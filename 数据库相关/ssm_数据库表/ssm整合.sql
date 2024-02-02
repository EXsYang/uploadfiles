-- 创建 furns_ssm
DROP DATABASE IF EXISTS furns_ssm;
CREATE DATABASE furn_ssm;
USE furn_ssm; -- 创建家居表
CREATE TABLE furn(
`id` INT(11) PRIMARY KEY AUTO_INCREMENT, ## id
`name` VARCHAR(64) NOT NULL, ## 家居名
`maker` VARCHAR(64) NOT NULL, ## 厂商
`price` DECIMAL(11,2) NOT NULL, ## 价格
`sales` INT(11) NOT NULL, ## 销量
`stock` INT(11) NOT NULL, ## 库存
`img_path` VARCHAR(256) NOT NULL ## 照片路径
);

-- 初始化家居数据
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

SELECT * FROM furn;


















