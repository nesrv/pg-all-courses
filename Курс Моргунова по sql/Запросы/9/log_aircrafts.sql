SET search_path = bookings;

CREATE OR REPLACE FUNCTION log_aircrafts()
RETURNS trigger  AS
$$
BEGIN
  INSERT INTO aircrafts_log ( aircraft_code, model, range, when_add,
                              operation )
  VALUES ( NEW.aircraft_code, NEW.model, NEW.range,
           CURRENT_TIMESTAMP, 'INSERT' );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS aircrafts_log ON aircrafts_tmp;

CREATE TRIGGER aircrafts_log AFTER INSERT ON aircrafts_tmp
FOR EACH ROW EXECUTE PROCEDURE log_aircrafts();
