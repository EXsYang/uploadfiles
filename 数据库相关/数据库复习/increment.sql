-- 演示自增长的使用
-- 创建表
CREATE TABLE t24(
	id INT PRIMARY KEY AUTO_INCREMENT, -- 默认从1开始
	email VARCHAR(32) NOT NULL DEFAULT '',
	`name` VARCHAR(32) NOT NULL DEFAULT '');

DESC t24;

-- 测试自增长的使用
INSERT INTO t24
	VALUES(NULL,'tom@sohu.com','tom'); 
INSERT INTO t24
	(email,`name`)
	VALUES('jack@sohu.com','jack');
INSERT INTO t24
	(id,email,`name`)
	VALUES(NULL,'hsp@sohu.com','hsp');

SELECT * FROM t24;

-- 自增长细节：
-- 1. 一般来说自增长是和primary key 配合使用的
-- 2. 自增长也可以单独使用[但是需要配合一个unique(唯一约束)]
-- 3. 自增长修饰的字段为整数型的（虽然小数也可以但是非常非常少这样使用）
-- 4. 自增长默认从1开始，你也可以通过如下命令修改
-- alter table 表名 auto_increment = 新的开始值;
-- 5. 如果你添加数据时，给自增长字段（列）指定的有值，则以指定的
-- 值为准，如果指定了自增长，一般来说，就按照自增长的规则来添加数据。




-- 修改默认的自增长开始值
CREATE TABLE t25(
	id INT PRIMARY KEY AUTO_INCREMENT, -- 默认从1开始
	email VARCHAR(32) NOT NULL DEFAULT '',
	`name` VARCHAR(32) NOT NULL DEFAULT '');

ALTER TABLE t25 AUTO_INCREMENT = 100;
INSERT INTO t25
	VALUES(NULL,'tom@sohu.com','tom'); 
INSERT INTO t25
	VALUES(NULL,'jack@sohu.com','jack');
INSERT INTO t25
	VALUES(444,'a@sohu.com','a'); -- 直接指定自增长的优先级最高
INSERT INTO t25
	VALUES(NULL,'b@sohu.com','b'); -- 底层找到id字段最大值+1
 
SELECT * FROM t25;











