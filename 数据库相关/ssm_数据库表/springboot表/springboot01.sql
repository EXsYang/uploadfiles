-- 创建 furns_ssm
DROP DATABASE IF EXISTS spring_boot;
CREATE DATABASE spring_boot;
USE spring_boot; -- 创建家居表
CREATE TABLE furn(
`id` INT(11) PRIMARY KEY AUTO_INCREMENT, ## id
`name` VARCHAR(64) NOT NULL, ## 家居名
`maker` VARCHAR(64) NOT NULL, ## 厂商
`price` DECIMAL(11,2) NOT NULL, ## 价格
`sales` INT(11) NOT NULL, ## 销量
`stock` INT(11) NOT NULL, ## 库存
`img_path` VARCHAR(256) NOT NULL ## 照片路径
);-- 初始化家居数据
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`)
VALUES(NULL , ' 北 欧 风 格 小 桌 子 ' , ' 熊 猫 家 居 ' , 180 , 666 , 7 ,
'assets/images/product-image/1.jpg');
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`)
VALUES(NULL , ' 简 约 风 格 小 椅 子 ' , ' 熊 猫 家 居 ' , 180 , 666 , 7 ,
'assets/images/product-image/2.jpg');
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`)
VALUES(NULL , ' 典 雅 风 格 小 台 灯 ' , ' 蚂 蚁 家 居 ' , 180 , 666 , 7 ,
'assets/images/product-image/3.jpg');
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`)
VALUES(NULL , ' 温 馨 风 格 盆 景 架 ' , ' 蚂 蚁 家 居 ' , 180 , 666 , 7 ,
'assets/images/product-image/4.jpg');
SELECT * FROM `furn`;

-- 到这位置是 springboot-usersys 使用到的数据

-- 下面是springboot-mybatis 使用的数据


-- 1. 创建数据库和表

CREATE DATABASE `springboot_mybatis`;
USE `springboot_mybatis`;
DROP TABLE `monster`;
 CREATE TABLE `monster` (
`id` INT NOT NULL AUTO_INCREMENT,
`age` INT NOT NULL,
`birthday` DATE DEFAULT NULL,
`email` VARCHAR(255) DEFAULT NULL,
`gender` CHAR(1) DEFAULT NULL,
`name` VARCHAR(255) DEFAULT NULL,
`salary` DOUBLE NOT NULL,
PRIMARY KEY (`id`)
) CHARSET=utf8;
SELECT * FROM `monster`;
INSERT INTO monster VALUES(NULL, 20, '2000-11-11', 'nmw@sohu.com', '男', '牛魔王', 5000.88);
INSERT INTO monster VALUES(NULL, 10, '2011-11-11', 'bgj@sohu.com', '女', '白骨精', 8000.88);


select * from `monster` where `email` like '%com%'

-- 模糊查询'%%' 中间什么都不写默认是查询所有记录
SELECT * FROM `monster` WHERE `email` LIKE '%%'


SELECT * FROM `monster` WHERE `id` = 1;


-- 下面是整合springboot-mybatisPlus

-- 1. 创建数据库和表
CREATE DATABASE `springboot_mybatisplus`;
USE `springboot_mybatisplus`;
CREATE TABLE `monster` (
`id` INT NOT NULL AUTO_INCREMENT,
`age` INT NOT NULL,
`birthday` DATE DEFAULT NULL,
`email` VARCHAR(255) DEFAULT NULL,
`gender` CHAR(1) DEFAULT NULL,
`name` VARCHAR(255) DEFAULT NULL,
`salary` DOUBLE NOT NULL,
PRIMARY KEY (`id`)
) CHARSET=utf8;
SELECT * FROM `monster`;
INSERT INTO monster VALUES(NULL, 20, '2000-11-11', 'xzj@sohu.com', '男', '蝎子精',15000.88);
INSERT INTO monster VALUES(NULL, 10, '2011-11-11', 'ytj@sohu.com', '女', '玉兔精',18000.88);


