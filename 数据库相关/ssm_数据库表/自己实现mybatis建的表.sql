CREATE DATABASE `hsp_mybatis`;
USE `hsp_mybatis`;
CREATE TABLE `monster` (
`id` INT NOT NULL AUTO_INCREMENT,
`age` INT NOT NULL,
`birthday` DATE DEFAULT NULL, 
`email` VARCHAR(255) NOT NULL,
`gender` TINYINT NOT NULL,
`name` VARCHAR(255) NOT NULL, 
`salary` DOUBLE NOT NULL,
PRIMARY KEY (`id`)
) CHARSET=utf8;
INSERT INTO `monster` VALUES(2, 200, '2000-11-11', 'nmw@sohu.com', 1,
'牛魔王2', 8888.88);

`mybatis``monster` WHERE `id`=1;

# 使用字符串的'1' 也能查询成功
SELECT * FROM `monster` WHERE `id`='1';
SELECT * FROM `monster` WHERE `id`="1";

# 下面测试的是 xml-mapper module xml映射器
SELECT * FROM `monster` WHERE `id`='6' AND `name` = '老鼠精';

SELECT * FROM `monster` WHERE `name` LIKE '%牛魔王%';

#查询 id > 10 并且 salary 大于 40,
SELECT * FROM `monster` WHERE `id`> 10 AND `salary` > 40;


# 测试 resultMap 映射结果集
CREATE TABLE `user` (
`user_id` INT NOT NULL AUTO_INCREMENT,
`user_email` VARCHAR(255) DEFAULT '',
`user_name` VARCHAR(255) DEFAULT '',
PRIMARY KEY (`user_id`)
)CHARSET=utf8;

INSERT INTO `user` (`user_email`,`user_name`) VALUES ('yd@sohu.com','yd');

SELECT * FROM `user`;

# 动态sql测试 dynamic-sql
-- 请查询 age 大于 10 的所有妖怪，如果程序员输入的 age 不大于 0, 则输出所有的妖怪!
SELECT * FROM `monster` WHERE `age` > 10
SELECT * FROM `monster` WHERE 1 = 1;

-- 根据 id 和名字来查询结果
SELECT * FROM `monster` WHERE `id` = 6 AND `name` = '老鼠精'
 
# 需求：如果给的 name 不为空，就按名字查询妖怪，如果指定的 id>0，就按 id 来查询妖
# 怪，如果前面的两个条件都不满足，就默认查询salary>100的，

SELECT * FROM `monster` WHERE `name` = '老鼠精' AND `id` > 0;

# 查询 monster_id 为 6,7,8 的妖怪
SELECT * FROM `monster` WHERE `id` IN(6,7,8)

# 按名字查询妖怪
SELECT * FROM `monster` WHERE `name` = '老鼠精' 

#需求: 请对指定 id 的妖怪进行 修改，如果没有设置新的属性，则保持原来的值
#传统方式 非常麻烦 不知道要修改哪一个字段 
# 同时也不知道原来的值有没有被修改过 还存在组合修改的情况 比较麻烦
UPDATE `monster` SET `age` = 22 WHERE `id` = 7;
UPDATE `monster` SET `name` = '老虎精' WHERE `id` = 7;
UPDATE `monster` SET `email` = 'laohu@sohu.com' WHERE `id` = 7;
UPDATE `monster` SET `email` = 'laohu@sohu.com',`salary` = 200 WHERE `id` = 7;
-- 如果同时修改所有的属性值
UPDATE `monster` SET `age` = 3,`email` = 'laohu@sohu.com',`salary` = 200 ... WHERE `id` = 7;

-- 出现新的问题
-- 1. 需要先把id=3 记录查询出来
-- 2. 在组织update 语句时，需要把不修改的指的原值设置上，同时把需要修改的字段的值
--    设置到对应的字段... 还是比较麻烦 => mybatis 动态sql set 标签就可以解决



# 动态sql homework -> 见项目 [mybatis]父项目-[dynamic-sql-homework-hero]子项目

 -- 	private Integer id;
--     //外号
--     private String nickname;
--     //技能
--     private String skill;
--     // 排行
--     private Integer rank;
--     // 薪水
--     private Double salary;
--     // 入伙时间
--     private Date date;

CREATE TABLE `hero` (
`id` INT NOT NULL AUTO_INCREMENT,
`nickname` VARCHAR(255) NOT NULL, 
`skill` VARCHAR(255) NOT NULL,
`rank` INT NOT NULL,
`salary` DOUBLE NOT NULL,
`date` DATE DEFAULT NULL,
PRIMARY KEY (`id`)
) CHARSET=utf8;

INSERT INTO `hero` (`nickname`,`skill`,`rank`,`salary`,`date`) 
VALUES('光头披风侠','认真一拳',4,3000.0,NOW());
INSERT INTO `hero` (`nickname`,`skill`,`rank`,`salary`,`date`) 
VALUES('艾伦-赶着去送死的家伙','发动地鸣',2,4000,NOW());
INSERT INTO `hero` (`nickname`,`skill`,`rank`,`salary`,`date`) 
VALUES('岡部倫太郎-凤凰院变态凶真-狂气的疯狂科学家','发现时间机器制作方法',3,6000,NOW());
INSERT INTO `hero` (`nickname`,`skill`,`rank`,`salary`,`date`) 
VALUES('克里斯提娜-助手','发明时间机器',1,5000,NOW());

INSERT INTO `hero` (`nickname`,`skill`,`rank`,`salary`,`date`) 
VALUES('王梦轩-铁胃美少女','曹氏吃不了-铁胃战损',666,666,NOW());


DELETE FROM `hero`;

DROP TABLE `hero`;

SELECT * FROM `hero`;

# 查询rank 大于 10的所有hero,如果输入的rank不大于0，则输出所有hero
SELECT * FROM `hero` WHERE `rank` > 10;
INSERT INTO `hero` (`nickname`,`skill`,`rank`,`salary`,`date`) 
VALUES('派大星','吹泡泡',12,50,NOW());

# 编写方法，查询rank为 3,6,8[rank可变]的hero  对应的sql子句是: IN(3,6,8)
SELECT * FROM `hero` WHERE `rank` IN (3,6,8);

# 编写方法，修改hero信息，如果没有设置新的属性值，则保持原来的值
UPDATE `hero` SET `skill` = '魔眼' WHERE `id` = 3;
SELECT * FROM `hero` WHERE `id` = 3;

# 可以根据id查询hero,如果没有传入id,就返回所有hero
SELECT * FROM `hero` WHERE `id` = 3;


#  可以根据id或者name查询hero,如果传入了id 就使用id查询,
#  如果没有传入id,就使用name查询, 如果name也没传入,默认查询 rank < 3 的hero

SELECT * FROM `hero` WHERE `id` = 3;


# 映射关系 一对一   对应的 module =》mybatis-mapping 
SELECT * FROM `monster`
SELECT * FROM `hero`,`monster` WHERE `id` = 1; -- where子句中的列“id”不明确 Column 'id' in where clause is ambiguous
SELECT * FROM `hero`,`monster` WHERE `hero`.`id` = 1; -- 出现笛卡尔集
SELECT * FROM `hero`,`monster` WHERE `hero`.`id` = 6 AND `hero`.`id` = `monster`.`id` ;

  
-- 创建 mybatis_idencard 表 记录身份证
CREATE TABLE `idencard`(
id INT PRIMARY KEY AUTO_INCREMENT,
card_sn VARCHAR(32) NOT NULL DEFAULT '' )CHARSET utf8 ;
INSERT INTO idencard VALUES(1,'111111111111110');
INSERT INTO idencard VALUES(5,'555555555555550');

CREATE TABLE person(
id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(32) NOT NULL DEFAULT '',
card_id INT , -- 对应 idencard 主键id
FOREIGN KEY (card_id) REFERENCES idencard(id) -- 外键	表是否设置外键, 对 MyBatis 进行对象/级联映射没有影响
)CHARSET utf8;

INSERT INTO person VALUES(1,'张三1',1);
INSERT INTO person VALUES(3,'张5',5);

SELECT * FROM person;
SELECT * FROM idencard;

# 根据 id 获取到身份证

SELECT * FROM `idencard` WHERE `id` = 1;

# 通过 Person 的 id 获取到 Person
SELECT * FROM `person` WHERE `id` = 1;

# 使用多表查询 同时返回相关信息
SELECT * FROM `person`,`idencard` 
WHERE `person`.`id` = 2 AND `person`.`card_id` = `idencard`.`id`;

        SELECT * FROM `person`,`idencard`
        WHERE `person`.`id` = 2 AND `person`.`id` = `idencard`.`id`;
--          SELECT `person`.`id`,`person`.`NAME`,`person`.`card_id`,`idencard`.`card_sn` FROM `person`,`idencard`
--          WHERE `person`.`id` = #{id} AND `person`.`id` = `idencard`.`id`;

SELECT `person`.`id`,`person`.`NAME`,`person`.`card_id`,`idencard`.`card_sn` FROM `person`,`idencard` 
WHERE `person`.`id` = 1 AND `person`.`id` = `idencard`.`id`;

SELECT * FROM `idencard` WHERE `id` = 1;
SELECT * FROM `person` WHERE `card_id` = 1;

# mybatis 级联操作 homework
# husband(id,name,wife_id)  wife(id,name)

-- 创建 wife 表  
 CREATE TABLE `wife`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`wife_name` VARCHAR(32) NOT NULL DEFAULT '' 
)CHARSET utf8 ;

-- 创建 husband 表 
CREATE TABLE `husband`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(32) NOT NULL DEFAULT '' ,
`wife_id` INT, -- 对应 idencard 主键id
FOREIGN KEY (`wife_id`) REFERENCES `wife`(`id`)  -- 外键	表是否设置外键, 对 MyBatis 进行对象/级联映射没有影响
)CHARSET utf8 ;



INSERT INTO `wife` VALUES(1,'铁扇公主');
INSERT INTO `husband` VALUES(1,'牛魔王',1);
INSERT INTO `wife` VALUES(2,'布尔玛');
INSERT INTO `husband` VALUES(2,'贝吉塔',2);


DROP TABLE `wife`
DROP TABLE `husband`

SELECT * FROM `husband`;
SELECT * FROM `wife`;

 # 据id获取Wife
SELECT * FROM `wife` WHERE `id` = 1;

#  根据id获取 Husband
SELECT * FROM `husband` WHERE `id` = 1;

# 级联操作 xml 第1种方式
 SELECT * FROM `husband`,`wife` WHERE
  `husband`.`id` = 2 AND `husband`.`id` = `wife`.`id`;

# 级联操作 xml 第2种方式
 SELECT * FROM `husband` WHERE `id` = 1;

# 多对一

# 创建 mybatis_user 和 mybatis_pet 表
CREATE TABLE mybatis_user
(id INT PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(32) NOT NULL DEFAULT '' 
)CHARSET=utf8 ;

CREATE TABLE mybatis_pet
(id INT PRIMARY KEY AUTO_INCREMENT,
nickname VARCHAR(32) NOT NULL DEFAULT '',
user_id INT ,
FOREIGN KEY (user_id) REFERENCES mybatis_user(id)
)CHARSET=utf8 ;

INSERT INTO mybatis_user
VALUES(NULL,'宋江'),(NULL,'张飞');

INSERT INTO mybatis_pet
VALUES(1,'黑背',1),(2,'小哈',1);
INSERT INTO mybatis_pet
VALUES(3,'波斯猫',2),(4,'贵妃猫',2);

SELECT * FROM mybatis_user;
SELECT * FROM mybatis_pet;


# 通过 User 的 id 来获取 pet 对象，可能有多个，因此使用 List 接收
SELECT * FROM `mybatis_pet` WHERE `user_id` = 1;

# 通过 id 获取 User 对象
SELECT * FROM `mybatis_user` WHERE `id` = 1;

# 通过 pet 的 id 获取 Pet 对象
SELECT * FROM `mybatis_pet` WHERE `id` = 1;














