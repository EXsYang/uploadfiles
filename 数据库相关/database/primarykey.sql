-- 主键使用

-- id name email
CREATE TABLE t17
	(id INT PRIMARY KEY, -- 表示id列是主键
	`name` VARCHAR(32),
	email VARCHAR(32));

-- 主键列的值不可以重复
INSERT INTO t17
	VALUES(1,'jack','jack@sohu.com');
INSERT INTO t17
	VALUES(2,'tom','tom@sohu.com');
INSERT INTO t17
	VALUES(1,'hsp','hsp@sohu.com'); -- Duplicate entry '1' for key 'PRIMARY'
SELECT * FROM t17;

-- 主键使用的细节讨论
-- primary key 不能重复而且不能为null.
INSERT INTO t17
	VALUES(NULL,'hsp','hsp@sohu.com'); -- Column 'id' cannot be null

-- 一张表最多只能有一个主键，但可以是复合主键(id + name)
CREATE TABLE t18
	(id INT PRIMARY KEY, -- 表示id列是主键
	`name` VARCHAR(32) PRIMARY KEY, -- 错误的
	email VARCHAR(32));
DROP TABLE t18;

CREATE TABLE t18
	(id INT , 
	`name` VARCHAR(32), 
	email VARCHAR(32),  -- 注意最后这里有个逗号
	PRIMARY KEY(id,`name`)); -- 注意，并不是两个主键，而是id和name同时相同才违反了主键约束

INSERT INTO t18
	VALUES(1,'tom','tom@sohu.com');
INSERT INTO t18
	VALUES(1,'jack','jack@sohu.com');
INSERT INTO t18
	VALUES(1,'tom','xxx@sohu.com'); -- Duplicate entry '1-tom' for key 'PRIMARY'
SELECT * FROM t18;
-- 逐渐的指定方式 有两种
-- (1)直接在字段名后指定：字段名 primary key 
-- (2)在表定义最后写 primary key(列名)
CREATE TABLE t19
	(id INT PRIMARY KEY, 
	`name` VARCHAR(32), 
	email VARCHAR(32)); -- 注意，并不是两个主键，而是id和name同时相同才违反了主键约束
CREATE TABLE t20
	(id INT , 
	`name` VARCHAR(32), 
	email VARCHAR(32),  -- 注意最后这里有个逗号
	PRIMARY KEY(id)); -- 注意，并不是两个主键，而是id和name同时相同才违反了主键约束

-- 使用 desc 表明，可以看到 primary key 的情况
DESC t19;
DESC t20;
DESC t18; -- 显示两个PRI,并不是两个主键，而是复合主键

# 开发中，每个表往往都会设计一个主键

























































