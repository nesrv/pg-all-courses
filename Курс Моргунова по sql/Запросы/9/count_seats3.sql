SET search_path = bookings;

CREATE OR REPLACE FUNCTION count_seats_var( VARIADIC a_codes char[] )
  RETURNS TABLE( model text, business bigint, comfort bigint, 
                 economy bigint  )
  AS
$$
SELECT a.model,
( SELECT count( * )
  FROM seats s
  WHERE s.aircraft_code = a.aircraft_code
        AND s.fare_conditions = 'Business'
) AS business,
( SELECT count( * )
  FROM seats s
  WHERE s.aircraft_code = a.aircraft_code
        AND s.fare_conditions = 'Comfort'
) AS comfort,
( SELECT count( * )
  FROM seats s
  WHERE s.aircraft_code = a.aircraft_code
        AND s.fare_conditions = 'Economy'
) AS economy
FROM aircrafts a
WHERE a.aircraft_code IN ( select unnest( a_codes ) )
ORDER BY 1;

$$ LANGUAGE sql;
