
chile8@DESKTOP-MH7KMT0 ~
$ ssh a81a0fe5-199e-4307-8d1b-d3c9ea434b44@serverhub.praktikum-services.ru -p 4554
** WARNING: connection is not using a post-quantum key exchange algorithm.
** This session may be vulnerable to "store now, decrypt later" attacks.
** The server may need to be upgraded. See https://openssh.com/pq.html
morty@server-a81a0fe5-199e-4307-8d1b-d3c9ea434b44:~$ psql -U morty -d scooter_rent
Password for user morty:
psql (11.18 (Debian 11.18-0+deb10u1))
Type "help" for help.

scooter_rent=# \dt
           List of relations
 Schema |     Name      | Type  | Owner
--------+---------------+-------+-------
 public | Couriers      | table | root
 public | Orders        | table | root
 public | SequelizeMeta | table | root
(3 rows)

scooter_rent=# \d "Couriers"
scooter_rent=# \d "Orders"
scooter_rent=# SELECT c.login, COUNT(o.id) AS orders_in_delivery
scooter_rent-# FROM "Couriers" c
scooter_rent-# JOIN "Orders" o ON c.id = o."courierId"
scooter_rent-# WHERE o."inDelivery" = true
scooter_rent-# GROUP BY c.login
scooter_rent-# ORDER BY orders_in_delivery DESC;
 login | orders_in_delivery
-------+--------------------
 ася   |                  2
 маша  |                  2
 саша  |                  2
(3 rows)

scooter_rent=# SELECT
scooter_rent-#     track,
scooter_rent-#     CASE
scooter_rent-#         WHEN finished = true THEN 2
scooter_rent-#         WHEN cancelled = true THEN -1
scooter_rent-#         WHEN "inDelivery" = true THEN 1
scooter_rent-#         ELSE 0
scooter_rent-#     END AS status
scooter_rent-# FROM "Orders";
 track  | status
--------+--------
 630355 |      0
 314068 |      0
 242513 |      1
 319024 |      1
 319024 |      1
 698562 |      1
 698562 |      1
 242513 |      2
  98981 |     -1
(9 rows)

scooter_rent=# \q
morty@server-a81a0fe5-199e-4307-8d1b-d3c9ea434b44:~$ cat > queries.sql <<'EOF'
> -- Задание 1: Логины курьеров с количеством заказов в доставке
> SELECT c.login, COUNT(o.id) AS orders_in_delivery
> FROM "Couriers" c
> JOIN "Orders" o ON c.id = o."courierId"
> WHERE o."inDelivery" = true
> GROUP BY c.login
> ORDER BY orders_in_delivery DESC;
>
> -- Задание 2: Трекеры заказов и их статусы
> SELECT
>     track,
>     CASE
>         WHEN finished = true THEN 2
>         WHEN cancelled = true THEN -1
>         WHEN "inDelivery" = true THEN 1
>         ELSE 0
>     END AS status
> FROM "Orders";
> EOF
morty@server-a81a0fe5-199e-4307-8d1b-d3c9ea434b44:~$ cat queries.sql
-- Задание 1: Логины курьеров с количеством заказов в доставке
SELECT c.login, COUNT(o.id) AS orders_in_delivery
FROM "Couriers" c
JOIN "Orders" o ON c.id = o."courierId"
WHERE o."inDelivery" = true
GROUP BY c.login
ORDER BY orders_in_delivery DESC;

-- Задание 2: Трекеры заказов и их статусы
SELECT
    track,
    CASE
        WHEN finished = true THEN 2
        WHEN cancelled = true THEN -1
        WHEN "inDelivery" = true THEN 1
        ELSE 0
    END AS status
FROM "Orders";
morty@server-a81a0fe5-199e-4307-8d1b-d3c9ea434b44:~$
