-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: ticketdb
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'ROLE_ADMIN'),(3,'ROLE_CUSTOMER'),(4,'ROLE_EVENT_ORIGANEZE'),(2,'ROLE_STAFF');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,1,41),(42,1,42),(43,1,43),(44,1,44),(45,1,45),(46,1,46),(47,1,47),(48,1,48),(49,1,49),(50,1,50),(51,1,51),(52,1,52),(53,1,53),(54,1,54),(55,1,55),(56,1,56),(57,1,57),(58,1,58),(59,1,59),(60,1,60),(61,1,61),(62,1,62),(63,1,63),(65,1,65),(66,1,66),(67,1,67),(68,1,68),(130,1,70),(131,1,71),(107,2,21),(108,2,22),(109,2,23),(110,2,24),(111,2,27),(112,2,28),(113,2,32),(114,2,35),(115,2,36),(116,2,51),(117,2,52),(118,2,56),(119,2,57),(120,2,58),(121,2,59),(122,2,60),(123,2,61),(124,2,62),(125,2,63),(69,2,64),(70,4,25),(71,4,26),(72,4,27),(73,4,28),(127,4,30),(128,4,32),(129,4,33),(75,4,34),(76,4,35),(77,4,36),(78,4,37),(79,4,38),(80,4,39),(81,4,40),(82,4,41),(83,4,42),(84,4,43),(85,4,44),(86,4,45),(87,4,46),(88,4,47),(89,4,48),(90,4,49),(91,4,50),(92,4,51),(93,4,52),(94,4,53),(95,4,54),(96,4,55),(97,4,56),(98,4,57),(99,4,58),(100,4,59),(101,4,60),(102,4,61),(103,4,62),(104,4,63),(105,4,64),(106,4,68);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add category',6,'add_category'),(22,'Can change category',6,'change_category'),(23,'Can delete category',6,'delete_category'),(24,'Can view category',6,'view_category'),(25,'Can add venue',7,'add_venue'),(26,'Can change venue',7,'change_venue'),(27,'Can delete venue',7,'delete_venue'),(28,'Can view venue',7,'view_venue'),(29,'Can add user',8,'add_user'),(30,'Can change user',8,'change_user'),(31,'Can delete user',8,'delete_user'),(32,'Can view user',8,'view_user'),(33,'Can add event',9,'add_event'),(34,'Can change event',9,'change_event'),(35,'Can delete event',9,'delete_event'),(36,'Can view event',9,'view_event'),(37,'Can add comment',10,'add_comment'),(38,'Can change comment',10,'change_comment'),(39,'Can delete comment',10,'delete_comment'),(40,'Can view comment',10,'view_comment'),(41,'Can add messages',11,'add_messages'),(42,'Can change messages',11,'change_messages'),(43,'Can delete messages',11,'delete_messages'),(44,'Can view messages',11,'view_messages'),(45,'Can add notification',12,'add_notification'),(46,'Can change notification',12,'change_notification'),(47,'Can delete notification',12,'delete_notification'),(48,'Can view notification',12,'view_notification'),(49,'Can add performance',13,'add_performance'),(50,'Can change performance',13,'change_performance'),(51,'Can delete performance',13,'delete_performance'),(52,'Can view performance',13,'view_performance'),(53,'Can add receipt',14,'add_receipt'),(54,'Can change receipt',14,'change_receipt'),(55,'Can delete receipt',14,'delete_receipt'),(56,'Can view receipt',14,'view_receipt'),(57,'Can add ticket_ type',15,'add_ticket_type'),(58,'Can change ticket_ type',15,'change_ticket_type'),(59,'Can delete ticket_ type',15,'delete_ticket_type'),(60,'Can view ticket_ type',15,'view_ticket_type'),(61,'Can add ticket',16,'add_ticket'),(62,'Can change ticket',16,'change_ticket'),(63,'Can delete ticket',16,'delete_ticket'),(64,'Can view ticket',16,'view_ticket'),(65,'Can add review',17,'add_review'),(66,'Can change review',17,'change_review'),(67,'Can delete review',17,'delete_review'),(68,'Can view review',17,'view_review'),(70,'Can add application',18,'add_application'),(71,'Can change application',18,'change_application'),(72,'Can delete application',18,'delete_application'),(73,'Can view application',18,'view_application'),(74,'Can add access token',19,'add_accesstoken'),(75,'Can change access token',19,'change_accesstoken'),(76,'Can delete access token',19,'delete_accesstoken'),(77,'Can view access token',19,'view_accesstoken'),(78,'Can add grant',20,'add_grant'),(79,'Can change grant',20,'change_grant'),(80,'Can delete grant',20,'delete_grant'),(81,'Can view grant',20,'view_grant'),(82,'Can add refresh token',21,'add_refreshtoken'),(83,'Can change refresh token',21,'change_refreshtoken'),(84,'Can delete refresh token',21,'delete_refreshtoken'),(85,'Can view refresh token',21,'view_refreshtoken'),(86,'Can add id token',22,'add_idtoken'),(87,'Can change id token',22,'change_idtoken'),(88,'Can delete id token',22,'delete_idtoken'),(89,'Can view id token',22,'view_idtoken'),(90,'Can add chat room',23,'add_chatroom'),(91,'Can change chat room',23,'change_chatroom'),(92,'Can delete chat room',23,'delete_chatroom'),(93,'Can view chat room',23,'view_chatroom');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_tickets_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_tickets_user_id` FOREIGN KEY (`user_id`) REFERENCES `tickets_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-05-17 22:22:18.889007','1','Vé ca nhạc',1,'[{\"added\": {}}]',6,1),(2,'2025-05-17 22:22:27.522501','2','Văn hóa nghệ thuật',1,'[{\"added\": {}}]',6,1),(3,'2025-05-17 22:22:31.709828','3','Du lịch',1,'[{\"added\": {}}]',6,1),(4,'2025-05-17 22:22:37.684059','4','Workshop',1,'[{\"added\": {}}]',6,1),(5,'2025-05-17 22:22:43.745849','5','Vé xem phim',1,'[{\"added\": {}}]',6,1),(6,'2025-05-17 22:22:48.509667','6','Vé tham quan',1,'[{\"added\": {}}]',6,1),(7,'2025-05-17 22:22:53.835661','7','Thể thao',1,'[{\"added\": {}}]',6,1),(8,'2025-05-17 22:22:58.298908','8','Tin Tức',1,'[{\"added\": {}}]',6,1),(9,'2025-05-17 22:24:25.432992','1','White place - 20',1,'[{\"added\": {}}]',7,1),(10,'2025-05-17 22:25:19.800145','1','Test',1,'[{\"added\": {}}]',9,1),(11,'2025-05-17 22:25:48.637876','2','Test 1',1,'[{\"added\": {}}]',9,1),(12,'2025-05-17 22:26:39.014986','3','Test 2',1,'[{\"added\": {}}]',9,1),(13,'2025-05-17 22:26:48.359194','3','Test 2',2,'[{\"changed\": {\"fields\": [\"Attendee count\"]}}]',9,1),(14,'2025-05-17 22:27:10.187570','1','a - 17.000.000 VNĐ',1,'[{\"added\": {}}]',15,1),(15,'2025-05-17 22:27:22.980421','2','b - 20.000.000 VNĐ',1,'[{\"added\": {}}]',15,1),(16,'2025-05-17 22:27:39.832887','3','c - 11.000.000 VNĐ',1,'[{\"added\": {}}]',15,1),(17,'2025-05-17 22:27:51.381950','4','d - 30.000.000 VNĐ',1,'[{\"added\": {}}]',15,1),(18,'2025-05-17 22:40:18.017548','4','Admin',1,'[{\"added\": {}}]',14,1),(19,'2025-05-17 22:41:45.234382','1','d',1,'[{\"added\": {}}]',16,1),(20,'2025-05-17 22:42:23.560196','2','c',1,'[{\"added\": {}}]',16,1),(21,'2025-05-17 22:49:24.611488','1','Chương trình test',1,'[{\"added\": {}}]',13,1),(22,'2025-05-17 22:50:06.549414','2','Chương trình test 2',1,'[{\"added\": {}}]',13,1),(23,'2025-05-17 22:52:49.584695','2','Chương trình test 2',3,'',13,1),(24,'2025-05-17 22:52:49.584695','1','Chương trình test',3,'',13,1),(25,'2025-05-17 22:54:20.630612','3','Chương trình test',1,'[{\"added\": {}}]',13,1),(26,'2025-05-17 22:55:10.004593','4','Chương trình test 2',1,'[{\"added\": {}}]',13,1),(27,'2025-05-17 23:10:37.349732','2','c',2,'[]',16,1),(28,'2025-05-17 23:23:32.405986','1','Review object (1)',1,'[{\"added\": {}}]',17,1),(29,'2025-05-18 06:33:46.993476','1','ROLE_ADMIN',1,'[{\"added\": {}}]',3,1),(30,'2025-05-18 14:55:51.443530','1','ROLE_ADMIN',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(31,'2025-05-18 14:58:36.467363','1','Admin',2,'[{\"changed\": {\"fields\": [\"Groups\", \"First name\", \"Last name\", \"Birthday\", \"Avatar\", \"Phone\", \"Address\"]}}]',8,1),(32,'2025-05-18 14:59:48.869000','2','test',1,'[{\"added\": {}}]',8,1),(33,'2025-05-18 15:00:12.407877','2','test',2,'[{\"changed\": {\"fields\": [\"Email address\"]}}]',8,1),(34,'2025-05-18 15:05:31.211305','2','ROLE_STAFF',1,'[{\"added\": {}}]',3,1),(35,'2025-05-18 15:05:47.089056','2','test',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',8,1),(36,'2025-05-18 15:09:41.109107','2','test',2,'[]',8,1),(37,'2025-05-18 15:09:57.807541','2','test',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',8,1),(38,'2025-05-18 15:13:25.880901','3','ROLE_CUSTOMER',1,'[{\"added\": {}}]',3,1),(39,'2025-05-18 15:14:12.967774','3','customer1',1,'[{\"added\": {}}]',8,1),(40,'2025-05-18 15:19:25.141053','4','ROLE_EVENT_ORIGANEZE',1,'[{\"added\": {}}]',3,1),(41,'2025-05-18 15:20:59.367852','2','ROLE_STAFF',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(42,'2025-05-18 15:22:44.094060','4','eventoriganeze',1,'[{\"added\": {}}]',8,1),(43,'2025-05-18 15:23:00.214876','2','staff1',2,'[{\"changed\": {\"fields\": [\"Username\"]}}]',8,1),(44,'2025-05-18 15:23:10.117830','4','eventoriganeze1',2,'[{\"changed\": {\"fields\": [\"Username\"]}}]',8,1),(45,'2025-05-18 15:25:11.458509','4','Chương trình test 2',3,'',13,2),(46,'2025-05-18 15:38:49.520626','2','staff1',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',8,1),(47,'2025-05-18 15:38:58.577878','2','staff1',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',8,1),(48,'2025-05-18 20:45:16.244536','4','ROLE_EVENT_ORIGANEZE',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(49,'2025-05-18 21:10:55.495309','4','ROLE_EVENT_ORIGANEZE',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(50,'2025-05-18 21:11:09.562199','4','ROLE_EVENT_ORIGANEZE',2,'[]',3,1),(51,'2025-05-18 21:27:00.054810','69','Tickets | user | can you see detail user',1,'[{\"added\": {}}]',2,1),(52,'2025-05-18 22:12:14.101927','4','ROLE_EVENT_ORIGANEZE',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(53,'2025-05-18 22:26:27.064941','4','ROLE_EVENT_ORIGANEZE',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(54,'2025-05-18 22:46:31.173052','4','ROLE_EVENT_ORIGANEZE',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(55,'2025-05-18 22:48:17.297114','2','staff1',2,'[{\"changed\": {\"fields\": [\"Superuser status\"]}}]',8,1),(56,'2025-05-18 22:59:25.544389','2','staff1',2,'[{\"changed\": {\"fields\": [\"Superuser status\"]}}]',8,1),(57,'2025-05-25 11:20:20.362726','1','Vé ca nhạc',2,'[{\"changed\": {\"fields\": [\"Img_name\"]}}]',6,1),(58,'2025-05-25 12:05:57.772961','2','Văn hóa nghệ thuật',2,'[{\"changed\": {\"fields\": [\"Img_name\"]}}]',6,1),(59,'2025-05-25 12:08:10.084337','3','Du lịch',2,'[{\"changed\": {\"fields\": [\"Img_name\"]}}]',6,1),(60,'2025-05-25 12:08:44.889872','4','Workshop',2,'[{\"changed\": {\"fields\": [\"Img_name\"]}}]',6,1),(61,'2025-05-25 12:10:09.160766','5','Vé xem phim',2,'[{\"changed\": {\"fields\": [\"Img_name\"]}}]',6,1),(62,'2025-05-25 12:10:29.144478','6','Vé tham quan',2,'[{\"changed\": {\"fields\": [\"Img_name\"]}}]',6,1),(63,'2025-05-25 12:11:01.371375','7','Thể thao',2,'[{\"changed\": {\"fields\": [\"Img_name\"]}}]',6,1),(64,'2025-05-25 12:11:22.647944','8','Tin Tức',2,'[{\"changed\": {\"fields\": [\"Img_name\"]}}]',6,1),(65,'2025-05-25 12:58:20.416199','4','Su kien : Test 3 - Thoi gian : 2025-05-28 12:57:45 -- 2025-05-29 12:57:52',1,'[{\"added\": {}}]',9,1),(66,'2025-05-25 12:58:53.968216','5','Su kien : Test 5 - Thoi gian : 2025-05-30 12:58:43 -- 2025-05-31 12:58:47',1,'[{\"added\": {}}]',9,1),(67,'2025-05-25 12:59:43.802567','6','Su kien : test 6 - Thoi gian : 2025-06-01 12:59:34 -- 2025-06-02 12:59:38',1,'[{\"added\": {}}]',9,1),(68,'2025-05-25 13:01:17.049055','7','Su kien : Test 7 - Thoi gian : 2025-06-03 13:00:01 -- 2025-06-04 13:00:07',1,'[{\"added\": {}}]',9,1),(69,'2025-05-25 13:01:47.746450','8','Su kien : Test 8 - Thoi gian : 2025-06-05 13:01:32 -- 2025-06-06 13:01:39',1,'[{\"added\": {}}]',9,1),(70,'2025-05-25 13:02:32.513423','9','Su kien : Test 9 - Thoi gian : 2025-06-09 13:02:04 -- 2025-06-10 13:02:08',1,'[{\"added\": {}}]',9,1),(71,'2025-05-25 13:03:00.559168','10','Su kien : Test 10 - Thoi gian : 2025-06-11 13:02:47 -- 2025-06-12 13:02:52',1,'[{\"added\": {}}]',9,1),(72,'2025-06-02 08:44:20.390621','5','Chương trình test 2',1,'[{\"added\": {}}]',13,1),(73,'2025-06-02 13:15:24.420199','3','customer1',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',8,1),(74,'2025-06-04 12:58:54.257039','1','Room tes (Customer: staff1, Staff: customer1)',1,'[{\"added\": {}}]',23,1),(75,'2025-06-04 12:59:14.961627','1','Room tes (Customer: staff1, Staff: customer1)',3,'',23,1),(76,'2025-06-04 23:30:07.363765','2','c',3,'',16,1),(77,'2025-06-04 23:30:07.363765','1','d',3,'',16,1),(78,'2025-06-04 23:30:14.447598','4','Receipt #4 - Admin',3,'',14,1),(79,'2025-06-05 00:05:14.502726','8','b',3,'',16,1),(80,'2025-06-05 00:05:14.502726','7','a',3,'',16,1),(81,'2025-06-05 00:05:14.502726','4','b',3,'',16,1),(82,'2025-06-05 00:05:14.503731','3','a',3,'',16,1),(83,'2025-06-05 00:05:26.857828','8','Receipt #8 - user1',3,'',14,1),(84,'2025-06-05 00:05:26.857828','7','Receipt #7 - customer1',3,'',14,1),(85,'2025-06-05 00:05:26.857828','6','Receipt #6 - customer1',3,'',14,1),(86,'2025-06-05 00:05:26.857828','5','Receipt #5 - customer1',3,'',14,1),(87,'2025-06-05 00:19:34.817289','10','b',3,'',16,1),(88,'2025-06-05 00:19:34.817289','9','a',3,'',16,1),(89,'2025-06-05 00:19:43.240395','9','Receipt #9 - user1',3,'',14,1),(90,'2025-06-05 20:30:38.664307','1','ROLE_ADMIN',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(91,'2025-06-06 11:02:27.009704','2','White place 2 - 30',1,'[{\"added\": {}}]',7,1),(92,'2025-06-06 20:57:24.276531','5','Loại vé 1 - 17.000.000 VNĐ',1,'[{\"added\": {}}]',15,1),(93,'2025-06-06 20:57:42.339041','6','Loai ve 2 - 17.000.000 VNĐ',1,'[{\"added\": {}}]',15,1),(94,'2025-06-06 20:57:56.215681','7','Loại vé 3 - 17.000.000 VNĐ',1,'[{\"added\": {}}]',15,1),(95,'2025-06-06 20:58:16.850103','8','Loại vé 4 - 17.000.000 VNĐ',1,'[{\"added\": {}}]',15,1),(96,'2025-06-06 21:12:54.639476','20','Loại vé 3',3,'',16,1),(97,'2025-06-06 21:12:59.866392','21','Loại vé 3',3,'',16,1),(98,'2025-06-06 21:13:11.161573','18','Receipt #18 - user1',3,'',14,1),(99,'2025-06-06 21:13:15.561466','17','Receipt #17 - user1',3,'',14,1),(100,'2025-06-06 21:28:39.316396','22','Loại vé 3',3,'',16,1),(101,'2025-06-06 21:28:59.950088','19','Receipt #19 - user1',3,'',14,1),(102,'2025-06-06 21:32:17.243582','23','Loại vé 3',3,'',16,1),(103,'2025-06-06 21:32:23.385580','20','Receipt #20 - user1',3,'',14,1),(104,'2025-06-11 09:30:59.514129','28','Loại vé 3',1,'[{\"added\": {}}]',16,2),(105,'2025-06-11 09:31:25.861058','28','Loại vé 3',3,'',16,2),(106,'2025-06-12 09:54:13.766366','10','Su kien : Test 10 - Thoi gian : 2025-06-13 10:00:00 -- 2025-06-14 13:02:52',2,'[{\"changed\": {\"fields\": [\"Started date\", \"Ended date\"]}}]',9,4),(107,'2025-06-12 20:38:10.899130','1','rất tốt',1,'[{\"added\": {}}]',10,4),(108,'2025-06-12 22:07:23.402757','11','Su kien : Anh trai say hi - Thoi gian : 2025-06-15 22:07:01 -- 2025-06-16 22:07:05',1,'[{\"added\": {}}]',9,4),(109,'2025-06-12 22:08:12.860454','12','Su kien : Sự kiện test 13 - Thoi gian : 2025-06-17 22:07:58 -- 2025-06-18 22:08:01',1,'[{\"added\": {}}]',9,4),(110,'2025-06-13 00:11:11.890611','30','Loại vé 4',3,'',16,1),(111,'2025-06-13 00:11:19.714295','26','Receipt #26 - user3',3,'',14,1),(112,'2025-06-13 00:58:14.023267','13','Su kien : WorldCup - Thoi gian : 2025-06-20 00:56:55 -- 2025-06-22 17:56:57',1,'[{\"added\": {}}]',9,4),(113,'2025-06-13 01:00:25.472098','14','Su kien : Hay Hôm Nay - Thoi gian : 2025-06-23 10:00:00 -- 2025-06-24 10:00:00',1,'[{\"added\": {}}]',9,4),(114,'2025-06-13 01:02:43.837343','6','Su kien : test 6 - Thoi gian : 2025-06-25 12:59:34 -- 2025-06-26 12:59:38',2,'[{\"changed\": {\"fields\": [\"Started date\", \"Ended date\"]}}]',9,4),(115,'2025-06-13 01:03:26.000530','7','Su kien : Test 7 - Thoi gian : 2025-07-03 13:00:01 -- 2025-07-04 13:00:07',2,'[{\"changed\": {\"fields\": [\"Started date\", \"Ended date\"]}}]',9,4),(116,'2025-06-13 01:08:27.688512','8','Su kien : Test 8 - Thoi gian : 2025-07-05 13:01:32 -- 2025-07-06 13:01:39',2,'[{\"changed\": {\"fields\": [\"Started date\", \"Ended date\"]}}]',9,4);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(19,'oauth2_provider','accesstoken'),(18,'oauth2_provider','application'),(20,'oauth2_provider','grant'),(22,'oauth2_provider','idtoken'),(21,'oauth2_provider','refreshtoken'),(5,'sessions','session'),(6,'tickets','category'),(23,'tickets','chatroom'),(10,'tickets','comment'),(9,'tickets','event'),(11,'tickets','messages'),(12,'tickets','notification'),(13,'tickets','performance'),(14,'tickets','receipt'),(17,'tickets','review'),(16,'tickets','ticket'),(15,'tickets','ticket_type'),(8,'tickets','user'),(7,'tickets','venue');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-05-17 22:19:53.441173'),(2,'contenttypes','0002_remove_content_type_name','2025-05-17 22:19:53.547838'),(3,'auth','0001_initial','2025-05-17 22:19:53.837147'),(4,'auth','0002_alter_permission_name_max_length','2025-05-17 22:19:53.913446'),(5,'auth','0003_alter_user_email_max_length','2025-05-17 22:19:53.916953'),(6,'auth','0004_alter_user_username_opts','2025-05-17 22:19:53.929249'),(7,'auth','0005_alter_user_last_login_null','2025-05-17 22:19:53.929249'),(8,'auth','0006_require_contenttypes_0002','2025-05-17 22:19:53.936833'),(9,'auth','0007_alter_validators_add_error_messages','2025-05-17 22:19:53.944374'),(10,'auth','0008_alter_user_username_max_length','2025-05-17 22:19:53.948871'),(11,'auth','0009_alter_user_last_name_max_length','2025-05-17 22:19:53.956979'),(12,'auth','0010_alter_group_name_max_length','2025-05-17 22:19:53.976820'),(13,'auth','0011_update_proxy_permissions','2025-05-17 22:19:53.976820'),(14,'auth','0012_alter_user_first_name_max_length','2025-05-17 22:19:53.986832'),(15,'tickets','0001_initial','2025-05-17 22:19:55.690249'),(16,'admin','0001_initial','2025-05-17 22:19:55.852754'),(17,'admin','0002_logentry_remove_auto_add','2025-05-17 22:19:55.866744'),(18,'admin','0003_logentry_add_action_flag_choices','2025-05-17 22:19:55.876768'),(19,'sessions','0001_initial','2025-05-17 22:19:55.917028'),(20,'tickets','0002_alter_ticket_receipt','2025-05-17 22:37:16.394600'),(21,'tickets','0003_alter_ticket_receipt','2025-05-17 23:05:24.001190'),(22,'tickets','0004_category_img_name','2025-05-25 11:15:25.405317'),(23,'oauth2_provider','0001_initial','2025-06-02 10:15:54.178887'),(24,'oauth2_provider','0002_auto_20190406_1805','2025-06-02 10:15:54.363297'),(25,'oauth2_provider','0003_auto_20201211_1314','2025-06-02 10:15:54.442277'),(26,'oauth2_provider','0004_auto_20200902_2022','2025-06-02 10:15:55.004873'),(27,'oauth2_provider','0005_auto_20211222_2352','2025-06-02 10:15:55.094557'),(28,'oauth2_provider','0006_alter_application_client_secret','2025-06-02 10:15:55.129119'),(29,'oauth2_provider','0007_application_post_logout_redirect_uris','2025-06-02 10:15:55.218318'),(30,'oauth2_provider','0008_alter_accesstoken_token','2025-06-02 10:15:55.225075'),(31,'oauth2_provider','0009_add_hash_client_secret','2025-06-02 10:15:55.344973'),(32,'oauth2_provider','0010_application_allowed_origins','2025-06-02 10:15:55.424853'),(33,'oauth2_provider','0011_refreshtoken_token_family','2025-06-02 10:15:55.505431'),(34,'oauth2_provider','0012_add_token_checksum','2025-06-02 10:15:55.804957'),(35,'tickets','0002_venue_latitude_venue_longitude','2025-06-06 10:36:41.145597'),(36,'tickets','0003_event_view_count','2025-06-12 20:27:08.223787'),(37,'tickets','0004_alter_event_attendee_count_alter_event_category_and_more','2025-06-13 03:09:00.981790'),(38,'tickets','0005_alter_event_attendee_count_alter_event_category_and_more','2025-06-13 03:16:02.101092');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('2u5wyjspvr62p4ov6rhf0io5r4lt5fq6','.eJxVjM0OwiAQhN-FsyHLTyl69O4zkN0FpGogKe3J-O62SQ-azGm-b-YtAq5LCWtPc5iiuAglTr8dIT9T3UF8YL03ya0u80RyV-RBu7y1mF7Xw_07KNjLtmZveaAtCghtImNyZOOVJscege2go3ME3int0qjRZLBnsBBhzNmR-HwB8yY34w:1uLriC:3hDyD93iJDmRpl6b05NV2K57ufUWkMyxqPMjnYeg1eo','2025-06-16 06:03:28.439769'),('ecpgv4f8sec79i464fjbpnhgv7k07u8w','.eJxVjM0OwiAQhN-FsyHLTyl69O4zkN0FpGogKe3J-O62SQ-azGm-b-YtAq5LCWtPc5iiuAglTr8dIT9T3UF8YL03ya0u80RyV-RBu7y1mF7Xw_07KNjLtmZveaAtCghtImNyZOOVJscege2go3ME3int0qjRZLBnsBBhzNmR-HwB8yY34w:1uGgUX:Z5svwDP-t607OyXXbfjBHiKoyq0FjC8eiizz8qfUPiY','2025-06-01 23:03:57.498005'),('hlbclq8lobskm0b616qyyjggz9v4sv17','.eJxVjMsOwiAQRf-FtSG8QZfu_QYyMIxUDSSlXRn_3TbpQrf3nHPfLMK61LiOMscJ2YUZdvrdEuRnaTvAB7R757m3ZZ4S3xV-0MFvHcvrerh_BxVG3WpLgCooqTTAWXsklUgok4O3CK5IYcgEIakIcJtClLSy2fkk0TpnDPt8AetbN-8:1uPuUG:ekiJU8r4a5FurHq2YewVKJt51xDVA6s3WXhID5VD2jI','2025-06-27 09:49:48.177353');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_accesstoken`
--

DROP TABLE IF EXISTS `oauth2_provider_accesstoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_accesstoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `source_refresh_token_id` bigint DEFAULT NULL,
  `id_token_id` bigint DEFAULT NULL,
  `token_checksum` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth2_provider_accesstoken_token_checksum_85319a26_uniq` (`token_checksum`),
  UNIQUE KEY `source_refresh_token_id` (`source_refresh_token_id`),
  UNIQUE KEY `id_token_id` (`id_token_id`),
  KEY `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_accesstoken_user_id_6e4c9a65_fk_tickets_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_acce_id_token_id_85db651b_fk_oauth2_pr` FOREIGN KEY (`id_token_id`) REFERENCES `oauth2_provider_idtoken` (`id`),
  CONSTRAINT `oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr` FOREIGN KEY (`source_refresh_token_id`) REFERENCES `oauth2_provider_refreshtoken` (`id`),
  CONSTRAINT `oauth2_provider_accesstoken_user_id_6e4c9a65_fk_tickets_user_id` FOREIGN KEY (`user_id`) REFERENCES `tickets_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_accesstoken`
--

LOCK TABLES `oauth2_provider_accesstoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_accesstoken` VALUES (1,'AN07QfYHwOhjcYla98PFKVO2p5nB59','2025-06-02 23:25:24.523595','read write',2,3,'2025-06-02 13:25:24.524637','2025-06-02 13:25:24.524637',NULL,NULL,'68055d9be42711026854998a4a2c6fae3c9bd1d72d25d15a065ff6ce5633ec47'),(2,'8nZURT9ENxdEEcHiY9aMUKgO1Sr9be','2025-06-05 00:43:54.429423','read write',2,5,'2025-06-04 14:43:54.429423','2025-06-04 14:43:54.429423',NULL,NULL,'4c4308c00139ff0c569d6f636727af69c6817fa4f0cdbe87ac604c866139e7a4'),(3,'VUGSbfwx4fsDVNv3EQrrMAcDS4bK7d','2025-06-05 00:45:54.825286','read write',2,5,'2025-06-04 14:45:54.825286','2025-06-04 14:45:54.825286',NULL,NULL,'18ea2f157d1c1330a44f306deea3192e75528e0175b0bbacc12e3f5040691406'),(4,'Afyxi45JCFS6NCWpI8eJYpE7TyMHZh','2025-06-05 00:48:54.729708','read write',2,5,'2025-06-04 14:48:54.729708','2025-06-04 14:48:54.729708',NULL,NULL,'5e929e3bd1adc2faf0f0bf3cb25fb0ce4026e44cc58d1a6ff66853dece5bbbeb'),(5,'zlsXWm1Ga3GWAW4j2cnIULY449xfHm','2025-06-05 01:01:20.304489','read write',2,5,'2025-06-04 15:01:20.304489','2025-06-04 15:01:20.304489',NULL,NULL,'d5257d837ebde5461d8f3229b82550f7b26d2a76242800ff88857d24b69b84a8'),(6,'js9peryVOflqXuuMS0sXPsif5a3k7j','2025-06-05 01:07:03.537067','read write',2,5,'2025-06-04 15:07:03.537067','2025-06-04 15:07:03.537067',NULL,NULL,'bce0e40d693616985e00b6c5232e3cc30c7d903e77412762d0f03532451c10c4'),(7,'1pKEQX8Nt3Uof90BAcjjD0mls906Gu','2025-06-05 01:20:11.904656','read write',2,5,'2025-06-04 15:20:11.909510','2025-06-04 15:20:11.909510',NULL,NULL,'faa039e18a6ff901aa2d577347af441ad99e5408125a33981485366003cff867'),(8,'s4u0M8R4X0wPyUNAN6RVjXjkCCxPUH','2025-06-05 01:26:53.122524','read write',2,5,'2025-06-04 15:26:53.122524','2025-06-04 15:26:53.122524',NULL,NULL,'1b3fe7a0e67a02d6c3149c35748d2f83f4f84f87f9f0ae09103413cfeaaa5cb7'),(9,'ATex0pRicBtOnLSctYjvrO5Tfuz3At','2025-06-05 01:56:30.912743','read write',2,5,'2025-06-04 15:56:30.912743','2025-06-04 15:56:30.912743',NULL,NULL,'edbd94f4e8522d1b7df0acea6819bf3c6e373228aa5d207e9197248f29268bdb'),(10,'MTxGxR3sJYVNPd15vWtQvZ5HkWRY9C','2025-06-05 01:58:06.971319','read write',2,5,'2025-06-04 15:58:06.971319','2025-06-04 15:58:06.971319',NULL,NULL,'28225d65322edbf98a617c2d24346806fe744ee93231cd2cb27acd86e4f6c419'),(11,'BZWv4oPW4s4Zo8HiFCDDenHSirH2E1','2025-06-05 02:15:09.776540','read write',2,5,'2025-06-04 16:15:09.776540','2025-06-04 16:15:09.776540',NULL,NULL,'c604a3a4b006c30cbf32ea27c73d95b951d334afdd8ec60052fec51b6de3049a'),(12,'j7miMUQeZVJ4u04SlvJxzun6td2EnG','2025-06-05 02:27:33.446656','read write',2,5,'2025-06-04 16:27:33.462690','2025-06-04 16:27:33.462690',NULL,NULL,'bf27c90dd163aebb01e1093530370a35ccde6c56f2dfd0224037a9eebf0e2e7b'),(13,'1P2s2bqkLWoEt6CAPk17fKOCHVk2PH','2025-06-05 02:30:07.691545','read write',2,5,'2025-06-04 16:30:07.691545','2025-06-04 16:30:07.691545',NULL,NULL,'18dd5a06691d8d1e4dbee589b4742662e0458bf413e145283751ec409f3f9de6'),(14,'s5CWqoxbPn8yyxmEWObPPAFJKSQpdW','2025-06-05 07:11:30.575721','read write',2,5,'2025-06-04 21:11:30.576723','2025-06-04 21:11:30.576723',NULL,NULL,'83f9d6e944f1c574371356126b389b285bc2f728ce6ed9a41f6110eb80bd2506'),(15,'3eWfapJEzjKDmh3keurE3t2BjjFoJ7','2025-06-05 08:00:19.921637','read write',2,5,'2025-06-04 22:00:19.929882','2025-06-04 22:00:19.929882',NULL,NULL,'73dd958fe4a6986b6bd47aad4c1326685944e4d1b1ceb9d0879dbeaf380ff4eb'),(16,'zAKOnU6fGYhYvgnFtKT82br7gMjKSD','2025-06-05 08:09:03.081477','read write',2,5,'2025-06-04 22:09:03.093638','2025-06-04 22:09:03.093638',NULL,NULL,'1d388d1abdc39b4a944454c98a4a5a411a40060182fb5e3ccd0f78c6857a62f0'),(17,'iFVCqGNyCwGKSuctJQ6hP21k1XNRwK','2025-06-05 08:10:20.809629','read write',2,5,'2025-06-04 22:10:20.810646','2025-06-04 22:10:20.810646',NULL,NULL,'814dac250d37dc2da6d8b979ac1accfa16afd29a22c7a6b483213f6cd42b249b'),(18,'zBaV2dOjwVXHMfgW5TF0MbVfa8ihqT','2025-06-05 08:17:03.727432','read write',2,5,'2025-06-04 22:17:03.730523','2025-06-04 22:17:03.730523',NULL,NULL,'c0b82b1f8fc039063dfe92ed43bfad7f1dc4222714c8dc27e8861344bb1fc84a'),(19,'MnBfkGkqXI5Rb5QuaYRPezyjBE9fyy','2025-06-05 08:19:27.412488','read write',2,5,'2025-06-04 22:19:27.412488','2025-06-04 22:19:27.412488',NULL,NULL,'9199ed33d2b9224fd005fd837e0258ad7406119ec97eeb035454d14bf94232f7'),(20,'zdhgNuqnRprphNmM3TILM43DhKq7W9','2025-06-05 08:20:42.340232','read write',2,3,'2025-06-04 22:20:42.340232','2025-06-04 22:20:42.340232',NULL,NULL,'88ece6a5b9e3fa8a62471098a633697a704430b4a2dc6f6f1da93f7a47f33050'),(21,'Nc6TaTRrgyqzVWp9NNHi6JWnuOXG1p','2025-06-05 08:31:38.571517','read write',2,5,'2025-06-04 22:31:38.576103','2025-06-04 22:31:38.576103',NULL,NULL,'78ba3a2bd27256aef3c8ca7f4e72e69537022329dbecaaee856e93b05b149e8b'),(22,'mHBzLKFbmY1KzrK95L9pZQHkm09991','2025-06-05 08:37:16.622212','read write',2,5,'2025-06-04 22:37:16.623213','2025-06-04 22:37:16.623213',NULL,NULL,'248cba2f8bc654758551407b10ec7603e34b0c474edbca5d4bc03b0525bc5d34'),(23,'z9zKsYBztgXupqzVZ1Fjb8Vu7MJJPx','2025-06-05 08:46:16.046958','read write',2,5,'2025-06-04 22:46:16.051029','2025-06-04 22:46:16.051029',NULL,NULL,'46b579f1666ba5ac0ba6564d168c9d1740bce3abfaa5b6e55b4d319c75d1ba7d'),(24,'SzejRcVQ71Y7RfyhXhV8bZ1sFEaVu4','2025-06-05 08:48:01.385247','read write',2,5,'2025-06-04 22:48:01.393223','2025-06-04 22:48:01.393223',NULL,NULL,'b6bb9b8c8b4078d31b3030874170e39e9e64ed7194769d79216b23be8669571d'),(25,'ibgLj5LKFk9sXUH5Lqjua9SyyzLORH','2025-06-05 09:00:37.488604','read write',2,5,'2025-06-04 23:00:37.488604','2025-06-04 23:00:37.488604',NULL,NULL,'f8c94054c527d70f245f983043faf5d6008cd7e027edcdba78a822e908a35f44'),(26,'uYdECJBXbn3WuneWJ5d5y3tDKwf841','2025-06-05 09:04:24.595346','read write',2,3,'2025-06-04 23:04:24.597746','2025-06-04 23:04:24.597746',NULL,NULL,'7c03f481e4b0a9e33264270ea7a4a64c8c03b3a3c36ab14eea833e339b6ac3d1'),(27,'HJCZX6fxOfPrShWLcksAspTwoszobu','2025-06-05 09:26:09.925189','read write',2,5,'2025-06-04 23:26:09.938722','2025-06-04 23:26:09.938722',NULL,NULL,'8523195a9e1a17c384deb4c51dd3207d4223067e4591cc5e97d8e2a1333d43b3'),(28,'52uBM7M6Y5WGe6YP1Qgd4HFxKnmDj0','2025-06-05 09:27:06.368313','read write',2,3,'2025-06-04 23:27:06.368313','2025-06-04 23:27:06.368313',NULL,NULL,'cbca4a7f192cad1a715944147751f6302412d953e8d038c37089b113d49ed89f'),(29,'cwssy9eFA18ZnBGpjYCSV8bFvWWi13','2025-06-05 09:55:28.293262','read write',2,5,'2025-06-04 23:55:28.294265','2025-06-04 23:55:28.294265',NULL,NULL,'ab3e567898c46deb10b7ccbd504cc2f5d6a8f0f25ad8c9062c8b8cc09b841cb7'),(30,'jXB4KVeE3ltLwcczN70KWzrP93zHxV','2025-06-05 09:56:15.802742','read write',2,5,'2025-06-04 23:56:15.803756','2025-06-04 23:56:15.803756',NULL,NULL,'aebaefa247c7b9934534aabf03f626e242bb049fcb10181815145717ff996cdc'),(31,'lZlVEqM7atEFp0CC8O2vhgvWtLWpTE','2025-06-05 18:47:21.835031','read write',2,5,'2025-06-05 08:47:21.837480','2025-06-05 08:47:21.837480',NULL,NULL,'c1567a73d4ebc313a5f3a62e65946724022b9158a0df08e0ecf93b5ceb93215c'),(32,'yPJVfzp61qPHHdBvIoWtXyE2SQIMJn','2025-06-05 19:11:01.221493','read write',2,5,'2025-06-05 09:11:01.223745','2025-06-05 09:11:01.223745',NULL,NULL,'9fec9bf194c645acb821e8728a064cd2b6041f1b49a9dd13268165f84c3e8d84'),(33,'A3pqBLD111INz9r6hwcIJlW987jylK','2025-06-05 21:38:02.597026','read write',2,5,'2025-06-05 11:38:02.598033','2025-06-05 11:38:02.598033',NULL,NULL,'84a9f954751851179697954afdaded4b6d6a0a3a4833a12ed1f38b6b02c7b86a'),(34,'V4WFk4hUSqNd0KGpwtH6QP5Eurb7A9','2025-06-05 21:43:15.288024','read write',2,3,'2025-06-05 11:43:15.289113','2025-06-05 11:43:15.289113',NULL,NULL,'3117749d47bfc4faa4aa76a3005cb018114f44bd034f7751d8cadcc4cf3007d2'),(35,'fHsOSTXbAxF8xApHWOvXSVDgoWCa9L','2025-06-05 21:46:36.955542','read write',2,6,'2025-06-05 11:46:36.955542','2025-06-05 11:46:36.956049',NULL,NULL,'7c254f7ae63c5061922e7c07a26b74f558e0cf1f0d11ec0f301a008bc393aca7'),(36,'pfL22WSwGwOCnpMYB78hqlbmUNFhpF','2025-06-06 02:51:37.834791','read write',2,5,'2025-06-05 16:51:37.837766','2025-06-05 16:51:37.837766',NULL,NULL,'ef3a86f78255c80ffda5dc0157616a1cb09a45f6509e00d24d52dd1260fe7f45'),(37,'F0C7LjFjX8PvSaT27Vom6MXmWnWtRg','2025-06-06 02:52:23.856919','read write',2,5,'2025-06-05 16:52:23.857936','2025-06-05 16:52:23.857936',NULL,NULL,'56e8041b47bba24c12d16b31cec8e5c27874f2c83238f18bdbf8f6cce37cdd11'),(38,'LUvu6T6vLQUG9PzfgZK87jRtKKaPtl','2025-06-06 02:53:45.407914','read write',2,5,'2025-06-05 16:53:45.407914','2025-06-05 16:53:45.407914',NULL,NULL,'8dbdb1cc6a2c85632859173a9ab115640536b8aedd4b184dd979105f8580e08d'),(39,'wmh6HjqpLm0sIa2NXtJttfUrd00T55','2025-06-06 02:59:09.059639','read write',2,5,'2025-06-05 16:59:09.065163','2025-06-05 16:59:09.065163',NULL,NULL,'c200d0f687eea6cca76d458af4418cfd9b3c8b3505d5cc51ebd972454b8cd208'),(40,'LExTPeCjsPswkShA7SwJn1OzrJLMFk','2025-06-06 21:12:56.805100','read write',2,5,'2025-06-06 11:12:56.826280','2025-06-06 11:12:56.826280',NULL,NULL,'8513511bcd0b749298a1cb2b01d8ecd2f3804d93a42b935556b70a02739434f7'),(41,'gj3v0SRbU7j5neyWd1zZndoqbL164Z','2025-06-07 06:59:03.233502','read write',2,5,'2025-06-06 20:59:03.233502','2025-06-06 20:59:03.233502',NULL,NULL,'e7ec9d5cb205ee5f9edf71cb40c387cc6234823e3ee79ef92d537b3ce5e92451'),(42,'pb1xOdtqXPHrplISTbz8Grzbzikad0','2025-06-07 07:26:11.828567','read write',2,5,'2025-06-06 21:26:11.828567','2025-06-06 21:26:11.828567',NULL,NULL,'0c0908699575b7911bf5633e143c9dd01930e4719c68bb3d3e96fbd6603df02e'),(43,'n3TLILm1aeUfSQBDgrOB3eI2EFrQe1','2025-06-07 07:30:35.690684','read write',2,5,'2025-06-06 21:30:35.693849','2025-06-06 21:30:35.693849',NULL,NULL,'355dc0793721e83cac6159a1065e2b1d91f8b958eb004af3b44f542dcd6acccd'),(44,'TWrYr5McUULUJBekpiUWB7rLqXS1Ij','2025-06-07 07:33:52.788828','read write',2,5,'2025-06-06 21:33:52.788828','2025-06-06 21:33:52.788828',NULL,NULL,'1b949542483b12d612dd008226ed12a218033cb4b411c43281c9c171d13b4db5'),(45,'qemAbOR55CtaX9NBGD0tPGi6XcLCkT','2025-06-07 07:37:43.631133','read write',2,5,'2025-06-06 21:37:43.631133','2025-06-06 21:37:43.631133',NULL,NULL,'20cd782c6cc0b44a142e5919dc28e39c61782cdad12e5fdb74d65660cdcf2216'),(46,'e5SD7uRc01wgiyBtJZey3HMlekFPh9','2025-06-07 07:40:44.999297','read write',2,5,'2025-06-06 21:40:45.002445','2025-06-06 21:40:45.002445',NULL,NULL,'fe78e57e55e8c2dacfb615a701c0a5a61139bf885d3c11a8b6750604b9b48b77'),(47,'WfaVXcOCjBM29EzDSun1LY1nRjj1MV','2025-06-07 07:42:50.504254','read write',2,5,'2025-06-06 21:42:50.504254','2025-06-06 21:42:50.504254',NULL,NULL,'c6215bc570de093ff6ef4db90c0911405af3e18db96f4bb8bda35f2faec51b3a'),(48,'iuQwUjckyRJCpgA8suugkd8S66NJrj','2025-06-07 07:58:07.087331','read write',2,5,'2025-06-06 21:58:07.087331','2025-06-06 21:58:07.087331',NULL,NULL,'fcad35e36997b4fb91413a5a52931cbc1a7356c121caa2a24554c10cc7e8f62e'),(49,'6hFAeeqqh910i8XWHGZCTIK1OSSSGJ','2025-06-07 08:10:03.446440','read write',2,5,'2025-06-06 22:10:03.447461','2025-06-06 22:10:03.447461',NULL,NULL,'713ebc6c9b395735d4bedbf22b0fdfb0fcb9a44dd848b27eda1e272f4b5fce9b'),(50,'4XxNgtnPjXaOoQPzcDZVXsGN8vw1IM','2025-06-07 09:23:44.855906','read write',2,5,'2025-06-06 23:23:44.868239','2025-06-06 23:23:44.868239',NULL,NULL,'fbeba6d3fcdbe1f231ab0bf0d5381f93ee1a82ef6214fd5bd9e6da7597093ba8'),(51,'1aqzFaWzXurUsASLDEXwFacbYIHPso','2025-06-11 06:24:22.482054','read write',2,5,'2025-06-10 20:24:22.498087','2025-06-10 20:24:22.498087',NULL,NULL,'f204b40d7de44534aeb77420348468605ebea39d81cf7ac0ef1388902b443bbe'),(52,'N550LWq8nMeK1K9rAZhqLmvAROMxEp','2025-06-11 06:41:18.334454','read write',2,5,'2025-06-10 20:41:18.344603','2025-06-10 20:41:18.344603',NULL,NULL,'9c581caa18207123c3b1c31249bcd2d0fdc8fe3cbd6d9314bafb6ce29ebc0ad3'),(53,'gmS4HXgcCJnyasgM0m8JQEgVPZyDJj','2025-06-11 09:47:09.798581','read write',2,5,'2025-06-10 23:47:09.799587','2025-06-10 23:47:09.799587',NULL,NULL,'80bbe0722f2d95cf0e6fb39985a77d682b321ad406a3d46f34f84adc9c27f268'),(54,'l7nq6zqWMfzKDLy3KdHtY5donv5nPN','2025-06-11 11:22:42.644102','read write',2,5,'2025-06-11 01:22:42.644102','2025-06-11 01:22:42.644102',NULL,NULL,'9cce5e3b1b207db8f41a4760b7f89fda29e7e93f51e911b340ba6264467050b0'),(55,'GVXpn6osJqj1g1nZJNr2DJ6yROSkZN','2025-06-11 11:24:42.930963','read write',2,5,'2025-06-11 01:24:42.956992','2025-06-11 01:24:42.956992',NULL,NULL,'cd6fb3cbce7db63eaa1abccf3bbb78c6f3355ada2dfe98582720b72b60f2bd40'),(56,'kRmURBkoTEGDkLejl8SlVzXeLRsY0F','2025-06-11 11:25:18.464214','read write',2,5,'2025-06-11 01:25:18.464214','2025-06-11 01:25:18.464214',NULL,NULL,'969b2d78b704a0961c6c3eb1d0f0a1b4b409e5333e63e737102d6beca5249d89'),(57,'9wlbLhwIDiVMDXSey4SRqDdLR9EnTw','2025-06-11 11:27:49.311478','read write',2,5,'2025-06-11 01:27:49.311478','2025-06-11 01:27:49.311478',NULL,NULL,'5e3a4898035d6062cc8874a42790a04b04547262b039d91977acec13683470fb'),(58,'CDIleztbI7H09YEWcXj4QpbNcy1d1O','2025-06-11 20:07:27.990409','read write',2,5,'2025-06-11 10:07:27.990409','2025-06-11 10:07:27.990409',NULL,NULL,'54543f83b03d9c595d04bee5b221d6f8c5bf31b0db42f5091885828e79061c34'),(59,'QX0E5bfDjbgzP8YuF79nLNe3eseake','2025-06-12 02:22:06.787001','read write',2,5,'2025-06-11 16:22:06.801632','2025-06-11 16:22:06.801632',NULL,NULL,'478e0abe022f3af0ecb4818d9e82f71d7f58f944c9533971a11f6a374f4913ad'),(60,'iglcZR8Yqfq086Zaz4eRUFjEGANFUj','2025-06-12 02:23:22.663773','read write',2,5,'2025-06-11 16:23:22.664770','2025-06-11 16:23:22.665769',NULL,NULL,'d32fda9d792619eed5888b5ebf37bc7cd2dcf91ca546e38bc6d6a41d99aa3a1e'),(61,'SGR1fYyPu05GyU9aX0mnfWVID35PjV','2025-06-12 19:34:34.664978','read write',2,5,'2025-06-12 09:34:34.682592','2025-06-12 09:34:34.682592',NULL,NULL,'d696966cef048eaf5951a8794ed0da70833c7c0f9fe8d80f771cc5bd173f988f'),(62,'PHMRxnfLQuqg2gimTgfiN3wICuJc1m','2025-06-12 19:49:21.425191','read write',2,5,'2025-06-12 09:49:21.433259','2025-06-12 09:49:21.433259',NULL,NULL,'6d80bbfa14219f86864bdb9506a0d88dabd503da9360a0632b84bdb7c054a156'),(63,'35o2ztZfuYdgmKxSjtTFmYBNrs2o4i','2025-06-12 19:55:10.420031','read write',2,5,'2025-06-12 09:55:10.420031','2025-06-12 09:55:10.420031',NULL,NULL,'7a3663ae42395496075990a1e5180c121c0222d44d479b57bc95ce70ead95a98'),(64,'lkmTi40buLHLIs7DN4cZzjN7TXTUXL','2025-06-12 20:01:08.909054','read write',2,5,'2025-06-12 10:01:08.909054','2025-06-12 10:01:08.909054',NULL,NULL,'d8962f5036f6f31a4226f373a734b1adef3387e424d2ad8fcf16762af0193cb1'),(65,'AYEO9bI51IeuwheG2PeaR0fUnovX9l','2025-06-12 20:18:31.551071','read write',2,5,'2025-06-12 10:18:31.558156','2025-06-12 10:18:31.558156',NULL,NULL,'ef0afe55190a75dd3f0f74d5523333648b74e57c87bf31e300ea8f1a5499c5ae'),(66,'2Q2aMZYQNmn9Ft5LNvG8EZMOGR7xnr','2025-06-13 03:00:12.343341','read write',2,5,'2025-06-12 17:00:12.350489','2025-06-12 17:00:12.350489',NULL,NULL,'92f48da8d12575469629cc3ed6a49955de4edc38f34e7257b90c7b8fc3a394ea'),(67,'DgpBDqP45gKmsLC3tDQHKkR3neMpNh','2025-06-13 06:39:43.107126','read write',2,5,'2025-06-12 20:39:43.108157','2025-06-12 20:39:43.108157',NULL,NULL,'d04dcfad11c39f614a6a783be6ec0ea1180f1986c221f6aeb8c87932b7f3415d'),(68,'AcDPx0R2DaSPgpTQCNWCrR03gFgj0a','2025-06-13 07:07:20.238969','read write',2,5,'2025-06-12 21:07:20.243466','2025-06-12 21:07:20.243466',NULL,NULL,'cce345234aa31e9de55413e3f9e391cc5b0f9410d03aabbf8ccf68c7099f83e9'),(69,'un0yzPBb45hHiWqpU6oUI9kiIzUKZe','2025-06-13 10:07:29.054680','read write',2,7,'2025-06-13 00:07:29.055735','2025-06-13 00:07:29.055735',NULL,NULL,'c323df2b463f7e036f3bfac10040cdd387a0f13ef44e53d3cdcb7fbdfa57714d'),(70,'orNhuY1HfNOZJM9l50Bwdkr1lD0gU4','2025-06-13 10:15:04.158664','read write',2,7,'2025-06-13 00:15:04.161654','2025-06-13 00:15:04.161654',NULL,NULL,'2b2fbf23737e6b415edbb8a2e39bafefa574653672feb8b781aee7616887b797'),(71,'EIIZs6XokVH6UUCUvpUHef9dL1TdAX','2025-06-13 10:22:35.797630','read write',2,5,'2025-06-13 00:22:35.799181','2025-06-13 00:22:35.799181',NULL,NULL,'80899174dae6ccd6ff49095a698e269e38b208bcf3577a8a821d8898c8471781'),(72,'5xliO9WODnFkarvYS9fqI80YBUtCcf','2025-06-13 10:38:31.092957','read write',2,5,'2025-06-13 00:38:31.094487','2025-06-13 00:38:31.094487',NULL,NULL,'d9edda31c7b54fdc589de8305dc42cc1dc9b279cf16301594ad29c3d850d27ab'),(73,'WKvCxz2Bqto6bSHipTP8LM4ryxjyGd','2025-06-13 19:19:04.173787','read write',2,5,'2025-06-13 09:19:04.198934','2025-06-13 09:19:04.198934',NULL,NULL,'6acf51d1173d78c86308c05c4cfe41cc03a32bfe9755edfb46e4f9c6d93dcdf7'),(74,'CdqbXIDsp5kM8xPhVsRmRfYXFOT4b7','2025-06-13 19:44:15.216155','read write',2,7,'2025-06-13 09:44:15.239422','2025-06-13 09:44:15.239422',NULL,NULL,'96c2145d5e186f87ac63033ff39ff21cdbd9b6500eba3d005a50ee02a783dd99'),(75,'HsYWQQrhbQPey02B2NbXH6FSgQ8Hg4','2025-06-13 19:48:52.113170','read write',2,5,'2025-06-13 09:48:52.114170','2025-06-13 09:48:52.114170',NULL,NULL,'e195ca683ac23b1e0a6e605731f0c39fb0e24c9e4c9525350e448f56bfdd341e');
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_application`
--

DROP TABLE IF EXISTS `oauth2_provider_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_application` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `client_id` varchar(100) NOT NULL,
  `redirect_uris` longtext NOT NULL,
  `client_type` varchar(32) NOT NULL,
  `authorization_grant_type` varchar(32) NOT NULL,
  `client_secret` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `skip_authorization` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `algorithm` varchar(5) NOT NULL,
  `post_logout_redirect_uris` longtext NOT NULL,
  `hash_client_secret` tinyint(1) NOT NULL,
  `allowed_origins` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `oauth2_provider_application_user_id_79829054_fk_tickets_user_id` (`user_id`),
  KEY `oauth2_provider_application_client_secret_53133678` (`client_secret`),
  CONSTRAINT `oauth2_provider_application_user_id_79829054_fk_tickets_user_id` FOREIGN KEY (`user_id`) REFERENCES `tickets_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_application`
--

LOCK TABLES `oauth2_provider_application` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_application` DISABLE KEYS */;
INSERT INTO `oauth2_provider_application` VALUES (2,'6OYmJrNXua1Qs7FyIr0CnJ9nC1u48nW6bMQ3diAT','','confidential','password','pbkdf2_sha256$1000000$TqMeOSISzuTAAztb3Gx6MZ$HrdPD4CL9f1SNN8v03s3iFvxyYqTZh94Ds6wO3chcoM=','TicketApp',1,0,'2025-06-02 13:23:41.085810','2025-06-02 13:23:41.085810','','',1,'');
/*!40000 ALTER TABLE `oauth2_provider_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_grant`
--

DROP TABLE IF EXISTS `oauth2_provider_grant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_grant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `expires` datetime(6) NOT NULL,
  `redirect_uri` longtext NOT NULL,
  `scope` longtext NOT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `code_challenge` varchar(128) NOT NULL,
  `code_challenge_method` varchar(10) NOT NULL,
  `nonce` varchar(255) NOT NULL,
  `claims` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_grant_user_id_e8f62af8_fk_tickets_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_grant_user_id_e8f62af8_fk_tickets_user_id` FOREIGN KEY (`user_id`) REFERENCES `tickets_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_grant`
--

LOCK TABLES `oauth2_provider_grant` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_grant` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_grant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_idtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_idtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_idtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `jti` char(32) NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jti` (`jti`),
  KEY `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_idtoken_user_id_dd512b59_fk_tickets_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_idtoken_user_id_dd512b59_fk_tickets_user_id` FOREIGN KEY (`user_id`) REFERENCES `tickets_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_idtoken`
--

LOCK TABLES `oauth2_provider_idtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_refreshtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_refreshtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_refreshtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `access_token_id` bigint DEFAULT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `revoked` datetime(6) DEFAULT NULL,
  `token_family` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_token_id` (`access_token_id`),
  UNIQUE KEY `oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq` (`token`,`revoked`),
  KEY `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_refreshtoken_user_id_da837fce_fk_tickets_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr` FOREIGN KEY (`access_token_id`) REFERENCES `oauth2_provider_accesstoken` (`id`),
  CONSTRAINT `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_refreshtoken_user_id_da837fce_fk_tickets_user_id` FOREIGN KEY (`user_id`) REFERENCES `tickets_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_refreshtoken`
--

LOCK TABLES `oauth2_provider_refreshtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_refreshtoken` VALUES (1,'0NCiOygSYKi8ULb4aSJmYeLC4bIaLp',1,2,3,'2025-06-02 13:25:24.578940','2025-06-02 13:25:24.578940',NULL,'ac2c0e970614490984bf75e365373bfd'),(2,'9NLlRXTGsjBAUMdccYEjmg3426wnbt',2,2,5,'2025-06-04 14:43:54.460983','2025-06-04 14:43:54.460983',NULL,'ba37646f7ad04cd0a23a8cf175140386'),(3,'hgxgw7mKsBqb3RYmjA36UYVZX0r3ul',3,2,5,'2025-06-04 14:45:54.829812','2025-06-04 14:45:54.829812',NULL,'7e22c06063204a10aeb7e19846f2f3e8'),(4,'kin6k1PUnTqu95Vert5CubgIzBfofR',4,2,5,'2025-06-04 14:48:54.729708','2025-06-04 14:48:54.729708',NULL,'352a278ef31a42f2bd395973f33ce13c'),(5,'2A3E7BERDJit6gp0IvzpCP03Slpwp5',5,2,5,'2025-06-04 15:01:20.335734','2025-06-04 15:01:20.335734',NULL,'222375f9fcd74220b0e148ba0910fcba'),(6,'cE8KtciGlfaEdy3DsMRf1o5Ki4UbSA',6,2,5,'2025-06-04 15:07:03.537067','2025-06-04 15:07:03.537067',NULL,'d0db6943ceea465b85057256ba1bb4c9'),(7,'dKGVxMeZuJCUn32JnulwSux8m6ewtZ',7,2,5,'2025-06-04 15:20:11.909510','2025-06-04 15:20:11.909510',NULL,'7ffa48627c6b4588b0552f4b028feec3'),(8,'G7OUerBxDGAjsCWJVJGVyu2JV5qxQX',8,2,5,'2025-06-04 15:26:53.132413','2025-06-04 15:26:53.132413',NULL,'88c0680f877f45f09768f05654ded1d9'),(9,'JPU1cFcxDaiIqzJwgiLyH2jTjEMegN',9,2,5,'2025-06-04 15:56:30.961385','2025-06-04 15:56:30.961385',NULL,'dbdc793e3b674653b85354833be0c7cf'),(10,'cv6eFeQCWJnFOLos4wwdOwcLC2ozSb',10,2,5,'2025-06-04 15:58:06.984968','2025-06-04 15:58:06.984968',NULL,'25845a23e53e434db62dd2b704078199'),(11,'QERGE31ojoBBXRARug8z4VRuqpSbAS',11,2,5,'2025-06-04 16:15:09.776540','2025-06-04 16:15:09.776540',NULL,'75423015177e4fbab121ead2976869a1'),(12,'YHDzRxdChCsWLnU6y6LRLbJsluxwkw',12,2,5,'2025-06-04 16:27:33.478951','2025-06-04 16:27:33.478951',NULL,'73961843296e4bdba092a6f4610e08ef'),(13,'V3nJDosAcbw7qiNUrrSQ8Mft2dgbGT',13,2,5,'2025-06-04 16:30:07.691545','2025-06-04 16:30:07.691545',NULL,'bd400c3b0c614595957bf95f602939a2'),(14,'Shi27f6Ok22zoZFGb5IFbxjgAGo0nd',14,2,5,'2025-06-04 21:11:30.609850','2025-06-04 21:11:30.609850',NULL,'412240db82d141148edee66241f2a9c6'),(15,'cxIxKooM9UmtZh7RsXQFS3A606ngWT',15,2,5,'2025-06-04 22:00:19.980751','2025-06-04 22:00:19.980751',NULL,'91b09f295d914a298df58849e14029dc'),(16,'57LIgWcVrXiDUU7wIchOMAeQ8YtqU1',16,2,5,'2025-06-04 22:09:03.124026','2025-06-04 22:09:03.124026',NULL,'9cf63d4e19ab4edb9148f2e944d67c31'),(17,'4YDUyFmAkJ5xDk6FBlfQnBTfTWLQwa',17,2,5,'2025-06-04 22:10:20.811759','2025-06-04 22:10:20.811759',NULL,'bfc5d5cfda9e46da9b197fa35b316416'),(18,'49RXfnDNSOIgjOWse7MWop8Kn80YKX',18,2,5,'2025-06-04 22:17:03.766398','2025-06-04 22:17:03.766398',NULL,'83380da051ce42148f226023f1f2df71'),(19,'Gm9Jj8nzybWG1YIlfvQX5F6se36kUn',19,2,5,'2025-06-04 22:19:27.414911','2025-06-04 22:19:27.414911',NULL,'b9f7d7f3447c405094fda3e91a54ce92'),(20,'L1CQcLkgcn2MoFnVYQ8CORFEx9er6P',20,2,3,'2025-06-04 22:20:42.344069','2025-06-04 22:20:42.344069',NULL,'bcb7d53e192840c6ab7c3d4e4e84b2bc'),(21,'vXzpabCmIS4ZLQEows3IP5BwuyQ61m',21,2,5,'2025-06-04 22:31:38.608963','2025-06-04 22:31:38.608963',NULL,'29d695cecf4946c290a10a8691cbb11f'),(22,'3vIbzUIKF5n76BL9XMBl3whaZEiZDV',22,2,5,'2025-06-04 22:37:16.628264','2025-06-04 22:37:16.628264',NULL,'cafa0dec19684f2bb57416ade2c9189f'),(23,'S11DD64YEaDxrtShbhQBz2kj3WN0SG',23,2,5,'2025-06-04 22:46:16.068861','2025-06-04 22:46:16.068861',NULL,'89f8d0f5ee7a47fb94ba23999be6eb67'),(24,'NF4TP5BMmjHsZAmYEcpFBiNsWP6z04',24,2,5,'2025-06-04 22:48:01.426206','2025-06-04 22:48:01.426206',NULL,'e04d688460d641c79c9f53f7ec2d77a1'),(25,'cDK2lcERl1P9swVnlgAvaAKaFsxHpj',25,2,5,'2025-06-04 23:00:37.519544','2025-06-04 23:00:37.519544',NULL,'24f21d5ef4374a66a8a4a4135301ebd7'),(26,'BKEH9fT49H6Us4wrnYUz7IfCTsuyvt',26,2,3,'2025-06-04 23:04:24.602750','2025-06-04 23:04:24.602750',NULL,'9a1d73207d4549c5b86ad3a4f83a1a16'),(27,'adzkI2iO9NpzrPaVzUV15nOmjwHYYx',27,2,5,'2025-06-04 23:26:09.977027','2025-06-04 23:26:09.977027',NULL,'a740e959ada14033befcf4df2e9355a0'),(28,'FVKevwjYMFeRKepSzqngwKIP9LqIdk',28,2,3,'2025-06-04 23:27:06.371839','2025-06-04 23:27:06.371839',NULL,'2bc64c18f5eb4964b79886b3c9899e5b'),(29,'tSWrq75vfbuBLJPX3YAjeiFZ1liIjM',29,2,5,'2025-06-04 23:55:28.326618','2025-06-04 23:55:28.326618',NULL,'7014e0594b68430380ebf9fba1219879'),(30,'3qtQqhgnK7zlC6qeEWhvaBQn9Ad2xE',30,2,5,'2025-06-04 23:56:15.809760','2025-06-04 23:56:15.809760',NULL,'846f7ee3c5d64c5ba1c36d7eeeb6e8e7'),(31,'Ggk8V7zli4XsN4Gaen8rgRuvzcYgHz',31,2,5,'2025-06-05 08:47:21.883960','2025-06-05 08:47:21.883960',NULL,'9f74d8e9a0624f51afe98d4383353d30'),(32,'sw1PX3QNSLG8CKstjl10FD5tbpuRFi',32,2,5,'2025-06-05 09:11:01.280411','2025-06-05 09:11:01.280411',NULL,'4970978d8b8640119818611302d38fbb'),(33,'lFxW3f26aML6Trf3TS4il7dFqZkBOr',33,2,5,'2025-06-05 11:38:02.631681','2025-06-05 11:38:02.631681',NULL,'fa83f233e9c647e2a4c9957ffc2ed334'),(34,'daZBfZ7xxmXaSCD26iSmXmPlYXXce2',34,2,3,'2025-06-05 11:43:15.295108','2025-06-05 11:43:15.295108',NULL,'5b71b5fccb2747fda1f9f342044705ec'),(35,'Ep50qqaroXiMXufPmjzQA3sUhAvX1E',35,2,6,'2025-06-05 11:46:36.959563','2025-06-05 11:46:36.959563',NULL,'3d9c7ca5444b457090b316ce1a45fd55'),(36,'2I28RNP7pGk40dCAwO95WRioSGddZX',36,2,5,'2025-06-05 16:51:37.869073','2025-06-05 16:51:37.869073',NULL,'b16565afd6754b0a905d578413eb35c2'),(37,'kc7thrGsVqwr6wm9kW3RcWpUd6BjPb',37,2,5,'2025-06-05 16:52:23.867470','2025-06-05 16:52:23.867470',NULL,'7779d636136b4a099cb9a597fce830d6'),(38,'CwUdBACHo27CuMStgHWPyPjhrLJGvn',38,2,5,'2025-06-05 16:53:45.415216','2025-06-05 16:53:45.415216',NULL,'0139649790ef43c98564011d9dde786d'),(39,'hIJGkCNEFf7IVCByKswR8mof4RWwDf',39,2,5,'2025-06-05 16:59:09.092096','2025-06-05 16:59:09.092096',NULL,'22b857c7c3384e609c04e1e251e52306'),(40,'jgzu25yIQ3hJkNml6uLgdAe6cLAsHN',40,2,5,'2025-06-06 11:12:56.885457','2025-06-06 11:12:56.885457',NULL,'75e49a1d2dbd4b0e8067d3a7d95e5c19'),(41,'qKRlb6iRV06kHfUeuwDRLNy73E4sn2',41,2,5,'2025-06-06 20:59:03.253773','2025-06-06 20:59:03.253773',NULL,'e0d21323b0454b9ba2974256d4b7db68'),(42,'NFxaLx7mNNWfiZ56G2rd3wkREBAy2v',42,2,5,'2025-06-06 21:26:11.845205','2025-06-06 21:26:11.845205',NULL,'d3a3d917ab33485f8b0d563a07843997'),(43,'zHgLsXz1RH59INlH3aYQzy4vI4FiqP',43,2,5,'2025-06-06 21:30:35.703697','2025-06-06 21:30:35.703697',NULL,'972847276b8b49028fe31ec429de0770'),(44,'HaELotjf3flBJstpM6uhqoZeKTlxnL',44,2,5,'2025-06-06 21:33:52.788828','2025-06-06 21:33:52.788828',NULL,'61f0567f763444e2a3fc2b3e82354da5'),(45,'wv0D48JZbDCmH6psF8iU4yqBN70eXo',45,2,5,'2025-06-06 21:37:43.635140','2025-06-06 21:37:43.635140',NULL,'22eed664142f4a0e81f467ce62a5ab0c'),(46,'UIas7ZAlmvXqJE5FkYGeSsfvCBARW2',46,2,5,'2025-06-06 21:40:45.030379','2025-06-06 21:40:45.031380',NULL,'d7d7a06ede564e5fa99393e3780ce713'),(47,'naWtGChfGC1pG3CKoYeJ2z57mqBXBF',47,2,5,'2025-06-06 21:42:50.509288','2025-06-06 21:42:50.509288',NULL,'ad1daf32b4e14c309c34c0b01de5357b'),(48,'c6CkvmS6wM4Df2iOZd8scTIBcxuzhz',48,2,5,'2025-06-06 21:58:07.087331','2025-06-06 21:58:07.087331',NULL,'491e992171cd4288b96a6d218488f4be'),(49,'db8W5jLFIlIylGJ5aclR4aTz8noIgl',49,2,5,'2025-06-06 22:10:03.467913','2025-06-06 22:10:03.467913',NULL,'84672e1747e641bca7ae7c5345870648'),(50,'pOYeviAiYJiQAqQ8EYhWQxptyktATD',50,2,5,'2025-06-06 23:23:44.910243','2025-06-06 23:23:44.910243',NULL,'e37252fd273144928c9f384c114ec18a'),(51,'UdhpnrSmAan06XrzH0DR20xxDHuzzB',51,2,5,'2025-06-10 20:24:22.536962','2025-06-10 20:24:22.536962',NULL,'0b4bb114e2fc4fceb9000d8fc3de83d6'),(52,'z7Tj63NsTeSM8rKRU7ynUEILuYgI8E',52,2,5,'2025-06-10 20:41:18.366785','2025-06-10 20:41:18.366785',NULL,'632457a4d1d24a0886fbf0039bb3182d'),(53,'kiJTeYnhr2DyMuevyciJKjtDotStud',53,2,5,'2025-06-10 23:47:09.820062','2025-06-10 23:47:09.820062',NULL,'514498f190b343c894ef954ca8424864'),(54,'bXqVFs4ptfG0EBzHzoJOFru6Kw4RLw',54,2,5,'2025-06-11 01:22:42.675970','2025-06-11 01:22:42.675970',NULL,'c11c828b93034594befc7673a555466b'),(55,'Veq04diGbfiSAjhgpeYmm6g4BxAh9o',55,2,5,'2025-06-11 01:24:42.984185','2025-06-11 01:24:42.984185',NULL,'18929644c9cd4184bf493c34b13dcb1a'),(56,'rxDe1xE7b6Fh0Q5cem6UfjybCwdFkH',56,2,5,'2025-06-11 01:25:18.477722','2025-06-11 01:25:18.477722',NULL,'3dc3fe82022f4ffe8ee733af634e0e14'),(57,'cR97Zp3OoTXG3NuaNMwptO8YqxpY2M',57,2,5,'2025-06-11 01:27:49.322801','2025-06-11 01:27:49.322801',NULL,'58a0024fb2754945bc7e3d36fbd2c37c'),(58,'3sKEbQjCn5LMySehUSzMrdICNh8G9H',58,2,5,'2025-06-11 10:07:28.004467','2025-06-11 10:07:28.004467',NULL,'95a2d8442ff44d2bbf92e822b9a0a104'),(59,'pBnBt75Rj7xMnDiuir6AxUShfeU02P',59,2,5,'2025-06-11 16:22:06.832862','2025-06-11 16:22:06.832862',NULL,'4da149a546e54fc0a05deb76f8df2cd9'),(60,'139yHJHiZw9lhP8hCUCgA5OHeu1hVo',60,2,5,'2025-06-11 16:23:22.697771','2025-06-11 16:23:22.697771',NULL,'964cf12d18804e828e30e4f0a1c97382'),(61,'1B6kuGeAd3wCXGUTnaAT8UBFKDZbw7',61,2,5,'2025-06-12 09:34:34.722419','2025-06-12 09:34:34.722419',NULL,'ce573dbe848f49c6900e8faeb3b01b7d'),(62,'hVFnJitWmCyBBknAYfvuG6DPXpBhhz',62,2,5,'2025-06-12 09:49:21.480099','2025-06-12 09:49:21.480099',NULL,'67e36581bb534a81ba4344cfc7a42831'),(63,'y317L7eDPCQAxNqeXRAD0araPKhz52',63,2,5,'2025-06-12 09:55:10.428425','2025-06-12 09:55:10.428425',NULL,'90d6537dd98749e1bf1256f488a59270'),(64,'Lpn7bUSitZzimRzm41CdHHUMiDlEHk',64,2,5,'2025-06-12 10:01:08.918891','2025-06-12 10:01:08.918891',NULL,'e19ae9a260554e31821ff26967daa9d9'),(65,'pSRXYQdHILppQwqPx3K4IwhFwj8Won',65,2,5,'2025-06-12 10:18:31.559706','2025-06-12 10:18:31.559706',NULL,'fd3f933e25da47bfba3be13978451916'),(66,'zMOHLdYRCV6RFrpS5snw0Nsgk5aGcJ',66,2,5,'2025-06-12 17:00:12.385811','2025-06-12 17:00:12.385811',NULL,'fa9c6f1f3d224839bc987e2e8afff6a6'),(67,'wcaIV53ams0TkR0DWVy8U7xUUuUO9n',67,2,5,'2025-06-12 20:39:43.128035','2025-06-12 20:39:43.128035',NULL,'a2a6313fa22b4bfa9b93d8cb20f1678c'),(68,'FOI3k535Cbo13oamAhmMgHdGyygnh4',68,2,5,'2025-06-12 21:07:20.261228','2025-06-12 21:07:20.261228',NULL,'2186c361dd4a4734861d9acf3b295e55'),(69,'XrjlXkR3mBEJLIHQRPb8d00C6my1nR',69,2,7,'2025-06-13 00:07:29.063890','2025-06-13 00:07:29.063890',NULL,'a7196830445445068532509420685e50'),(70,'iijKm01VBFTFqNMbg8wHmcEaXCsIBv',70,2,7,'2025-06-13 00:15:04.166938','2025-06-13 00:15:04.166938',NULL,'e12af26631d1476b910862aaa9c28949'),(71,'mBL9MaFfPnuHFoxbutiS9BU67HuMQQ',71,2,5,'2025-06-13 00:22:35.801799','2025-06-13 00:22:35.802324',NULL,'0931e1631bde41b5a884ef45f5eb6a31'),(72,'1gQ5aaNC6lyR8UnEIO10rlNvZVuRKo',72,2,5,'2025-06-13 00:38:31.107037','2025-06-13 00:38:31.107037',NULL,'a44b5694ee8d4948b35651650b422420'),(73,'Pc6uzaeDMvIstMMCNLz31D8iJwrcmz',73,2,5,'2025-06-13 09:19:04.259406','2025-06-13 09:19:04.259406',NULL,'d4a4e6ffe8e94039a12e809ce950eb30'),(74,'xS5ibBjk1GUheTRVI11qQatWHVl7SI',74,2,7,'2025-06-13 09:44:15.278839','2025-06-13 09:44:15.278839',NULL,'df9790f7767e42feb51abd7db8cf2393'),(75,'hs0YbFOJCRyZzd2T6SSKnhysvtDDzg',75,2,5,'2025-06-13 09:48:52.117685','2025-06-13 09:48:52.117685',NULL,'66775ce8f3204517aef8cae3d910d846');
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_category`
--

DROP TABLE IF EXISTS `tickets_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  `img_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_category`
--

LOCK TABLES `tickets_category` WRITE;
/*!40000 ALTER TABLE `tickets_category` DISABLE KEYS */;
INSERT INTO `tickets_category` VALUES (1,'2025-05-17 22:22:18.886078','2025-05-25 11:20:04.883069',1,'Vé ca nhạc','image/upload/v1748146820/lunfuk3uzrthe8vs7nt8.png'),(2,'2025-05-17 22:22:27.520503','2025-05-25 12:05:55.391081',1,'Văn hóa nghệ thuật','image/upload/v1748149557/owibzjv5zlwrgyydrfpu.png'),(3,'2025-05-17 22:22:31.707821','2025-05-25 12:08:09.189877',1,'Du lịch','image/upload/v1748149690/hasifo3mvkw2yge6oydc.png'),(4,'2025-05-17 22:22:37.681554','2025-05-25 12:08:44.300312',1,'Workshop','image/upload/v1748149725/t7ays7dsvyetcjmy1t1g.png'),(5,'2025-05-17 22:22:43.743847','2025-05-25 12:10:08.589719',1,'Vé xem phim','image/upload/v1748149809/dkqto5njejhsxdjjphyf.png'),(6,'2025-05-17 22:22:48.507168','2025-05-25 12:10:28.467789',1,'Vé tham quan','image/upload/v1748149829/dedezdaa4kqbufw01jto.png'),(7,'2025-05-17 22:22:53.835661','2025-05-25 12:11:00.677408',1,'Thể thao','image/upload/v1748149861/fn4x4fnei4im3negqhul.png'),(8,'2025-05-17 22:22:58.296858','2025-05-25 12:11:22.038320',1,'Tin Tức','image/upload/v1748149882/x8g6zb1k8vo4cgvsyzd8.png');
/*!40000 ALTER TABLE `tickets_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_chatroom`
--

DROP TABLE IF EXISTS `tickets_chatroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_chatroom` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `customer_id` bigint NOT NULL,
  `staff_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `tickets_chatroom_customer_id_dc3c9c08_fk_tickets_user_id` (`customer_id`),
  KEY `tickets_chatroom_staff_id_e2bba531_fk_tickets_user_id` (`staff_id`),
  CONSTRAINT `tickets_chatroom_customer_id_dc3c9c08_fk_tickets_user_id` FOREIGN KEY (`customer_id`) REFERENCES `tickets_user` (`id`),
  CONSTRAINT `tickets_chatroom_staff_id_e2bba531_fk_tickets_user_id` FOREIGN KEY (`staff_id`) REFERENCES `tickets_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_chatroom`
--

LOCK TABLES `tickets_chatroom` WRITE;
/*!40000 ALTER TABLE `tickets_chatroom` DISABLE KEYS */;
INSERT INTO `tickets_chatroom` VALUES (2,'2025-06-04 16:49:46.669166','2025-06-04 16:49:46.669166',1,'room_5','2025-06-04 16:49:46.669166',5,2),(3,'2025-06-04 21:32:37.841858','2025-06-04 21:32:37.842104',1,'room_3','2025-06-04 21:32:37.842104',3,2),(4,'2025-06-05 12:31:16.888575','2025-06-05 12:31:16.888575',1,'room_6','2025-06-05 12:31:16.888575',6,2),(5,'2025-06-13 00:17:01.912841','2025-06-13 00:17:01.912841',1,'room_7','2025-06-13 00:17:01.912841',7,2);
/*!40000 ALTER TABLE `tickets_chatroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_comment`
--

DROP TABLE IF EXISTS `tickets_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `content` varchar(255) NOT NULL,
  `parent_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `event_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tickets_comment_parent_id_fa31a551_fk_tickets_comment_id` (`parent_id`),
  KEY `tickets_comment_user_id_9bf2a162_fk_tickets_user_id` (`user_id`),
  KEY `tickets_comment_event_id_3af517d4_fk_tickets_event_id` (`event_id`),
  CONSTRAINT `tickets_comment_event_id_3af517d4_fk_tickets_event_id` FOREIGN KEY (`event_id`) REFERENCES `tickets_event` (`id`),
  CONSTRAINT `tickets_comment_parent_id_fa31a551_fk_tickets_comment_id` FOREIGN KEY (`parent_id`) REFERENCES `tickets_comment` (`id`),
  CONSTRAINT `tickets_comment_user_id_9bf2a162_fk_tickets_user_id` FOREIGN KEY (`user_id`) REFERENCES `tickets_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_comment`
--

LOCK TABLES `tickets_comment` WRITE;
/*!40000 ALTER TABLE `tickets_comment` DISABLE KEYS */;
INSERT INTO `tickets_comment` VALUES (1,'2025-06-12 20:38:10.880090','2025-06-12 20:38:10.880090',1,'rất tốt',NULL,5,10),(2,'2025-06-12 20:42:44.427509','2025-06-12 20:42:44.427509',1,'Hhhhghhgh',NULL,5,9),(3,'2025-06-13 09:49:22.465510','2025-06-13 09:49:22.465510',1,'Rất tốt',NULL,5,3);
/*!40000 ALTER TABLE `tickets_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_event`
--

DROP TABLE IF EXISTS `tickets_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_event` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `name` varchar(100) NOT NULL,
  `image` varchar(255) NOT NULL,
  `attendee_count` int NOT NULL,
  `started_date` datetime(6) NOT NULL,
  `ended_date` datetime(6) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `category_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `venue_id` bigint NOT NULL,
  `view_count` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tickets_event_category_id_bca24b79_fk_tickets_category_id` (`category_id`),
  KEY `tickets_event_user_id_dc47e63f_fk_tickets_user_id` (`user_id`),
  KEY `tickets_event_venue_id_44dda076_fk_tickets_venue_id` (`venue_id`),
  CONSTRAINT `tickets_event_category_id_bca24b79_fk_tickets_category_id` FOREIGN KEY (`category_id`) REFERENCES `tickets_category` (`id`),
  CONSTRAINT `tickets_event_user_id_dc47e63f_fk_tickets_user_id` FOREIGN KEY (`user_id`) REFERENCES `tickets_user` (`id`),
  CONSTRAINT `tickets_event_venue_id_44dda076_fk_tickets_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `tickets_venue` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_event`
--

LOCK TABLES `tickets_event` WRITE;
/*!40000 ALTER TABLE `tickets_event` DISABLE KEYS */;
INSERT INTO `tickets_event` VALUES (1,'2025-05-17 22:25:19.178934','2025-05-17 22:25:19.178934',1,'Test','image/upload/v1747495517/wddrbtiokexkb1erua7i.jpg',20,'2025-06-01 22:24:44.000000','2025-06-02 22:24:50.000000','sddsds','published',8,1,2,0),(2,'2025-05-17 22:25:48.051350','2025-05-17 22:25:48.051350',1,'Test 1','image/upload/v1747495546/wyudmhnwr1kplkmjfmpt.jpg',20,'2025-06-02 22:25:35.000000','2025-06-03 23:25:41.000000','sddsds','published',8,1,2,0),(3,'2025-05-17 22:26:38.371502','2025-05-17 22:26:48.355662',1,'Test 2','image/upload/v1747495596/pjnodpjwdnbzkwthy3ul.jpg',20,'2025-06-03 22:26:26.000000','2025-06-04 22:26:31.000000','sddsds','published',7,1,2,0),(4,'2025-05-25 12:58:18.232109','2025-05-25 12:58:18.232109',1,'Test 3','image/upload/v1748152700/bgu1md9bofyxevl8xlke.jpg',12,'2025-06-28 12:57:45.000000','2025-06-29 12:57:52.000000','sddsds','published',7,1,2,6),(5,'2025-05-25 12:58:53.111324','2025-05-25 12:58:53.111324',1,'Test 5','image/upload/v1748152734/wvyemfj0wotieradpbmp.jpg',12,'2025-06-30 12:58:43.000000','2025-07-01 12:58:47.000000','sddsds','published',6,1,2,2),(6,'2025-05-25 12:59:42.886423','2025-06-13 01:02:43.298565',1,'test 6','image/upload/v1748152784/w1vwppiw9fqcxjovhqqg.png',11,'2025-06-25 12:59:34.000000','2025-06-26 12:59:38.000000','sddsds','published',5,1,2,0),(7,'2025-05-25 13:01:15.388859','2025-06-13 01:03:25.590167',1,'Test 7','image/upload/v1748152877/h22jyrco0nzwl3vw0nzm.png',12,'2025-07-03 13:00:01.000000','2025-07-04 13:00:07.000000','sddsds','published',5,1,2,0),(8,'2025-05-25 13:01:46.927807','2025-06-13 01:08:26.865167',1,'Test 8','image/upload/v1748152907/pafdvfxpoypicl0j6ep5.jpg',0,'2025-07-05 13:01:32.000000','2025-07-06 13:01:39.000000','sddsds','published',4,1,2,1),(9,'2025-05-25 13:02:31.875525','2025-05-25 13:02:31.875525',1,'Test 9','image/upload/v1748152952/hcpvkesekopqvc6stynz.png',17,'2025-06-09 13:02:04.000000','2025-06-10 13:02:08.000000','sddsds','published',4,1,2,0),(10,'2025-05-25 13:02:59.930016','2025-06-12 09:54:07.237735',1,'Test 10','image/upload/v1748152980/gjq6yzb8ftzudfun569g.jpg',18,'2025-06-13 10:00:00.000000','2025-06-14 13:02:52.000000','sddsds','published',6,1,2,2),(11,'2025-06-12 22:07:19.941572','2025-06-12 22:07:19.941572',1,'Anh trai say hi','image/upload/v1749740833/z03gg9ld68quaigcomuz.jpg',12,'2025-06-15 22:07:01.000000','2025-06-16 22:07:05.000000','sddsds','published',7,4,2,14),(12,'2025-06-12 22:08:11.769222','2025-06-12 22:08:11.769222',1,'Sự kiện test 13','image/upload/v1749740883/h2iils0zy7zekyht4zwk.jpg',20,'2025-06-17 22:07:58.000000','2025-06-18 22:08:01.000000','sddsds','published',7,4,2,22),(13,'2025-06-13 00:58:10.159056','2025-06-13 00:58:10.159056',1,'WorldCup','image/upload/v1749751084/we6frcjzsimj4jhmbu3u.png',30,'2025-06-20 00:56:55.000000','2025-06-22 17:56:57.000000','1','published',7,4,2,0),(14,'2025-06-13 01:00:23.881753','2025-06-13 01:00:23.881753',1,'Hay Hôm Nay','image/upload/v1749751216/kcmym4vk57esj9prnwjs.jpg',20,'2025-06-23 10:00:00.000000','2025-06-24 10:00:00.000000','1','published',5,4,2,0);
/*!40000 ALTER TABLE `tickets_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_messages`
--

DROP TABLE IF EXISTS `tickets_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `content` longtext NOT NULL,
  `sent_at` datetime(6) NOT NULL,
  `room_id` bigint NOT NULL,
  `sender_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tickets_messages_user_id_6ed8b66c_fk_tickets_sender_id` (`sender_id`),
  KEY `tickets_messages_event_id_e1ad99ad_fk_tickets_event_id_idx` (`room_id`),
  CONSTRAINT `tickets_messages_event_id_e1ad99ad_fk_tickets_room_id` FOREIGN KEY (`room_id`) REFERENCES `tickets_chatroom` (`id`),
  CONSTRAINT `tickets_messages_user_id_6ed8b66c_fk_tickets_sender_id` FOREIGN KEY (`sender_id`) REFERENCES `tickets_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_messages`
--

LOCK TABLES `tickets_messages` WRITE;
/*!40000 ALTER TABLE `tickets_messages` DISABLE KEYS */;
INSERT INTO `tickets_messages` VALUES (1,'2025-06-04 16:50:14.320778','2025-06-04 16:50:14.320778',1,'Hello','2025-06-04 16:50:14.320778',2,5),(2,'2025-06-04 16:50:21.340139','2025-06-04 16:50:21.340139',1,'hello 1','2025-06-04 16:50:21.340139',2,1),(3,'2025-06-04 16:50:52.530806','2025-06-04 16:50:52.530806',1,'Ê cu','2025-06-04 16:50:52.530806',2,5),(4,'2025-06-04 16:50:56.834078','2025-06-04 16:50:56.834078',1,'xin chào','2025-06-04 16:50:56.834078',2,1),(5,'2025-06-04 16:51:02.650884','2025-06-04 16:51:02.650884',1,'vu ngu','2025-06-04 16:51:02.650884',2,1),(6,'2025-06-04 16:51:04.111441','2025-06-04 16:51:04.111441',1,'Quể','2025-06-04 16:51:04.111441',2,5),(7,'2025-06-04 16:53:38.450690','2025-06-04 16:53:38.450690',1,'Hahaha','2025-06-04 16:53:38.450690',2,5),(8,'2025-06-04 16:53:44.066894','2025-06-04 16:53:44.066894',1,'hahha','2025-06-04 16:53:44.066894',2,1),(9,'2025-06-04 21:23:32.493939','2025-06-04 21:23:32.493939',1,'Hello','2025-06-04 21:23:32.493939',2,5),(10,'2025-06-04 21:23:40.885720','2025-06-04 21:23:40.885720',1,'hello','2025-06-04 21:23:40.885720',2,1),(11,'2025-06-04 22:17:27.314720','2025-06-04 22:17:27.314720',1,'Tôi có thể giúp gì cho bạn','2025-06-04 22:17:27.314720',2,5),(12,'2025-06-04 22:17:43.025013','2025-06-04 22:17:43.025013',1,'Hello','2025-06-04 22:17:43.025013',2,5),(13,'2025-06-04 22:20:49.229698','2025-06-04 22:20:49.229698',1,'Hello','2025-06-04 22:20:49.229698',3,3),(14,'2025-06-04 22:20:57.255189','2025-06-04 22:20:57.255189',1,'xin chài','2025-06-04 22:20:57.255189',3,1),(15,'2025-06-04 22:21:57.413177','2025-06-04 22:21:57.413177',1,'Khùng','2025-06-04 22:21:57.413177',3,3),(16,'2025-06-04 22:22:01.443957','2025-06-04 22:22:01.443957',1,'chóa','2025-06-04 22:22:01.443957',3,1),(17,'2025-06-04 22:23:26.532236','2025-06-04 22:23:26.532236',1,'hello','2025-06-04 22:23:26.532236',3,1),(18,'2025-06-04 22:37:24.433815','2025-06-04 22:37:24.433815',1,'Hello','2025-06-04 22:37:24.433815',2,5),(19,'2025-06-04 22:38:29.306040','2025-06-04 22:38:29.306040',1,'Học ','2025-06-04 22:38:29.306040',2,5),(20,'2025-06-04 22:38:47.577157','2025-06-04 22:38:47.577157',1,'oki nè','2025-06-04 22:38:47.577157',2,1),(21,'2025-06-04 22:39:04.030623','2025-06-04 22:39:04.030623',1,'fsfs','2025-06-04 22:39:04.030623',2,1),(22,'2025-06-04 22:39:07.889289','2025-06-04 22:39:07.889289',1,'Hello','2025-06-04 22:39:07.889289',2,5),(23,'2025-06-04 22:39:11.243982','2025-06-04 22:39:11.243982',1,'123132','2025-06-04 22:39:11.243982',2,1),(24,'2025-06-04 22:39:46.593056','2025-06-04 22:39:46.593056',1,'sfsfs','2025-06-04 22:39:46.593056',2,1),(25,'2025-06-04 22:39:51.391437','2025-06-04 22:39:51.391437',1,'Hshsh','2025-06-04 22:39:51.391437',2,5),(26,'2025-06-04 22:40:06.611529','2025-06-04 22:40:06.611529',1,'Ghh','2025-06-04 22:40:06.611529',2,5),(27,'2025-06-04 22:40:08.608422','2025-06-04 22:40:08.608422',1,'dfsas','2025-06-04 22:40:08.608422',2,1),(28,'2025-06-04 22:46:50.747831','2025-06-04 22:46:50.747831',1,'Hello','2025-06-04 22:46:50.747831',2,5),(29,'2025-06-04 22:46:54.509153','2025-06-04 22:46:54.509153',1,'dsf','2025-06-04 22:46:54.509153',2,1),(30,'2025-06-04 22:46:59.143807','2025-06-04 22:46:59.143807',1,'Tgg','2025-06-04 22:46:59.143807',2,5),(31,'2025-06-04 22:48:14.977604','2025-06-04 22:48:14.977604',1,'Hello','2025-06-04 22:48:14.977604',2,5),(32,'2025-06-04 22:48:17.594605','2025-06-04 22:48:17.594605',1,'dfsa','2025-06-04 22:48:17.594605',2,1),(33,'2025-06-04 23:00:46.095651','2025-06-04 23:00:46.095651',1,'Hello','2025-06-04 23:00:46.095651',2,5),(34,'2025-06-04 23:00:50.829992','2025-06-04 23:00:50.829992',1,'dfasf','2025-06-04 23:00:50.829992',2,1),(35,'2025-06-04 23:00:52.647363','2025-06-04 23:00:52.647363',1,'dsf','2025-06-04 23:00:52.647363',2,1),(36,'2025-06-04 23:00:53.404958','2025-06-04 23:00:53.404958',1,'sdf','2025-06-04 23:00:53.404958',2,1),(37,'2025-06-04 23:00:53.880808','2025-06-04 23:00:53.880808',1,'sdf','2025-06-04 23:00:53.880808',2,1),(38,'2025-06-04 23:00:54.264528','2025-06-04 23:00:54.264528',1,'sdf','2025-06-04 23:00:54.264528',2,1),(39,'2025-06-04 23:00:54.608758','2025-06-04 23:00:54.608758',1,'sf','2025-06-04 23:00:54.608758',2,1),(40,'2025-06-04 23:00:54.937503','2025-06-04 23:00:54.937503',1,'sf','2025-06-04 23:00:54.937503',2,1),(41,'2025-06-04 23:00:55.304071','2025-06-04 23:00:55.304071',1,'s','2025-06-04 23:00:55.304071',2,1),(42,'2025-06-04 23:00:55.630025','2025-06-04 23:00:55.630025',1,'fs','2025-06-04 23:00:55.630025',2,1),(43,'2025-06-04 23:00:55.925192','2025-06-04 23:00:55.925192',1,'fs','2025-06-04 23:00:55.926192',2,1),(44,'2025-06-04 23:00:56.233739','2025-06-04 23:00:56.233739',1,'fsf','2025-06-04 23:00:56.233739',2,1),(45,'2025-06-04 23:00:56.516809','2025-06-04 23:00:56.516809',1,'s','2025-06-04 23:00:56.516809',2,1),(46,'2025-06-04 23:01:00.335020','2025-06-04 23:01:00.335020',1,'f','2025-06-04 23:01:00.335020',2,1),(47,'2025-06-04 23:01:17.395404','2025-06-04 23:01:17.395404',1,'Hello','2025-06-04 23:01:17.395404',2,5),(48,'2025-06-04 23:03:40.450052','2025-06-04 23:03:40.450052',1,'Helo','2025-06-04 23:03:40.450052',2,5),(49,'2025-06-04 23:03:43.673370','2025-06-04 23:03:43.673370',1,'Hi','2025-06-04 23:03:43.673550',2,5),(50,'2025-06-04 23:03:53.295646','2025-06-04 23:03:53.295646',1,'df','2025-06-04 23:03:53.295646',2,1),(51,'2025-06-04 23:03:56.521511','2025-06-04 23:03:56.521511',1,'Ggh','2025-06-04 23:03:56.521511',2,5),(52,'2025-06-04 23:03:57.734332','2025-06-04 23:03:57.734332',1,'dsfs','2025-06-04 23:03:57.734332',2,1),(53,'2025-06-04 23:03:59.794303','2025-06-04 23:03:59.794303',1,'Mrfrc','2025-06-04 23:03:59.794303',2,5),(54,'2025-06-04 23:04:01.686501','2025-06-04 23:04:01.686501',1,'ffss','2025-06-04 23:04:01.686501',2,1),(55,'2025-06-04 23:04:03.187593','2025-06-04 23:04:03.187593',1,'Crex','2025-06-04 23:04:03.187593',2,5),(56,'2025-06-04 23:04:05.531545','2025-06-04 23:04:05.531545',1,'ffaasf','2025-06-04 23:04:05.531545',2,1),(57,'2025-06-04 23:04:06.936409','2025-06-04 23:04:06.936409',1,'Rcxr','2025-06-04 23:04:06.936409',2,5),(58,'2025-06-04 23:05:57.547480','2025-06-04 23:05:57.547480',1,'Xin chào tui cần giúp đỡ','2025-06-04 23:05:57.547480',3,3),(59,'2025-06-04 23:06:08.126733','2025-06-04 23:06:08.126733',1,'bạn muốn giúp gì nè','2025-06-04 23:06:08.126733',3,1),(60,'2025-06-04 23:08:28.763617','2025-06-04 23:08:28.763617',1,'Tôi thanh toán bị thất bại','2025-06-04 23:08:28.763617',3,3),(61,'2025-06-04 23:08:32.850655','2025-06-04 23:08:32.850655',1,'aizz','2025-06-04 23:08:32.850655',3,1),(62,'2025-06-04 23:26:23.376918','2025-06-04 23:26:23.376918',1,'Heloo','2025-06-04 23:26:23.376918',2,5),(63,'2025-06-04 23:26:30.503936','2025-06-04 23:26:30.503936',1,'fgdgsg','2025-06-04 23:26:30.503936',2,1),(64,'2025-06-04 23:26:36.691716','2025-06-04 23:26:36.691716',1,'Xxx','2025-06-04 23:26:36.691716',2,5),(65,'2025-06-04 23:26:42.373679','2025-06-04 23:26:42.373679',1,'fdgdfg','2025-06-04 23:26:42.373679',2,1),(66,'2025-06-04 23:28:30.760108','2025-06-04 23:28:30.760108',1,'Gkjgg','2025-06-04 23:28:30.760108',3,3),(67,'2025-06-04 23:28:38.056806','2025-06-04 23:28:38.056806',1,'gfdg','2025-06-04 23:28:38.056806',2,1),(68,'2025-06-04 23:28:55.110575','2025-06-04 23:28:55.110575',1,'dfsfs','2025-06-04 23:28:55.110575',3,1),(69,'2025-06-04 23:28:59.868874','2025-06-04 23:28:59.868874',1,'Ddf','2025-06-04 23:28:59.868874',3,3),(70,'2025-06-05 11:44:35.609929','2025-06-05 11:44:35.609929',1,'Hello','2025-06-05 11:44:35.609929',3,3),(71,'2025-06-05 11:44:45.605412','2025-06-05 11:44:45.605412',1,'xin chèo','2025-06-05 11:44:45.605412',3,1),(72,'2025-06-05 16:53:55.252494','2025-06-05 16:53:55.252494',1,'Hshsj','2025-06-05 16:53:55.252494',2,5),(73,'2025-06-05 16:54:00.739931','2025-06-05 16:54:00.739931',1,'ghgjg','2025-06-05 16:54:00.739931',2,1),(74,'2025-06-05 16:54:03.287327','2025-06-05 16:54:03.287327',1,'bjbj','2025-06-05 16:54:03.287327',2,1),(75,'2025-06-05 16:59:14.827976','2025-06-05 16:59:14.827976',1,'Hdhsh','2025-06-05 16:59:14.827976',2,5),(76,'2025-06-05 17:01:44.988521','2025-06-05 17:01:44.988521',1,'sdsf','2025-06-05 17:01:44.988521',2,1),(77,'2025-06-05 17:02:05.161514','2025-06-05 17:02:05.161514',1,'Hshsh','2025-06-05 17:02:05.161514',2,5),(78,'2025-06-05 17:02:08.078816','2025-06-05 17:02:08.078816',1,'huhuuh','2025-06-05 17:02:08.078816',2,1),(79,'2025-06-05 17:04:20.882754','2025-06-05 17:04:20.882754',1,'Hdhhd','2025-06-05 17:04:20.882754',2,5),(80,'2025-06-05 17:04:23.919559','2025-06-05 17:04:23.919559',1,'fyfyfy','2025-06-05 17:04:23.919559',2,1),(81,'2025-06-06 11:14:55.342079','2025-06-06 11:14:55.342079',1,'Hello','2025-06-06 11:14:55.342079',2,5),(82,'2025-06-06 11:14:58.492981','2025-06-06 11:14:58.492981',1,'hello','2025-06-06 11:14:58.492981',2,1),(83,'2025-06-06 22:10:17.943947','2025-06-06 22:10:17.943947',1,'Admin','2025-06-06 22:10:17.943947',2,5),(84,'2025-06-06 22:10:22.887925','2025-06-06 22:10:22.887925',1,'5564654','2025-06-06 22:10:22.887925',2,1),(85,'2025-06-06 23:26:54.361970','2025-06-06 23:26:54.361970',1,'Hshsh','2025-06-06 23:26:54.361970',2,5),(86,'2025-06-06 23:26:58.732760','2025-06-06 23:26:58.732760',1,'gugugiug','2025-06-06 23:26:58.732760',2,1),(87,'2025-06-11 00:09:05.048758','2025-06-11 00:09:05.048758',1,'Helloween ','2025-06-11 00:09:05.048758',2,5),(88,'2025-06-11 00:09:09.396703','2025-06-11 00:09:09.396703',1,'fhjhg','2025-06-11 00:09:09.396703',2,2),(89,'2025-06-11 00:09:15.515958','2025-06-11 00:09:15.515958',1,'Helllo ','2025-06-11 00:09:15.515958',2,5),(90,'2025-06-11 00:09:18.509904','2025-06-11 00:09:18.509904',1,'fdf','2025-06-11 00:09:18.509904',2,2),(91,'2025-06-12 17:15:31.711773','2025-06-12 17:15:31.713772',1,'Hels','2025-06-12 17:15:31.713772',2,5),(92,'2025-06-12 17:16:02.665179','2025-06-12 17:16:02.665179',1,'Hdhs','2025-06-12 17:16:02.665179',2,5),(93,'2025-06-13 00:19:10.302816','2025-06-13 00:19:10.302816',1,'Hello em','2025-06-13 00:19:10.302816',5,7),(94,'2025-06-13 00:19:20.524959','2025-06-13 00:19:20.524959',1,'bạn cần hỗ trợ gì nè','2025-06-13 00:19:20.524959',5,2),(95,'2025-06-13 00:19:25.374111','2025-06-13 00:19:25.374111',1,'<3','2025-06-13 00:19:25.374111',5,2),(96,'2025-06-13 00:19:35.572399','2025-06-13 00:19:35.572945',1,'Cảm ơn bạn','2025-06-13 00:19:35.572945',5,7),(97,'2025-06-13 00:19:40.185445','2025-06-13 00:19:40.185445',1,'=))','2025-06-13 00:19:40.185445',5,7),(98,'2025-06-13 09:47:45.349370','2025-06-13 09:47:45.349370',1,'Sjjssj','2025-06-13 09:47:45.349370',5,7),(99,'2025-06-13 09:47:48.991117','2025-06-13 09:47:48.991117',1,'gygyg','2025-06-13 09:47:48.991117',5,2);
/*!40000 ALTER TABLE `tickets_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_notification`
--

DROP TABLE IF EXISTS `tickets_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` varchar(255) NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `event_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tickets_notification_event_id_cccaecba_fk_tickets_event_id` (`event_id`),
  KEY `tickets_notification_user_id_008c63b1_fk_tickets_user_id` (`user_id`),
  CONSTRAINT `tickets_notification_event_id_cccaecba_fk_tickets_event_id` FOREIGN KEY (`event_id`) REFERENCES `tickets_event` (`id`),
  CONSTRAINT `tickets_notification_user_id_008c63b1_fk_tickets_user_id` FOREIGN KEY (`user_id`) REFERENCES `tickets_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_notification`
--

LOCK TABLES `tickets_notification` WRITE;
/*!40000 ALTER TABLE `tickets_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickets_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_performance`
--

DROP TABLE IF EXISTS `tickets_performance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_performance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  `started_date` datetime(6) NOT NULL,
  `ended_date` datetime(6) NOT NULL,
  `event_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tickets_performance_event_id_715964b3_fk_tickets_event_id` (`event_id`),
  CONSTRAINT `tickets_performance_event_id_715964b3_fk_tickets_event_id` FOREIGN KEY (`event_id`) REFERENCES `tickets_event` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_performance`
--

LOCK TABLES `tickets_performance` WRITE;
/*!40000 ALTER TABLE `tickets_performance` DISABLE KEYS */;
INSERT INTO `tickets_performance` VALUES (3,'2025-05-17 22:54:20.625986','2025-05-17 22:54:20.625986',1,'Chương trình test','2025-05-25 07:00:00.000000','2025-05-25 10:00:00.000000',3),(5,'2025-06-02 08:44:20.338831','2025-06-02 08:44:20.338831',1,'Chương trình test 2','2025-05-25 10:05:00.000000','2025-05-25 15:00:00.000000',3);
/*!40000 ALTER TABLE `tickets_performance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_receipt`
--

DROP TABLE IF EXISTS `tickets_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_receipt` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `payment_method` varchar(20) NOT NULL,
  `is_paid` tinyint(1) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `total_quantity` int NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tickets_receipt_user_id_628fe0ad_fk_tickets_user_id` (`user_id`),
  CONSTRAINT `tickets_receipt_user_id_628fe0ad_fk_tickets_user_id` FOREIGN KEY (`user_id`) REFERENCES `tickets_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_receipt`
--

LOCK TABLES `tickets_receipt` WRITE;
/*!40000 ALTER TABLE `tickets_receipt` DISABLE KEYS */;
INSERT INTO `tickets_receipt` VALUES (10,'2025-06-05 00:20:12.963449','2025-06-05 00:20:12.963449',1,'VNPay',1,37000000.00,2,5),(11,'2025-06-05 11:38:37.024735','2025-06-05 11:38:37.024735',1,'VNPay',1,17000000.00,1,5),(12,'2025-06-05 11:43:33.973163','2025-06-05 11:43:33.973163',1,'VNPay',1,60000000.00,2,3),(13,'2025-06-05 11:44:18.807249','2025-06-05 11:44:18.807249',1,'VNPay',1,11000000.00,1,3),(14,'2025-06-05 11:46:56.515041','2025-06-05 11:46:56.515041',1,'VNPay',1,37000000.00,2,6),(15,'2025-06-05 11:47:41.474073','2025-06-05 11:47:41.474073',1,'VNPay',1,30000000.00,1,6),(16,'2025-06-06 20:59:47.672287','2025-06-06 20:59:47.672287',1,'VNPay',1,17000000.00,1,5),(21,'2025-06-06 21:50:26.183363','2025-06-06 21:50:26.183363',1,'VNPay',1,17000000.00,1,5),(22,'2025-06-06 23:25:59.849386','2025-06-06 23:25:59.849386',1,'VNPay',1,17000000.00,1,5),(23,'2025-06-11 00:52:31.766992','2025-06-11 00:52:31.766992',1,'VNPay',1,17000000.00,1,5),(24,'2025-06-11 01:31:18.822693','2025-06-11 01:31:18.822693',1,'VNPay',1,17000000.00,1,5),(25,'2025-06-12 17:01:18.806159','2025-06-12 17:01:18.806159',1,'VNPay',1,17000000.00,1,5),(27,'2025-06-13 00:16:13.769085','2025-06-13 00:16:13.769085',1,'VNPay',1,34000000.00,2,7),(28,'2025-06-13 09:45:19.103131','2025-06-13 09:45:19.103131',1,'VNPay',1,34000000.00,2,7);
/*!40000 ALTER TABLE `tickets_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_review`
--

DROP TABLE IF EXISTS `tickets_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `count` int NOT NULL,
  `event_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tickets_review_event_id_user_id_8489384e_uniq` (`event_id`,`user_id`),
  KEY `tickets_review_user_id_aadb297a_fk_tickets_user_id` (`user_id`),
  CONSTRAINT `tickets_review_event_id_28e573c0_fk_tickets_event_id` FOREIGN KEY (`event_id`) REFERENCES `tickets_event` (`id`),
  CONSTRAINT `tickets_review_user_id_aadb297a_fk_tickets_user_id` FOREIGN KEY (`user_id`) REFERENCES `tickets_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_review`
--

LOCK TABLES `tickets_review` WRITE;
/*!40000 ALTER TABLE `tickets_review` DISABLE KEYS */;
INSERT INTO `tickets_review` VALUES (1,'2025-05-17 23:23:32.383310','2025-05-17 23:23:32.383310',1,3,3,1),(2,'2025-06-12 20:42:44.630741','2025-06-12 20:42:44.630741',1,5,9,5),(3,'2025-06-13 09:49:23.545945','2025-06-13 09:49:23.545945',1,5,3,5);
/*!40000 ALTER TABLE `tickets_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_ticket`
--

DROP TABLE IF EXISTS `tickets_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_ticket` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `code_qr` varchar(255) NOT NULL,
  `is_checked_in` tinyint(1) NOT NULL,
  `quantity` int NOT NULL,
  `receipt_id` bigint NOT NULL,
  `ticket_type_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_qr` (`code_qr`),
  KEY `tickets_ticket_ticket_type_id_763402dc_fk_tickets_ticket_type_id` (`ticket_type_id`),
  KEY `tickets_ticket_receipt_id_7f2fac2b_fk_tickets_receipt_id` (`receipt_id`),
  CONSTRAINT `tickets_ticket_receipt_id_7f2fac2b_fk_tickets_receipt_id` FOREIGN KEY (`receipt_id`) REFERENCES `tickets_receipt` (`id`),
  CONSTRAINT `tickets_ticket_ticket_type_id_763402dc_fk_tickets_ticket_type_id` FOREIGN KEY (`ticket_type_id`) REFERENCES `tickets_ticket_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_ticket`
--

LOCK TABLES `tickets_ticket` WRITE;
/*!40000 ALTER TABLE `tickets_ticket` DISABLE KEYS */;
INSERT INTO `tickets_ticket` VALUES (11,'2025-06-05 00:20:12.976341','2025-06-05 00:33:48.153326',1,'ID: RC:10||TT:1\nUSER: user1\nEVENT: Test 2\nTIME: 2025-06-24 22:26:26 - 2025-06-25 22:26:31\nADDRESS: White place - long khánh\nEVENT TYPE - PRICE: a - 17.000.000 VNĐ',0,1,10,1),(12,'2025-06-05 00:20:12.986572','2025-06-05 00:39:23.308626',1,'ID: RC:10||TT:2\nUSER: user1\nEVENT: Test 2\nTIME: 2025-06-24 22:26:26 - 2025-06-25 22:26:31\nADDRESS: White place - long khánh\nEVENT TYPE - PRICE: b - 20.000.000 VNĐ',1,1,10,2),(13,'2025-06-05 11:38:37.043587','2025-06-05 11:38:37.044587',1,'ID: RC:11||TT:1\nUSER: user1\nEVENT: Test 2\nTIME: 2025-06-24 22:26:26 - 2025-06-25 22:26:31\nADDRESS: White place - long khánh\nEVENT TYPE - PRICE: a - 17.000.000 VNĐ',0,1,11,1),(14,'2025-06-05 11:43:33.986927','2025-06-05 11:43:33.986927',1,'ID: RC:12||TT:4\nUSER: customer1\nEVENT: Test 1\nTIME: 2025-06-22 22:25:35 - 2025-06-23 23:25:41\nADDRESS: White place - long khánh\nEVENT TYPE - PRICE: d - 60.000.000 VNĐ',0,2,12,4),(15,'2025-06-05 11:44:18.818145','2025-06-05 11:45:01.822811',1,'ID: RC:13||TT:3\nUSER: customer1\nEVENT: Test\nTIME: 2025-06-20 22:24:44 - 2025-06-22 22:24:50\nADDRESS: White place - long khánh\nEVENT TYPE - PRICE: c - 11.000.000 VNĐ',1,1,13,3),(16,'2025-06-05 11:46:56.525192','2025-06-05 11:46:56.525192',1,'ID: RC:14||TT:1\nUSER: user2\nEVENT: Test 2\nTIME: 2025-06-24 22:26:26 - 2025-06-25 22:26:31\nADDRESS: White place - long khánh\nEVENT TYPE - PRICE: a - 17.000.000 VNĐ',0,1,14,1),(17,'2025-06-05 11:46:56.534840','2025-06-05 11:46:56.534840',1,'ID: RC:14||TT:2\nUSER: user2\nEVENT: Test 2\nTIME: 2025-06-24 22:26:26 - 2025-06-25 22:26:31\nADDRESS: White place - long khánh\nEVENT TYPE - PRICE: b - 20.000.000 VNĐ',0,1,14,2),(18,'2025-06-05 11:47:41.486882','2025-06-05 11:47:41.486882',1,'ID: RC:15||TT:4\nUSER: user2\nEVENT: Test 1\nTIME: 2025-06-22 22:25:35 - 2025-06-23 23:25:41\nADDRESS: White place - long khánh\nEVENT TYPE - PRICE: d - 30.000.000 VNĐ',0,1,15,4),(19,'2025-06-06 20:59:47.696180','2025-06-06 21:06:57.716046',1,'ID: RC:16||TT:7\nUSER: user1\nEVENT: Test 5\nTIME: 2025-06-30 12:58:43 - 2025-07-01 12:58:47\nADDRESS: White place 2 - Gò vấp\nEVENT TYPE - PRICE: Loại vé 3 - 17.000.000 VNĐ',0,1,16,7),(24,'2025-06-06 21:50:26.218713','2025-06-11 01:30:18.926733',1,'ID: RC:21||TT:8\nUSER: user1\nEVENT: Test 3\nTIME: 2025-06-28 12:57:45 - 2025-06-29 12:57:52\nADDRESS: White place 2 - Gò vấp\nEVENT TYPE - PRICE: Loại vé 4 - 17.000.000 VNĐ',1,1,21,8),(25,'2025-06-06 23:25:59.881454','2025-06-06 23:25:59.881454',1,'ID: RC:22||TT:5\nUSER: user1\nEVENT: Test 9\nTIME: 2025-06-09 13:02:04 - 2025-06-10 13:02:08\nADDRESS: White place 2 - Gò vấp\nEVENT TYPE - PRICE: Loại vé 1 - 17.000.000 VNĐ',0,1,22,5),(26,'2025-06-11 00:52:31.799794','2025-06-11 01:03:36.317107',1,'ID: RC:23||TT:6\nUSER: user1\nEVENT: Test 10\nTIME: 2025-06-11 13:02:47 - 2025-06-12 13:02:52\nADDRESS: White place 2 - Gò vấp\nEVENT TYPE - PRICE: Loai ve 2 - 17.000.000 VNĐ',1,1,23,6),(27,'2025-06-11 01:31:18.838156','2025-06-11 01:31:18.838156',1,'ID: RC:24||TT:6\nUSER: user1\nEVENT: Test 10\nTIME: 2025-06-11 13:02:47 - 2025-06-12 13:02:52\nADDRESS: White place 2 - Gò vấp\nEVENT TYPE - PRICE: Loai ve 2 - 17.000.000 VNĐ',0,1,24,6),(29,'2025-06-12 17:01:18.836712','2025-06-12 17:01:18.836712',1,'ID: RC:25||TT:8\nUSER: user1\nEVENT: Test 3\nTIME: 2025-06-28 12:57:45 - 2025-06-29 12:57:52\nADDRESS: White place 2 - Gò vấp\nEVENT TYPE - PRICE: Loại vé 4 - 17.000.000 VNĐ',0,1,25,8),(31,'2025-06-13 00:16:13.789561','2025-06-13 00:20:16.188542',1,'ID: RC:27||TT:8\nUSER: user3\nEVENT: Test 3\nTIME: 2025-06-28 12:57:45 - 2025-06-29 12:57:52\nADDRESS: White place 2 - Gò vấp\nEVENT TYPE - PRICE: Loại vé 4 - 34.000.000 VNĐ',1,2,27,8),(32,'2025-06-13 09:45:19.137592','2025-06-13 09:46:42.499155',1,'ID: RC:28||TT:6\nUSER: user3\nEVENT: Test 10\nTIME: 2025-06-13 10:00:00 - 2025-06-14 13:02:52\nADDRESS: White place 2 - Gò vấp\nEVENT TYPE - PRICE: Loai ve 2 - 34.000.000 VNĐ',1,2,28,6);
/*!40000 ALTER TABLE `tickets_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_ticket_type`
--

DROP TABLE IF EXISTS `tickets_ticket_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_ticket_type` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `event_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tickets_ticket_type_event_id_8ffdaff5_fk_tickets_event_id` (`event_id`),
  CONSTRAINT `tickets_ticket_type_event_id_8ffdaff5_fk_tickets_event_id` FOREIGN KEY (`event_id`) REFERENCES `tickets_event` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_ticket_type`
--

LOCK TABLES `tickets_ticket_type` WRITE;
/*!40000 ALTER TABLE `tickets_ticket_type` DISABLE KEYS */;
INSERT INTO `tickets_ticket_type` VALUES (1,'2025-05-17 22:27:10.186137','2025-06-05 11:46:56.520144',1,'a',2,17000000.00,3),(2,'2025-05-17 22:27:22.978454','2025-06-05 11:46:56.528710',1,'b',5,20000000.00,3),(3,'2025-05-17 22:27:39.831891','2025-06-05 11:44:18.812257',1,'c',19,11000000.00,1),(4,'2025-05-17 22:27:51.379952','2025-06-05 11:47:41.481196',1,'d',17,30000000.00,2),(5,'2025-06-06 20:57:24.244246','2025-06-06 23:25:59.862962',1,'Loại vé 1',9,17000000.00,9),(6,'2025-06-06 20:57:42.339041','2025-06-13 09:45:19.119983',1,'Loai ve 2',6,17000000.00,10),(7,'2025-06-06 20:57:56.206445','2025-06-06 21:30:51.312750',1,'Loại vé 3',7,17000000.00,5),(8,'2025-06-06 20:58:16.850103','2025-06-13 00:16:13.777658',1,'Loại vé 4',5,17000000.00,4);
/*!40000 ALTER TABLE `tickets_ticket_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_user`
--

DROP TABLE IF EXISTS `tickets_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_user`
--

LOCK TABLES `tickets_user` WRITE;
/*!40000 ALTER TABLE `tickets_user` DISABLE KEYS */;
INSERT INTO `tickets_user` VALUES (1,'pbkdf2_sha256$1000000$Fs3BpKwGhq1DyRrUACPAQt$4X6bRgO8i426XLK7MjlJB9EL96BqCJZltuZygPkEGhE=','2025-06-13 02:58:56.611022',1,'Admin','Nguyễn','Nhật','admin@gmail.com',1,1,'2025-05-17 22:21:01.000000',1,'2025-05-18','image/upload/v1747555114/i2oakif6zjmpkumlo0bg.jpg','0358001963','075204008980'),(2,'pbkdf2_sha256$1000000$74R3PQ8tnMduYJg8AXHBRe$BD/wdw7ilhVbDJsf1/YeOj7qhmsYmKelSBQ4Gcr2pHg=','2025-06-13 09:46:10.028703',0,'staff1','Nguyễn','Nhật','test@gmail.com',1,1,'2025-05-18 14:59:20.000000',1,'2025-05-18','image/upload/v1747555186/u7zeqhxyoojgzxtfxdup.jpg','0358001963','075204008980'),(3,'pbkdf2_sha256$1000000$cZ3GFQqpWJTg3nDeeJMAs9$u9TNSRiBJGsG2Gc2FmTiuZhDufNVOQ1sQQk+VVj4V04=',NULL,0,'customer1','','','customer1@gmail.com',0,1,'2025-05-18 15:12:11.000000',1,'2025-05-18','image/upload/v1747556050/oo64ccapjbxle8xetgwb.jpg','0123456789','Long khánh'),(4,'pbkdf2_sha256$1000000$Zyu9eoLkVvg5CJu8M4zYLn$6SoZ+uXRYfibduH+X+PZDlMuDLo+ji59WVZhb7bmtRo=','2025-06-13 09:49:48.015939',0,'eventoriganeze1','','','',1,1,'2025-05-18 15:21:15.000000',1,'2025-05-18','image/upload/v1747556561/p6drgyslyzzhaszms9xq.jpg','0123456789','long khanh dong nai'),(5,'pbkdf2_sha256$1000000$Md5ZrvcIzr8xDD7OqrDdMI$pjeXZUKpu9zHC4AhrUzvlSrh9nTW5CRF4bfBwQqyEl8=',NULL,0,'user1','A','Nguyễn Văn','user1@gmail.com',0,1,'2025-06-04 14:43:38.185778',NULL,NULL,'image/upload/v1749737130/kh6tubwcoyomh2thwki2.jpg','0358001963','Long khánh'),(6,'pbkdf2_sha256$1000000$3GKmqfLKQhl5ySu3RzBdJN$DeOelPy5vDb62cMgMeGV7e74sHelFnn2lMJCEpvqEjc=',NULL,0,'user2','B','Nguyễn Văn','user2@gmail.com',0,1,'2025-06-05 11:46:21.875169',NULL,NULL,'image/upload/v1749098785/e0mxap85aqcokfjfno1q.jpg','0123456788',NULL),(7,'pbkdf2_sha256$1000000$DIdOEq9WPZq7sX18rx0HLx$p6r1xq4jC471Dab2EYR7FNwJPHUoLJ0T/3clyEjnhEI=',NULL,0,'user3','Test','Nguyễn Văn','user3@gmail.com',0,1,'2025-06-13 00:07:12.172902',NULL,NULL,'image/upload/v1749748028/red4gv3iuakgwkeboja7.jpg','0358001963',NULL);
/*!40000 ALTER TABLE `tickets_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_user_groups`
--

DROP TABLE IF EXISTS `tickets_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tickets_user_groups_user_id_group_id_8d2f7abd_uniq` (`user_id`,`group_id`),
  KEY `tickets_user_groups_group_id_a446cc88_fk_auth_group_id` (`group_id`),
  CONSTRAINT `tickets_user_groups_group_id_a446cc88_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `tickets_user_groups_user_id_5799bca8_fk_tickets_user_id` FOREIGN KEY (`user_id`) REFERENCES `tickets_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_user_groups`
--

LOCK TABLES `tickets_user_groups` WRITE;
/*!40000 ALTER TABLE `tickets_user_groups` DISABLE KEYS */;
INSERT INTO `tickets_user_groups` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(6,5,3),(7,6,3),(8,7,3);
/*!40000 ALTER TABLE `tickets_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_user_user_permissions`
--

DROP TABLE IF EXISTS `tickets_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tickets_user_user_permis_user_id_permission_id_f34e7843_uniq` (`user_id`,`permission_id`),
  KEY `tickets_user_user_pe_permission_id_24eb96a2_fk_auth_perm` (`permission_id`),
  CONSTRAINT `tickets_user_user_pe_permission_id_24eb96a2_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `tickets_user_user_pe_user_id_b14f98f2_fk_tickets_u` FOREIGN KEY (`user_id`) REFERENCES `tickets_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_user_user_permissions`
--

LOCK TABLES `tickets_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `tickets_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickets_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_venue`
--

DROP TABLE IF EXISTS `tickets_venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_venue` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `name` varchar(100) NOT NULL,
  `capacity` int NOT NULL,
  `img_seat` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_venue`
--

LOCK TABLES `tickets_venue` WRITE;
/*!40000 ALTER TABLE `tickets_venue` DISABLE KEYS */;
INSERT INTO `tickets_venue` VALUES (1,'2025-05-17 22:24:23.049866','2025-05-17 22:24:23.049866',1,'White place',20,'image/upload/v1747495462/h6edulf3ahxdzffygkxs.jpg','long khánh',NULL,NULL),(2,'2025-06-06 11:02:24.122605','2025-06-06 11:02:24.123141',1,'White place 2',30,'image/upload/v1749182545/cg72snradx9olm2dzeki.jpg','Gò vấp',10.8306171,106.6779308);
/*!40000 ALTER TABLE `tickets_venue` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-29 19:34:16
