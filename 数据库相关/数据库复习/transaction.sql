-- 事务的一个重要概念和具体操作
-- 回退事务
-- 保存点(savepoint)是事务中的点，用于取消部分事务，当结束事务时（commit），
-- 会自动地删除该事务所定义的所有保存点
-- 提交事务
-- commit 执行后，会确认事物的变化，结束事务、删除保存点、释放锁，数据生效
-- 当使用commit语句结束事务后，其他会话【其它连接】将可以查看到事物变化后的新数据
-- [所有数据就正式生效]



-- 演示
-- 1. 创建一张测试表
CREATE TABLE t29
	(id INT,
	`name` VARCHAR(32));
-- 2. 开始事务
START TRANSACTION 
-- 3. 设置保存点
SAVEPOINT a  
-- 执行dml 操作
INSERT INTO t29
	VALUES(100,'tom');
SELECT * FROM t29;

SAVEPOINT b
-- 执行dml操作
INSERT INTO t29
	VALUES(200,'jack');
	
-- 回退到b
ROLLBACK TO b;	
-- 继续回退 a
ROLLBACK TO a;

# 回退到a点之后，就不能在回退到b点了！！！

ROLLBACK; -- 回退全部事务
COMMIT; -- 提交事务，所有的操作生效，不能回退
DELETE FROM t29;


-- 事务细节讨论 detail
-- 
-- 1. 如果不开始事务，默认情况下，dml操作是自动提交的，不能回滚
-- 2. 如果开始一个事务，你没有创建保存点，你可以执行rollback,
-- 默认就回退到你事务开始的状态
-- 3. 在事务中（还没有提交时），创建多个保存点 savepoint a; 执行dml, savepoint b;
-- 4. 你可以在事务没有提交前，选择回退到哪个保存点
-- 5. MySQL的事务机制需要innodb的存储引擎才可以使用，myisam不好使
-- 6. 开始一个事务两种方式 
-- start transaction; 
-- set autocommit=off;













