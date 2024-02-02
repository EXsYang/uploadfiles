-- 演示字符串相关函数的使用，使用emp表来演示
-- charset(str) 返回字符串字符集
SELECT CHARSET(ename) FROM emp;

-- concat (string2 [...]) 连接字符串,将多个列拼接成一列 逗号分割
SELECT CONCAT(ename, ' 工作是 ', job) FROM emp;

-- instr (string ,substring) 返回substring在string中出现的位置，没有返回0
-- dual 亚元表，系统表 可以作为测试表使用
SELECT INSTR('hanshunping','ping') FROM DUAL; -- 8  从一开始

-- ucase (string2) 转换成大写
-- lcase (string2) 转换成小写
SELECT UCASE(ename) FROM emp;
SELECT LCASE(ename) FROM emp;

-- left(string2,length) 从string2中的左边起取length个字符
-- right(string2,length) 从string2中的右边起取length个字符
SELECT LEFT(ename,2) FROM emp;
SELECT RIGHT(ename,3) FROM emp;

-- length(string) string长度【按照字节,返回 汉字一个占三个字节，字母一个占一个字节】
SELECT LENGTH(ename) FROM emp;
-- replace(str,search_str,replace_str) 在str中用replace_str 替换search_str
SELECT REPLACE(job,'MANAGER','经理') FROM emp; -- 这里区分大小写 小写的manager替换失败
SELECT * FROM emp;

-- strcmp(string1,string2) 逐字符比较两个字符串大小
SELECT STRCMP('yang','yang') FROM DUAL;
SELECT STRCMP('aang','yang') FROM DUAL;
SELECT STRCMP('yang','aang') FROM DUAL;

-- substring(str,position,[length]) 从str的position开始【从1开始计算】
SELECT SUBSTRING('hanshunping',1,3) FROM DUAL;
SELECT SUBSTRING('hanshunping',4) FROM DUAL;

-- ltrim(string2)/ rtrim(string2)/ trim  去除前端空格或后端空格，或两端空格都去除
SELECT LTRIM('  北京  ') FROM DUAL;
SELECT RTRIM('  nana   ') FROM DUAL;
SELECT TRIM('      daaa      ') FROM DUAL;

-- 练习：以首字母小写的方式显示所有员工emp表的姓名


SELECT CONCAT( LCASE(SUBSTRING(ename,1,1)) , SUBSTRING(ename,2)) AS '名字' FROM emp;
SELECT CONCAT( LCASE(LEFT(ename,1)) , SUBSTRING(ename,2)) AS '名字' FROM emp;





































