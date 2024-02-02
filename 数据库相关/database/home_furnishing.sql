-- 创建家具网购需要的数据库和表-- 创建 home_furnishing
-- 删除,一定要小心
DROP DATABASE IF EXISTS home_furnishing; 

-- 创建数据库
CREATE DATABASE home_furnishing; 


USE home_furnishing; 

DROP TABLE `member`
-- 创建会员表
CREATE TABLE `member`( 
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`username` VARCHAR(32) NOT NULL UNIQUE, 
`password` VARCHAR(32) NOT NULL, 
`email` VARCHAR(64) 
)CHARSET utf8 ENGINE INNODB

-- 测试数据

INSERT INTO member(`username`,`password`,`email`) 
VALUES('admin',MD5('admin'),'hsp@hanshunping.net'); 

INSERT INTO member(`username`,`password`,`email`) 
VALUES('milan123',MD5('milan123'),'milan123@hanshunping.net'); 

INSERT INTO member(`username`,`password`,`email`)VALUES('milan123xa',MD5('milan123'),'milan123@hanshunping.net'); 

SELECT * FROM member;

SELECT * FROM member       -- 数据库这里不用打一个空格再回车，但是在DAO层用字符串拼接sql语句时
WHERE `username` = 'admin';-- 这里必须打一个空格在换行拼接字符串！！！



UPDATE `member` SET `password` = MD5('123456') WHERE username = 'admin'
SELECT * FROM member WHERE `username` = 'admin' AND `password` = MD5('123456');





