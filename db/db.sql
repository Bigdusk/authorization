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
  `announcement_id` bigint NOT NULL AUTO_INCREMENT COMMENT '公告ID，主键，自动递增',
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题，不允许为空',
  `content` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告内容，不允许为空',
  `user_id` bigint NOT NULL COMMENT '发布人ID，关联users表的user_id',
  `publish_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间，默认值为当前时间戳',
  `expiration_date` datetime DEFAULT NULL COMMENT '过期时间，可选字段，用于设置公告的有效期限',
  `is_active` tinyint(1) DEFAULT '1' COMMENT '公告是否有效，布尔类型，默认值为 TRUE',
  PRIMARY KEY (`announcement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='公告表';

/*Data for the table `announcements` */

insert  into `announcements`(`announcement_id`,`title`,`content`,`user_id`,`publish_date`,`expiration_date`,`is_active`) values 
(2,'软件内测公告','Hello QQ_HELP：专注于qq简化操作',1,'2024-11-15 23:38:50','2024-11-15 23:38:50',1);

/*Table structure for table `card_keys` */

DROP TABLE IF EXISTS `card_keys`;

CREATE TABLE `card_keys` (
  `key_id` bigint NOT NULL AUTO_INCREMENT COMMENT '卡密ID，主键，自动递增',
  `card_key` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '卡密字符串，不允许为空，并且必须唯一',
  `type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '卡密类型，例如：产品激活码、优惠券等',
  `value` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '卡密对应的值，例如：折扣金额、产品ID等',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间，默认值为当前时间戳',
  `activated_at` datetime DEFAULT NULL COMMENT '激活时间，允许为空',
  `expires_at` datetime DEFAULT NULL COMMENT '过期时间，允许为空',
  `is_active` tinyint(1) DEFAULT '1' COMMENT '卡密是否有效，布尔类型，默认值为 TRUE',
  `authorization_id` bigint DEFAULT NULL COMMENT '使用人ID，关联authorization_id表的，允许为空',
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `card_key` (`card_key`)
) ENGINE=InnoDB AUTO_INCREMENT=519 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='卡密管理表';

/*Data for the table `card_keys` */

insert  into `card_keys`(`key_id`,`card_key`,`type`,`value`,`created_at`,`activated_at`,`expires_at`,`is_active`,`authorization_id`) values 
(439,'c8NG36eNgxHkkCdwc4WdSMtWhQUBXUXE1U8fz0nUYYsGL9RyCEW6Hd7piUPJ3g','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(440,'bowuf9T8a3kyX69k5T92S4Ijg6cMYm41X7iqm4U5jJHEZ0HQzZYtjHHPY5MGXj','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(441,'Zy3seOosrVEuwL0qDR6U9I61vuRFWJeVJ3p5PlI9OaPfT1zgdLkqHQXmVRR7NR','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(442,'H8kYab3RHWcEJpfaJvjLlrbcuNltBtinu6PFadvCFSxA2BLfuvbtxxSLLVpVxv','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(443,'OTVCKEAWsWi706tow1kxRCRKhyQp0vTMFl5ank2RuA5bh8uTMB3zhG2FcWPt7I','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(444,'VljX4xKj5AcYIWukfnwVAIGVzu0HUYc5euhMpDoe5ItdYSMyoeqfarItuIfUiy','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(445,'QEk5mt3cEexbTgIkS5bvVSXgacEwuNM8PCSCigLCKw3KBVywkXLlEbZY7eeHbp','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(446,'p131xpa80gwByuLeOh1feOJxkU53ivI7fDaM61ttLma2sACgSJ6Peks5fgtcL5','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(447,'6RImGSK1U8TRO9Q4nT5LBfU8ZEQ5R9HPs8JbtqbewDshWqx9Zp7qOSSh1xXXj3','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(448,'LBz2vWsOGuhaWXJ3zBLT7Q3akwDGWVgqYwZ1JpVm3vdz8YMSIYEhxdqRWVDJkr','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(449,'U60rNiCMQObQIsZtp07XCwyLb5R2yo0LHkNYTULOm3ve6knV1E60zJH0Yr1Qqu','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(450,'3cGVHH50G79WhtRfyTFtSfpiaZDISYvkGEin7ihOTMg3TeE6VSyWV005qkB0JN','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(451,'qjTiqM7oTY34jPgz7vDjx8OPao47Zg20aJDU3D5khC6Y1g40k8YTw41qkQ8RLY','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(452,'u8BcvPgp4D2hkxXgDS7D7nnzhgpwOitSQJt5J76l4ObuqkB6l4SIERuApm5Own','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(453,'2pG0yyazz4i8yMYQKUjAS5LnABRgE9SbbeDy9JrK2xvfvXqRUI9ALbXQpKwDm5','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(454,'dcHQsylKEPCSsqFY0s0AMtpoqWIW0gSmsv2FkuvJHMcgwsntLx3LyyFsv73P8B','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(455,'VhEDVGn5U3tn20eMFgo2O3IsFlIRkvNHyjsgtfJVDVyuocA8ohgJDaTZTIpquN','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(456,'HHkv0CNCjSYEsdoOxS48m8RlyH17HCCkoNbApHGihm2POjTCmSfTMgMJLJb1Fu','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(457,'CYD0ZbwV1NjbD6uMsejIuHxl7GqBLAOrZxUJWlQAIWi5WZdV5owuZ055c94OVT','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(458,'5YrCiUdyHhxMkhYbuAtWBsKjnWQHldLwjFYU9hyrV7h5klnVnIm6HnM5rMsHUU','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(459,'bo2A5J6w3FCzTUaKoKb8XfCtn5yGdLRndXrBe5BqnYBuQesm55e56YBkuTQRuI','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(460,'v9BLt4cwHmvIn4RRkO1FTlQgms0laMKU6Ph1WEYUejupgTOab2pO0euU75Orix','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(461,'2d2u6nnvwCpW9KUseA6xDF0Vs96nS2iePvCynFT4enahIO0XSJjTsNiQxKoPMq','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(462,'BvArwYBAftWEvVtJXaRNZJOTxggTalBiON8snHYeTQRJcJDJWdr9yKvpu17LoI','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(463,'tv7gITdy707Jqcu0wljgYsq1w7yHnsRJCpzy7eT588olcY2k6EqgnJQt7TvbfW','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(464,'jeZa5APwPVOZczYvCm8IKQtN1ekXLYfBjgaLFqau5uZw3P0XQPoISSVbFpzIkB','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(465,'6gVo8py6Qv0pYfzDMOCsEeijjfirzaR458KZdzX3eoDNiBVAcy5u3LthD5qqaV','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(466,'CNzNwgwdpRVpfxzjk5gk1FeleUGtXRtDgFzKpYUpuPeMgpwRmwJH1SMzTAiwXQ','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(467,'NytkkhnjuhltSjGRdvg2WGJasAXpT3ICvrniNMOg9v7hN25iRbtdyHiu09spQN','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(468,'JE4ckBWJayJpzjcaHrYPLCIzjPjFL5OZ6DWO9slIvHgVITwhYCMUTDcu5ypImO','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(469,'elJd66jjjLxWxFzBP78pVES0lEujb6Nw5IcYz9KJzgr8CN61hojsmVhLnJTz6Z','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(470,'S9q444okOaHX6N7B9AlOhUtKMy7xt1dZUG0YQtlneXk2zO2bImWQAphC0e7cBi','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(471,'0CdrW5EL9uLI0sPXTioeiKKrmvFmPc7GLsWuQKn2jT1ObEhqkZBSWWWa50Pi9k','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(472,'M4HSt4TLoIgkICyirT3ON1kG9o9g7UqiEW6uTZQexYC6kO5dLppaxgbbyhQ1Va','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(473,'jwdDwPA11pN1Uqisk4HuQmKJVmYiF2ImEYN100vVCcU2gVFIGPRExt7FiSHKJG','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(474,'tgWgfDbghyDr1LMYFQpbSFReit97N184OI8BSTlwfWsJvWDyAWFoZEfXdrybSL','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(475,'WBVCKMyKxrReGrXhLsaAWZqqTOUASKBff9NYqBQGwiEXT8xqGtLTsM5JYC7Brh','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(476,'r5zElkFiQLYoE1bqhvscjnJaAzlrHhewyTJ62raGWPUdegI8syLJpCLd6396FJ','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(477,'yCdGv7icqDa5I70MS7oeG1EAMQwPSh9a6iPI1Dp2OJO59jdVpu9vyzPPv0w3GB','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(478,'GCCNzW6TFCjv8aHMUeYKiDD3aygOzgZmfvROXyS8MtusU9Syr5TverrRJpjCSV','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(479,'IIilprOiT0aU1LHCInh3h9PQCvavpnILxvESD06VdbGs8l5F0YiKi7B2Y8u8bw','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(480,'JGI4F0HRK9WhnCgxGeCx45W0PXaVLtQTRrmDL0xiKoDPPfjlv3rhCWnmoq7XxJ','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(481,'YTpma4KHyicBCBqFhmpMjA0MlVN9btOr8ObhR1FiWiBZ281TZjx6kEkGX3F0kt','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(482,'Ow43G5u5mNOZnGVQdjpZyBpmQrpY48LiP2f0LOdVyOTFP9wbMpDUaOzectPMdX','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(483,'un2vwk0e7YpZSNzBpCOIbMdM5czqK6Tkm9ue1chdOP4OkpsBNxMGkeEDD7Y4nt','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(484,'UQ487A3XcNzFYHrfF2VRv7IFF29IPtY81VoGFug1NtM56RAH4ck4vlrxggoFmT','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(485,'cnBS4UpMimZUSg0GGNYBfgICCXUD97ivyoUV6bo64yFhr2DVUSqFD8nC4ioVR7','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(486,'HoafaqNyaj8v4l2aar82zdzeM4ankXyQBQAhsskPSYrCG86jLmTfbPyzTs0UsR','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(487,'0oH7hWk9pvH3FR3vXSWvdZ2MzJHdAPYtmDmtVO7Lc5RZw2uPC5oQHJT7pyR5S8','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(488,'ROK9SJ42lXZBgu9x0NBmKcoqYuX9B25nJW5iXl800OvokdvRmJVyQUsqtH2RsV','试用天卡','1','2024-11-15 10:58:04',NULL,NULL,0,0),
(489,'KLHKi61Rz9h0bPuwjEIJpJojI7sW8fVjsHQytuXFuZBHqBajcYiNaFoZtxIw6Z','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(490,'BWpYD83QYmInzhRkMY7B71l7duKF4aRPPmFpcawBdlIbzf758dtaWBTpPU4V9v','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(491,'DWWwb4v4jVfoio4zMlsDUwt4igGmzJwjP5niQyDZkCaYKYx45yySbNn1SpyogO','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(492,'ZupSn3OZbYjA8aaHiUfI4VRrGd9wykuxR27Bnzd4eh7RQ3m8CvWxyPYpNyu9mp','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(493,'ydC735z4D0JtaDAFU44P1ar0MjZZAPFMeEo1HDZ6n3ccgBqR2JrxMTDfByXRD2','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(494,'nHGJqiYdjbinfJdh5KkD256lMlblrIdSSZMIk73Ud1aHMX8eCzUfUvdlyzdbXX','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(495,'4EpnHzAD2Nwf6a9O13ijPHGD81fSPWGw8bLI3t2bwPEEgzjXYZSPhG3ElF0mGk','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(496,'Xo48wh86H1HMftc56cQ3HgZyddbo2dMzoExdNFjWuom8BTR0DEWBZhKZgIOCrP','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(497,'IdlhXJpxL29k8gxUZx6hIrz5IxVvJo2V71OLfPfzNhyw4wATumLosCbI0fIVQw','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(498,'J9O8oCS0J2dMUWiLTDfl8JZ6Z7CbbB6BlXm54IghnPEw7bA1njMwUvm53WlFsE','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(499,'K0YjyjjxWf2X9H9EBLmlVfHsKgsEunaNZSzbdKSBY9rxE9Y6h5Z6h5Ig56tbFm','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(500,'QQEEMZ6BXiA5DyxeRxY3qWMfQxqNLWkrZezKU2bSG8Se5wa5Uqz5K0R36ZPAq3','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(501,'oGirE8bWwVOYVbFzfEBHrUhIhEerGB1hj8SH7g01G0QhNlp0e9A0UhsgbgcBi9','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(502,'H7NSgIUALkKccruXyX1dGdt6bLsbQNo197O1AapsyU3GX825SGBVRDJMO5mT4y','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(503,'acLjJBCQoHxkaE8hetXe4FkXr3CMyXteIJd9QpwefvnMBtIio9gXdNOZq07ZJy','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(504,'OUHeLEhXyzNxvLhMm4Sfst4BeBFChUWlfmjlXySGR9w5YLOqo7YAOrtEzuKDGu','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(505,'VnpyaVFOT5ppRrrwhDcN1oU6Foksg9tJfU0OEhgntGP0HzFGJwmlXJgz5JTGjS','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(506,'bVD1NIvyJAT0el6p6ApYszFK3BcSm75hX5HJgzPHRPPzSH3vdgS2nxxvkbqWI7','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(507,'c9nBYLpqKqxv1sI5GAdbFzgtxehPWnXNz68WYB7ipUuBiP7oWIspSWFoFQwWqA','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(508,'487Dgj62UpW3bClVNRNXvrPOIQJtt20UPEUGIQOqsiuxzogsGE4x5fSgTg0HlH','月卡','30','2024-11-15 03:09:27',NULL,NULL,0,0),
(509,'EWJyWXuc9hlmlpVBSV945NHywXBkAQgaQuVjTGxlyeVUeNrqApO6UIWJZ3pH57','年卡','365','2024-11-15 23:09:54',NULL,NULL,0,0),
(510,'EUZnEgCy1rBkuQPS0cNfvLbiDkzNAxGUlpGgiKe610AbY385zKfHOFvI7RqotP','年卡','365','2024-11-15 23:09:54',NULL,NULL,0,0),
(511,'B3kTG1M4zDS6K3REZlN5WNlPS9gwezJKGCYrieGLbBP3xYa3qxeC5XmsOKcJSr','年卡','365','2024-11-15 23:09:54',NULL,NULL,0,0),
(512,'QGfhzvbC0gA6IdklJgOTsqn55kHGQ9rieksWgdKHhvOIOkOyWVB39ulY1XtXMo','年卡','365','2024-11-15 23:09:54',NULL,NULL,0,0),
(513,'Vz5MPBwz5h5wBIVulZtZW6GtX3GLZanahWBM3nTZDh4WFNsYdRzutvgxxjeryQ','年卡','365','2024-11-15 23:09:54',NULL,NULL,0,0),
(514,'Df1cmyuwL04pAUqgjlWAEFlmi6m5wPvwP1QaqVB7zGpPC5XvWXkJYNswPlVgqq','年卡','365','2024-11-15 23:09:54',NULL,NULL,0,0),
(515,'CS6wPcaDZKm2FAWppfST3EjrTevXtYlinaEBwOTAk4MoTLOlhjEzhKQRUYjHD2','年卡','365','2024-11-15 23:09:54',NULL,NULL,0,0),
(516,'4ntoOkNPznKjQnXuFQcibMToxm2rsRvUaOu2nNtd76lEsGZlLsWPfdlrO76ivE','年卡','365','2024-11-15 23:09:54',NULL,NULL,0,0),
(517,'mR2Q0TvIWAkYph3kxud4wsZzqu4VOCoXlgP0sfDJrUcCGfgBM2CMe5Mv8oeZBM','年卡','365','2024-11-15 23:09:54',NULL,NULL,0,0),
(518,'NYUAWWvse4rPcEX6cF1YcWf0HX5ir25oISO1ibNX7p0PEngKit35T9jpFtoZNR','年卡','365','2024-11-15 23:09:54',NULL,NULL,0,0);

/*Table structure for table `computer_authorizations` */

DROP TABLE IF EXISTS `computer_authorizations`;

CREATE TABLE `computer_authorizations` (
  `authorization_id` bigint NOT NULL AUTO_INCREMENT COMMENT '授权ID，主键，自动递增',
  `computer_id` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '电脑唯一标识符，例如MAC地址或序列号，或者为游览器指纹，不允许为空，并且必须唯一',
  `expires_at` datetime DEFAULT NULL COMMENT '过期时间，允许为空',
  `is_active` tinyint(1) DEFAULT '1' COMMENT '授权是否有效，布尔类型，可用于强制关闭授权，默认值为 TRUE',
  PRIMARY KEY (`authorization_id`),
  UNIQUE KEY `computer_id` (`computer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='电脑授权管理表';

/*Data for the table `computer_authorizations` */

insert  into `computer_authorizations`(`authorization_id`,`computer_id`,`expires_at`,`is_active`) values 
(2,'63f6a5b44671a4d95c055e3d7e55620f','2024-11-16 07:57:41',NULL);

/*Table structure for table `computers_id_log` */

DROP TABLE IF EXISTS `computers_id_log`;

CREATE TABLE `computers_id_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '`announcements`主键，自动递增',
  `ip_address` varchar(45) COLLATE utf8mb4_general_ci NOT NULL COMMENT '电脑的IP地址，不允许为空，并且必须唯一',
  `hostname` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '电脑的主机名，可选字段',
  `location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '电脑的位置，可选字段，用于记录物理位置信息',
  `authorization_id` bigint DEFAULT NULL COMMENT '分配给的用户电脑ID，关联电脑授权表的computer_authorizations，允许为空',
  `start_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '登录时间，默认值为当前时间戳',
  `last_seen` datetime DEFAULT NULL COMMENT '最后在线时间，允许为空',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_address` (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='管理电脑IP地址表';

/*Data for the table `computers_id_log` */

/*Table structure for table `user_ip_logs` */

DROP TABLE IF EXISTS `user_ip_logs`;

CREATE TABLE `user_ip_logs` (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID，主键，自动递增',
  `user_id` bigint NOT NULL COMMENT '用户ID，关联users表的user_id',
  `ip_address` varchar(45) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户登录时的IP地址',
  `login_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '登录时间，默认值为当前时间戳',
  `location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '登录地点，可选字段，用于记录地理位置信息',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户IP地址记录表';

/*Data for the table `user_ip_logs` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID，主键，自动递增',
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名，不允许为空，并且必须唯一',
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码的哈希值，不允许为空',
  `permissions` int NOT NULL DEFAULT '1' COMMENT '用户权限等级0为最高级',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户登录表';

/*Data for the table `users` */

insert  into `users`(`user_id`,`username`,`password`,`permissions`) values 
(1,'hhzx','1183c7683af7293d0af4c98efb70252c',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
