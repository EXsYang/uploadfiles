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


