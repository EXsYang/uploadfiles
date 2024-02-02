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



















