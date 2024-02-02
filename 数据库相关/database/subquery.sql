-- 子查询的演示
-- 思考：如何显示和SMITH同一个部门的所有员工？

/*
	1. 先查询到 SMITH的部门号
	2. 把上面的select 语句当作一个子查询来使用
	

*/

SELECT deptno -- 返回的数据只有一行 ，单行子查询
	FROM emp
	WHERE ename = 'SMITH';

SELECT *    
	FROM emp
	WHERE deptno = (
	SELECT deptno
	FROM emp
	WHERE ename = 'SMITH'
	);
	
-- 如何查询和部门10的工作相同的雇员的
-- 名字、岗位、工资、部门号，但是不包含部门自己的雇员

/*
	1.查询到部门10的工作类型有哪些
		
*/

SELECT * FROM emp;

SELECT DISTINCT job FROM emp
	WHERE deptno = 10;

SELECT ename,job,sal,deptno
	FROM emp
	WHERE job IN (
	SELECT DISTINCT job FROM emp
	-- WHERE deptno = 10; -- 这里不要带;分号了
	WHERE deptno = 10
	) AND deptno != 10;
	-- ) AND deptno <> 10;


SELECT * FROM ecshop.ecs_goods; -- 数据库名.表名
SELECT * FROM hsp_db02.emp
SELECT * FROM emp;

-- 查询ecshop中各个类别中，价格最高的商品
-- 先得到各个类别中，价格最高的商品 max + group by cat_id,当作临时表
-- 把子查询当作一张临时表可以解决很多很多复杂的查询

SELECT goods_id,cat_id,goods_name,shop_price FROM ecs_goods;
SELECT cat_id,shop_price FROM ecs_goods;

-- 按照类别分组，取出最高价格
SELECT cat_id,MAX(shop_price) -- 这样写会出现按照cat_id 进行了分组，但是分组后返回的数量和
			 -- 单独查询shop_price返回的行数 数量不一致 
	FROM ecs_goods
	GROUP BY cat_id;

SELECT goods_id,ecs_goods.cat_id,goods_name,shop_price 
	FROM (SELECT cat_id,MAX(shop_price) AS `max_price`			 
	FROM ecs_goods
	GROUP BY cat_id) temp,ecs_goods
	WHERE ecs_goods.cat_id = temp.cat_id 
	AND shop_price = temp.`max_price`
	
	

SELECT MAX(shop_price) FROM ecs_goods;

















