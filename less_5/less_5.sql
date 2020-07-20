-- Task №1

DROP TABLE IF EXISTS orders;
CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `index_of_user_id` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE `orders_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20)  unsigned DEFAULT NULL,
  `product_id` bigint(20)  unsigned DEFAULT NULL,
  `total` int(10) unsigned DEFAULT '1' COMMENT 'Кол-во заказанных товарных позиций',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  CONSTRAINT `fk_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Состав заказать';

INSERT INTO `orders` (user_id) VALUES (1), (3), (5);
INSERT INTO `orders_products` (order_id, product_id, total) VALUES ( 1, 4, 1) , ( 2, 5, 5), ( 3, 6, 2), ( 4, 7, 7);

SELECT name FROM users JOIN orders on users.id = orders.`user_id`;


-- Task №2

SELECT p.id, p.name, c.name FROM products AS p JOIN catalogs AS c ON c.id = p.`catalog_id`;


-- Task №3

DROP DATABASE IF EXISTS flights_db;
CREATE DATABASE flights_db CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE flights_db;
SELECT DATABASE() AS 'DATA BASE';

CREATE TABLE cities (
  label CHAR(3) PRIMARY KEY COMMENT 'Метка города (на английском)',
  name CHAR(64) NOT NULL COMMENT 'Название города на русском'
) COMMENT 'Города для полётов';

INSERT INTO cities VALUES
  ('msk', 'Москва'),
  ('spb', 'Санкт-Петербург'),
  ('nyc', 'Нью-Йорк'),
  ('prs', 'Париж'),
  ('pkn', 'Пекин');

CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` CHAR(3) NOT NULL COMMENT 'Метка города вылета',
  `to` CHAR(3) NOT NULL COMMENT 'Метка города прилёта',
  CONSTRAINT fk_flights_to_from_label FOREIGN KEY (`from`) REFERENCES cities(label),
  CONSTRAINT fk_flights_to_to_label FOREIGN KEY (`to`) REFERENCES cities(label)
) COMMENT 'Зарегистрированные полёты';

INSERT INTO flights VALUES
  (NULL, 'msk', 'spb'),
  (NULL, 'spb', 'msk'),
  (NULL, 'msk', 'nyc'),
  (NULL, 'nyc', 'msk'),
  (NULL, 'msk', 'prs'),
  (NULL, 'prs', 'msk'),
  (NULL, 'msk', 'pkn'),
  (NULL, 'pkn', 'msk');

-- ЗАПРОС
SELECT
  f.id AS 'Рейс №',
  cf.name AS 'Из города',
  ct.name AS 'В город'
FROM flights f
  INNER JOIN cities cf ON f.`from` = cf.label
  INNER JOIN cities ct ON f.`to` = ct.label
ORDER BY f.id;