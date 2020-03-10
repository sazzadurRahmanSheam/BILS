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
	(5, 'Sazzadur', '123', '123', 'sazzadur@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-02-10 03:12:29', '2020-02-11 06:47:09'),
	(6, 'abul', '123', '123', 'abul@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-02-10 03:12:29', '2020-02-21 13:41:45'),
	(7, 'babul', '1234', '123', 'babul@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-02-10 03:12:29', '2020-03-03 08:35:30'),
	(8, 'Siam', '123', '123', 'siam@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-03-05 00:42:11', '2020-03-05 00:42:11'),
	(9, 'Mizanur', '123', '123', 'mizanur@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-03-05 00:43:09', '2020-03-05 00:43:09'),
	(10, 'Chaki', '123', '123', 'chaki@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-03-05 00:44:27', '2020-03-05 00:44:27'),
	(11, 'Jahed', '123', '123', 'jahed@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-03-05 00:44:56', '2020-03-05 00:44:56'),
	(12, 'Momit', '123', '123', 'momit@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-03-05 00:45:39', '2020-03-05 00:45:39');
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
	(1, 5, 30, 1, '2020-02-10 03:12:29', '2020-02-18 14:29:21'),
	(2, 5, 27, 1, '2020-02-10 03:48:22', '2020-02-18 14:29:21'),
	(4, 6, 31, 1, '2020-02-22 06:52:15', NULL),
	(5, 5, 31, 1, '2020-02-22 06:52:49', NULL),
	(6, 7, 31, 1, '2020-02-22 06:56:46', NULL),
	(7, 7, 30, 1, '2020-02-22 06:57:09', NULL),
	(8, 8, 33, 1, '2020-03-05 00:42:11', '2020-03-05 00:42:11'),
	(9, 9, 27, 1, '2020-03-05 00:43:09', '2020-03-05 00:43:09'),
	(10, 9, 30, 1, '2020-03-05 00:43:09', '2020-03-05 00:43:09'),
	(11, 9, 31, 1, '2020-03-05 00:43:09', '2020-03-05 00:43:09'),
	(12, 9, 32, 1, '2020-03-05 00:43:09', '2020-03-05 00:43:09'),
	(13, 9, 33, 1, '2020-03-05 00:43:09', '2020-03-05 00:43:09'),
	(14, 10, 32, 1, '2020-03-05 00:44:27', '2020-03-05 00:44:27'),
	(15, 11, 27, 1, '2020-03-05 00:44:57', '2020-03-05 00:44:57'),
	(16, 11, 30, 1, '2020-03-05 00:44:57', '2020-03-05 00:44:57'),
	(17, 11, 31, 1, '2020-03-05 00:44:57', '2020-03-05 00:44:57'),
	(18, 11, 32, 1, '2020-03-05 00:44:58', '2020-03-05 00:44:58'),
	(19, 11, 33, 1, '2020-03-05 00:44:58', '2020-03-05 00:44:58'),
	(20, 12, 27, 1, '2020-03-05 00:45:39', '2020-03-05 00:45:39'),
	(21, 12, 30, 1, '2020-03-05 00:45:39', '2020-03-05 00:45:39'),
	(22, 12, 31, 1, '2020-03-05 00:45:39', '2020-03-05 00:45:39'),
	(23, 12, 32, 1, '2020-03-05 00:45:39', '2020-03-05 00:45:39'),
	(24, 12, 33, 1, '2020-03-05 00:45:39', '2020-03-05 00:45:39');
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
	(1, 'Math', 'Basic Math Will Here', 1, '2020-02-11 00:19:33', '2020-02-11 01:10:45'),
	(3, 'English', 'here is english', 1, '2020-03-03 04:42:40', '2020-03-03 04:42:40');
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
	(4, 'Labour Study', 5, '2020-03-04', '2020-03-26', NULL, NULL, 3, 'Sazzadur Raman', 'admin', 'This is about details. This is about details. This is about details. This is about details. This is about details. This is about details. \r\nThis is about details. This is about details. This is about details. This is about details. This is about details. This is about details. \r\nThis is about details. This is about details. This is about details. This is about details. This is about details. This is about details. \r\nThis is about details. This is about details. This is about details. This is about details. This is about details. This is about details. \r\nThis is about details. This is about details. This is about details. This is about details. This is about details. This is about details. \r\nThis is about details. This is about details. This is about details. This is about details. This is about details. This is about details.', 1, 5000, 'Bkash', NULL, NULL, 1, 'Momit', 'Momit', '2020-03-05 00:06:36', '2020-03-09 02:03:29'),
	(5, 'Web Design', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', 'this is about web design.', 1, NULL, NULL, NULL, NULL, 1, 'Momit', 'Momit', '2020-03-05 01:41:23', '2020-03-05 04:23:40');
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
	(4, 4, 6, 0, NULL, NULL, '2020-03-05 00:47:39', '2020-03-05 00:47:39'),
	(5, 4, 7, 0, NULL, NULL, '2020-03-05 00:47:39', '2020-03-05 00:47:39'),
	(6, 4, 10, 1, 0, NULL, '2020-03-05 00:47:39', '2020-03-07 00:38:14'),
	(7, 4, 11, 1, 0, NULL, '2020-03-05 00:47:39', '2020-03-07 00:38:14'),
	(8, 4, 9, 1, 0, NULL, '2020-03-05 00:47:39', '2020-03-06 04:53:45'),
	(9, 4, 12, 3, 1, NULL, '2020-03-05 00:47:39', '2020-03-09 07:53:23'),
	(10, 4, 5, 0, NULL, NULL, '2020-03-05 00:47:39', '2020-03-05 00:47:39'),
	(11, 4, 8, 1, 0, NULL, '2020-03-05 00:47:39', '2020-03-06 07:30:54'),
	(12, 5, 6, 0, NULL, NULL, '2020-03-05 04:23:40', '2020-03-05 04:23:40'),
	(13, 5, 7, 0, NULL, NULL, '2020-03-05 04:23:40', '2020-03-05 04:23:40'),
	(14, 5, 10, 0, NULL, NULL, '2020-03-05 04:23:40', '2020-03-05 04:23:40'),
	(15, 5, 11, 0, NULL, NULL, '2020-03-05 04:23:40', '2020-03-05 04:23:40'),
	(16, 5, 9, 0, NULL, NULL, '2020-03-05 04:23:40', '2020-03-05 04:23:40'),
	(17, 5, 12, 0, NULL, NULL, '2020-03-05 04:23:40', '2020-03-05 04:23:40'),
	(18, 5, 5, 0, NULL, NULL, '2020-03-05 04:23:40', '2020-03-05 04:23:40'),
	(19, 5, 8, 0, NULL, NULL, '2020-03-05 04:23:40', '2020-03-05 04:23:40');
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
	(1, 'User', 'Users', '', 0, 1, 'clip-user-plus', 1, '0000-00-00 00:00:00', '2020-02-04 05:46:09'),
	(2, 'User', 'Admin Users', 'user/admin/admin-user-management', 1, 1, NULL, 1, '0000-00-00 00:00:00', '2020-02-04 06:09:48'),
	(4, 'User', 'App Users', 'user/app-user/app-user-management', 1, 3, NULL, 1, '0000-00-00 00:00:00', '2020-02-04 06:28:13'),
	(6, 'Surveys', 'Surveys', 'survey/management', 0, 3, 'clip-note', 1, '0000-00-00 00:00:00', '2020-02-04 06:28:13'),
	(7, 'Courses', 'Courses', '', 0, 2, 'clip-book', 1, '0000-00-00 00:00:00', '2020-02-04 06:28:13'),
	(8, 'Courses', 'Manage Courses', 'courses/open-course', 7, 1, NULL, 1, '0000-00-00 00:00:00', '2020-03-09 01:43:18'),
	(10, 'Cpanel', 'Control Panel', '', 0, NULL, 'clip-settings', 1, '0000-00-00 00:00:00', '2020-02-04 06:28:13'),
	(11, 'Cpanel', 'General Setting', 'cp/general/general-setting', 10, NULL, '', 1, '0000-00-00 00:00:00', '2020-02-04 06:28:13'),
	(13, 'Cpanel', 'Manage Module', 'cp/module/manage-module', 10, NULL, NULL, 1, '0000-00-00 00:00:00', '2020-02-04 05:28:38'),
	(21, 'Cpanel', 'Web Actions', 'cp/web-action/web-action-management', 10, NULL, NULL, 1, '2020-02-04 06:20:29', '2020-02-04 06:21:40'),
	(26, 'Settings', 'Settings', '', 0, NULL, 'clip-wrench-2', 1, '2020-02-05 04:05:14', '2020-02-05 04:05:14'),
	(27, 'Settings', 'Admin User Groups', 'settings/admin/admin-group-management', 26, NULL, NULL, 1, '2020-02-05 04:06:31', '2020-02-05 04:07:23'),
	(28, 'Settings', 'App User Groups', 'settings/app-user/app-user-group-management', 26, NULL, NULL, 1, '2020-02-07 07:30:00', '2020-02-07 07:30:00'),
	(29, 'Messages', 'Messages', '', 0, NULL, 'clip-bubbles-3', 1, '2020-02-07 07:33:57', '2020-02-07 07:36:38'),
	(30, 'Messages', 'All Messages', 'messages/all-messages-management', 29, NULL, NULL, 1, '2020-02-07 07:38:13', '2020-02-07 07:38:13'),
	(31, 'Messages', 'Group Messages', 'messages/group-messages-management', 29, NULL, NULL, 1, '2020-02-07 07:39:00', '2020-02-07 07:39:00'),
	(32, 'Settings', 'Message Groups', 'settings/messages/all-messages-management', 26, NULL, NULL, 1, '2020-02-07 08:22:46', '2020-02-07 08:22:46'),
	(33, 'Settings', 'Publication Category', 'settings/publication/publication-category', 26, NULL, NULL, 1, '2020-02-10 04:25:48', '2020-02-10 04:25:48'),
	(34, 'Settings', 'Course Category', 'settings/courses/manage-courses-category', 26, NULL, NULL, 1, '2020-02-10 23:47:48', '2020-02-10 23:47:48'),
	(35, 'Settings', 'Notice Category', 'settings/notice/manage-notice-category', 26, NULL, NULL, 1, '2020-02-11 03:53:05', '2020-02-11 03:53:05'),
	(36, 'Settings', 'Survey Category', 'settings/survey/manage-survey-category', 26, NULL, NULL, 1, '2020-02-11 07:08:18', '2020-02-11 07:08:18'),
	(37, 'Notice', 'Notice', 'notice/manage-notice', 0, NULL, 'clip-notification', 1, '2020-02-18 05:21:38', '2020-02-18 05:21:38'),
	(38, 'Publication', 'Publication', 'publication/publication-management', 0, NULL, 'clip-stack-empty', 1, '2020-02-22 04:01:15', '2020-02-22 04:01:15'),
	(39, 'Messages', 'Sent Message', 'messages/sent-message', 29, NULL, NULL, 1, '2020-02-29 00:44:15', '2020-02-29 00:44:15'),
	(40, 'Settings', 'Message Category', 'settings/message/message-category', 26, NULL, NULL, 1, '2020-03-02 08:16:36', '2020-03-03 02:34:46'),
	(42, 'Courses', 'Manage Teacher', 'course/teacher/manage-teacher', 7, NULL, NULL, 1, '2020-03-07 04:01:49', '2020-03-07 04:19:13');
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
	(1, 'All', 'All User can sent message', 1, '2020-03-03 05:35:54', '2020-03-03 05:42:05');
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
	(1, 1, 1, 'test message', 5, NULL, 0, NULL, '2020-02-29 07:15:04', NULL, 0, '2020-02-29 01:15:04', '2020-02-29 11:12:38'),
	(2, 1, 1, 'test message', 6, NULL, 0, NULL, '2020-02-29 07:15:04', NULL, 0, '2020-02-29 01:15:04', '2020-02-29 11:24:42');
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
	(1, 'First Notice Title', 'First test Notice Details', NULL, '', NULL, 1, 'Momit', 'Momit', '2020-02-22 03:12:14', '2020-02-22 03:13:56');
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
	(1, 'Notice Category', 'DetailS', 1, '2020-02-11 06:24:04', '2020-02-11 06:42:34'),
	(2, 'Notice Category1', 'notice details', 0, '2020-02-11 06:40:21', '2020-02-11 06:50:57');
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
	(12, 1, 'Admin', 6, 'App User', '2020-03-05 06:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 00:47:39', '2020-03-05 00:47:39'),
	(13, 1, 'Admin', 7, 'App User', '2020-03-05 06:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 00:47:39', '2020-03-05 00:47:39'),
	(14, 1, 'Admin', 10, 'App User', '2020-03-05 06:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 00:47:39', '2020-03-05 00:47:39'),
	(15, 1, 'Admin', 11, 'App User', '2020-03-05 06:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 00:47:39', '2020-03-05 00:47:39'),
	(16, 1, 'Admin', 9, 'App User', '2020-03-05 06:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 00:47:39', '2020-03-05 00:47:39'),
	(17, 1, 'Admin', 12, 'App User', '2020-03-05 06:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 00:47:39', '2020-03-05 00:47:39'),
	(18, 1, 'Admin', 5, 'App User', '2020-03-05 06:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 00:47:39', '2020-03-05 00:47:39'),
	(19, 1, 'Admin', 8, 'App User', '2020-03-05 06:47:39', 'BILS Initiate Labour Study Course', NULL, 'course/4', 0, '2020-03-05 00:47:39', '2020-03-05 00:47:39'),
	(20, 1, 'Admin', 6, 'App User', '2020-03-05 10:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 04:23:40', '2020-03-05 04:23:40'),
	(21, 1, 'Admin', 7, 'App User', '2020-03-05 10:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 04:23:40', '2020-03-05 04:23:40'),
	(22, 1, 'Admin', 10, 'App User', '2020-03-05 10:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 04:23:40', '2020-03-05 04:23:40'),
	(23, 1, 'Admin', 11, 'App User', '2020-03-05 10:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 04:23:40', '2020-03-05 04:23:40'),
	(24, 1, 'Admin', 9, 'App User', '2020-03-05 10:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 04:23:40', '2020-03-05 04:23:40'),
	(25, 1, 'Admin', 12, 'App User', '2020-03-05 10:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 04:23:40', '2020-03-05 04:23:40'),
	(26, 1, 'Admin', 5, 'App User', '2020-03-05 10:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 04:23:40', '2020-03-05 04:23:40'),
	(27, 1, 'Admin', 8, 'App User', '2020-03-05 10:23:40', 'BILS Initiate Web Design Course', NULL, 'course/5', 0, '2020-03-05 04:23:40', '2020-03-05 04:23:40');
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
	(1, 'labour stadies', 'something something something something something something. something something something something something something. something something something something something something.', 'Article', 'siam', '', 1, 'Momit', '', '2020-02-22 05:11:46', '2020-02-22 12:31:24'),
	(2, 'test', 'test details', 'Article', 'chanchol', '', 0, 'Momit', 'Momit', '2020-02-22 05:12:28', '2020-02-22 06:33:09');
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
	(1, 'Article', 'some article type will goes here', 1, '2020-02-10 05:38:13', '2020-02-10 05:38:13'),
	(2, 'test', 'some article type will goes here', 1, '2020-02-10 06:17:31', '2020-02-22 12:32:04');
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
	(1, 'Bangladesh Institute of Labour Studies', 'BILS', 'BILS APPLICATION', 'admin@bils.com', '01980340482', NULL, '/admin', NULL, 'Dhaka', NULL, '2020-02-03 11:14:58');
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
	(1, 'Survey Category 1', NULL, 1, '2020-02-11 08:00:45', '2020-02-11 08:00:45'),
	(3, 'Survey Category 3', 'asda', 1, '2020-02-11 08:04:45', '2020-03-05 04:27:09');
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
	(5, 'Sazzadur Raman', 'sazzadur@gmail.com', '01747083028', '1234567890', 'Kalabagan, Dhaka', 3, 2, '2020-03-09 07:51:46', '2020-03-09 01:51:46'),
	(6, 'Momit Hasan', 'momit@technolife.ee', '01980340482', '1234567890', 'mohammadpur', 3, 1, '2020-03-09 06:58:58', '2020-03-09 00:58:58'),
	(7, 'chaki', 'chaki@gmail.com', '01757808214', '11', 'Dhaka', 3, 1, '2020-03-09 10:53:40', '2020-03-09 04:53:40');
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
	(1, 'Momit', '123456', '01711', 'momit@bils.com', 'mohammadpur', 1, '1583847111.jpg', '$2y$10$ta1BmsLnz8H4tUqFJHI8puHxhCldn9DSwVfQjc3g59v9YSxM7.Trq', NULL, 0, 1, 'Very Good person.Very Good person.Very Good person.Very Good person.Very Good person.Very Good person.Very Good person.Very Good person.Very Good person.', '2020-01-24 11:30:45', '2020-01-24 00:51:31', '2020-03-10 07:31:51'),
	(31, 'SiaM', '123', '01747083028', 'siam@gmail.com', 'Dhanmondi', 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2020-02-09 07:25:51', '2020-03-10 07:44:09'),
	(37, 'Mr Chaki', '1234567', '01757808214', 'chaki@gmail.com', NULL, 1, '', NULL, NULL, NULL, 1, 'Mr. Chaki is very good person. He likes to do hard work.', NULL, '2020-03-09 05:30:09', '2020-03-10 07:38:53'),
	(38, 'Sabbiur Rahman', 'aa', 'aa', '111a@gmail.com', 'gabtali', 1, '1583831207.jpg', NULL, NULL, NULL, 1, NULL, NULL, '2020-03-09 05:30:52', '2020-03-10 03:06:47');
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.user_groups: ~7 rows (approximately)
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
INSERT INTO `user_groups` (`id`, `group_name`, `type`, `status`, `created_at`, `updated_at`) VALUES
	(26, 'Admin', 1, 1, '2020-02-08 05:39:02', '2020-02-08 05:39:02'),
	(27, 'Web View', 2, 1, '2020-02-08 07:02:57', '2020-02-09 06:00:49'),
	(30, 'App View', 2, 1, '2020-02-09 05:37:38', '2020-02-09 05:59:25'),
	(31, 'General', 2, 1, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(32, 'Senior', 2, 1, '2020-03-05 00:40:22', '2020-03-05 00:40:22'),
	(33, 'Joniour', 2, 1, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(35, 'Sub Admin', 1, 1, '2020-03-10 07:24:51', '2020-03-10 07:24:51');
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.user_group_members: ~8 rows (approximately)
/*!40000 ALTER TABLE `user_group_members` DISABLE KEYS */;
INSERT INTO `user_group_members` (`id`, `emp_id`, `group_id`, `status`, `created_at`, `updated_at`) VALUES
	(2, 1, 26, 1, '2020-02-09 07:27:08', '2020-03-10 13:31:51'),
	(6, 31, 26, 0, '2020-02-09 07:42:22', '2020-02-09 07:42:22'),
	(13, 37, 26, 0, '2020-03-09 05:30:09', '2020-03-10 13:35:49'),
	(14, 38, 26, 1, '2020-03-09 05:30:52', '2020-03-10 09:06:47'),
	(25, 1, 35, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(26, 31, 35, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(27, 37, 35, 1, '2020-03-10 07:24:51', '2020-03-10 13:43:43'),
	(28, 38, 35, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51');
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
) ENGINE=InnoDB AUTO_INCREMENT=779 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_new_db.user_group_permissions: ~518 rows (approximately)
/*!40000 ALTER TABLE `user_group_permissions` DISABLE KEYS */;
INSERT INTO `user_group_permissions` (`id`, `group_id`, `action_id`, `status`, `created_at`, `updated_at`) VALUES
	(19, 26, 1, 1, '2020-02-08 05:39:02', '2020-03-09 10:33:18'),
	(20, 26, 2, 1, '2020-02-08 05:39:02', '2020-03-09 10:33:18'),
	(21, 26, 4, 1, '2020-02-08 05:39:02', '2020-03-09 10:33:18'),
	(22, 26, 6, 1, '2020-02-08 05:39:02', '2020-03-09 10:33:18'),
	(23, 26, 7, 1, '2020-02-08 05:39:02', '2020-03-09 10:33:18'),
	(24, 26, 8, 1, '2020-02-08 05:39:02', '2020-03-09 10:33:18'),
	(25, 26, 9, 1, '2020-02-08 05:39:02', '2020-03-09 10:33:18'),
	(26, 26, 10, 1, '2020-02-08 05:39:02', '2020-03-09 10:33:18'),
	(27, 27, 1, 0, '2020-02-08 07:02:57', '2020-02-08 07:02:57'),
	(28, 27, 2, 0, '2020-02-08 07:02:57', '2020-02-08 07:02:57'),
	(29, 27, 4, 0, '2020-02-08 07:02:58', '2020-02-08 07:02:58'),
	(30, 27, 6, 0, '2020-02-08 07:02:58', '2020-02-08 07:02:58'),
	(31, 27, 7, 0, '2020-02-08 07:02:58', '2020-02-08 07:02:58'),
	(32, 27, 8, 0, '2020-02-08 07:02:58', '2020-02-08 07:02:58'),
	(33, 27, 9, 0, '2020-02-08 07:02:58', '2020-02-08 07:02:58'),
	(34, 27, 10, 0, '2020-02-08 07:02:58', '2020-02-08 07:02:58'),
	(51, 30, 1, 0, '2020-02-09 05:37:39', '2020-02-09 05:37:39'),
	(52, 30, 2, 0, '2020-02-09 05:37:39', '2020-02-09 05:37:39'),
	(53, 30, 4, 0, '2020-02-09 05:37:39', '2020-02-09 05:37:39'),
	(54, 30, 6, 0, '2020-02-09 05:37:39', '2020-02-09 05:37:39'),
	(55, 30, 7, 0, '2020-02-09 05:37:39', '2020-02-09 05:37:39'),
	(56, 30, 8, 0, '2020-02-09 05:37:39', '2020-02-09 05:37:39'),
	(57, 30, 9, 0, '2020-02-09 05:37:39', '2020-02-09 05:37:39'),
	(58, 30, 10, 0, '2020-02-09 05:37:39', '2020-02-09 05:37:39'),
	(60, 26, 24, 1, '2020-02-17 07:46:51', '2020-03-09 10:33:18'),
	(61, 27, 24, 0, '2020-02-17 07:46:51', '2020-02-17 07:46:51'),
	(64, 30, 24, 0, '2020-02-17 07:46:51', '2020-02-17 07:46:51'),
	(66, 26, 25, 1, '2020-02-18 00:17:38', '2020-03-09 10:33:18'),
	(67, 27, 25, 0, '2020-02-18 00:17:38', '2020-02-18 00:17:38'),
	(70, 30, 25, 0, '2020-02-18 00:17:38', '2020-02-18 00:17:38'),
	(72, 26, 26, 1, '2020-02-18 00:23:30', '2020-03-09 10:33:18'),
	(73, 27, 26, 0, '2020-02-18 00:23:30', '2020-02-18 00:23:30'),
	(76, 30, 26, 0, '2020-02-18 00:23:30', '2020-02-18 00:23:30'),
	(78, 26, 27, 1, '2020-02-18 00:37:34', '2020-03-09 10:33:18'),
	(79, 27, 27, 0, '2020-02-18 00:37:34', '2020-02-18 00:37:34'),
	(82, 30, 27, 0, '2020-02-18 00:37:34', '2020-02-18 00:37:34'),
	(84, 26, 28, 1, '2020-02-18 00:44:36', '2020-03-09 10:33:18'),
	(85, 27, 28, 0, '2020-02-18 00:44:36', '2020-02-18 00:44:36'),
	(88, 30, 28, 0, '2020-02-18 00:44:36', '2020-02-18 00:44:36'),
	(90, 26, 29, 1, '2020-02-18 00:47:38', '2020-03-09 10:33:18'),
	(91, 27, 29, 0, '2020-02-18 00:47:38', '2020-02-18 00:47:38'),
	(94, 30, 29, 0, '2020-02-18 00:47:38', '2020-02-18 00:47:38'),
	(96, 26, 30, 1, '2020-02-18 00:48:40', '2020-03-09 10:33:18'),
	(97, 27, 30, 0, '2020-02-18 00:48:40', '2020-02-18 00:48:40'),
	(100, 30, 30, 0, '2020-02-18 00:48:40', '2020-02-18 00:48:40'),
	(102, 26, 31, 1, '2020-02-18 00:48:55', '2020-03-09 10:33:18'),
	(103, 27, 31, 0, '2020-02-18 00:48:55', '2020-02-18 00:48:55'),
	(106, 30, 31, 0, '2020-02-18 00:48:55', '2020-02-18 00:48:55'),
	(108, 26, 32, 1, '2020-02-18 00:51:12', '2020-03-09 10:33:18'),
	(109, 27, 32, 0, '2020-02-18 00:51:12', '2020-02-18 00:51:12'),
	(112, 30, 32, 0, '2020-02-18 00:51:12', '2020-02-18 00:51:12'),
	(114, 26, 33, 1, '2020-02-18 01:12:07', '2020-03-09 10:33:18'),
	(115, 27, 33, 0, '2020-02-18 01:12:07', '2020-02-18 01:12:07'),
	(118, 30, 33, 0, '2020-02-18 01:12:07', '2020-02-18 01:12:07'),
	(120, 26, 34, 1, '2020-02-18 01:14:20', '2020-03-09 10:33:18'),
	(121, 27, 34, 0, '2020-02-18 01:14:20', '2020-02-18 01:14:20'),
	(124, 30, 34, 0, '2020-02-18 01:14:20', '2020-02-18 01:14:20'),
	(126, 26, 35, 1, '2020-02-18 01:34:40', '2020-03-09 10:33:18'),
	(127, 27, 35, 0, '2020-02-18 01:34:40', '2020-02-18 01:34:40'),
	(130, 30, 35, 0, '2020-02-18 01:34:40', '2020-02-18 01:34:40'),
	(132, 26, 36, 1, '2020-02-18 01:36:01', '2020-03-09 10:33:18'),
	(133, 27, 36, 0, '2020-02-18 01:36:01', '2020-02-18 01:36:01'),
	(136, 30, 36, 0, '2020-02-18 01:36:01', '2020-02-18 01:36:01'),
	(138, 26, 37, 1, '2020-02-18 01:46:54', '2020-03-09 10:33:18'),
	(139, 27, 37, 0, '2020-02-18 01:46:54', '2020-02-18 01:46:54'),
	(142, 30, 37, 0, '2020-02-18 01:46:54', '2020-02-18 01:46:54'),
	(144, 26, 38, 1, '2020-02-18 01:47:10', '2020-03-09 10:33:18'),
	(145, 27, 38, 0, '2020-02-18 01:47:10', '2020-02-18 01:47:10'),
	(148, 30, 38, 0, '2020-02-18 01:47:10', '2020-02-18 01:47:10'),
	(150, 26, 39, 1, '2020-02-18 02:21:39', '2020-03-09 10:33:18'),
	(151, 27, 39, 0, '2020-02-18 02:21:39', '2020-02-18 02:21:39'),
	(154, 30, 39, 0, '2020-02-18 02:21:39', '2020-02-18 02:21:39'),
	(156, 26, 40, 1, '2020-02-18 02:26:01', '2020-03-09 10:33:18'),
	(157, 27, 40, 0, '2020-02-18 02:26:01', '2020-02-18 02:26:01'),
	(160, 30, 40, 0, '2020-02-18 02:26:01', '2020-02-18 02:26:01'),
	(162, 26, 41, 1, '2020-02-18 02:37:37', '2020-03-09 10:33:18'),
	(163, 27, 41, 0, '2020-02-18 02:37:37', '2020-02-18 02:37:37'),
	(166, 30, 41, 0, '2020-02-18 02:37:37', '2020-02-18 02:37:37'),
	(168, 26, 42, 1, '2020-02-18 02:49:36', '2020-03-09 10:33:18'),
	(169, 27, 42, 0, '2020-02-18 02:49:36', '2020-02-18 02:49:36'),
	(172, 30, 42, 0, '2020-02-18 02:49:36', '2020-02-18 02:49:36'),
	(174, 26, 43, 1, '2020-02-18 02:49:48', '2020-03-09 10:33:18'),
	(175, 27, 43, 0, '2020-02-18 02:49:48', '2020-02-18 02:49:48'),
	(178, 30, 43, 0, '2020-02-18 02:49:48', '2020-02-18 02:49:48'),
	(180, 26, 44, 1, '2020-02-18 03:02:37', '2020-03-09 10:33:18'),
	(181, 27, 44, 0, '2020-02-18 03:02:38', '2020-02-18 03:02:38'),
	(184, 30, 44, 0, '2020-02-18 03:02:38', '2020-02-18 03:02:38'),
	(186, 26, 45, 1, '2020-02-18 03:02:55', '2020-03-09 10:33:18'),
	(187, 27, 45, 0, '2020-02-18 03:02:55', '2020-02-18 03:02:55'),
	(190, 30, 45, 0, '2020-02-18 03:02:55', '2020-02-18 03:02:55'),
	(192, 26, 46, 1, '2020-02-18 03:03:06', '2020-03-09 10:33:18'),
	(193, 27, 46, 0, '2020-02-18 03:03:06', '2020-02-18 03:03:06'),
	(196, 30, 46, 0, '2020-02-18 03:03:06', '2020-02-18 03:03:06'),
	(198, 26, 47, 1, '2020-02-18 03:03:18', '2020-03-09 10:33:18'),
	(199, 27, 47, 0, '2020-02-18 03:03:18', '2020-02-18 03:03:18'),
	(202, 30, 47, 0, '2020-02-18 03:03:18', '2020-02-18 03:03:18'),
	(204, 26, 48, 1, '2020-02-18 03:13:35', '2020-03-09 10:33:18'),
	(205, 27, 48, 0, '2020-02-18 03:13:36', '2020-02-18 03:13:36'),
	(208, 30, 48, 0, '2020-02-18 03:13:36', '2020-02-18 03:13:36'),
	(210, 26, 49, 1, '2020-02-18 03:14:00', '2020-03-09 10:33:18'),
	(211, 27, 49, 0, '2020-02-18 03:14:00', '2020-02-18 03:14:00'),
	(214, 30, 49, 0, '2020-02-18 03:14:00', '2020-02-18 03:14:00'),
	(216, 26, 50, 1, '2020-02-18 03:14:15', '2020-03-09 10:33:18'),
	(217, 27, 50, 0, '2020-02-18 03:14:15', '2020-02-18 03:14:15'),
	(220, 30, 50, 0, '2020-02-18 03:14:15', '2020-02-18 03:14:15'),
	(222, 26, 51, 1, '2020-02-18 03:14:26', '2020-03-09 10:33:18'),
	(223, 27, 51, 0, '2020-02-18 03:14:26', '2020-02-18 03:14:26'),
	(226, 30, 51, 0, '2020-02-18 03:14:26', '2020-02-18 03:14:26'),
	(228, 26, 52, 1, '2020-02-18 03:25:01', '2020-03-09 10:33:18'),
	(229, 27, 52, 0, '2020-02-18 03:25:01', '2020-02-18 03:25:01'),
	(232, 30, 52, 0, '2020-02-18 03:25:01', '2020-02-18 03:25:01'),
	(234, 26, 53, 1, '2020-02-18 03:25:15', '2020-03-09 10:33:18'),
	(235, 27, 53, 0, '2020-02-18 03:25:15', '2020-02-18 03:25:15'),
	(238, 30, 53, 0, '2020-02-18 03:25:15', '2020-02-18 03:25:15'),
	(240, 26, 54, 1, '2020-02-18 03:25:30', '2020-03-09 10:33:18'),
	(241, 27, 54, 0, '2020-02-18 03:25:30', '2020-02-18 03:25:30'),
	(244, 30, 54, 0, '2020-02-18 03:25:30', '2020-02-18 03:25:30'),
	(246, 26, 55, 1, '2020-02-18 03:25:43', '2020-03-09 10:33:18'),
	(247, 27, 55, 0, '2020-02-18 03:25:43', '2020-02-18 03:25:43'),
	(250, 30, 55, 0, '2020-02-18 03:25:43', '2020-02-18 03:25:43'),
	(252, 26, 56, 1, '2020-02-18 03:32:33', '2020-03-09 10:33:18'),
	(253, 27, 56, 0, '2020-02-18 03:32:34', '2020-02-18 03:32:34'),
	(256, 30, 56, 0, '2020-02-18 03:32:34', '2020-02-18 03:32:34'),
	(258, 26, 57, 1, '2020-02-18 03:32:46', '2020-03-09 10:33:18'),
	(259, 27, 57, 0, '2020-02-18 03:32:46', '2020-02-18 03:32:46'),
	(262, 30, 57, 0, '2020-02-18 03:32:46', '2020-02-18 03:32:46'),
	(264, 26, 58, 1, '2020-02-18 03:32:55', '2020-03-09 10:33:18'),
	(265, 27, 58, 0, '2020-02-18 03:32:56', '2020-02-18 03:32:56'),
	(268, 30, 58, 0, '2020-02-18 03:32:56', '2020-02-18 03:32:56'),
	(270, 26, 59, 1, '2020-02-18 03:33:07', '2020-03-09 10:33:18'),
	(271, 27, 59, 0, '2020-02-18 03:33:07', '2020-02-18 03:33:07'),
	(274, 30, 59, 0, '2020-02-18 03:33:07', '2020-02-18 03:33:07'),
	(276, 26, 60, 1, '2020-02-18 03:39:22', '2020-03-09 10:33:18'),
	(277, 27, 60, 0, '2020-02-18 03:39:23', '2020-02-18 03:39:23'),
	(280, 30, 60, 0, '2020-02-18 03:39:23', '2020-02-18 03:39:23'),
	(282, 26, 61, 1, '2020-02-18 03:39:33', '2020-03-09 10:33:18'),
	(283, 27, 61, 0, '2020-02-18 03:39:33', '2020-02-18 03:39:33'),
	(286, 30, 61, 0, '2020-02-18 03:39:33', '2020-02-18 03:39:33'),
	(288, 26, 62, 1, '2020-02-18 03:39:44', '2020-03-09 10:33:18'),
	(289, 27, 62, 0, '2020-02-18 03:39:44', '2020-02-18 03:39:44'),
	(292, 30, 62, 0, '2020-02-18 03:39:44', '2020-02-18 03:39:44'),
	(294, 26, 63, 1, '2020-02-18 03:40:00', '2020-03-09 10:33:18'),
	(295, 27, 63, 0, '2020-02-18 03:40:00', '2020-02-18 03:40:00'),
	(298, 30, 63, 0, '2020-02-18 03:40:00', '2020-02-18 03:40:00'),
	(300, 26, 64, 1, '2020-02-18 05:23:13', '2020-03-09 10:33:18'),
	(301, 27, 64, 0, '2020-02-18 05:23:13', '2020-02-18 05:23:13'),
	(304, 30, 64, 0, '2020-02-18 05:23:13', '2020-02-18 05:23:13'),
	(306, 26, 65, 1, '2020-02-18 05:38:26', '2020-03-09 10:33:18'),
	(307, 27, 65, 0, '2020-02-18 05:38:26', '2020-02-18 05:38:26'),
	(310, 30, 65, 0, '2020-02-18 05:38:26', '2020-02-18 05:38:26'),
	(312, 26, 66, 1, '2020-02-18 05:38:38', '2020-03-09 10:33:18'),
	(313, 27, 66, 0, '2020-02-18 05:38:38', '2020-02-18 05:38:38'),
	(316, 30, 66, 0, '2020-02-18 05:38:38', '2020-02-18 05:38:38'),
	(318, 26, 67, 1, '2020-02-18 05:38:50', '2020-03-09 10:33:18'),
	(319, 27, 67, 0, '2020-02-18 05:38:50', '2020-02-18 05:38:50'),
	(322, 30, 67, 0, '2020-02-18 05:38:50', '2020-02-18 05:38:50'),
	(323, 31, 1, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(324, 31, 2, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(325, 31, 4, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(326, 31, 6, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(327, 31, 7, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(328, 31, 8, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(329, 31, 9, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(330, 31, 10, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(331, 31, 27, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(332, 31, 28, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(333, 31, 24, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(334, 31, 25, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(335, 31, 26, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(336, 31, 29, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(337, 31, 30, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(338, 31, 31, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(339, 31, 32, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(340, 31, 33, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(341, 31, 34, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(342, 31, 35, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(343, 31, 36, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(344, 31, 37, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(345, 31, 38, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(346, 31, 39, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(347, 31, 40, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(348, 31, 41, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(349, 31, 42, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(350, 31, 43, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(351, 31, 44, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(352, 31, 45, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(353, 31, 46, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(354, 31, 47, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(355, 31, 48, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(356, 31, 49, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(357, 31, 50, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(358, 31, 51, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(359, 31, 52, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(360, 31, 53, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(361, 31, 54, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(362, 31, 55, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(363, 31, 56, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(364, 31, 57, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(365, 31, 58, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(366, 31, 59, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(367, 31, 60, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(368, 31, 61, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(369, 31, 62, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(370, 31, 63, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(371, 31, 64, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(372, 31, 65, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(373, 31, 66, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(374, 31, 67, 0, '2020-02-18 08:01:17', '2020-02-18 08:01:17'),
	(376, 26, 68, 1, '2020-02-22 04:02:39', '2020-03-09 10:33:18'),
	(377, 27, 68, 0, '2020-02-22 04:02:39', '2020-02-22 04:02:39'),
	(380, 30, 68, 0, '2020-02-22 04:02:39', '2020-02-22 04:02:39'),
	(381, 31, 68, 0, '2020-02-22 04:02:39', '2020-02-22 04:02:39'),
	(383, 26, 69, 1, '2020-02-22 04:06:07', '2020-03-09 10:33:18'),
	(384, 27, 69, 0, '2020-02-22 04:06:07', '2020-02-22 04:06:07'),
	(387, 30, 69, 0, '2020-02-22 04:06:07', '2020-02-22 04:06:07'),
	(388, 31, 69, 0, '2020-02-22 04:06:07', '2020-02-22 04:06:07'),
	(390, 26, 70, 1, '2020-02-22 04:06:25', '2020-03-09 10:33:18'),
	(391, 27, 70, 0, '2020-02-22 04:06:25', '2020-02-22 04:06:25'),
	(394, 30, 70, 0, '2020-02-22 04:06:25', '2020-02-22 04:06:25'),
	(395, 31, 70, 0, '2020-02-22 04:06:25', '2020-02-22 04:06:25'),
	(397, 26, 71, 1, '2020-02-22 04:06:50', '2020-03-09 10:33:18'),
	(398, 27, 71, 0, '2020-02-22 04:06:50', '2020-02-22 04:06:50'),
	(401, 30, 71, 0, '2020-02-22 04:06:50', '2020-02-22 04:06:50'),
	(402, 31, 71, 0, '2020-02-22 04:06:50', '2020-02-22 04:06:50'),
	(404, 26, 72, 1, '2020-02-29 00:45:50', '2020-03-09 10:33:18'),
	(405, 27, 72, 0, '2020-02-29 00:45:50', '2020-02-29 00:45:50'),
	(408, 30, 72, 0, '2020-02-29 00:45:50', '2020-02-29 00:45:50'),
	(409, 31, 72, 0, '2020-02-29 00:45:50', '2020-02-29 00:45:50'),
	(411, 26, 73, 1, '2020-02-29 00:46:46', '2020-03-09 10:33:18'),
	(412, 27, 73, 0, '2020-02-29 00:46:46', '2020-02-29 00:46:46'),
	(415, 30, 73, 0, '2020-02-29 00:46:46', '2020-02-29 00:46:46'),
	(416, 31, 73, 0, '2020-02-29 00:46:46', '2020-02-29 00:46:46'),
	(418, 26, 74, 1, '2020-02-29 00:46:56', '2020-03-09 10:33:18'),
	(419, 27, 74, 0, '2020-02-29 00:46:56', '2020-02-29 00:46:56'),
	(422, 30, 74, 0, '2020-02-29 00:46:56', '2020-02-29 00:46:56'),
	(423, 31, 74, 0, '2020-02-29 00:46:56', '2020-02-29 00:46:56'),
	(425, 26, 75, 1, '2020-02-29 00:47:04', '2020-03-09 10:33:18'),
	(426, 27, 75, 0, '2020-02-29 00:47:04', '2020-02-29 00:47:04'),
	(429, 30, 75, 0, '2020-02-29 00:47:04', '2020-02-29 00:47:04'),
	(430, 31, 75, 0, '2020-02-29 00:47:04', '2020-02-29 00:47:04'),
	(432, 26, 76, 1, '2020-03-02 03:25:05', '2020-03-09 10:33:18'),
	(433, 27, 76, 0, '2020-03-02 03:25:05', '2020-03-02 03:25:05'),
	(436, 30, 76, 0, '2020-03-02 03:25:05', '2020-03-02 03:25:05'),
	(437, 31, 76, 0, '2020-03-02 03:25:05', '2020-03-02 03:25:05'),
	(439, 26, 77, 1, '2020-03-02 03:25:28', '2020-03-09 10:33:18'),
	(440, 27, 77, 0, '2020-03-02 03:25:28', '2020-03-02 03:25:28'),
	(443, 30, 77, 0, '2020-03-02 03:25:28', '2020-03-02 03:25:28'),
	(444, 31, 77, 0, '2020-03-02 03:25:28', '2020-03-02 03:25:28'),
	(474, 26, 82, 1, '2020-03-03 05:25:01', '2020-03-09 10:33:18'),
	(475, 27, 82, 0, '2020-03-03 05:25:01', '2020-03-03 05:25:01'),
	(478, 30, 82, 0, '2020-03-03 05:25:01', '2020-03-03 05:25:01'),
	(479, 31, 82, 0, '2020-03-03 05:25:01', '2020-03-03 05:25:01'),
	(481, 26, 83, 1, '2020-03-03 05:25:10', '2020-03-09 10:33:18'),
	(482, 27, 83, 0, '2020-03-03 05:25:10', '2020-03-03 05:25:10'),
	(485, 30, 83, 0, '2020-03-03 05:25:10', '2020-03-03 05:25:10'),
	(486, 31, 83, 0, '2020-03-03 05:25:10', '2020-03-03 05:25:10'),
	(488, 26, 84, 1, '2020-03-03 05:25:19', '2020-03-09 10:33:18'),
	(489, 27, 84, 0, '2020-03-03 05:25:19', '2020-03-03 05:25:19'),
	(492, 30, 84, 0, '2020-03-03 05:25:19', '2020-03-03 05:25:19'),
	(493, 31, 84, 0, '2020-03-03 05:25:19', '2020-03-03 05:25:19'),
	(495, 26, 85, 1, '2020-03-03 05:25:29', '2020-03-09 10:33:18'),
	(496, 27, 85, 0, '2020-03-03 05:25:29', '2020-03-03 05:25:29'),
	(499, 30, 85, 0, '2020-03-03 05:25:29', '2020-03-03 05:25:29'),
	(500, 31, 85, 0, '2020-03-03 05:25:29', '2020-03-03 05:25:29'),
	(501, 32, 1, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(502, 32, 2, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(503, 32, 4, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(504, 32, 6, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(505, 32, 7, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(506, 32, 8, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(507, 32, 9, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(508, 32, 10, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(509, 32, 27, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(510, 32, 28, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(511, 32, 24, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(512, 32, 25, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(513, 32, 26, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(514, 32, 76, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(515, 32, 77, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(516, 32, 29, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(517, 32, 30, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(518, 32, 31, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(519, 32, 32, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(520, 32, 33, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(521, 32, 34, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(522, 32, 35, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(523, 32, 36, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(524, 32, 37, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(525, 32, 38, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(526, 32, 39, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(527, 32, 40, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(528, 32, 41, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(529, 32, 42, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(530, 32, 43, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(531, 32, 44, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(532, 32, 45, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(533, 32, 46, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(534, 32, 47, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(535, 32, 48, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(536, 32, 49, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(537, 32, 50, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(538, 32, 51, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(539, 32, 52, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(540, 32, 53, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(541, 32, 54, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(542, 32, 55, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(543, 32, 56, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(544, 32, 57, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(545, 32, 58, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(546, 32, 59, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(547, 32, 60, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(548, 32, 61, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(549, 32, 62, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(550, 32, 63, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(551, 32, 82, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(552, 32, 83, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(553, 32, 84, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(554, 32, 85, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(555, 32, 72, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(556, 32, 73, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(557, 32, 74, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(558, 32, 75, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(559, 32, 64, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(560, 32, 65, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(561, 32, 66, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(562, 32, 67, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(563, 32, 68, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(564, 32, 69, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(565, 32, 70, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(566, 32, 71, 0, '2020-03-05 00:40:23', '2020-03-05 00:40:23'),
	(567, 33, 1, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(568, 33, 2, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(569, 33, 4, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(570, 33, 6, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(571, 33, 7, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(572, 33, 8, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(573, 33, 9, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(574, 33, 10, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(575, 33, 27, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(576, 33, 28, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(577, 33, 24, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(578, 33, 25, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(579, 33, 26, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(580, 33, 76, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(581, 33, 77, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(582, 33, 29, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(583, 33, 30, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(584, 33, 31, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(585, 33, 32, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(586, 33, 33, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(587, 33, 34, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(588, 33, 35, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(589, 33, 36, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(590, 33, 37, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(591, 33, 38, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(592, 33, 39, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(593, 33, 40, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(594, 33, 41, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(595, 33, 42, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(596, 33, 43, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(597, 33, 44, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(598, 33, 45, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(599, 33, 46, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(600, 33, 47, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(601, 33, 48, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(602, 33, 49, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(603, 33, 50, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(604, 33, 51, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(605, 33, 52, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(606, 33, 53, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(607, 33, 54, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(608, 33, 55, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(609, 33, 56, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(610, 33, 57, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(611, 33, 58, 0, '2020-03-05 00:40:39', '2020-03-05 00:40:39'),
	(612, 33, 59, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(613, 33, 60, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(614, 33, 61, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(615, 33, 62, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(616, 33, 63, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(617, 33, 82, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(618, 33, 83, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(619, 33, 84, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(620, 33, 85, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(621, 33, 72, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(622, 33, 73, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(623, 33, 74, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(624, 33, 75, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(625, 33, 64, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(626, 33, 65, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(627, 33, 66, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(628, 33, 67, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(629, 33, 68, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(630, 33, 69, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(631, 33, 70, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(632, 33, 71, 0, '2020-03-05 00:40:40', '2020-03-05 00:40:40'),
	(634, 26, 86, 1, '2020-03-07 01:22:25', '2020-03-09 10:33:18'),
	(635, 27, 86, 0, '2020-03-07 01:22:25', '2020-03-07 01:22:25'),
	(638, 30, 86, 0, '2020-03-07 01:22:25', '2020-03-07 01:22:25'),
	(639, 31, 86, 0, '2020-03-07 01:22:25', '2020-03-07 01:22:25'),
	(640, 32, 86, 0, '2020-03-07 01:22:25', '2020-03-07 01:22:25'),
	(641, 33, 86, 0, '2020-03-07 01:22:25', '2020-03-07 01:22:25'),
	(643, 26, 87, 1, '2020-03-07 01:22:40', '2020-03-09 10:33:18'),
	(644, 27, 87, 0, '2020-03-07 01:22:40', '2020-03-07 01:22:40'),
	(647, 30, 87, 0, '2020-03-07 01:22:40', '2020-03-07 01:22:40'),
	(648, 31, 87, 0, '2020-03-07 01:22:40', '2020-03-07 01:22:40'),
	(649, 32, 87, 0, '2020-03-07 01:22:40', '2020-03-07 01:22:40'),
	(650, 33, 87, 0, '2020-03-07 01:22:40', '2020-03-07 01:22:40'),
	(652, 26, 88, 1, '2020-03-07 04:14:47', '2020-03-09 10:33:18'),
	(653, 27, 88, 0, '2020-03-07 04:14:47', '2020-03-07 04:14:47'),
	(656, 30, 88, 0, '2020-03-07 04:14:47', '2020-03-07 04:14:47'),
	(657, 31, 88, 0, '2020-03-07 04:14:47', '2020-03-07 04:14:47'),
	(658, 32, 88, 0, '2020-03-07 04:14:47', '2020-03-07 04:14:47'),
	(659, 33, 88, 0, '2020-03-07 04:14:47', '2020-03-07 04:14:47'),
	(661, 26, 89, 1, '2020-03-07 04:15:10', '2020-03-09 10:33:18'),
	(662, 27, 89, 0, '2020-03-07 04:15:10', '2020-03-07 04:15:10'),
	(665, 30, 89, 0, '2020-03-07 04:15:10', '2020-03-07 04:15:10'),
	(666, 31, 89, 0, '2020-03-07 04:15:10', '2020-03-07 04:15:10'),
	(667, 32, 89, 0, '2020-03-07 04:15:10', '2020-03-07 04:15:10'),
	(668, 33, 89, 0, '2020-03-07 04:15:10', '2020-03-07 04:15:10'),
	(670, 26, 90, 1, '2020-03-07 04:15:24', '2020-03-09 10:33:18'),
	(671, 27, 90, 0, '2020-03-07 04:15:24', '2020-03-07 04:15:24'),
	(674, 30, 90, 0, '2020-03-07 04:15:24', '2020-03-07 04:15:24'),
	(675, 31, 90, 0, '2020-03-07 04:15:24', '2020-03-07 04:15:24'),
	(676, 32, 90, 0, '2020-03-07 04:15:24', '2020-03-07 04:15:24'),
	(677, 33, 90, 0, '2020-03-07 04:15:24', '2020-03-07 04:15:24'),
	(679, 26, 91, 1, '2020-03-07 04:15:39', '2020-03-09 10:33:18'),
	(680, 27, 91, 0, '2020-03-07 04:15:39', '2020-03-07 04:15:39'),
	(683, 30, 91, 0, '2020-03-07 04:15:39', '2020-03-07 04:15:39'),
	(684, 31, 91, 0, '2020-03-07 04:15:39', '2020-03-07 04:15:39'),
	(685, 32, 91, 0, '2020-03-07 04:15:39', '2020-03-07 04:15:39'),
	(686, 33, 91, 0, '2020-03-07 04:15:39', '2020-03-07 04:15:39'),
	(688, 26, 92, 1, '2020-03-09 01:54:34', '2020-03-09 10:33:18'),
	(689, 27, 92, 0, '2020-03-09 01:54:34', '2020-03-09 01:54:34'),
	(692, 30, 92, 0, '2020-03-09 01:54:34', '2020-03-09 01:54:34'),
	(693, 31, 92, 0, '2020-03-09 01:54:34', '2020-03-09 01:54:34'),
	(694, 32, 92, 0, '2020-03-09 01:54:34', '2020-03-09 01:54:34'),
	(695, 33, 92, 0, '2020-03-09 01:54:34', '2020-03-09 01:54:34'),
	(697, 26, 93, 1, '2020-03-09 01:54:59', '2020-03-09 10:33:18'),
	(698, 27, 93, 0, '2020-03-09 01:54:59', '2020-03-09 01:54:59'),
	(701, 30, 93, 0, '2020-03-09 01:54:59', '2020-03-09 01:54:59'),
	(702, 31, 93, 0, '2020-03-09 01:54:59', '2020-03-09 01:54:59'),
	(703, 32, 93, 0, '2020-03-09 01:54:59', '2020-03-09 01:54:59'),
	(704, 33, 93, 0, '2020-03-09 01:54:59', '2020-03-09 01:54:59'),
	(705, 35, 1, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(706, 35, 2, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(707, 35, 4, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(708, 35, 6, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(709, 35, 7, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(710, 35, 8, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(711, 35, 9, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(712, 35, 10, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(713, 35, 27, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(714, 35, 28, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(715, 35, 86, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(716, 35, 87, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(717, 35, 24, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(718, 35, 25, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(719, 35, 26, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(720, 35, 76, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(721, 35, 77, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(722, 35, 88, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(723, 35, 89, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(724, 35, 90, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(725, 35, 91, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(726, 35, 92, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(727, 35, 93, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(728, 35, 29, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(729, 35, 30, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(730, 35, 31, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(731, 35, 32, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(732, 35, 33, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(733, 35, 34, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(734, 35, 35, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(735, 35, 36, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(736, 35, 37, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(737, 35, 38, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(738, 35, 39, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(739, 35, 40, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(740, 35, 41, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(741, 35, 42, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(742, 35, 43, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(743, 35, 44, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(744, 35, 45, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(745, 35, 46, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(746, 35, 47, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(747, 35, 48, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(748, 35, 49, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(749, 35, 50, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(750, 35, 51, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(751, 35, 52, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(752, 35, 53, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(753, 35, 54, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(754, 35, 55, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(755, 35, 56, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(756, 35, 57, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(757, 35, 58, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(758, 35, 59, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(759, 35, 60, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(760, 35, 61, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(761, 35, 62, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(762, 35, 63, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(763, 35, 82, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(764, 35, 83, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(765, 35, 84, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(766, 35, 85, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(767, 35, 72, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(768, 35, 73, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(769, 35, 74, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(770, 35, 75, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(771, 35, 64, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(772, 35, 65, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(773, 35, 66, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(774, 35, 67, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(775, 35, 68, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(776, 35, 69, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(777, 35, 70, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51'),
	(778, 35, 71, 0, '2020-03-10 07:24:51', '2020-03-10 07:24:51');
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

-- Dumping data for table bils_new_db.web_actions: ~65 rows (approximately)
/*!40000 ALTER TABLE `web_actions` DISABLE KEYS */;
INSERT INTO `web_actions` (`id`, `activity_name`, `module_id`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Admin Users', 1, 1, '0000-00-00 00:00:00', '2020-02-05 08:13:21'),
	(2, 'Admin User Entry', 1, 1, '0000-00-00 00:00:00', '2020-02-05 08:13:21'),
	(4, 'Admin User update', 1, 1, '0000-00-00 00:00:00', '2020-02-05 08:13:21'),
	(6, 'Admin User delete', 1, 1, '0000-00-00 00:00:00', '2020-02-05 08:13:21'),
	(7, 'App Users', 1, 1, '0000-00-00 00:00:00', '2020-02-05 08:13:21'),
	(8, 'App User Entry', 1, 1, '0000-00-00 00:00:00', '2020-02-05 08:13:21'),
	(9, 'App User update', 1, 1, '0000-00-00 00:00:00', '2020-02-05 08:13:21'),
	(10, 'App User delete', 1, 1, '0000-00-00 00:00:00', '2020-02-05 08:13:21'),
	(24, 'Open Course', 7, 1, '2020-02-17 07:46:50', '2020-02-17 07:46:50'),
	(25, 'Course', 7, 1, '2020-02-18 00:17:38', '2020-02-18 00:17:38'),
	(26, 'Course Entry', 7, 1, '2020-02-18 00:23:30', '2020-03-02 03:16:59'),
	(27, 'Survey', 6, 1, '2020-02-18 00:37:34', '2020-02-18 00:37:34'),
	(28, 'Add Survey', 6, 1, '2020-02-18 00:44:35', '2020-02-18 00:44:35'),
	(29, 'Control Panel', 10, 1, '2020-02-18 00:47:38', '2020-02-18 00:47:38'),
	(30, 'Web Actions Entry', 10, 1, '2020-02-18 00:48:40', '2020-02-18 00:48:40'),
	(31, 'Web Actions Update', 10, 1, '2020-02-18 00:48:55', '2020-02-18 00:48:55'),
	(32, 'Web Actions Management', 10, 1, '2020-02-18 00:51:12', '2020-02-18 00:51:12'),
	(33, 'General Setting Management', 10, 1, '2020-02-18 01:12:07', '2020-02-18 01:12:07'),
	(34, 'General Setting Update', 10, 1, '2020-02-18 01:14:20', '2020-02-18 01:14:20'),
	(35, 'Manage Module', 10, 1, '2020-02-18 01:34:40', '2020-02-18 01:34:40'),
	(36, 'Add Module', 10, 1, '2020-02-18 01:36:01', '2020-02-18 01:36:01'),
	(37, 'Update Module', 10, 1, '2020-02-18 01:46:54', '2020-02-18 01:46:54'),
	(38, 'Delete Module', 10, 1, '2020-02-18 01:47:10', '2020-02-18 01:47:10'),
	(39, 'Admin User Group Management', 26, 1, '2020-02-18 02:21:39', '2020-02-18 02:21:39'),
	(40, 'Admin User Group Entry', 26, 1, '2020-02-18 02:26:01', '2020-02-18 02:26:01'),
	(41, 'Give Permission To Admin User', 26, 1, '2020-02-18 02:37:37', '2020-02-18 02:37:37'),
	(42, 'Admin User Group Update', 26, 1, '2020-02-18 02:49:36', '2020-02-18 02:49:36'),
	(43, 'Admin User Group Delete', 26, 1, '2020-02-18 02:49:47', '2020-02-18 02:49:47'),
	(44, 'App User Group Management', 26, 1, '2020-02-18 03:02:37', '2020-02-18 03:02:37'),
	(45, 'App User Group Entry', 26, 1, '2020-02-18 03:02:55', '2020-02-18 03:02:55'),
	(46, 'App User Group Update', 26, 1, '2020-02-18 03:03:06', '2020-02-18 03:03:06'),
	(47, 'App User Group Delete', 26, 1, '2020-02-18 03:03:18', '2020-02-18 03:03:18'),
	(48, 'Publication Category', 26, 1, '2020-02-18 03:13:35', '2020-02-18 03:13:35'),
	(49, 'Publication Category Entry', 26, 1, '2020-02-18 03:14:00', '2020-02-18 03:14:00'),
	(50, 'Publication Category Update', 26, 1, '2020-02-18 03:14:15', '2020-02-18 03:14:15'),
	(51, 'Publication Category Delete', 26, 1, '2020-02-18 03:14:26', '2020-02-18 03:14:26'),
	(52, 'Course Category', 26, 1, '2020-02-18 03:25:01', '2020-02-18 03:25:01'),
	(53, 'Course Category Entry', 26, 1, '2020-02-18 03:25:15', '2020-02-18 03:25:15'),
	(54, 'Course Category Update', 26, 1, '2020-02-18 03:25:30', '2020-02-18 03:25:30'),
	(55, 'Course Category Delete', 26, 1, '2020-02-18 03:25:43', '2020-02-18 03:25:43'),
	(56, 'Notice Category', 26, 1, '2020-02-18 03:32:33', '2020-02-18 03:32:33'),
	(57, 'Notice Category Entry', 26, 1, '2020-02-18 03:32:46', '2020-02-18 03:32:46'),
	(58, 'Notice Category update', 26, 1, '2020-02-18 03:32:55', '2020-02-18 03:32:55'),
	(59, 'Notice Category Delete', 26, 1, '2020-02-18 03:33:07', '2020-02-18 03:33:07'),
	(60, 'Survey Category', 26, 1, '2020-02-18 03:39:22', '2020-02-18 03:39:22'),
	(61, 'Survey Category Entry', 26, 1, '2020-02-18 03:39:33', '2020-02-18 03:39:33'),
	(62, 'Survey Category Update', 26, 1, '2020-02-18 03:39:44', '2020-02-18 03:39:44'),
	(63, 'Survey Category Delete', 26, 1, '2020-02-18 03:40:00', '2020-02-18 03:40:00'),
	(64, 'Manage Notice', 37, 1, '2020-02-18 05:23:13', '2020-02-18 05:23:13'),
	(65, 'Notice Entry', 37, 1, '2020-02-18 05:38:26', '2020-02-18 05:38:26'),
	(66, 'Notice Update', 37, 1, '2020-02-18 05:38:38', '2020-02-18 05:38:38'),
	(67, 'Notice Delete', 37, 1, '2020-02-18 05:38:50', '2020-02-18 05:38:50'),
	(68, 'Publication', 38, 1, '2020-02-22 04:02:39', '2020-02-22 04:02:39'),
	(69, 'Publication Entry', 38, 1, '2020-02-22 04:06:07', '2020-02-22 04:06:07'),
	(70, 'Publication Update', 38, 1, '2020-02-22 04:06:25', '2020-02-22 04:06:25'),
	(71, 'Publication Delete', 38, 1, '2020-02-22 04:06:50', '2020-02-22 04:06:50'),
	(72, 'Message Manage', 29, 1, '2020-02-29 00:45:50', '2020-02-29 00:45:50'),
	(73, 'Message Entry', 29, 1, '2020-02-29 00:46:46', '2020-02-29 00:46:46'),
	(74, 'Message Update', 29, 1, '2020-02-29 00:46:56', '2020-02-29 00:46:56'),
	(75, 'Message Delete', 29, 1, '2020-02-29 00:47:04', '2020-02-29 00:47:04'),
	(76, 'Course Update', 7, 1, '2020-03-02 03:25:05', '2020-03-02 03:25:05'),
	(77, 'Course Delete', 7, 1, '2020-03-02 03:25:27', '2020-03-02 03:25:27'),
	(82, 'Message Category', 26, 1, '2020-03-03 05:25:01', '2020-03-03 05:25:01'),
	(83, 'Message Category Entry', 26, 1, '2020-03-03 05:25:10', '2020-03-03 05:25:10'),
	(84, 'Message Category Update', 26, 1, '2020-03-03 05:25:19', '2020-03-03 05:25:19'),
	(85, 'Message Category Delete', 26, 1, '2020-03-03 05:25:29', '2020-03-03 05:25:29'),
	(86, 'Survey Update', 6, 1, '2020-03-07 01:22:25', '2020-03-07 01:23:40'),
	(87, 'Survey Delete', 6, 1, '2020-03-07 01:22:40', '2020-03-07 01:22:40'),
	(88, 'Manage Teacher', 7, 1, '2020-03-07 04:14:47', '2020-03-07 04:14:47'),
	(89, 'Teacher Entry', 7, 1, '2020-03-07 04:15:10', '2020-03-07 04:15:10'),
	(90, 'Teacher Update', 7, 1, '2020-03-07 04:15:24', '2020-03-07 04:15:24'),
	(91, 'Teacher Delete', 7, 1, '2020-03-07 04:15:39', '2020-03-07 04:15:39'),
	(92, 'Publish Course', 7, 1, '2020-03-09 01:54:34', '2020-03-09 01:54:34'),
	(93, 'Select Perticipant', 7, 1, '2020-03-09 01:54:59', '2020-03-09 01:54:59');
/*!40000 ALTER TABLE `web_actions` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
