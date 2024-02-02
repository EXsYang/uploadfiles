-- 使用反引号是为了防止关键字 
CREATE DATABASE `mybatis`;
USE `mybatis`;
-- 1. 创建 mybatis 数据库 - monster 表
CREATE TABLE `monster` (
`id` INT NOT NULL AUTO_INCREMENT, #id是自增长的 插入时不用管
`age` INT NOT NULL, 
`birthday` DATE DEFAULT NULL,
`email` VARCHAR(255) NOT NULL , 
`gender` TINYINT NOT NULL, 
`name` VARCHAR(255) NOT NULL,
`salary` DOUBLE NOT NULL,
PRIMARY KEY (`id`)
) CHARSET=utf8;


-- 添加语句 建议表名 字段名带上反引号
INSERT INTO `monster` (`age`,`birthday`,`email`,`gender`,`name`,`salary`) 
VALUES(10,NULL,'222@qq.com',1,'hsp','10000');

SELECT * FROM `monster`;


DELETE FROM `monster` WHERE `id`=2;

UPDATE `monster` SET `age`=200,`birthday` = NULL,`email` = '32@sohu.com',
`gender`=1,`name`='蜈蚣精',`salary` = 4000 WHERE id = 5;

SELECT * FROM `monster` WHERE id = 5;

DROP TABLE `monk`;

# 课堂练习和尚monk表
CREATE DATABASE `mybatis2`;
USE `mybatis2`;

CREATE TABLE `monk` (
`id` INT NOT NULL AUTO_INCREMENT, #id是自增长的 插入时不用管
`nickname` VARCHAR(255) NOT NULL, 
`skill` VARCHAR(255) NOT NULL, 
`grade` INT NOT NULL,
`salary` DOUBLE NOT NULL,
-- `birthday` DATETIME DEFAULT NULL, #可以显示年月日时分秒
`birthday` TIMESTAMP, #可以显示年月日时分秒
`entry` DATE DEFAULT NULL,
PRIMARY KEY (`id`)
) CHARSET=utf8;

DROP TABLE `monk`;

INSERT INTO `monk` (`nickname`,`skill`,`grade`,`salary`,`birthday`,`entry`) 
VALUES ('法海','锁妖塔',100,200,NOW(),NOW());

SELECT * FROM `monk`;


DELETE FROM `monk` WHERE `id` = 1;

UPDATE `monk` SET `nickname` = '孙悟空',`skill` = '金箍棒',`grade` = '99',
`salary` = 100,`birthday` = NOW(),`entry` = NOW() WHERE id = 4;

SELECT * FROM `monk` WHERE `id` = 4;














