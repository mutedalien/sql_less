-- Task №1

USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE `logs` (
  `inserted_data` varchar(255) DEFAULT NULL COMMENT 'Вставленные данные'
) ENGINE=ARCHIVE DEFAULT CHARSET=utf8 COMMENT='Log таблица';

DELIMITER //

DROP TRIGGER IF EXISTS users_log//
CREATE TRIGGER users_log AFTER INSERT ON users
FOR EACH ROW
BEGIN
	set @inserted_data = CONCAT(NOW(),', TABLE_NAME - users, id - ', NEW.id, ', содержимое поля name - ', NEW.name );
  	INSERT INTO `logs` (`inserted_data`) VALUES (@inserted_data);
END//

DROP TRIGGER IF EXISTS catalogs_log//
CREATE TRIGGER catalogs_log AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	set @inserted_data = CONCAT(NOW(),', TABLE_NAME - catalogs, id - ', NEW.id, ', содержимое поля name - ', NEW.name );
  	INSERT INTO `logs` (`inserted_data`) VALUES (@inserted_data);
END//

DROP TRIGGER IF EXISTS products_log//
CREATE TRIGGER products_log AFTER INSERT ON products
FOR EACH ROW
BEGIN
	set @inserted_data = CONCAT(NOW(),', TABLE_NAME - products, id - ', NEW.id, ', содержимое поля name - ', NEW.name );
  	INSERT INTO `logs` (`inserted_data`) VALUES (@inserted_data);
END//

DELIMITER ;

INSERT INTO `users` (`id`, `name`) VALUES (NULL, 'New insert');
INSERT INTO `catalogs` (`id`, `name`) VALUES (NULL, 'New insert');
INSERT INTO `products` (`id`, `name`) VALUES (NULL, 'New insert');


-- Task №2

SET autocommit = 0;

DELIMITER //
CREATE PROCEDURE generate()
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < 1000000 DO
    INSERT INTO user VALUES (0,'test');
    SET i = i + 1;
    END WHILE;
END//

DELIMITER ;

CALL generate();

--	или так:

DROP PROCEDURE IF EXISTS one_million_rows
CREATE PROCEDURE one_million_rows()
BEGIN
	DECLARE n BIGINT;
	DECLARE i DATE;
	DECLARE k int;
	SET n = 1000000;
	SET i = NOW();
	SET k = 1;
	WHILE n > 0 DO
	 INSERT INTO users(name,birthday_at) VALUES (CONCAT('user_name',k), i);
	 SET i = i - INTERVAL;
	 SET n = n - 1;
	END WHILE;
END//
