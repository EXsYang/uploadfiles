-- DROP TABLE `member`
-- 创建 admin表
CREATE TABLE `admin`( 
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`admin_name` VARCHAR(32) NOT NULL UNIQUE, 
`admin_pwd` VARCHAR(32) NOT NULL
)CHARSET utf8 ENGINE INNODB

INSERT INTO `admin`(`admin_name`,`admin_pwd`) 
VALUES('admin',MD5('admin')); 

SELECT * FROM `admin`;

SELECT `id`,`admin_name` `adminName`,`admin_pwd` `adminPwd` FROM `admin` WHERE admin_name = 'admin' AND admin_pwd = MD5('admin');










