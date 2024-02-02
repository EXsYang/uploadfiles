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

















