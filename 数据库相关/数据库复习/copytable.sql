-- 表的复制
-- 为了对某个sql语句进行效率测试，我们需要海量数据时，可以使用此方法为表创建海量数据

CREATE TABLE my_tab01
	(id INT,
	`name` VARCHAR(32),
	sal DOUBLE,
	job VARCHAR(32),
	deptno INT);

SELECT * FROM my_tab01;
DESC my_tab01;

-- 演示如何自我复制
-- 1. 先把emp 表的记录复制到 my_tab01 这里不需要用values
INSERT INTO my_tab01
	(id, `name`, sal, job,deptno)
	SELECT empno, ename, sal, job, deptno FROM emp;
-- 2. 自我复制
INSERT INTO my_tab01
	SELECT * FROM my_tab01;

SELECT COUNT(*) FROM my_tab01;


-- 正常的insert语句如下：
INSERT INTO `goods` (id,`goods_name`,`price`)
	VALUES(2,'iphone',5000);

-- 面试题：如何删除掉一张表重复记录
-- 1. 先创建一张表 my_tab02,
-- 2. 让 my_tab02 有重复的记录

CREATE TABLE my_tab02 LIKE emp; -- 这个语句 把emp表的结构(列)，复制到my_tab02

DESC my_tab02;

INSERT INTO my_tab02
	SELECT * FROM emp;

SELECT * FROM my_tab02;

INSERT INTO my_tab02
	SELECT * FROM my_tab02;

-- 3. 考虑去重 my_tab02的记录
/*
	思路
	(1) 先创建一张临时表 my_tmp, 该表的结构和my_tab02一样
	(2) 把my_tab02 的记录通过 distinct 关键字处理后 把记录复制到my_tmp
	(3) 清除掉 my_tab02记录
	(4) 把my_tmp 表的记录复制到 my_tab02
	(5) drop 掉 临时表my_tmp
*/	

-- (1) 先创建一张临时表 my_tmp, 该表的结构和my_tab02一样
CREATE TABLE my_tmp LIKE my_tab02;

DESC my_tmp;
SELECT * FROM my_tmp;
-- (2) 把my_tab02 的记录通过 distinct 关键字处理后 把记录复制到my_tmp
INSERT INTO my_tmp
	SELECT DISTINCT * FROM my_tab02;
SELECT * FROM my_tmp;
-- (直接改名字也行)
DROP TABLE my_tab02; -- 语法注意
RENAME TABLE my_tmp TO my_tab02; -- 语法注意
-- (3) 清除掉 my_tab02记录

SELECT * FROM my_tab02;
DELETE FROM my_tab02; -- 注意语法！！！
-- (4) 把my_tmp 表的记录复制到 my_tab02
INSERT INTO my_tab02
	SELECT * FROM my_tmp;
SELECT * FROM my_tab02;
-- (5) drop 掉 临时表my_tmp
SELECT * FROM my_tmp;
DROP TABLE my_tmp;


























