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


-- MySQL索引入门

-- 上传课程资料中的tb_sku*.sql脚本到linux服务器中, /var/lib/docker/volumes/mysql8_data/_data/sku_sql

-- 在MySQL服务器的配置文件（my.cnf或my.ini）中，添加以下配置项：
[mysqld]
local_infile=1

-- 使用mysql客户端连接mysql
mysql --local-infile=1 -u root -p

-- 进入到mysql中的，执行如下命令导入数据
use atguigudb ;

-- 根据课程资料中提供的建表语句创建数据库表

-- 使用load data命令导入数据
load data local infile '/var/lib/mysql/sku_sql/tb_sku1.sql' into table `tb_sku` fields terminated by ',' lines terminated by '\n';
load data local infile '/var/lib/mysql/sku_sql/tb_sku2.sql' into table `tb_sku` fields terminated by ',' lines terminated by '\n';
load data local infile '/var/lib/mysql/sku_sql/tb_sku3.sql' into table `tb_sku` fields terminated by ',' lines terminated by '\n';
load data local infile '/var/lib/mysql/sku_sql/tb_sku4.sql' into table `tb_sku` fields terminated by ',' lines terminated by '\n';
load data local infile '/var/lib/mysql/sku_sql/tb_sku5.sql' into table `tb_sku` fields terminated by ',' lines terminated by '\n';

-- 不创建索引进行查询
mysql> select * from tb_sku where name = '华为Meta1000' ;
1 row in set (17.04 sec)

-- 创建索引进行查询
create index idx_sku_name on tb_sku(name) ;  -- 为name字段创建索引
mysql> select * from tb_sku where name = '华为Meta1000' ;
1 row in set (0.00 sec)



-- 随表一起创建索引：
CREATE TABLE customer (
    
  id INT UNSIGNED AUTO_INCREMENT,
  customer_no VARCHAR(200),
  customer_name VARCHAR(200),
    
  PRIMARY KEY(id), -- 主键索引：列设定为主键后会自动建立索引，唯一且不能为空。
  UNIQUE INDEX uk_no (customer_no), -- 唯一索引：索引列值必须唯一，允许有NULL值，且NULL可能会出现多次。
  KEY idx_name (customer_name), -- 普通索引：既不是主键，列值也不需要唯一，单纯的为了提高查询速度而创建。
  KEY idx_no_name (customer_no,customer_name) -- 复合索引：即一个索引包含多个列。
);




-- 单独建创索引：
CREATE TABLE customer1 (
  id INT UNSIGNED,
  customer_no VARCHAR(200),
  customer_name VARCHAR(200)
);

-- 建表后创建索引
ALTER TABLE customer1 ADD PRIMARY KEY customer1(id); -- 主键索引
CREATE UNIQUE INDEX uk_no ON customer1(customer_no); -- 唯一索引
CREATE INDEX idx_name ON customer1(customer_name);  -- 普通索引
CREATE INDEX idx_no_name ON customer1(customer_no,customer_name); -- 复合索引

ALTER TABLE customer1 MODIFY id INT UNSIGNED AUTO_INCREMENT, ADD PRIMARY KEY customer1(id); -- 创建自增的主键索引

-- 使用ALTER命令：
ALTER TABLE customer1 ADD PRIMARY KEY (id); -- 主键索引
ALTER TABLE customer1 ADD UNIQUE INDEX uk_no (customer_no); -- 唯一索引
ALTER TABLE customer1 ADD INDEX idx_name (customer_name);   -- 普通索引
ALTER TABLE customer1 ADD INDEX idx_no_name (customer_no,customer_name);  -- 复合索引


#查看索引
SHOW INDEX FROM customer;

#删除索引
DROP INDEX idx_name ON customer; -- 删除单值、唯一、复合索引

ALTER TABLE customer MODIFY id INT UNSIGNED, DROP PRIMARY KEY; -- 删除主键索引(有主键自增)
#上面这条语句做了两件事：
#1.修改列定义：MODIFY id INT UNSIGNED 修改了 id 列，只指定了它是 INT UNSIGNED 类型。由于没有包含 AUTO_INCREMENT 关键字，所以原来列上的 AUTO_INCREMENT 属性将被移除。这就是为什么 AUTO_INCREMENT 被去除的原因。
#2.删除主键索引：DROP PRIMARY KEY 从表中删除主键索引。这通常需要做，因为主键索引是一种约束，它要求值唯一且非空。删除主键索引通常会影响表的性能和数据完整性检查。
#注意点
#1.在实际操作中，如果 id 列是表的唯一主键并且设置了 AUTO_INCREMENT，直接修改列定义通常会引起错误，因为 AUTO_INCREMENT 属性依赖于列是主键的事实。如果确实需要移除 AUTO_INCREMENT 属性，通常需要先移除或修改主键约束。
#2.删除带有 AUTO_INCREMENT 的主键前，确保理解这将如何影响数据的插入。去掉 AUTO_INCREMENT 后，必须手动管理 id 列的值，否则可能导致插入冲突或其他数据完整性问题。
#

ALTER TABLE customer1 DROP PRIMARY KEY;  -- 删除主键索引(没有主键自增)


### MODIFY 和 AUTO_INCREMENT

#如果你的 `ALTER TABLE` 语句使用了 `MODIFY` 关键字来更改一个列，并且在 `MODIFY` 子句中没有明确包括 `AUTO_INCREMENT` 属性，那么即使原来的列定义中包含了 `AUTO_INCREMENT`，这个属性也不会被保留。换句话说，你需要在 `MODIFY` 子句中显式指定所有希望保留的属性。

#例如，如果原来的列定义是这样的：
id INT UNSIGNED AUTO_INCREMENT

#并且你执行了以下修改：
ALTER TABLE customer MODIFY id INT UNSIGNED;

#这里的 `MODIFY` 子句没有包括 `AUTO_INCREMENT`，所以即使没有明确删除，`AUTO_INCREMENT` 属性也会被移除。
#正确的修改方式
#如果你想保持 `AUTO_INCREMENT` 属性，你应该这样写：

ALTER TABLE customer MODIFY id INT UNSIGNED AUTO_INCREMENT;

#这样，`id` 列就会继续保有 `AUTO_INCREMENT` 属性。如果你不包括 `AUTO_INCREMENT`，那么这个属性就会从列定义中去除。
#结论
#所以，如果你的意图是修改列的其他属性（比如从 `SIGNED` 变为 `UNSIGNED`）而保留 `AUTO_INCREMENT`，你必须在 `MODIFY` 语句中明确指出 `AUTO_INCREMENT`。



#性能分析（EXPLAIN）
#语法: EXPLAIN + SQL语句


USE atguigudb;
 
CREATE TABLE t1(id INT(10) AUTO_INCREMENT, content VARCHAR(100) NULL, PRIMARY KEY (id));
CREATE TABLE t2(id INT(10) AUTO_INCREMENT, content VARCHAR(100) NULL, PRIMARY KEY (id));
CREATE TABLE t3(id INT(10) AUTO_INCREMENT, content VARCHAR(100) NULL, PRIMARY KEY (id));
CREATE TABLE t4(id INT(10) AUTO_INCREMENT, content1 VARCHAR(100) NULL, content2 VARCHAR(100) NULL, PRIMARY KEY (id));

CREATE INDEX idx_content1 ON t4(content1);  -- 创建普通索引

# 以下新增sql多执行几次，以便演示
INSERT INTO t1(content) VALUES(CONCAT('t1_',FLOOR(1+RAND()*1000)));
INSERT INTO t2(content) VALUES(CONCAT('t2_',FLOOR(1+RAND()*1000)));
INSERT INTO t3(content) VALUES(CONCAT('t3_',FLOOR(1+RAND()*1000)));
INSERT INTO t4(content1, content2) VALUES(CONCAT('t4_',FLOOR(1+RAND()*1000)), CONCAT('t4_',FLOOR(1+RAND()*1000)));


EXPLAIN SELECT * FROM t1;

#下面这个查询相当于下面的内连接查询，对MySQL来说性能是一样的!!!
EXPLAIN SELECT * FROM t1, t2 WHERE t1.id = t2.id;
#内连接查询
EXPLAIN SELECT * FROM t1 INNER JOIN t2 ON t1.id = t2.id;


EXPLAIN SELECT * FROM t1, t2, t3;


EXPLAIN SELECT t1.id FROM t1 WHERE t1.id =(
  SELECT t2.id FROM t2 WHERE t2.id =(
    SELECT t3.id FROM t3 WHERE t3.content = 't3_914'
  )
);


EXPLAIN SELECT * FROM t1 WHERE content IN (SELECT content FROM t2 WHERE content = 'a');


EXPLAIN SELECT * FROM t1 UNION SELECT * FROM t2;


EXPLAIN SELECT * FROM t1 UNION ALL SELECT * FROM t2;

#小结：
-- id如果相同，可以认为是一组，`从上往下顺序执行`
-- 在所有组中，`id值越大，越先执行`
-- 关注点：每个id号码，表示一次独立的查询, `一个sql的查询趟数越少越好`

EXPLAIN SELECT * FROM t1;

EXPLAIN SELECT * FROM t3 WHERE id = ( SELECT id FROM t2 WHERE content= 'a');

# DEPENDENT SUBQUREY：**如果包含了子查询，并且，查询语句不能被优化器转换为连接查询，
#并且，子查询是**相关子查询（子查询基于外部数据列）**，则子查询就是DEPENDENT SUBQUREY。
EXPLAIN SELECT * FROM t3 WHERE id = ( SELECT id FROM t2 WHERE content = t3.content);

EXPLAIN SELECT * FROM t3 WHERE id = ( SELECT id FROM t2 WHERE content = @@character_set_server);

EXPLAIN 
SELECT * FROM t3 WHERE id = 1 
UNION  -- union 两张表的合并，默认会去重，会产生临时表 
SELECT * FROM t2 WHERE id = 1;


EXPLAIN 
SELECT * FROM t3 WHERE id = 1 
UNION ALL -- union all 两张表的合并，默认不会去重，不会产生临时表，因此性能会比union高一点
SELECT * FROM t2 WHERE id = 1;


 EXPLAIN SELECT * FROM t1 WHERE content IN
 (
 SELECT content FROM t2 
 UNION 
 SELECT content FROM t3
 );



EXPLAIN SELECT * FROM (
   SELECT content, COUNT(*) AS c FROM t1 GROUP BY content
) AS derived_t1 WHERE c > 1;


EXPLAIN SELECT * FROM t1;


EXPLAIN SELECT content1 FROM t4;

EXPLAIN SELECT id FROM t1;

EXPLAIN SELECT * FROM t1 WHERE id > 2;


EXPLAIN SELECT * FROM t4 WHERE content1 = 'a';


EXPLAIN SELECT * FROM t1, t2 WHERE t1.id = t2.id;
EXPLAIN SELECT * FROM t1 inner join t2 on t1.id = t2.id;



CREATE TABLE t(i int) Engine=MyISAM;
INSERT INTO t VALUES(1);
EXPLAIN SELECT * FROM t;

EXPLAIN SELECT id FROM t1 WHERE id = 1;




CREATE TABLE `t_emp` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `empno` INT NOT NULL ,					-- 可以使用随机数字，或者从1开始的自增数字，不允许重复
  `name` VARCHAR(20) DEFAULT NULL,  		-- 随机生成，允许姓名重复 20 * 4 + 2 + 1= 83
  `age` INT(3) DEFAULT NULL,				-- 区间随机数  4 + 1
  `deptId` INT(11) DEFAULT NULL,			-- 1-1w之间随机数
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1;

-- 创建索引
CREATE INDEX idx_age_name ON t_emp(age, `name`);

-- 测试1
EXPLAIN SELECT * FROM t_emp WHERE age = 30 AND `name` = 'ab%';

-- 测试2
EXPLAIN SELECT * FROM t_emp WHERE age = 30;
#计算 key_len：
#age 字段：
#age 是一个 INT 类型，它通常占用4个字节。
#由于 age 字段允许为空，根据你的说明，允许为空的字段要额外加1个字节。
#因此，对于 age 字段，key_len 应该是 4 (字节 for INT) + 1 (为空标志位) = 5 字节。


EXPLAIN SELECT * FROM t4 WHERE content1 = 'a';


EXPLAIN SELECT * FROM t1, t2 WHERE t1.id = t2.id;

-- 如果是全表扫描，rows的值就是表中数据的估计行数
EXPLAIN SELECT * FROM t_emp WHERE empno = '100001';

-- 如果是使用索引查询，rows的值就是预计扫描索引记录行数
EXPLAIN SELECT * FROM t_emp WHERE deptId = 1;


EXPLAIN SELECT * FROM t_emp WHERE 1 != 1;

# Extra = Using where：使用了where，但在where上有字段没有创建索引。也可以理解为如果数据从引擎层被返回到server层进行过滤，那么就是Using where。
EXPLAIN SELECT * FROM t_emp WHERE name = '风清扬';

EXPLAIN SELECT * FROM t1 ORDER BY id;

EXPLAIN SELECT * FROM t1 ORDER BY content; -- content 字段不是索引字段,即ORDER BY 排序没有用上索引

# Extra = Using index  使用了覆盖索引
EXPLAIN SELECT id, content1 FROM t4;


-- content1列上有索引idx_content1
EXPLAIN SELECT * FROM t4 WHERE content1 > 'z' AND content1 LIKE '%a';



# MySQL索引失效场景 数据准备
CREATE TABLE `dept` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `deptName` VARCHAR(30) DEFAULT NULL,		-- 随机字符串，允许重复
  `address` VARCHAR(40) DEFAULT NULL,		-- 随机字符串，允许重复
  ceo INT NULL ,							-- 1-50w之间的任意数字
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1;

CREATE TABLE `emp` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `empno` INT NOT NULL ,					-- 可以使用随机数字，或者从1开始的自增数字，不允许重复
  `name` VARCHAR(20) DEFAULT NULL,  		-- 随机生成，允许姓名重复
  `age` INT(3) DEFAULT NULL,				-- 区间随机数
  `deptId` INT(11) DEFAULT NULL,			-- 1-1w之间随机数
  PRIMARY KEY (`id`)
  #CONSTRAINT `fk_dept_id` FOREIGN KEY (`deptId`) REFERENCES `t_dept` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1;


#自定义生成随机数的函数：
SELECT RAND(); 				-- 返回一个0到1之间的随机浮点数
SELECT FLOOR(RAND() * 10); 	-- 返回一个0到9之间的随机整数
SELECT UUID(); 				-- 返回一个随机的唯一标识符

-- 查看mysql是否允许创建函数：
SHOW VARIABLES LIKE 'log_bin_trust_function_creators';
SET GLOBAL log_bin_trust_function_creators=1; 				-- 命令开启：允许创建函数设置：（global-所有session都生效）

-- 随机产生字符串
DELIMITER $$  -- 将分隔符设置为"$$"，以便在自定义函数中使用多个语句。
CREATE FUNCTION rand_string(n INT) RETURNS VARCHAR(255)  -- n表示的随机字符串的长度 
BEGIN    
  DECLARE chars_str VARCHAR(100) DEFAULT 'abcdefghijklmnopqrstuvwxyzABCDEFJHIJKLMNOPQRSTUVWXYZ';
  DECLARE return_str VARCHAR(255) DEFAULT '';
  DECLARE i INT DEFAULT 0;
  WHILE i < n DO  
    SET return_str = CONCAT(return_str,SUBSTRING(chars_str,FLOOR(1+RAND()*52),1));  
    SET i = i + 1;
  END WHILE;
  RETURN return_str;
END $$

-- 假如要删除
-- drop function rand_string;


-- 用于随机产生区间数字
DELIMITER $$
CREATE FUNCTION rand_num (from_num INT ,to_num INT) RETURNS INT(11)
BEGIN   
 DECLARE i INT DEFAULT 0;  
 SET i = FLOOR(from_num +RAND()*(to_num - from_num + 1));
RETURN i;  
END$$

-- 假如要删除
-- drop function rand_num;



#创建存储过程
-- 插入员工数据
DELIMITER $$			-- 将分隔符设置为"$$"，以便在存储过程中使用多个语句。
CREATE PROCEDURE insert_emp(START INT, max_num INT)
BEGIN  
  DECLARE i INT DEFAULT 0;   
  SET autocommit = 0;   -- 将自动提交事务的选项设置为0，即关闭自动提交。
  REPEAT  				-- REPEAT ... END REPEAT; ：开始一个循环，循环结束条件是`i = max_num`，每次循环`i`递增1。
    SET i = i + 1;  
    INSERT INTO emp (empno, NAME, age, deptid ) VALUES ((START+i) ,rand_string(6), rand_num(30,50), rand_num(1,10000));  
    UNTIL i = max_num  
  END REPEAT;  
  COMMIT;  
END$$
 
-- 删除
-- drop PROCEDURE insert_emp;


-- 插入部门数据
DELIMITER $$
CREATE PROCEDURE insert_dept(max_num INT)
BEGIN  
  DECLARE i INT DEFAULT 0;   
  SET autocommit = 0;    
  REPEAT  
    SET i = i + 1;  
    INSERT INTO dept ( deptname,address,ceo ) VALUES (rand_string(8),rand_string(10),rand_num(1,500000));  
    UNTIL i = max_num  
  END REPEAT;  
  COMMIT;  
END$$
 
-- 删除
-- DELIMITER ;
-- drop PROCEDURE insert_dept;

#调用存储过程
-- 执行存储过程，往dept表添加1万条数据
CALL insert_dept(10000); 

-- 执行存储过程，往emp表添加50万条数据，编号从100000开始
CALL insert_emp(100000,500000); 

-- 显示sql语句执行时间
SET profiling = 1; -- profiling=0 代表关闭，我们需要把 profiling 打开，即设置为 1：
SHOW VARIABLES  LIKE '%profiling%';
SHOW PROFILES;


#单表索引失效案例
-- 创建索引
CREATE INDEX idx_name ON emp(`name`);

show index from emp;

-- 显示查询分析		
#1. 计算、函数导致索引失效
EXPLAIN SELECT * FROM emp WHERE emp.name  LIKE 'abc%';
EXPLAIN SELECT * FROM emp WHERE LEFT(emp.name,3) = 'abc'; -- 索引失效

#2. LIKE以%开头索引失效
EXPLAIN SELECT * FROM emp WHERE name LIKE 'ab%'; -- 使用上了索引
EXPLAIN SELECT * FROM emp WHERE name LIKE '%ab'; -- 索引失效
EXPLAIN SELECT * FROM emp WHERE name LIKE '%ab%'; -- 索引失效

#3. 不等于(!= 或者<>)索引失效
EXPLAIN SELECT * FROM emp WHERE emp.name = 'abc' ;
EXPLAIN SELECT * FROM emp WHERE emp.name <> 'abc' ; -- 索引失效

#4. IS NOT NULL 和 IS NULL
EXPLAIN SELECT * FROM emp WHERE emp.name IS NULL;
EXPLAIN SELECT * FROM emp WHERE emp.name IS NOT NULL; -- 索引失效
#注意： 当数据库中的数据的**索引列的NULL值达到比较高的比例的时候**，即使在IS NOT NULL 的情况下 MySQL的查询优化器会选择使用索引，此时**type的值是range（范围查询）**
-- 将 id>20000 的数据的 name 值改为 NULL
UPDATE emp SET `name` = NULL WHERE `id` > 20000;

-- 执行查询分析，可以发现 IS NOT NULL 使用了索引
-- 具体多少条记录的值为NULL可以使索引在IS NOT NULL的情况下生效，由查询优化器的算法决定
EXPLAIN SELECT * FROM emp WHERE emp.name IS NOT NULL;


UPDATE emp SET `name` = rand_string(6) WHERE `id` > 20000;


#5. 类型转换导致索引失效
EXPLAIN SELECT * FROM emp WHERE name='123'; 
EXPLAIN SELECT * FROM emp WHERE name= 123; -- 索引失效

#6. 全索引匹配效率最高

-- 删除之前在emp表上的创建的索引
drop index idx_name on emp ;

-- 查询分析
EXPLAIN SELECT * FROM emp WHERE emp.age = 30 and deptid = 4 AND emp.name = 'abcd';
-- 执行SQL
SELECT * FROM emp WHERE emp.age = 30 and deptid = 4 AND emp.name = 'abcd';
-- 查看执行时间
SHOW PROFILES;


-- 创建索引：分别创建以下三种索引的一种，并分别进行以上查询分析
CREATE INDEX idx_age ON emp(age);
CREATE INDEX idx_age_deptid ON emp(age,deptid);
CREATE INDEX idx_age_deptid_name ON emp(age,deptid,`name`);

#最高效的查询应用了联合索引idx_age_deptid_name

#7. 违背了最佳左前缀法则

-- 首先删除之前创建的索引
drop index idx_age ON emp ;
drop index idx_age_deptid ON emp ;
drop index idx_age_deptid_name ON emp ;

-- 创建索引
CREATE INDEX idx_age_deptid_name ON emp(age,deptid,`name`);

EXPLAIN SELECT * FROM emp WHERE emp.age=30 AND emp.name = 'abcd' ;
-- EXPLAIN结果：
-- key_len：5 只使用了age索引
-- 索引查找的顺序为 age、deptid、name，查询条件中不包含deptid，无法使用deptid和name索引

EXPLAIN SELECT * FROM emp WHERE emp.deptid=1 AND emp.name = 'abcd';
-- EXPLAIN结果：
-- type： ALL， 执行了全表扫描
-- key_len： NULL， 索引失效
-- 索引查找的顺序为 age、deptid、name，查询条件中不包含age，无法使用整个索引

EXPLAIN SELECT * FROM emp WHERE emp.age = 30 AND emp.deptid=1 AND emp.name = 'abcd';
-- EXPLAIN结果：
-- 索引查找的顺序为 age、deptid、name，匹配所有索引字段

EXPLAIN SELECT * FROM emp WHERE emp.deptid=1 AND emp.name = 'abcd' AND emp.age = 30;
-- EXPLAIN结果：
-- 索引查找的顺序为 age、deptid、name，匹配所有索引字段


#8. 索引中范围条件右边的列失效
-- 首先删除之前创建的索引
drop index idx_age_deptid_name ON emp ;

EXPLAIN SELECT * FROM emp WHERE emp.age=30 AND emp.deptId > 1000 AND emp.name = 'abc'; 


-- 创建索引并执行以上SQL语句的EXPLAIN
CREATE INDEX idx_age_deptid_name ON emp(age,deptid,`name`);
-- key_len：10， 只是用了 age 和 deptid索引，name失效

-- 创建索引并执行以上SQL语句的EXPLAIN（将deptid索引的放在最后）
CREATE INDEX idx_age_name_deptid ON emp(age,`name`,deptid);
-- 使用了完整的索引















#MySQL关联查询优化
-- 分类
CREATE TABLE IF NOT EXISTS `class` (
`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`card` INT(10) UNSIGNED NOT NULL,
PRIMARY KEY (`id`)
);
-- 图书
CREATE TABLE IF NOT EXISTS `book` (
`bookid` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`card` INT(10) UNSIGNED NOT NULL,
PRIMARY KEY (`bookid`)
);
 
-- 插入16条记录
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
 
-- 插入20条记录
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));


#测试左外连接，在那张表上创建索引性能最高 驱动表和被驱动表，结论，在右表/大表/被驱动表 创建索引效率最高
EXPLAIN SELECT * FROM class LEFT JOIN book ON class.card = book.card;
-- 左表class：驱动表、右表book：被驱动表

-- 创建索引
CREATE INDEX idx_class_card ON class(card);


-- 首先删除之前创建的索引
drop index idx_class_card on class ;

-- 创建索引
CREATE INDEX idx_book_card ON book(card);


-- 已经有了book索引
CREATE INDEX idx_class_card ON class(card);

-- 结论：针对两张表的连接条件涉及的列，索引要创建在被驱动表上，驱动表尽量是小表
-- 
-- **左连接的左表就是驱动表，左连接的右表就是被驱动表**
-- 
-- **左连接的左表放小表，左连接的右表放大表**
-- 
-- **并在左连接的被驱动表上创建索引，效率是最高的**



#测试内连接时，在那张表创建索引性能最高
-- 换成inner join
EXPLAIN SELECT * FROM class INNER JOIN book ON class.card=book.card;

-- 交换class和book的位置
EXPLAIN SELECT * FROM book INNER JOIN class ON class.card=book.card;

-- **都有索引的情况下：** 查询优化器自动选择数据量小的表做为驱动表 


-- 
-- **结论：** 
-- 
-- 1、发现即使交换表的位置，MySQL优化器也会自动选择驱动表。
-- 
-- 2、自动选择驱动表的原则是：索引创建在被驱动表上，驱动表是小表。 








#查询方式选择
use atguigudb;

CREATE TABLE `t_dept` (
 `id` INT NOT NULL AUTO_INCREMENT,
 `deptName` VARCHAR(30) DEFAULT NULL,
 `address` VARCHAR(40) DEFAULT NULL,
 PRIMARY KEY (`id`)
);
 
CREATE TABLE `t_emp` (
 `id` INT NOT NULL AUTO_INCREMENT,
 `name` VARCHAR(20) DEFAULT NULL,
 `age` INT DEFAULT NULL,
 `deptId` INT DEFAULT NULL,
`empno` INT NOT NULL,
 PRIMARY KEY (`id`),
 KEY `idx_dept_id` (`deptId`)
 #CONSTRAINT `fk_dept_id` FOREIGN KEY (`deptId`) REFERENCES `t_dept` (`id`)
);

INSERT INTO t_dept(id,deptName,address) VALUES(1,'华山','华山');
INSERT INTO t_dept(id,deptName,address) VALUES(2,'丐帮','洛阳');
INSERT INTO t_dept(id,deptName,address) VALUES(3,'峨眉','峨眉山');
INSERT INTO t_dept(id,deptName,address) VALUES(4,'武当','武当山');
INSERT INTO t_dept(id,deptName,address) VALUES(5,'明教','光明顶');
INSERT INTO t_dept(id,deptName,address) VALUES(6,'少林','少林寺');

INSERT INTO t_emp(id,NAME,age,deptId,empno) VALUES(1,'风清扬',90,1,100001);
INSERT INTO t_emp(id,NAME,age,deptId,empno) VALUES(2,'岳不群',50,1,100002);
INSERT INTO t_emp(id,NAME,age,deptId,empno) VALUES(3,'令狐冲',24,1,100003);

INSERT INTO t_emp(id,NAME,age,deptId,empno) VALUES(4,'洪七公',70,2,100004);
INSERT INTO t_emp(id,NAME,age,deptId,empno) VALUES(5,'乔峰',35,2,100005);

INSERT INTO t_emp(id,NAME,age,deptId,empno) VALUES(6,'灭绝师太',70,3,100006);
INSERT INTO t_emp(id,NAME,age,deptId,empno) VALUES(7,'周芷若',20,3,100007);

INSERT INTO t_emp(id,NAME,age,deptId,empno) VALUES(8,'张三丰',100,4,100008);
INSERT INTO t_emp(id,NAME,age,deptId,empno) VALUES(9,'张无忌',25,5,100009);
INSERT INTO t_emp(id,NAME,age,deptId,empno) VALUES(10,'韦小宝',18,NULL,100010);

-- 给t_dept表添加ceo字段，该字段的值为t_emp表的id
ALTER TABLE t_dept ADD CEO INT(11);
UPDATE t_dept SET CEO=2 WHERE id=1;
UPDATE t_dept SET CEO=4 WHERE id=2;
UPDATE t_dept SET CEO=6 WHERE id=3;
UPDATE t_dept SET CEO=8 WHERE id=4;
UPDATE t_dept SET CEO=9 WHERE id=5;

SELECT * FROM t_emp ;

SELECT * FROM t_dept ;
-- 需求：查询每一个人物所对应的掌门人名称
-- **方式一：**三表左连接方式
-- 员工表(t_emp)、部门表(t_dept)、ceo(t_emp)表 关联查询
EXPLAIN SELECT emp.name, ceo.name AS ceoname 
FROM t_emp emp
LEFT JOIN t_dept dept ON emp.deptid = dept.id 
LEFT JOIN t_emp ceo ON dept.ceo = ceo.id; -- 这里用的是ceo表的ceo.id 主键索引 
#关联条件中只要有一个是主键就可以,就会用到主键索引
-- **ref=atguigu.dept.CEO**   关联查询时出现，ceo表和dept表的哪一列进行关联
-- 一趟查询，用到了主键索引，**效果最佳**

-- t_dept.CEO 创建索引
CREATE INDEX idx_dept ON t_dept(CEO);

show index from t_dept;

#删除索引
drop index idx_dept on t_dept;


-- 查看执行时间
SHOW PROFILES;

select * from t_emp;

select * from t_dept;

-- **方式二**：子查询方式
explain SELECT 
emp.name, 
(SELECT ceo.name FROM t_emp ceo WHERE ceo.id = dept.ceo) AS ceoname
FROM t_emp emp
LEFT JOIN t_dept dept ON emp.deptid = dept.id;
-- 两趟查询，用到了主键索引，跟第一种比，效果稍微差点。



-- **方式三：**临时表连接方式1
EXPLAIN SELECT emp_with_ceo_id.name, emp.name AS ceoname FROM 
-- 查询所有员工及对应的ceo的id
( 
SELECT emp.name, dept.ceo 
FROM t_emp emp 
LEFT JOIN t_dept dept ON emp.deptid = dept.id 
) emp_with_ceo_id
LEFT JOIN t_emp emp ON emp_with_ceo_id.ceo = emp.id;
-- 查询一趟，**MySQL查询优化器将衍生表查询转换成了连接表查询**，速度堪比第一种方式


-- **方式三：**临时表连接方式2
explain SELECT emp.name, ceo.ceoname FROM t_emp emp LEFT JOIN
( 
SELECT emp.deptId AS deptId, emp.name AS ceoname 
FROM t_emp emp 
INNER JOIN t_dept dept ON emp.id = dept.ceo 
) ceo
ON emp.deptId = ceo.deptId;

-- 查询并创建临时表ceo：包含ceo的部门id和ceo的name
-- 查询一趟，MySQL查询优化器将衍生表查询转换成了连接表查询，但是只有一个表使用了索引，数据检索的次数稍多，性能最差。
-- **总结**：**能够直接多表关联的尽量直接关联(即左连接)，不用子查询。(减少查询的趟数)**



#MySQL子查询优化

-- 需求：查询非掌门人的信息

-- **方式一：*
-- 查询员工，这些员工的id没在（掌门人id列表中）
-- 【查询不是CEO的员工】
explain SELECT * FROM t_emp emp WHERE emp.id NOT IN 
(SELECT dept.ceo FROM t_dept dept WHERE dept.ceo IS NOT NULL);

-- **方式二：**
-- 推荐
explain SELECT emp.* FROM t_emp emp LEFT JOIN t_dept dept ON emp.id = dept.ceo WHERE dept.id IS NULL;
-- **结论：** 尽量不要使用NOT IN 或者 NOT EXISTS，用LEFT JOIN xxx ON xx = xx WHERE xx IS NULL替代 



#MySQL排序优化
-- 排序索引失效情况
-- 1. 无过滤不索引

-- 删除emp表中的所有的索引
-- 创建新的索引结构
CREATE INDEX idx_age_deptid_name ON emp (age,deptid,`name`);

-- 没有使用索引：
EXPLAIN SELECT * FROM emp ORDER BY age,deptid;

-- 使用了索引：order by想使用索引，必须有过滤条件，索引才能生效，limit也可以看作是过滤条件
EXPLAIN SELECT * FROM emp ORDER BY age,deptid LIMIT 10; 


-- 2. 顺序错不索引

-- 排序使用了索引：
-- 注意：key_len = 5是where语句使用age索引的标记，order by语句使用索引不在key_len中体现。
-- order by语句如果没有使用索引，在extra中会出现using filesort。                  
EXPLAIN SELECT * FROM emp WHERE age=45 ORDER BY deptid;

-- 排序使用了索引：
EXPLAIN SELECT * FROM emp WHERE age=45 ORDER BY deptid, `name`; 

-- 过滤where用上了索引age,排序没用上索引，empno不在联合索引上，索引只有一种排序
-- 第1个字段排序，结果相同的情况下再按照第2个字段排序，结果相同的情况下再按照第3个字段排序
-- 又因为索引树只有一种排序，(age,deptid,`name`) ，empno 不在这个索引树上
-- 按照empno字段在排序就用不上这个索引树了，如果再按照`empno`字段进行排序，和索引
-- (age,deptid,`name`)的顺序不一样，所以这里 ORDER BY  就没有用上索引排序
EXPLAIN SELECT * FROM emp WHERE age=45 ORDER BY deptid, empno;

-- 排序没有使用索引， 顺序错不索引 (age,deptid,`name`), 因为排序的顺序是(age,deptid,`name`) 
-- 而不能是(age,`name`,deptid) 
EXPLAIN SELECT * FROM emp WHERE age=45 ORDER BY `name`, deptid;

-- 排序没有使用索引：出现的顺序要和复合索引中的列的顺序一致！   -----> 排序在条件过滤之后进行执行，条件过滤没有遵循最左前缀法则 (age,deptid,`name`) ,下面这个没有用上`age`
EXPLAIN SELECT * FROM emp WHERE deptid=45 ORDER BY age;

-- 3. 排序反不索引
-- 排序使用了索引：排序条件和索引一致，并方向相同，可以使用索引
EXPLAIN SELECT * FROM emp WHERE age=45 ORDER BY deptid DESC, `name` DESC;

-- 排序使用了索引
EXPLAIN SELECT * FROM emp WHERE age=45 ORDER BY deptid ASC, `name` DESC;


#索引优化案例。 排序优化的目的是，去掉 Extra 中的 using filesort

-- 删除emp表中之前所创建的所有的索引
-- 这个例子结合 show profiles; 查看运行时间
SET profiling = 1;

-- **需求：** 查询 年龄为30岁的，且员工编号小于101000的用户，按用户名称排序 
-- **测试1：** 很显然，type 是 ALL，即最坏的情况。Extra 里还出现了 Using filesort,也是最坏的情况。优化是必须的。
-- sql演示：
-- 查询 年龄为30岁的，且员工编号小于101000的用户，按用户名称排序 
explain select * from t_emp emp where emp.age = 30 and emp.empno < 101000 order BY emp.`name` ;

-- **duration**	持续时间；期间  /djuˈreɪʃn/


-- **优化思路：** 尽量让where的过滤条件和排序使用上索引
-- **step1：** 我们建一个三个字段的组合索引可否?
CREATE INDEX idx_age_empno_name ON t_emp (age,empno,`name`);
-- 最后的name索引没有用到，出现了Using filesort。原因是，因为empno是一个范围过滤
-- ，所以索引后面的字段不会再使用索引了。所以我们建一个3值索引是没有意义的。



-- **step2：** 那么我们先删掉这个索引：

DROP INDEX idx_age_empno_name ON t_emp;

-- 为了去掉filesort我们可以把索引建成，也就是说empno 和name这个两个字段我只能二选其一。即范围条件和排序条件两个都有索引时，二选一，只有一个会生效

CREATE INDEX idx_age_name ON t_emp(age,`name`);

-- 这样我们优化掉了 using filesort。但是经过测试，性能反而下降

-- **step3：**如果我们选择那个范围过滤，而放弃排序上的索引呢? 


DROP INDEX idx_age_name ON t_emp;
CREATE INDEX idx_age_empno ON t_emp(age,empno);
-- 执行原始的sql语句，查看性能，结果竟然有 filesort的 sql 运行速度，超过了已经优化掉 filesort的 sql，何故？
-- 
-- **原因：** 所有的**排序都是在条件过滤之后才执行的**，所以，如果条件过滤掉大部分数据的话，剩下几百几千条数据进行排序其实并不是很消耗性能，即使索引优化了排序，但实际提升性能很有限。  相对的**empno < 101000** 这个条件，如果没有用到索引的话，要对几万条的数据进行扫描，这是非常消耗性能的，所以索引放在这个字段上性价比最高，是最优选择。
-- 
-- **结论：** 
-- 当【范围条件】和【group by 或者 order by】的字段出现二选一时，
-- **优先观察条件字段的过滤数量，如果过滤的数据足够多，
-- 而需要排序的数据并不多时，优先把索引放在范围字段上**。
-- 也可以将选择权交给MySQL：索引同时存在，mysql自动选择最优的方案：
-- （对于这个例子，mysql选择idx_age_empno），
-- 但是，随着数据量的变化，选择的索引也会随之变化的。



## 双路排序和单路排序

-- 如果排序没有使用索引，引起了filesort，那么filesort有两种算法

#1、双路排序

#2、单路排序




# 6 MySQL分组优化

-- 1、group by 使用索引的原则几乎跟order by一致。但是**group by 即使没有过滤条件用到索引
-- ，也可以直接使用索引**（Order By 必须有过滤条件才能使用上索引）
-- 
-- 2、包含了order by、group by、distinct这些查询的语句，where条件过滤出来的结果集请保持在1000行以内，否则SQL会很慢。
-- 


# 7 覆盖索引优化

-- 1、禁止使用select *，禁止查询与业务无关字段
-- 
-- 2、尽量利用覆盖索引

