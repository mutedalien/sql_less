-- Task №1

USE shop;
DROP TABLE IF EXISTS shop.users;
CREATE TABLE shop.users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Имя покупателя',
	birthday_at DATE COMMENT 'Дата рождения',
	created_at VARCHAR(255),
	updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO shop.users (id, name, birthday_at) VALUES
	(1, 'Геннадий', '1990-10-05'),
    (2, 'Наталья', '1984-11-12'),
    (3, 'Александр', '1985-05-20'),
    (4, 'Сергей', '1988-02-14'),
    (5, 'Иван', '1998-01-12'),
    (6, 'Мария', '1992-08-29'),
    (7, 'Святослав', '1980-08-08');

UPDATE users SET created_at = NOW(), updated_at = NOW() WHERE created_at IS NULL || updated_at IS NULL;
SELECT * FROM users;



-- Task №2

USE shop;
TRUNCATE users;

INSERT INTO shop.users (id, n ame, birthday_at, created_at, updated_at) VALUES
	(DEFAULT, 'Геннадий', '1990-10-05', '17.07.2020 12:10:00','17.07.2020 12:25:00'),
    (DEFAULT, 'Наталья', '1984-11-12', '17.07.2020 12:10:00','17.07.2020 12:25:00'),
    (DEFAULT, 'Александр', '1985-05-20', '17.07.2020 12:10:00','17.07.2020 12:25:00'),
    (DEFAULT, 'Сергей', '1988-02-14', '17.07.2020 12:10:00','17.07.2020 12:25:00'),
    (DEFAULT, 'Иван', '1998-01-12', '17.07.2020 12:10:00','17.07.2020 12:25:00')
    (DEFAULT, 'Мария', '1992-08-29', '17.07.2020 12:10:00','17.07.2020 12:25:00'),
    (DEFAULT, 'Святослав', '1980-08-08', '17.07.2020 12:10:00','17.07.2020 12:25:00');
SELECT * FROM users; -- проверяем

UPDATE users SET
	created_at = DATE_FORMAT(STR_TO_DATE(users.`created_at`, '%d.%m.%Y %T'), '%Y-%m-%d %T'),
	updated_at = DATE_FORMAT(STR_TO_DATE(users.`updated_at`, '%d.%m.%Y %T'), '%Y-%m-%d %T');

ALTER TABLE users MODIFY users.`created_at` DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users MODIFY users.`updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
SELECT * FROM users; -- проверяем




-- Task №3

USE shop;
DROP TABLE IF EXISTS storehouse_products;
CREATE TABLE storehouse_products (
	id SERIAL PRIMARY KEY,
	storehouse_id INT UNSIGNED,
	product_id INT UNSIGNED,
	value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Запасы на складе';

INSERT INTO `storehouse_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES
	(DEFAULT, 1, 1, 0, '2020-07-17 17:50:28', '2020-07-17 17:50:28'),
	(DEFAULT, 1, 2, 2500, '2020-07-17 17:50:28', '2020-07-17 17:50:28'),
	(DEFAULT, 1, 3, 0, '2020-07-17 17:50:28', '2020-07-17 17:50:28'),
	(DEFAULT, 1, 4, 30, '2020-07-17 17:50:28', '2020-07-17 17:50:28'),
	(DEFAULT, 1, 5, 500, '2020-07-17 17:50:28', '2020-07-17 17:50:28'),
	(DEFAULT, 1, 6, 1, '2020-07-17 17:50:28', '2020-07-17 17:50:28');

SELECT * FROM storehouse_products ORDER BY IF(value <> 0, 0, 1), value;


-- Task №4

USE shop;
DROP TABLE IF EXISTS shop.users;
CREATE TABLE shop.users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Имя покупателя',
	birthday_at DATE COMMENT 'Дата рождения',
	created_at VARCHAR(255),
	updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO shop.users (id, name, birthday_at) VALUES
	(DEFAULT, 'Геннадий', '1990-10-05'),
    (DEFAULT, 'Наталья', '1984-11-12'),
    (DEFAULT, 'Александр', '1985-05-20'),
    (DEFAULT, 'Сергей', '1988-02-14'),
    (DEFAULT, 'Иван', '1998-01-12'),
    (DEFAULT, 'Мария', '1992-08-29'),
    (DEFAULT, 'Святослав', '1980-08-08'),
    (DEFAULT, 'Василий', '1986-08-27'),
    (DEFAULT, 'Петр', '1986-05-27');

SELECT name, birthday_at, CASE
		WHEN DATE_FORMAT(birthday_at, '%c') = 1 THEN 'January'
		WHEN DATE_FORMAT(birthday_at, '%c') = 2 THEN 'February'
		WHEN DATE_FORMAT(birthday_at, '%c') = 3 THEN 'March'
		WHEN DATE_FORMAT(birthday_at, '%c') = 4 THEN 'April'
		WHEN DATE_FORMAT(birthday_at, '%c') = 5 THEN 'May'
		WHEN DATE_FORMAT(birthday_at, '%c') = 6 THEN 'June'
		WHEN DATE_FORMAT(birthday_at, '%c') = 7 THEN 'July'
		WHEN DATE_FORMAT(birthday_at, '%c') = 8 THEN 'August'
		WHEN DATE_FORMAT(birthday_at, '%c') = 9 THEN 'September'
		WHEN DATE_FORMAT(birthday_at, '%c') = 10 THEN 'October'
		WHEN DATE_FORMAT(birthday_at, '%c') = 11 THEN 'November'
		WHEN DATE_FORMAT(birthday_at, '%c') = 12 THEN 'December'
    	ELSE 'unknown'
	END AS month
FROM users HAVING month IN ('May', 'August');

-- ИЛИ
SELECT name, DATE_FORMAT(birthday_at, '%M') AS month FROM users;
SELECT name FROM users WHERE DATE_FORMAT(birthday_at, '%M') IN ('May', 'August');


-- Task №5

SELECT * FROM catalogs WHERE id IN (5, 1, 2);
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5,1,2);
