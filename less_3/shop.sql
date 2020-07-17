DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название раздела'
) COMMENT = 'Разделы интернет-магазина';

-- INSERT INTO catalogs VALUES (NULL, 'Процессоры');
-- INSERT INTO catalogs (name, id) VALUES ('Мат.платы', NULL);
-- INSERT INTO catalogs VALUES (DEFAULT, 'Видеокарты');

INSERT INTO catalogs VALUES
	(DEFAULT, 'Процессоры'),
	(DEFAULT, 'Мат.платы'),
	(DEFAULT, 'Видеокарты'),
	(DEFAULT, 'Жесткие диски'),
	(DEFAULT, 'Оперативная память');

-- DELETE FROM catalogs WHERE id > 1 LIMIT 1;
-- SELECT id, name FROM catalogs;

UPDATE catalogs SET name = 'Процессоры (intel)' WHERE name = 'Процессоры';

SELECT * FROM catalogs;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Имя покупателя',
	birthday_at DATE COMMENT 'Дата рождения',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
	('Геннадий', '1990-10-05'),
	('Наталья', '1984-11-12'),
	('Александр', '1985-05-20'),
	('Сергей', '1988-02-14'),
	('Иван', '1998-01-12'),
	('Мария', '1992-08-29'),
	('Святослав', '1980-08-08');

SELECT * FROM users;

DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название',
	description TEXT COMMENT 'Описание', 
	prise DECIMAL (11,2) COMMENT 'Цена',
	catalog_id INT UNSIGNED,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Товарные позиции';

INSERT INTO products
	(name, description, prise, catalog_id)
VALUES
	('Intel Core i3-8100', 'Процессор для настольных перс компьютеров на платформе  Intel', 7890.00, 1),
	('Intel Core i5-7400', 'Процессор для настольных перс компьютеров на платформе  Intel', 12700.00, 1),
	('AMD FX-8320E', 'Процессор для настольных перс компьютеров на платформе  AMD', 4780.00, 1),
	('AMD FX-8320', 'Процессор для настольных перс компьютеров на платформе  AMD', 7120.00, 1),
	('ASUS ROG MAXIMUS X HERO', 'Материнская плата, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
	('Gigabyte H310M S2H', 'Материнская плата, H310, Socket 1151, DDR4, mATX', 4790.00, 2),
	('MSI B250M GAMING PRO', 'Материнская плата, B250, Socket 1151-V2, DDR4, mATX', 5060.00, 2);

SELECT * FROM products;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	user_id INT UNSIGNED,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
	id SERIAL PRIMARY KEY,
	order_id INT UNSIGNED,
	product_id INT UNSIGNED,
	total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных позиций',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
	id SERIAL PRIMARY KEY,
	user_id INT UNSIGNED,
	product_id INT UNSIGNED,
	discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0,0 до 1,0',
	started_at DATETIME,
	finished_at DATETIME,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	KEY index_of_user_id(user_id),
	KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	id SERIAL PRIMARY KEY,
	storehouse_id INT UNSIGNED,
	product_id INT UNSIGNED,
	value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';