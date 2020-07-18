-- task №1

USE shop;
DROP TABLE IF EXISTS shop.users;
CREATE TABLE shop.users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Имя покупателя',
	birthday_at DATE COMMENT 'Дата рождения',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO shop.users (id, name, birthday_at) VALUES
	(DEFAULT, 'Геннадий', 	'1990-10-05'),
    (DEFAULT, 'Наталья', 	'1984-11-12'),
    (DEFAULT, 'Александр', 	'1985-05-20'),
    (DEFAULT, 'Сергей', 	'1988-02-14'),
    (DEFAULT, 'Иван', 		'1998-01-12'),
    (DEFAULT, 'Мария', 		'1992-08-29'),
    (DEFAULT, 'Святослав', 	'1980-08-08'),
    (DEFAULT, 'Василий', 	'1986-08-27'),
    (DEFAULT, 'Петр', 		'1986-05-27');

SELECT
	FLOOR(AVG(FLOOR((TO_DAYS(NOW()) - TO_DAYS(birthday_at)) / 365.25))) AS average_age
FROM
	users;


-- task №2

SELECT name, CONCAT(DATE_FORMAT(now(), '%Y'), DATE_FORMAT(birthday_at, '-%m-%d')) AS current_year_birthday FROM users;
SELECT DATE_FORMAT(CONCAT(YEAR(NOW()), DATE_FORMAT(birthday_at, '-%m-%d')), '%W') AS week_day_to_this_year FROM users;

SELECT
	DATE_FORMAT(CONCAT(YEAR(NOW()), DATE_FORMAT(birthday_at, '-%m-%d')), '%W') AS week_day,
	COUNT(*) AS number_of_birthdays
	FROM users
	GROUP BY week_day
	ORDER BY FIELD(week_day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- task №3

USE shop;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (
id serial primary key,
value INT NOT NULL
) COMMENT = 'Игра с числами в столбце';

INSERT INTO numbers (value)
	VALUES
    (2), (4), (8), (16), (32);

SELECT CEILING(EXP(SUM(LN(value)))) FROM numbers;
