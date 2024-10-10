

CREATE INDEX posts_content_idx ON posts(content)
WITH (deduplicate_items = off);

SELECT pg_size_pretty(pg_total_relation_size('posts_content_idx'));

DROP INDEX posts_content_idx;
CREATE INDEX posts_content_idx ON posts(content);
SELECT pg_size_pretty(pg_total_relation_size('posts_content_idx'));


CREATE INDEX ON posts (post_id);
CREATE INDEX ON posts (content);

EXPLAIN SELECT * FROM posts WHERE post_id > 4;

EXPLAIN SELECT * FROM t13 WHERE id > 99000 AND j IS NOT NULL 
ORDER BY (CASE 
		  WHEN id<10000 THEN 2 
		  WHEN id >= 10000 AND id <= 20000 THEN 4
		  WHEN id > 20000 AND id < 60000 THEN 1
		  WHEn id >= 60000 THEN 3
		 ) DESC;




DO $$
BEGIN
	FOR i IN 1..100
	LOOP
		EXECUTE 'SELECT avg(amount) FROM ticket_flights';
	END LOOP;
END;
$$;

DO $$
BEGIN
	FOR i IN 1..100
	LOOP
		PERFORM avg(amount) FROM ticket_flights;
	END LOOP;
END;
$$;

DO $$
BEGIN
	FOR i IN 1..10000
	LOOP
		EXECUTE 'SELECT * FROM ticket_flights WHERE ticket_id=10';
	END LOOP;
END;
$$;

DO $$
BEGIN
	FOR i IN 1..10000
	LOOP
		PERFORM * FROM ticket_flights WHERE ticket_id=10;
	END LOOP;
END;
$$;

EXPLAIN SELECT avg(amount) FROM ticket_flights;

EXPLAIN 
WITH tv AS (
	SELECT * FROM t13
)
SELECT avg(id) FROM tv;

EXPLAIN SELECT * FROM t13;





