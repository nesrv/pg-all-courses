[https://www.postgresql.org/download/linux/ubuntu/](https://www.postgresql.org/download/linux/ubuntu/)

```sh
sudo apt install unzip


student:~/Downloads$ unzip demo_small.zip 

psql -f demo_small.sql -U postgres

```


sudo apt-get install -y postgresql-13

psql --version показывает сейчас psql (PostgreSQL) 15.3 (Ubuntu 15.3-1.pgdg20.04+1)

# Запуск кластера 15 версии
pg_ctlcluster start 15 main

Для того, чтобы они запускались одновременно, то можно использовать разные порты - чтобы запускались на разных портах. Например, 15 версия на 5432 порту, а 13 - на 5433.
Это сделать можно либо через postgresql.conf - конфигфайл, ищи port. Изначально он такой:
#port = 5342                      # (change requires restart)


раскоментируй и выстави свое значение. 
Подсказка - он скорее всего в директории /var/lib/postgresql//, например, /var/lib/postgresql/13/main/postgresql.conf

```sh
nano /etc/postgresql/17/main/postgresql.conf

```

Для подключения просто передай psql нужный порт:
psql -p 5432 # 15 версия
psql -p 5433 # 13 версия