--  创建数据库/表
CREATE DATABASE e_commerce_center_db;
USE e_commerce_center_db;
CREATE TABLE member(
id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id', 
NAME VARCHAR(64) COMMENT '用户名', 
pwd CHAR(32) COMMENT '密码',
mobile VARCHAR(20) COMMENT '手机号码', 
email VARCHAR(64) COMMENT '邮箱', 
gender TINYINT COMMENT '性别', 
PRIMARY KEY (id));`storage``storage`

INSERT INTO member VALUES
(NULL, 'smith', MD5('123'), '123456789000', 'smith@sohu.com', 1);

SELECT * FROM member;

SELECT * FROM `member` WHERE `id`=1;

INSERT INTO `member` (`NAME`,`pwd`,`mobile`,`e`undo_log`mail`,`gender`) 
VALUES ("牛魔王1",MD5("12345"),"13344444444","nmw@sohu.com",1);

-- DROP TABLE member;


-- 下面是学习seata用到的数据
CREATE DATABASE seata;
USE seata;

-- 在MySQL中查看数据库版本的指令是使用 SQL 查询语句：
SELECT VERSION();

-- 下面是seata提供的创建表的脚本
-- the table to store GlobalSession data
DROP TABLE IF EXISTS `global_table`;
CREATE TABLE `global_table` (
  `xid` VARCHAR(128)  NOT NULL,
  `transaction_id` BIGINT,
  `status` TINYINT NOT NULL,
  `application_id` VARCHAR(32),
  `transaction_service_group` VARCHAR(32),
  `transaction_name` VARCHAR(128),
  `timeout` INT,
  `begin_time` BIGINT,
  `application_data` VARCHAR(2000),
  `gmt_create` DATETIME,
  `gmt_modified` DATETIME,
  PRIMARY KEY (`xid`),
  KEY `idx_gmt_modified_status` (`gmt_modified`, `status`),
  KEY `idx_transaction_id` (`transaction_id`)
);

-- the table to store BranchSession data
DROP TABLE IF EXISTS `branch_table`;
CREATE TABLE `branch_table` (
  `branch_id` BIGINT NOT NULL,
  `xid` VARCHAR(128) NOT NULL,
  `transaction_id` BIGINT ,
  `resource_group_id` VARCHAR(32),
  `resource_id` VARCHAR(256) ,
  `lock_key` VARCHAR(128) ,
  `branch_type` VARCHAR(8) ,
  `status` TINYINT,
  `client_id` VARCHAR(64),
  `application_data` VARCHAR(2000),
  `gmt_create` DATETIME,
  `gmt_modified` DATETIME,
  PRIMARY KEY (`branch_id`),
  KEY `idx_xid` (`xid`)
);

-- the table to store lock data
DROP TABLE IF EXISTS `lock_table`;
CREATE TABLE `lock_table` (
  `row_key` VARCHAR(128) NOT NULL,
  `xid` VARCHAR(96),
  `transaction_id` LONG ,
  `branch_id` LONG,
  `resource_id` VARCHAR(256) ,
  `table_name` VARCHAR(32) ,
  `pk` VARCHAR(36) ,
  `gmt_create` DATETIME ,
  `gmt_modified` DATETIME,
  PRIMARY KEY(`row_key`)
);




-- 订单微服务的数据库
CREATE DATABASE order_micro_service
USE order_micro_service

CREATE TABLE `order`(
id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, user_id BIGINT DEFAULT NULL , product_id BIGINT DEFAULT NULL , nums INT DEFAULT NULL , money INT DEFAULT NULL, `status` INT DEFAULT NULL COMMENT '0：创建中; 1：已完结' );
SELECT * FROM `order`

-- 库存微服务的数据库`storage``order`
CREATE DATABASE storage_micro_service
USE storage_micro_service
CREATE TABLE `storage`(
id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, product_id BIGINT DEFAULT NULL , amount INT DEFAULT NULL COMMENT '库存量' );
-- 初始化库存表
INSERT INTO `storage` VALUES(NULL, 1, 10);
SELECT * FROM `storage`


-- 账号微服务的数据库
CREATE DATABASE account_micro_service
USE account_micro_service
CREATE TABLE `account`(
id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY , user_id BIGINT DEFAULT NULL , money INT DEFAULT NULL COMMENT '账户金额' );
-- 初始化账户表
INSERT INTO `account` VALUES(NULL, 666, 10000);
SELECT * FROM `account`;


USE order_micro_service
CREATE TABLE `undo_log` (
`id` BIGINT(20) NOT NULL AUTO_INCREMENT, `branch_id` BIGINT(20) NOT NULL, `xid` VARCHAR(100) NOT NULL, `context` VARCHAR(128) NOT NULL, `rollback_info` LONGBLOB NOT NULL, `log_status` INT(11) NOT NULL, `log_created` DATETIME NOT NULL, `log_modified` DATETIME NOT NULL, `ext` VARCHAR(100) DEFAULT NULL,
PRIMARY KEY (`id`),
UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
USE storage_micro_service
CREATE TABLE `undo_log` (
`id` BIGINT(20) NOT NULL AUTO_INCREMENT, `branch_id` BIGINT(20) NOT NULL, `xid` VARCHAR(100) NOT NULL, `context` VARCHAR(128) NOT NULL, `rollback_info` LONGBLOB NOT NULL, `log_status` INT(11) NOT NULL, `log_created` DATETIME NOT NULL, `log_modified` DATETIME NOT NULL, `ext` VARCHAR(100) DEFAULT NULL,
PRIMARY KEY (`id`),
UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
USE account_micro_service
CREATE TABLE `undo_log` (
`id` BIGINT(20) NOT NULL AUTO_INCREMENT, `branch_id` BIGINT(20) NOT NULL, `xid` VARCHAR(100) NOT NULL, `context` VARCHAR(128) NOT NULL, `rollback_info` LONGBLOB NOT NULL, `log_status` INT(11) NOT NULL, `log_created` DATETIME NOT NULL, `log_modified` DATETIME NOT NULL, `ext` VARCHAR(100) DEFAULT NULL,
PRIMARY KEY (`id`),
UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;