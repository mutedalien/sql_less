-- TASK №1

/* Первый пользователь */
CREATE USER 'shop_read'@'localhost';
GRANT SELECT, SHOW VIEW ON shop.* TO 'shop_read'@'localhost' IDENTIFIED BY '';

/* Второй пользователь */
CREATE USER 'shop'@'localhost';
GRANT ALL ON shop.* TO 'shop'@'localhost' IDENTIFIED BY '';

-- TASK №2

USE sample;

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  password VARCHAR(255)
);

CREATE OR REPLACE VIEW username(id, name) AS
  SELECT id, name FROM accounts;

DROP USER IF EXISTS user_read@localhost;
CREATE USER user_read@localhost IDENTIFIED BY '0';
GRANT SELECT ON sample.username TO user_read@localhost;

SHOW GRANTS FOR user_read@localhost;