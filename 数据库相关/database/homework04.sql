

SELECT * FROM emp;
SELECT * FROM dept;

SELECT deptno FROM emp,dept;
字段列表中的列“deptno”不明确 ： 多表查询相同列名，需要指定是哪一个表

SELECT * ,emp.`deptno` FROM emp,dept;

-- count(*)和count(列)的区别：
-- count(*) 返回满足条件的记录的行数
-- count(列) 返回满足条件的某列有多少个，但是会排除 为null

SELECT COUNT(*) AS a -- 返回
	FROM emp;
SELECT COUNT(mgr) AS b -- 返回非空的mgr有多少行
	FROM emp;
-- (1)．列出至少有一个员工的所有部门

/*
	先查出各个部门有多少人
	使用 having 子句过滤
*/	
SELECT COUNT(*) AS c,deptno 
	FROM emp
	GROUP BY deptno
	HAVING c >= 1;
SELECT COUNT(*)
	FROM emp
	GROUP BY deptno
-- (2)．列出薪金比“SMITH”多的所有员工。
/*
	先查出 smith 的 sal => 作为子查询
	然后其他员工 sal 大于 smith 即可
*/
SELECT * FROM emp;
SELECT * 
	FROM emp
	WHERE sal > (SELECT sal 
			FROM emp
			WHERE ename = "SMITH"
	)


-- (3)．列出受雇日期晚于其直接上级的所有员工。
/*
	先把 emp 表 当做两张表 worker , leader
	条件 1. worker.hiredate > leader.hiredate
	     2. worker.mgr = leader.empno
*/
SELECT worker.ename AS '员工名',worker.hiredate AS '员工入职时间',
	leader.ename AS '上级名',leader.hiredate AS '上级入职时间'
	FROM emp worker ,emp leader
	WHERE worker.hiredate > leader.hiredate
	AND worker.mgr = leader.empno;

-- (4)．列出部门名称和这些部门的员工信息，同时列出那些没有员工的部门。
/*
	这里因为需要显示所有部门，因此考虑使用外连接，(左外连接)
	如果没有印象了，去看看老师讲的外连接.
*/
SELECT ename, * FROM emp RIGHT JOIN dept 
	ON emp.`deptno` = dept.`deptno`;
	
SELECT emp.*, dname  FROM emp RIGHT JOIN dept  -- 这里要写emp.* ,直接写* 报错
	ON emp.`deptno` = dept.`deptno`;

SELECT dname,ename FROM emp RIGHT JOIN dept 
	ON emp.`deptno` = dept.`deptno`;
SELECT dname,ename FROM dept LEFT JOIN emp -- 左外连接，左侧的表完全显示
	ON emp.`deptno` = dept.`deptno`; -- ON 后面写条件，相当于where
-- (5)．列出所有“CLERK”（办事员）的姓名及其部门名称。
SELECT * FROM emp;
SELECT * FROM dept;
SELECT ename,job,dname
	FROM emp,dept
	WHERE job = 'CLERK' AND emp.`deptno` = dept.`deptno`;


-- (6)．列出最低薪金大于1500的各种工作job。

/*
	查询各个部门的最低工资
	使用having 子句进行过滤
*/

SELECT MIN(sal) AS min_sal,job FROM emp	
	GROUP BY job
	HAVING min_sal > 1500
	
	
SELECT MIN(sal) min_sal,dname
	FROM emp,dept
	WHERE dept.`deptno` = emp.`deptno`
	GROUP BY dname
	HAVING min_sal > 1000 -- 所有人工资大于1000的部门，即最低工资大于1000
SELECT *
	FROM emp,dept
	WHERE dept.`deptno` = emp.`deptno`;


-- (7)．列出在部门“SALES”（销售部）工作的员工的姓名。
SELECT ename ,dname -- 老师写的
	FROM emp ,dept
	WHERE emp.`deptno` = dept.`deptno` AND dname = 'SALES';
	
SELECT ename ,deptno FROM emp -- 自己写的
	WHERE (SELECT deptno FROM dept 
			WHERE dname = 'SALES') = deptno



-- (8)．列出薪金高于公司平均薪金的所有员工。
SELECT ename,sal FROM emp
	WHERE (SELECT AVG(sal) FROM emp) < sal

-- (9)．列出与“SCOTT”从事相同工作的所有员工。
SELECT * FROM emp
	WHERE job = (SELECT job 
		FROM emp
		WHERE ename = 'SCOTT'
		) AND ename != 'SCOTT';

-- (10)．列出薪金高于所在部门30的工作的所有员工的薪金的员工姓名和薪金。
-- 先查询出30部门的最高工资
SELECT ename,sal FROM emp
	WHERE sal > ( 
		SELECT MAX(sal)
			FROM emp
			WHERE deptno = 30
	 )
				



-- (11)．列出在每个部门工作的员工数量、平均工资和平均服务期限(时间单位)。
-- 老师建议 ， 写sql 也是一步一步完成的
SELECT COUNT(*) AS "部门员工数量",deptno,AVG(sal) AS "部门平均工资",
	FORMAT(AVG(DATEDIFF(NOW(),hiredate) / 365),2)  AS "部门平均服务年限" -- FORMAT(data,2) 保留小数点两位
	FROM emp
	GROUP BY deptno

-- (12)．列出所有员工的姓名、部门名称和工资。
SELECT * FROM dept
-- 就是 emp 和 dept 联合查询 ，连接条件就是 emp.deptno = dept.deptno
SELECT ename,dname,sal 
	FROM emp,dept
	WHERE emp.`deptno` = dept.`deptno`



-- (13)．列出所有部门的详细信息和部门人数。

-- 1. 先得到各个部门人数 , 把下面的结果看成临时表 和 dept表联合查询
SELECT * 
	FROM dept,(
			SELECT COUNT(*) AS c,deptno
				FROM emp
				GROUP BY deptno 
			) AS temp

SELECT dept.* ,temp.c
	FROM dept,(
			SELECT COUNT(*) AS c,deptno
				FROM emp
				GROUP BY deptno 
			) AS temp

-- (14)．列出各种工作的最低工资。
SELECT MIN(sal),job
	FROM emp
	GROUP BY job

-- (15)．列出MANAGER（经理）的最低薪金。
SELECT MIN(sal),job
	FROM emp
	GROUP BY job
	HAVING job = "MANAGER"

SELECT MIN(sal),job
	FROM emp
	WHERE job = "MANAGER"

-- (16)．列出所有员工的年工资,按年薪从低到高排序。
SELECT * FROM emp

SELECT (sal + IFNULL(comm,0)) * 12 AS year_sal,ename -- 如果comm 为null 返回0 ，not null 是多少返回多少
	FROM emp
	ORDER BY year_sal

-- 1. 先得到员工的年工资
	
-- 技术就窗户纸 

	




 
