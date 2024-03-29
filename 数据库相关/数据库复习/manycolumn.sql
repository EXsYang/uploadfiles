-- 多列子查询

-- 请思考如何查询与ALLEN的部门和岗位完全相同的所有雇员(并且不含allen本人)
-- (字段1,字段2...) = (select 字段1,字段2...from...)

-- 分析：1. 得到allen的部门和岗位

SELECT deptno,job FROM emp
	WHERE ename = 'ALLEN';
	
-- 分析：2. 把上面的查询当作子查询来使用，并且使用多列子查询的语法进行匹配

SELECT * FROM emp
	WHERE (deptno,job) = ( -- 多列子查询语法！！！
	-- SELECT job,deptno -- 写反了匹配不出来
	SELECT deptno,job
	FROM emp
	WHERE ename = 'ALLEN'
	) AND ename != 'ALLEN'













