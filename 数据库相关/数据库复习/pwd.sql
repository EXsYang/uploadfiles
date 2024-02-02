-- 演示加密函数和系统函数

-- USER() 查询用户
-- 可以查看登录到mysql的有哪些用户，以及登录的IP
SELECT USER() FROM DUAL; -- 用户@IP地址

-- database() 查询当前使用数据库名称
USE hsp_db02;
SELECT DATABASE();

-- MD5(str)  为字符串算出一个MD5 32位的字符串，常用(用户密码)加密
-- root 密码是 hsp -> 加密MD5 -> 在数据库中存放的是加密后的密码
SELECT MD5('hsp') FROM DUAL;
SELECT LENGTH(MD5('hsp')) FROM DUAL;
SELECT LENGTH(MD5('hspfgshtrrfgjgfdgshgsh')) FROM DUAL; -- 不管密码多长，md5后都是32位

-- 演示用户表，存放密码时，是md5
CREATE TABLE users(
	id INT,
	`name` VARCHAR(32) NOT NULL DEFAULT '',
	pwd CHAR(32) NOT NULL DEFAULT '');

INSERT INTO users 
	VALUES( 1,'韩顺平',MD5('hsp'));

SELECT * FROM users;

SELECT * FROM users 	-- SQL注入问题
	WHERE `name` = '韩顺平' AND `pwd` = MD5('hsp');
	
-- password(str) 加密函数 --mysql8 中弃用了

SELECT PASSWORD('hsp') FROM DUAL; -- mysql 用户密码默认用的密码加密方法就是password函数加密

-- SELECT * FROM mysql.user \G 从原文密码str 计算并返回密码字符串
-- 通常用于对mysql数据库的用户密码加密
-- mysql.user 表示 数据库.表  带上mysql. 可以不用切换数据库 root用户，创建的用户在mysql数据库中


SELECT * FROM mysql.user 

























