#练习insert 语句
-- 创建一张商品表goods (id int,goods_name varchar(10),price double );
-- 添加两条记录
CREATE TABLE `goods` (
	id INT,
	`goods_name` VARCHAR(10),
	`price` DOUBLE);
-- 添加数据
INSERT INTO `goods` (id,`goods_name`,`price`)
	VALUES(1,'华为手机',3000);
INSERT INTO `goods` (id,`goods_name`,`price`)
	VALUES(2,'iphone',5000);
SELECT * FROM `goods`;

DESC employee;
INSERT INTO employee(id,user_name,birthday,entry_date,job,selary,`resume`,image)
	VALUES(1,'杨达','1998-3-27','2023-4-4 10:10:33','程序员',12000,'后端开发','img');
INSERT INTO employee(id,user_name,birthday,entry_date,job,selary,`resume`,image)
	VALUES(1,'张三丰','1955-3-27','2033-4-4 10:10:33','太极拳',12000,'拳师','img1');
SELECT * FROM employee;




