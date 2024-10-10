SET search_path = bookings;

BEGIN;

INSERT INTO bookings ( book_ref, book_date, total_amount )
VALUES ( 'ABC123', bookings.now(), 0 );

INSERT INTO tickets ( ticket_no, book_ref, passenger_id,
                      passenger_name)
VALUES ( '9991234567890', 'ABC123', '1234 123456',
         'IVAN PETROV' );

INSERT INTO ticket_flights ( ticket_no, flight_id,
                             fare_conditions, amount )
VALUES ( '9991234567890', 5572, 'Business', 12500 ),
       ( '9991234567890', 13881, 'Economy', 8500 );

COMMIT;

SELECT * from bookings WHERE book_ref = 'ABC123';
