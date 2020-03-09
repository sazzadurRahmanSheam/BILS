-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.8-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for bils_new_db
CREATE DATABASE IF NOT EXISTS `bils_new_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `bils_new_db`;

-- Dumping structure for table bils_new_db.app_users
CREATE TABLE IF NOT EXISTS `app_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `nid_no` varchar(20) DEFAULT NULL,
  `contact_no` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `user_profile_image` varchar(50) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '0: In-active, 1:Active',
  `user_type` int(2) NOT NULL DEFAULT 2 COMMENT '1: Admin user, 2: App User',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.app_users: ~8 rows (approximately)
/*!40000 ALTER TABLE `app_users` DISABLE KEYS */;
INSERT INTO `app_users` (`id`, `name`, `nid_no`, `contact_no`, `email`, `address`, `password`, `user_profile_image`, `remarks`, `status`, `user_type`, `created_at`, `updated_at`) VALUES
	(5, 'Sazzadur', '123', '123', 'sazzadur@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-02-10 09:12:29', '2020-02-11 12:47:09'),
	(6, 'abul', '123', '123', 'abul@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-02-10 09:12:29', '2020-02-21 19:41:45'),
	(7, 'babul', '1234', '123', 'babul@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-02-10 09:12:29', '2020-03-03 14:35:30'),
	(8, 'Siam', '123', '123', 'siam@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-03-05 06:42:11', '2020-03-05 06:42:11'),
	(9, 'Mizanur', '123', '123', 'mizanur@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-03-05 06:43:09', '2020-03-05 06:43:09'),
	(10, 'Chaki', '123', '123', 'chaki@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-03-05 06:44:27', '2020-03-05 06:44:27'),
	(11, 'Jahed', '123', '123', 'jahed@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-03-05 06:44:56', '2020-03-05 06:44:56'),
	(12, 'Momit', '123', '123', 'momit@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-03-05 06:45:39', '2020-03-05 06:45:39');
/*!40000 ALTER TABLE `app_users` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.app_user_group_members
CREATE TABLE IF NOT EXISTS `app_user_group_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0 : no access, 1 : access',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 2` (`group_id`,`app_user_id`),
  KEY `FK_app_user_group_members_app_users` (`app_user_id`),
  CONSTRAINT `FK_app_user_group_members_app_users` FOREIGN KEY (`app_user_id`) REFERENCES `app_users` (`id`),
  CONSTRAINT `FK_app_user_group_members_user_groups` FOREIGN KEY (`group_id`) REFERENCES `user_groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.app_user_group_members: ~22 rows (approximately)
/*!40000 ALTER TABLE `app_user_group_members` DISABLE KEYS */;
INSERT INTO `app_user_group_members` (`id`, `app_user_id`, `group_id`, `status`, `created_at`, `updated_at`) VALUES
	(1, 5, 30, 1, '2020-02-10 09:12:29', '2020-02-18 20:29:21'),
	(2, 5, 27, 1, '2020-02-10 09:48:22', '2020-02-18 20:29:21'),
	(4, 6, 31, 1, '2020-02-22 12:52:15', NULL),
	(5, 5, 31, 1, '2020-02-22 12:52:49', NULL),
	(6, 7, 31, 1, '2020-02-22 12:56:46', NULL),
	(7, 7, 30, 1, '2020-02-22 12:57:09', NULL),
	(8, 8, 33, 1, '2020-03-05 06:42:11', '2020-03-05 06:42:11'),
	(9, 9, 27, 1, '2020-03-05 06:43:09', '2020-03-05 06:43:09'),
	(10, 9, 30, 1, '2020-03-05 06:43:09', '2020-03-05 06:43:09'),
	(11, 9, 31, 1, '2020-03-05 06:43:09', '2020-03-05 06:43:09'),
	(12, 9, 32, 1, '2020-03-05 06:43:09', '2020-03-05 06:43:09'),
	(13, 9, 33, 1, '2020-03-05 06:43:09', '2020-03-05 06:43:09'),
	(14, 10, 32, 1, '2020-03-05 06:44:27', '2020-03-05 06:44:27'),
	(15, 11, 27, 1, '2020-03-05 06:44:57', '2020-03-05 06:44:57'),
	(16, 11, 30, 1, '2020-03-05 06:44:57', '2020-03-05 06:44:57'),
	(17, 11, 31, 1, '2020-03-05 06:44:57', '2020-03-05 06:44:57'),
	(18, 11, 32, 1, '2020-03-05 06:44:58', '2020-03-05 06:44:58'),
	(19, 11, 33, 1, '2020-03-05 06:44:58', '2020-03-05 06:44:58'),
	(20, 12, 27, 1, '2020-03-05 06:45:39', '2020-03-05 06:45:39'),
	(21, 12, 30, 1, '2020-03-05 06:45:39', '2020-03-05 06:45:39'),
	(22, 12, 31, 1, '2020-03-05 06:45:39', '2020-03-05 06:45:39'),
	(23, 12, 32, 1, '2020-03-05 06:45:39', '2020-03-05 06:45:39'),
	(24, 12, 33, 1, '2020-03-05 06:45:39', '2020-03-05 06:45:39');
/*!40000 ALTER TABLE `app_user_group_members` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.course_categories
CREATE TABLE IF NOT EXISTS `course_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0: In-active, 1: Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.course_categories: ~0 rows (approximately)
/*!40000 ALTER TABLE `course_categories` DISABLE KEYS */;
INSERT INTO `course_categories` (`id`, `category_name`, `details`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Math', 'Basic Math Will Here', 1, '2020-02-11 06:19:33', '2020-02-11 07:10:45'),
	(3, 'English', 'here is english', 1, '2020-03-03 10:42:40', '2020-03-03 10:42:40');
/*!40000 ALTER TABLE `course_categories` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.course_masters
CREATE TABLE IF NOT EXISTS `course_masters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_title` varchar(100) NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `appx_start_time` date DEFAULT NULL,
  `appx_end_time` date DEFAULT NULL,
  `act_start_time` date DEFAULT NULL,
  `act_end_time` date DEFAULT NULL,
  `course_type` int(11) DEFAULT NULL COMMENT 'from course categories table',
  `course_teacher` varchar(50) DEFAULT NULL COMMENT 'form teacher table',
  `course_responsible_person` varchar(15) DEFAULT 'admin',
  `details` text DEFAULT NULL,
  `course_status` tinyint(1) DEFAULT NULL COMMENT '1: Initiate, 2: Approved, 3: Rejected, 4: Started, 5: Completed',
  `payment_fee` double DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL COMMENT 'from paymet_methods table',
  `discount_message` text DEFAULT NULL,
  `attachment` varchar(50) DEFAULT NULL,
  `pub_status` tinyint(1) DEFAULT NULL COMMENT '0: Not-published, 1: Published',
  `created_by` varchar(20) DEFAULT '',
  `updated_by` varchar(20) DEFAULT '',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.course_masters: ~2 rows (approximately)
/*!40000 ALTER TABLE `course_masters` DISABLE KEYS */;
INSERT INTO `course_masters` (`id`, `course_title`, `duration`, `appx_start_time`, `appx_end_time`, `act_start_time`, `act_end_time`, `course_type`, `course_teacher`, `course_responsible_person`, `details`, `course_status`, `payment_fee`, `payment_method`, `discount_message`, `attachment`, `pub_status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(4, 'Labour Study', 5, '2020-03-04', '2020-03-26', NULL, NULL, 3, 'Sazzadur Raman', 'admin', 'This is about details. This is about details. This is about details. This is about details. This is about details. This is about details. \r\nThis is about details. This is about details. This is about details. This is about details. This is about details. This is about details. \r\nThis is about details. This is about details. This is about details. This is about details. This is about details. This is about details. \r\nThis is about details. This is about details. This is about details. This is about details. This is about details. This is about details. \r\nThis is about details. This is about details. This is about details. This is about details. This is about details. This is about details. \r\nThis is about details. This is about details. This is about details. This is about details. This is about details. This is about details.', 1, 5000, 'Bkash', NULL, NULL, 1, 'Momit', 'Momit', '2020-03-05 06:06:36', '2020-03-09 08:03:29'),
	(5, 'Web Design', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', 'this is about web design.', 1, NULL, NULL, NULL, NULL, 1, 'Momit', 'Momit', '2020-03-05 07:41:23', '2020-03-05 10:23:40');
/*!40000 ALTER TABLE `course_masters` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.course_perticipants
CREATE TABLE IF NOT EXISTS `course_perticipants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) DEFAULT NULL,
  `perticipant_id` int(11) DEFAULT NULL,
  `is_interested` tinyint(1) DEFAULT NULL COMMENT '0: Not seen, 1: Interested, 2:NOt interested, 3:registered, 4:not-registered',
  `is_selected` tinyint(1) DEFAULT NULL COMMENT '0: Not-selected, 1: Selected',
  `status` tinyint(1) DEFAULT NULL COMMENT '1: Active, 2: Removed',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.course_perticipants: ~16 rows (approximately)
/*!40000 ALTER TABLE `course_perticipants` DISABLE KEYS */;
INSERT INTO `course_perticipants` (`id`, `course_id`, `perticipant_id`, `is_interested`, `is_selected`, `status`, `created_at`, `updated_at`) VALUES
	(4, 4, 6, 0, NULL, NULL, '2020-03-05 06:47:39', '2020-03-05 06:47:39'),
	(5, 4, 7, 0, NULL, NULL, '2020-03-05 06:47:39', '2020-03-05 06:47:39'),
	(6, 4, 10, 1, 0, NULL, '2020-03-05 06:47:39', '2020-03-07 06:38:14'),
	(7, 4, 11, 1, 0, NULL, '2020-03-05 06:47:39', '2020-03-07 06:38:14'),
	(8, 4, 9, 1, 0, NULL, '2020-03-05 06:47:39', '2020-03-06 10:53:45'),
	(9, 4, 12, 3, 1, NULL, '2020-03-05 06:47:39', '2020-03-09 13:53:23'),
	(10, 4, 5, 0, NULL, NULL, '2020-03-05 06:47:39', '2020-03-05 06:47:39'),
	(11, 4, 8, 1, 0, NULL, '2020-03-05 06:47:39', '2020-03-06 13:30:54'),
	(12, 5, 6, 0, NULL, NULL, '2020-03-05 10:23:40', '2020-03-05 10:23:40'),
	(13, 5, 7, 0, NULL, NULL, '2020-03-05 10:23:40', '2020-03-05 10:23:40'),
	(14, 5, 10, 0, NULL, NULL, '2020-03-05 10:23:40', '2020-03-05 10:23:40'),
	(15, 5, 11, 0, NULL, NULL, '2020-03-05 10:23:40', '2020-03-05 10:23:40'),
	(16, 5, 9, 0, NULL, NULL, '2020-03-05 10:23:40', '2020-03-05 10:23:40'),
	(17, 5, 12, 0, NULL, NULL, '2020-03-05 10:23:40', '2020-03-05 10:23:40'),
	(18, 5, 5, 0, NULL, NULL, '2020-03-05 10:23:40', '2020-03-05 10:23:40'),
	(19, 5, 8, 0, NULL, NULL, '2020-03-05 10:23:40', '2020-03-05 10:23:40');
/*!40000 ALTER TABLE `course_perticipants` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8_unicode_ci NOT NULL,
  `queue` text COLLATE utf8_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_new_db.failed_jobs: ~0 rows (approximately)
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8_unicode_ci NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_new_db.jobs: ~0 rows (approximately)
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.menus
CREATE TABLE IF NOT EXISTS `menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `menu_title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `menu_url` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT 0,
  `serial_no` int(11) DEFAULT NULL,
  `menu_icon_class` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1:active, 0:inactive',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_new_db.menus: ~26 rows (approximately)
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` (`id`, `module_name`, `menu_title`, `menu_url`, `parent_id`, `serial_no`, `menu_icon_class`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'User', 'Users', '', 0, 1, 'clip-user-plus', 1, '0000-00-00 00:00:00', '2020-02-04 11:46:09'),
	(2, 'User', 'Admin Users', 'user/admin/admin-user-management', 1, 1, NULL, 1, '0000-00-00 00:00:00', '2020-02-04 12:09:48'),
	(4, 'User', 'App Users', 'user/app-user/app-user-management', 1, 3, NULL, 1, '0000-00-00 00:00:00', '2020-02-04 12:28:13'),
	(6, 'Surveys', 'Surveys', 'survey/management', 0, 3, 'clip-note', 1, '0000-00-00 00:00:00', '2020-02-04 12:28:13'),
	(7, 'Courses', 'Courses', '', 0, 2, 'clip-book', 1, '0000-00-00 00:00:00', '2020-02-04 12:28:13'),
	(8, 'Courses', 'Manage Courses', 'courses/open-course', 7, 1, NULL, 1, '0000-00-00 00:00:00', '2020-03-09 07:43:18'),
	(10, 'Cpanel', 'Control Panel', '', 0, NULL, 'clip-settings', 1, '0000-00-00 00:00:00', '2020-02-04 12:28:13'),
	(11, 'Cpanel', 'General Setting', 'cp/general/general-setting', 10, NULL, '', 1, '0000-00-00 00:00:00', '2020-02-04 12:28:13'),
	(13, 'Cpanel', 'Manage Module', 'cp/module/manage-module', 10, NULL, NULL, 1, '0000-00-00 00:00:00', '2020-02-04 11:28:38'),
	(21, 'Cpanel', 'Web Actions', 'cp/web-action/web-action-management', 10, NULL, NULL, 1, '2020-02-04 12:20:29', '2020-02-04 12:21:40'),
	(26, 'Settings', 'Settings', '', 0, NULL, 'clip-wrench-2', 1, '2020-02-05 10:05:14', '2020-02-05 10:05:14'),
	(27, 'Settings', 'Admin User Groups', 'settings/admin/admin-group-management', 26, NULL, NULL, 1, '2020-02-05 10:06:31', '2020-02-05 10:07:23'),
	(28, 'Settings', 'App User Groups', 'settings/app-user/app-user-group-management', 26, NULL, NULL, 1, '2020-02-07 13:30:00', '2020-02-07 13:30:00'),
	(29, 'Messages', 'Messages', '', 0, NULL, 'clip-bubbles-3', 1, '2020-02-07 13:33:57', '2020-02-07 13:36:38'),
	(30, 'Messages', 'All Messages', 'messages/all-messages-management', 29, NULL, NULL, 1, '2020-02-07 13:38:13', '2020-02-07 13:38:13'),
	(31, 'Messages', 'Group Messages', 'messages/group-messages-management', 29, NULL, NULL, 1, '2020-02-07 13:39:00', '2020-02-07 13:39:00'),
	(32, 'Settings', 'Message Groups', 'settings/messages/all-messages-management', 26, NULL, NULL, 1, '2020-02-07 14:22:46', '2020-02-07 14:22:46'),
	(33, 'Settings', 'Publication Category', 'settings/publication/publication-category', 26, NULL, NULL, 1, '2020-02-10 10:25:48', '2020-02-10 10:25:48'),
	(34, 'Settings', 'Course Category', 'settings/courses/manage-courses-category', 26, NULL, NULL, 1, '2020-02-11 05:47:48', '2020-02-11 05:47:48'),
	(35, 'Settings', 'Notice Category', 'settings/notice/manage-notice-category', 26, NULL, NULL, 1, '2020-02-11 09:53:05', '2020-02-11 09:53:05'),
	(36, 'Settings', 'Survey Category', 'settings/survey/manage-survey-category', 26, NULL, NULL, 1, '2020-02-11 13:08:18', '2020-02-11 13:08:18'),
	(37, 'Notice', 'Notice', 'notice/manage-notice', 0, NULL, 'clip-notification', 1, '2020-02-18 11:21:38', '2020-02-18 11:21:38'),
	(38, 'Publication', 'Publication', 'publication/publication-management', 0, NULL, 'clip-stack-empty', 1, '2020-02-22 10:01:15', '2020-02-22 10:01:15'),
	(39, 'Messages', 'Sent Message', 'messages/sent-message', 29, NULL, NULL, 1, '2020-02-29 06:44:15', '2020-02-29 06:44:15'),
	(40, 'Settings', 'Message Category', 'settings/message/message-category', 26, NULL, NULL, 1, '2020-03-02 14:16:36', '2020-03-03 08:34:46'),
	(42, 'Courses', 'Manage Teacher', 'course/teacher/manage-teacher', 7, NULL, NULL, 1, '2020-03-07 10:01:49', '2020-03-07 10:19:13');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.message_categories
CREATE TABLE IF NOT EXISTS `message_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0 COMMENT '0: In-active, 1: Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.message_categories: ~0 rows (approximately)
/*!40000 ALTER TABLE `message_categories` DISABLE KEYS */;
INSERT INTO `message_categories` (`id`, `category_name`, `details`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'All', 'All User can sent message', 1, '2020-03-03 11:35:54', '2020-03-03 11:42:05');
/*!40000 ALTER TABLE `message_categories` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.message_masters
CREATE TABLE IF NOT EXISTS `message_masters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `admin_message` text DEFAULT NULL,
  `app_user_id` int(11) DEFAULT NULL,
  `app_user_message` text DEFAULT NULL,
  `is_seen` tinyint(1) DEFAULT 0 COMMENT '0: Not-seen, 1: Seen',
  `message_category` int(11) DEFAULT NULL,
  `message_date_time` timestamp NULL DEFAULT current_timestamp(),
  `attachment` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '0: In-active, 1: Active, 2: Deleted',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.message_masters: ~2 rows (approximately)
/*!40000 ALTER TABLE `message_masters` DISABLE KEYS */;
INSERT INTO `message_masters` (`id`, `message_id`, `admin_id`, `admin_message`, `app_user_id`, `app_user_message`, `is_seen`, `message_category`, `message_date_time`, `attachment`, `status`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, 'test message', 5, NULL, 0, NULL, '2020-02-29 13:15:04', NULL, 0, '2020-02-29 07:15:04', '2020-02-29 17:12:38'),
	(2, 1, 1, 'test message', 6, NULL, 0, NULL, '2020-02-29 13:15:04', NULL, 0, '2020-02-29 07:15:04', '2020-02-29 17:24:42');
/*!40000 ALTER TABLE `message_masters` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_new_db.migrations: ~4 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2020_01_24_063021_create_jobs_table', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.notices
CREATE TABLE IF NOT EXISTS `notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `notice_date` date DEFAULT NULL,
  `attachment` varchar(200) DEFAULT '',
  `expire_date` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '0: In-active, 1: Active',
  `created_by` varchar(20) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.notices: ~0 rows (approximately)
/*!40000 ALTER TABLE `notices` DISABLE KEYS */;
INSERT INTO `notices` (`id`, `title`, `details`, `notice_date`, `attachment`, `expire_date`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 'First Notice Title', 'First test Notice Details', NULL, '', NULL, 1, 'Momit', 'Momit', '2020-02-22 09:12:14', '2020-02-22 09:13:56');
/*!40000 ALTER TABLE `notices` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.notice_categories
CREATE TABLE IF NOT EXISTS `notice_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0: In-active, 1: Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.notice_categories: ~2 rows (approximately)
/*!40000 ALTER TABLE `notice_categories` DISABLE KEYS */;
INSERT INTO `notice_categories` (`id`, `category_name`, `details`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Notice Category', 'DetailS', 1, '2020-02-11 12:24:04', '2020-02-11 12:42:34'),
	(2, 'Notice Category1', 'notice details', 0, '2020-02-11 12:40:21', '2020-02-11 12:50:57');
/*!40000 ALTER TABLE `notice_categories` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_id` int(11) DEFAULT NULL,
  `from_user_type` varchar(50) DEFAULT '' COMMENT 'Admin Or App User',
  `to_id` int(11) DEFAULT NULL,
  `to_user_type` varchar(50) DEFAULT '' COMMENT 'Admin Or App User',
  `date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `notification_title` varchar(255) DEFAULT '',
  `message` text DEFAULT NULL,
  `view_url` varchar(100) DEFAULT NULL COMMENT 'moduleName/id',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: Un-seen, 1: Seen',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COMMENT='m';

-- Dumping data for table bils_new_db.notifications: ~16 rows (approximately)
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` (`id`, `from_id`, `from_user_type`, `to_id`, `to_user_type`, `date_time`, `notification_title`, `message`, `view_url`, `status`, `created_at`, `updated_at`) VALUES
	(12, 1, 'Admin', 6, 'App User', '2020-03-05 12:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 06:47:39', '2020-03-05 06:47:39'),
	(13, 1, 'Admin', 7, 'App User', '2020-03-05 12:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 06:47:39', '2020-03-05 06:47:39'),
	(14, 1, 'Admin', 10, 'App User', '2020-03-05 12:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 06:47:39', '2020-03-05 06:47:39'),
	(15, 1, 'Admin', 11, 'App User', '2020-03-05 12:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 06:47:39', '2020-03-05 06:47:39'),
	(16, 1, 'Admin', 9, 'App User', '2020-03-05 12:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 06:47:39', '2020-03-05 06:47:39'),
	(17, 1, 'Admin', 12, 'App User', '2020-03-05 12:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 06:47:39', '2020-03-05 06:47:39'),
	(18, 1, 'Admin', 5, 'App User', '2020-03-05 12:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 06:47:39', '2020-03-05 06:47:39'),
	(19, 1, 'Admin', 8, 'App User', '2020-03-05 12:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 06:47:39', '2020-03-05 06:47:39'),
	(20, 1, 'Admin', 6, 'App User', '2020-03-05 16:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 10:23:40', '2020-03-05 10:23:40'),
	(21, 1, 'Admin', 7, 'App User', '2020-03-05 16:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 10:23:40', '2020-03-05 10:23:40'),
	(22, 1, 'Admin', 10, 'App User', '2020-03-05 16:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 10:23:40', '2020-03-05 10:23:40'),
	(23, 1, 'Admin', 11, 'App User', '2020-03-05 16:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 10:23:40', '2020-03-05 10:23:40'),
	(24, 1, 'Admin', 9, 'App User', '2020-03-05 16:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 10:23:40', '2020-03-05 10:23:40'),
	(25, 1, 'Admin', 12, 'App User', '2020-03-05 16:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 10:23:40', '2020-03-05 10:23:40'),
	(26, 1, 'Admin', 5, 'App User', '2020-03-05 16:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 10:23:40', '2020-03-05 10:23:40'),
	(27, 1, 'Admin', 8, 'App User', '2020-03-05 16:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 10:23:40', '2020-03-05 10:23:40');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_new_db.password_resets: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.publications
CREATE TABLE IF NOT EXISTS `publications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publication_title` varchar(150) DEFAULT '',
  `details` text DEFAULT '',
  `publication_type` varchar(50) DEFAULT NULL,
  `authors` varchar(100) DEFAULT '',
  `attachment` varchar(255) DEFAULT '',
  `status` tinyint(1) DEFAULT NULL COMMENT '0: In-active, 1: Active',
  `created_by` varchar(20) DEFAULT '',
  `updated_by` varchar(20) DEFAULT '',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.publications: ~2 rows (approximately)
/*!40000 ALTER TABLE `publications` DISABLE KEYS */;
INSERT INTO `publications` (`id`, `publication_title`, `details`, `publication_type`, `authors`, `attachment`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 'labour stadies', 'something something something something something something. something something something something something something. something something something something something something.', 'Article', 'siam', '', 1, 'Momit', '', '2020-02-22 11:11:46', '2020-02-22 18:31:24'),
	(2, 'test', 'test details', 'Article', 'chanchol', '', 0, 'Momit', 'Momit', '2020-02-22 11:12:28', '2020-02-22 12:33:09');
/*!40000 ALTER TABLE `publications` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.publication_categories
CREATE TABLE IF NOT EXISTS `publication_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0 COMMENT '0: In-active, 1: Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.publication_categories: ~2 rows (approximately)
/*!40000 ALTER TABLE `publication_categories` DISABLE KEYS */;
INSERT INTO `publication_categories` (`id`, `category_name`, `details`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Article', 'some article type will goes here', 1, '2020-02-10 11:38:13', '2020-02-10 11:38:13'),
	(2, 'test', 'some article type will goes here', 1, '2020-02-10 12:17:31', '2020-02-22 18:32:04');
/*!40000 ALTER TABLE `publication_categories` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `short_name` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `site_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin_email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin_mobile` varchar(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  `site_url` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin_url` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_new_db.settings: ~0 rows (approximately)
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`id`, `company_name`, `short_name`, `site_name`, `admin_email`, `admin_mobile`, `site_url`, `admin_url`, `logo`, `address`, `created_at`, `updated_at`) VALUES
	(1, 'Bangladesh Institute of Labour Studies', 'BILS', 'BILS APPLICATION', 'admin@bils.com', '01980340482', NULL, '/admin', NULL, 'Dhaka', NULL, '2020-02-03 17:14:58');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.survey_categories
CREATE TABLE IF NOT EXISTS `survey_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0 COMMENT '0: In-active, 1: Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.survey_categories: ~2 rows (approximately)
/*!40000 ALTER TABLE `survey_categories` DISABLE KEYS */;
INSERT INTO `survey_categories` (`id`, `category_name`, `details`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Survey Category 1', NULL, 1, '2020-02-11 14:00:45', '2020-02-11 14:00:45'),
	(3, 'Survey Category 3', 'asda', 1, '2020-02-11 14:04:45', '2020-03-05 10:27:09');
/*!40000 ALTER TABLE `survey_categories` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.survey_groups
CREATE TABLE IF NOT EXISTS `survey_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL COMMENT 'From app_user_groups',
  `status` tinyint(1) NOT NULL COMMENT '0: In-active, 1: Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.survey_groups: ~0 rows (approximately)
/*!40000 ALTER TABLE `survey_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_groups` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.survey_masters
CREATE TABLE IF NOT EXISTS `survey_masters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_name` varchar(200) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `survey_category` int(11) NOT NULL COMMENT 'From survey_categories ',
  `survey_type` int(11) NOT NULL,
  `details` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0: Initiate, 1: Published, 2: Closed, 3: In-active',
  `created_by` int(11) NOT NULL COMMENT 'Admin User ID',
  `updated_by` int(11) NOT NULL COMMENT 'Admin User ID',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.survey_masters: ~16 rows (approximately)
/*!40000 ALTER TABLE `survey_masters` DISABLE KEYS */;
INSERT INTO `survey_masters` (`id`, `survey_name`, `start_date`, `end_date`, `survey_category`, `survey_type`, `details`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 'aaaa', '2020-03-06', '2020-03-05', 1, 0, NULL, 1, 1, 1, '2020-03-06 09:38:44', '2020-03-06 17:11:57'),
	(5, 'New Survey', '2020-03-13', '2020-03-28', 3, 0, 'This is a demo survey', 0, 1, 1, '2020-03-07 09:58:24', '2020-03-07 09:58:24'),
	(6, 'New Survey', '2020-03-13', '2020-03-28', 3, 0, 'This is a demo survey', 1, 1, 1, '2020-03-07 10:00:33', '2020-03-07 10:00:33'),
	(7, 'Survey 3', '2020-03-21', '2020-03-28', 3, 0, 'Survey demo', 1, 1, 1, '2020-03-07 10:08:47', '2020-03-07 10:08:47'),
	(8, 'survey test', '2020-03-13', '2020-03-28', 3, 0, 'asjdf llk asjdf;lk lksaj df', 1, 1, 1, '2020-03-07 10:19:18', '2020-03-07 10:19:18'),
	(9, 'test survvey', '2020-03-20', '2020-03-06', 3, 0, 'sadfsadf', 1, 1, 1, '2020-03-07 10:21:02', '2020-03-07 10:21:02'),
	(10, 'test survey sdf', '2020-03-12', '2020-03-27', 1, 0, 'sadfdsaf', 1, 1, 1, '2020-03-07 10:22:10', '2020-03-07 10:22:10'),
	(11, 'new', '2020-03-20', '2020-03-14', 1, 0, 'sfdsfd', 1, 1, 1, '2020-03-07 10:26:18', '2020-03-07 10:26:18'),
	(12, 'sdfsdf', '2020-03-19', '2020-03-12', 3, 0, 'sadfsdf', 1, 1, 1, '2020-03-07 10:27:12', '2020-03-07 10:27:12'),
	(13, 'iuytr', '2020-03-21', '2020-03-12', 3, 0, 'sdfgdfsg', 1, 1, 1, '2020-03-07 10:28:24', '2020-03-07 10:28:24'),
	(14, 'fsda', '2020-03-06', '2020-03-18', 3, 0, 'sadf', 1, 1, 1, '2020-03-07 10:30:08', '2020-03-07 10:30:08'),
	(15, 'jhk', '2020-03-12', '2020-03-21', 3, 0, 'vxczxcv', 1, 1, 1, '2020-03-07 10:35:26', '2020-03-07 10:35:26'),
	(16, 'dfgh', '2020-03-13', '2020-03-27', 3, 0, 'asdfasdf', 1, 1, 1, '2020-03-07 10:36:40', '2020-03-07 10:36:40'),
	(17, 'new survey', '2020-03-13', '2020-03-28', 3, 0, 'asdfsdaf', 1, 1, 1, '2020-03-07 10:40:13', '2020-03-07 10:40:13'),
	(18, 'name', '2020-03-13', '2020-03-28', 1, 0, 'asdfasdf asdfsdf asfdsadfsdaf sadf dsfg', 1, 1, 1, '2020-03-07 10:41:16', '2020-03-07 10:57:40'),
	(19, 'aaaaa', '2020-03-13', '2020-03-27', 1, 0, 'asfdsdf', 1, 1, 1, '2020-03-07 11:39:46', '2020-03-07 11:39:46');
/*!40000 ALTER TABLE `survey_masters` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.survey_participants
CREATE TABLE IF NOT EXISTS `survey_participants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_user_id` int(11) NOT NULL,
  `survey_id` int(11) NOT NULL,
  `answer_date` date NOT NULL,
  `is_answered` tinyint(1) DEFAULT NULL COMMENT '0: Not-answer, 1: Answer',
  `survey_completed` tinyint(1) DEFAULT NULL COMMENT '0: Not-completed, 1: Completed',
  `status` tinyint(1) DEFAULT NULL COMMENT '0: In-active, 1: Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.survey_participants: ~0 rows (approximately)
/*!40000 ALTER TABLE `survey_participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_participants` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.survey_participant_answers
CREATE TABLE IF NOT EXISTS `survey_participant_answers` (
  `survey_participan_id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_question_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`survey_participan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.survey_participant_answers: ~0 rows (approximately)
/*!40000 ALTER TABLE `survey_participant_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_participant_answers` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.survey_participant_answer_options
CREATE TABLE IF NOT EXISTS `survey_participant_answer_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_participant_answer_id` int(11) DEFAULT NULL,
  `option_id` int(11) DEFAULT 0,
  `answer` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.survey_participant_answer_options: ~0 rows (approximately)
/*!40000 ALTER TABLE `survey_participant_answer_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_participant_answer_options` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.survey_questions
CREATE TABLE IF NOT EXISTS `survey_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_id` int(11) DEFAULT NULL,
  `question_details` text DEFAULT NULL,
  `question_type` int(11) DEFAULT NULL COMMENT '1: text 2: number ;3:radio ;3:checkbox',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.survey_questions: ~35 rows (approximately)
/*!40000 ALTER TABLE `survey_questions` DISABLE KEYS */;
INSERT INTO `survey_questions` (`id`, `survey_id`, `question_details`, `question_type`, `created_at`, `updated_at`) VALUES
	(18, 1, 'ashdflkj', 4, '2020-03-06 09:42:49', '2020-03-06 09:42:49'),
	(19, 1, 'ashdflkj', 4, '2020-03-06 09:43:28', '2020-03-06 09:43:28'),
	(21, 1, 'ashdflkj', 4, '2020-03-06 09:45:02', '2020-03-06 09:45:02'),
	(29, 1, 'ashdflkj', 4, '2020-03-06 09:52:34', '2020-03-06 09:52:34'),
	(30, 1, 'new question', 3, '2020-03-06 10:38:34', '2020-03-06 10:38:34'),
	(31, 1, 'new question', 3, '2020-03-06 10:38:35', '2020-03-06 10:38:35'),
	(32, 1, 'ZXC', 3, '2020-03-06 10:40:34', '2020-03-06 10:40:34'),
	(43, 1, 'Question 1', 3, '2020-03-07 09:59:05', '2020-03-07 09:59:05'),
	(44, 1, 'question 2', 4, '2020-03-07 09:59:38', '2020-03-07 09:59:38'),
	(45, 1, 'question 3', 3, '2020-03-07 10:00:09', '2020-03-07 12:07:18'),
	(46, 7, 'question 1', 3, '2020-03-07 10:10:12', '2020-03-07 10:10:12'),
	(47, 7, 'question 1', 3, '2020-03-07 10:11:02', '2020-03-07 10:11:02'),
	(48, 12, 'sadf', 3, '2020-03-07 10:27:19', '2020-03-07 10:27:19'),
	(49, 12, 'asfdsdf', 4, '2020-03-07 10:27:43', '2020-03-07 10:27:43'),
	(50, 13, 'sdfg', 3, '2020-03-07 10:28:36', '2020-03-07 10:28:36'),
	(51, 14, 'asfd', 3, '2020-03-07 10:30:24', '2020-03-07 10:30:24'),
	(52, 15, 'zxvc', 3, '2020-03-07 10:35:38', '2020-03-07 10:35:38'),
	(53, 15, 'xzvc', 4, '2020-03-07 10:35:57', '2020-03-07 10:35:57'),
	(54, 16, 'sadf', 3, '2020-03-07 10:37:00', '2020-03-07 10:37:00'),
	(55, 16, 'asdfsadf', 4, '2020-03-07 10:37:16', '2020-03-07 10:37:16'),
	(56, 16, 'safd', 4, '2020-03-07 10:37:33', '2020-03-07 10:37:33'),
	(57, 17, 'question', 3, '2020-03-07 10:40:35', '2020-03-07 10:40:35'),
	(60, 18, 'cccccc', 1, '2020-03-07 10:43:29', '2020-03-07 11:29:47'),
	(61, 18, 'sdafsaf', 2, '2020-03-07 10:43:40', '2020-03-07 10:43:40'),
	(62, 18, 'bbbbbb', 3, '2020-03-07 10:43:52', '2020-03-07 11:27:25'),
	(63, 18, 'cccc', 3, '2020-03-07 10:44:02', '2020-03-07 11:37:22'),
	(64, 18, 'xzcvxzcv', 3, '2020-03-07 11:35:37', '2020-03-07 11:35:37'),
	(65, 18, 'dddd', 3, '2020-03-07 11:37:33', '2020-03-07 11:38:20'),
	(66, 19, 'aaa', 1, '2020-03-07 11:39:54', '2020-03-07 11:39:54'),
	(67, 19, 'bbbd', 2, '2020-03-07 11:40:00', '2020-03-07 11:41:20'),
	(68, 19, 'ccc', 3, '2020-03-07 11:40:13', '2020-03-07 11:45:48'),
	(70, 1, 'dsfgsg', 1, '2020-03-07 12:07:25', '2020-03-07 12:07:25'),
	(71, 1, 'vvvv', 3, '2020-03-07 12:07:35', '2020-03-07 12:36:08'),
	(72, 1, 'dsgfgdfg', 2, '2020-03-07 12:07:44', '2020-03-07 12:07:44'),
	(73, 1, 'iiiiiii', 3, '2020-03-07 12:36:45', '2020-03-07 12:36:45');
/*!40000 ALTER TABLE `survey_questions` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.survey_question_answer_options
CREATE TABLE IF NOT EXISTS `survey_question_answer_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_question_id` int(11) NOT NULL DEFAULT 0,
  `answer_option` varchar(255) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.survey_question_answer_options: ~78 rows (approximately)
/*!40000 ALTER TABLE `survey_question_answer_options` DISABLE KEYS */;
INSERT INTO `survey_question_answer_options` (`id`, `survey_question_id`, `answer_option`, `created_at`, `updated_at`) VALUES
	(22, 43, 'answer 1', '2020-03-07 09:59:05', '2020-03-07 09:59:05'),
	(23, 43, 'answer 2', '2020-03-07 09:59:05', '2020-03-07 09:59:05'),
	(24, 43, 'answer 3', '2020-03-07 09:59:05', '2020-03-07 09:59:05'),
	(25, 43, 'answer 4', '2020-03-07 09:59:05', '2020-03-07 09:59:05'),
	(26, 44, 'answer 1', '2020-03-07 09:59:38', '2020-03-07 09:59:38'),
	(27, 44, 'answer 2', '2020-03-07 09:59:38', '2020-03-07 09:59:38'),
	(28, 44, 'answer 3', '2020-03-07 09:59:38', '2020-03-07 09:59:38'),
	(29, 44, 'answer 4', '2020-03-07 09:59:38', '2020-03-07 09:59:38'),
	(30, 44, 'answer 5', '2020-03-07 09:59:38', '2020-03-07 09:59:38'),
	(31, 45, 'answer 2', '2020-03-07 10:00:09', '2020-03-07 12:07:18'),
	(33, 46, 'asfd', '2020-03-07 10:10:12', '2020-03-07 10:10:12'),
	(34, 46, 'asfd', '2020-03-07 10:10:12', '2020-03-07 10:10:12'),
	(35, 47, 'asfd', '2020-03-07 10:11:02', '2020-03-07 10:11:02'),
	(36, 47, 'asfd', '2020-03-07 10:11:02', '2020-03-07 10:11:02'),
	(37, 47, 'safdsad', '2020-03-07 10:11:02', '2020-03-07 10:11:02'),
	(38, 48, 'sdf', '2020-03-07 10:27:19', '2020-03-07 10:27:19'),
	(39, 48, 'sdfs', '2020-03-07 10:27:19', '2020-03-07 10:27:19'),
	(40, 49, 'sdf', '2020-03-07 10:27:43', '2020-03-07 10:27:43'),
	(41, 49, 'sdfd', '2020-03-07 10:27:43', '2020-03-07 10:27:43'),
	(42, 49, 'sdfsd', '2020-03-07 10:27:43', '2020-03-07 10:27:43'),
	(43, 49, 'asdfasfd', '2020-03-07 10:27:43', '2020-03-07 10:27:43'),
	(44, 50, 'dsfg', '2020-03-07 10:28:36', '2020-03-07 10:28:36'),
	(45, 50, 'dsfgd', '2020-03-07 10:28:36', '2020-03-07 10:28:36'),
	(46, 50, 'dsfg', '2020-03-07 10:28:36', '2020-03-07 10:28:36'),
	(47, 51, 'asdf', '2020-03-07 10:30:24', '2020-03-07 10:30:24'),
	(48, 51, 'asfd', '2020-03-07 10:30:24', '2020-03-07 10:30:24'),
	(49, 51, 'adfsa', '2020-03-07 10:30:24', '2020-03-07 10:30:24'),
	(50, 51, 'asfd', '2020-03-07 10:30:24', '2020-03-07 10:30:24'),
	(51, 51, 'sadf', '2020-03-07 10:30:24', '2020-03-07 10:30:24'),
	(52, 52, 'zxvc', '2020-03-07 10:35:38', '2020-03-07 10:35:38'),
	(53, 52, 'zxcv', '2020-03-07 10:35:38', '2020-03-07 10:35:38'),
	(54, 52, 'xzcv', '2020-03-07 10:35:38', '2020-03-07 10:35:38'),
	(55, 53, 'zxvczv', '2020-03-07 10:35:57', '2020-03-07 10:35:57'),
	(56, 53, 'zxvcxzv', '2020-03-07 10:35:57', '2020-03-07 10:35:57'),
	(57, 54, 'sadf', '2020-03-07 10:37:00', '2020-03-07 10:37:00'),
	(58, 54, 'safddd', '2020-03-07 10:37:00', '2020-03-07 10:37:00'),
	(59, 55, 'asdfsadf', '2020-03-07 10:37:16', '2020-03-07 10:37:16'),
	(60, 55, 'safdsdf', '2020-03-07 10:37:16', '2020-03-07 10:37:16'),
	(61, 55, 'sadfdsaf', '2020-03-07 10:37:16', '2020-03-07 10:37:16'),
	(62, 55, 'asdfsdafsadf', '2020-03-07 10:37:16', '2020-03-07 10:37:16'),
	(63, 56, 'safd', '2020-03-07 10:37:33', '2020-03-07 10:37:33'),
	(64, 56, 'asfddsf', '2020-03-07 10:37:33', '2020-03-07 10:37:33'),
	(65, 56, 'asfd', '2020-03-07 10:37:33', '2020-03-07 10:37:33'),
	(66, 56, 'asdfds', '2020-03-07 10:37:33', '2020-03-07 10:37:33'),
	(67, 57, 'sadf', '2020-03-07 10:40:35', '2020-03-07 10:40:35'),
	(68, 57, 'sadf', '2020-03-07 10:40:35', '2020-03-07 10:40:35'),
	(69, 57, 'safdsadf', '2020-03-07 10:40:35', '2020-03-07 10:40:35'),
	(70, 57, 'asfdf', '2020-03-07 10:40:35', '2020-03-07 10:40:35'),
	(71, 62, 'asdfds', '2020-03-07 10:43:52', '2020-03-07 11:27:25'),
	(72, 62, 'asdfdsf', '2020-03-07 10:43:52', '2020-03-07 11:27:25'),
	(73, 62, 'safddsf', '2020-03-07 10:43:52', '2020-03-07 11:27:25'),
	(74, 63, 'sdfggf', '2020-03-07 10:44:02', '2020-03-07 11:37:22'),
	(75, 63, 'dddd', '2020-03-07 10:44:02', '2020-03-07 11:37:22'),
	(76, 63, 'sdfgdfgdfsg', '2020-03-07 11:24:08', '2020-03-07 11:37:22'),
	(77, 62, 'bbbbbbb', '2020-03-07 11:27:25', '2020-03-07 11:27:25'),
	(78, 63, 'asfdafdasfdasfds', '2020-03-07 11:30:01', '2020-03-07 11:37:22'),
	(79, 63, 'sfdsdfs', '2020-03-07 11:30:44', '2020-03-07 11:37:22'),
	(80, 63, 'dfdsfds', '2020-03-07 11:30:44', '2020-03-07 11:37:22'),
	(81, 63, 'sss', '2020-03-07 11:31:26', '2020-03-07 11:37:22'),
	(82, 63, 'ssss', '2020-03-07 11:31:26', '2020-03-07 11:37:22'),
	(83, 64, 'xzvcx', '2020-03-07 11:35:37', '2020-03-07 11:35:37'),
	(84, 64, 'zcv', '2020-03-07 11:35:37', '2020-03-07 11:35:37'),
	(86, 63, 'cvxv', '2020-03-07 11:35:59', '2020-03-07 11:37:22'),
	(87, 63, 'cc', '2020-03-07 11:36:35', '2020-03-07 11:37:22'),
	(88, 63, 'c', '2020-03-07 11:36:35', '2020-03-07 11:37:22'),
	(89, 65, 'sdfsdf', '2020-03-07 11:38:20', '2020-03-07 11:38:20'),
	(90, 65, 'sfddsf', '2020-03-07 11:38:20', '2020-03-07 11:38:20'),
	(94, 69, 'dfdfdf', '2020-03-07 11:40:24', '2020-03-07 11:41:07'),
	(95, 69, 'dfdfdfd', '2020-03-07 11:40:24', '2020-03-07 11:41:07'),
	(96, 69, 'sfdsfdsf', '2020-03-07 11:40:35', '2020-03-07 11:41:07'),
	(97, 68, 'sdfdsf', '2020-03-07 11:40:54', '2020-03-07 11:45:48'),
	(98, 69, 'fffff', '2020-03-07 11:41:07', '2020-03-07 11:41:07'),
	(99, 68, 'sadfsadf', '2020-03-07 11:45:48', '2020-03-07 11:45:48'),
	(103, 71, 'aas', '2020-03-07 12:09:33', '2020-03-07 12:36:08'),
	(104, 71, 'afdsasdf', '2020-03-07 12:35:54', '2020-03-07 12:36:08'),
	(105, 73, 'sadf', '2020-03-07 12:36:45', '2020-03-07 12:36:45'),
	(106, 73, 'safd', '2020-03-07 12:36:45', '2020-03-07 12:36:45'),
	(107, 73, 'asdf', '2020-03-07 12:36:45', '2020-03-07 12:36:45');
/*!40000 ALTER TABLE `survey_question_answer_options` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.teachers
CREATE TABLE IF NOT EXISTS `teachers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_no` varchar(20) NOT NULL,
  `nid` varchar(20) NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  `user_type` tinyint(1) NOT NULL DEFAULT 3 COMMENT '1:admin, 2:app-use, 3: teaher',
  `status` tinyint(1) NOT NULL COMMENT '0:  In-active, 1: Active, 2: Deleted',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.teachers: ~3 rows (approximately)
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` (`id`, `name`, `email`, `contact_no`, `nid`, `address`, `user_type`, `status`, `created_at`, `updated_at`) VALUES
	(5, 'Sazzadur Raman', 'sazzadur@gmail.com', '01747083028', '1234567890', 'Kalabagan, Dhaka', 3, 2, '2020-03-09 13:51:46', '2020-03-09 07:51:46'),
	(6, 'Momit Hasan', 'momit@technolife.ee', '01980340482', '1234567890', 'mohammadpur', 3, 1, '2020-03-09 12:58:58', '2020-03-09 06:58:58'),
	(7, 'chaki', 'chaki@gmail.com', '01757808214', '11', 'Dhaka', 3, 1, '2020-03-09 16:53:40', '2020-03-09 10:53:40');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nid_no` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `contact_no` varchar(13) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1:admin user , 2:App user, 3: Teacher',
  `user_profile_image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login_status` tinyint(1) DEFAULT NULL COMMENT '1:logged in, 0 not logged in',
  `status` tinyint(1) DEFAULT NULL COMMENT '1:active, 0:in-active',
  `remarks` text COLLATE utf8_unicode_ci DEFAULT '',
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_new_db.users: ~4 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `nid_no`, `contact_no`, `email`, `address`, `user_type`, `user_profile_image`, `password`, `remember_token`, `login_status`, `status`, `remarks`, `last_login`, `created_at`, `updated_at`) VALUES
	(1, 'Momit', '123456', '01711', 'momit@bils.com', 'mohammadpur', 1, '1583753452.jpg', '$2y$10$ta1BmsLnz8H4tUqFJHI8puHxhCldn9DSwVfQjc3g59v9YSxM7.Trq', NULL, 0, 1, 'Very Good person.Very Good person.Very Good person.Very Good person.Very Good person.Very Good person.Very Good person.Very Good person.Very Good person.', '2020-01-24 17:30:45', '2020-01-24 06:51:31', '2020-03-09 18:55:16'),
	(13, 'Momit Hasan', '1234567890', '01980340482', 'momit@technolife.ee', 'mohammadpur', 1, '', NULL, NULL, NULL, 1, '', NULL, '2020-02-02 08:44:30', '2020-03-09 18:23:39'),
	(31, 'SiaM', '123', '01747083028', 'siam@gmail.com', 'Dhanmondi', 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2020-02-09 13:25:51', '2020-03-09 11:04:49'),
	(32, 'Sazzadur Raman', '1234567890', '01747083028', 'sazzadur@gmail.com', 'Kalabagan, Dhaka', 3, NULL, NULL, NULL, NULL, 0, '', NULL, '2020-03-07 12:08:17', '2020-03-09 16:51:09'),
	(33, 'chaki', '11', '01757808214', 'chaki@gmail.com', 'Dhaka', 3, NULL, NULL, NULL, NULL, 1, '', NULL, '2020-03-07 12:23:41', '2020-03-09 10:53:40'),
	(34, 'a', 'a', 'a', 'alex@gmail.com', NULL, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2020-03-09 11:25:12', '2020-03-09 11:25:12'),
	(35, 'aaa', 'aa', 'aa', 'aaaaaa@gmail.com', NULL, 1, '1583753258.png', NULL, NULL, NULL, 1, NULL, NULL, '2020-03-09 11:27:38', '2020-03-09 18:55:25'),
	(36, 'aaa', 'aa', 'aa', 'a@gmail.com', NULL, 1, '1583753353.png', NULL, NULL, NULL, 1, NULL, NULL, '2020-03-09 11:29:13', '2020-03-09 18:55:34'),
	(37, 'aaa', 'aa', 'aa', '11a@gmail.com', NULL, 1, '1583753409.jpg', NULL, NULL, NULL, 1, NULL, NULL, '2020-03-09 11:30:09', '2020-03-09 18:55:45'),
	(38, 'aaa', 'aa', 'aa', '111a@gmail.com', NULL, 1, '1583753409.jpg', NULL, NULL, NULL, 1, NULL, NULL, '2020-03-09 11:30:52', '2020-03-09 19:36:28');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.user_groups
CREATE TABLE IF NOT EXISTS `user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(50) DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1: Admin User, 2: App User',
  `status` int(11) NOT NULL COMMENT '1: Active, 0: In-active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.user_groups: ~9 rows (approximately)
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
INSERT INTO `user_groups` (`id`, `group_name`, `type`, `status`, `created_at`, `updated_at`) VALUES
	(25, 'Sub Admin', 1, 0, '2020-02-07 10:23:56', '2020-02-18 06:53:21'),
	(26, 'Admin', 1, 1, '2020-02-08 11:39:02', '2020-02-08 11:39:02'),
	(27, 'Web View', 2, 1, '2020-02-08 13:02:57', '2020-02-09 12:00:49'),
	(28, 'Sub Admin 1', 1, 0, '2020-02-09 09:57:24', '2020-02-09 09:57:24'),
	(29, 'Sub Admin 2', 1, 0, '2020-02-09 10:48:54', '2020-02-09 10:51:34'),
	(30, 'App View', 2, 1, '2020-02-09 11:37:38', '2020-02-09 11:59:25'),
	(31, 'General', 2, 1, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(32, 'Senior', 2, 1, '2020-03-05 06:40:22', '2020-03-05 06:40:22'),
	(33, 'Joniour', 2, 1, '2020-03-05 06:40:39', '2020-03-05 06:40:39');
/*!40000 ALTER TABLE `user_groups` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.user_group_members
CREATE TABLE IF NOT EXISTS `user_group_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_id` bigint(20) unsigned NOT NULL,
  `group_id` int(11) NOT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '0 : no access, 1 : access',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 4` (`emp_id`,`group_id`),
  KEY `FK_user_group_members_user_groups` (`group_id`),
  CONSTRAINT `FK_user_group_members_user_groups` FOREIGN KEY (`group_id`) REFERENCES `user_groups` (`id`),
  CONSTRAINT `FK_user_group_members_users` FOREIGN KEY (`emp_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.user_group_members: ~4 rows (approximately)
/*!40000 ALTER TABLE `user_group_members` DISABLE KEYS */;
INSERT INTO `user_group_members` (`id`, `emp_id`, `group_id`, `status`, `created_at`, `updated_at`) VALUES
	(1, 31, 25, 1, '2020-02-09 13:25:51', '2020-03-09 17:04:49'),
	(2, 1, 26, 1, '2020-02-09 13:27:08', '2020-03-09 15:54:37'),
	(3, 1, 25, 0, '2020-02-09 13:27:24', '2020-02-18 11:51:05'),
	(6, 31, 26, 0, '2020-02-09 13:42:22', '2020-02-09 13:42:22'),
	(10, 34, 26, 1, '2020-03-09 11:25:12', '2020-03-09 11:25:12'),
	(11, 35, 26, 1, '2020-03-09 11:27:38', '2020-03-09 11:27:38'),
	(12, 36, 26, 1, '2020-03-09 11:29:13', '2020-03-09 11:29:13'),
	(13, 37, 26, 1, '2020-03-09 11:30:09', '2020-03-09 11:30:09'),
	(14, 38, 26, 1, '2020-03-09 11:30:52', '2020-03-09 19:35:59');
/*!40000 ALTER TABLE `user_group_members` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.user_group_permissions
CREATE TABLE IF NOT EXISTS `user_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL DEFAULT 0,
  `action_id` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL COMMENT '0: Not Permit, 1: Permit',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 2` (`group_id`,`action_id`),
  KEY `FK_user_group_permission_web_actions` (`action_id`),
  CONSTRAINT `FK_user_group_permission_user_group` FOREIGN KEY (`group_id`) REFERENCES `user_groups` (`id`),
  CONSTRAINT `FK_user_group_permission_web_actions` FOREIGN KEY (`action_id`) REFERENCES `web_actions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=705 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_new_db.user_group_permissions: ~590 rows (approximately)
/*!40000 ALTER TABLE `user_group_permissions` DISABLE KEYS */;
INSERT INTO `user_group_permissions` (`id`, `group_id`, `action_id`, `status`, `created_at`, `updated_at`) VALUES
	(8, 25, 1, 0, '2020-02-07 10:23:56', '2020-02-18 15:00:27'),
	(9, 25, 2, 0, '2020-02-07 10:23:56', '2020-02-07 10:23:56'),
	(10, 25, 4, 0, '2020-02-07 10:23:56', '2020-02-07 10:23:56'),
	(11, 25, 6, 0, '2020-02-07 10:23:56', '2020-02-07 10:23:56'),
	(12, 25, 7, 0, '2020-02-07 10:23:56', '2020-02-18 11:50:47'),
	(13, 25, 8, 0, '2020-02-07 10:23:56', '2020-02-18 11:50:47'),
	(14, 25, 9, 0, '2020-02-07 10:23:56', '2020-02-07 10:23:56'),
	(15, 25, 10, 0, '2020-02-07 10:23:56', '2020-02-07 10:23:56'),
	(19, 26, 1, 1, '2020-02-08 11:39:02', '2020-03-09 16:33:18'),
	(20, 26, 2, 1, '2020-02-08 11:39:02', '2020-03-09 16:33:18'),
	(21, 26, 4, 1, '2020-02-08 11:39:02', '2020-03-09 16:33:18'),
	(22, 26, 6, 1, '2020-02-08 11:39:02', '2020-03-09 16:33:18'),
	(23, 26, 7, 1, '2020-02-08 11:39:02', '2020-03-09 16:33:18'),
	(24, 26, 8, 1, '2020-02-08 11:39:02', '2020-03-09 16:33:18'),
	(25, 26, 9, 1, '2020-02-08 11:39:02', '2020-03-09 16:33:18'),
	(26, 26, 10, 1, '2020-02-08 11:39:02', '2020-03-09 16:33:18'),
	(27, 27, 1, 0, '2020-02-08 13:02:57', '2020-02-08 13:02:57'),
	(28, 27, 2, 0, '2020-02-08 13:02:57', '2020-02-08 13:02:57'),
	(29, 27, 4, 0, '2020-02-08 13:02:58', '2020-02-08 13:02:58'),
	(30, 27, 6, 0, '2020-02-08 13:02:58', '2020-02-08 13:02:58'),
	(31, 27, 7, 0, '2020-02-08 13:02:58', '2020-02-08 13:02:58'),
	(32, 27, 8, 0, '2020-02-08 13:02:58', '2020-02-08 13:02:58'),
	(33, 27, 9, 0, '2020-02-08 13:02:58', '2020-02-08 13:02:58'),
	(34, 27, 10, 0, '2020-02-08 13:02:58', '2020-02-08 13:02:58'),
	(35, 28, 1, 0, '2020-02-09 09:57:24', '2020-02-09 09:57:24'),
	(36, 28, 2, 0, '2020-02-09 09:57:25', '2020-02-09 09:57:25'),
	(37, 28, 4, 0, '2020-02-09 09:57:25', '2020-02-09 09:57:25'),
	(38, 28, 6, 0, '2020-02-09 09:57:25', '2020-02-09 09:57:25'),
	(39, 28, 7, 0, '2020-02-09 09:57:25', '2020-02-09 09:57:25'),
	(40, 28, 8, 0, '2020-02-09 09:57:25', '2020-02-09 09:57:25'),
	(41, 28, 9, 0, '2020-02-09 09:57:25', '2020-02-09 09:57:25'),
	(42, 28, 10, 0, '2020-02-09 09:57:25', '2020-02-09 09:57:25'),
	(43, 29, 1, 0, '2020-02-09 10:48:54', '2020-02-09 10:48:54'),
	(44, 29, 2, 0, '2020-02-09 10:48:54', '2020-02-09 10:48:54'),
	(45, 29, 4, 0, '2020-02-09 10:48:54', '2020-02-09 10:48:54'),
	(46, 29, 6, 0, '2020-02-09 10:48:54', '2020-02-09 10:48:54'),
	(47, 29, 7, 0, '2020-02-09 10:48:54', '2020-02-09 10:48:54'),
	(48, 29, 8, 0, '2020-02-09 10:48:54', '2020-02-09 10:48:54'),
	(49, 29, 9, 0, '2020-02-09 10:48:54', '2020-02-09 10:48:54'),
	(50, 29, 10, 0, '2020-02-09 10:48:54', '2020-02-09 10:48:54'),
	(51, 30, 1, 0, '2020-02-09 11:37:39', '2020-02-09 11:37:39'),
	(52, 30, 2, 0, '2020-02-09 11:37:39', '2020-02-09 11:37:39'),
	(53, 30, 4, 0, '2020-02-09 11:37:39', '2020-02-09 11:37:39'),
	(54, 30, 6, 0, '2020-02-09 11:37:39', '2020-02-09 11:37:39'),
	(55, 30, 7, 0, '2020-02-09 11:37:39', '2020-02-09 11:37:39'),
	(56, 30, 8, 0, '2020-02-09 11:37:39', '2020-02-09 11:37:39'),
	(57, 30, 9, 0, '2020-02-09 11:37:39', '2020-02-09 11:37:39'),
	(58, 30, 10, 0, '2020-02-09 11:37:39', '2020-02-09 11:37:39'),
	(59, 25, 24, 0, '2020-02-17 13:46:50', '2020-02-17 13:46:50'),
	(60, 26, 24, 1, '2020-02-17 13:46:51', '2020-03-09 16:33:18'),
	(61, 27, 24, 0, '2020-02-17 13:46:51', '2020-02-17 13:46:51'),
	(62, 28, 24, 0, '2020-02-17 13:46:51', '2020-02-17 13:46:51'),
	(63, 29, 24, 0, '2020-02-17 13:46:51', '2020-02-17 13:46:51'),
	(64, 30, 24, 0, '2020-02-17 13:46:51', '2020-02-17 13:46:51'),
	(65, 25, 25, 0, '2020-02-18 06:17:38', '2020-02-18 06:17:38'),
	(66, 26, 25, 1, '2020-02-18 06:17:38', '2020-03-09 16:33:18'),
	(67, 27, 25, 0, '2020-02-18 06:17:38', '2020-02-18 06:17:38'),
	(68, 28, 25, 0, '2020-02-18 06:17:38', '2020-02-18 06:17:38'),
	(69, 29, 25, 0, '2020-02-18 06:17:38', '2020-02-18 06:17:38'),
	(70, 30, 25, 0, '2020-02-18 06:17:38', '2020-02-18 06:17:38'),
	(71, 25, 26, 0, '2020-02-18 06:23:30', '2020-02-18 06:23:30'),
	(72, 26, 26, 1, '2020-02-18 06:23:30', '2020-03-09 16:33:18'),
	(73, 27, 26, 0, '2020-02-18 06:23:30', '2020-02-18 06:23:30'),
	(74, 28, 26, 0, '2020-02-18 06:23:30', '2020-02-18 06:23:30'),
	(75, 29, 26, 0, '2020-02-18 06:23:30', '2020-02-18 06:23:30'),
	(76, 30, 26, 0, '2020-02-18 06:23:30', '2020-02-18 06:23:30'),
	(77, 25, 27, 0, '2020-02-18 06:37:34', '2020-02-18 06:37:34'),
	(78, 26, 27, 1, '2020-02-18 06:37:34', '2020-03-09 16:33:18'),
	(79, 27, 27, 0, '2020-02-18 06:37:34', '2020-02-18 06:37:34'),
	(80, 28, 27, 0, '2020-02-18 06:37:34', '2020-02-18 06:37:34'),
	(81, 29, 27, 0, '2020-02-18 06:37:34', '2020-02-18 06:37:34'),
	(82, 30, 27, 0, '2020-02-18 06:37:34', '2020-02-18 06:37:34'),
	(83, 25, 28, 0, '2020-02-18 06:44:36', '2020-02-18 06:44:36'),
	(84, 26, 28, 1, '2020-02-18 06:44:36', '2020-03-09 16:33:18'),
	(85, 27, 28, 0, '2020-02-18 06:44:36', '2020-02-18 06:44:36'),
	(86, 28, 28, 0, '2020-02-18 06:44:36', '2020-02-18 06:44:36'),
	(87, 29, 28, 0, '2020-02-18 06:44:36', '2020-02-18 06:44:36'),
	(88, 30, 28, 0, '2020-02-18 06:44:36', '2020-02-18 06:44:36'),
	(89, 25, 29, 0, '2020-02-18 06:47:38', '2020-02-18 06:47:38'),
	(90, 26, 29, 1, '2020-02-18 06:47:38', '2020-03-09 16:33:18'),
	(91, 27, 29, 0, '2020-02-18 06:47:38', '2020-02-18 06:47:38'),
	(92, 28, 29, 0, '2020-02-18 06:47:38', '2020-02-18 06:47:38'),
	(93, 29, 29, 0, '2020-02-18 06:47:38', '2020-02-18 06:47:38'),
	(94, 30, 29, 0, '2020-02-18 06:47:38', '2020-02-18 06:47:38'),
	(95, 25, 30, 0, '2020-02-18 06:48:40', '2020-02-18 06:48:40'),
	(96, 26, 30, 1, '2020-02-18 06:48:40', '2020-03-09 16:33:18'),
	(97, 27, 30, 0, '2020-02-18 06:48:40', '2020-02-18 06:48:40'),
	(98, 28, 30, 0, '2020-02-18 06:48:40', '2020-02-18 06:48:40'),
	(99, 29, 30, 0, '2020-02-18 06:48:40', '2020-02-18 06:48:40'),
	(100, 30, 30, 0, '2020-02-18 06:48:40', '2020-02-18 06:48:40'),
	(101, 25, 31, 0, '2020-02-18 06:48:55', '2020-02-18 06:48:55'),
	(102, 26, 31, 1, '2020-02-18 06:48:55', '2020-03-09 16:33:18'),
	(103, 27, 31, 0, '2020-02-18 06:48:55', '2020-02-18 06:48:55'),
	(104, 28, 31, 0, '2020-02-18 06:48:55', '2020-02-18 06:48:55'),
	(105, 29, 31, 0, '2020-02-18 06:48:55', '2020-02-18 06:48:55'),
	(106, 30, 31, 0, '2020-02-18 06:48:55', '2020-02-18 06:48:55'),
	(107, 25, 32, 0, '2020-02-18 06:51:12', '2020-02-18 06:51:12'),
	(108, 26, 32, 1, '2020-02-18 06:51:12', '2020-03-09 16:33:18'),
	(109, 27, 32, 0, '2020-02-18 06:51:12', '2020-02-18 06:51:12'),
	(110, 28, 32, 0, '2020-02-18 06:51:12', '2020-02-18 06:51:12'),
	(111, 29, 32, 0, '2020-02-18 06:51:12', '2020-02-18 06:51:12'),
	(112, 30, 32, 0, '2020-02-18 06:51:12', '2020-02-18 06:51:12'),
	(113, 25, 33, 0, '2020-02-18 07:12:07', '2020-02-18 07:12:07'),
	(114, 26, 33, 1, '2020-02-18 07:12:07', '2020-03-09 16:33:18'),
	(115, 27, 33, 0, '2020-02-18 07:12:07', '2020-02-18 07:12:07'),
	(116, 28, 33, 0, '2020-02-18 07:12:07', '2020-02-18 07:12:07'),
	(117, 29, 33, 0, '2020-02-18 07:12:07', '2020-02-18 07:12:07'),
	(118, 30, 33, 0, '2020-02-18 07:12:07', '2020-02-18 07:12:07'),
	(119, 25, 34, 0, '2020-02-18 07:14:20', '2020-02-18 07:14:20'),
	(120, 26, 34, 1, '2020-02-18 07:14:20', '2020-03-09 16:33:18'),
	(121, 27, 34, 0, '2020-02-18 07:14:20', '2020-02-18 07:14:20'),
	(122, 28, 34, 0, '2020-02-18 07:14:20', '2020-02-18 07:14:20'),
	(123, 29, 34, 0, '2020-02-18 07:14:20', '2020-02-18 07:14:20'),
	(124, 30, 34, 0, '2020-02-18 07:14:20', '2020-02-18 07:14:20'),
	(125, 25, 35, 0, '2020-02-18 07:34:40', '2020-02-18 07:34:40'),
	(126, 26, 35, 1, '2020-02-18 07:34:40', '2020-03-09 16:33:18'),
	(127, 27, 35, 0, '2020-02-18 07:34:40', '2020-02-18 07:34:40'),
	(128, 28, 35, 0, '2020-02-18 07:34:40', '2020-02-18 07:34:40'),
	(129, 29, 35, 0, '2020-02-18 07:34:40', '2020-02-18 07:34:40'),
	(130, 30, 35, 0, '2020-02-18 07:34:40', '2020-02-18 07:34:40'),
	(131, 25, 36, 0, '2020-02-18 07:36:01', '2020-02-18 07:36:01'),
	(132, 26, 36, 1, '2020-02-18 07:36:01', '2020-03-09 16:33:18'),
	(133, 27, 36, 0, '2020-02-18 07:36:01', '2020-02-18 07:36:01'),
	(134, 28, 36, 0, '2020-02-18 07:36:01', '2020-02-18 07:36:01'),
	(135, 29, 36, 0, '2020-02-18 07:36:01', '2020-02-18 07:36:01'),
	(136, 30, 36, 0, '2020-02-18 07:36:01', '2020-02-18 07:36:01'),
	(137, 25, 37, 0, '2020-02-18 07:46:54', '2020-02-18 07:46:54'),
	(138, 26, 37, 1, '2020-02-18 07:46:54', '2020-03-09 16:33:18'),
	(139, 27, 37, 0, '2020-02-18 07:46:54', '2020-02-18 07:46:54'),
	(140, 28, 37, 0, '2020-02-18 07:46:54', '2020-02-18 07:46:54'),
	(141, 29, 37, 0, '2020-02-18 07:46:54', '2020-02-18 07:46:54'),
	(142, 30, 37, 0, '2020-02-18 07:46:54', '2020-02-18 07:46:54'),
	(143, 25, 38, 0, '2020-02-18 07:47:10', '2020-02-18 07:47:10'),
	(144, 26, 38, 1, '2020-02-18 07:47:10', '2020-03-09 16:33:18'),
	(145, 27, 38, 0, '2020-02-18 07:47:10', '2020-02-18 07:47:10'),
	(146, 28, 38, 0, '2020-02-18 07:47:10', '2020-02-18 07:47:10'),
	(147, 29, 38, 0, '2020-02-18 07:47:10', '2020-02-18 07:47:10'),
	(148, 30, 38, 0, '2020-02-18 07:47:10', '2020-02-18 07:47:10'),
	(149, 25, 39, 0, '2020-02-18 08:21:39', '2020-02-18 08:21:39'),
	(150, 26, 39, 1, '2020-02-18 08:21:39', '2020-03-09 16:33:18'),
	(151, 27, 39, 0, '2020-02-18 08:21:39', '2020-02-18 08:21:39'),
	(152, 28, 39, 0, '2020-02-18 08:21:39', '2020-02-18 08:21:39'),
	(153, 29, 39, 0, '2020-02-18 08:21:39', '2020-02-18 08:21:39'),
	(154, 30, 39, 0, '2020-02-18 08:21:39', '2020-02-18 08:21:39'),
	(155, 25, 40, 0, '2020-02-18 08:26:01', '2020-02-18 08:26:01'),
	(156, 26, 40, 1, '2020-02-18 08:26:01', '2020-03-09 16:33:18'),
	(157, 27, 40, 0, '2020-02-18 08:26:01', '2020-02-18 08:26:01'),
	(158, 28, 40, 0, '2020-02-18 08:26:01', '2020-02-18 08:26:01'),
	(159, 29, 40, 0, '2020-02-18 08:26:01', '2020-02-18 08:26:01'),
	(160, 30, 40, 0, '2020-02-18 08:26:01', '2020-02-18 08:26:01'),
	(161, 25, 41, 0, '2020-02-18 08:37:37', '2020-02-18 08:37:37'),
	(162, 26, 41, 1, '2020-02-18 08:37:37', '2020-03-09 16:33:18'),
	(163, 27, 41, 0, '2020-02-18 08:37:37', '2020-02-18 08:37:37'),
	(164, 28, 41, 0, '2020-02-18 08:37:37', '2020-02-18 08:37:37'),
	(165, 29, 41, 0, '2020-02-18 08:37:37', '2020-02-18 08:37:37'),
	(166, 30, 41, 0, '2020-02-18 08:37:37', '2020-02-18 08:37:37'),
	(167, 25, 42, 0, '2020-02-18 08:49:36', '2020-02-18 08:49:36'),
	(168, 26, 42, 1, '2020-02-18 08:49:36', '2020-03-09 16:33:18'),
	(169, 27, 42, 0, '2020-02-18 08:49:36', '2020-02-18 08:49:36'),
	(170, 28, 42, 0, '2020-02-18 08:49:36', '2020-02-18 08:49:36'),
	(171, 29, 42, 0, '2020-02-18 08:49:36', '2020-02-18 08:49:36'),
	(172, 30, 42, 0, '2020-02-18 08:49:36', '2020-02-18 08:49:36'),
	(173, 25, 43, 0, '2020-02-18 08:49:48', '2020-02-18 08:49:48'),
	(174, 26, 43, 1, '2020-02-18 08:49:48', '2020-03-09 16:33:18'),
	(175, 27, 43, 0, '2020-02-18 08:49:48', '2020-02-18 08:49:48'),
	(176, 28, 43, 0, '2020-02-18 08:49:48', '2020-02-18 08:49:48'),
	(177, 29, 43, 0, '2020-02-18 08:49:48', '2020-02-18 08:49:48'),
	(178, 30, 43, 0, '2020-02-18 08:49:48', '2020-02-18 08:49:48'),
	(179, 25, 44, 0, '2020-02-18 09:02:37', '2020-02-18 09:02:37'),
	(180, 26, 44, 1, '2020-02-18 09:02:37', '2020-03-09 16:33:18'),
	(181, 27, 44, 0, '2020-02-18 09:02:38', '2020-02-18 09:02:38'),
	(182, 28, 44, 0, '2020-02-18 09:02:38', '2020-02-18 09:02:38'),
	(183, 29, 44, 0, '2020-02-18 09:02:38', '2020-02-18 09:02:38'),
	(184, 30, 44, 0, '2020-02-18 09:02:38', '2020-02-18 09:02:38'),
	(185, 25, 45, 0, '2020-02-18 09:02:55', '2020-02-18 09:02:55'),
	(186, 26, 45, 1, '2020-02-18 09:02:55', '2020-03-09 16:33:18'),
	(187, 27, 45, 0, '2020-02-18 09:02:55', '2020-02-18 09:02:55'),
	(188, 28, 45, 0, '2020-02-18 09:02:55', '2020-02-18 09:02:55'),
	(189, 29, 45, 0, '2020-02-18 09:02:55', '2020-02-18 09:02:55'),
	(190, 30, 45, 0, '2020-02-18 09:02:55', '2020-02-18 09:02:55'),
	(191, 25, 46, 0, '2020-02-18 09:03:06', '2020-02-18 09:03:06'),
	(192, 26, 46, 1, '2020-02-18 09:03:06', '2020-03-09 16:33:18'),
	(193, 27, 46, 0, '2020-02-18 09:03:06', '2020-02-18 09:03:06'),
	(194, 28, 46, 0, '2020-02-18 09:03:06', '2020-02-18 09:03:06'),
	(195, 29, 46, 0, '2020-02-18 09:03:06', '2020-02-18 09:03:06'),
	(196, 30, 46, 0, '2020-02-18 09:03:06', '2020-02-18 09:03:06'),
	(197, 25, 47, 0, '2020-02-18 09:03:18', '2020-02-18 09:03:18'),
	(198, 26, 47, 1, '2020-02-18 09:03:18', '2020-03-09 16:33:18'),
	(199, 27, 47, 0, '2020-02-18 09:03:18', '2020-02-18 09:03:18'),
	(200, 28, 47, 0, '2020-02-18 09:03:18', '2020-02-18 09:03:18'),
	(201, 29, 47, 0, '2020-02-18 09:03:18', '2020-02-18 09:03:18'),
	(202, 30, 47, 0, '2020-02-18 09:03:18', '2020-02-18 09:03:18'),
	(203, 25, 48, 0, '2020-02-18 09:13:35', '2020-02-18 09:13:35'),
	(204, 26, 48, 1, '2020-02-18 09:13:35', '2020-03-09 16:33:18'),
	(205, 27, 48, 0, '2020-02-18 09:13:36', '2020-02-18 09:13:36'),
	(206, 28, 48, 0, '2020-02-18 09:13:36', '2020-02-18 09:13:36'),
	(207, 29, 48, 0, '2020-02-18 09:13:36', '2020-02-18 09:13:36'),
	(208, 30, 48, 0, '2020-02-18 09:13:36', '2020-02-18 09:13:36'),
	(209, 25, 49, 0, '2020-02-18 09:14:00', '2020-02-18 09:14:00'),
	(210, 26, 49, 1, '2020-02-18 09:14:00', '2020-03-09 16:33:18'),
	(211, 27, 49, 0, '2020-02-18 09:14:00', '2020-02-18 09:14:00'),
	(212, 28, 49, 0, '2020-02-18 09:14:00', '2020-02-18 09:14:00'),
	(213, 29, 49, 0, '2020-02-18 09:14:00', '2020-02-18 09:14:00'),
	(214, 30, 49, 0, '2020-02-18 09:14:00', '2020-02-18 09:14:00'),
	(215, 25, 50, 0, '2020-02-18 09:14:15', '2020-02-18 09:14:15'),
	(216, 26, 50, 1, '2020-02-18 09:14:15', '2020-03-09 16:33:18'),
	(217, 27, 50, 0, '2020-02-18 09:14:15', '2020-02-18 09:14:15'),
	(218, 28, 50, 0, '2020-02-18 09:14:15', '2020-02-18 09:14:15'),
	(219, 29, 50, 0, '2020-02-18 09:14:15', '2020-02-18 09:14:15'),
	(220, 30, 50, 0, '2020-02-18 09:14:15', '2020-02-18 09:14:15'),
	(221, 25, 51, 0, '2020-02-18 09:14:26', '2020-02-18 09:14:26'),
	(222, 26, 51, 1, '2020-02-18 09:14:26', '2020-03-09 16:33:18'),
	(223, 27, 51, 0, '2020-02-18 09:14:26', '2020-02-18 09:14:26'),
	(224, 28, 51, 0, '2020-02-18 09:14:26', '2020-02-18 09:14:26'),
	(225, 29, 51, 0, '2020-02-18 09:14:26', '2020-02-18 09:14:26'),
	(226, 30, 51, 0, '2020-02-18 09:14:26', '2020-02-18 09:14:26'),
	(227, 25, 52, 0, '2020-02-18 09:25:01', '2020-02-18 09:25:01'),
	(228, 26, 52, 1, '2020-02-18 09:25:01', '2020-03-09 16:33:18'),
	(229, 27, 52, 0, '2020-02-18 09:25:01', '2020-02-18 09:25:01'),
	(230, 28, 52, 0, '2020-02-18 09:25:01', '2020-02-18 09:25:01'),
	(231, 29, 52, 0, '2020-02-18 09:25:01', '2020-02-18 09:25:01'),
	(232, 30, 52, 0, '2020-02-18 09:25:01', '2020-02-18 09:25:01'),
	(233, 25, 53, 0, '2020-02-18 09:25:15', '2020-02-18 09:25:15'),
	(234, 26, 53, 1, '2020-02-18 09:25:15', '2020-03-09 16:33:18'),
	(235, 27, 53, 0, '2020-02-18 09:25:15', '2020-02-18 09:25:15'),
	(236, 28, 53, 0, '2020-02-18 09:25:15', '2020-02-18 09:25:15'),
	(237, 29, 53, 0, '2020-02-18 09:25:15', '2020-02-18 09:25:15'),
	(238, 30, 53, 0, '2020-02-18 09:25:15', '2020-02-18 09:25:15'),
	(239, 25, 54, 0, '2020-02-18 09:25:30', '2020-02-18 09:25:30'),
	(240, 26, 54, 1, '2020-02-18 09:25:30', '2020-03-09 16:33:18'),
	(241, 27, 54, 0, '2020-02-18 09:25:30', '2020-02-18 09:25:30'),
	(242, 28, 54, 0, '2020-02-18 09:25:30', '2020-02-18 09:25:30'),
	(243, 29, 54, 0, '2020-02-18 09:25:30', '2020-02-18 09:25:30'),
	(244, 30, 54, 0, '2020-02-18 09:25:30', '2020-02-18 09:25:30'),
	(245, 25, 55, 0, '2020-02-18 09:25:43', '2020-02-18 09:25:43'),
	(246, 26, 55, 1, '2020-02-18 09:25:43', '2020-03-09 16:33:18'),
	(247, 27, 55, 0, '2020-02-18 09:25:43', '2020-02-18 09:25:43'),
	(248, 28, 55, 0, '2020-02-18 09:25:43', '2020-02-18 09:25:43'),
	(249, 29, 55, 0, '2020-02-18 09:25:43', '2020-02-18 09:25:43'),
	(250, 30, 55, 0, '2020-02-18 09:25:43', '2020-02-18 09:25:43'),
	(251, 25, 56, 0, '2020-02-18 09:32:33', '2020-02-18 09:32:33'),
	(252, 26, 56, 1, '2020-02-18 09:32:33', '2020-03-09 16:33:18'),
	(253, 27, 56, 0, '2020-02-18 09:32:34', '2020-02-18 09:32:34'),
	(254, 28, 56, 0, '2020-02-18 09:32:34', '2020-02-18 09:32:34'),
	(255, 29, 56, 0, '2020-02-18 09:32:34', '2020-02-18 09:32:34'),
	(256, 30, 56, 0, '2020-02-18 09:32:34', '2020-02-18 09:32:34'),
	(257, 25, 57, 0, '2020-02-18 09:32:46', '2020-02-18 09:32:46'),
	(258, 26, 57, 1, '2020-02-18 09:32:46', '2020-03-09 16:33:18'),
	(259, 27, 57, 0, '2020-02-18 09:32:46', '2020-02-18 09:32:46'),
	(260, 28, 57, 0, '2020-02-18 09:32:46', '2020-02-18 09:32:46'),
	(261, 29, 57, 0, '2020-02-18 09:32:46', '2020-02-18 09:32:46'),
	(262, 30, 57, 0, '2020-02-18 09:32:46', '2020-02-18 09:32:46'),
	(263, 25, 58, 0, '2020-02-18 09:32:55', '2020-02-18 09:32:55'),
	(264, 26, 58, 1, '2020-02-18 09:32:55', '2020-03-09 16:33:18'),
	(265, 27, 58, 0, '2020-02-18 09:32:56', '2020-02-18 09:32:56'),
	(266, 28, 58, 0, '2020-02-18 09:32:56', '2020-02-18 09:32:56'),
	(267, 29, 58, 0, '2020-02-18 09:32:56', '2020-02-18 09:32:56'),
	(268, 30, 58, 0, '2020-02-18 09:32:56', '2020-02-18 09:32:56'),
	(269, 25, 59, 0, '2020-02-18 09:33:07', '2020-02-18 09:33:07'),
	(270, 26, 59, 1, '2020-02-18 09:33:07', '2020-03-09 16:33:18'),
	(271, 27, 59, 0, '2020-02-18 09:33:07', '2020-02-18 09:33:07'),
	(272, 28, 59, 0, '2020-02-18 09:33:07', '2020-02-18 09:33:07'),
	(273, 29, 59, 0, '2020-02-18 09:33:07', '2020-02-18 09:33:07'),
	(274, 30, 59, 0, '2020-02-18 09:33:07', '2020-02-18 09:33:07'),
	(275, 25, 60, 0, '2020-02-18 09:39:22', '2020-02-18 09:39:22'),
	(276, 26, 60, 1, '2020-02-18 09:39:22', '2020-03-09 16:33:18'),
	(277, 27, 60, 0, '2020-02-18 09:39:23', '2020-02-18 09:39:23'),
	(278, 28, 60, 0, '2020-02-18 09:39:23', '2020-02-18 09:39:23'),
	(279, 29, 60, 0, '2020-02-18 09:39:23', '2020-02-18 09:39:23'),
	(280, 30, 60, 0, '2020-02-18 09:39:23', '2020-02-18 09:39:23'),
	(281, 25, 61, 0, '2020-02-18 09:39:33', '2020-02-18 09:39:33'),
	(282, 26, 61, 1, '2020-02-18 09:39:33', '2020-03-09 16:33:18'),
	(283, 27, 61, 0, '2020-02-18 09:39:33', '2020-02-18 09:39:33'),
	(284, 28, 61, 0, '2020-02-18 09:39:33', '2020-02-18 09:39:33'),
	(285, 29, 61, 0, '2020-02-18 09:39:33', '2020-02-18 09:39:33'),
	(286, 30, 61, 0, '2020-02-18 09:39:33', '2020-02-18 09:39:33'),
	(287, 25, 62, 0, '2020-02-18 09:39:44', '2020-02-18 09:39:44'),
	(288, 26, 62, 1, '2020-02-18 09:39:44', '2020-03-09 16:33:18'),
	(289, 27, 62, 0, '2020-02-18 09:39:44', '2020-02-18 09:39:44'),
	(290, 28, 62, 0, '2020-02-18 09:39:44', '2020-02-18 09:39:44'),
	(291, 29, 62, 0, '2020-02-18 09:39:44', '2020-02-18 09:39:44'),
	(292, 30, 62, 0, '2020-02-18 09:39:44', '2020-02-18 09:39:44'),
	(293, 25, 63, 0, '2020-02-18 09:40:00', '2020-02-18 09:40:00'),
	(294, 26, 63, 1, '2020-02-18 09:40:00', '2020-03-09 16:33:18'),
	(295, 27, 63, 0, '2020-02-18 09:40:00', '2020-02-18 09:40:00'),
	(296, 28, 63, 0, '2020-02-18 09:40:00', '2020-02-18 09:40:00'),
	(297, 29, 63, 0, '2020-02-18 09:40:00', '2020-02-18 09:40:00'),
	(298, 30, 63, 0, '2020-02-18 09:40:00', '2020-02-18 09:40:00'),
	(299, 25, 64, 0, '2020-02-18 11:23:13', '2020-02-18 11:23:13'),
	(300, 26, 64, 1, '2020-02-18 11:23:13', '2020-03-09 16:33:18'),
	(301, 27, 64, 0, '2020-02-18 11:23:13', '2020-02-18 11:23:13'),
	(302, 28, 64, 0, '2020-02-18 11:23:13', '2020-02-18 11:23:13'),
	(303, 29, 64, 0, '2020-02-18 11:23:13', '2020-02-18 11:23:13'),
	(304, 30, 64, 0, '2020-02-18 11:23:13', '2020-02-18 11:23:13'),
	(305, 25, 65, 0, '2020-02-18 11:38:26', '2020-02-18 11:38:26'),
	(306, 26, 65, 1, '2020-02-18 11:38:26', '2020-03-09 16:33:18'),
	(307, 27, 65, 0, '2020-02-18 11:38:26', '2020-02-18 11:38:26'),
	(308, 28, 65, 0, '2020-02-18 11:38:26', '2020-02-18 11:38:26'),
	(309, 29, 65, 0, '2020-02-18 11:38:26', '2020-02-18 11:38:26'),
	(310, 30, 65, 0, '2020-02-18 11:38:26', '2020-02-18 11:38:26'),
	(311, 25, 66, 0, '2020-02-18 11:38:38', '2020-02-18 11:38:38'),
	(312, 26, 66, 1, '2020-02-18 11:38:38', '2020-03-09 16:33:18'),
	(313, 27, 66, 0, '2020-02-18 11:38:38', '2020-02-18 11:38:38'),
	(314, 28, 66, 0, '2020-02-18 11:38:38', '2020-02-18 11:38:38'),
	(315, 29, 66, 0, '2020-02-18 11:38:38', '2020-02-18 11:38:38'),
	(316, 30, 66, 0, '2020-02-18 11:38:38', '2020-02-18 11:38:38'),
	(317, 25, 67, 0, '2020-02-18 11:38:50', '2020-02-18 11:38:50'),
	(318, 26, 67, 1, '2020-02-18 11:38:50', '2020-03-09 16:33:18'),
	(319, 27, 67, 0, '2020-02-18 11:38:50', '2020-02-18 11:38:50'),
	(320, 28, 67, 0, '2020-02-18 11:38:50', '2020-02-18 11:38:50'),
	(321, 29, 67, 0, '2020-02-18 11:38:50', '2020-02-18 11:38:50'),
	(322, 30, 67, 0, '2020-02-18 11:38:50', '2020-02-18 11:38:50'),
	(323, 31, 1, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(324, 31, 2, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(325, 31, 4, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(326, 31, 6, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(327, 31, 7, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(328, 31, 8, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(329, 31, 9, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(330, 31, 10, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(331, 31, 27, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(332, 31, 28, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(333, 31, 24, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(334, 31, 25, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(335, 31, 26, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(336, 31, 29, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(337, 31, 30, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(338, 31, 31, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(339, 31, 32, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(340, 31, 33, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(341, 31, 34, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(342, 31, 35, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(343, 31, 36, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(344, 31, 37, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(345, 31, 38, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(346, 31, 39, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(347, 31, 40, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(348, 31, 41, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(349, 31, 42, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(350, 31, 43, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(351, 31, 44, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(352, 31, 45, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(353, 31, 46, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(354, 31, 47, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(355, 31, 48, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(356, 31, 49, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(357, 31, 50, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(358, 31, 51, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(359, 31, 52, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(360, 31, 53, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(361, 31, 54, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(362, 31, 55, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(363, 31, 56, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(364, 31, 57, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(365, 31, 58, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(366, 31, 59, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(367, 31, 60, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(368, 31, 61, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(369, 31, 62, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(370, 31, 63, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(371, 31, 64, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(372, 31, 65, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(373, 31, 66, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(374, 31, 67, 0, '2020-02-18 14:01:17', '2020-02-18 14:01:17'),
	(375, 25, 68, 0, '2020-02-22 10:02:39', '2020-02-22 10:02:39'),
	(376, 26, 68, 1, '2020-02-22 10:02:39', '2020-03-09 16:33:18'),
	(377, 27, 68, 0, '2020-02-22 10:02:39', '2020-02-22 10:02:39'),
	(378, 28, 68, 0, '2020-02-22 10:02:39', '2020-02-22 10:02:39'),
	(379, 29, 68, 0, '2020-02-22 10:02:39', '2020-02-22 10:02:39'),
	(380, 30, 68, 0, '2020-02-22 10:02:39', '2020-02-22 10:02:39'),
	(381, 31, 68, 0, '2020-02-22 10:02:39', '2020-02-22 10:02:39'),
	(382, 25, 69, 0, '2020-02-22 10:06:07', '2020-02-22 10:06:07'),
	(383, 26, 69, 1, '2020-02-22 10:06:07', '2020-03-09 16:33:18'),
	(384, 27, 69, 0, '2020-02-22 10:06:07', '2020-02-22 10:06:07'),
	(385, 28, 69, 0, '2020-02-22 10:06:07', '2020-02-22 10:06:07'),
	(386, 29, 69, 0, '2020-02-22 10:06:07', '2020-02-22 10:06:07'),
	(387, 30, 69, 0, '2020-02-22 10:06:07', '2020-02-22 10:06:07'),
	(388, 31, 69, 0, '2020-02-22 10:06:07', '2020-02-22 10:06:07'),
	(389, 25, 70, 0, '2020-02-22 10:06:25', '2020-02-22 10:06:25'),
	(390, 26, 70, 1, '2020-02-22 10:06:25', '2020-03-09 16:33:18'),
	(391, 27, 70, 0, '2020-02-22 10:06:25', '2020-02-22 10:06:25'),
	(392, 28, 70, 0, '2020-02-22 10:06:25', '2020-02-22 10:06:25'),
	(393, 29, 70, 0, '2020-02-22 10:06:25', '2020-02-22 10:06:25'),
	(394, 30, 70, 0, '2020-02-22 10:06:25', '2020-02-22 10:06:25'),
	(395, 31, 70, 0, '2020-02-22 10:06:25', '2020-02-22 10:06:25'),
	(396, 25, 71, 0, '2020-02-22 10:06:50', '2020-02-22 10:06:50'),
	(397, 26, 71, 1, '2020-02-22 10:06:50', '2020-03-09 16:33:18'),
	(398, 27, 71, 0, '2020-02-22 10:06:50', '2020-02-22 10:06:50'),
	(399, 28, 71, 0, '2020-02-22 10:06:50', '2020-02-22 10:06:50'),
	(400, 29, 71, 0, '2020-02-22 10:06:50', '2020-02-22 10:06:50'),
	(401, 30, 71, 0, '2020-02-22 10:06:50', '2020-02-22 10:06:50'),
	(402, 31, 71, 0, '2020-02-22 10:06:50', '2020-02-22 10:06:50'),
	(403, 25, 72, 0, '2020-02-29 06:45:50', '2020-02-29 06:45:50'),
	(404, 26, 72, 1, '2020-02-29 06:45:50', '2020-03-09 16:33:18'),
	(405, 27, 72, 0, '2020-02-29 06:45:50', '2020-02-29 06:45:50'),
	(406, 28, 72, 0, '2020-02-29 06:45:50', '2020-02-29 06:45:50'),
	(407, 29, 72, 0, '2020-02-29 06:45:50', '2020-02-29 06:45:50'),
	(408, 30, 72, 0, '2020-02-29 06:45:50', '2020-02-29 06:45:50'),
	(409, 31, 72, 0, '2020-02-29 06:45:50', '2020-02-29 06:45:50'),
	(410, 25, 73, 0, '2020-02-29 06:46:46', '2020-02-29 06:46:46'),
	(411, 26, 73, 1, '2020-02-29 06:46:46', '2020-03-09 16:33:18'),
	(412, 27, 73, 0, '2020-02-29 06:46:46', '2020-02-29 06:46:46'),
	(413, 28, 73, 0, '2020-02-29 06:46:46', '2020-02-29 06:46:46'),
	(414, 29, 73, 0, '2020-02-29 06:46:46', '2020-02-29 06:46:46'),
	(415, 30, 73, 0, '2020-02-29 06:46:46', '2020-02-29 06:46:46'),
	(416, 31, 73, 0, '2020-02-29 06:46:46', '2020-02-29 06:46:46'),
	(417, 25, 74, 0, '2020-02-29 06:46:56', '2020-02-29 06:46:56'),
	(418, 26, 74, 1, '2020-02-29 06:46:56', '2020-03-09 16:33:18'),
	(419, 27, 74, 0, '2020-02-29 06:46:56', '2020-02-29 06:46:56'),
	(420, 28, 74, 0, '2020-02-29 06:46:56', '2020-02-29 06:46:56'),
	(421, 29, 74, 0, '2020-02-29 06:46:56', '2020-02-29 06:46:56'),
	(422, 30, 74, 0, '2020-02-29 06:46:56', '2020-02-29 06:46:56'),
	(423, 31, 74, 0, '2020-02-29 06:46:56', '2020-02-29 06:46:56'),
	(424, 25, 75, 0, '2020-02-29 06:47:04', '2020-02-29 06:47:04'),
	(425, 26, 75, 1, '2020-02-29 06:47:04', '2020-03-09 16:33:18'),
	(426, 27, 75, 0, '2020-02-29 06:47:04', '2020-02-29 06:47:04'),
	(427, 28, 75, 0, '2020-02-29 06:47:04', '2020-02-29 06:47:04'),
	(428, 29, 75, 0, '2020-02-29 06:47:04', '2020-02-29 06:47:04'),
	(429, 30, 75, 0, '2020-02-29 06:47:04', '2020-02-29 06:47:04'),
	(430, 31, 75, 0, '2020-02-29 06:47:04', '2020-02-29 06:47:04'),
	(431, 25, 76, 0, '2020-03-02 09:25:05', '2020-03-02 09:25:05'),
	(432, 26, 76, 1, '2020-03-02 09:25:05', '2020-03-09 16:33:18'),
	(433, 27, 76, 0, '2020-03-02 09:25:05', '2020-03-02 09:25:05'),
	(434, 28, 76, 0, '2020-03-02 09:25:05', '2020-03-02 09:25:05'),
	(435, 29, 76, 0, '2020-03-02 09:25:05', '2020-03-02 09:25:05'),
	(436, 30, 76, 0, '2020-03-02 09:25:05', '2020-03-02 09:25:05'),
	(437, 31, 76, 0, '2020-03-02 09:25:05', '2020-03-02 09:25:05'),
	(438, 25, 77, 0, '2020-03-02 09:25:28', '2020-03-02 09:25:28'),
	(439, 26, 77, 1, '2020-03-02 09:25:28', '2020-03-09 16:33:18'),
	(440, 27, 77, 0, '2020-03-02 09:25:28', '2020-03-02 09:25:28'),
	(441, 28, 77, 0, '2020-03-02 09:25:28', '2020-03-02 09:25:28'),
	(442, 29, 77, 0, '2020-03-02 09:25:28', '2020-03-02 09:25:28'),
	(443, 30, 77, 0, '2020-03-02 09:25:28', '2020-03-02 09:25:28'),
	(444, 31, 77, 0, '2020-03-02 09:25:28', '2020-03-02 09:25:28'),
	(473, 25, 82, 0, '2020-03-03 11:25:01', '2020-03-03 11:25:01'),
	(474, 26, 82, 1, '2020-03-03 11:25:01', '2020-03-09 16:33:18'),
	(475, 27, 82, 0, '2020-03-03 11:25:01', '2020-03-03 11:25:01'),
	(476, 28, 82, 0, '2020-03-03 11:25:01', '2020-03-03 11:25:01'),
	(477, 29, 82, 0, '2020-03-03 11:25:01', '2020-03-03 11:25:01'),
	(478, 30, 82, 0, '2020-03-03 11:25:01', '2020-03-03 11:25:01'),
	(479, 31, 82, 0, '2020-03-03 11:25:01', '2020-03-03 11:25:01'),
	(480, 25, 83, 0, '2020-03-03 11:25:10', '2020-03-03 11:25:10'),
	(481, 26, 83, 1, '2020-03-03 11:25:10', '2020-03-09 16:33:18'),
	(482, 27, 83, 0, '2020-03-03 11:25:10', '2020-03-03 11:25:10'),
	(483, 28, 83, 0, '2020-03-03 11:25:10', '2020-03-03 11:25:10'),
	(484, 29, 83, 0, '2020-03-03 11:25:10', '2020-03-03 11:25:10'),
	(485, 30, 83, 0, '2020-03-03 11:25:10', '2020-03-03 11:25:10'),
	(486, 31, 83, 0, '2020-03-03 11:25:10', '2020-03-03 11:25:10'),
	(487, 25, 84, 0, '2020-03-03 11:25:19', '2020-03-03 11:25:19'),
	(488, 26, 84, 1, '2020-03-03 11:25:19', '2020-03-09 16:33:18'),
	(489, 27, 84, 0, '2020-03-03 11:25:19', '2020-03-03 11:25:19'),
	(490, 28, 84, 0, '2020-03-03 11:25:19', '2020-03-03 11:25:19'),
	(491, 29, 84, 0, '2020-03-03 11:25:19', '2020-03-03 11:25:19'),
	(492, 30, 84, 0, '2020-03-03 11:25:19', '2020-03-03 11:25:19'),
	(493, 31, 84, 0, '2020-03-03 11:25:19', '2020-03-03 11:25:19'),
	(494, 25, 85, 0, '2020-03-03 11:25:29', '2020-03-03 11:25:29'),
	(495, 26, 85, 1, '2020-03-03 11:25:29', '2020-03-09 16:33:18'),
	(496, 27, 85, 0, '2020-03-03 11:25:29', '2020-03-03 11:25:29'),
	(497, 28, 85, 0, '2020-03-03 11:25:29', '2020-03-03 11:25:29'),
	(498, 29, 85, 0, '2020-03-03 11:25:29', '2020-03-03 11:25:29'),
	(499, 30, 85, 0, '2020-03-03 11:25:29', '2020-03-03 11:25:29'),
	(500, 31, 85, 0, '2020-03-03 11:25:29', '2020-03-03 11:25:29'),
	(501, 32, 1, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(502, 32, 2, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(503, 32, 4, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(504, 32, 6, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(505, 32, 7, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(506, 32, 8, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(507, 32, 9, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(508, 32, 10, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(509, 32, 27, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(510, 32, 28, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(511, 32, 24, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(512, 32, 25, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(513, 32, 26, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(514, 32, 76, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(515, 32, 77, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(516, 32, 29, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(517, 32, 30, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(518, 32, 31, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(519, 32, 32, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(520, 32, 33, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(521, 32, 34, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(522, 32, 35, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(523, 32, 36, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(524, 32, 37, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(525, 32, 38, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(526, 32, 39, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(527, 32, 40, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(528, 32, 41, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(529, 32, 42, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(530, 32, 43, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(531, 32, 44, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(532, 32, 45, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(533, 32, 46, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(534, 32, 47, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(535, 32, 48, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(536, 32, 49, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(537, 32, 50, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(538, 32, 51, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(539, 32, 52, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(540, 32, 53, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(541, 32, 54, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(542, 32, 55, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(543, 32, 56, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(544, 32, 57, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(545, 32, 58, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(546, 32, 59, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(547, 32, 60, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(548, 32, 61, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(549, 32, 62, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(550, 32, 63, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(551, 32, 82, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(552, 32, 83, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(553, 32, 84, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(554, 32, 85, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(555, 32, 72, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(556, 32, 73, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(557, 32, 74, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(558, 32, 75, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(559, 32, 64, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(560, 32, 65, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(561, 32, 66, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(562, 32, 67, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(563, 32, 68, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(564, 32, 69, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(565, 32, 70, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(566, 32, 71, 0, '2020-03-05 06:40:23', '2020-03-05 06:40:23'),
	(567, 33, 1, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(568, 33, 2, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(569, 33, 4, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(570, 33, 6, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(571, 33, 7, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(572, 33, 8, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(573, 33, 9, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(574, 33, 10, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(575, 33, 27, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(576, 33, 28, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(577, 33, 24, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(578, 33, 25, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(579, 33, 26, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(580, 33, 76, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(581, 33, 77, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(582, 33, 29, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(583, 33, 30, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(584, 33, 31, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(585, 33, 32, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(586, 33, 33, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(587, 33, 34, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(588, 33, 35, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(589, 33, 36, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(590, 33, 37, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(591, 33, 38, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(592, 33, 39, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(593, 33, 40, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(594, 33, 41, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(595, 33, 42, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(596, 33, 43, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(597, 33, 44, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(598, 33, 45, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(599, 33, 46, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(600, 33, 47, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(601, 33, 48, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(602, 33, 49, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(603, 33, 50, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(604, 33, 51, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(605, 33, 52, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(606, 33, 53, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(607, 33, 54, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(608, 33, 55, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(609, 33, 56, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(610, 33, 57, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(611, 33, 58, 0, '2020-03-05 06:40:39', '2020-03-05 06:40:39'),
	(612, 33, 59, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(613, 33, 60, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(614, 33, 61, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(615, 33, 62, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(616, 33, 63, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(617, 33, 82, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(618, 33, 83, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(619, 33, 84, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(620, 33, 85, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(621, 33, 72, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(622, 33, 73, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(623, 33, 74, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(624, 33, 75, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(625, 33, 64, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(626, 33, 65, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(627, 33, 66, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(628, 33, 67, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(629, 33, 68, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(630, 33, 69, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(631, 33, 70, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(632, 33, 71, 0, '2020-03-05 06:40:40', '2020-03-05 06:40:40'),
	(633, 25, 86, 0, '2020-03-07 07:22:25', '2020-03-07 07:22:25'),
	(634, 26, 86, 1, '2020-03-07 07:22:25', '2020-03-09 16:33:18'),
	(635, 27, 86, 0, '2020-03-07 07:22:25', '2020-03-07 07:22:25'),
	(636, 28, 86, 0, '2020-03-07 07:22:25', '2020-03-07 07:22:25'),
	(637, 29, 86, 0, '2020-03-07 07:22:25', '2020-03-07 07:22:25'),
	(638, 30, 86, 0, '2020-03-07 07:22:25', '2020-03-07 07:22:25'),
	(639, 31, 86, 0, '2020-03-07 07:22:25', '2020-03-07 07:22:25'),
	(640, 32, 86, 0, '2020-03-07 07:22:25', '2020-03-07 07:22:25'),
	(641, 33, 86, 0, '2020-03-07 07:22:25', '2020-03-07 07:22:25'),
	(642, 25, 87, 0, '2020-03-07 07:22:40', '2020-03-07 07:22:40'),
	(643, 26, 87, 1, '2020-03-07 07:22:40', '2020-03-09 16:33:18'),
	(644, 27, 87, 0, '2020-03-07 07:22:40', '2020-03-07 07:22:40'),
	(645, 28, 87, 0, '2020-03-07 07:22:40', '2020-03-07 07:22:40'),
	(646, 29, 87, 0, '2020-03-07 07:22:40', '2020-03-07 07:22:40'),
	(647, 30, 87, 0, '2020-03-07 07:22:40', '2020-03-07 07:22:40'),
	(648, 31, 87, 0, '2020-03-07 07:22:40', '2020-03-07 07:22:40'),
	(649, 32, 87, 0, '2020-03-07 07:22:40', '2020-03-07 07:22:40'),
	(650, 33, 87, 0, '2020-03-07 07:22:40', '2020-03-07 07:22:40'),
	(651, 25, 88, 0, '2020-03-07 10:14:47', '2020-03-07 10:14:47'),
	(652, 26, 88, 1, '2020-03-07 10:14:47', '2020-03-09 16:33:18'),
	(653, 27, 88, 0, '2020-03-07 10:14:47', '2020-03-07 10:14:47'),
	(654, 28, 88, 0, '2020-03-07 10:14:47', '2020-03-07 10:14:47'),
	(655, 29, 88, 0, '2020-03-07 10:14:47', '2020-03-07 10:14:47'),
	(656, 30, 88, 0, '2020-03-07 10:14:47', '2020-03-07 10:14:47'),
	(657, 31, 88, 0, '2020-03-07 10:14:47', '2020-03-07 10:14:47'),
	(658, 32, 88, 0, '2020-03-07 10:14:47', '2020-03-07 10:14:47'),
	(659, 33, 88, 0, '2020-03-07 10:14:47', '2020-03-07 10:14:47'),
	(660, 25, 89, 0, '2020-03-07 10:15:10', '2020-03-07 10:15:10'),
	(661, 26, 89, 1, '2020-03-07 10:15:10', '2020-03-09 16:33:18'),
	(662, 27, 89, 0, '2020-03-07 10:15:10', '2020-03-07 10:15:10'),
	(663, 28, 89, 0, '2020-03-07 10:15:10', '2020-03-07 10:15:10'),
	(664, 29, 89, 0, '2020-03-07 10:15:10', '2020-03-07 10:15:10'),
	(665, 30, 89, 0, '2020-03-07 10:15:10', '2020-03-07 10:15:10'),
	(666, 31, 89, 0, '2020-03-07 10:15:10', '2020-03-07 10:15:10'),
	(667, 32, 89, 0, '2020-03-07 10:15:10', '2020-03-07 10:15:10'),
	(668, 33, 89, 0, '2020-03-07 10:15:10', '2020-03-07 10:15:10'),
	(669, 25, 90, 0, '2020-03-07 10:15:24', '2020-03-07 10:15:24'),
	(670, 26, 90, 1, '2020-03-07 10:15:24', '2020-03-09 16:33:18'),
	(671, 27, 90, 0, '2020-03-07 10:15:24', '2020-03-07 10:15:24'),
	(672, 28, 90, 0, '2020-03-07 10:15:24', '2020-03-07 10:15:24'),
	(673, 29, 90, 0, '2020-03-07 10:15:24', '2020-03-07 10:15:24'),
	(674, 30, 90, 0, '2020-03-07 10:15:24', '2020-03-07 10:15:24'),
	(675, 31, 90, 0, '2020-03-07 10:15:24', '2020-03-07 10:15:24'),
	(676, 32, 90, 0, '2020-03-07 10:15:24', '2020-03-07 10:15:24'),
	(677, 33, 90, 0, '2020-03-07 10:15:24', '2020-03-07 10:15:24'),
	(678, 25, 91, 0, '2020-03-07 10:15:39', '2020-03-07 10:15:39'),
	(679, 26, 91, 1, '2020-03-07 10:15:39', '2020-03-09 16:33:18'),
	(680, 27, 91, 0, '2020-03-07 10:15:39', '2020-03-07 10:15:39'),
	(681, 28, 91, 0, '2020-03-07 10:15:39', '2020-03-07 10:15:39'),
	(682, 29, 91, 0, '2020-03-07 10:15:39', '2020-03-07 10:15:39'),
	(683, 30, 91, 0, '2020-03-07 10:15:39', '2020-03-07 10:15:39'),
	(684, 31, 91, 0, '2020-03-07 10:15:39', '2020-03-07 10:15:39'),
	(685, 32, 91, 0, '2020-03-07 10:15:39', '2020-03-07 10:15:39'),
	(686, 33, 91, 0, '2020-03-07 10:15:39', '2020-03-07 10:15:39'),
	(687, 25, 92, 0, '2020-03-09 07:54:34', '2020-03-09 07:54:34'),
	(688, 26, 92, 1, '2020-03-09 07:54:34', '2020-03-09 16:33:18'),
	(689, 27, 92, 0, '2020-03-09 07:54:34', '2020-03-09 07:54:34'),
	(690, 28, 92, 0, '2020-03-09 07:54:34', '2020-03-09 07:54:34'),
	(691, 29, 92, 0, '2020-03-09 07:54:34', '2020-03-09 07:54:34'),
	(692, 30, 92, 0, '2020-03-09 07:54:34', '2020-03-09 07:54:34'),
	(693, 31, 92, 0, '2020-03-09 07:54:34', '2020-03-09 07:54:34'),
	(694, 32, 92, 0, '2020-03-09 07:54:34', '2020-03-09 07:54:34'),
	(695, 33, 92, 0, '2020-03-09 07:54:34', '2020-03-09 07:54:34'),
	(696, 25, 93, 0, '2020-03-09 07:54:59', '2020-03-09 07:54:59'),
	(697, 26, 93, 1, '2020-03-09 07:54:59', '2020-03-09 16:33:18'),
	(698, 27, 93, 0, '2020-03-09 07:54:59', '2020-03-09 07:54:59'),
	(699, 28, 93, 0, '2020-03-09 07:54:59', '2020-03-09 07:54:59'),
	(700, 29, 93, 0, '2020-03-09 07:54:59', '2020-03-09 07:54:59'),
	(701, 30, 93, 0, '2020-03-09 07:54:59', '2020-03-09 07:54:59'),
	(702, 31, 93, 0, '2020-03-09 07:54:59', '2020-03-09 07:54:59'),
	(703, 32, 93, 0, '2020-03-09 07:54:59', '2020-03-09 07:54:59'),
	(704, 33, 93, 0, '2020-03-09 07:54:59', '2020-03-09 07:54:59');
/*!40000 ALTER TABLE `user_group_permissions` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.web_actions
CREATE TABLE IF NOT EXISTS `web_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `module_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1:active, 0:inactive',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_name_module_id` (`activity_name`,`module_id`),
  KEY `module_id` (`module_id`),
  CONSTRAINT `FK_web_actions_menus` FOREIGN KEY (`module_id`) REFERENCES `menus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_new_db.web_actions: ~67 rows (approximately)
/*!40000 ALTER TABLE `web_actions` DISABLE KEYS */;
INSERT INTO `web_actions` (`id`, `activity_name`, `module_id`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Admin Users', 1, 1, '0000-00-00 00:00:00', '2020-02-05 14:13:21'),
	(2, 'Admin User Entry', 1, 1, '0000-00-00 00:00:00', '2020-02-05 14:13:21'),
	(4, 'Admin User update', 1, 1, '0000-00-00 00:00:00', '2020-02-05 14:13:21'),
	(6, 'Admin User delete', 1, 1, '0000-00-00 00:00:00', '2020-02-05 14:13:21'),
	(7, 'App Users', 1, 1, '0000-00-00 00:00:00', '2020-02-05 14:13:21'),
	(8, 'App User Entry', 1, 1, '0000-00-00 00:00:00', '2020-02-05 14:13:21'),
	(9, 'App User update', 1, 1, '0000-00-00 00:00:00', '2020-02-05 14:13:21'),
	(10, 'App User delete', 1, 1, '0000-00-00 00:00:00', '2020-02-05 14:13:21'),
	(24, 'Open Course', 7, 1, '2020-02-17 13:46:50', '2020-02-17 13:46:50'),
	(25, 'Course', 7, 1, '2020-02-18 06:17:38', '2020-02-18 06:17:38'),
	(26, 'Course Entry', 7, 1, '2020-02-18 06:23:30', '2020-03-02 09:16:59'),
	(27, 'Survey', 6, 1, '2020-02-18 06:37:34', '2020-02-18 06:37:34'),
	(28, 'Add Survey', 6, 1, '2020-02-18 06:44:35', '2020-02-18 06:44:35'),
	(29, 'Control Panel', 10, 1, '2020-02-18 06:47:38', '2020-02-18 06:47:38'),
	(30, 'Web Actions Entry', 10, 1, '2020-02-18 06:48:40', '2020-02-18 06:48:40'),
	(31, 'Web Actions Update', 10, 1, '2020-02-18 06:48:55', '2020-02-18 06:48:55'),
	(32, 'Web Actions Management', 10, 1, '2020-02-18 06:51:12', '2020-02-18 06:51:12'),
	(33, 'General Setting Management', 10, 1, '2020-02-18 07:12:07', '2020-02-18 07:12:07'),
	(34, 'General Setting Update', 10, 1, '2020-02-18 07:14:20', '2020-02-18 07:14:20'),
	(35, 'Manage Module', 10, 1, '2020-02-18 07:34:40', '2020-02-18 07:34:40'),
	(36, 'Add Module', 10, 1, '2020-02-18 07:36:01', '2020-02-18 07:36:01'),
	(37, 'Update Module', 10, 1, '2020-02-18 07:46:54', '2020-02-18 07:46:54'),
	(38, 'Delete Module', 10, 1, '2020-02-18 07:47:10', '2020-02-18 07:47:10'),
	(39, 'Admin User Group Management', 26, 1, '2020-02-18 08:21:39', '2020-02-18 08:21:39'),
	(40, 'Admin User Group Entry', 26, 1, '2020-02-18 08:26:01', '2020-02-18 08:26:01'),
	(41, 'Give Permission To Admin User', 26, 1, '2020-02-18 08:37:37', '2020-02-18 08:37:37'),
	(42, 'Admin User Group Update', 26, 1, '2020-02-18 08:49:36', '2020-02-18 08:49:36'),
	(43, 'Admin User Group Delete', 26, 1, '2020-02-18 08:49:47', '2020-02-18 08:49:47'),
	(44, 'App User Group Management', 26, 1, '2020-02-18 09:02:37', '2020-02-18 09:02:37'),
	(45, 'App User Group Entry', 26, 1, '2020-02-18 09:02:55', '2020-02-18 09:02:55'),
	(46, 'App User Group Update', 26, 1, '2020-02-18 09:03:06', '2020-02-18 09:03:06'),
	(47, 'App User Group Delete', 26, 1, '2020-02-18 09:03:18', '2020-02-18 09:03:18'),
	(48, 'Publication Category', 26, 1, '2020-02-18 09:13:35', '2020-02-18 09:13:35'),
	(49, 'Publication Category Entry', 26, 1, '2020-02-18 09:14:00', '2020-02-18 09:14:00'),
	(50, 'Publication Category Update', 26, 1, '2020-02-18 09:14:15', '2020-02-18 09:14:15'),
	(51, 'Publication Category Delete', 26, 1, '2020-02-18 09:14:26', '2020-02-18 09:14:26'),
	(52, 'Course Category', 26, 1, '2020-02-18 09:25:01', '2020-02-18 09:25:01'),
	(53, 'Course Category Entry', 26, 1, '2020-02-18 09:25:15', '2020-02-18 09:25:15'),
	(54, 'Course Category Update', 26, 1, '2020-02-18 09:25:30', '2020-02-18 09:25:30'),
	(55, 'Course Category Delete', 26, 1, '2020-02-18 09:25:43', '2020-02-18 09:25:43'),
	(56, 'Notice Category', 26, 1, '2020-02-18 09:32:33', '2020-02-18 09:32:33'),
	(57, 'Notice Category Entry', 26, 1, '2020-02-18 09:32:46', '2020-02-18 09:32:46'),
	(58, 'Notice Category update', 26, 1, '2020-02-18 09:32:55', '2020-02-18 09:32:55'),
	(59, 'Notice Category Delete', 26, 1, '2020-02-18 09:33:07', '2020-02-18 09:33:07'),
	(60, 'Survey Category', 26, 1, '2020-02-18 09:39:22', '2020-02-18 09:39:22'),
	(61, 'Survey Category Entry', 26, 1, '2020-02-18 09:39:33', '2020-02-18 09:39:33'),
	(62, 'Survey Category Update', 26, 1, '2020-02-18 09:39:44', '2020-02-18 09:39:44'),
	(63, 'Survey Category Delete', 26, 1, '2020-02-18 09:40:00', '2020-02-18 09:40:00'),
	(64, 'Manage Notice', 37, 1, '2020-02-18 11:23:13', '2020-02-18 11:23:13'),
	(65, 'Notice Entry', 37, 1, '2020-02-18 11:38:26', '2020-02-18 11:38:26'),
	(66, 'Notice Update', 37, 1, '2020-02-18 11:38:38', '2020-02-18 11:38:38'),
	(67, 'Notice Delete', 37, 1, '2020-02-18 11:38:50', '2020-02-18 11:38:50'),
	(68, 'Publication', 38, 1, '2020-02-22 10:02:39', '2020-02-22 10:02:39'),
	(69, 'Publication Entry', 38, 1, '2020-02-22 10:06:07', '2020-02-22 10:06:07'),
	(70, 'Publication Update', 38, 1, '2020-02-22 10:06:25', '2020-02-22 10:06:25'),
	(71, 'Publication Delete', 38, 1, '2020-02-22 10:06:50', '2020-02-22 10:06:50'),
	(72, 'Message Manage', 29, 1, '2020-02-29 06:45:50', '2020-02-29 06:45:50'),
	(73, 'Message Entry', 29, 1, '2020-02-29 06:46:46', '2020-02-29 06:46:46'),
	(74, 'Message Update', 29, 1, '2020-02-29 06:46:56', '2020-02-29 06:46:56'),
	(75, 'Message Delete', 29, 1, '2020-02-29 06:47:04', '2020-02-29 06:47:04'),
	(76, 'Course Update', 7, 1, '2020-03-02 09:25:05', '2020-03-02 09:25:05'),
	(77, 'Course Delete', 7, 1, '2020-03-02 09:25:27', '2020-03-02 09:25:27'),
	(82, 'Message Category', 26, 1, '2020-03-03 11:25:01', '2020-03-03 11:25:01'),
	(83, 'Message Category Entry', 26, 1, '2020-03-03 11:25:10', '2020-03-03 11:25:10'),
	(84, 'Message Category Update', 26, 1, '2020-03-03 11:25:19', '2020-03-03 11:25:19'),
	(85, 'Message Category Delete', 26, 1, '2020-03-03 11:25:29', '2020-03-03 11:25:29'),
	(86, 'Survey Update', 6, 1, '2020-03-07 07:22:25', '2020-03-07 07:23:40'),
	(87, 'Survey Delete', 6, 1, '2020-03-07 07:22:40', '2020-03-07 07:22:40'),
	(88, 'Manage Teacher', 7, 1, '2020-03-07 10:14:47', '2020-03-07 10:14:47'),
	(89, 'Teacher Entry', 7, 1, '2020-03-07 10:15:10', '2020-03-07 10:15:10'),
	(90, 'Teacher Update', 7, 1, '2020-03-07 10:15:24', '2020-03-07 10:15:24'),
	(91, 'Teacher Delete', 7, 1, '2020-03-07 10:15:39', '2020-03-07 10:15:39'),
	(92, 'Publish Course', 7, 1, '2020-03-09 07:54:34', '2020-03-09 07:54:34'),
	(93, 'Select Perticipant', 7, 1, '2020-03-09 07:54:59', '2020-03-09 07:54:59');
/*!40000 ALTER TABLE `web_actions` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
