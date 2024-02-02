# 子查询练习

-- 1. 查找每个部门工资高于本部门平均工资的人的资料
-- 这里要用到数据查询小技巧，把一个子查询当作一个临时表使用

SELECT * FROM emp;

-- 每个 * deptno sal > 本部门平均工资 
SELECT deptno,AVG(sal) AS `avga sal` FROM emp -- 这种写法是正规的
	GROUP BY deptno; 
SELECT deptno,AVG(sal) AS "avg_sal" FROM emp -- 双引号 单引号都可以 别名加不加as 都行
	GROUP BY deptno;
SELECT deptno,AVG(sal) AS 'avga sal' FROM emp
	GROUP BY deptno;

SELECT ename,sal,temp.`avg_sal`,emp.deptno -- sal这样写可以，因为子查询中取了别名
	FROM emp,(SELECT deptno,AVG(sal) AS `avg_sal`
		FROM emp
		GROUP BY deptno) temp
	WHERE sal > temp.`avg_sal` AND emp.deptno = temp.deptno
	-- group by empno

-- 2. 查找每个部门工资最高的人的详细资料
SELECT deptno,MAX(sal) FROM emp
	GROUP BY deptno

SELECT *
	FROM (SELECT deptno,MAX(sal) AS `max_sal` FROM emp
	GROUP BY deptno
	) temp,emp	
	WHERE emp.`deptno` = temp.deptno AND emp.sal = temp.`max_sal`;

-- 查询每个部门的信息（包括：部门名，编号，地址）和人员数量
-- 1. 部门名，编号，地址 dept表
-- 2. 各个部门的人员数量 -> 构建一个临时表
SELECT * FROM dept;
SELECT * FROM emp;

SELECT deptno,COUNT(*) 
	FROM emp
	GROUP BY deptno;
	
SELECT dname,dept.`deptno`,loc,temp.per_num AS '人数'
	FROM dept,(SELECT deptno,COUNT(*) AS per_num
	FROM emp
	GROUP BY deptno
	) temp
	WHERE temp.deptno = dept.`deptno`;
	
-- 还有一种写法 表.* 表示将该表所有列都显示出来，可以简化sql语句
-- 在多表查询中，当多个表的列不重复时，才可以直接写列名
SELECT temp.*,dname,loc
	FROM dept,(SELECT deptno,COUNT(*) AS per_num
	FROM emp
	GROUP BY deptno
	) temp
	WHERE temp.deptno = dept.`deptno`
	
	

























