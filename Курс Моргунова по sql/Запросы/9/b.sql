SET search_path = bookings;

CREATE OR REPLACE FUNCTION count_seats1( VARIADIC a_codes char[] )
  RETURNS TABLE( a_code char  )
  AS
$$
  select unnest( a_codes )
--WHERE a.aircraft_code IN ( '773', '320', '319' )
ORDER BY 1;

$$ LANGUAGE sql;
