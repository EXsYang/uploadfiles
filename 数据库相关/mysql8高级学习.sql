## MySQL高级学习


# 查看MySQL使用的字符集
SHOW VARIABLES LIKE '%char%';


#修改默认密码校验方式,使得低版本的SQLyog可以连接上mysql8
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '1234';
#执行以下 SQL 语句来查询指定用户的密码校验方式：
SELECT user, host, plugin FROM mysql.user WHERE user = 'root';

-- **Windows环境：**全部不区分大小写

-- **Linux环境：**

-- 1、数据库名、表名、表的别名、变量名严格【区分大小写】；

-- 2、列名与列的别名【不区分大小写】;

-- 3、关键字、函数名称【不区分大小写】；

SELECT User as us from USER as u where u.user = 'root';

-- 重点: ONLY_FULL_GROUP_BY     要求GROUP BY子句中的列必须出现在SELECT列表中，或者是聚合函数的参数，否则会抛出错误。

-- 默认设置: ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION 

SHOW VARIABLES LIKE 'sql_mode';



SET SESSION sql_mode = ''; -- 当前会话生效，关闭当前会话就不生效了。可以省略SESSION关键字

CREATE DATABASE atguigudb;
USE atguigudb;
CREATE TABLE employee(id INT, `name` VARCHAR(16),age INT,dept INT);
INSERT INTO employee VALUES(1,'zhang3',33,101);
INSERT INTO employee VALUES(2,'li4',34,101);
INSERT INTO employee VALUES(3,'wang5',34,102);
INSERT INTO employee VALUES(4,'zhao6',34,102);
INSERT INTO employee VALUES(5,'tian7',36,102);


SELECT * FROM `employee`;

-- 下面这个查询语句是正确的
SELECT dept,MAX(age) FROM `employee` GROUP BY dept;

-- 下面这个查询语句 当加了name字段后会报错，是错误的查询语句
-- 1055 - Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'atguigudb.employee.name' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

-- 1055-SELECT列表的表达式#1不在GROUP BY子句中，并且包含非聚合列“atguidb.employee.name”，该列在功能上不依赖于GROUP BY子句的列；这与sqlmode=only_full_group_by不兼容
SELECT `name`,dept,MAX(age) FROM `employee` GROUP BY dept;



-- 在 MySQL 中，聚合函数是用于执行计算在一组值上，并返回单一的值的函数。聚合函数通常用于 SELECT 语句中，与 GROUP BY 子句结合使用，用以汇总或聚合某列的数据。聚合函数忽略 NULL 值，只对非 NULL 值进行计算。 


-- 分组时，select 语句列名聚合函数（max min avg sum count），分组字段 name不能出现在select后面，因为SQL_MODE 包括 ONLY_FULL_GROUP_BY
-- 在 ONLY_FULL_GROUP_BY 模式下的限制，即在使用 GROUP BY 的时候，非聚合列（如此处的 name）不能出现在 SELECT 语句中，除非它们被包括在 GROUP BY 中。
--  尝试选择 name, dept, 和 max(age) 而没有将 name 包含在 GROUP BY 中。这在 ONLY_FULL_GROUP_BY 模式下会导致错误。
select name,dept,max(age) from employee
group by dept;


-- 设置 SQL 模式的命令 修改会话的 SQL 模式，去除所有默认模式，这样可以临时绕过 ONLY_FULL_GROUP_BY 的限制。
SET SESSION sql_mode = ''; -- 当前会话生效，关闭当前会话就不生效了。可以省略SESSION关键字

-- 去掉ONLY_FULL_GROUP_BY约束，下面这条语句才会查询出结果，name值不对。
-- 在 SQL 模式被修改后尝试执行同样的查询，此时不会报错，但是返回的 name 值可能不准确，因为没有对应的聚合约束。
select name,dept,max(age) as maxAge from employee group by dept;

-- 去掉ONLY_FULL_GROUP_BY约束, 下面这条语句才会查询出正确的结果。
-- 这里是对解决 ONLY_FULL_GROUP_BY 问题的一种正确做法的示例，首先通过子查询找到每个部门的最大年龄，然后通过内连接（INNER JOIN）根据部门和最大年龄来确保 name 的正确性。
select e.name,groupage.dept,groupage.maxAge
from (select dept,max(age) as maxAge from employee group by dept) as groupage
inner join employee e
on groupage.dept = e.dept and groupage.maxAge=e.age;


SET SESSION sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



#确认profiling是否开启 SQL的执行流程
SHOW VARIABLES LIKE '%profiling%';


SET profiling = 1;  -- profiling = ON


SELECT * FROM atguigudb.employee; 
SELECT * FROM atguigudb.employee WHERE id = 5; 


SHOW PROFILES;

#查看指定SQL的执行流程：查询指定的 Query ID
SHOW PROFILE FOR QUERY 31;


#查看查询缓存是否启用
SHOW VARIABLES LIKE '%query_cache_type%';


#查看MySQL提供什么存储引擎
SHOW ENGINES;



-- 测试事务-----------------------------------------------------------------------------
#innodb 存储引擎 1.默认存储引擎 2.支持事务 3.行级锁定 4.支持外键约束 5.支持崩溃恢复
create table goods_innodb(
	id int NOT NULL AUTO_INCREMENT,
	name varchar(20) NOT NULL,
    primary key(id)
)ENGINE=innodb DEFAULT CHARSET=utf8;

SELECT * FROM goods_innodb;

-- sql语句
start transaction;
insert into goods_innodb(id,name)values(null,'Meta20');
commit;
-- -----------------------------------------------------------------------------------



create table country_innodb(
	country_id int NOT NULL AUTO_INCREMENT,
    country_name varchar(100) NOT NULL,
    primary key(country_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


create table city_innodb(
	city_id int NOT NULL AUTO_INCREMENT,
    city_name varchar(50) NOT NULL,
    country_id int NOT NULL,
    primary key(city_id),
    CONSTRAINT `fk_city_country` FOREIGN KEY(country_id) REFERENCES country_innodb(country_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into country_innodb values(null,'China'),(null,'America'),(null,'Japan');
insert into city_innodb values(null,'Xian',1),(null,'NewYork',2),(null,'BeiJing',1);

SELECT * FROM `country_innodb`;
SELECT * FROM `city_innodb`;

show create table city_innodb ;

-- 执行结果如下:
-- CREATE TABLE `city_innodb` (
--   `city_id` int NOT NULL AUTO_INCREMENT,
--   `city_name` varchar(50) NOT NULL,
--   `country_id` int NOT NULL,
--   PRIMARY KEY (`city_id`),
--   KEY `fk_city_country` (`country_id`),
--   CONSTRAINT `fk_city_country` FOREIGN KEY (`country_id`) REFERENCES `country_innodb` (`country_id`) ON DELETE RESTRICT ON UPDATE CASCADE
-- ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3


#删除主表country_id为1 的country数据
delete from country_innodb where country_id = 1;
-- 解释 ON DELETE RESTRICT 
-- 因为在从表中设置了外键约束(注意外键约束是在从表中设置的)，ON DELETE RESTRICT 
-- 因此，主表的主键列(或者说被从表设置了外键关联的数据)还有被从表的列关联着呢，因此不可以随便删除主表的用来当作从表外键的数据，否则会报下面的错
-- 1451 - Cannot delete or update a parent row: a foreign key constraint fails (`atguigudb`.`city_innodb`, CONSTRAINT `fk_city_country` FOREIGN KEY (`country_id`) REFERENCES `country_innodb` (`country_id`) ON DELETE RESTRICT ON UPDATE CASCADE)


#更新主表country表的字段 country_id 
update country_innodb set country_id = 100 where country_id = 1;
-- 解释 ON UPDATE CASCADE
-- 因为在从表中设置了外键约束(注意外键约束是在从表中设置的)，ON UPDATE CASCADE
-- 因此，主表的主键列(或者说被从表设置了外键关联的数据)被从表的列关联着呢，
-- 因此更新主表的数据country_id = 1 改为country_id = 100,从表外键的数据也会级联/联动着一起更改为country_id = 100



-- 复习老韩讲解的外键演示start ------------------------------ 

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

-- 复习老韩讲解的外键演示 end ------------------------------ 

#innodb 存储引擎 1.默认存储引擎 2.支持事务 3.行级锁定 4.支持外键约束 5.支持崩溃恢复

#myisam 存储引擎 1.不支持事务 2.表级锁定 3.较低的存储空间占用
create table goods_myisam(
	id int NOT NULL AUTO_INCREMENT,
	name varchar(20) NOT NULL,
    primary key(id)
)ENGINE=myisam DEFAULT CHARSET=utf8;


start transaction;
insert into goods_myisam(name) values('zhangsan');
rollback;

#可见myisam 存储引擎 不支持事务


#MEMORY 存储引擎 1.数据存储在内存中 2.不支持持久化,数据库重启后数据会丢失。 3.表级锁定 4.适用于临时数据和缓存
-- 建表语句
CREATE TABLE goods_memory (
    id INT PRIMARY KEY,
    column1 VARCHAR(50),
    column2 INT
) ENGINE=MEMORY;

-- 测试数据存储在内存中
INSERT INTO goods_memory (id, column1, column2) VALUES (1, 'value1', 100);
SELECT * FROM goods_memory;

-- 重启mysql容器，数据丢失





































































































