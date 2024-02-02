-- VALUE is a synonym for VALUES in this context. Neither implies anything
--  about the number of values lists, nor about the number of values per list.
--   Either may be used whether there is a single values list or multiple lists,
--    and regardless of the number of values per list.
-- value可以用于插入单条数据也可以插入多条数据，values亦是如此
-- SQL Server只支持VALUES作为关键字，不要搞混了。
INSERT INTO t09 VALUE('name1 ydddd');插入一行数据

INSERT INTO t09 VALUES('name1s ydddd');插入一行数据

INSERT INTO t09 VALUE('name1 ydddd'),('name2 ydddd'),
			('name3 ydddd'),('name4 ydddd'),
			('name5 ydddd'),('name6 ydddd');插入多行数据

INSERT INTO t09 VALUES('name11 ydddd'),('name22 ydddd'),
			('name33 ydddd'),('name44 ydddd'),
			('name55 ydddd'),('name66 ydddd');插入多行数据
SELECT * FROM t09;
DELETE FROM t09 WHERE `name`=; -- 删除表中的数据
DROP TABLE t09; -- 删除表

-- delete 语句演示

-- 删除表中名称为`张三丰`的记录
DELETE FROM employee
	WHERE `user_name` = '张三丰';

-- 删除表中所有记录，提醒一定要小心
DELETE FROM employee;

-- Delete语句不能删除某一列的值（可使用update 设为 null 或者''）
UPDATE employee SET job = '' WHERE user_name = '杨达';
UPDATE employee SET job = NULL WHERE user_name = '杨达';
SELECT * FROM employee;

-- 要删除这个表
DROP TABLE employee;


#演示bit类型使用
#说明
#1. bit(m) m 在 1-64
#2. 添加数据 范围 按照你给的位数来确定， 比如 m = 8 表示一个字节 0~255
#3. 显示按照bit
#4. 查询时，任然可以按照数来查询

CREATE TABLE t05 (num BIT(8) );
INSERT INTO t05 VALUES(255);
SELECT * FROM t05;
SELECT * FROM t05 WHERE num = 255;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

#演示字符串类型使用char varchar
#注释的快捷键 shift + ctrl + c,注销注释 shift + ctrl + r
-- char(size)
-- 固定长度字符串 最大255 字符
-- varchar(size) 0~65535字节 2^16字节
-- 可变长度字符串 最大65532字节 【utf8编码最大21844字符 1-3个字节用于记录大小】
如果表的编码是utf8 VARCHAR(size) size = (65535-3) / 3 = 21844
如果表的编码是gbk VARCHAR(size) size = (65535-3) / 2 = 32766



CREATE 1TABLE t09 (
	`name` CHAR(255));

CREATE TABLE t022 (
	`name` CHAR(256)); -- Column length too big for column 'name' (max = 255); use BLOB or TEXT instead
	
SELECT * FROM t09;
INSERT INTO t09 VALUES('name1 ydddd')
	
CREATE TABLE t10 (
	`name` VARCHAR(21844));
CREATE TABLE t100 (
	`name` VARCHAR(21845));	-- Row size too large. The maximum row size for the used table type,
-- 				not counting BLOBs, is 65535. 
-- 				This includes storage overhead, check the manual.
-- 				You have to change some columns to TEXT or BLOBs

DROP TABLE t09;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

#演示字符串类型的使用细节
#1. char(4)和 varchar(4) 这个4表示的是字符，而不是字节，不区分字符是汉字还是字母
#不管是 中文还是英文字母，都是最多存放4个，是按照字符来存放的
#2. char(4)是定长，就是说，即使你插入'aa',也会占用 分配的四个字符
#varchar(4)是变长，就是说，如果你插入了'aa'，实际占用空间大小并不是4个字符
#，而是按照实际占用空间来分配（varchar本身还需要占用1~3个字节，来记录存放内容长度
#L(实际数据大小+(1~3)字节)
#3. 什么时候使用char,什么时候使用varchar
#①如果数据是定长，推荐使用char,比如md5的密码，邮编，手机号，身份证号等 char(32)
#②如果一个字段的长度是不确定，我们使用varchar,比如留言，文章
# 查询速度 char > varchar
#4. 在存放文本时，也可以使用Text数据类型。可以i将Text列视为varchar列，
#注意 Text 不能有默认值，大小 0 - 2^16字节
#如果希望存放更多字符，可以选择 MEDIUMTEXT 0-2^24 或者LONGTEXT 0~2^32

CREATE TABLE t11 (
	`name`  CHAR(4));
INSERT INTO t11 VALUES('AA');
INSERT INTO t11 VALUES('AAaa');
INSERT INTO t11 VALUES('AAaaA'); -- Data too long for column 'name' at row 1

SELECT * FROM t11;
CREATE TABLE t12 (
	`name`  VARCHAR(4));
INSERT INTO t12 VALUES('韩顺平号');
SELECT * FROM t12;

CREATE TABLE t13 (
	content TEXT,content2 MEDIUMTEXT,content3 LONGTEXT);
INSERT INTO t13 VALUES('韩顺平','韩顺平123','韩顺平11111~~');
SELECT * FROM t13;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
#演示decimal类型、float、double使用 deci： 十分之一 decimal： 小数的;十进制的;	定点数
# decimal[M,D] M是小数位数(精度)的总和，D是小数点(标度)后面的位数
# 如果D是0，则值没有小数点或分数部分。M最大65，D最大30。如果M被省略，默认是10，如果D被省略，默认是0

#创建表
CREATE TABLE t072 (
	
 	num3 DECIMAL(30,20));  显示规则 小数点后20位全部展示出来，不够补零，前面的30，表示这个数最多30位
#添加数据

INSERT INTO t072 VALUES(444.55) -- M是小数位数的总数，最大65 总体的位数不够65不会显示65位，  D,小数点后面20位显示出来了 D写多少小数点后面显示多少位，不够补0
SELECT * FROM t072;

#创建表

CREATE TABLE t06 (
	num1 FLOAT,
	num2 DOUBLE,
	num3 DECIMAL(5,2)); -- 不能填位数大于5-2的整数
DROP TABLE t06;
#添加数据
INSERT INTO t06 VALUES(444.55,4555.5,66.2)
INSERT INTO t06 VALUES(444.55,4555.5,677)
INSERT INTO t06 VALUES(444.55,4555.5,6774) -- 添加失败 ，显示出后面的小数点 总体变成6位了
INSERT INTO t06 VALUES(444.55,4555.5,67755)-- 添加失败，显示出后面的小数点 总体变成7位了
INSERT INTO t06 VALUES(88.12345678912345,88.12345678912345,88.12345678912345); 
INSERT INTO t06 VALUES(88.12345678912345,88.12345678912345,88.12345678912345); 

SELECT * FROM t06;

#decimal可以存放很大的数

CREATE TABLE t07 (
	
	num3 DECIMAL(65));

INSERT INTO t07 VALUES(342232422342256463635555555666666666666677777);

SELECT * FROM t07;

CREATE TABLE t08 (
	num BIGINT UNSIGNED)

INSERT INTO t08 VALUES(342232422342256463635555555666666666666677777); -- BIGINT存不进去这么大的数！






-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

#演示时间相关的类型
#创建一张表，date ,datetime ,timestamp 时间戳
CREATE TABLE t14 (
  birthday DATE,
  -- 生日
  job_time DATETIME,
  -- 记录年月日 时分秒
  login_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;-- 登录时间，如果希望login_time列自动更新

SELECT * FROM t14;
INSERT INTO t14(birthday,job_time)
	VALUES('2021-11-11','2021-11-11 10:10:10');
-- 如果更新，t14表的某条记录，login_time列会自动地以当前时间进行更新
 	
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
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

CREATE TABLE `emp01`(
	id INT,
	`name` VARCHAR(32),
	`gender` CHAR(1),
	birthday DATE,
	entry_date DATE,
	job VARCHAR(32),
	Salary DECIMAL(10,2),
	`resume` TEXT) CHARSET utf8 COLLATE utf8_bin ENGINE INNODB;
	
ALTER TABLE emp01 MODIFY entry_date DATETIME;	
INSERT INTO `emp01` VALUES( 1,'小妖怪','男','2020-10-10','2022-10-10 10:10:00','巡山的',800,'大王叫我来巡山');
INSERT INTO `emp01` VALUES( 2,'小妖怪','男','2020-10-10','2022-10-10','巡山的',800,'大王叫我来巡山');
SELECT * FROM emp01;

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
INSERT INTO `emp` VALUES( 2,'小妖怪','男','2020-10-10','2022-10-10 10:10:44','巡山的',800,);
SELECT * FROM emp;	



-- BLOB、TEXT、GEOMETRY或JSON列“resume”不能具有默认值 
CREATE TABLE `t002` (`resume` TEXT DEFAULT 'text') CHARSET utf8 COLLATE utf8_bin ENGINE INNODB;  

INSERT INTO t001 VALUES(); TEXT -- 类型可以为null
SELECT * FROM t001;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
#修改表的操作练习
-- 员工表emp 增加一个image列，varchar类型(要求在resume后面)

ALTER TABLE emp ADD image VARCHAR(32) NOT NULL DEFAULT '' AFTER `resume`
DESC emp; -- 显示表结构，可以查看表的所有列 

-- 修改job列，使其长度为60
ALTER TABLE emp
	MODIFY job VARCHAR(60) NOT NULL DEFAULT ''

-- 删除sex列
ALTER TABLE emp
	DROP sex;

-- 表明改为employee
RENAME TABLE emp TO employee;
DESC employee;
-- 修改表的字符集为utf8
ALTER TABLE employee CHARACTER SET utf8;

-- 列名name修改为user_name
ALTER TABLE employee
	CHANGE `name` `user_name` VARCHAR(64) NOT NULL DEFAULT ''

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

#练习insert 语句
-- 创建一张商品表goods (id int,goods_name varchar(10),price double );
-- 添加两条记录
CREATE TABLE `goods` (
	id INT,
	`goods_name` VARCHAR(10),
	`price` DOUBLE);
-- 添加数据
INSERT INTO `goods` (id,`goods_name`,`price`)
	VALUES(1,'华为手机',3000);
INSERT INTO `goods` (id,`goods_name`,`price`)
	VALUES(2,'iphone',5000);
SELECT * FROM `goods`;

DESC employee;
INSERT INTO employee(id,user_name,birthday,entry_date,job,selary,`resume`,image)
	VALUES(1,'杨达','1998-3-27','2023-4-4 10:10:33','程序员',12000,'后端开发','img');
INSERT INTO employee(id,user_name,birthday,entry_date,job,selary,`resume`,image)
	VALUES(1,'张三丰','1955-3-27','2033-4-4 10:10:33','太极拳',12000,'拳师','img1');
SELECT * FROM employee;


#说明 insert 语句的细节
-- 1.插入的数据应与字段的数据类型相同
-- 	比如 把 'abc' 添加到 int 类型会错误
INSERT INTO `goods` (id,goods_name,price)
	VALUES('3','小米手机',2000); -- 可以成功，mysql底层会试着将'3' 转换成整形
INSERT INTO `goods` (id,goods_name,price)
	VALUES('韩顺平','小米手机',4000); -- 失败
SELECT * FROM `goods`;

#2. 数据的长度应在列的规定范围内，例如：不能将一个长度为80的字符串加入到长度为40的列中
INSERT INTO `goods` (id,goods_name,price)
	VALUES(40,'vivo手机vivo手机vivo手机vivo手机vivo手机',3000);

#3. 在values中列出的数据位置必须与被加入的列的排列位置相对应
INSERT INTO `goods` (id,goods_name,price) -- 一般是按照顺序写
	VALUES('vivo手机',4,2000);  -- 错误的

INSERT INTO `goods` (goods_name,id,price) -- 很少这样写，但是可以执行成功
	VALUES('vivo手机',4,2000); 

#4. 字符和日期型数据应包含在单引号中
INSERT INTO `goods` (id,goods_name,price)
	VALUES(40,vivo手机,3000); -- 错误的 应该 'vivo手机'


#5. 列可以插入空值[前提是该字段允许为空]，insert into table value(null)
-- 在创建表时，该列没有写 NOT NULL 表示该列可以为NULL 

INSERT INTO `goods` (id,goods_name,price)
	VALUES(404,'vivo手机',NULL);
SELECT * FROM `goods`;

#6. insert into tab_name (列名..) values (),(),() 形式添加多条记录
INSERT INTO `goods` (id,goods_name,price)
	VALUES(50,'三星手机',4000),(60,'海尔手机',5000);
SELECT * FROM goods;
#7. 如果是给表中的所有字段添加数据，可以不写前面的字段名称
INSERT INTO `goods`
	VALUES(70,'IBM手机',7000);
SELECT * FROM goods;

#8. 默认值的使用，当不给某个字段值时，如果有默认值就会添加，否则报错
-- 如果某个列 没有指定 not null ,那么当添加数据时，没有给定值，则会默认给null
CREATE TABLE goods2 (
	id INT,
	`goods_name` VARCHAR(30),
	price INT NOT NULL DEFAULT 100)

INSERT INTO `goods`(id,goods_name)
	VALUES(705,'IBM手机');
SELECT * FROM goods2;

INSERT INTO `goods2`(id,goods_name)
	VALUES(705,'IBM手机');















	
	
	














































