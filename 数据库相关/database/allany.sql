-- all 和 any的使用

-- 思考：显示工资比部门30的所有员工的工资高的员工的姓名、工资和部门号

SELECT ename,sal,deptno 
	FROM emp
	WHERE sal > ALL(
	SELECT sal 
		FROM emp
		WHERE deptno = 30)

SELECT ename,sal,deptno 
	FROM emp
	WHERE sal > (
	SELECT MAX(sal) 
		FROM emp
		WHERE deptno = 30)

-- 思考：如何显示工资比部门30的其中一个员工的工资高的员工的姓名、工资和部门号
SELECT ename,sal,deptno 
	FROM emp
	WHERE sal > ANY( -- 比其中一个高
	SELECT sal
		FROM emp
		WHERE deptno = 30)

SELECT ename,sal,deptno 
	FROM emp
	WHERE sal > (
	SELECT MIN(sal) 
		FROM emp
		WHERE deptno = 30)











		