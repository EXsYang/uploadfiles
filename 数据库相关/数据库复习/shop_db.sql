-- 使用约束的课堂练习
CREATE DATABASE shop_db;

-- 现有一个商店的数据库shop_db，记录客户及其购物情况，由下面三个表组成：
-- 商品goods（商品号goods_id，商品名goods_name，单价unitprice，商品类别category，
-- 供应商provider);
-- 客户customer（客户号customer_id,姓名name,住址address,电邮email性别sex,身份证card_Id);
-- 购买purchase（购买订单号order_id，客户号customer_id,商品号goods_id,购买数量nums);
-- 1 建表，在定义中要求声明 [进行合理设计]：
-- (1)每个表的主外键；
-- (2)客户的姓名不能为空值；
-- (3)电邮不能够重复;
-- (4)客户的性别[男|女] check 枚举..
-- (5)单价unitprice 在 1.0 - 9999.99 之间 check

从表1
-- 创建商品goods表
CREATE TABLE goods (
	goods_id INT PRIMARY KEY, -- 主键 外键
	goods_name VARCHAR(32),
	unitprice DOUBLE CHECK (unitprice > 1 AND unitprice < 9999.99),
	category VARCHAR(32),
	provider VARCHAR(32),
	FOREIGN KEY (goods_id) REFERENCES purchase(goods_id));

从表2
-- 创建客户表customer

CREATE TABLE customer (
	customer_id INT PRIMARY KEY, -- 主键
	`name` VARCHAR(32) NOT NULL,
	address VARCHAR(32),
	email VARCHAR(32) UNIQUE,
	sex VARCHAR(6) CHECK (sex IN ('男','女') ),
	card_Id CHAR(18),
	FOREIGN KEY (customer_id) REFERENCES purchase(customer_id));
DROP TABLE customer;
-- 主表
-- 购买purchase（购买订单号order_id 主键，客户号customer_id 唯一,商品号goods_id 唯一,购买数量nums);

CREATE TABLE purchase (
	order_id INT PRIMARY KEY,
	customer_id INT UNIQUE,
	goods_id INT UNIQUE,
	nums INT)

DROP TABLE purchase;

INSERT INTO purchase
	VALUES(1,1,1,1),(2,2,2,2),(3,3,3,3);

INSERT INTO goods
	VALUES(1,'华为手机',4000,'手机','华为'),(2,'vivo手机',3000,'手机','vivo'),(3,'haha手机',2000,'手机','haha');

-- 客户customer（客户号customer_id,姓名name,住址address,电邮email性别sex,身份证card_Id);

INSERT INTO customer
	VALUES(1,'tom','北京','tom@sohu.com','男','122233333444567865');
INSERT INTO customer
	VALUES(2,'jack','天津','jack@sohu.com','女','122233333444562222');
INSERT INTO customer
	VALUES(3,'hsp','四川','hsp@sohu.com','男','122233333444567345');


SELECT * FROM goods;
SELECT * FROM customer;
SELECT * FROM purchase;

-- 下面的是老师建的表
-- 商品goods
CREATE TABLE goods (
	goods_id INT PRIMARY KEY,
	goods_name VARCHAR(64) NOT NULL DEFAULT '',
	unitprice DECIMAL(10,2) NOT NULL DEFAULT 0 
		CHECK (unitprice >= 1.0 AND unitprice <= 9999.99),
	category INT NOT NULL DEFAULT 0,
	provider VARCHAR(64) NOT NULL DEFAULT '');
	
-- 客户customer（客户号customer_id,姓名name,住址address,电邮email性别sex,
-- 身份证card_Id);
CREATE TABLE customer(
	customer_id CHAR(8) PRIMARY KEY, -- 程序员自己决定
	`name` VARCHAR(64) NOT NULL DEFAULT '',
	address VARCHAR(64) NOT NULL DEFAULT '',
	email VARCHAR(64) UNIQUE NOT NULL,
	sex ENUM('男','女') NOT NULL ,  -- 这里老师使用的枚举类型, 是生效
	card_Id CHAR(18)); 
	
-- 购买purchase（购买订单号order_id，客户号customer_id,商品号goods_id,
-- 购买数量nums);
CREATE TABLE purchase(
	order_id INT UNSIGNED PRIMARY KEY,
	customer_id CHAR(8) NOT NULL DEFAULT '', -- 外键约束在后
	goods_id INT NOT NULL DEFAULT 0 , -- 外键约束在后
	nums INT NOT NULL DEFAULT 0,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (goods_id) REFERENCES goods(goods_id));
DESC goods;
DESC customer;
DESC purchase;


















