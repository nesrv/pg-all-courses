SET search_path = bookings;

DROP FUNCTION count_seats( char(3), text );
CREATE FUNCTION count_seats( a_code char(3), fare_cond text )
RETURNS bigint  AS
$$
SELECT count( * ) FROM seats s
WHERE s.aircraft_code = a_code AND
      s.fare_conditions = fare_cond;
$$ LANGUAGE sql;
