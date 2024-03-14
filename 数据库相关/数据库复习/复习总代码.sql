#演示整形范围
#使用tinyint 来演示范围 有符号-128 ~ 127 如果没有符号 0 ~ 255
# 说明：表的字符集，校验规则，存储引擎，使用默认
#1. 如果没有指定 unsigned ,则TINYINT就是有符号
#2. 如果指定 unsigned ,则TINYINT 就是无符号 0 ~ 255

CREATE TABLE t4 (
	id TINYINT );  
	
DROP TABLE t5;

CREATE TABLE t5 (
	id TINYINT UNSIGNED );

INSERT INTO t4 VALUES(128);

INSERT INTO t5 VALUES(0);

SELECT * FROM t5;

-- 表类型和存储引擎

-- 查看所有的存储引擎
SHOW ENGINES
-- innodb 存储引擎，是前面使用过.
-- 1. 支持事务 2. 支持外键 3. 支持行级锁

-- myisam 存储引擎
CREATE TABLE t28 (
	id INT,
	`name` VARCHAR(32)) ENGINE MYISAM
-- 1. 添加速度快 2. 不支持外键和事务 3. 支持表级锁

START TRANSACTION;
SAVEPOINT t1
INSERT INTO t28 VALUES(1, 'jack');
SELECT * FROM t28;
ROLLBACK TO t1

-- memory 存储引擎
-- 1. 数据存储在内存中[关闭了Mysql服务，数据丢失, 但是表结构还在] 
-- 2. 执行速度很快(没有IO读写) 3. 默认支持索引(hash表)

CREATE TABLE t29 (
	id INT,
	`name` VARCHAR(32)) ENGINE MEMORY
DESC t29
INSERT INTO t29
	VALUES(1,'tom'), (2,'jack'), (3, 'hsp');
SELECT * FROM t29

-- 指令修改存储引擎
ALTER TABLE `t29` ENGINE = INNODB


-- 视图的使用
-- 创建一个视图emp_view01,只能查询emp表的(empno、ename, job 和 deptno ) 信息

-- 创建视图
CREATE VIEW emp_view01
	AS
	SELECT empno,ename,job,deptno
	FROM emp;

SELECT * FROM emp;



-- 查看视图
DESC emp_view01;
SELECT * FROM emp_view01;
SELECT empno,job FROM emp_view01;

-- 查看创建视图的指令
SHOW CREATE VIEW emp_view01;

-- 删除视图
DROP VIEW emp_view01;

-- 视图的细节

-- 1. 创建视图后，到数据库去看，对应视图只有一个视图结构文件(形式: 视图名.frm) 
-- 2. 视图的数据变化会影响到基表，基表的数据变化也会影响到视图[insert update delete ]

-- 修改视图 会影响到基表

UPDATE emp_view01
	SET job = 'MANAGER'
	WHERE empno = 7369;

SELECT * FROM emp; -- 查询基表

SELECT * FROM emp_view01;

-- 修改基本表， 会影响到视图

UPDATE emp
	SET job = 'SALESMAN'
	WHERE empno = 7369;

-- 3. 视图中可以再使用视图 , 比如从emp_view01 视图中，选出empno,和ename做出新视图
DESC emp_view01;

CREATE VIEW emp_02
	AS
	`emp_view01``emp_02`SELECT empno,ename FROM emp_view01;

SELECT * FROM emp_02;


-- 视图的课堂练习
-- 针对 emp ，dept , 和   salgrade 张三表.创建一个视图 emp_view03，
-- 可以显示雇员编号，雇员名，雇员部门名称和 薪水级别[即使用三张表，构建一个视图]

/*
	分析: 使用三表联合查询，得到结果
	将得到的结果，构建成视图
	  
*/

SELECT * FROM emp;

SELECT * FROM dept;

SELECT * FROM salgrade;

CREATE VIEW emp_view03
	AS
	SELECT empno, ename, dname, grade 
	FROM emp,dept,salgrade
	WHERE emp.`deptno` = dept.`deptno` AND
	 (emp.`sal` BETWEEN salgrade.`losal` AND salgrade.hisal);

CREATE VIEW emp_view04 -- Duplicate column name 'deptno'   重复的列名'deptno'
	AS
	SELECT *
	FROM emp,dept,salgrade
	WHERE emp.`deptno` = dept.`deptno` AND
	 (emp.`sal` BETWEEN salgrade.`losal` AND salgrade.hisal);

DESC emp_view03
SELECT * FROM emp_view03


-- Mysql用户的管理
-- 原因：当我们做项目开发时，可以根据不同的开发人员，赋给他相应的Mysql操作权限
-- 所以，Mysql数据库管理人员(root), 根据需要创建不同的用户，赋给相应的权限，供人员使用

-- 1. 创建新的用户
-- 解读 (1) 'hsp_edu'@'localhost' 表示用户的完整信息 'hsp_edu' 用户名 'localhost' 登录的IP
-- (2) 123456 密码, 但是注意 存放到 mysql.user表时，是password('123456') 加密后的密码
--     *6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9
CREATE USER 'hsp_edu'@'localhost' IDENTIFIED BY '123456'

SELECT `host`, `user`, authentication_string  
	FROM mysql.user

-- 2. 删除用户
DROP USER 'hsp_edu'@'localhost'

-- 3. 登录

-- root 用户修改 hsp_edu@localhost 密码, 是可以成功.
SET PASSWORD FOR 'hsp_edu'@'localhost' = PASSWORD('123456')

--  修改自己的密码, 没问题

SET PASSWORD = PASSWORD('abcdef')

-- 修改其他人的密码， 需要权限

SET PASSWORD FOR 'root'@'localhost' = PASSWORD('123456')

-- 演示 用户权限的管理

-- 创建用户 shunping  密码 123 , 从本地登录
CREATE USER 'shunping'@'localhost' IDENTIFIED BY '123'

-- 使用root 用户创建 testdb  ,表 news
CREATE DATABASE testdb
CREATE TABLE news (
	id INT ,
	content VARCHAR(32));
-- 添加一条测试数据
INSERT INTO news VALUES(100, '北京新闻');
SELECT * FROM news;

-- 给 shunping 分配查看 news 表和 添加news的权限
GRANT SELECT , INSERT 
	ON testdb.news
	TO 'shunping'@'localhost'
	
-- 可以增加update权限
GRANT UPDATE  
	ON testdb.news
	TO 'shunping'@'localhost'
	
	
-- 修改 shunping的密码为 abc
SET PASSWORD FOR 'shunping'@'localhost' = PASSWORD('abc');

-- 回收 shunping 用户在 testdb.news 表的所有权限
REVOKE SELECT , UPDATE, INSERT ON testdb.news FROM 'shunping'@'localhost'
REVOKE ALL ON testdb.news FROM 'shunping'@'localhost'

-- 删除 shunping
DROP USER 'shunping'@'localhost'

-- 这里在默认情况下, shunping 用户只能看到一个默认的系统数据库

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
	
	
-- homework01.sql
SELECT ename,sal*12 AS "Annual Salary" FROM emp
SELECT ename,sal salary FROM emp ORDER BY sal;  -- 默认升序 ASC
SELECT ename,sal salary FROM emp ORDER BY salary ASC; -- 升序
SELECT ename,sal salary FROM emp ORDER BY salary DESC; -- 降序


-- 2. 写出 查看DEPT表和EMP表的结构 的sql语句  homework02.sql   10min 自己先练习
-- 
	DESC dept
	DESC emp
-- 3. 使用简单查询语句完成:
-- (1) 显示所有部门名称。
-- SELECT dname FROM dept,emp
-- 	WHERE emp.`deptno` = dept.`deptno`
-- 	group by dname;
SELECT dname FROM dept;

 
-- (2) 显示所有雇员名及其全年收入 13月(工资+补助),并指定列别名"年收入"
 SELECT * FROM emp;
 SELECT * FROM dept;

SELECT ename,(sal + IFNULL(comm,0))*13 AS '年收入' FROM emp -- 解释：IFNULL(comm,0)：如果comm 为空，返回0
-- 
-- 4.限制查询数据。
-- (1) 显示工资超过2850的雇员姓名和工资。
SELECT ename,sal FROM emp
	WHERE sal > 2850;

 
-- (2) 显示工资不在1500到2850之间的所有雇员名及工资。
 SELECT ename,sal FROM emp
	WHERE sal NOT BETWEEN 1500 AND 2850;
	
SELECT ename, sal
	FROM emp 
	WHERE sal < 1500 OR sal > 2850	

SELECT ename, sal
	FROM emp 
	WHERE NOT (sal >= 1500 AND sal <= 2850) 
-- (3) 显示编号为7566的雇员姓名及所在部门编号。
SELECT ename,deptno FROM emp
	WHERE empno = 7566;
SELECT * FROM emp;
 
-- (4) 显示部门10和30中工资超过1500的雇员名及工资。
SELECT ename,sal,deptno FROM emp
	WHERE (deptno = 10 OR deptno = 30) AND sal > 1500; -- 这里必须加上小括号，把(deptno = 10 OR deptno = 30)看作一个条件
							   -- 否则会把deptno = 30 AND sal > 1500 看作一个条件

 
-- (5) 显示无管理者的雇员名及岗位。
 SELECT ename,job FROM emp
	WHERE mgr IS NULL -- 判断空/非空使用 IS
	
SELECT ename,job FROM emp
		WHERE mgr IS NOT NULL;
-- 
-- 5.排序数据。
-- (1) 显示在1991年2月1日到1991年5月1日之间雇用的雇员名,岗位及雇佣日期, 
-- 并以雇佣日期进行排序[默认]。
-- 思路 1. 先查询到对应结果 2. 考虑排序
 SELECT ename,job,hiredate FROM emp
	WHERE hiredate > '1991-02-1' AND hiredate < '1991-05-1' -- 日期比较大小时需要加上 '' !!!!
	ORDER BY hiredate;

-- (2) 显示获得补助的所有雇员名,工资及补助,并以工资降序排序
 SELECT * FROM emp;
 
 SELECT ename,sal,comm
	FROM emp
	WHERE comm IS NOT NULL
	ORDER BY sal -- 默认升序
	
 SELECT ename,sal,comm
	FROM emp
	WHERE comm IS NOT NULL
	ORDER BY sal ASC -- 升序
	
 SELECT ename,sal,comm
	FROM emp
	WHERE comm IS NOT NULL
	ORDER BY sal DESC; -- 降序 


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
	
SELECT * FROM `commodity_category` WHERE `name` LIKE '%灯%';
# WHERE `name` LIKE '%%'; 相当于查询所有
SELECT * FROM `commodity_category` WHERE `name` LIKE '%%';
	
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

-- 完成最后一个综合的练习

-- 8. 设学校环境如下:一个系有若干个专业，每个专业一年只招一个班，每个班有若干个学生。
-- 现要建立关于系、学生、班级的数据库，关系模式为：
-- 班CLASS （班号classid，专业名subject，系名deptname，入学年份enrolltime，人数num）
-- 学生STUDENT （学号studentid，姓名name，年龄age，班号classid）
-- 系 DEPARTMENT （系号departmentid，系名deptname）
-- 试用SQL语言完成以下功能：  homework05.sql 10min 
-- 
-- (1) 建表，在定义中要求声明：
--     （1）每个表的主外码。
--     （2）deptname是唯一约束。
--     （3）学生姓名不能为空。

-- 创建表 系 DEPARTMENT （系号departmentid，系名deptname）
CREATE TABLE DEPARTMENT (
	departmentid VARCHAR(32) PRIMARY KEY,
	deptname VARCHAR(32) UNIQUE NOT NULL
	);	
-- 班CLASS （班号classid，专业名subject，系名deptname，入学年份enrolltime，人数num）
CREATE TABLE class (
	classid INT PRIMARY KEY,
	`subject` VARCHAR(32) NOT NULL DEFAULT '',
	deptname VARCHAR(32),
	enrolltime INT NOT NULL DEFAULT 2000,
	num INT NOT NULL DEFAULT 0,
	FOREIGN KEY(deptname) REFERENCES DEPARTMENT(deptname));
	
-- 学生STUDENT （学号studentid，姓名name，年龄age，班号classid）
CREATE TABLE hsp_student (
	studentid INT PRIMARY KEY,
	`name` VARCHAR(32) NOT NULL DEFAULT '',
	age INT NOT NULL DEFAULT 0,
	classid INT,
	FOREIGN KEY(classid) REFERENCES class(classid));

)	
-- 添加测试数据

INSERT INTO department VALUES('001','数学');
INSERT INTO department VALUES('002','计算机');
INSERT INTO department VALUES('003','化学');
INSERT INTO department VALUES('004','中文');
INSERT INTO department VALUES('005','经济');

INSERT INTO class VALUES(101,'软件','计算机',1995,20);
INSERT INTO class VALUES(102,'微电子','计算机',1996,30);
INSERT INTO class VALUES(111,'无机化学','化学',1995,29);
INSERT INTO class VALUES(112,'高分子化学','化学',1996,25);
INSERT INTO class VALUES(121,'统计数学','数学',1995,20);
INSERT INTO class VALUES(131,'现代语言','中文',1996,20);
INSERT INTO class VALUES(141,'国际贸易','经济',1997,30);
INSERT INTO class VALUES(142,'国际金融','经济',1996,14);

INSERT INTO hsp_student VALUES(8101,'张三',18,101);
INSERT INTO hsp_student VALUES(8102,'钱四',16,121);
INSERT INTO hsp_student VALUES(8103,'王玲',17,131);
INSERT INTO hsp_student VALUES(8105,'李飞',19,102);
INSERT INTO hsp_student VALUES(8109,'赵四',18,141);
INSERT INTO hsp_student VALUES(8110,'李可',20,142);
INSERT INTO hsp_student VALUES(8201,'张飞',18,111);
INSERT INTO hsp_student VALUES(8302,'周瑜',16,112);
INSERT INTO hsp_student VALUES(8203,'王亮',17,111);
INSERT INTO hsp_student VALUES(8305,'董庆',19,102);
INSERT INTO hsp_student VALUES(8409,'赵龙',18,101);

SELECT * FROM department
SELECT * FROM class
SELECT * FROM hsp_student

-- (3) 完成以下查询功能
--   3.1 找出所有姓李的学生。
-- 查表 hsp_student , like
SELECT * FROM hsp_student
	WHERE `name` LIKE '李%';

--   3.2 列出所有开设超过1个专业的系的名字。

-- 1. 先查询各个系有多少个专业
SELECT COUNT(*) AS nubs,deptname
	FROM class
	GROUP BY deptname
	HAVING nubs > 1;


--   3.3 列出人数大于等于30的系的编号(department表中的departmentid)和名字(department表中的deptname)。
-- 1. 先查出各个系有多少人, 并得到 >= 30 的系


SELECT SUM(num) AS sum_num,deptname 
				FROM class
				GROUP BY deptname
				HAVING sum_num >= 30

-- 2. 将上面的结果看成一个临时表 和 department 联合查询即可
-- 第一种写法：
SELECT departmentid,department.`deptname`
	FROM department,(
			SELECT SUM(num) AS sum_num,deptname 
				FROM class
				GROUP BY deptname ) AS temp
	WHERE department.`deptname` = temp.`deptname` AND temp.sum_num >= 30;
-- 第二种写法：	
SELECT temp.*,department.`departmentid`
	FROM department,(
			SELECT SUM(num) AS sum_num,deptname 
				FROM class
				GROUP BY deptname
				HAVING sum_num >= 30 ) AS temp -- 老师写的先过滤出结果，最后直接对结果查询
	WHERE department.`deptname` = temp.`deptname`;



-- (4) 学校又新增加了一个物理系，编号为006
SELECT * FROM department
SELECT * FROM class
SELECT * FROM hsp_student
-- 添加一条数据
INSERT INTO department VALUES('006','物理系');


-- (5) 学生张三退学，请更新相关的表

-- 分析：1. 张三所在班级的人数-1 2. 将张三从学生表删除  3. 需要使用事务控制

-- 开启事务

-- 张三所在班级的人数-1 
START TRANSACTION;

-- savepoint a;
UPDATE class SET num = num - 1
	WHERE classid = (
		SELECT classid 
			FROM hsp_student
			WHERE `name` = '张三' -- ; -- 这里不可以写分号！！
	);
-- savepoint b;

DELETE FROM hsp_student
	WHERE `name` = '张三';
-- rollback a; 回退到a 后 不可以再往b回退，回退到a,会把从回退时到回退到a 之间的所有保存点删掉！！
-- rollback b; 
-- rollback;
-- 提交事务
COMMIT;

SELECT * FROM class
SELECT * FROM hsp_student


-- 创建测试表 演员表

CREATE TABLE actor ( -- 演员表
id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(32) NOT NULL DEFAULT '',
sex CHAR(1) NOT NULL DEFAULT '女',
borndate DATETIME,
phone VARCHAR(12));

SELECT * FROM actor
SELECT * FROM actor01


-- 演示sql 注入
-- 创建一张表
CREATE TABLE  admin ( -- 管理员表
NAME VARCHAR(32) NOT NULL UNIQUE,
pwd VARCHAR(32) NOT NULL DEFAULT '') CHARACTER SET utf8;

-- 添加数据
INSERT INTO admin VALUES('tom', '123');

-- 查找某个管理是否存在

SELECT * 
	FROM admin
	WHERE NAME = 'tom' AND pwd = '123'
	
-- SQL 
-- 输入用户名 为  1' or 
-- 输入万能密码 为 or '1'= '1 
SELECT * 
	FROM admin
	WHERE NAME = '1' OR' AND pwd = 'OR '1'= '1'
SELECT * FROM admin




CREATE TABLE news (id INT PRIMARY KEY AUTO_INCREMENT,news VARCHAR(32) NOT NULL DEFAULT '')

SELECT * FROM news;
DROP TABLE news;


SELECT * 
	FROM admin11
	
SELECT * FROM `account`

DESC account

INSERT INTO account VALUES(1,'马云',3000);
INSERT INTO account VALUES(2,'马化腾',10000);


CREATE TABLE admin2 (
id INT PRIMARY KEY AUTO_INCREMENT,
username VARCHAR(32) NOT NULL,
PASSWORD VARCHAR(32) NOT NULL);

SELECT * FROM admin2;
SELECT COUNT(*) FROM admin2;
DROP TABLE admin2;

SELECT * FROM actor;

#用户表
CREATE TABLE employee (
	id INT PRIMARY KEY AUTO_INCREMENT, #自增
	empId VARCHAR(50) UNIQUE NOT NULL DEFAULT '',#员工号
	pwd CHAR(32) NOT NULL DEFAULT '',#密码md5
	NAME VARCHAR(50) NOT NULL DEFAULT '',#姓名
	job VARCHAR(50) NOT NULL DEFAULT '' #岗位
)CHARSET=utf8; 

SELECT * FROM employee;

DROP TABLE employee;

CREATE DATABASE mhl;

INSERT INTO employee VALUES(NULL, '6668612', MD5('123456'), '张三丰', '经理');
INSERT INTO employee VALUES(NULL, '6668622', MD5('123456'),'小龙女', '服务员');
INSERT INTO employee VALUES(NULL, '6668633', MD5('123456'), '张无忌', '收银员');
INSERT INTO employee VALUES(NULL, '666', MD5('123456'), '老韩', '经理');

#餐桌表
CREATE TABLE diningTable (
	id INT PRIMARY KEY AUTO_INCREMENT, #自增, 表示餐桌编号
	state VARCHAR(20) NOT NULL DEFAULT '',#餐桌的状态
	orderName VARCHAR(50) NOT NULL DEFAULT '',#预订人的名字
	orderTel VARCHAR(20) NOT NULL DEFAULT ''
)CHARSET=utf8; 

 

INSERT INTO diningTable VALUES(NULL, '空','','');
INSERT INTO diningTable VALUES(NULL, '空','','');
INSERT INTO diningTable VALUES(NULL, '空','','');



CREATE TABLE diningTable1 (
	id LONG, #自增, 表示餐桌编号   ---- 这里测试允许为null,情况下，Java程序会不会出现空指针异常，没出
	state VARCHAR(20) NOT NULL DEFAULT '',#餐桌的状态
	orderName VARCHAR(50) NOT NULL DEFAULT '',#预订人的名字
	orderTel VARCHAR(20) NOT NULL DEFAULT ''
)CHARSET=utf8;

INSERT INTO diningTable1 VALUES(1, 'k','','');
INSERT INTO diningTable1 VALUES(NULL, '空','','');  -- 这里的null ,java中POJO long id 可以接收到 ,显示为 0 其他另外考虑吧

SELECT * FROM diningtable1;

DROP TABLE diningTable1;

#菜谱
CREATE TABLE menu (
	id INT PRIMARY KEY AUTO_INCREMENT, #自增主键，作为菜谱编号(唯一)
	NAME VARCHAR(50) NOT NULL DEFAULT '',#菜品名称
	TYPE VARCHAR(50) NOT NULL DEFAULT '', #菜品种类
	price DOUBLE NOT NULL DEFAULT 0#价格
)CHARSET=utf8; 

INSERT INTO menu VALUES(NULL, '八宝饭', '主食类', 10);
INSERT INTO menu VALUES(NULL, '叉烧包', '主食类', 20);
INSERT INTO menu VALUES(NULL, '宫保鸡丁', '热菜类', 30);
INSERT INTO menu VALUES(NULL, '山药拨鱼', '凉菜类', 14);
INSERT INTO menu VALUES(NULL, '银丝卷', '甜食类', 9);
INSERT INTO menu VALUES(NULL, '水煮鱼', '热菜类', 26);
INSERT INTO menu VALUES(NULL, '甲鱼汤', '汤类', 100);
INSERT INTO menu VALUES(NULL, '鸡蛋汤', '汤类', 16);

#账单流水, 考虑可以分开结账, 并考虑将来分别统计各个不同菜品的销售情况
CREATE TABLE bill (
	id INT PRIMARY KEY AUTO_INCREMENT, #自增主键
	billId VARCHAR(50) NOT NULL DEFAULT '',#账单号可以按照自己规则生成 UUID
	menuId INT NOT NULL DEFAULT 0,#菜品的编号, 也可以使用外键
	nums SMALLINT NOT NULL DEFAULT 0,#份数
	money DOUBLE NOT NULL DEFAULT 0, #金额
	diningTableId INT NOT NULL DEFAULT 0, #餐桌
	billDate DATETIME NOT NULL ,#订单日期
	state VARCHAR(50) NOT NULL DEFAULT '' # 状态 '未结账' , '已经结账', '挂单'
)CHARSET=utf8;

INSERT INTO menu VALUES(NULL,?,?,?,0,?,NOW(),'未结账')
DROP TABLE bill;


# 演示数据库的操作
# 创建一个名称为db01的数据库

#使用指令创建数据库
CREATE DATABASE db02;
#删除数据库指令
DROP DATABASE db02;
#创建一个使用utf8字符集的db02数据库
CREATE DATABASE hsp_db02 CHARACTER SET utf8
#创建一个使用utf8字符集 并带校对规则的的db03数据库
CREATE DATABASE hsp_db03 CHARACTER SET 	utf8 COLLATE utf8_bin
#校对规则utf8_bin 区分大小写；utf8_general_ci 不区分大小写  创建表时没指定collate 则跟随数据库的

#下面是一条查询的sql,select 查询  * 表示所有字段 FROM 从哪个表
#WHERE 从哪个字段  NAME = 'tom' 查询名字是tom
SELECT * FROM t1 WHERE NAME = 'tom'


#练习 : database03.sql 备份hsp_db02 和 hsp_db03 库中的数据，并恢复

#备份, 要在Dos下执行mysqldump指令其实在mysql安装目录\bin
#这个备份的文件，就是对应的sql语句
mysqldump -u root -p -B hsp_db02 hsp_db03 > d:\\bak.sql

DROP DATABASE ecshop;

#恢复数据库(注意：进入Mysql命令行再执行)
source d:\\bak.sql
#第二个恢复方法， 直接将bak.sql的内容放到查询编辑器中，执行
	

# 演示update语句
-- 要求在上面创建的employee表中修改表中的记录
-- 1. 将所有员工薪水修改为5000元。[如果没有带where 条件，会修改所有的记录，因此要小心]
UPDATE employee SET salary = 5000
DESC employee;

ALTER TABLE employee
	CHANGE selary salary DOUBLE NOT NULL DEFAULT 1000;

SELECT * FROM employee;
-- 2. 将姓名为 小妖怪 的员工薪水修改为3000元
UPDATE employee SET salary = 3000
	WHERE `user_name` = '小妖怪';

-- 3.将张三丰的薪水在原有的基础上增加1000元
UPDATE employee 
	SET salary = salary + 1000
	WHERE `user_name` = '张三丰';

# update 使用细节
-- 1.update语法可以用新值更新原有表中的各列。
-- 2.set子句指是要修改哪些列和要给予哪些值。
-- 3.where 子句指定应更新那些行。如果没有where子句，则更新所有的行（记录），因此一定小心
-- 4.如果需要修改多个字段，可以通过 set 字段1=值1,字段2=值2...
UPDATE employee 
	SET salary = salary + 1000,job = '洗脚的'
	WHERE `user_name` = '张三丰';
SELECT * FROM employee;

-- ============================================================================

 -- 创建家居表(表如何设计)
-- 设计furn表 家居表
 -- 老师说 需求-文档-界面 
 -- 技术细节
 -- 有时会看到 id int(11) ... 11 表示的显示宽度,存放的数据范围和int 配合zerofill
 --                int(2) .... 2 表示的显示宽度
 --                67890 => int(11) 00000067890
 --                67890 => int(2)  67890
 -- 创建表的时候，一定注意当前是DB
 -- 表如果是第一次写项目，表的字段可能会增加,修改，删除

CREATE TABLE `furn`(
`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, #id
`name` VARCHAR(64) NOT NULL, #家居名
`maker` VARCHAR(64) NOT NULL, #制造商
`price` DECIMAL(11,2) NOT NULL, #价格 定点数
`sales` INT UNSIGNED NOT NULL, #销量
`stock` INT UNSIGNED NOT NULL, #库存
`img_path` VARCHAR(256) NOT NULL #存放图片的路径
)CHARSET utf8 ENGINE INNODB;

-- 因为id没有限制非空 可以为null 执行更新语句时不会报错 只是受影响的行为0 
UPDATE `furn` SET `name`= '123',`maker` =1,`price`=1 ,`sales`=1,`stock`=1 WHERE `id` = NULL;
-- 更新不存在的id号   执行更新语句时不会报错 只是受影响的行为0 
UPDATE `furn` SET `name`= '123',`maker` =1,`price`=1 ,`sales`=1,`stock`=1 WHERE `id` = 0;


-- 分页查询!!!

# LIMIT begin,size; begin从0开始 0对应第一条数据 size 每页的数据条数

# 如果只写了一个参数 那么等价于 LIMIT０,？; 写的这一个参数？代表的是第二个参数size的值，第一个参数默认是０
SELECT * FROM emp
	ORDER BY empno ASC
	LIMIT ?;
#上面的语句等价于下面的
SELECT * FROM emp
	ORDER BY empno ASC
	LIMIT 0,?;
	
# LIMIT start,rows; start+1开始取，取出rows行， start从0开始计算；
-- 推导出一个公式：LIMIT 每页显示的记录数 * (第几页 - 1),每页显示的记录数; 
 
-- 1.按雇员的id号升序取出，每页显示3条记录，分别显示 第1页，第2页，第3页
-- 第1页
SELECT * FROM emp
	ORDER BY empno ASC
	LIMIT 0,3;
-- 第2页
SELECT * FROM emp
	ORDER BY empno ASC
	LIMIT 3,3;
-- 第3页
SELECT * FROM emp
	ORDER BY empno ASC
	LIMIT 6,3;
-- 第4页
SELECT * FROM emp
	ORDER BY empno ASC
	LIMIT 9,3;
-- 第n页
-- 推导出一个公式：LIMIT 每页显示的记录数 * (第几页 - 1),每页显示的记录数; 
SELECT * FROM emp
	ORDER BY empno ASC
	LIMIT 每页显示的记录数 * (第几页 - 1),每页显示的记录数;
SELECT * FROM emp
	ORDER BY empno DESC
	LIMIT 10,5;
SELECT * FROM emp
	ORDER BY empno DESC
	LIMIT 20,5;
	
	
	
DESC emp;

-- 2.基本语法：select ... limit start,rows
--   表示从start+1 行开始取，取出rows行，start 从0开始计算


-- 表的复制
-- 为了对某个sql语句进行效率测试，我们需要海量数据时，可以使用此方法为表创建海量数据

CREATE TABLE my_tab01
	(id INT,
	`name` VARCHAR(32),
	sal DOUBLE,
	job VARCHAR(32),
	deptno INT);

SELECT * FROM my_tab01;
DESC my_tab01;

-- 演示如何自我复制
-- 1. 先把emp 表的记录复制到 my_tab01 这里不需要用values
INSERT INTO my_tab01
	(id, `name`, sal, job,deptno)
	SELECT empno, ename, sal, job, deptno FROM emp;
-- 2. 自我复制
INSERT INTO my_tab01
	SELECT * FROM my_tab01;

SELECT COUNT(*) FROM my_tab01;


-- 正常的insert语句如下：
INSERT INTO `goods` (id,`goods_name`,`price`)
	VALUES(2,'iphone',5000);

-- 面试题：如何删除掉一张表重复记录
-- 1. 先创建一张表 my_tab02,
-- 2. 让 my_tab02 有重复的记录

CREATE TABLE my_tab02 LIKE emp; -- 这个语句 把emp表的结构(列)，复制到my_tab02

DESC my_tab02;

INSERT INTO my_tab02
	SELECT * FROM emp;

SELECT * FROM my_tab02;

INSERT INTO my_tab02
	SELECT * FROM my_tab02;

-- 3. 考虑去重 my_tab02的记录
/*
	思路
	(1) 先创建一张临时表 my_tmp, 该表的结构和my_tab02一样
	(2) 把my_tab02 的记录通过 distinct 关键字处理后 把记录复制到my_tmp
	(3) 清除掉 my_tab02记录
	(4) 把my_tmp 表的记录复制到 my_tab02
	(5) drop 掉 临时表my_tmp
*/	

-- (1) 先创建一张临时表 my_tmp, 该表的结构和my_tab02一样
CREATE TABLE my_tmp LIKE my_tab02;

DESC my_tmp;
SELECT * FROM my_tmp;
-- (2) 把my_tab02 的记录通过 distinct 关键字处理后 把记录复制到my_tmp
INSERT INTO my_tmp
	SELECT DISTINCT * FROM my_tab02;
SELECT * FROM my_tmp;
-- (直接改名字也行)
DROP TABLE my_tab02; -- 语法注意
RENAME TABLE my_tmp TO my_tab02; -- 语法注意
-- (3) 清除掉 my_tab02记录

SELECT * FROM my_tab02;
DELETE FROM my_tab02; -- 注意语法！！！
-- (4) 把my_tmp 表的记录复制到 my_tab02
INSERT INTO my_tab02
	SELECT * FROM my_tmp;
SELECT * FROM my_tab02;
-- (5) drop 掉 临时表my_tmp
SELECT * FROM my_tmp;
DROP TABLE my_tmp;


-- 外键演示

-- 创建主表 my_class
CREATE TABLE my_class (
	id INT PRIMARY KEY , -- 班级编号
	`name` VARCHAR(32) NOT NULL DEFAULT '');

-- 创建 从表 my_stu
CREATE TABLE my_stu (
	id INT PRIMARY KEY , -- 学生编号
	`name` VARCHAR(32) NOT NULL DEFAULT '',
	class_id INT, -- 学生所在班级的编号
	-- 下面指定外键关系
	FOREIGN KEY(class_id) REFERENCES my_class(id));

-- 测试数据
INSERT INTO my_class
	VALUES(100,'java'),(200,'web'),(300,'php');
INSERT INTO my_class
	VALUES(NULL,'python'); -- 主键是非空唯一约束 Column 'id' cannot be null

SELECT * FROM my_class;


INSERT INTO my_stu
	VALUES(1,'tom',100);
INSERT INTO my_stu
	VALUES(2,'jack',200);
INSERT INTO my_stu
	VALUES(3,'hsp',300);
INSERT INTO my_stu
	VALUES(4,'mary',400);  -- 这里会失败，因为400班级不存在
	
INSERT INTO my_stu
	VALUES(5, 'king', NULL); -- 可以, 外键 没有写 not null

SELECT * FROM my_stu;
SELECT * FROM my_class; -- 一旦建立主外键的关系，数据不能随意删除了

DELETE FROM my_class
	WHERE id = 100;	
	
DELETE FROM my_stu
	WHERE id = 1;	

SELECT * FROM my_stu;	

-- foreign key(外键) 细节：
-- 1.外键指向的表的字段，要求是primary key 或者是unique(唯一)
-- 2.表的存储引擎类型是innodb,这样的表才支持外键
-- 3.外键字段的类型要和主键字段的类型一致(长度可以不同)
-- 4.外键字段的值，必须在主键字段中出现过，或者从表中添加的数据为null[前提是从表中外键字段允许为null]
-- 5.一旦建立主外键的关系，数据不能随意删除，除非从表(设置外键的表)中的数据，
-- 没有指向主表数据（一个也没有），主表中的数据才可以删除


-- 日期时间相关函数

-- current_date() 当前日期
SELECT CURRENT_DATE() FROM DUAL; -- () 加不加都行
-- current_time() 当前时间
SELECT CURRENT_TIME() FROM DUAL;
-- current_timestamp() 当前时间戳
SELECT CURRENT_TIMESTAMP() FROM DUAL;

SELECT NOW() FROM DUAL;

-- 创建测试表 信息表
CREATE TABLE mes(id INT, content VARCHAR(30),sendtime DATETIME);

-- 添加一条记录
INSERT INTO mes
	VALUES(1,'北京新闻',CURRENT_TIMESTAMP());
INSERT INTO mes
	VALUES(2,'上海新闻',NOW());
INSERT INTO mes 
	VALUES(3,'广州新闻',NOW());

SELECT * FROM mes;

SELECT NOW() FROM DUAL;

-- 应用实例
-- 显示所有新闻信息，发布日期只显示日期，不用显示时间
SELECT id,content,DATE(sendtime)
	FROM mes;

-- 查询在10分钟内发布的新闻
SELECT * 
	FROM mes
	WHERE DATE_ADD(sendtime, INTERVAL 10 MINUTE) >= NOW(); -- sendtime 加上10分钟

SELECT * 
	FROM mes
	WHERE sendtime >= DATE_SUB(NOW(), INTERVAL 10 MINUTE); -- 
	-- sendtime 大于等于 now() 减去 10分钟

-- 求出2011-11-11 和 1990-1-1 相差多少天
SELECT DATEDIFF('2011-11-11','1990-01-01') FROM DUAL;
-- 求出你活了多少天
SELECT DATEDIFF(NOW(),'1998-03-27') FROM DUAL;
SELECT DATEDIFF('1998-03-21','1998-03-23') FROM DUAL;
 -- 得到的是天数 前面的日期-后面的日期 ，可能是 负数
-- 如果你能活80岁，求出你还能活多少天
-- DATE_ADD(date1, INTERVAL 80 YEAR) date1 可以是date,datetime,timestamp
-- INTERVAL 80 YEAR: YEAR 可以是 年月日，时分秒 year month day minute second hour 
SELECT DATEDIFF((DATE_ADD('1998-03-07', INTERVAL 80 YEAR)) ,NOW()) FROM DUAL; -- 

SELECT TIMEDIFF('10:10:11','04:10:10') FROM DUAL;

-- YEAR|Month|DAY DATE (datetime)
SELECT YEAR(NOW()) FROM DUAL;
SELECT MONTH(NOW()) FROM DUAL;
SELECT DAY(NOW()) FROM DUAL;
SELECT MONTH('2022-02-02') FROM DUAL;

-- unix_timestamp() : 返回的是1970-1-1 到现在的秒数
SELECT UNIX_TIMESTAMP() FROM DUAL;

-- from_unixtime() :可以把一个unix_timestamp 秒数，转成指定格式的日期

-- %Y-%m-%d 格式是规定好的，表示年月日
-- 意义：在开发中，可以存放一个整数，然后表示时间，通过FROM_UNIXTIME转换
-- select from_unixtime('1671288382','%Y-%m-%d') from dual;
SELECT FROM_UNIXTIME(1671288355,'%Y-%m-%d') FROM DUAL;
SELECT FROM_UNIXTIME(1671288355,'%Y-%m-%d %H:%i:%s') FROM DUAL;


#演示时间相关的类型
#创建一张表，date ,datetime ,timestamp
CREATE TABLE t14 (
  birthday DATE,
  -- 生日
  job_time DATETIME,
  -- 记录年月日 时分秒
  login_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;-- 登录时间，如果希望login_time列自动更新

SELECT * FROM t14;
INSERT INTO t14(birthday,job_time)
	VALUES('2021-11-11','2021-11-11 10:10:10');
-- 如果更新，t14表的某条记录，login_time列会自动地以当前时间进行更新
 	
























































































































 








 







 























































