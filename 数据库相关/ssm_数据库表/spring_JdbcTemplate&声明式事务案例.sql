-- 创建数据库
CREATE DATABASE spring
USE spring
-- 创建表 monster
CREATE TABLE monster(
id INT PRIMARY KEY, `name` VARCHAR(64) NOT NULL DEFAULT '',
skill VARCHAR(64) NOT NULL DEFAULT '' )CHARSET=utf8
INSERT INTO monster VALUES(100, '青牛怪', '吐火');
INSERT INTO monster VALUES(200, '黄袍怪', '吐烟');
INSERT INTO monster VALUES(300, '蜘蛛怪', '吐丝');

SELECT `id` AS `monsterId` ,`name` ,`skill` FROM monster WHERE `id` = 100;

-- 演示声明式事务创建的表
CREATE TABLE `user_account`(
user_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
user_name VARCHAR(32) NOT NULL DEFAULT '',
money DOUBLE NOT NULL DEFAULT 0.0
)CHARSET=utf8;
INSERT INTO `user_account` VALUES(NULL,'张三', 1000);
INSERT INTO `user_account` VALUES(NULL,'李四', 2000);
CREATE TABLE `goods`(
goods_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
goods_name VARCHAR(32) NOT NULL DEFAULT '',
price DOUBLE NOT NULL DEFAULT 0.0
)CHARSET=utf8 ;
INSERT INTO `goods` VALUES(NULL,'小风扇', 10.00);
INSERT INTO `goods` VALUES(NULL,'小台灯', 12.00);
INSERT INTO `goods` VALUES(NULL,'可口可乐', 3.00);
CREATE TABLE `goods_amount`(
goods_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
goods_num INT UNSIGNED DEFAULT 0
)CHARSET=utf8 ;
INSERT INTO `goods_amount` VALUES(1,200);
INSERT INTO `goods_amount` VALUES(2,20);
INSERT INTO `goods_amount` VALUES(3,15);




-- ---------------------------------------------

# 声明式事务 传播机制 和 隔离级别  、 超时回滚

SELECT * FROM goods;

SELECT * FROM user_account;

SELECT * FROM goods_amount;

SELECT @@global.tx_isolation;

UPDATE goods SET price = 10 WHERE goods_id = 1;


-- ---------------------------------------------

-- homework

# 卖家表
CREATE TABLE `seller`(
seller_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
seller_name VARCHAR(32) NOT NULL DEFAULT '',
seller_money DOUBLE NOT NULL DEFAULT 0.0
)CHARSET=utf8;


# 买家表
CREATE TABLE `buyer`(
buyer_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
buyer_name VARCHAR(32) NOT NULL DEFAULT '',
buyer_money DOUBLE NOT NULL DEFAULT 0.0
)CHARSET=utf8;

# goods表 使用之前的

# taoBao表 提取入账成交额的10%
CREATE TABLE `taoBao`(
taoBao_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
taoBao_money DOUBLE NOT NULL DEFAULT 0.0
)CHARSET=utf8;

SELECT * FROM seller;
INSERT INTO `seller` VALUES(NULL,'卖家1', 1000);
INSERT INTO `seller` VALUES(NULL,'卖家2', 3000);

SELECT * FROM buyer;
INSERT INTO `buyer` VALUES(NULL,'买家1', 2000);
INSERT INTO `buyer` VALUES(NULL,'买家2', 2000);
UPDATE buyer SET buyer_name = '买家1' WHERE buyer_id=1;

SELECT * FROM taoBao;
INSERT INTO `taoBao` VALUES(NULL, 0);




























