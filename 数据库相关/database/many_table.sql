-- 多表查询
-- 在默认情况下：当两个表查询时，规则：
-- 1. 从第一张表中，取出一行 和第二张表的
-- 每一行进行组合，返回结果【含有两张表的所有列】
-- 2. 一共返回的记录数 第一张表行数*第二张表的行数
-- 3.这样多表查询默认处理返回的结果，称为笛卡尔集
-- 4.解决这个多表的关键就是要写出正确的过滤条件 
--   where,需要程序员进行分析

# 技巧：多表查询的条件不能少于 表的个数-1，否则出现笛卡尔集



-- 1. 显示雇员名，雇员工资及所在部门的名字 【笛卡尔集】
/*
	分析：
	1. 雇员名，雇员工资 来自 emp表
	2. 部门的名字 来着 dept表
	3. 需求对 emp 和 dept查询 ename,sal,dname,deptno	

*/

SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM emp,dept; -- 多表使用逗号进行分割

SELECT ename,sal,dname,emp.`deptno`
	FROM emp,dept
	WHERE emp.`deptno` = dept.`deptno`;

-- 2. 如何显示部门号为10的部门名、员工名和工资

SELECT dname,`ename`,sal,dept.`deptno` FROM emp,dept
	WHERE emp.deptno = dept.`deptno` AND dept.`deptno` = 10	

-- 3. 显示各个员工姓名，工资，及其工资的级别
SELECT * FROM emp;
SELECT * FROM salgrade;
SELECT * FROM emp,salgrade;
-- SELECT `ename`,sal,grade FROM emp,salgrade
-- 	WHERE ifnull(if(losal<= sal <=hisal,null,1),1)
SELECT `ename`,sal,grade FROM emp,salgrade
	WHERE sal BETWEEN losal AND hisal;

-- 显示雇员名，雇员工资及所在部门的名字，并按部门排序
SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM emp,dept;

SELECT ename,sal,dname,emp.deptno FROM emp,dept
	WHERE emp.deptno = dept.`deptno`
	ORDER BY emp.`deptno` ASC; -- 升序  order by放在where后面


SELECT deptno,AVG(sal) AS avg_sal
	FROM emp
	
	GROUP BY deptno	     -- 分组
	HAVING avg_sal > 1000
	
	ORDER BY avg_sal DESC -- 排序
	LIMIT 0,2;	      -- 分页










