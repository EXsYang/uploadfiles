# 演示数据库的操作
# 创建一个名称为db01的数据库

#使用指令创建数据库

CREATE DATABASE fx_db02;
#删除数据库指令
DROP DATABASE fx_db02;
 
#创建一个使用utf8字符集的db02数据库
CREATE DATABASE yd_db02 CHARACTER SET utf8
#创建一个使用utf8字符集 并带校对规则的的db03数据库

CREATE DATABASE hsp_db03 CHARACTER SET 	utf8 COLLATE utf8_bin
SHOW CHARACTER SET;
SHOW COLLATION;
#校对规则utf8_bin 区分大小写；utf8_general_ci 不区分大小写  创建表时没指定collate 则跟随数据库的

#下面是一条查询的sql,select 查询  * 表示所有字段 FROM 从哪个表
#WHERE 从哪个字段  NAME = 'tom' 查询名字是tom
SELECT * FROM t1 WHERE NAME = 'tom'

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
#演示删除和查询数据库
#查看当前数据库服务器中的所有数据库
SHOW DATABASES
#查看前面创建的hsp_02数据库的定义信息
SHOW CREATE DATABASE `yd_db02`;
#说明 在创建数据库表的时候，为了规避关键字，可以使用反引号

#删除前面创建的hsp_db01数据库
CREATE DATABASE `yd_db02`;
DROP DATABASE `yd_db02`;

CREATE DATABASE hsp_db02;
DROP DATABASE hsp_db02

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

#练习 : database03.sql 备份hsp_db02 和 hsp_db03 库中的数据，并恢复

#备份, 要在Dos下执行mysqldump指令其实在mysql安装目录\bin
#这个备份的文件，就是对应的sql语句
mysqldump -u root -p -B hsp_db02 hsp_db03 > d:\\bak.sql

DROP DATABASE ecshop;

#恢复数据库(注意：进入Mysql命令行再执行)
source d:\\bak.sql
#第二个恢复方法， 直接将bak.sql的内容放到查询编辑器中，执行

在命令行 需要写分号 代表结束！ ; 
mysql> SHOW DATABASES
    -> \c
mysql> SHOW DATABASE
    -> SHOW DATABASES
    -> \c
mysql> SHOW DATABASES
    -> ;
+--------------------+
| DATABASE           |
+--------------------+
| information_schema |
| ecshop             |
| hsp_db03           |
| mhl                |
| mysql              |
| performance_schema |
| shop_db            |
| sys                |
| tmp                |
| yd_db02            |
+--------------------+
10 ROWS IN SET (0.00 sec)

mysql>


#指令创建表
CREATE TABLE `table` (
	id INT,
	`name` VARCHAR(255),
	`password` VARCHAR(255),
	`birthday` DATE)
	CHARACTER SET utf8 COLLATE utf8_bin ENGINE INNODB;

#演示整形范围
#使用tinyint 来演示范围 有符号-128 ~ 127 如果没有符号 0 ~ 255
# 说明：表的字符集，校验规则，存储引擎，使用默认
#1. 如果没有指定 unsigned ,则TINYINT就是有符号
#2. 如果指定 unsigned ,则TINYINT 就是无符号 0 ~ 255

-- tinyint类型代表一个字节，如果一个数字大小超过一个字节，则无法保存。
-- tinyint有两种类型，第一种（默认）可以储存正负数；第二种指定字段unsigned，只能储存正数。
-- (1) . 第一种储存过程：一个字节共有8位，将第一个字节作为正负标志，不做数据储存，其中第一个字节为1=负，0=正。所以最大负数=11111111=-127(将后面7位转为十进制制)，最大正数=01111111=127；官方给出的tinyint取值范围是-128到127，为什么不是-127到127呢，原因在于当10000000时候，此时为-0，当00000000时，此时为+0，这就出现了两个0，而-0没有意义，所以就规定-0时候，储存数字为-128。这样tinyint最大负数=-128
-- (2). 第二种储存过程：只存正数，则一个字节最大可以储存1111111=255，即tinyint范围=0~255




CREATE TABLE t4 (
	id TINYINT );
	
DROP TABLE t5;

CREATE TABLE t5 (
	id TINYINT UNSIGNED );

INSERT INTO t4 VALUES(128);

INSERT INTO t5 VALUES(0);
INSERT INTO t4 VALUES(-5);
SELECT * FROM t4;
SELECT * FROM t5;








