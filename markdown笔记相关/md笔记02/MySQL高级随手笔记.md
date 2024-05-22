# 1 docker 安装mysql8的命令



## 使用docker安装mysql8， 并设置root用户的密码为1234

~~~
docker run -d \
-p 3309:3306 \
-v mysql8_conf:/etc/mysql/conf.d \
-v mysql8_data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=1234 \
--name atguigu-mysql8 \
--restart=always \
mysql:8.0.30
~~~



### 查看数据卷

~~~
#查看docker数据卷 即docker容器中的目录 挂载到Linux本地的文件目录
docker volume ls
~~~



### 查询数据卷详情

命令如下所示：

~~~
#语法: docker volume inspect 数据卷名称
docker volume inspect mysql8_conf
docker volume inspect mysql8_data
~~~





# 2 为什么firewall中没有开启3309端口，但是Navicat却可以成功连接的Linux中的docker容器mysql8？



### 总结：Linux 防火墙与 Docker 配置分析

#### 1. 查看 Docker 网络配置
```bash
docker network ls
```
- **结果**:
  ```
  NETWORK ID     NAME      DRIVER    SCOPE
  0a35cc5dbce3   bridge    bridge    local
  b728280f257d   host      host      local
  8d525e0f3cb3   none      null      local
  ```
- **解释**: 
  显示当前 Docker 网络配置，包括 `bridge`、`host` 和 `none` 网络。此命令确认了 Docker 容器所使用的网络驱动和范围。

#### 2. 查看 `public` 区域的防火墙开放端口
```bash
firewall-cmd --zone=public --list-ports
```
- **结果**:
  ```
  80/tcp 10000/tcp 6379/tcp 6380/tcp 6381/tcp 6389/tcp 6390/tcp 6391/tcp 15672/tcp 5672/tcp
  ```
- **解释**:
  显示 `public` 区域中当前开放的端口列表，但未包括 3309 端口。

#### 3. 尝试查看 `docker0` 接口的防火墙配置
```bash
firewall-cmd --zone=docker0 --list-ports
```
- **结果**:
  ```
  Error: INVALID_ZONE: docker0
  ```
- **解释**:
  由于 `docker0` 不是有效的防火墙区域名称，此命令失败。

#### 4. 获取所有活动的防火墙区域
```bash
firewall-cmd --get-active-zones
```
- **结果**:
  ```
  docker
    interfaces: docker0
  public
    interfaces: ens33
  ```
- **解释**:
  显示当前活动的防火墙区域及其关联的网络接口。确认 `docker` 区域对应 `docker0` 接口，`public` 区域对应 `ens33` 接口。

#### 5. 查看 `docker` 区域的防火墙开放端口
```bash
firewall-cmd --zone=docker --list-ports
```
- **结果**:
  ```
  (无输出)
  ```
- **解释**:
  `docker` 区域未单独列出任何开放端口。

#### 6. 查看 `docker` 区域的详细防火墙配置
```bash
firewall-cmd --zone=docker --list-all
```
- **结果**:
  ```
  docker (active)
    target: ACCEPT
    icmp-block-inversion: no
    interfaces: docker0
    sources: 
    services: 
    ports: 
    protocols: 
    masquerade: no
    forward-ports: 
    source-ports: 
    icmp-blocks: 
    rich rules: 
  ```
- **解释**:
  `docker` 区域的目标设置为 `ACCEPT`，表示所有通过 `docker0` 接口的流量都会被允许，无需单独列出具体端口。

### 结论

此时的防火墙区域有两个，分别为`public`和`docker`

`firewall-cmd --list-all` 如果没有指定区域,默认为`--zone=public`。默认情况下，它会使用 `--zone=public`，除非已配置其他默认区域。

### 验证默认区域

~~~shell
#查看当前默认区域
firewall-cmd --get-default-zone

#要查看所有区域的详细配置，您可以分别指定每个区域，例如：
firewall-cmd --zone=public --list-all
firewall-cmd --zone=docker --list-all

~~~

当您运行 `firewall-cmd --list-all` 时，如果没有指定区域，它将显示默认区域的配置。默认区域通常是 `public`，但可以通过配置更改。如果您想要查看 `docker` 区域的配置，需要明确指定 `--zone=docker`。



**由于 `docker` 区域的目标是 `ACCEPT`，所有流量都被允许通过 `docker0` 接口。因此，即使防火墙未显示 3309 端口被开放，Docker 容器的端口映射功能依然可以正常工作，确保 Navicat 能够成功连接到 Docker 容器中的 MySQL 服务。**



# 3 Navicat中新建查询保存的物理地址位置



![image-20240519184704639](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240519184704639.png)





# 4 sql_mode案例(重点: ONLY_FULL_GROUP_BY)





~~~sql

-- 重点: ONLY_FULL_GROUP_BY     要求GROUP BY子句中的列必须出现在SELECT列表中，或者是聚合函数的参数，否则会抛出错误。

-- 默认设置: ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION 

SHOW VARIABLES LIKE 'sql_mode';



SET SESSION sql_mode = ''; -- 当前会话生效，关闭当前会话就不生效了。可以省略SESSION关键字

CREATE DATABASE atguigudb;
USE atguigudb;
CREATE TABLE employee(id INT, `name` VARCHAR(16),age INT,dept INT);
INSERT INTO employee VALUES(1,'zhang3',33,101);
INSERT INTO employee VALUES(2,'li4',34,101);
INSERT INTO employee VALUES(3,'wang5',34,102);
INSERT INTO employee VALUES(4,'zhao6',34,102);
INSERT INTO employee VALUES(5,'tian7',36,102);


SELECT * FROM `employee`;

-- 下面这个查询语句是正确的
SELECT dept,MAX(age) FROM `employee` GROUP BY dept;

-- 下面这个查询语句 当加了name字段后会报错，是错误的查询语句
-- 1055 - Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'atguigudb.employee.name' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

-- 1055-SELECT列表的表达式#1不在GROUP BY子句中，并且包含非聚合列“atguidb.employee.name”，该列在功能上不依赖于GROUP BY子句的列；这与sqlmode=only_full_group_by不兼容
SELECT `name`,dept,MAX(age) FROM `employee` GROUP BY dept;

~~~

## 4.1 解释上面的sql语句 `SELECT `name`,dept,MAX(age) FROM `employee` GROUP BY dept;` 为什么报错1055错误



您遇到的错误 1055 是 MySQL 在 `ONLY_FULL_GROUP_BY` 模式下的一个常见问题。在这种模式下，如果您使用 `GROUP BY` 子句，那么 `SELECT` 列表中的每个非聚合列都必须在 `GROUP BY` 子句中声明。这确保了每个选择的列都可以通过 `GROUP BY` 列表中的列唯一确定，从而避免了不明确的结果。

### 错误分析

在您的查询中：
```sql
SELECT `name`, dept, MAX(age) FROM `employee` GROUP BY dept;
```

- **`dept`** 是 `GROUP BY` 子句中的唯一列。
- **`MAX(age)`** 是一个聚合函数，它可以没有 `GROUP BY` 子句中的对应列。
- **`name`** 是一个非聚合列，它没有出现在 `GROUP BY` 子句中。

由于 `name` 不在 `GROUP BY` 子句中，并且不是一个聚合函数的参数，因此 MySQL 无法保证每个 `dept` 组内哪一个 `name` 应该被选择显示。这违反了 `ONLY_FULL_GROUP_BY` 模式的要求，导致错误 1055。

### 解决方案

要修正这个错误，您有几个选择：

1. **添加所有非聚合列到 `GROUP BY` 子句中**：
   这是最直接的解决方案，确保查询符合 `ONLY_FULL_GROUP_BY` 的要求。
   ```sql
   SELECT `name`, dept, MAX(age) FROM `employee` GROUP BY dept, `name`;
   ```

2. **使用聚合函数**：
   如果您仍想在不改变 `GROUP BY` 子句的情况下包含 `name`，可以考虑使用某种聚合函数，如 `MIN()` 或 `MAX()`，来决定在每个 `dept` 组内选择哪个 `name`。
   ```sql
   SELECT MAX(`name`) AS name, dept, MAX(age) FROM `employee` GROUP BY dept;
   ```

3. **修改 SQL 模式**：
   您已经提到了如何暂时或永久更改 SQL 模式以禁用 `ONLY_FULL_GROUP_BY`。对于当前会话，您可以这样做：
   ```sql
   SET sql_mode = '';
   ```
   这会允许您执行原始查询，但这种做法可能会隐藏数据问题，例如返回意外的或技术上不准确的行。

### 推荐做法

通常推荐的做法是尽可能在 `GROUP BY` 子句中包含所有非聚合列，或者清晰地定义您想如何聚合那些列。这不仅符合 SQL 标准的最佳实践，而且还确保了数据的准确性和查询结果的可预测性。



![image-20240520010017968](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240520010017968.png)



解释内连接`inner join... on...`

在您提供的代码和结果截图中，您使用了 `INNER JOIN` 来结合两个查询的结果：一个是通过 `GROUP BY` 聚合得到的结果集，另一个是原始的 `employee` 表。这个 `INNER JOIN` 的目的是连接这两个结果集以找出每个部门年龄最大的员工的具体信息。下面详细解释：

### SQL 查询的解释

1. **子查询**：
   ```sql
   SELECT dept, MAX(age) as maxAge FROM employee GROUP BY dept
   ```
   这个子查询根据部门对 `employee` 表进行分组，并计算每个部门的最大年龄。它返回两个字段：部门 (`dept`) 和该部门的最大年龄 (`maxAge`)。

2. **内连接查询**：
   ```sql
   SELECT e.name, groupage.dept, groupage.maxAge
   FROM (SELECT dept, MAX(age) as maxAge FROM employee GROUP BY dept) as groupage
   INNER JOIN employee e ON groupage.dept = e.dept AND groupage.maxAge = e.age
   ```
   - **子查询 `groupage`**：这是上面已经解释的子查询，结果被临时命名为 `groupage`。
   - **内连接 `INNER JOIN`**：这一步将 `groupage` 结果集与原始的 `employee` 表 `e` 进行连接。
   - **连接条件**：`ON groupage.dept = e.dept AND groupage.maxAge = e.age`。这个条件说明，只有当 `employee` 表中的 `dept` 和 `age` 字段分别与 `groupage` 结果集中的 `dept` 和 `maxAge` 字段匹配时，相关记录才会被连接起来。

### 目的和结果

这个查询的目的是要找出每个部门中年龄最大的员工的名字。通过 `INNER JOIN` 使用两个条件确保了只有当员工所在部门和年龄与每个部门的最大年龄完全匹配时，该员工的记录才会被选取。

结果集包含三个字段：
- **`name`**：符合条件的员工姓名。
- **`dept`**：员工所在的部门。
- **`maxAge`**：该部门的最大年龄。

通过这种方式，您能确切地获得每个部门年龄最大的员工的详细信息，而不仅仅是最大年龄数字。这是一个常用的方法来解决类似问题，特别是在需要从分组聚合的结果中进一步提取详细记录的场景中。

## 4.2 内连接和外连接的关系与区别是？

内连接（INNER JOIN）和外连接（OUTER JOIN）是 SQL 中两种常用的表连接方式，它们的用途是将两个或多个表中相关的行组合在一起，基于指定的连接条件。它们的主要区别在于如何处理不符合连接条件的行：

### 内连接（INNER JOIN）
- **定义**：内连接返回两个表中连接条件完全匹配的行。只有当两个表中的行在连接的字段上相等时，这些行才会出现在结果集中。
- **结果**：如果表 A 和表 B 进行内连接，那么结果中的每一行都会包含表 A 和表 B 中连接字段相匹配的信息。不匹配的行不会被包含在结果集中。
- **用途**：当你只想从两个表中获取那些在两边都有匹配的数据时使用内连接。



#### 内连接、sql_mode 的案例分析：

~~~mysql
-- 重点: ONLY_FULL_GROUP_BY     要求GROUP BY子句中的列必须出现在SELECT列表中，或者是聚合函数的参数，否则会抛出错误。

-- 默认设置: ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION 

SHOW VARIABLES LIKE 'sql_mode';



SET SESSION sql_mode = ''; -- 当前会话生效，关闭当前会话就不生效了。可以省略SESSION关键字

CREATE DATABASE atguigudb;
USE atguigudb;
CREATE TABLE employee(id INT, `name` VARCHAR(16),age INT,dept INT);
INSERT INTO employee VALUES(1,'zhang3',33,101);
INSERT INTO employee VALUES(2,'li4',34,101);
INSERT INTO employee VALUES(3,'wang5',34,102);
INSERT INTO employee VALUES(4,'zhao6',34,102);
INSERT INTO employee VALUES(5,'tian7',36,102);


SELECT * FROM `employee`;

-- 下面这个查询语句是正确的
SELECT dept,MAX(age) FROM `employee` GROUP BY dept;

-- 下面这个查询语句 当加了name字段后会报错，是错误的查询语句
-- 1055 - Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'atguigudb.employee.name' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

-- 1055-SELECT列表的表达式#1不在GROUP BY子句中，并且包含非聚合列“atguidb.employee.name”，该列在功能上不依赖于GROUP BY子句的列；这与sqlmode=only_full_group_by不兼容
SELECT `name`,dept,MAX(age) FROM `employee` GROUP BY dept;



-- 在 MySQL 中，聚合函数是用于执行计算在一组值上，并返回单一的值的函数。聚合函数通常用于 SELECT 语句中，与 GROUP BY 子句结合使用，用以汇总或聚合某列的数据。聚合函数忽略 NULL 值，只对非 NULL 值进行计算。 


-- 分组时，select 语句列名聚合函数（max min avg sum count），分组字段 name不能出现在select后面，因为SQL_MODE 包括 ONLY_FULL_GROUP_BY
-- 在 ONLY_FULL_GROUP_BY 模式下的限制，即在使用 GROUP BY 的时候，非聚合列（如此处的 name）不能出现在 SELECT 语句中，除非它们被包括在 GROUP BY 中。
--  尝试选择 name, dept, 和 max(age) 而没有将 name 包含在 GROUP BY 中。这在 ONLY_FULL_GROUP_BY 模式下会导致错误。
select name,dept,max(age) from employee
group by dept;


-- 设置 SQL 模式的命令 修改会话的 SQL 模式，去除所有默认模式，这样可以临时绕过 ONLY_FULL_GROUP_BY 的限制。
SET SESSION sql_mode = ''; -- 当前会话生效，关闭当前会话就不生效了。可以省略SESSION关键字

-- 去掉ONLY_FULL_GROUP_BY约束，下面这条语句才会查询出结果，name值不对。
-- 在 SQL 模式被修改后尝试执行同样的查询，此时不会报错，但是返回的 name 值可能不准确，因为没有对应的聚合约束。
select name,dept,max(age) as maxAge from employee group by dept;

-- 去掉ONLY_FULL_GROUP_BY约束, 下面这条语句才会查询出正确的结果。
-- 这里是对解决 ONLY_FULL_GROUP_BY 问题的一种正确做法的示例，首先通过子查询找到每个部门的最大年龄，然后通过内连接（INNER JOIN）根据部门和最大年龄来确保 name 的正确性。
select e.name,groupage.dept,groupage.maxAge
from (select dept,max(age) as maxAge from employee group by dept) as groupage
inner join employee e
on groupage.dept = e.dept and groupage.maxAge=e.age;

~~~



### 内连接的详细解释:

在 SQL 的内连接（INNER JOIN）中，关键是理解连接是基于哪些条件进行的，而不必关注表的左右或主从关系。内连接的核心在于它返回所有在两个或多个表中根据指定的连接条件匹配的行。

### 内连接的特点
- **连接条件**：连接基于等式条件，这些条件定义了如何匹配两个表的行。连接条件可以是单一的（比如只连接一个字段），也可以是多重的（多个字段一起决定连接），如 `ON table1.column = table2.column`。
- **连接结果**：结果集中的每一行都是通过连接条件在两个表中找到匹配的行组合而成。只有两个表中同时满足条件的行才会出现在结果中。

### 内连接中没有“主表”或“从表”概念
内连接不像外连接那样区分左表或右表。在内连接中，两个表都是平等的：只要满足连接条件，两个表中的记录就会连接在一起。如果不满足连接条件，则两个表中的相关记录都不会出现在结果集中。

### 多重条件内连接
在您给出的示例中：
```sql
SELECT e.name, groupage.dept, groupage.maxAge
FROM (SELECT dept, MAX(age) AS maxAge FROM employee GROUP BY dept) AS groupage
INNER JOIN employee e ON groupage.dept = e.dept AND groupage.maxAge = e.age;
```
这里的连接条件有两个：`groupage.dept = e.dept` 和 `groupage.maxAge = e.age`。

- **连接逻辑**：只有当 `groupage` 中的记录与 `employee` 表中的记录在 `dept` 和 `maxAge` 字段上都相等时，这两条记录才会联接。这意味着内连接会从 `groupage` 子查询和 `employee` 表中找出部门相同且年龄也是该部门最大的员工记录。

- **结果解释**：结果集将包括满足上述两个条件的所有 `employee` 的 `name`，以及他们的 `dept` 和 `maxAge`。这样的查询特别有用，当你需要找到每个部门年龄最大的员工时。

总的来说，内连接是基于每个表的指定列必须相等的原则工作的，不考虑表的左右位置或主从关系，只要连接条件成立，相关的记录就会出现在最终的查询结果中。

### 外连接（OUTER JOIN）
- **类型**：
  - **左外连接（LEFT OUTER JOIN）**：返回左表（SQL 语句中 JOIN 关键字左侧的表）的所有行，即使在右表中没有匹配的行。如果右表中没有匹配的行，则结果中这部分对应的列将包含 NULL。
  - **右外连接（RIGHT OUTER JOIN）**：返回右表的所有行，即使在左表中没有匹配的行。如果左表中没有匹配的行，则结果中这部分对应的列将包含 NULL。
  - **全外连接（FULL OUTER JOIN）**：结合了左外连接和右外连接的特性，返回左表和右表中的所有行。如果某一边没有匹配的行，则结果中这部分对应的列将包含 NULL。
- **结果**：外连接会包含至少一个表中的所有行，即使它们在另一个表中没有匹配。
- **用途**：当你需要从一个或两个表中获取数据，并且想要查看即使在另一表中没有匹配也存在的行时使用外连接。

### 关系与区别
- **包含关系**：内连接的结果是外连接结果的一个子集。即，所有在内连接中显示的行也会出现在相应的外连接中，但外连接可能包含更多因为只在一个表中有匹配的行。
- **选择性**：内连接可以视为更加严格的连接，它只会返回两边完全匹配的结果；而外连接则更加宽松，它可以返回至少一边有数据的所有可能的结果。
- **应用场景**：选择内连接还是外连接取决于你的数据需求。如果你需要的数据必须在两个表中都有记录，那么应该使用内连接；如果你需要查看即使没有关联的数据也要显示的信息，则应该使用外连接。

总之，选择正确的连接类型对于达到查询的目的和效率都非常关键。



## 4.3 内连接和外连接的具体示例

假设我们有两个简单的表，一个是 `employees` 表和另一个是 `departments` 表。这两个表通过 `department_id` 关联。下面是每个表的简单结构和一些示例数据，以及如何使用内连接、左外连接和右外连接来查询数据。

### 表结构和示例数据

**employees 表**:
```
+------------+-----------+---------------+
| employee_id| name      | department_id |
+------------+-----------+---------------+
| 1          | Alice     | 1             |
| 2          | Bob       | 2             |
| 3          | Charlie   | 3             |
| 4          | David     | NULL          |
+------------+-----------+---------------+
```

**departments 表**:
```
+---------------+-----------------+
| department_id | department_name |
+---------------+-----------------+
| 1             | HR              |
| 2             | Engineering     |
| 3             | Marketing       |
| 5             | Sales           |
+---------------+-----------------+
```

### SQL 查询示例

#### 1. 内连接 (INNER JOIN)
- **描述**：只返回两个表中有匹配的行。
- **代码**：
```sql
SELECT employees.name, departments.department_name
FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id;
```
- **结果**：
```
+---------+-----------------+
| name    | department_name |
+---------+-----------------+
| Alice   | HR              |
| Bob     | Engineering     |
| Charlie | Marketing       |
+---------+-----------------+
```

#### 2. 左外连接 (LEFT OUTER JOIN)
- **描述**：返回 `employees` 表的所有行，即使在 `departments` 表中没有匹配的行。
- **代码**：
```sql
SELECT employees.name, departments.department_name
FROM employees
LEFT OUTER JOIN departments ON employees.department_id = departments.department_id;
```
- **结果**：
```
+---------+-----------------+
| name    | department_name |
+---------+-----------------+
| Alice   | HR              |
| Bob     | Engineering     |
| Charlie | Marketing       |
| David   | NULL            |
+---------+-----------------+
```
David 没有对应的部门因为 `department_id` 是 NULL。

#### 3. 右外连接 (RIGHT OUTER JOIN)
- **描述**：返回 `departments` 表的所有行，即使在 `employees` 表中没有匹配的行。
- **代码**：
```sql
SELECT employees.name, departments.department_name
FROM employees
RIGHT OUTER JOIN departments ON employees.department_id = departments.department_id;
```
- **结果**：
```
+---------+-----------------+
| name    | department_name |
+---------+-----------------+
| Alice   | HR              |
| Bob     | Engineering     |
| Charlie | Marketing       |
| NULL    | Sales           |
+---------+-----------------+
```
部门 "Sales" 没有对应的员工。

这些示例清晰地展示了不同类型的 SQL 连接如何工作，以及它们在实际数据查询中的应用。每种连接类型的选择取决于你想从查询中得到什么样的结果。





# 5 MySQL聚合函数



### 聚合函数的定义

在 MySQL 中，聚合函数是用于执行计算在一组值上，并返回单一的值的函数。聚合函数通常用于 `SELECT` 语句中，与 `GROUP BY` 子句结合使用，用以汇总或聚合某列的数据。聚合函数忽略 `NULL` 值，只对非 `NULL` 值进行计算。

### MySQL中常用的聚合函数

1. **SUM()**：计算数值列的总和。
   ```sql
   SELECT SUM(salary) FROM employees;
   ```

2. **AVG()**：计算数值列的平均值。
   ```sql
   SELECT AVG(salary) FROM employees;
   ```

3. **MAX()**：返回一列中的最大值。
   ```sql
   SELECT MAX(salary) FROM employees;
   ```

4. **MIN()**：返回一列中的最小值。
   ```sql
   SELECT MIN(salary) FROM employees;
   ```

5. **COUNT()**：
   - **COUNT(*)**：计算表中行的数量，包括 NULL 值。
     ```sql
     SELECT COUNT(*) FROM employees;
     ```
   - **COUNT(column)**：计算指定列中非 NULL 值的数量。
     ```sql
     SELECT COUNT(salary) FROM employees;
     ```

6. **GROUP_CONCAT()**：将来自多个行的字符串值连接为一个字符串，通常用于 `GROUP BY` 子句中。
   ```sql
   SELECT GROUP_CONCAT(name) FROM employees GROUP BY department_id;
   ```

### 特殊聚合函数
除了上述常用的聚合函数外，MySQL 还提供一些特殊的聚合函数，如：

1. **STD() / STDDEV() / STDDEV_POP()**：计算标准差。
2. **VARIANCE() / VAR_POP()**：计算方差。

### 聚合函数的使用注意事项
- **与 GROUP BY 的结合**：当与 `GROUP BY` 子句一起使用时，聚合函数将根据分组键对数据进行汇总。
- **聚合函数和非聚合列的组合**：在包含 `GROUP BY` 的查询中，除聚合函数之外的所有列都应包含在 `GROUP BY` 子句中，除非你修改了默认的 SQL 模式以允许这种行为。

聚合函数是数据库查询中非常强大的工具，它们可以帮助你快速得到大量数据的统计信息，从而支持决策分析和数据报告。



# 6 MySQL中的DML,DDL,DCL

在 MySQL 中，SQL 语言根据其操作类型可以分为几种不同的类别：数据操纵语言（DML），数据定义语言（DDL），和数据控制语言（DCL）。这些类别帮助组织 SQL 语句，使它们执行特定的数据库操作。下面是每一种类别的简单解释和一些常见的命令示例。

### 数据操纵语言（DML）

**数据操纵语言**用于处理数据库中的数据。它包括插入、修改、删除和查询数据库中的数据。这些是日常数据库交互中最频繁使用的命令。

- **SELECT**：查询数据库中的数据，是最常用的 DML 操作。
  ```sql
  SELECT name, age FROM users WHERE age > 18;
  ```
- **INSERT**：向数据库表中插入新的数据行。
  ```sql
  INSERT INTO users(name, age) VALUES ('Alice', 22);
  ```
- **UPDATE**：修改数据库表中的已有数据。
  ```sql
  UPDATE users SET age = 23 WHERE name = 'Alice';
  ```
- **DELETE**：从数据库表中删除数据。
  ```sql
  DELETE FROM users WHERE name = 'Alice';
  ```

### 数据定义语言（DDL）

**数据定义语言**用于定义和修改数据库结构，如创建、修改、删除表和数据库等结构。

- **CREATE**：创建新的数据库或数据库表。
  ```sql
  CREATE TABLE users (id INT AUTO_INCREMENT, name VARCHAR(100), age INT, PRIMARY KEY(id));
  ```
- **ALTER**：修改现有的数据库结构，如添加、删除或修改列。
  ```sql
  ALTER TABLE users ADD email VARCHAR(255);
  ```
- **DROP**：删除整个表或数据库。
  ```sql
  DROP TABLE users;
  ```
- **TRUNCATE**：快速删除表中的所有行，但不删除表本身。
  ```sql
  TRUNCATE TABLE users;
  ```

### 数据控制语言（DCL）

**数据控制语言**用于定义数据库的安全策略和权限控制。这涉及到授予权限以及回收权限。

- **GRANT**：给用户授权，如允许用户访问特定的数据库对象。
  ```sql
  GRANT SELECT, INSERT ON users TO 'someuser'@'localhost';
  ```
- **REVOKE**：撤销用户的权限。
  ```sql
  REVOKE INSERT ON users FROM 'someuser'@'localhost';
  ```

这些 SQL 类别的使用取决于您需要进行的操作类型——是否是在查询/修改数据，改变数据库结构，还是管理数据库的访问权限。每种操作类型都有其特定的命令集，以支持数据库管理和数据操作的不同方面。

# 7 简单解释一下JDBC的7个过程

JDBC (Java Database Connectivity) 是一个用于 Java 应用程序的 API，它允许 Java 程序通过标准的方法连接和执行数据库操作。JDBC 定义了如何连接到数据库以及如何发送 SQL 或 PL/SQL 命令并处理返回结果。与数据库的交互通常包括以下六个基本步骤：

### 1. 导入 JDBC 包
在 Java 程序中，需要导入包含 JDBC 类的包，这是使用 JDBC 的第一步。常见的导入语句如下：
```java
import java.sql.*;
```
这个语句导入了所有与 JDBC 交互所需的类。

### 2. 注册 JDBC 驱动
要连接数据库，首先必须加载并注册 JDBC 驱动。这可以通过使用 `Class.forName()` 方法来实现，它告诉 JVM 加载并初始化指定的驱动程序类。
```java
Class.forName("com.mysql.cj.jdbc.Driver");
```
对于现代 JDBC 驱动程序，因为 JDBC 4.0+ 自动加载驱动，这一步通常可以省略。

### 3. 建立连接
使用 `DriverManager` 的 `getConnection` 方法来建立到数据库的连接。这需要提供数据库的 URL，以及数据库的用户名和密码。
```java
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "user", "password");
```
此步骤返回 `Connection` 对象，该对象用于后续与数据库的所有交互。

### 4. 创建 Statement 对象
通过连接对象创建一个 `Statement` 对象，以便发送 SQL 语句到数据库。
```java
Statement stmt = conn.createStatement();
```
还可以创建 `PreparedStatement` 对象，以执行带或不带 IN 参数的预编译 SQL 语句。

### 5. 执行 SQL 查询
使用 `Statement` 对象来执行 SQL 语句。这可以是 SELECT 查询或任何更新语句（INSERT, UPDATE, DELETE）。
```java
ResultSet rs = stmt.executeQuery("SELECT * FROM employees");
```
对于更新语句，使用 `executeUpdate()` 方法：
```java
int rowsAffected = stmt.executeUpdate("UPDATE employees SET age = 25 WHERE id = 101");
```

### 6. 处理结果
如果执行的是查询，需要处理 `ResultSet` 对象来访问结果集。
```java
while (rs.next()) {
    String name = rs.getString("name");
    int age = rs.getInt("age");
    System.out.println("Name: " + name + ", Age: " + age);
}
```
对于更新语句，则可能需要处理返回的行数或使用其他方法来确认操作的效果。

### 7. 清理环境
最后，需要关闭 `ResultSet`、`Statement` 和 `Connection` 对象，以释放数据库资源。
```java
rs.close();
stmt.close();
conn.close();
```
这些步骤确保所有数据库资源都被适当管理和释放。

遵循这七个步骤可以有效地通过 JDBC 连接和操作数据库，无论是进行查询还是更新操作。







# 8 InnoDB引擎的外键约束



~~~mysql
create table country_innodb(
	country_id int NOT NULL AUTO_INCREMENT,
    country_name varchar(100) NOT NULL,
    primary key(country_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


create table city_innodb(
	city_id int NOT NULL AUTO_INCREMENT,
    city_name varchar(50) NOT NULL,
    country_id int NOT NULL,
    primary key(city_id),
    CONSTRAINT `fk_city_country` FOREIGN KEY(country_id) REFERENCES country_innodb(country_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into country_innodb values(null,'China'),(null,'America'),(null,'Japan');
insert into city_innodb values(null,'Xian',1),(null,'NewYork',2),(null,'BeiJing',1);	
~~~



**解释下面的语句的意思**

~~~mysql
CONSTRAINT `fk_city_country` FOREIGN KEY(country_id) REFERENCES country_innodb(country_id) ON DELETE RESTRICT ON UPDATE CASCADE
~~~



在您提供的 SQL 代码中，`CONSTRAINT` 语句用于定义外键约束 `fk_city_country`，这个外键约束是在 `city_innodb` 表中对 `country_id` 列设置的。让我们一步步解释这个约束的各个部分：

### CONSTRAINT `fk_city_country`

- **CONSTRAINT** 关键字用于定义一个约束，并给它命名。在这种情况下，约束被命名为 `fk_city_country`。命名约束可以帮助在以后需要修改或删除约束时更容易地引用它。

### FOREIGN KEY(country_id)

- **FOREIGN KEY(country_id)** 指明 `city_innodb` 表中的 `country_id` 列是一个外键，它将与另一表中的列（这里是 `country_innodb` 表的 `country_id`）建立链接。

### REFERENCES country_innodb(country_id)

- **REFERENCES country_innodb(country_id)** 指定外键的目标表和列。在这里，它表示 `city_innodb` 表的 `country_id` 列引用了 `country_innodb` 表的 `country_id` 列。

### ON DELETE RESTRICT

- **ON DELETE RESTRICT** 定义了当尝试删除父表（即含有被参考主键的表，这里是 `country_innodb`）中的一条记录时的行为。`RESTRICT` 选项会阻止删除操作，如果存在至少一个依赖于该记录的外键（即存在至少一个城市仍然引用这个国家的 `country_id`），删除操作将被拒绝。

### ON UPDATE CASCADE

- **ON UPDATE CASCADE** 定义了当更新父表中的主键时的行为。`CASCADE` 选项意味着如果 `country_innodb` 表中的 `country_id` 被修改，所有引用该 `country_id` 的 `city_innodb` 表中的 `country_id` 也会相应地被自动更新。这保证了引用的完整性，防止了数据之间的不一致。

这些约束确保了数据库的引用完整性，防止了数据不一致的情况发生。通过使用外键约束，可以确保 `city_innodb` 表中的 `country_id` 总是指向 `country_innodb` 表中有效的 `country_id`，并且在删除或更新关键数据时，依赖关系得到妥善处理。



# 9 在 SQL 中，左右外连接、主表从表以及外键约束是数据库关系和数据完整性管理的重要概念。让我们逐一详细解释这些概念及它们之间的关系：

### 1. 左右外连接（LEFT AND RIGHT OUTER JOIN）

外连接（Outer Joins）用于在两个表之间进行查询，不仅返回满足连接条件的行，还返回左表（LEFT OUTER JOIN）或右表（RIGHT OUTER JOIN）中未找到匹配的行。

- **左外连接（LEFT OUTER JOIN）**：
  - 这种连接返回左表中的所有行，即使右表中没有匹配的行。
  - 在没有匹配的情况下，右表中的列将以 NULL 形式显示。

- **右外连接（RIGHT OUTER JOIN）**：
  - 这种连接返回右表中的所有行，即使左表中没有匹配的行。
  - 在没有匹配的情况下，左表中的列将以 NULL 形式显示。

### 2. 主表与从表（Parent and Child Tables）

在涉及外键约束的数据库设计中，通常会有两种表：主表和从表。

- **主表（Parent Table）**：
  - 包含主键的表，其他表的外键列指向此表的主键。
  - 在删除或更新主表中的行时，必须考虑到从表中依赖这些行的数据。

- **从表（Child Table）**：
  - 包含外键的表，这些外键引用主表的主键。
  - 从表的完整性依赖于主表中对应行的存在。

### 3. 外键约束（Foreign Key Constraint）

外键约束用于保持数据之间的引用完整性和一致性。它确保从表中的一个字段（外键）必须是主表中对应字段（主键）的有效值。

- **作用**：
  - 确保在引用的主表中存在对应的值。
  - 控制主表中数据被删除或修改时对从表的影响（通过 ON DELETE 和 ON UPDATE 规则）。

- **ON DELETE 和 ON UPDATE 约束**：
  - **ON DELETE RESTRICT**：防止删除主表中被从表引用的行。
  - **ON DELETE CASCADE**：当删除主表中的行时，同时删除从表中依赖这些行的数据。
  - **ON UPDATE CASCADE**：当主表中的行被更新时，自动更新从表中依赖这些行的数据。

### 关系分析

在一个典型的关系数据库中，外键约束定义了表之间的依赖关系（主从关系），而左右外连接则提供了在查询过程中如何视图合并这些表的数据的灵活性。外键确保了数据的完整性和一致性，而外连接则允许在查询时包括那些在关联表中没有直接匹配的行，从而提供了更全面的数据视图。

总结来说，理解这些概念及其在 SQL 查询和数据库设计中的应用对于构建有效、健壮和高效的数据库系统至关重要。



# 10 从表的外键一般都指向主表的主键吗？是的，通常情况下，从表中的外键确实会指向主表的主键。这种设计方法保证了两个关键方面的数据完整性和引用的有效性：

### 1. 唯一性
主键的定义就是要确保主表中的每一行都是唯一的。这种唯一性是通过主键约束来实施的，它禁止任何重复值的出现。由于主键保证了表中每行的唯一性，因此，将从表的外键指向主表的主键能够确保每个外键值都对应一个有效且唯一的记录。

### 2. 引用完整性
外键约束用来维护数据库的引用完整性，确保从表中的数据项只能取那些在主表中已经存在的值。如果外键指向主表的主键，就可以保证这种引用关系总是有效的，因为主键的值必须存在且是唯一的。外键约束防止了以下情况的发生：
- 在从表中插入一个不存在于主表主键列中的值。
- 从主表中删除某个被从表作为外键引用的值，除非有特定的级联操作被定义（如 `ON DELETE CASCADE`）。

### 特殊情况
尽管将从表的外键指向主表的主键是最常见的实践，但也有特殊情况，例如：
- **外键指向非主键列**：在某些情况下，外键可能指向主表中的非主键列，但这要求非主键列具有唯一约束，以保证引用的有效性和唯一性。
- **复合外键**：外键可能由多个列组成，这种情况通常发生在复合主键的场景中，即外键将引用主表的复合主键。

### 设计建议
在数据库设计中，推荐从表的外键指向主表的主键，因为这样做可以最大限度地减少数据冗余和维护引用完整性的复杂性。这种方法也使得数据模型更清晰、更易于管理。

通过这种方式，数据库设计不仅能保证数据操作的正确性，还能提高查询效率，因为数据库管理系统（DBMS）通常对主键列进行优化，如自动索引等。



# 11 解释在MySQL的InnoDB存储引擎中，非聚簇索引为什么会回表查询？

在MySQL的InnoDB存储引擎中，非聚簇索引（也称为辅助索引）进行回表查询的原因主要与其存储结构和聚簇索引的存在方式有关。

### 聚簇索引的结构
在InnoDB中，聚簇索引不仅是一个索引，它实际上存储了整个表的数据。每个数据行都存放在聚簇索引的叶子节点中，并且按照聚簇索引键（通常是主键）的顺序物理存储。这意味着如果你直接通过聚簇索引键进行查询，你可以非常快速地定位到数据行。

### 非聚簇索引的结构
非聚簇索引，或辅助索引，是根据表中的非主键列建立的。它的叶子节点并不直接存储整行数据，而是存储了对应行的聚簇索引键（即主键值）。这种设计使得非聚簇索引相对较小，可以更快速地加载和搜索。

### 回表查询的过程
当你使用非聚簇索引进行查询时（例如，基于一个非主键的属性进行搜索），查询操作首先在非聚簇索引中找到匹配的条目。这些条目包含了对应数据行的聚簇索引键（主键值）。

然而，因为非聚簇索引的叶子节点不直接包含完整的行数据，所以一旦找到了匹配的聚簇索引键，数据库还需要进行第二步操作：使用这些聚簇索引键回到聚簇索引（即回表查询），找到并读取完整的数据行。这个过程称为“回表”查询，因为它需要返回到聚簇索引表中去检索完整的数据。

### 为什么需要回表查询
1. **空间效率**：非聚簇索引如果包含了完整的行数据，将会非常大并且不高效，因为这样会有大量数据重复存储（一份在聚簇索引，一份在每个非聚簇索引）。
2. **性能权衡**：通过仅存储指向聚簇索引键的指针，非聚簇索引可以保持较小的尺寸，这使得加载和搜索索引更快。但是这种设计需要额外的步骤来回表查询完整数据。

综上所述，回表查询是InnoDB优化数据存储和检索效率的一种结果。虽然它引入了额外的查询步骤，但这是为了整体性能考虑的权衡。



# 12 关于Mysql的聚簇索引和非聚簇索引，比如当查询select * ...进行非聚簇索引的查询时，一般会回表查询，但是如果没有创建过该表的聚簇索引，这时mysql是如何解决的？



在MySQL中，聚簇索引和非聚簇索引的工作方式与表的存储引擎有关，尤其是InnoDB存储引擎。

### 聚簇索引（Clustered Index）
在InnoDB中，聚簇索引通常是基于主键的。表的数据实际上存储在聚簇索引的叶子节点中。如果表定义了主键，那么聚簇索引就是基于这个主键建立的。如果没有显式定义主键，InnoDB会选择一个唯一索引作为聚簇索引。如果表中没有任何唯一索引，InnoDB会自动创建一个隐藏的ROW_ID来作为聚簇索引。

### 非聚簇索引（Non-Clustered Index）
非聚簇索引，或称为辅助索引（Secondary Index），在InnoDB中的实现是指向聚簇索引记录的指针。这意味着，当使用非聚簇索引查询数据时，索引会首先查找到聚簇索引的键，然后通过该键来定位到数据行。

### 回表查询（Bookmark Lookup）
当你使用非聚簇索引进行查询时，如`SELECT * FROM table WHERE non_clustered_index_column = some_value`，查询操作首先在非聚簇索引中查找满足条件的条目，得到对应的聚簇索引键，然后再通过聚簇索引键来访问实际的数据行。这个过程就是所谓的“回表”查询。

### 如果没有聚簇索引
在InnoDB中，总会有聚簇索引，因为它是按上述方式自动管理的。如果你没有显式创建聚簇索引（即主键），InnoDB会使用一个内部的ROW_ID作为聚簇索引。因此，即使没有显式定义聚簇索引，回表查询依然可以正常进行，因为每个非聚簇索引条目会包含一个指向聚簇索引（可能是内部ROW_ID）的指针。

因此，不论表中是否显式定义了聚簇索引，InnoDB总是能够通过某种方式（主键、唯一索引或内部ROW_ID）来解决数据的定位问题。



# 13 "在InnoDB中，总会有聚簇索引",也就是说当一个表创建好后就已经有一个聚簇索引可以用了?

是的，正是这样。在InnoDB存储引擎中，一旦表被创建，就自动拥有了聚簇索引。这种聚簇索引的创建有以下几种情况：

1. **显式主键**：如果在创建表时定义了主键，那么这个主键就会被用作聚簇索引。聚簇索引会直接存储行数据，主键值用于行数据的物理排序。

2. **唯一索引**：如果表没有定义主键，但有一个或多个唯一索引，InnoDB会选择第一个不包含任何空值的唯一索引来作为聚簇索引。

3. **内部ROW_ID**：如果表中既没有定义主键，也没有合适的唯一索引（所有唯一索引都可能包含空值），InnoDB会自动生成一个名为ROW_ID的隐藏列，并以此作为聚簇索引。这个ROW_ID是一个内部生成的唯一标识符，用户通常看不到也不需要关心它。

因此，每个InnoDB表都有一个聚簇索引，无论开发者是否显式指定。这是InnoDB的核心特性之一，使得基于主键的查找非常高效。同时，这种设计也意味着非聚簇索引（即辅助索引）需要存储相应的聚簇索引键（即主键值或ROW_ID），以便可以通过非聚簇索引定位到具体的数据行。





# 14 在MySQL8中，`.ibd`文件扩展名代表的是“**InnoDB Data File**”，这是InnoDB存储引擎的表数据文件。`.ibd`文件是InnoDB表空间的一部分，用于存储数据和索引。

![image-20240521174640003](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240521174640003.png)

![image-20240521174758534](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240521174758534.png)

### 中文意思
`.ibd`文件的中文意思可以译为“**InnoDB数据文件**”。

### 使用场景
在MySQL的InnoDB存储引擎中，可以配置表数据存储在共享的表空间中，也可以配置每个表使用独立的`.ibd`文件存储数据和索引。使用独立的文件有助于提升数据管理的灵活性，比如更容易的进行备份和恢复。

独立的`.ibd`文件存储方式通过`innodb_file_per_table`选项来控制。当这个选项设置为`ON`时，每个InnoDB表会使用单独的`.ibd`文件存储数据和索引。当设置为`OFF`时，所有表的数据和索引将存储在共享的表空间中，通常是`ibdata1`文件。



# 15 



























