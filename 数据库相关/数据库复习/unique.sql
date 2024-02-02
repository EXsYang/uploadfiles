-- 约束 not null(非空)
-- 如果在列上定义了not null,那么当插入数据时，必须为列提供数据
-- 语法：字段名 字段类型 not null

-- unique(唯一)
-- 当定义了唯一约束后，该列值是不能重复的
-- 字段名 字段类型 unique

CREATE TABLE t21
	(id INT UNIQUE,  -- 表示 id 列是不可以重复的
	`name` VARCHAR(32), 
	email VARCHAR(32)); 

INSERT INTO t21
	VALUES(1,'tom','tom@sohu.com'); 
UPDATE t21
	SET email = 'tom@sohu.com'
	WHERE id = 1;
INSERT INTO t21
	VALUES(1,'jack','jack@sohu.com');
	
SELECT * FROM t21;

-- unique 细节(注意)
-- 1. 如果没有指定 not null ,则 unique 字段可以有多个null
-- 如果一个列(字段)，是 unique not null 使用效果类似 primary key
INSERT INTO t21
	VALUES(NULL,'tom','tom@sohu.com');
SELECT * FROM t21;
-- 2. 一张表可以有多个 unique 字段
CREATE TABLE t22
	(id INT UNIQUE,  -- 表示 id 列是不可以重复的
	`name` VARCHAR(32) UNIQUE,  -- 表示 name 列是不可以重复的
	email VARCHAR(32)); 
DESC t22;














