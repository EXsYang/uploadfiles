#演示整形范围
#使用tinyint 来演示范围 有符号-128 ~ 127 如果没有符号 0 ~ 255
# 说明：表的字符集，校验规则，存储引擎，使用默认
#1. 如果没有指定 unsigned ,则TINYINT就是有符号
#2. 如果指定 unsigned ,则TINYINT 就是无符号 0 ~ 255

CREATE TABLE t4 (
	id TINYINT );
	
DROP TABLE t5;

CREATE TABLE t5 (
	id TINYINT UNSIGNED );

INSERT INTO t4 VALUES(128);

INSERT INTO t5 VALUES(0);

SELECT * FROM t5;