# 演示数据库的操作
# 创建一个名称为db01的数据库

SQLyog 注释快捷键 CTRL + shift + C
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






概念：COLLATE 含义 核对、校对
CREATE TABLE `table1` (
 
`id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
 
`field1` TEXT COLLATE utf8_unicode_ci NOT NULL COMMENT '字段1',
 
`field2` VARCHAR(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '字段2',
 
PRIMARY KEY (`id`)
 
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8_unicode_ci COMMENT '测试表';

  mysql中字符型的列/字段 需要一个COLLATE类型来告知mysql如何对该列进行排序和比较
简而言之，COLLATE会影响到ORDER BY语句的顺序，会影响到WHERE条件中大于小于号筛选出来的结果，会影响**DISTINCT**、**GROUP BY**、**HAVING**语句的查询结果。

mysql建索引的时候，如果索引列是字符类型，也会影响索引创建

凡是涉及到字符类型比较或排序的地方，都会和COLLATE有关系

COLLATE通常是和数据编码（CHARSET）相关的，一般来说每种CHARSET都有多种它所支持的COLLATE，并且每种CHARSET都指定一种COLLATE为默认值。例如Latin1编码的默认COLLATE为latin1_swedish_ci，GBK编码的默认COLLATE为gbk_chinese_ci，utf8mb4编码的默认值为utf8mb4_general_ci
注意：建表时  DEFAULT CHARSET=utf8mb3 之前，现在多写为 DEFAULT CHARSET=utf8mb4  （表情符号如:微信☺—占据4bytes）

区分charset 与collate不同
1.charset设置字符串编码集，常用的utf8，mysql遗留问题utf8最存储3字节的大小，4字节的文字无法存储，需要utf8mb4

2.collate和charset关联，定义了字符串的排序规则，如utf8mb4_general_ci是和utf8mb4对应的排序规则，ci为Case Insensitive，即大小写不敏感

3.对应cs为Case Sensitive，即大小写敏感  【where NAME='A'与name='a'效果一致！ci不敏感时】
 
4.查看数据库的所有charset和collate
SHOW CHARACTER SET;
SHOW COLLATION;

  5  设置collate的级别【库、表和字段】

    库    CREATE DATABASE <db_name> DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
    表   CREATE TABLE tablename (
      `name` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
     ...
     ...
    ) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    SQL级别查询   显示声明覆盖表中的COLLATE设置
    SELECT DISTINCT field1 COLLATE utf8mb4_general_ci FROM table1;
    SELECT field1, field2 FROM table1 ORDER BY field1 COLLATE utf8mb4_general_ci;
    优先级顺序是 SQL语句 > 列级别设置 > 表级别设置 > 库级别设置 > 实例级别设置
 