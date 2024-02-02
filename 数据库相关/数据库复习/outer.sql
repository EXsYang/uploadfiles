-- 外连接
-- 1. 左外连接（如果 左侧的表完全显示 我们就说是左外连接）
# 语法：select...from 表1 left join 表2 on 条件  -- 表1称为左表，表2称为右表
-- 2. 右外连接（如果 右侧的表完全显示 我们就说是右外连接）
# 语法：select...from 表1 right join 表2 on 条件


-- 比如：列出部门名称和这些部门的员工名称和工作，
-- 同时要求 显示出那些没有员工的部门

-- 使用我们学习过的多表查询的SQL，看看效果如何？

SELECT dname,ename,job      -- OPERATIONS部门没有显示出来
	FROM emp,dept
	WHERE emp.`deptno` = dept.`deptno`
	ORDER BY dname;

SELECT * FROM dept; 
SELECT * FROM emp; -- deptno 部门编号没有40

-- 创建 stu 表
CREATE TABLE stu (
	id INT,
	`name` VARCHAR(32));
INSERT INTO stu VALUES(1,'jack'),(2,'tom'),(3,'kity'),(4,'nono');
SELECT * FROM stu;

-- 创建exam 表
CREATE TABLE exam(
	id INT,
	grade INT);
INSERT INTO exam VALUES(1,56),(2,76),(11,8);
SELECT * FROM exam;

-- 使用左外连接
-- （显示所有人的成绩，如果没有成绩，
-- 也要显示该人的姓名和id号，成绩显示为空）

SELECT `name`,stu.id, grade
	FROM stu,exam
	WHERE stu.`id` = exam.`id`;

-- 改成左外连接
SELECT `name`,stu.id, grade
	FROM stu LEFT JOIN exam
	ON stu.`id` = exam.`id`;


-- 使用右外连接（显示所有成绩，如果没有名字匹配，显示空）
-- 即：右边的表(exam) 和左表没有匹配的记录，也会把右表的记录显示出来
SELECT `name`,stu.id,grade
	FROM stu RIGHT JOIN exam
	ON stu.`id` = exam.`id`;


-- 练习：列出部门名称和这些部门的员工信息(名字和工作)，同时列出那些没有员工的部门

SELECT * FROM emp;
SELECT * FROM dept;

-- 使用左外连接实现
SELECT dname,ename,job
	FROM dept LEFT JOIN emp
	ON emp.`deptno` = dept.`deptno`
	ORDER BY dname;

-- 使用右外连接实现
SELECT dname,ename,job
	FROM emp RIGHT JOIN dept
	ON emp.`deptno` = dept.`deptno`
	ORDER BY dname;














































