set search_path = bookings;

SELECT a.model,
( SELECT count( * )
  FROM seats s
  WHERE s.aircraft_code = a.aircraft_code
        AND s.fare_conditions = 'Business'
) AS seats_business,
( SELECT count( * )
  FROM seats s
  WHERE s.aircraft_code = a.aircraft_code
        AND s.fare_conditions = 'Comfort'
) AS seats_comfort,
( SELECT count( * )
  FROM seats s
  WHERE s.aircraft_code = a.aircraft_code
        AND s.fare_conditions = 'Economy'
) AS seats_economy
FROM aircrafts a
WHERE a.aircraft_code IN ( select unnest( ARRAY['773', '320', '319'] ) )
--WHERE a.aircraft_code IN ( '773', '320', '319' )
ORDER BY 1;
