-- 创建furn表
-- 图片 	家居名 	商家 	价格 	销量 	库存 	操作 (修改，删除)
CREATE TABLE `furn`( 
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`product_name` VARCHAR(32) NOT NULL UNIQUE, 
`merchant_name` VARCHAR(32) NOT NULL DEFAULT '', -- 或者 business name
-- `price` int NOT NULL DEFAULT 0,
`price` DOUBLE NOT NULL DEFAULT 0.0,
`sales_volume` INT NOT NULL DEFAULT 0,
`inventory` INT NOT NULL DEFAULT 0,
-- `operate` tinyint 1:'修改操作',2:'删除操作' NOT NULL DEFAULT 1,	-- 有语法错误
`operate` TINYINT NOT NULL DEFAULT 0
-- `marker` VARCHAR(32) NOT NULL,
)CHARSET utf8 ENGINE INNODB;
-- CREATE TABLE t23 (
-- 	id INT PRIMARY KEY,
-- 	`name` VARCHAR(32) ,
-- 	sex VARCHAR(6) CHECK (sex IN('man','woman')),
-- 	sal DOUBLE CHECK ( sal > 1000 AND sal < 2000),
-- 	sal DOUBLE CHECK ( sal > 1000 OR sal < 2000),
-- );

INSERT INTO `furn`(`product_name`,`merchant_name`,`price`,`sales_volume`,`inventory`) 
VALUES('椅子','京东商城',100,30,1000); 

INSERT INTO `furn`(`product_name`,`merchant_name`,`price`,`sales_volume`,`inventory`) 
VALUES('桌子','阿里商城',134,5,300); 



 -- 创建家居表(表如何设计)
-- 设计furn表 家居表
 -- 老师说 需求-文档-界面 
 -- 技术细节
 -- 有时会看到 id int(11) ... 11 表示的显示宽度,存放的数据范围和int 配合zerofill
 --                int(2) .... 2 表示的显示宽度
 --                67890 => int(11) 00000067890		int(10) 无符号； int(11) 有符号
 --                67890 => int(2)  67890
 -- 创建表的时候，一定注意当前是DB
 -- 表如果是第一次写项目，表的字段可能会增加,修改，删除

CREATE TABLE `furn`(
`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, #id
`name` VARCHAR(64) NOT NULL, #家居名
`maker` VARCHAR(64) NOT NULL, #制造商
`price` DECIMAL(11,2) NOT NULL, #价格 定点数 价格使用decimal精度更高更好控制
`sales` INT UNSIGNED NOT NULL, #销量
`stock` INT UNSIGNED NOT NULL, #库存
`img_path` VARCHAR(256) NOT NULL #存放图片的路径
)CHARSET utf8 ENGINE INNODB;
-- 测试数据, 参考 家居购物-数据库设计.sql 
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`) 
VALUES(NULL , '北欧风格小桌子' , '熊猫家居' , 180 , 666 , 7 , 'assets/images/product-image/6.jpg');
 
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`) 
VALUES(NULL , '简约风格小椅子' , '熊猫家居' , 180 , 666 , 7 , 'assets/images/product-image/4.jpg');
 
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`) 
VALUES(NULL , '典雅风格小台灯' , '蚂蚁家居' , 180 , 666 , 7 , 'assets/images/product-image/14.jpg');
 
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`) 
VALUES(NULL , '温馨风格盆景架' , '蚂蚁家居' , 180 , 666 , 7 , 'assets/images/product-image/16.jpg');


INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`) 
VALUES(NULL , '13北欧风格小桌子' , '熊猫家居' , 180 , 666 , 7 , 'assets/images/product-image/6.jpg');
 
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`) 
VALUES(NULL , '14简约风格小椅子' , '熊猫家居' , 180 , 666 , 7 , 'assets/images/product-image/4.jpg');
 
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`) 
VALUES(NULL , '15典雅风格小台灯' , '蚂蚁家居' , 180 , 666 , 7 , 'assets/images/product-image/14.jpg');
 
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`) 
VALUES(NULL , '16温馨风格盆景架' , '蚂蚁家居' , 180 , 666 , 7 , 'assets/images/product-image/16.jpg');

SELECT * FROM furn
DELETE FROM `furn`;

DROP TABLE `furn`;

INSERT INTO furn( `name` , `maker` , `price` , `sales` , `stock`) 
VALUES( '简约风格小椅子' , '熊猫家居' , 180 , 666 , 7 );

-- Field 'name' doesn't have a default value
-- INSERT INTO furn(  `maker` , `price` , `sales` , `stock`) 
-- VALUES(  '熊猫家居' , 180 , 666 , 7 );


INSERT INTO furn( `name` , `maker` , `price` , `sales` , `stock`, `img_path`) 
VALUES( "jy小台灯", "杨达工程", 333, 3, 100, 'assets/images/product-image/4.jpg' );

DELETE FROM `furn`;
DROP TABLE `furn`;

SELECT * FROM furn WHERE  `name` ='简约风格小椅子' AND `maker` ='熊猫家居'  AND `price` =180 AND
 `sales` =666  AND `stock` =7 AND `img_path` ='assets/images/product-image/4.jpg' ;

SELECT `id`,`name`,`maker`,`price`,`sales`,`stock`,`img_path` AS `imgPath` FROM `furn`
SELECT `id`,`name`,`maker`,`price`,`sales`,`stock`,`img_path` `imgPath` FROM `furn` WHERE `id` = 101 # AS 可以省略
SELECT * FROM `furn` WHERE `id`=100;





SELECT * FROM furn WHERE  `name` ='简约风格小椅子' AND `maker` ='熊猫家居'  AND `price` =180 AND
 `sales` =666  AND `stock` =7 AND `img_path` `imgPath` ='assets/images/product-image/4.jpg'

-- 因为id没有限制非空 可以为null 执行更新语句时不会报错 只是受影响的行为0 
UPDATE `furn` SET `name`= '123',`maker` =1,`price`=1 ,`sales`=1,`stock`=1 WHERE `id` = NULL;
-- 更新不存在的id号   执行更新语句时不会报错 只是受影响的行为0 
UPDATE `furn` SET `name`= '123',`maker` =1,`price`=1 ,`sales`=1,`stock`=1 WHERE `id` = 0;

-- Out of range value for column 'stock' at row 1
-- 第1行“stock”列的值超出范围  
UPDATE `furn` SET `name`= '3典雅风格小台灯',`maker` ='蚂蚁家居',
`price`=180.00 ,`sales`=670,`stock`=-1, -- 第1行“stock”列的值超出范围 
# 因为创建表时设置了无符号 `stock` INT UNSIGNED NOT NULL, #库存 
`img_path` ='assets/images/product-image/14.jpg' WHERE `id` = 246;


UPDATE `furn` SET `name`=?,`maker` =?,`price`=?,`sales`=?,`stock`=? ,`img_path`=? WHERE `id` = ?
--  Parameters: [3典雅风格小台灯, 蚂蚁家居, 180.00, 674, -1, assets/images/product-image/14.jpg, 246]

-- delete 语句演示

-- 删除表中名称为`张三丰`的记录
DELETE FROM employee
	WHERE `user_name` = '张三丰';

-- 删除表中所有记录，提醒一定要小心
DELETE FROM employee;

-- Delete语句不能删除某一列的值（可使用update 设为 null 或者''）
UPDATE employee SET job = '' WHERE user_name = '杨达';
UPDATE employee SET job = NULL WHERE user_name = '杨达';
SELECT * FROM employee;

-- 要删除这个表
DROP TABLE employee;

DELETE FROM `furn` WHERE `id` = 37;


SELECT * FROM `furn` WHERE  `name` =? AND `maker` =? AND `price` =? AND" +
                " `sales` =?  AND `stock` =? AND `img_path` `imgPath` =?
 
SELECT * FROM furn WHERE `img_path` AS `q` = 'assets/images/product-image/4.jpg'

SELECT * FROM furn WHERE `price` AS `pre` = 60;

SELECT * FROM furn WHERE `price` AS `pre`;


SELECT COUNT(*) FROM `furn`;

-- 分页查询!!!
# LIMIT begin,size; begin从0开始 0对应第一条数据 size 每页的数据条数
# LIMIT start,rows; start+1开始取，取出rows行， start从0开始计算；
-- 推导出一个公式：LIMIT 每页显示的记录数 * (第几页 - 1),每页显示的记录数; 
 
 -- 第n页
-- 推导出一个公式：LIMIT 每页显示的记录数 * (第几页 - 1),每页显示的记录数; 
SELECT * FROM emp
	ORDER BY empno ASC
	LIMIT 每页显示的记录数 * (第几页 - 1),每页显示的记录数;


-- begin为负数时 查询会报错
SELECT * FROM `furn` 	
	LIMIT -1 , 3;
-- begin为0时 查询不会报错 因为begin 是从0开始的	
SELECT * FROM `furn` 	
	LIMIT 0 , 3;
-- 正常分页查询
SELECT * FROM `furn` 	
	LIMIT 3, 3;
# 当begin 大于等于 最后一条数据行数时 就取不到数据了
SELECT * FROM `furn` 	
	LIMIT 3333, 3;	
	
	
-- 	温馨风格盆景架
	
SELECT COUNT(*) FROM `furn` WHERE `name` = "简约风格小椅子";
 

SELECT `id`,`name`,`maker`,`price`,`sales`,`stock`,`img_path` `imgPath` FROM `furn` WHERE `name`= "简约风格小椅子" LIMIT 0, 3;	
	
SELECT `id`,`name`,`maker`,`price`,`sales`,`stock`,`img_path` `imgPath` FROM `furn` WHERE `name`= "温馨风格盆景架" LIMIT 0, 3;	
	
# 模糊查询 like
-- ■ 如何使用 like 操作符(模糊)
-- %: 表示 0 到多个任意字符 _: 表示单个任意字符
-- ?如何显示首字符为 S 的员工姓名和工资
SELECT ename, sal FROM emp
WHERE ename LIKE 'S%' -- ?如何显示第三个字符为大写 O 的所有员工的姓名和工资
SELECT ename, sal FROM emp
WHERE ename LIKE '__O%'

SELECT `id`,`name`,`maker`,`price`,`sales`,`stock`,`img_path` `imgPath` FROM `furn` WHERE `name` LIKE '%小椅子%' LIMIT 0, 3;	
	
SELECT COUNT(*) FROM `furn` WHERE `name` LIKE '%""%';	# 0
SELECT COUNT(*) FROM `furn` WHERE `name` LIKE '%%';	# 75 返回所有数据

SELECT * FROM `furn` WHERE `name` LIKE '%""%';	
SELECT * FROM `furn` WHERE `name` LIKE '%%';	
SELECT * FROM `furn` WHERE `name` LIKE "%小椅子%";

-- 删除表中所有记录，提醒一定要小心
DELETE FROM `furn` 	