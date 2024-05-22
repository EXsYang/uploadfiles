
#创建数据库seckill
DROP DATABASE IF EXISTS `seckill`;
CREATE DATABASE `seckill`;
USE `seckill`;

#1. 创建表 seckill_user

DROP TABLE IF EXISTS `seckill_user`;

CREATE TABLE `seckill_user` (
`id` BIGINT(20) NOT NULL COMMENT '用户 ID, 设为主键, 唯一 手机号', 
`nickname` VARCHAR(255) NOT NULL DEFAULT '', 
`password` VARCHAR(32) NOT NULL DEFAULT '' COMMENT 'MD5(MD5(pass 明文+固定salt)+salt)', 
`salt` VARCHAR(10) NOT NULL DEFAULT '',
`head` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '头像', 
`register_date` DATETIME DEFAULT NULL COMMENT '注册时间', 
`last_login_date` DATETIME DEFAULT NULL COMMENT '最后一次登录时间', 
`login_count` INT(11) DEFAULT '0' COMMENT '登录次数',
PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

SELECT * FROM `seckill_user`;

INSERT INTO `seckill_user` (id, nickname, PASSWORD, salt, head, register_date, login_count)
VALUES (13300000000, 'tom', '2ef6dd46e8d4ec44f09f4033a59bfbf0', '3cj5tnMw', 'tx', NOW(), 0);

INSERT INTO `seckill_user` (id, nickname, PASSWORD, salt, head, register_date, login_count)
VALUES (13300000001, 'jack', '2ef6dd46e8d4ec44f09f4033a59bfbf0', '3cj5tnMw', 'tx', NOW(), 0);

DELETE FROM `seckill_user` WHERE id >= 13300000100;


SELECT * FROM `seckill_user` WHERE id >= 13300000890;



DROP TABLE IF EXISTS `t_goods`;
# 秒杀商品表，存放的是所有的商品
CREATE TABLE `t_goods` (
`id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '商品id', 
`goods_name` VARCHAR(16) NOT NULL DEFAULT '', 
`goods_title` VARCHAR(64) NOT NULL DEFAULT '' COMMENT '商品标题', 
`goods_img` VARCHAR(64) NOT NULL DEFAULT '' COMMENT '商品图片', 
`goods_detail` LONGTEXT NOT NULL COMMENT '商品详情',
`goods_price` DECIMAL(10,2) DEFAULT '0.00' COMMENT '商品价格', 
`goods_stock` INT(11) DEFAULT '0' COMMENT '商品库存', 
PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;




INSERT INTO `t_goods` VALUES ('1', '整体厨房设计-套件', '整体厨房设计-套件', '/imgs/kitchen.jpg', '整体厨房设计-套件', '15266.00', '100');
INSERT INTO `t_goods` VALUES ('2', '学习书桌-套件', '学习书桌-套件', '/imgs/desk.jpg', '学习书桌-套件', '5690.00', '100');


DROP TABLE IF EXISTS `t_seckill_goods`;

CREATE TABLE `t_seckill_goods` (
`id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '秒杀商品id', 
`goods_id` BIGINT(20) DEFAULT 0 COMMENT '该秒杀商品对应t_goods表的id', 
`seckill_price` DECIMAL(10,2) DEFAULT '0.00' COMMENT '秒杀价', 
`stock_count` INT(10) DEFAULT 0 COMMENT '秒杀商品库存', 
`start_date` DATETIME DEFAULT NULL COMMENT '秒杀开始时间', 
`end_date` DATETIME DEFAULT NULL COMMENT '秒杀结束时间', 
PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;


INSERT INTO `t_seckill_goods` VALUES ('1', '1', '5266.00', '0', '2022-11-18 19:36:00', '2022-11-19 09:00:00');
INSERT INTO `t_seckill_goods` VALUES ('2', '2', '690.00', '10', '2022-11-18 08:00:00', '2022-11-19 09:00:00');


SELECT * FROM `t_seckill_goods`;
#下面这条语句，即使条件不满足，执行之后也不报错，只是影响行数为0而已
UPDATE t_seckill_goods SET stock_count = stock_count - 1 WHERE goods_id = 1 AND stock_count > 0;


#编写sql,可以返回秒杀商品列表/信息
 -- 左外连接，左侧的表完全显示

SELECT g.id, g.goods_name, 
	g.goods_title, 
	g.goods_img,
	g.goods_detail, 
	g.goods_price, 
	g.goods_stock, 
	sg.seckill_price, 
	sg.stock_count, 
	sg.start_date, 
	sg.end_date
	FROM 
	t_goods g LEFT JOIN t_seckill_goods AS sg -- 左外连接，左侧的表完全显示
	ON g.id = sg.goods_id; -- ON 后面写条件，相当于where


-- 获取指定商品详情-根据id
 SELECT
            g.id, g.goods_name,
            g.goods_title,
            g.goods_img,
            g.goods_detail,
            g.goods_price,
            g.goods_stock,
            sg.seckill_price,
            sg.stock_count,
            sg.start_date,
            sg.end_date
            FROM
            t_goods g LEFT JOIN t_seckill_goods AS sg -- 左外连接，左侧的表完全显示
            ON g.id = sg.goods_id -- ON 后面写条件，相当于where
            WHERE g.id =1;




-- ----------------------------
-- Table structure for t_order 普通订单表,记录订单完整信息
-- ---------------------------- DROP TABLE IF EXISTS `t_order`;
-- AUTO_INCREMENT=600 表示自增的字段从600开始自增长
CREATE TABLE `t_order` (
`id` BIGINT(20) NOT NULL AUTO_INCREMENT, 
`user_id` BIGINT(20) NOT NULL DEFAULT 0, 
`goods_id` BIGINT(20) NOT NULL DEFAULT 0, 
`delivery_addr_id` BIGINT(20) NOT NULL DEFAULT 0, 
`goods_name` VARCHAR(16) NOT NULL DEFAULT '', 
`goods_count` INT(11) NOT NULL DEFAULT '0', 
`goods_price` DECIMAL(10,2) NOT NULL DEFAULT '0.00', 
`order_channel` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '订单渠道 1pc，2Android，3ios', 
`status` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '订单状态：0 新建未支付 1 已支付 2 已发货 3 已收货 4 已退款 5 已完成',
`create_date` DATETIME DEFAULT NULL, `pay_date` DATETIME DEFAULT NULL,
PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=600 DEFAULT CHARSET=utf8mb4;
-- ----------------------------
-- Table structure for t_seckill_order 秒杀订单表,记录某用户 id,秒杀的商品 id,及其订单 id
-- ---------------------------- DROP TABLE IF EXISTS `t_seckill_order`;
CREATE TABLE `t_seckill_order` (
`id` BIGINT(20) NOT NULL AUTO_INCREMENT, 
`user_id` BIGINT(20) NOT NULL DEFAULT 0, 
`order_id` BIGINT(20) NOT NULL DEFAULT 0, 
`goods_id` BIGINT(20) NOT NULL DEFAULT 0,
PRIMARY KEY (`id`),
UNIQUE KEY `seckill_uid_gid` (`user_id`,`goods_id`) USING BTREE COMMENT ' 用户 id，商
品 id 的唯一索引，解决同一个用户多次抢购' ) ENGINE=INNODB AUTO_INCREMENT=300 DEFAULT CHARSET=utf8mb4;

SELECT * FROM `t_seckill_order`;

#在MySQL5.7中查看Mysql当前事务隔离级别
SELECT @@tx_isolation;

#在MySQL8中查看Mysql当前事务隔离级别
SELECT @@transaction_isolation;

#REPEATABLE-READ


























