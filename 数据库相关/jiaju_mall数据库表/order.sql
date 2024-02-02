
CREATE TABLE `order`(
`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, #订单号id 
`DATATIME` DATETIME NOT NULL, #生成订单的日期 记录年月日 时分秒 '2021-11-11 10:10:10'
`price` DECIMAL(11,2) NOT NULL, #订单的金额 定点数
`status` VARCHAR(20) NOT NULL DEFAULT '', #订单状态 发货或者未发货
`member_id` INT UNSIGNED NOT NULL #会员id
)CHARSET utf8 ENGINE INNODB;

INSERT INTO `order`(id, `DATATIME` , `price` , `status` , `member_id`) 
VALUES(NULL, NOW() , 288  , '未发货' , 888);

INSERT INTO `order`(id, `DATATIME` , `price` , `status` , `member_id`) 
VALUES(NULL, '2023-08-05 18:17:46' , 28  , '未发货' , 888);

SELECT * FROM `order`

# 订单家居项表 点开详情后 需要显示的数据
CREATE TABLE `order_item`(
`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, #家居项的id 
`name` VARCHAR(32) NOT NULL, #家居名 
`price` DECIMAL(11,2) NOT NULL, #订单家居的单价 定点数
`count` INT NOT NULL, # 该项家居购买的数量
`total_price` DECIMAL(11,2) NOT NULL, #总金额
`order_id` INT NOT NULL #该商品项属于那个订单号的
)CHARSET utf8 ENGINE INNODB;

DROP TABLE `order_item`

INSERT INTO `order_item`( `id`,`name` , `price` , `count`, `total_price`, `order_id`) 
VALUES(null,'沙发ffa',102,2,204,111);

INSERT INTO `order_item`( `name` , `price` , `count`, `total_price`, `order_id`) 
VALUES( '书桌' , 50  , 2 , 100,666);
INSERT INTO `order_item`( `name` , `price` , `count`, `total_price`, `order_id`) 
VALUES( '台灯' , 200  , 3 , 600,777);

SELECT * FROM `order_item`



-- 以下是参考老韩改的
-- 订单表 order 
-- 参考界面来写订单
-- 认真分析字段和字段类型
-- 老师说明: 每个字段, 使用not null 来约束
--  字段类型的设计, 应当和相关的表的字段有对应
-- 外键是否要给? 1. 需要[可以从db层保证数据的一致性 ]  
-- 2. 不需要[老韩推荐] [外键对效率有影响, 应当从程序的业务保证一致性]
-- 是否需要一个外键的约束? 
-- FOREIGN KEY(`member_id`) REFERENCES `member`(`id`) 


-- 主键本来就是非空唯一的 不用再加一遍 not null!!! 
-- 主键可以和not null 连用(不会报错)但是没必要！
-- `id` varchar(64) primary not null, -- 订单号
-- 这里的错误是 主键是primary key 而不是 primary！
CREATE TABLE `order`(
`id` varchar(64) primary key, -- 订单号	可能是sn-000001 而不是一个纯数字!
`create_time` datetime not null, -- 订单生成时间  
`price` DECIMAL(11,2) not null, -- 订单的金额 
`status` tinyint not null, -- 状态 0 未发货 1 已发货 2 已结账
`member_id` INT not null  --  该订单对应的会员id
)CHARSET utf8 ENGINE INNODB;

select * from `order`;

insert into `order`(`id`,`create_time`,`price`,`status`,`member_id`) 
values('sn-00001',now(),200,0,10);

SELECT `id`,`create_time` `createTime`,`price`,`status`,`member_id` `memberId` FROM `order` where `id` = '`member`';

SELECT `id`,`create_time` `createTime`,`price`,`status`,`member_id` `memberId` FROM `order` WHERE `order_id` = 11;


DROP TABLE `order`

desc `order`

-- 创建订单项表
CREATE TABLE `order_item`(
`id` int primary key auto_increment,-- 订单项的id
`name` VARCHAR(64) not null, -- 家居名
`price` DECIMAL(11,2) not null,-- 家居价格
`count`	int not null, -- 数量
`total_price` DECIMAL(11,2) not null,-- 订单项的总价
`order_id` VARCHAR(64) not null -- 对应的订单号
)CHARSET utf8 ENGINE INNODB;

INSERT INTO `order_item`( `id`,`name` , `price` , `count`, `total_price`, `order_id`) 
VALUES(NULL,'北欧小沙发',230,2,460,'sn-00001');

INSERT INTO `order_item`( `id`,`name` , `price` , `count`, `total_price`, `order_id`) 
VALUES(?,?,?,?,?,?);

select * from `order_item`;

select `id`,`name` , `price` , `count`, `total_price` `totalPrice`, `order_id` `orderId` from `order_item` 
where `order_id` = '1691403140053-10'; -- `order_id` 为null 和 '' 什么都查不到 可以查到的是模糊查询时的情况

DROP TABLE `order_item`














