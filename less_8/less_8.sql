-- Task №1

DELIMITER //
USE shop //

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
  	set @night = 'Доброй ночи';
  	set @morning = 'Доброе утро';
  	set @afternoon = 'Добрый день';
  	set @evening = 'Добрый вечер';
  	set @hrs = (SELECT DATE_FORMAT(NOW(), "%k"));
	IF(@hrs >=12 AND @hrs <18) THEN
		RETURN @afternoon;
	ELSEIF (@hrs >=18 AND @hrs <0) THEN
		RETURN @evening;
	ELSEIF (@hrs >=0 AND @hrs <6) THEN
		RETURN @night;
	ELSEIF (@hrs >=6 AND @hrs <12) THEN
		RETURN @morning;
  	END IF;
END//

SELECT  hello()//

-- Task №2

DELIMITER //
USE shop //
DROP TRIGGER IF EXISTS check_catalog_name_desc_insert//
CREATE TRIGGER check_catalog_name_desc_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  	IF (NEW.name = NULL AND NEW.description = NULL) THEN
  		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = "Попытка вставки NULL по NAME and DESCRIPTION";
  	END IF;
END//


INSERT INTO products VALUES (DEFAULT, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT)//

-- делаем таблицу
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название',
  `description` text COMMENT 'Описание',
  `price` decimal(11,2) DEFAULT NULL COMMENT 'Цена',
  `catalog_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `index_of_catalog_id` (`catalog_id`),
  CONSTRAINT `fk_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `catalogs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='Товарные позиции';

-- Task №3

DELIMITER //
USE sample//

DROP FUNCTION IF EXISTS fibonacci//

CREATE FUNCTION fibonacci(num int)
RETURNS int deterministic
BEGIN
  declare x int default 0;
  declare fib int default 0;
  while x <= num do
    SET fib = fib + x;
    SET x = x+1;
  END while;
RETURN fib;

END//

select fibonacci(5), fibonacci(10)//
