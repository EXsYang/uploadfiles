-- 日期时间相关函数

-- current_date() 当前日期
SELECT CURRENT_DATE() FROM DUAL; -- () 加不加都行
-- current_time() 当前时间
SELECT CURRENT_TIME() FROM DUAL;
-- current_timestamp() 当前时间戳
SELECT CURRENT_TIMESTAMP() FROM DUAL;

SELECT NOW() FROM DUAL;

-- 创建测试表 信息表
CREATE TABLE mes(id INT, content VARCHAR(30),sendtime DATETIME);

-- 添加一条记录
INSERT INTO mes
	VALUES(1,'北京新闻',CURRENT_TIMESTAMP());
INSERT INTO mes
	VALUES(2,'上海新闻',NOW());
INSERT INTO mes 
	VALUES(3,'广州新闻',NOW());

SELECT * FROM mes;

SELECT NOW() FROM DUAL;

-- 应用实例
-- 显示所有新闻信息，发布日期只显示日期，不用显示时间
SELECT id,content,DATE(sendtime)
	FROM mes;

-- 查询在10分钟内发布的新闻
SELECT * 
	FROM mes
	WHERE DATE_ADD(sendtime, INTERVAL 10 MINUTE) >= NOW(); -- sendtime 加上10分钟

SELECT * 
	FROM mes
	WHERE sendtime >= DATE_SUB(NOW(), INTERVAL 10 MINUTE); -- 
	-- sendtime 大于等于 now() 减去 10分钟

-- 求出2011-11-11 和 1990-1-1 相差多少天
SELECT DATEDIFF('2011-11-11','1990-01-01') FROM DUAL;
-- 求出你活了多少天
SELECT DATEDIFF(NOW(),'1998-03-27') FROM DUAL;
SELECT DATEDIFF('1998-03-21','1998-03-23') FROM DUAL;
 -- 得到的是天数 前面的日期-后面的日期 ，可能是 负数
-- 如果你能活80岁，求出你还能活多少天
-- DATE_ADD(date1, INTERVAL 80 YEAR) date1 可以是date,datetime,timestamp
-- INTERVAL 80 YEAR: YEAR 可以是 年月日，时分秒 year month day minute second hour 
SELECT DATEDIFF((DATE_ADD('1998-03-07', INTERVAL 80 YEAR)) ,NOW()) FROM DUAL; -- 

SELECT TIMEDIFF('10:10:11','04:10:10') FROM DUAL;

-- YEAR|Month|DAY DATE (datetime)
SELECT YEAR(NOW()) FROM DUAL;
SELECT MONTH(NOW()) FROM DUAL;
SELECT DAY(NOW()) FROM DUAL;
SELECT MONTH('2022-02-02') FROM DUAL;

-- unix_timestamp() : 返回的是1970-1-1 到现在的秒数
SELECT UNIX_TIMESTAMP() FROM DUAL;

-- from_unixtime() :可以把一个unix_timestamp 秒数，转成指定格式的日期

-- %Y-%m-%d 格式是规定好的，表示年月日
-- 意义：在开发中，可以存放一个整数，然后表示时间，通过FROM_UNIXTIME转换
-- select from_unixtime('1671288382','%Y-%m-%d') from dual;
SELECT FROM_UNIXTIME(1671288355,'%Y-%m-%d') FROM DUAL;
SELECT FROM_UNIXTIME(1671288355,'%Y-%m-%d %H:%i:%s') FROM DUAL;














































