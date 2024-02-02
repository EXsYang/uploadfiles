#演示字符串类型的使用细节
#1. char(4)和 varchar(4) 这个4表示的是字符，而不是字节，不区分字符是汉字还是字母
#不管是 中文还是英文字母，都是最多存放4个，是按照字符来存放的
#2. char(4)是定长，就是说，即使你插入'aa',也会占用 分配的四个字符
#varchar(4)是变长，就是说，如果你插入了'aa'，实际占用空间大小并不是4个字符
#，而是按照实际占用空间来分配（varchar本身还需要占用1~3个字节，来记录存放内容长度
#L(实际数据大小+(1~3)字节)
#3. 什么时候使用char,什么时候使用varchar
#①如果数据是定长，推荐使用char,比如md5的密码，邮编，手机号，身份证号等 char(32)
#②如果一个字段的长度是不确定，我们使用varchar,比如留言，文章
# 查询速度 char > varchar
#4. 在存放文本时，也可以使用Text数据类型。可以i将Text列视为varchar列，
#注意 Text 不能有默认值，大小 0 - 2^16字节
#如果希望存放更多字符，可以选择 MEDIUMTEXT 0-2^24 或者LONGTEXT 0~2^32

CREATE TABLE t11 (
	`name`  CHAR(4));
INSERT INTO t11 VALUES('AA');
SELECT * FROM t11;
CREATE TABLE t12 (
	`name`  VARCHAR(4));
INSERT INTO t12 VALUES('韩顺平号');
SELECT * FROM t12;

CREATE TABLE t13 (
	content TEXT,content2 MEDIUMTEXT,content3 LONGTEXT);
INSERT INTO t13 VALUES('韩顺平','韩顺平123','韩顺平11111~~');
SELECT * FROM t13;
