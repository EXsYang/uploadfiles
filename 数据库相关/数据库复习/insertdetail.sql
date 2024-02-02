#说明 insert 语句的细节
-- 1.插入的数据应与字段的数据类型相同
-- 	比如 把 'abc' 添加到 int 类型会错误
INSERT INTO `goods` (id,goods_name,price)
	VALUES('3','小米手机',2000); -- 可以成功，mysql底层会试着将'3' 转换成整形
INSERT INTO `goods` (id,goods_name,price)
	VALUES('韩顺平','小米手机',4000); -- 失败
SELECT * FROM `goods`;

#2. 数据的长度应在列的规定范围内，例如：不能将一个长度为80的字符串加入到长度为40的列中
INSERT INTO `goods` (id,goods_name,price)
	VALUES(40,'vivo手机vivo手机vivo手机vivo手机vivo手机',3000);

#3. 在values中列出的数据位置必须与被加入的列的排列位置相对应
INSERT INTO `goods` (id,goods_name,price) -- 一般是按照顺序写
	VALUES('vivo手机',4,2000);  -- 错误的

INSERT INTO `goods` (goods_name,id,price) -- 很少这样写，但是可以执行成功
	VALUES('vivo手机',4,2000); 

#4. 字符和日期型数据应包含在单引号中
INSERT INTO `goods` (id,goods_name,price)
	VALUES(40,vivo手机,3000); -- 错误的 应该 'vivo手机'


#5. 列可以插入空值[前提是该字段允许为空]，insert into table value(null)
-- 在创建表时，该列没有写 NOT NULL 表示该列可以为NULL 

INSERT INTO `goods` (id,goods_name,price)
	VALUES(404,'vivo手机',NULL);
SELECT * FROM `goods`;

#6. insert into tab_name (列名..) values (),(),() 形式添加多条记录
INSERT INTO `goods` (id,goods_name,price)
	VALUES(50,'三星手机',4000),(60,'海尔手机',5000);
SELECT * FROM goods;
#7. 如果是给表中的所有字段添加数据，可以不写前面的字段名称
INSERT INTO `goods`
	VALUES(70,'IBM手机',7000);
SELECT * FROM goods;

#8. 默认值的使用，当不给某个字段值时，如果有默认值就会添加，否则报错
-- 如果某个列 没有指定 not null ,那么当添加数据时，没有给定值，则会默认给null
CREATE TABLE goods2 (
	id INT,
	`goods_name` VARCHAR(30),
	price INT NOT NULL DEFAULT 100)

INSERT INTO `goods`(id,goods_name)
	VALUES(705,'IBM手机');
SELECT * FROM goods2;

INSERT INTO `goods2`(id,goods_name)
	VALUES(705,'IBM手机');






