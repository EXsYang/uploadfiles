-- homework01.sql
SELECT ename,sal*12 AS "Annual Salary" FROM emp
SELECT ename,sal salary FROM emp ORDER BY sal;  -- 默认升序 ASC
SELECT ename,sal salary FROM emp ORDER BY salary ASC; -- 升序
SELECT ename,sal salary FROM emp ORDER BY salary DESC; -- 降序