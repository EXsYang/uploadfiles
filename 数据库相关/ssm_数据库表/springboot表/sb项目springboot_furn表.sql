--  1. 创建数据库和表
-- 创建 springboot_vue
DROP DATABASE IF EXISTS springboot_vue;
CREATE DATABASE springboot_vue;
USE springboot_vue; -- 创建家居表
DROP TABLE furn;
CREATE TABLE furn(
`id` INT(11) PRIMARY KEY AUTO_INCREMENT, ## id
`name` VARCHAR(64) NOT NULL, ## 家居名
`maker` VARCHAR(64) NOT NULL, ## 厂商
`price` DECIMAL(11,2) NOT NULL, ## 价格
`sales` INT(11) NOT NULL, ## 销量
`stock` INT(11) NOT NULL ## 库存
);
-- 初始化家居数据
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock`)
VALUES(NULL , '北欧风格小桌子' , '熊猫家居' , 180 , 666 , 7);
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock`)
VALUES(NULL , '简约风格小椅子' , '熊猫家居' , 180 , 666 , 7 );
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` )
VALUES(NULL , '典雅风格小台灯' , '蚂蚁家居' , 180 , 666 , 7 );
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` )
VALUES(NULL , '温馨风格盆景架' , '蚂蚁家居' , 180 , 666 , 7 );

-- INSERT INTO furn ( price, sales, stock ) VALUES ( 180, 180 ,180 )
-- INSERT INTO furn(`id` , `name` , `maker`)
-- VALUES(NULL , '北欧风格小桌子' , '熊猫家居' );

SELECT * FROM furn;

