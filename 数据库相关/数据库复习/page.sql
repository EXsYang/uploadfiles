-- 分页查询!!!
# LIMIT begin,size; begin从0开始 0对应第一条数据 size 每页的数据条数
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







