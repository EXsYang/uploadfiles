#演示字符串类型使用char varchar
#注释的快捷键 shift + ctrl + c,注销注释 shift + ctrl + r
-- char(size)
-- 固定长度字符串 最大255 字符
-- varchar(size) 0~65535字节
-- 可变长度字符串 最大65532字节 【utf8编码最大21844字符 1-3个字节用于记录大小】
如果表的编码是utf8 VARCHAR(size) size = (65535-3) / 3 = 21844
如果表的编码是gbk VARCHAR(size) size = (65535-3) / 2 = 32766





CREATE TABLE t09 (
	`name` CHAR(255));
	

	
CREATE TABLE t10 (
	`name` VARCHAR(21844));
	

DROP TABLE t09;



