#创建表的课堂练习
-- 字段 属性
-- id 	整形
-- name	 字符型
-- sex   字符型
-- birthday 日期型（date)
-- entry_date 日期型（date)
-- job 字符型
-- Salary 小数型
-- resume 文本型 

CREATE TABLE `emp` (
	id INT,
	`name` VARCHAR(32),
	sex CHAR(1),
	birthday DATE,
	entry_date DATETIME,
	job VARCHAR(32),
	selary DECIMAL(22,3),
	`resume` TEXT) CHARSET utf8 COLLATE utf8_bin ENGINE INNODB;

DROP TABLE emp;
INSERT INTO `emp` VALUES( 1,'小妖怪','男','2020-10-10','2022-10-10 10:10:44','巡山的',800,'大王叫我来巡山');
SELECT * FROM emp;	


	
	
	



