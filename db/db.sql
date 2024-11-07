/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 8.4.3 : Database - authorization
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`authorization` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `authorization`;

/*Table structure for table `announcements` */

DROP TABLE IF EXISTS `announcements`;

CREATE TABLE `announcements` (
  `announcement_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID，主键，自动递增',
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题，不允许为空',
  `content` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告内容，不允许为空',
  `published_by` int NOT NULL COMMENT '发布人ID，关联users表的user_id',
  `publish_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间，默认值为当前时间戳',
  `expiration_date` timestamp NULL DEFAULT NULL COMMENT '过期时间，可选字段，用于设置公告的有效期限',
  `is_active` tinyint(1) DEFAULT '1' COMMENT '公告是否有效，布尔类型，默认值为 TRUE',
  PRIMARY KEY (`announcement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='公告表';

/*Data for the table `announcements` */

/*Table structure for table `card_keys` */

DROP TABLE IF EXISTS `card_keys`;

CREATE TABLE `card_keys` (
  `key_id` int NOT NULL AUTO_INCREMENT COMMENT '卡密ID，主键，自动递增',
  `card_key` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '卡密字符串，不允许为空，并且必须唯一',
  `type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '卡密类型，例如：产品激活码、优惠券等',
  `value` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '卡密对应的值，例如：折扣金额、产品ID等',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间，默认值为当前时间戳',
  `activated_at` timestamp NULL DEFAULT NULL COMMENT '激活时间，允许为空',
  `expires_at` timestamp NULL DEFAULT NULL COMMENT '过期时间，允许为空',
  `is_active` tinyint(1) DEFAULT '1' COMMENT '卡密是否有效，布尔类型，默认值为 TRUE',
  `authorization_id` int DEFAULT NULL COMMENT '使用人ID，关联authorization_id表的，允许为空',
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `card_key` (`card_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='卡密管理表';

/*Data for the table `card_keys` */

/*Table structure for table `computer_authorizations` */

DROP TABLE IF EXISTS `computer_authorizations`;

CREATE TABLE `computer_authorizations` (
  `authorization_id` int NOT NULL AUTO_INCREMENT COMMENT '授权ID，主键，自动递增',
  `computer_id` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '电脑唯一标识符，例如MAC地址或序列号，或者为游览器指纹，不允许为空，并且必须唯一',
  `expires_at` timestamp NULL DEFAULT NULL COMMENT '过期时间，允许为空',
  `is_active` tinyint(1) DEFAULT '1' COMMENT '授权是否有效，布尔类型，可用于强制关闭授权，默认值为 TRUE',
  PRIMARY KEY (`authorization_id`),
  UNIQUE KEY `computer_id` (`computer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='电脑授权管理表';

/*Data for the table `computer_authorizations` */

/*Table structure for table `computers_id_log` */

DROP TABLE IF EXISTS `computers_id_log`;

CREATE TABLE `computers_id_log` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '`announcements`主键，自动递增',
  `ip_address` varchar(45) COLLATE utf8mb4_general_ci NOT NULL COMMENT '电脑的IP地址，不允许为空，并且必须唯一',
  `hostname` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '电脑的主机名，可选字段',
  `location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '电脑的位置，可选字段，用于记录物理位置信息',
  `authorization_id` int DEFAULT NULL COMMENT '分配给的用户电脑ID，关联电脑授权表的computer_authorizations，允许为空',
  `start_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登录时间，默认值为当前时间戳',
  `last_seen` timestamp NULL DEFAULT NULL COMMENT '最后在线时间，允许为空',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_address` (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='管理电脑IP地址表';

/*Data for the table `computers_id_log` */

/*Table structure for table `user_ip_logs` */

DROP TABLE IF EXISTS `user_ip_logs`;

CREATE TABLE `user_ip_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT COMMENT '日志ID，主键，自动递增',
  `user_id` int NOT NULL COMMENT '用户ID，关联users表的user_id',
  `ip_address` varchar(45) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户登录时的IP地址',
  `login_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登录时间，默认值为当前时间戳',
  `location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '登录地点，可选字段，用于记录地理位置信息',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户IP地址记录表';

/*Data for the table `user_ip_logs` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID，主键，自动递增',
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名，不允许为空，并且必须唯一',
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码的哈希值，不允许为空',
  `permissions` int NOT NULL DEFAULT '1' COMMENT '用户权限等级0为最高级',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户登录表';

/*Data for the table `users` */

insert  into `users`(`user_id`,`username`,`password`,`permissions`) values 
(1,'admin','admin',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
