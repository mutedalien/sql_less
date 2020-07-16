
-- Task №1
DROP TABLE IF EXISTS shop.catalogs;
CREATE TABLE shop.catalogs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название раздела',
	UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';
/*
NULL это пустая ячейка. Такое же значение NULL не вызовет ошибки при повторе
*/
INSERT INTO shop.catalogs VALUES 
(DEFAULT, 'Мат платы'),
(DEFAULT, 'Видеокарты'),
(DEFAULT, NULL),
(DEFAULT, NULL),
(DEFAULT, NULL),
(DEFAULT, NULL),
(DEFAULT, 'Процессоры');
/* 
Во избежание ошибки нужно удалить уникальность поля 'name'
*/
UPDATE shop.catalogs SET shop.catalogs.name = 'empty' WHERE shop.catalogs.name IS NULL;

SELECT * FROM shop.catalogs;

----------------------------------------------------------------------------------------------------------------------
-- Task №2
DROP TABLE IF EXISTS media_files_storage;
CREATE TABLE media_files_storage (
	id SERIAL PRIMARY KEY,
	file_name VARCHAR(255) COMMENT 'Название медиа файла',
	file_path VARCHAR(255) COMMENT 'Путь к файлу',
	file_description VARCHAR(255) COMMENT 'Описание Файла',
	file__key_words VARCHAR(255) COMMENT 'Ключевые слова',
	file_owner VARCHAR(255) COMMENT 'Принадлежность пользователю',
	UNIQUE unique_file_name(file_name)
) COMMENT = 'Бада данных медиафайлов';

INSERT INTO media_files_storage VALUES 
(DEFAULT, 'The_Terminator_1984.mov', '/img/media/The_Terminator_1984.mov', 'Фильм Терминатор 1984 года выпуска', 'Терминатор, terminator', 'КиноПоиск'),
(DEFAULT, 'The_Terminator_1984.png', '/img/media/The_Terminator_1984.png', 'Постер фильма Терминатор 1984 года выпуска', 'Терминатор, terminator', 'КиноПоиск'),
(DEFAULT, 'The_Terminator_2_1991.mov', '/img/media/The_Terminator_2_1991.mov', 'Фильм Терминатор-2 1991 года выпуска', 'Терминатор-2, terminator', 'КиноПоиск'),
(DEFAULT, 'The_Terminator_2_1991.png', '/img/media/The_Terminator_2_1991.png', 'Постер фильма Терминатор-2 1991 года выпуска', 'Терминатор-2, terminator', 'КиноПоиск');

SELECT * FROM media_files_storage;

----------------------------------------------------------------------------------------------------------------------
-- Task №3
DROP TABLE IF EXISTS sample.cat;
CREATE TABLE sample.cat (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название раздела',
	UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO sample.cat VALUES 
(DEFAULT, 'product 1'),
(DEFAULT, 'product 2'),
(DEFAULT, 'product 3'),
(DEFAULT, 'product 4'),
(DEFAULT, 'product 5'),
(DEFAULT, 'product 6'),
(DEFAULT, 'product 7'),
(DEFAULT, 'product 8'),
(DEFAULT, 'product 9'),
(DEFAULT, 'product 10'),
(DEFAULT, 'product 11'),
(DEFAULT, 'product 12');

SELECT * FROM sample.cat;

INSERT INTO sample.cat SELECT * FROM shop.catalogs on DUPLICATE KEY UPDATE sample.cat.name = shop.catalogs.name;
SELECT * FROM sample.cat;