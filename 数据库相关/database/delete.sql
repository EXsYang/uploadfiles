-- delete 语句演示

-- 删除表中名称为`张三丰`的记录
DELETE FROM employee
	WHERE `user_name` = '张三丰';

-- 删除表中所有记录，提醒一定要小心
DELETE FROM employee;

-- Delete语句不能删除某一列的值（可使用update 设为 null 或者''）
UPDATE employee SET job = '' WHERE user_name = '杨达';
UPDATE employee SET job = NULL WHERE user_name = '杨达';
SELECT * FROM employee;

-- 要删除这个表
DROP TABLE employee;











