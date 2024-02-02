-- 索引的类型
1. 主键索引，主键自动的为主索引（类型primary key）
2. 唯一索引（unique）
3. 普通索引（index）
4. 全文索引（fulltext）[适用于MySAM存储引擎]
   一般开发不使用MySQL自带的全文索引，而是使用：全文搜索Solr和ElasticSearch(ES)框架

CREATE TABLE t1(
	id INT PRIMARY KEY, -- 主键，同时也是索引，称为主键索引
	`name` VARCHAR(32));
CREATE TABLE t1(
	id INT UNIQUE, -- id是唯一的，同时也是索引，称为unique索引
	`name` VARCHAR(32));

-- 演示mysql的索引的使用
-- 创建索引
CREATE TABLE t27 (
	id INT,
	`name` VARCHAR(32));

-- 查询表是否有索引
SHOW INDEXES FROM t27;
-- Non_unique 为0 是唯一索引，为1 是普通索引
-- 添加索引
-- 添加唯一索引
CREATE UNIQUE INDEX id_index ON t27(id);
-- 添加普通索引
CREATE INDEX id_index ON t27(id)
-- 如何选择
-- 1. 如果某列的值，是不会重复的，则优先考虑使用unique索引，否则使用普通索引
-- 添加普通索引方式2
ALTER TABLE t27 ADD INDEX id_index(id);

-- 添加主键索引
CREATE TABLE t28 (
	id INT,
	`name` VARCHAR(32));
ALTER TABLE t28 ADD PRIMARY KEY(id);
SHOW INDEXES FROM t28;


-- 删除索引
DROP INDEX id_index ON t27;
-- 删除主键索引
ALTER TABLE t28 DROP PRIMARY KEY;

-- 修改索引，先删除，在添加新的索引

-- 查询索引(推荐前三种)
-- 方式1
SHOW INDEX FROM t27
-- 方式2
SHOW INDEXES FROM t27
-- 方式3
SHOW KEYS FROM t27

-- 方式4
DESC t27;



-- 主键索引 练习
CREATE TABLE `order1` (
	id INT PRIMARY KEY,
	`goods_name` VARCHAR(32),
	customer VARCHAR(32));

DROP TABLE `order`;

CREATE TABLE `order2` (
	id INT UNIQUE,
	`goods_name` VARCHAR(32),
	customer VARCHAR(32));

CREATE INDEX index_id ON `order2`(id);
SHOW INDEXES FROM `order2`
DROP INDEX index_id ON order2;
-- create primary key INDEX index_id ON `order2`(id); -- 这条语法不对
CREATE UNIQUE INDEX index_id ON `order2`(id);
-- drop unique index index_id on order2(id); 语法不对

-- 可以直接drop的只有普通索引，可以使用create索引的只有普通索引和唯一索引unique，修改表方式删除的只有主键方式
-- alter table order2 drop unique; 语法错误
ALTER TABLE order2 DROP PRIMARY KEY; -- 修改表方式删除的只有主键方式
DROP INDEX index_id ON order2; -- 该语句也可以删除唯一索引
ALTER TABLE order2 ADD UNIQUE(id); -- 给order2表id列添加unique索引，
				-- 默认和本列名相同,与创建表时直接指定unique一样
				-- 都是默认和本列名相同
DROP INDEX id ON order2;
CREATE UNIQUE INDEX index_id ON order2(id)
DROP INDEX index_id ON order2; -- 该语句也可以删除唯一索引
SHOW INDEXES FROM `order2`
DROP TABLE order2;


-- 小结：哪些列上适合使用索引
-- 1.较频繁的作为查询条件字段应该创建索引
-- select * from emp where empno = 1;
-- 2.唯一性太差的字段不适合单独创建索引，即使频繁作为查询条件
-- select * from emp where sex = '男';
-- 3.更新非常频繁的字段不适合创建索引
-- select * from emp where logincount = 1;
-- 4.不会出现在where子句中字段不该创建索引












