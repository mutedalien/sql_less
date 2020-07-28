
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
