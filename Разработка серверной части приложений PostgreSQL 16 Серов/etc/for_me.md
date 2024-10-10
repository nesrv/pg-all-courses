для просмотра содержимого файла /etc/passwd, вы можете использовать следующую команду:

```sh
cat /etc/passwd
```

# Таблица умножения с помощью 


```sql
CREATE FUNCTION mul_table(max_line integer)
RETURNS TABLE(x integer, y integer, z integer)
IMMUTABLE LANGUAGE sql
BEGIN ATOMIC
    SELECT x, y, x * y as z
    FROM generate_series(1, max_line) AS x, 
         generate_series(1, max_line ) AS y;
END;

select * from mul_table(3);

```
# Регулярка

[https://postgrespro.ru/docs/postgresql/14/functions-matching](https://postgrespro.ru/docs/postgresql/14/functions-matching)

[https://habr.com/ru/articles/747934/](https://habr.com/ru/articles/747934/)