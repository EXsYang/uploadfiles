-- homework03

-- ------1.选择部门30中的所有员工.
SELECT * FROM emp;
SELECT * FROM dept;

SELECT * FROM emp
	WHERE deptno = 30;
 
-- ------2.列出所有办事员(CLERK)的姓名，编号和部门编号. 
 SELECT ename,empno,deptno FROM emp
	WHERE job = "CLERK";
  SELECT ename,empno,deptno,job FROM emp
	WHERE job = 'CLERK'; -- 写这一个
-- ------3.找出佣金高于薪金的员工.
 SELECT * FROM emp
	WHERE IFNULL(comm,0) > sal; -- 如果comm 为null 返回0 ，not null 是多少返回多少
	
 
-- ------4.找出佣金高于薪金60%的员工.
 SELECT * FROM emp
	WHERE IFNULL(comm,0) > sal * 0.6;
 
-- ------5.找出部门10中所有经理(MANAGER)和部门20中所有办事员(CLERK)的详细资料.
 SELECT * FROM emp
	WHERE (deptno = 10 AND job = 'MANAGER') 
	OR (deptno = 20 AND job = 'CLERK');
--  SELECT * FROM emp
-- 	WHERE deptno = 10 AND job = 'MANAGER' OR (deptno = 20 AND job = 'CLERK');

SELECT * FROM dept;
SELECT deptno FROM emp
	GROUP BY deptno;
SELECT * FROM emp
	ORDER BY deptno;
	
-- ------6.找出部门10中所有经理(MANAGER),部门20中所有办事员(CLERK), 
 -- 还有既不是经理又不是办事员但其薪金大于或等于2000的所有员工的详细资料.
SELECT * FROM emp
	WHERE (deptno = 10 AND job = 'MANAGER')
	 OR (deptno = 20 AND job = 'CLERK')
	OR (job <> 'MANAGER' AND job <> 'CLERK' AND sal >= 2000)
	ORDER BY deptno
	
-- ------7.找出收取佣金的员工的不同工作.
 SELECT DISTINCT job FROM emp -- distinct 去重
	WHERE comm IS NOT NULL;
 
 
-- ------8.找出不收取佣金或收取的佣金低于100的员工.
 SELECT * 
	FROM emp
	WHERE comm IS NULL OR IFNULL(comm,0) < 100;
 
-- ------9.找出各月倒数第3天受雇的所有员工.
-- 老韩提示: last_day(日期)， 可以返回该日期所在月份的最后一天
-- last_day(日期) - 2 得到日期所有月份的倒数第3天
SELECT LAST_DAY(NOW()) - 2 FROM DUAL; 
SELECT *
	FROM emp
	WHERE LAST_DAY(hiredate) - 2 = hiredate;

-- ------10.找出早于12年前受雇的员工.（即： 入职时间超过12年）
 SELECT * 
	FROM emp
	WHERE DATE_ADD(hiredate,INTERVAL 12 YEAR) < NOW();

-- 
-- ------11.以首字母小写的方式显示所有员工的姓名.
 SELECT CONCAT(LCASE(SUBSTRING(ename,1,1)),SUBSTRING(ename,2))
	FROM emp;
 -- ------ 以首字母大写，其余字母小写方式显示所有员工的姓名.
SELECT CONCAT(UCASE(SUBSTRING(ename,1,1)),LCASE(SUBSTRING(ename,2)))
	FROM emp;
-- ------12.显示正好为5个字符的员工的姓名.
SELECT ename
	FROM emp
	WHERE LENGTH(ename) = 5; -- LENGTH 长度
 

-- ------13.显示不带有"R"的员工的姓名.
 SELECT ename
	FROM emp
	WHERE ename NOT LIKE '%R%'; -- % 不限个数任意字符（0个也包含），_ 一位任意字符
-- 模糊查询忽略大小写
 SELECT ename
	FROM emp
	WHERE ename LIKE '%r%';
 SELECT ename
	FROM emp
	WHERE ename LIKE '%r%';
-- windows正常模式也是忽略大小写 ,在linux下，mysql的表名区分大小写，而在windows下是不区分
-- 让MYSQL不区分表名大小写的方法其实很简单：　　1.用ROOT登录，修改/etc/my.cnf　
-- 2.在[mysqld]下加入一行：lower_case_table_names=1　　3.重新启动数据库即可。	
 SELECT ename
	FROM Emp
	WHERE ename = 'ForD';	
-- ------14.显示所有员工姓名的前三个字符.
SELECT LEFT(ename,3)
	FROM emp;
SELECT SUBSTRING(ename,1,3)
	FROM emp;
 
-- ------15.显示所有员工的姓名,用a替换所有"A"
SELECT REPLACE(ename,'A','a') -- ename中的A替换成a
	FROM emp;
	
 
-- ------16.显示满10年服务年限的员工的姓名和受雇日期.
 SELECT ename,hiredate
	FROM emp
	WHERE DATE_ADD(hiredate,INTERVAL 10 YEAR) <= NOW();
-- ------17.显示员工的详细资料,按姓名排序.
SELECT * FROM emp 
	ORDER BY ename;
-- ------18.显示员工的姓名和受雇日期,根据其服务年限,将最老的员工排在最前面.
SELECT ename,hiredate
	FROM emp
	ORDER BY hiredate;
 
-- ------19.显示所有员工的姓名、工作和薪金,按工作降序排序,若工作相同则按薪金排序.
 SELECT ename,job,sal
	FROM emp
	ORDER BY job DESC,sal;
 
-- ------20.显示所有员工的姓名、加入公司的年份和月份,按受雇日期所在月排序,
-- 若月份相同则将最早年份的员工排在最前面.
 SELECT ename,CONCAT(YEAR(hiredate),'-',MONTH(hiredate))
	FROM emp
	ORDER BY MONTH(hiredate),YEAR(hiredate);

-- ------21.显示在一个月为30天的情况所有员工的日薪金,忽略余数.
 SELECT ename,FLOOR(sal / 30),sal / 30  -- floor 直接取整数部分忽略余数.
	FROM emp;
 SELECT ename,ROUND(sal / 30),sal / 30  -- round 四舍五入
	FROM emp;

-- ------22.找出在(任何年份的)2月受聘的所有员工。
 SELECT * 
	FROM emp
	WHERE MONTH(hiredate) = 2;
-- ------23.对于每个员工,显示其加入公司的天数.
SELECT ename,DATEDIFF(NOW(),hiredate)
	FROM emp;
 
-- ------24.显示姓名字段的任何位置包含"A"的所有员工的姓名.
SELECT ename
	FROM emp
	WHERE ename LIKE '%A%';
 
-- ------25.以年月日的方式显示所有员工的服务年限.   (大概)

-- 思路 1. 先求出 工作了多少天 
SELECT ename,CONCAT(FLOOR(DATEDIFF(NOW(),hiredate) / 365),'-',
	FLOOR(DATEDIFF(NOW(),hiredate) % 365 / 30),'-',
	FLOOR(DATEDIFF(NOW(),hiredate) % 30))
	FROM emp;










 