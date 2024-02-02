-- 外键演示

-- 创建主表 my_class
CREATE TABLE my_class (
	id INT PRIMARY KEY , -- 班级编号
	`name` VARCHAR(32) NOT NULL DEFAULT '');

-- 创建 从表 my_stu
CREATE TABLE my_stu (
	id INT PRIMARY KEY , -- 学生编号
	`name` VARCHAR(32) NOT NULL DEFAULT '',
	class_id INT, -- 学生所在班级的编号
	-- 下面指定外键关系
	FOREIGN KEY(class_id) REFERENCES my_class(id));

-- 测试数据
INSERT INTO my_class
	VALUES(100,'java'),(200,'web'),(300,'php');
INSERT INTO my_class
	VALUES(NULL,'python'); -- 主键是非空唯一约束 Column 'id' cannot be null

SELECT * FROM my_class;


INSERT INTO my_stu
	VALUES(1,'tom',100);
INSERT INTO my_stu
	VALUES(2,'jack',200);
INSERT INTO my_stu
	VALUES(3,'hsp',300);
INSERT INTO my_stu
	VALUES(4,'mary',400);  -- 这里会失败，因为400班级不存在
	
INSERT INTO my_stu
	VALUES(5, 'king', NULL); -- 可以, 外键 没有写 not null

SELECT * FROM my_stu;
SELECT * FROM my_class; -- 一旦建立主外键的关系，数据不能随意删除了

DELETE FROM my_class
	WHERE id = 100;	
	
DELETE FROM my_stu
	WHERE id = 1;	

SELECT * FROM my_stu;	

-- foreign key(外键) 细节：
-- 1.外键指向的表的字段，要求是primary key 或者是unique(唯一)
-- 2.表的存储引擎类型是innodb,这样的表才支持外键
-- 3.外键字段的类型要和主键字段的类型一致(长度可以不同)
-- 4.外键字段的值，必须在主键字段中出现过，或者从表中添加的数据为null[前提是从表中外键字段允许为null]
-- 5.一旦建立主外键的关系，数据不能随意删除，除非从表(设置外键的表)中的数据，
-- 没有指向主表数据（一个也没有），主表中的数据才可以删除





























