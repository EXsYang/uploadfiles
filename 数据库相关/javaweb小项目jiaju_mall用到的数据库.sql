/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.7.25 : Database - home_furnishing
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`home_furnishing` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `home_furnishing`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(32) NOT NULL,
  `admin_pwd` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_name` (`admin_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `admin` */

insert  into `admin`(`id`,`admin_name`,`admin_pwd`) values (1,'admin','21232f297a57a5a743894a0e4a801fc3');

/*Table structure for table `furn` */

DROP TABLE IF EXISTS `furn`;

CREATE TABLE `furn` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `maker` varchar(64) NOT NULL,
  `price` decimal(11,2) NOT NULL,
  `sales` int(10) unsigned NOT NULL,
  `stock` int(10) unsigned NOT NULL,
  `img_path` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=utf8;

/*Data for the table `furn` */

insert  into `furn`(`id`,`name`,`maker`,`price`,`sales`,`stock`,`img_path`) values (254,'333典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/2023817/4b187e2c-b7a8-4c56-8820-b82e83b59549_1692213741562_2.jpg'),(260,'177Name','蚂蚁家居','60.00',100,80,'assets/images/product-image/2023817/e8306636-ca25-4357-8368-6b6127dd1fde_1692213795526_天使恶魔.jpg'),(279,'北1风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/default.jpg'),(280,'简约风格小椅子','熊猫家居','180.00',667,6,'assets/images/product-image/2023817/abb918fd-8e65-4bf8-a11a-38f0c1dc3480_1692243781376_宫园薰.jpg'),(281,'典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(282,'温馨风格盆景架','蚂蚁家居','180.00',666,7,'assets/images/product-image/16.jpg'),(283,'13北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(284,'14简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(285,'15典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(286,'16温馨风格盆景架','蚂蚁家居','180.00',666,7,'assets/images/product-image/16.jpg'),(287,'北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(288,'简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(289,'典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(290,'温馨风格盆景架','蚂蚁家居','180.00',666,7,'assets/images/product-image/16.jpg'),(291,'13北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(292,'14简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(293,'15典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(294,'16温馨风格盆景架','蚂蚁家居','180.00',666,7,'assets/images/product-image/16.jpg'),(295,'北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(296,'简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(297,'典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(298,'温馨风格盆景架','蚂蚁家居','180.00',666,7,'assets/images/product-image/16.jpg'),(299,'13北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(300,'14简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(301,'15典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(302,'16温馨风格盆景架','蚂蚁家居','180.00',666,7,'assets/images/product-image/16.jpg'),(303,'北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(304,'简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(305,'典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(306,'温馨风格盆景架','蚂蚁家居','180.00',666,7,'assets/images/product-image/16.jpg'),(307,'13北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(308,'14简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(309,'15典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(310,'16温馨风格盆景架','蚂蚁家居','180.00',666,7,'assets/images/product-image/16.jpg'),(311,'北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(312,'简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(313,'典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(314,'温馨风格盆景架','蚂蚁家居','180.00',666,7,'assets/images/product-image/16.jpg'),(315,'13北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(316,'14简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(317,'15典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(318,'16温馨风格盆景架','蚂蚁家居','180.00',666,7,'assets/images/product-image/16.jpg'),(319,'北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(320,'简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(321,'典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(322,'温馨风格盆景架','蚂蚁家居','180.00',666,7,'assets/images/product-image/16.jpg'),(323,'13北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(324,'14简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(325,'15典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(326,'16温馨风格盆景架','蚂蚁家居','180.00',666,7,'assets/images/product-image/16.jpg'),(327,'北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(328,'简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(329,'典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(330,'温馨风格盆景架','蚂蚁家居','180.00',666,7,'assets/images/product-image/16.jpg'),(331,'13北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(332,'14简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(333,'15典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(334,'16温馨风格盆景架','蚂蚁家居','180.00',666,7,'assets/images/product-image/16.jpg'),(335,'北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(336,'简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(337,'典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(339,'13北欧风格小桌子','熊猫家居','180.00',666,7,'assets/images/product-image/6.jpg'),(340,'14简约风格小椅子','熊猫家居','180.00',666,7,'assets/images/product-image/4.jpg'),(341,'15典雅风格小台灯','蚂蚁家居','180.00',666,7,'assets/images/product-image/14.jpg'),(343,'Name1','蚂蚁家居','60.00',100,80,'assets/images/product-image/8bc1e0dc-fd35-49e6-9855-d6af7cf2b2be_1692129478648_'),(344,'jy小台灯','杨达工程','333.00',3,100,'assets/images/product-image/c88cbfa1-b5cc-423c-bc11-c7d6d47af11f_1692129628914_');

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `email` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

/*Data for the table `member` */

insert  into `member`(`id`,`username`,`password`,`email`) values (1,'admin','21232f297a57a5a743894a0e4a801fc3','hsp@hanshunping.net'),(2,'milan123','49e34051a5bb3df733080908649b9ad1','milan123@hanshunping.net'),(9,'yangdax','3f38929c17ba4d96f273bfa4c9880f9b','yangda@qq.com'),(10,'yangda','3f38929c17ba4d96f273bfa4c9880f9b','yangda@qq.com'),(11,'yangdaa','d44f6d6208efa88d6509307e9e34f922','yangdaa@qq.com'),(12,'yangda1','3f38929c17ba4d96f273bfa4c9880f9b','yangda@qq.com'),(13,'milan123x','49e34051a5bb3df733080908649b9ad1','milan123@hanshunping.net'),(14,'milan123xa','49e34051a5bb3df733080908649b9ad1','milan123@hanshunping.net'),(16,'zzzzzz','453e41d218e071ccfb2d1c99ce23906a','zzzzzz@qq.mmm'),(17,'121212','93279e3308bdbbeed946fc965017f67a','121212@qq.com'),(18,'666666','f379eaf3c831b04de153469d1bec345e','666666@qq.com'),(19,'888888','21218cca77804d2ba1922c33e0151105','888888@qq.com'),(20,'1222222','c73d8b2fee1f2a10920a097aa0c5d9de','1222222@s.cc'),(21,'111222','00b7691d86d96aebd21dd9e138f90840','111222@aa.com'),(22,'333444','abf156f3cf64496f9da2cabca68d95fe','333444@qq.com'),(23,'1222221','e781be17620581c1bc66f70125a78d66','1222221@qq.com'),(24,'yangda666','bdd4837fffdf3909c17b99dba41cfc54','yangda666@qq.com');

/*Table structure for table `order` */

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `id` varchar(64) NOT NULL,
  `create_time` datetime NOT NULL,
  `price` decimal(11,2) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order` */

insert  into `order`(`id`,`create_time`,`price`,`status`,`member_id`) values ('1691925623182-10','2023-08-13 19:20:23','180.00',0,10),('1692164217993-10','2023-08-16 13:36:58','180.00',0,10);

/*Table structure for table `order_item` */

DROP TABLE IF EXISTS `order_item`;

CREATE TABLE `order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `price` decimal(11,2) NOT NULL,
  `count` int(11) NOT NULL,
  `total_price` decimal(11,2) NOT NULL,
  `order_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

/*Data for the table `order_item` */

insert  into `order_item`(`id`,`name`,`price`,`count`,`total_price`,`order_id`) values (37,'5北欧风格小桌子','180.00',1,'180.00','1691925623182-10'),(38,'8温馨风格盆景架','180.00',1,'180.00','1692164217993-10');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
