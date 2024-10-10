SET search_path = bookings;

CREATE OR REPLACE FUNCTION update_bookings()
RETURNS trigger  AS
$$
DECLARE
  delta bookings.total_amount%TYPE;
  tick_no ticket_flights.ticket_no%TYPE;
BEGIN
  IF TG_OP = 'INSERT' THEN
    delta = NEW.amount;
    tick_no = NEW.ticket_no;

  ELSIF ( TG_OP = 'UPDATE' ) THEN
    delta = NEW.amount - OLD.amount;
    tick_no = OLD.ticket_no;

  ELSIF ( TG_OP = 'DELETE' ) THEN
    delta = OLD.amount * ( -1 );
    tick_no = OLD.ticket_no;
  END IF;

  UPDATE bookings b SET total_amount  = total_amount + delta
  FROM tickets t, ticket_flights tf
  WHERE b.book_ref = t.book_ref AND
        t.ticket_no = tick_no;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_bookings ON ticket_flights;

CREATE TRIGGER update_bookings 
AFTER INSERT OR UPDATE OR DELETE ON ticket_flights
FOR EACH ROW EXECUTE PROCEDURE update_bookings();
