#1. 创建对应的数据库/表
CREATE DATABASE hspliving_commodity;
USE hspliving_commodity;
# 老韩说明
# commodity_category 是商品分类表
# 1.CHARSET=utf8mb4 能更好的处理中文编码(utf8mb4 兼容 4 字节的 unicode , 支持常见的表情图标)
# 2.如果字段是关键字，尽量使用 _ 线来区别
CREATE TABLE `commodity_category` (
`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
`name` CHAR(50) NOT NULL COMMENT '名称', 
`parent_id` BIGINT NOT NULL COMMENT '父分类 id',
`cat_level` INT NOT NULL COMMENT '层级',
`is_show` TINYINT NOT NULL COMMENT '0 不显示，1 显示]',
`sort` INT NOT NULL COMMENT '排序',
`icon` CHAR(255) NOT NULL COMMENT '图标', 
`pro_unit` CHAR(50) NOT NULL COMMENT '统计单位', 
`pro_count` INT NOT NULL COMMENT '商品数量', 
PRIMARY KEY (`id`)
) CHARSET=utf8mb4 COMMENT='商品分类表';
SELECT * FROM commodity_category;

# 测试数据
# 第 1 组 家用电器
INSERT INTO
`commodity_category`(`id`,`name`,`parent_id`,`cat_level`,`is_show`,`sort`,`icon`,`pro_unit`,`pro_count`)
VALUES (1,'家用电器',0,1,1,0,'','',0);
INSERT INTO
`commodity_category`(`id`,`name`,`parent_id`,`cat_level`,`is_show`,`sort`,`icon`,`pro_unit`,`pro_count`)
VALUES (21,'大 家 电',1,2,1,0,'','',0);
INSERT INTO
`commodity_category`(`id`,`name`,`parent_id`,`cat_level`,`is_show`,`sort`,`icon`,`pro_unit`,`pro_count`)
VALUES (22,'厨卫大电',1,2,1,0,'','',0);
INSERT INTO
`commodity_category`(`id`,`name`,`parent_id`,`cat_level`,`is_show`,`sort`,`icon`,`pro_unit`,`pro_count`)
VALUES (201,'燃气灶',22,3,1,0,'','',0),(202,'油烟机',22,3,1,0,'','',0);
INSERT INTO
`commodity_category`(`id`,`name`,`parent_id`,`cat_level`,`is_show`,`sort`,`icon`,`pro_unit`,`pro_count`)
VALUES (301,'平板电视',21,3,1,0,'','',0);
# 第 2 组 家居家装
INSERT INTO
`commodity_category`(`id`,`name`,`parent_id`,`cat_level`,`is_show`,`sort`,`icon`,`pro_unit`,`pro_count`)
VALUES (2,'家居家装',0,1,1,0,'','',0);
INSERT INTO
`commodity_category`(`id`,`name`,`parent_id`,`cat_level`,`is_show`,`sort`,`icon`,`pro_unit`,`pro_count`)
VALUES (41,'家纺',2,2,1,0,'','',0);

INSERT INTO
`commodity_category`(`id`,`name`,`parent_id`,`cat_level`,`is_show`,`sort`,`icon`,`pro_unit`,`pro_count`)
VALUES (601,'桌布/罩件',41,3,1,0,'','',0);
INSERT INTO
`commodity_category`(`id`,`name`,`parent_id`,`cat_level`,`is_show`,`sort`,`icon`,`pro_unit`,`pro_count`)
VALUES (602,'地毯地垫',41,3,1,0,'','',0);
INSERT INTO
`commodity_category`(`id`,`name`,`parent_id`,`cat_level`,`is_show`,`sort`,`icon`,`pro_unit`,`pro_count`)
VALUES (42,'灯具',2,2,1,0,'','',0);
INSERT INTO `commodity_category`(`id`,`name`,`parent_id`,`cat_level`,`is_show`,`sort`,`icon`,`pro_unit`,`pro_count`)
VALUES (651,'台灯',42,3,1,0,'','',0);
INSERT INTO `commodity_category`(`id`,`name`,`parent_id`,`cat_level`,`is_show`,`sort`,`icon`,`pro_unit`,`pro_count`)
VALUES (659,'西瓜灯',42,3,1,0,'','',0);

SELECT * FROM `commodity_category`;

SELECT * FROM `commodity_category` WHERE `name` LIKE '%灯%';
# WHERE `name` LIKE '%%'; 相当于查询所有
SELECT * FROM `commodity_category` WHERE `name` LIKE '%%';




# COMMENT，它是用来添加对列或表的注释，方便开发者和其他人员理解该列或表的作用、规则或其他相关信息。
# 在你的语句中，'id' 这个注释提供了关于 id 列的额外说明，这在维护和理解数据库结构时可能会很有用。
## 家居品牌表
USE hspliving_commodity
CREATE TABLE `commodity_brand` (
id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id', 
`name` CHAR(50) COMMENT '品牌名',
logo VARCHAR(1200) COMMENT 'logo',
description LONGTEXT COMMENT '说明',
isShow TINYINT COMMENT '显示',
first_letter CHAR(1) COMMENT '检索首字母',
sort INT COMMENT '排序',
PRIMARY KEY (id)
)CHARSET=utf8mb4 COMMENT='家居品牌';

# 家居品牌
# sort 排序值, 有时很难确定，不管给什么 int 值,都不是很合适,这里给 null
# 家居品牌测试数据
INSERT INTO
`commodity_brand` (id,`name`, logo,description,isShow,first_letter,sort)
VALUES(1, '海信','','',1,'',NULL);
SELECT * FROM `commodity_brand`;




# 家居商品属性分组表
USE hspliving_commodity;
CREATE TABLE `commodity_attrgroup` (
id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id', 
`name` CHAR(20) COMMENT '组名', 
sort INT COMMENT '排序', 
description VARCHAR(255) COMMENT '说明',
icon VARCHAR(255) COMMENT '组图标', 
category_id BIGINT COMMENT '所属分类 id', 
PRIMARY KEY (id)
)CHARSET=utf8mb4 COMMENT='家居商品属性分组';

# 测试数据【后面我们通过管理系统来完成增删改查】, 我们的家居商品属性分组
#，是针对第三级家居分类的, 第一级和第二级没有商品属性分组信息
INSERT INTO
`commodity_attrgroup` (id,`name`, sort,description,icon,category_id)
VALUES(1, '主体',0,'主体说明','',301);
INSERT INTO
`commodity_attrgroup` (id,`name`, sort,description,icon,category_id)
VALUES(2, '规格',0,'规格说明','',301);
INSERT INTO
`commodity_attrgroup` (id,`name`, sort,description,icon,category_id)
VALUES(3, '功能',0,'功能说明','',301);
## 测试数据
SELECT * FROM `commodity_attrgroup`;

#SELECT id,icon,name,description,sort,category_id FROM commodity_attrgroup WHERE id=4















