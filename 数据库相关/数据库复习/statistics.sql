# 演示mysql的统计函数的使用
-- 统计一个班级共有多少学生
SELECT COUNT(*) FROM student;

-- 统计数学成绩大于90的学生有多少个
SELECT COUNT(*) FROM student
	WHERE math > 90;

-- 统计总分大于250的人数有多少
SELECT COUNT(*) FROM student
	WHERE (math + chinese + english) > 250;

-- count(*) 和 count(列) 的区别
-- 解释：count(*) 返回满足条件的记录的行数
-- count(列)： 统计满足条件的某列，有多少个，但是会排除 为null

CREATE TABLE t15 ( 
	NAME VARCHAR(30));

INSERT INTO t15 VALUES('tom');	
INSERT INTO t15 VALUES('jack');		
INSERT INTO t15 VALUES('mary');		
INSERT INTO t15 VALUES(NULL);		
	
SELECT * FROM t15;

SELECT COUNT(*) FROM t15; -- 4
SELECT COUNT(`name`) FROM t15; -- 3



-- 演示sum函数的使用
-- 统计一个班级数学总成绩
SELECT SUM(math) FROM student;
-- 统计一个班级语文、英语、数学各科的总成绩
SELECT SUM(chinese) AS chinese_total_score,SUM(english),SUM(math) FROM student;

-- 统计一个班级语文、英语、数学的成绩成绩总和
SELECT SUM(chinese + english + math) FROM student;
-- 统计一个班级语文成绩平均分
SELECT SUM(chinese)/COUNT(*) FROM student;

-- 注意：sum 用在非数值型不会报错，但是没有意义
-- 对多列求和，“,”逗号不能少
SELECT SUM(chinese) AS chinese_total_score,SUM(english),SUM(math) FROM student;


-- 演示avg的使用
-- 求一个班级数学平均分
SELECT AVG(math) FROM student;
-- 求一个班级总分平均分
SELECT AVG(math + chinese + english) FROM student;


-- 演示 max 和 min 使用
-- 求班级最高分和最低分
SELECT MAX(math + chinese + english),MIN(math + chinese + english) 
	FROM student;

-- 求出班级数学的最高分和最低分
SELECT MAX(math) AS math_high_score,MIN(math) AS math_low_score FROM student;









	






















