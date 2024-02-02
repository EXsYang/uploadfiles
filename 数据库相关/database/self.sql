-- 多表查询的 自连接

-- 显示公司员工名字 在emp表 和他的上级的名字 在emp表

# 员工和上级是通过 emp表的mgr列关联

# 总结自连接特点：
-- 1. 把同一张表当作两张表使用
-- 2. 需要给表取别名 表明 表别名  ==》 这里不要用AS AS是给列取别名用的
-- 3. 列名不明确，可以指定列的别名 列名 as 列的别名




SELECT * FROM emp;
SELECT * FROM emp ,emp; -- 不取别名会报错
SELECT * FROM emp worker,emp boss; -- 取别名

SELECT worker.ename AS '雇员',boss.`ename` AS '上级'
	FROM emp worker,emp boss -- 取别名
	WHERE worker.mgr = boss.empno;

SELECT emp.ename AS '雇员',boss.`ename` AS '上级' -- emp.ename会报错
SELECT ename AS '雇员',boss.`ename` AS '上级' -- ename会报错 ambiguous不明确的

	FROM emp worker,emp boss -- 取别名
	WHERE worker.mgr = boss.empno;










