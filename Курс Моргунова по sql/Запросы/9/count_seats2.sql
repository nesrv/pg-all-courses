SET search_path = bookings;

CREATE OR REPLACE FUNCTION count_seats( a_code char(3), OUT a_model text,
        OUT seats_business bigint, OUT seats_comfort bigint, 
        OUT seats_economy bigint )
 AS
$$
SELECT a.model,
( SELECT count( * )
  FROM seats s
  WHERE s.aircraft_code = a_code
        AND s.fare_conditions = 'Business'
) AS business,
( SELECT count( * )
  FROM seats s
  WHERE s.aircraft_code = a_code
        AND s.fare_conditions = 'Comfort'
) AS comfort,
( SELECT count( * )
  FROM seats s
  WHERE s.aircraft_code = a_code
        AND s.fare_conditions = 'Economy'
) AS economy
FROM aircrafts a
WHERE a.aircraft_code = a_code
ORDER BY 1;

$$ LANGUAGE sql;
