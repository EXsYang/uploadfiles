# 演示流程控制语句

# IF(expr1,expr2,expr3) 如果expr1为true,则返回expr2 否则返回 expr3
SELECT IF(TRUE,'北京','上海') FROM DUAL;
SELECT IF(FALSE,'北京','上海') FROM DUAL;

#ifnull(expr1,expr2)	如果expr1不为空null,则返回expr1,否则返回expr2
SELECT IFNULL(NULL,'韩顺平') FROM DUAL; -- expr1满足条件为null 返回expr2
SELECT IFNULL('北京','韩顺平') FROM DUAL; -- expr1不满足条件 不为null 返回expr1

#select case when expr1 then expr2 when expr3 then expr4 else expr5 end;[类似多重分支] if...else if
# 如果expr1 为 true,则返回expr2,如果expr3 为true,返回expr4,否则返回 expr5

SELECT CASE
	WHEN TRUE THEN 'jack'
	WHEN TRUE THEN 'tom'   -- 只返回第一次判断为true 的值
	WHEN FALSE THEN 'rose'
	ELSE 'hsp' END;
	
-- 1. 查询emp表，如果 comm 是 null ,则显示0.0
-- 说明：判断是否为null 要使用is null, 不能使用 = 或 == ，判断不为空 is not null
SELECT ename,IF(comm IS NULL,0.0,comm)
	FROM emp;
SELECT ename,IFNULL(comm,0.0)
	FROM emp;

-- 2.如果emp 表的job 是 CLERK 则显示 职员，如果是MANAGER 则显示经理
--   如果是 SALESMAN 则显示 销售人员，其他正常显示
SELECT ename,job ,(SELECT CASE
	WHEN job = 'CLERK' THEN '职员'
	WHEN job ='MANAGER' THEN '经理'   -- 只返回第一次判断为true 的值
	WHEN job ='SALESMAN' THEN '销售人员'
	ELSE job END) AS 'job'
	FROM emp;




	




















