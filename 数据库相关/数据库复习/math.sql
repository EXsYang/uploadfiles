-- 演示数学相关函数

-- ABS(num) 绝对值
SELECT ABS(-10) FROM DUAL;

-- bin(decimal_number)十进制转二进制
SELECT BIN(10) FROM DUAL;

-- ceiling(number2) 向上取整，得到比num2 大的最小整数
SELECT CEILING(1.1) FROM DUAL; -- 2

-- conv(number2,from_base,to_base) 进制转换 conversion(转换)
-- 下面的含义是 3 是十进制的 3，转换成二进制输出
SELECT CONV(3,10,2) FROM DUAL;
-- 下面的含义是 6 是8进制的 6，转换成二进制输出
SELECT CONV(6,8,2) FROM DUAL;
-- floor(number2) 向下取整，得到比 num2小的最大整数 
SELECT FLOOR(-1.2) FROM DUAL;

-- format(number,decimal_places) 保留小数位数 四舍五入 
SELECT FORMAT(105678.23545,2) FROM DUAL;

-- hex(DecimalNumber) 转十六进制
SELECT HEX(10) FROM DUAL;

-- least(number,number2 ...) 	求最小值
SELECT LEAST(-1,22,3,55) FROM DUAL;

-- mod(numerator,denominator) 求余
SELECT MOD(-10,3) FROM DUAL; -- 被模数、模数，符号与被模数相同

-- rand([seed]) rand() 随机数 范围 0 <= v <= 1
-- 如果使用rand() m每次返回不同的随机数，在 0 <= v <= 1.0
-- 如果使用rand(seed) m每次返回随机数，在 0 <= v <= 1.0,如果seed不变
-- 该随机数也不变了



SELECT RAND(3) FROM DUAL;
SELECT RAND() FROM DUAL;























