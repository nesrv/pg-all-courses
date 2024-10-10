SET search_path = bookings;

CREATE OR REPLACE FUNCTION get_route_info( d_city text, a_city text )
  RETURNS TABLE( dep_city text, arr_city text,
                 flight_no char(6), flight_id integer, 
                 scheduled_departure timestamptz, model text, 
                 total_seats integer, booked_seats integer,
                 percentage numeric )
  AS
$$
  DECLARE
    tmp char(1);
    flight RECORD;     -- тип ЗАПИСЬ
    tot_seats integer;
    b_seats integer;
    flights_found bool DEFAULT FALSE;
  BEGIN
    IF NOT EXISTS ( SELECT 'x' FROM airports WHERE city = d_city )
    THEN
      RAISE EXCEPTION 'Города % нет в базе данных', d_city;
    END IF;

    SELECT 'x' INTO tmp FROM airports WHERE city = a_city;
    IF NOT FOUND THEN
      RAISE NOTICE 'Города % нет в базе данных', a_city;
      RETURN;
    END IF;

    IF ( d_city = a_city ) THEN
      RAISE NOTICE 'Города отправления и прибытия не должны совпадать';
      RETURN;
    END IF;

    -- Организуем цикл по результату запроса
    FOR flight IN SELECT * FROM flights_v f, aircrafts a
                  WHERE f.departure_city = d_city AND
                        f.arrival_city = a_city AND
                        f.aircraft_code = a.aircraft_code
    LOOP
      -- Для отладочных целей
      -- RAISE NOTICE '% % % % %', 
      --              flight.departure_city, flight.arrival_city, 
      --              flight.flight_no, flight.flight_id, flight.model;

      -- Число мест в салоне самолета, выполняющего рейс
      SELECT count(*) INTO tot_seats
      FROM seats
      WHERE aircraft_code = flight.aircraft_code;

      -- Число проданных билетов (перелетов)
      SELECT count(*) INTO b_seats
      FROM ticket_flights tf
      WHERE tf.flight_id = flight.flight_id;

      -- Формируется очередная строка результата
      RETURN QUERY SELECT flight.departure_city, flight.arrival_city, 
                          flight.flight_no, flight.flight_id, 
                          flight.scheduled_departure, flight.model,
                          tot_seats, b_seats,
                          round( ( b_seats::float / tot_seats::float )::
                                   numeric, 2 );
      flights_found = TRUE;  -- строки были найдены
    END LOOP;

    -- Не было найдено ни одной строки
    IF NOT flights_found THEN
      RAISE NOTICE 'Между городами % и % нет прямого рейса', 
                   d_city, a_city;    
    END IF;

  -- Обработка исключений
  EXCEPTION
    WHEN OTHERS THEN
      RAISE NOTICE '%', SQLERRM;
  END;
$$ LANGUAGE plpgsql;
