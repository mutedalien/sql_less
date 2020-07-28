
Task №1

/*
127.0.0.1:6379> sadd 193.01.01 4
(integer) 1
127.0.0.1:6379> sadd 193.02.01 56
(integer) 1
127.0.0.1:6379> sadd 193.03.01 198
(integer) 1
127.0.0.1:6379> sadd 193.04.01 98
(integer) 1
127.0.0.1:6379> sdiff 193.01.01
1) "4"
127.0.0.1:6379> sdiff 193.04.01
1) "98"
127.0.0.1:6379>
*/


Task №2

/*
127.0.0.1:6379> hmset users vasiliy vasiliy@mail.ru katerina katerina@mail.ru
OK
127.0.0.1:6379> hget users vasiliy
"vasiliy@mail.ru"
127.0.0.1:6379> hmset emails vasiliy@mail.ru vasiliy katerina@mail.ru katerina elena@mail.ru elena john@mail.ru john
OK
127.0.0.1:6379> hget emails katerina@mail.ru
"katerina"
*/


Task №3

/*
db.shop.insert({id: '1', 'name': 'Принтеры'},
			   {id: '2', 'name': 'Мониторы'},
			   {id: '3', 'name': 'Процессоры'})

db.shop.insert({id: '1', 'name': 'Lexmark', 'description': 'Цветной принтер', 'price': '1000', 'catalog_id': '1', 'created_at': '2019-08-07 18:22:12', 'updated_at': '2019-08-07 18:22:12'},
			   {id: '2', 'name': 'Sharp', 'description': 'Мощный процессор для игр и не только!', 'price': '2300', 'catalog_id': '3', 'created_at': '2019-08-07 18:22:12', 'updated_at': '2019-08-07 18:22:12'},
			   {id: '3', 'name': 'Apple', 'description': 'Цветной монитор', 'price': '200', 'catalog_id': '2', 'created_at': '2019-08-07 18:22:12', 'updated_at': '2019-08-07 18:22:12'})
*/