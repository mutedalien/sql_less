-- Task №1

Drop table if exists sample.users;
CREATE TABLE sample.users (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Покупатели';

START TRANSACTION ;
INSERT INTO sample.users SELECT * FROM shop.users WHERE shop.users.id = 1;
DELETE FROM shop.users WHERE shop.users.id = 1;
COMMIT;

SELECT * FROM sample.users WHERE sample.users.id = 1;


-- Task №2

PREPARE product_name FROM 'SELECT p.id, p.name, c.name FROM products AS p JOIN catalogs AS c ON c.id = p.`catalog_id` having id = ?';
SET @id = 4 ;
EXECUTE product_name USING @id;


-- Task №3

use sample; -- выбираем базу данных
-- формируем тестовую таблицу и наполняем ее данными.
drop table if exists dates;
create table dates (
	id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	created_at datetime DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE KEY id (id)
	);

truncate table dates;
insert into dates values
	(default, '2018-08-01'),
	(default, '2018-08-04'),
	(default, '2018-08-16'),
	(default, '2018-08-17');

-- формируем таблицу с номерами дней 
drop table if exists day_of_month;
CREATE TEMPORARY TABLE day_of_month (
  day INT
);
INSERT INTO day_of_month
VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
       (11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
       (21), (22), (23), (24), (25), (26), (27), (28), (29), (30);


-- создаем переменную, для установления первого числа месяца из выборки (начало месяца).
select @days := (select concat_ws('-', extract(year from (select dates.created_at from dates where dates.id=1)),
		extract(MONTH from (select dates.created_at from dates where dates.id=1)),
		'01'));
	
select  DATE(@days + INTERVAL day_of_month.day day) AS days_month, 
		case when date(dates.created_at) is null then 0 else 1 end as my_dates  -- устанавливаем 0, если нашей даты нет, 1 если наша дата есть.
		from day_of_month left join dates -- из объединения
		on DATE(@days + INTERVAL day_of_month.day day) = dates.created_at -- где даты равны
		order by days_month; -- сортировка по датам всего месяца


-- Task №4

use sample;
-- создаем таблицу с датами
drop table if exists dates2;
create table dates2 (
	id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	created_at datetime DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE KEY id (id)
	);
-- заполняем таблицу данными
truncate table dates2;
insert into dates2 values
	(default, '2019-08-01'),
	(default, '2019-08-02'),
	(default, '2019-08-03'),
	(default, '2019-08-04'),
	(default, '2019-08-05'),
	(default, '2019-08-06'),
	(default, '2019-08-07'),
	(default, '2019-08-08'),
	(default, '2019-08-09'),
	(default, '2019-08-10'),
	(default, '2019-08-11'),
	(default, '2019-08-12');

-- запрос, выбирающий пять ID самых свежих дат (включая время!)
select id from dates2 order by created_at desc limit 5;
-- запрос, вдаляющий всё, кроме пяти самых свежих дат.
delete from dates2 
where id not in (
	select id from (
		select id from dates2 order by created_at desc limit 5
					) qwerty);
				
select * from dates2 order by created_at desc;
