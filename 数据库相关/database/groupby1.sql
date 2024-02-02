-- 增强group by 的使用
# group by 用于对查询的结果分组统计
-- having子句用于限制分组显示结果

-- (1) 显示每种岗位的雇员总数、平均工资
SELECT COUNT(*),AVG(sal),job
	FROM emp
	GROUP BY job; -- group by 放在 from 后面
	

-- (2) 显示雇员总数，以及获得补助的雇员数
-- 思路：获得补助的雇员数 就是 comm 列为非null,就是count(列)，如果该列的值为null,
--       是不会统计，sql 非常灵活
SELECT COUNT(*),COUNT(comm)
	FROM emp

SELECT COUNT(*),(COUNT(*) - COUNT(IF(comm IS NULL,11,NULL))) AS '收到补助'
	FROM emp

-- 统计没有获得补助的雇员数
SELECT COUNT(*)-COUNT(comm) FROM emp;

SELECT COUNT(*),COUNT(IF(comm IS NULL,11,NULL)) FROM emp;

SELECT * FROM emp;
-- (3) 显示管理者的总人数  distinct 去重
SELECT COUNT(DISTINCT mgr) FROM emp;
	

-- (4) 显示雇员工资的最大差额
SELECT MAX(sal)-MIN(sal) FROM emp;

-- 统计各个部门 group by 的平均工资 avg，并且是大于1000的habing
-- 并且按照工资从高到低排列，order by 取出前两行记录 limit 0，2

SELECT deptno,AVG(sal) AS avg_sal  -- select>from>where>group by>having>order by
	FROM emp
	
	GROUP BY deptno	     -- 分组
	HAVING avg_sal > 1000
	
	ORDER BY avg_sal DESC -- 排序
	LIMIT 0,2;	      -- 分页
	




