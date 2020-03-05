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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.app_users: ~3 rows (approximately)
/*!40000 ALTER TABLE `app_users` DISABLE KEYS */;
INSERT INTO `app_users` (`id`, `name`, `nid_no`, `contact_no`, `email`, `address`, `password`, `user_profile_image`, `remarks`, `status`, `user_type`, `created_at`, `updated_at`) VALUES
	(5, 'Sazzadur', '123', '123', 'sazzadur@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-02-10 09:12:29', '2020-02-11 12:47:09'),
	(6, 'abul', '123', '123', 'abul@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-02-10 09:12:29', '2020-02-21 19:41:45'),
	(7, 'babul', '1234', '123', 'babul@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-02-10 09:12:29', '2020-03-03 14:35:30');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.app_user_group_members: ~6 rows (approximately)
/*!40000 ALTER TABLE `app_user_group_members` DISABLE KEYS */;
INSERT INTO `app_user_group_members` (`id`, `app_user_id`, `group_id`, `status`, `created_at`, `updated_at`) VALUES
	(1, 5, 30, 1, '2020-02-10 09:12:29', '2020-02-18 20:29:21'),
	(2, 5, 27, 1, '2020-02-10 09:48:22', '2020-02-18 20:29:21'),
	(4, 6, 31, 1, '2020-02-22 12:52:15', NULL),
	(5, 5, 31, 1, '2020-02-22 12:52:49', NULL),
	(6, 7, 31, 1, '2020-02-22 12:56:46', NULL),
	(7, 7, 30, 1, '2020-02-22 12:57:09', NULL);
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
  `course_type` int(11) DEFAULT 0 COMMENT 'from course categories table',
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.course_masters: ~3 rows (approximately)
/*!40000 ALTER TABLE `course_masters` DISABLE KEYS */;
INSERT INTO `course_masters` (`id`, `course_title`, `duration`, `appx_start_time`, `appx_end_time`, `act_start_time`, `act_end_time`, `course_type`, `course_teacher`, `course_responsible_person`, `details`, `course_status`, `payment_fee`, `payment_method`, `discount_message`, `attachment`, `pub_status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 'Labour Study', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', 'teachig about labour', 2, NULL, NULL, NULL, NULL, 1, 'Momit', 'Momit', '2020-03-04 07:24:01', '2020-03-04 14:26:30'),
	(2, 'Test Course Title', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', 'Test Description', 1, NULL, NULL, NULL, NULL, 0, 'Momit', '', '2020-03-04 07:26:36', '2020-03-04 07:26:36'),
	(3, 'Rickshaw Pooler', 10, '2020-03-05', '2020-04-04', NULL, NULL, 3, 'Abul Hasan', 'admin', 'This is for Rickshaw Pooler. where they learn about their right.', 1, 300, 'Bkash', 'No discount available', NULL, 0, 'Momit', 'Momit', '2020-03-04 08:02:40', '2020-03-04 19:55:40');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.course_perticipants: ~3 rows (approximately)
/*!40000 ALTER TABLE `course_perticipants` DISABLE KEYS */;
INSERT INTO `course_perticipants` (`id`, `course_id`, `perticipant_id`, `is_interested`, `is_selected`, `status`, `created_at`, `updated_at`) VALUES
	(1, 1, 6, 1, NULL, NULL, '2020-03-04 14:06:15', '2020-03-04 20:08:20'),
	(2, 1, 7, 0, NULL, NULL, '2020-03-04 14:06:15', '2020-03-04 14:06:15'),
	(3, 1, 5, 0, NULL, NULL, '2020-03-04 14:06:15', '2020-03-04 14:06:15');
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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_new_db.menus: ~26 rows (approximately)
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` (`id`, `module_name`, `menu_title`, `menu_url`, `parent_id`, `serial_no`, `menu_icon_class`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'User', 'Users', '', 0, 1, 'clip-user-plus', 1, '0000-00-00 00:00:00', '2020-02-04 11:46:09'),
	(2, 'User', 'Admin Users', 'user/admin/admin-user-management', 1, 1, NULL, 1, '0000-00-00 00:00:00', '2020-02-04 12:09:48'),
	(4, 'User', 'App Users', 'user/app-user/app-user-management', 1, 3, NULL, 1, '0000-00-00 00:00:00', '2020-02-04 12:28:13'),
	(6, 'Surveys', 'Surveys', 'survey/management', 0, 3, 'clip-note', 1, '0000-00-00 00:00:00', '2020-02-04 12:28:13'),
	(7, 'Courses', 'Courses', '', 0, 2, 'clip-book', 1, '0000-00-00 00:00:00', '2020-02-04 12:28:13'),
	(8, 'Courses', 'Open Courses', 'courses/open-course', 7, 1, NULL, 1, '0000-00-00 00:00:00', '2020-02-04 12:28:13'),
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
	(40, 'Settings', 'Message Category', 'settings/message/message-category', 26, NULL, NULL, 1, '2020-03-02 14:16:36', '2020-03-03 08:34:46');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='m';

-- Dumping data for table bils_new_db.notifications: ~3 rows (approximately)
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` (`id`, `from_id`, `from_user_type`, `to_id`, `to_user_type`, `date_time`, `notification_title`, `message`, `view_url`, `status`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Admin', 6, 'App User', '2020-03-04 20:06:15', 'BILS Initiate Labour Study Course', NULL, 'course/1', 0, '2020-03-04 14:06:15', '2020-03-04 14:06:15'),
	(2, 1, 'Admin', 7, 'App User', '2020-03-04 20:06:15', 'BILS Initiate Labour Study Course', NULL, 'course/1', 0, '2020-03-04 14:06:15', '2020-03-04 14:06:15'),
	(3, 1, 'Admin', 5, 'App User', '2020-03-04 20:06:15', 'BILS Initiate Labour Study Course', NULL, 'course/1', 0, '2020-03-04 14:06:15', '2020-03-04 14:06:15'),
	(11, 1, 'Admin', 6, 'App User', '2020-03-04 20:26:30', 'BILS Approved Labour Study Course', NULL, 'course/1', 0, '2020-03-04 14:26:30', '2020-03-04 14:26:30');
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
	(3, 'Survey Category 3', 'asda', 0, '2020-02-11 14:04:45', '2020-02-11 14:06:11');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.survey_masters: ~0 rows (approximately)
/*!40000 ALTER TABLE `survey_masters` DISABLE KEYS */;
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
  `survey_question_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_no` int(11) DEFAULT NULL,
  `question_details` text NOT NULL,
  `question_type` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`survey_question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.survey_questions: ~0 rows (approximately)
/*!40000 ALTER TABLE `survey_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_questions` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.survey_question_answer_options
CREATE TABLE IF NOT EXISTS `survey_question_answer_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_question_id` int(11) NOT NULL DEFAULT 0,
  `option` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.survey_question_answer_options: ~0 rows (approximately)
/*!40000 ALTER TABLE `survey_question_answer_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_question_answer_options` ENABLE KEYS */;

-- Dumping structure for table bils_new_db.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nid_no` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `contact_no` varchar(13) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1:admin user , 2:App user',
  `user_profile_image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login_status` tinyint(1) DEFAULT NULL COMMENT '1:logged in, 0 not logged in',
  `status` tinyint(1) DEFAULT NULL COMMENT '1:active, 2:in-active',
  `remarks` text COLLATE utf8_unicode_ci DEFAULT '',
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_new_db.users: ~3 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `nid_no`, `contact_no`, `email`, `address`, `user_type`, `user_profile_image`, `password`, `remember_token`, `login_status`, `status`, `remarks`, `last_login`, `created_at`, `updated_at`) VALUES
	(1, 'Momit', '123456', '01711', 'momit@bils.com', 'mohammadpur', 1, '', '$2y$10$ta1BmsLnz8H4tUqFJHI8puHxhCldn9DSwVfQjc3g59v9YSxM7.Trq', NULL, 0, 1, 'Very Good', '2020-01-24 17:30:45', '2020-01-24 06:51:31', '2020-03-04 05:42:00'),
	(13, 'Momit Hasan', '78967899', '53463435', 'momit@technolife.ee', NULL, 1, NULL, NULL, NULL, NULL, 1, '', NULL, '2020-02-02 08:44:30', '2020-02-17 13:35:42'),
	(31, 'SiaM', '123', '01747083028', 'siam@gmail.com', NULL, 1, NULL, NULL, NULL, NULL, 2, '', NULL, '2020-02-09 13:25:51', '2020-02-17 13:35:46');
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.user_groups: ~7 rows (approximately)
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
INSERT INTO `user_groups` (`id`, `group_name`, `type`, `status`, `created_at`, `updated_at`) VALUES
	(25, 'Sub Admin', 1, 0, '2020-02-07 10:23:56', '2020-02-18 06:53:21'),
	(26, 'Admin', 1, 1, '2020-02-08 11:39:02', '2020-02-08 11:39:02'),
	(27, 'Web View', 2, 1, '2020-02-08 13:02:57', '2020-02-09 12:00:49'),
	(28, 'Sub Admin 1', 1, 0, '2020-02-09 09:57:24', '2020-02-09 09:57:24'),
	(29, 'Sub Admin 2', 1, 0, '2020-02-09 10:48:54', '2020-02-09 10:51:34'),
	(30, 'App View', 2, 1, '2020-02-09 11:37:38', '2020-02-09 11:59:25'),
	(31, 'General', 2, 1, '2020-02-18 14:01:17', '2020-02-18 14:01:17');
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_new_db.user_group_members: ~4 rows (approximately)
/*!40000 ALTER TABLE `user_group_members` DISABLE KEYS */;
INSERT INTO `user_group_members` (`id`, `emp_id`, `group_id`, `status`, `created_at`, `updated_at`) VALUES
	(1, 31, 25, 1, '2020-02-09 13:25:51', '2020-02-09 13:25:51'),
	(2, 1, 26, 1, '2020-02-09 13:27:08', '2020-02-18 11:51:05'),
	(3, 1, 25, 0, '2020-02-09 13:27:24', '2020-02-18 11:51:05'),
	(6, 31, 26, 0, '2020-02-09 13:42:22', '2020-02-09 13:42:22');
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
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_new_db.user_group_permissions: ~435 rows (approximately)
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
	(19, 26, 1, 1, '2020-02-08 11:39:02', '2020-03-03 17:28:05'),
	(20, 26, 2, 1, '2020-02-08 11:39:02', '2020-03-03 17:28:05'),
	(21, 26, 4, 1, '2020-02-08 11:39:02', '2020-03-03 17:28:05'),
	(22, 26, 6, 1, '2020-02-08 11:39:02', '2020-03-03 17:28:05'),
	(23, 26, 7, 1, '2020-02-08 11:39:02', '2020-03-03 17:28:05'),
	(24, 26, 8, 1, '2020-02-08 11:39:02', '2020-03-03 17:28:05'),
	(25, 26, 9, 1, '2020-02-08 11:39:02', '2020-03-03 17:28:05'),
	(26, 26, 10, 1, '2020-02-08 11:39:02', '2020-03-03 17:28:05'),
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
	(60, 26, 24, 1, '2020-02-17 13:46:51', '2020-03-03 17:28:05'),
	(61, 27, 24, 0, '2020-02-17 13:46:51', '2020-02-17 13:46:51'),
	(62, 28, 24, 0, '2020-02-17 13:46:51', '2020-02-17 13:46:51'),
	(63, 29, 24, 0, '2020-02-17 13:46:51', '2020-02-17 13:46:51'),
	(64, 30, 24, 0, '2020-02-17 13:46:51', '2020-02-17 13:46:51'),
	(65, 25, 25, 0, '2020-02-18 06:17:38', '2020-02-18 06:17:38'),
	(66, 26, 25, 1, '2020-02-18 06:17:38', '2020-03-03 17:28:05'),
	(67, 27, 25, 0, '2020-02-18 06:17:38', '2020-02-18 06:17:38'),
	(68, 28, 25, 0, '2020-02-18 06:17:38', '2020-02-18 06:17:38'),
	(69, 29, 25, 0, '2020-02-18 06:17:38', '2020-02-18 06:17:38'),
	(70, 30, 25, 0, '2020-02-18 06:17:38', '2020-02-18 06:17:38'),
	(71, 25, 26, 0, '2020-02-18 06:23:30', '2020-02-18 06:23:30'),
	(72, 26, 26, 1, '2020-02-18 06:23:30', '2020-03-03 17:28:05'),
	(73, 27, 26, 0, '2020-02-18 06:23:30', '2020-02-18 06:23:30'),
	(74, 28, 26, 0, '2020-02-18 06:23:30', '2020-02-18 06:23:30'),
	(75, 29, 26, 0, '2020-02-18 06:23:30', '2020-02-18 06:23:30'),
	(76, 30, 26, 0, '2020-02-18 06:23:30', '2020-02-18 06:23:30'),
	(77, 25, 27, 0, '2020-02-18 06:37:34', '2020-02-18 06:37:34'),
	(78, 26, 27, 1, '2020-02-18 06:37:34', '2020-03-03 17:28:05'),
	(79, 27, 27, 0, '2020-02-18 06:37:34', '2020-02-18 06:37:34'),
	(80, 28, 27, 0, '2020-02-18 06:37:34', '2020-02-18 06:37:34'),
	(81, 29, 27, 0, '2020-02-18 06:37:34', '2020-02-18 06:37:34'),
	(82, 30, 27, 0, '2020-02-18 06:37:34', '2020-02-18 06:37:34'),
	(83, 25, 28, 0, '2020-02-18 06:44:36', '2020-02-18 06:44:36'),
	(84, 26, 28, 1, '2020-02-18 06:44:36', '2020-03-03 17:28:05'),
	(85, 27, 28, 0, '2020-02-18 06:44:36', '2020-02-18 06:44:36'),
	(86, 28, 28, 0, '2020-02-18 06:44:36', '2020-02-18 06:44:36'),
	(87, 29, 28, 0, '2020-02-18 06:44:36', '2020-02-18 06:44:36'),
	(88, 30, 28, 0, '2020-02-18 06:44:36', '2020-02-18 06:44:36'),
	(89, 25, 29, 0, '2020-02-18 06:47:38', '2020-02-18 06:47:38'),
	(90, 26, 29, 1, '2020-02-18 06:47:38', '2020-03-03 17:28:05'),
	(91, 27, 29, 0, '2020-02-18 06:47:38', '2020-02-18 06:47:38'),
	(92, 28, 29, 0, '2020-02-18 06:47:38', '2020-02-18 06:47:38'),
	(93, 29, 29, 0, '2020-02-18 06:47:38', '2020-02-18 06:47:38'),
	(94, 30, 29, 0, '2020-02-18 06:47:38', '2020-02-18 06:47:38'),
	(95, 25, 30, 0, '2020-02-18 06:48:40', '2020-02-18 06:48:40'),
	(96, 26, 30, 1, '2020-02-18 06:48:40', '2020-03-03 17:28:05'),
	(97, 27, 30, 0, '2020-02-18 06:48:40', '2020-02-18 06:48:40'),
	(98, 28, 30, 0, '2020-02-18 06:48:40', '2020-02-18 06:48:40'),
	(99, 29, 30, 0, '2020-02-18 06:48:40', '2020-02-18 06:48:40'),
	(100, 30, 30, 0, '2020-02-18 06:48:40', '2020-02-18 06:48:40'),
	(101, 25, 31, 0, '2020-02-18 06:48:55', '2020-02-18 06:48:55'),
	(102, 26, 31, 1, '2020-02-18 06:48:55', '2020-03-03 17:28:05'),
	(103, 27, 31, 0, '2020-02-18 06:48:55', '2020-02-18 06:48:55'),
	(104, 28, 31, 0, '2020-02-18 06:48:55', '2020-02-18 06:48:55'),
	(105, 29, 31, 0, '2020-02-18 06:48:55', '2020-02-18 06:48:55'),
	(106, 30, 31, 0, '2020-02-18 06:48:55', '2020-02-18 06:48:55'),
	(107, 25, 32, 0, '2020-02-18 06:51:12', '2020-02-18 06:51:12'),
	(108, 26, 32, 1, '2020-02-18 06:51:12', '2020-03-03 17:28:05'),
	(109, 27, 32, 0, '2020-02-18 06:51:12', '2020-02-18 06:51:12'),
	(110, 28, 32, 0, '2020-02-18 06:51:12', '2020-02-18 06:51:12'),
	(111, 29, 32, 0, '2020-02-18 06:51:12', '2020-02-18 06:51:12'),
	(112, 30, 32, 0, '2020-02-18 06:51:12', '2020-02-18 06:51:12'),
	(113, 25, 33, 0, '2020-02-18 07:12:07', '2020-02-18 07:12:07'),
	(114, 26, 33, 1, '2020-02-18 07:12:07', '2020-03-03 17:28:05'),
	(115, 27, 33, 0, '2020-02-18 07:12:07', '2020-02-18 07:12:07'),
	(116, 28, 33, 0, '2020-02-18 07:12:07', '2020-02-18 07:12:07'),
	(117, 29, 33, 0, '2020-02-18 07:12:07', '2020-02-18 07:12:07'),
	(118, 30, 33, 0, '2020-02-18 07:12:07', '2020-02-18 07:12:07'),
	(119, 25, 34, 0, '2020-02-18 07:14:20', '2020-02-18 07:14:20'),
	(120, 26, 34, 1, '2020-02-18 07:14:20', '2020-03-03 17:28:05'),
	(121, 27, 34, 0, '2020-02-18 07:14:20', '2020-02-18 07:14:20'),
	(122, 28, 34, 0, '2020-02-18 07:14:20', '2020-02-18 07:14:20'),
	(123, 29, 34, 0, '2020-02-18 07:14:20', '2020-02-18 07:14:20'),
	(124, 30, 34, 0, '2020-02-18 07:14:20', '2020-02-18 07:14:20'),
	(125, 25, 35, 0, '2020-02-18 07:34:40', '2020-02-18 07:34:40'),
	(126, 26, 35, 1, '2020-02-18 07:34:40', '2020-03-03 17:28:05'),
	(127, 27, 35, 0, '2020-02-18 07:34:40', '2020-02-18 07:34:40'),
	(128, 28, 35, 0, '2020-02-18 07:34:40', '2020-02-18 07:34:40'),
	(129, 29, 35, 0, '2020-02-18 07:34:40', '2020-02-18 07:34:40'),
	(130, 30, 35, 0, '2020-02-18 07:34:40', '2020-02-18 07:34:40'),
	(131, 25, 36, 0, '2020-02-18 07:36:01', '2020-02-18 07:36:01'),
	(132, 26, 36, 1, '2020-02-18 07:36:01', '2020-03-03 17:28:05'),
	(133, 27, 36, 0, '2020-02-18 07:36:01', '2020-02-18 07:36:01'),
	(134, 28, 36, 0, '2020-02-18 07:36:01', '2020-02-18 07:36:01'),
	(135, 29, 36, 0, '2020-02-18 07:36:01', '2020-02-18 07:36:01'),
	(136, 30, 36, 0, '2020-02-18 07:36:01', '2020-02-18 07:36:01'),
	(137, 25, 37, 0, '2020-02-18 07:46:54', '2020-02-18 07:46:54'),
	(138, 26, 37, 1, '2020-02-18 07:46:54', '2020-03-03 17:28:05'),
	(139, 27, 37, 0, '2020-02-18 07:46:54', '2020-02-18 07:46:54'),
	(140, 28, 37, 0, '2020-02-18 07:46:54', '2020-02-18 07:46:54'),
	(141, 29, 37, 0, '2020-02-18 07:46:54', '2020-02-18 07:46:54'),
	(142, 30, 37, 0, '2020-02-18 07:46:54', '2020-02-18 07:46:54'),
	(143, 25, 38, 0, '2020-02-18 07:47:10', '2020-02-18 07:47:10'),
	(144, 26, 38, 1, '2020-02-18 07:47:10', '2020-03-03 17:28:05'),
	(145, 27, 38, 0, '2020-02-18 07:47:10', '2020-02-18 07:47:10'),
	(146, 28, 38, 0, '2020-02-18 07:47:10', '2020-02-18 07:47:10'),
	(147, 29, 38, 0, '2020-02-18 07:47:10', '2020-02-18 07:47:10'),
	(148, 30, 38, 0, '2020-02-18 07:47:10', '2020-02-18 07:47:10'),
	(149, 25, 39, 0, '2020-02-18 08:21:39', '2020-02-18 08:21:39'),
	(150, 26, 39, 1, '2020-02-18 08:21:39', '2020-03-03 17:28:05'),
	(151, 27, 39, 0, '2020-02-18 08:21:39', '2020-02-18 08:21:39'),
	(152, 28, 39, 0, '2020-02-18 08:21:39', '2020-02-18 08:21:39'),
	(153, 29, 39, 0, '2020-02-18 08:21:39', '2020-02-18 08:21:39'),
	(154, 30, 39, 0, '2020-02-18 08:21:39', '2020-02-18 08:21:39'),
	(155, 25, 40, 0, '2020-02-18 08:26:01', '2020-02-18 08:26:01'),
	(156, 26, 40, 1, '2020-02-18 08:26:01', '2020-03-03 17:28:05'),
	(157, 27, 40, 0, '2020-02-18 08:26:01', '2020-02-18 08:26:01'),
	(158, 28, 40, 0, '2020-02-18 08:26:01', '2020-02-18 08:26:01'),
	(159, 29, 40, 0, '2020-02-18 08:26:01', '2020-02-18 08:26:01'),
	(160, 30, 40, 0, '2020-02-18 08:26:01', '2020-02-18 08:26:01'),
	(161, 25, 41, 0, '2020-02-18 08:37:37', '2020-02-18 08:37:37'),
	(162, 26, 41, 1, '2020-02-18 08:37:37', '2020-03-03 17:28:05'),
	(163, 27, 41, 0, '2020-02-18 08:37:37', '2020-02-18 08:37:37'),
	(164, 28, 41, 0, '2020-02-18 08:37:37', '2020-02-18 08:37:37'),
	(165, 29, 41, 0, '2020-02-18 08:37:37', '2020-02-18 08:37:37'),
	(166, 30, 41, 0, '2020-02-18 08:37:37', '2020-02-18 08:37:37'),
	(167, 25, 42, 0, '2020-02-18 08:49:36', '2020-02-18 08:49:36'),
	(168, 26, 42, 1, '2020-02-18 08:49:36', '2020-03-03 17:28:05'),
	(169, 27, 42, 0, '2020-02-18 08:49:36', '2020-02-18 08:49:36'),
	(170, 28, 42, 0, '2020-02-18 08:49:36', '2020-02-18 08:49:36'),
	(171, 29, 42, 0, '2020-02-18 08:49:36', '2020-02-18 08:49:36'),
	(172, 30, 42, 0, '2020-02-18 08:49:36', '2020-02-18 08:49:36'),
	(173, 25, 43, 0, '2020-02-18 08:49:48', '2020-02-18 08:49:48'),
	(174, 26, 43, 1, '2020-02-18 08:49:48', '2020-03-03 17:28:05'),
	(175, 27, 43, 0, '2020-02-18 08:49:48', '2020-02-18 08:49:48'),
	(176, 28, 43, 0, '2020-02-18 08:49:48', '2020-02-18 08:49:48'),
	(177, 29, 43, 0, '2020-02-18 08:49:48', '2020-02-18 08:49:48'),
	(178, 30, 43, 0, '2020-02-18 08:49:48', '2020-02-18 08:49:48'),
	(179, 25, 44, 0, '2020-02-18 09:02:37', '2020-02-18 09:02:37'),
	(180, 26, 44, 1, '2020-02-18 09:02:37', '2020-03-03 17:28:05'),
	(181, 27, 44, 0, '2020-02-18 09:02:38', '2020-02-18 09:02:38'),
	(182, 28, 44, 0, '2020-02-18 09:02:38', '2020-02-18 09:02:38'),
	(183, 29, 44, 0, '2020-02-18 09:02:38', '2020-02-18 09:02:38'),
	(184, 30, 44, 0, '2020-02-18 09:02:38', '2020-02-18 09:02:38'),
	(185, 25, 45, 0, '2020-02-18 09:02:55', '2020-02-18 09:02:55'),
	(186, 26, 45, 1, '2020-02-18 09:02:55', '2020-03-03 17:28:05'),
	(187, 27, 45, 0, '2020-02-18 09:02:55', '2020-02-18 09:02:55'),
	(188, 28, 45, 0, '2020-02-18 09:02:55', '2020-02-18 09:02:55'),
	(189, 29, 45, 0, '2020-02-18 09:02:55', '2020-02-18 09:02:55'),
	(190, 30, 45, 0, '2020-02-18 09:02:55', '2020-02-18 09:02:55'),
	(191, 25, 46, 0, '2020-02-18 09:03:06', '2020-02-18 09:03:06'),
	(192, 26, 46, 1, '2020-02-18 09:03:06', '2020-03-03 17:28:05'),
	(193, 27, 46, 0, '2020-02-18 09:03:06', '2020-02-18 09:03:06'),
	(194, 28, 46, 0, '2020-02-18 09:03:06', '2020-02-18 09:03:06'),
	(195, 29, 46, 0, '2020-02-18 09:03:06', '2020-02-18 09:03:06'),
	(196, 30, 46, 0, '2020-02-18 09:03:06', '2020-02-18 09:03:06'),
	(197, 25, 47, 0, '2020-02-18 09:03:18', '2020-02-18 09:03:18'),
	(198, 26, 47, 1, '2020-02-18 09:03:18', '2020-03-03 17:28:05'),
	(199, 27, 47, 0, '2020-02-18 09:03:18', '2020-02-18 09:03:18'),
	(200, 28, 47, 0, '2020-02-18 09:03:18', '2020-02-18 09:03:18'),
	(201, 29, 47, 0, '2020-02-18 09:03:18', '2020-02-18 09:03:18'),
	(202, 30, 47, 0, '2020-02-18 09:03:18', '2020-02-18 09:03:18'),
	(203, 25, 48, 0, '2020-02-18 09:13:35', '2020-02-18 09:13:35'),
	(204, 26, 48, 1, '2020-02-18 09:13:35', '2020-03-03 17:28:05'),
	(205, 27, 48, 0, '2020-02-18 09:13:36', '2020-02-18 09:13:36'),
	(206, 28, 48, 0, '2020-02-18 09:13:36', '2020-02-18 09:13:36'),
	(207, 29, 48, 0, '2020-02-18 09:13:36', '2020-02-18 09:13:36'),
	(208, 30, 48, 0, '2020-02-18 09:13:36', '2020-02-18 09:13:36'),
	(209, 25, 49, 0, '2020-02-18 09:14:00', '2020-02-18 09:14:00'),
	(210, 26, 49, 1, '2020-02-18 09:14:00', '2020-03-03 17:28:05'),
	(211, 27, 49, 0, '2020-02-18 09:14:00', '2020-02-18 09:14:00'),
	(212, 28, 49, 0, '2020-02-18 09:14:00', '2020-02-18 09:14:00'),
	(213, 29, 49, 0, '2020-02-18 09:14:00', '2020-02-18 09:14:00'),
	(214, 30, 49, 0, '2020-02-18 09:14:00', '2020-02-18 09:14:00'),
	(215, 25, 50, 0, '2020-02-18 09:14:15', '2020-02-18 09:14:15'),
	(216, 26, 50, 1, '2020-02-18 09:14:15', '2020-03-03 17:28:05'),
	(217, 27, 50, 0, '2020-02-18 09:14:15', '2020-02-18 09:14:15'),
	(218, 28, 50, 0, '2020-02-18 09:14:15', '2020-02-18 09:14:15'),
	(219, 29, 50, 0, '2020-02-18 09:14:15', '2020-02-18 09:14:15'),
	(220, 30, 50, 0, '2020-02-18 09:14:15', '2020-02-18 09:14:15'),
	(221, 25, 51, 0, '2020-02-18 09:14:26', '2020-02-18 09:14:26'),
	(222, 26, 51, 1, '2020-02-18 09:14:26', '2020-03-03 17:28:05'),
	(223, 27, 51, 0, '2020-02-18 09:14:26', '2020-02-18 09:14:26'),
	(224, 28, 51, 0, '2020-02-18 09:14:26', '2020-02-18 09:14:26'),
	(225, 29, 51, 0, '2020-02-18 09:14:26', '2020-02-18 09:14:26'),
	(226, 30, 51, 0, '2020-02-18 09:14:26', '2020-02-18 09:14:26'),
	(227, 25, 52, 0, '2020-02-18 09:25:01', '2020-02-18 09:25:01'),
	(228, 26, 52, 1, '2020-02-18 09:25:01', '2020-03-03 17:28:05'),
	(229, 27, 52, 0, '2020-02-18 09:25:01', '2020-02-18 09:25:01'),
	(230, 28, 52, 0, '2020-02-18 09:25:01', '2020-02-18 09:25:01'),
	(231, 29, 52, 0, '2020-02-18 09:25:01', '2020-02-18 09:25:01'),
	(232, 30, 52, 0, '2020-02-18 09:25:01', '2020-02-18 09:25:01'),
	(233, 25, 53, 0, '2020-02-18 09:25:15', '2020-02-18 09:25:15'),
	(234, 26, 53, 1, '2020-02-18 09:25:15', '2020-03-03 17:28:05'),
	(235, 27, 53, 0, '2020-02-18 09:25:15', '2020-02-18 09:25:15'),
	(236, 28, 53, 0, '2020-02-18 09:25:15', '2020-02-18 09:25:15'),
	(237, 29, 53, 0, '2020-02-18 09:25:15', '2020-02-18 09:25:15'),
	(238, 30, 53, 0, '2020-02-18 09:25:15', '2020-02-18 09:25:15'),
	(239, 25, 54, 0, '2020-02-18 09:25:30', '2020-02-18 09:25:30'),
	(240, 26, 54, 1, '2020-02-18 09:25:30', '2020-03-03 17:28:05'),
	(241, 27, 54, 0, '2020-02-18 09:25:30', '2020-02-18 09:25:30'),
	(242, 28, 54, 0, '2020-02-18 09:25:30', '2020-02-18 09:25:30'),
	(243, 29, 54, 0, '2020-02-18 09:25:30', '2020-02-18 09:25:30'),
	(244, 30, 54, 0, '2020-02-18 09:25:30', '2020-02-18 09:25:30'),
	(245, 25, 55, 0, '2020-02-18 09:25:43', '2020-02-18 09:25:43'),
	(246, 26, 55, 1, '2020-02-18 09:25:43', '2020-03-03 17:28:05'),
	(247, 27, 55, 0, '2020-02-18 09:25:43', '2020-02-18 09:25:43'),
	(248, 28, 55, 0, '2020-02-18 09:25:43', '2020-02-18 09:25:43'),
	(249, 29, 55, 0, '2020-02-18 09:25:43', '2020-02-18 09:25:43'),
	(250, 30, 55, 0, '2020-02-18 09:25:43', '2020-02-18 09:25:43'),
	(251, 25, 56, 0, '2020-02-18 09:32:33', '2020-02-18 09:32:33'),
	(252, 26, 56, 1, '2020-02-18 09:32:33', '2020-03-03 17:28:05'),
	(253, 27, 56, 0, '2020-02-18 09:32:34', '2020-02-18 09:32:34'),
	(254, 28, 56, 0, '2020-02-18 09:32:34', '2020-02-18 09:32:34'),
	(255, 29, 56, 0, '2020-02-18 09:32:34', '2020-02-18 09:32:34'),
	(256, 30, 56, 0, '2020-02-18 09:32:34', '2020-02-18 09:32:34'),
	(257, 25, 57, 0, '2020-02-18 09:32:46', '2020-02-18 09:32:46'),
	(258, 26, 57, 1, '2020-02-18 09:32:46', '2020-03-03 17:28:05'),
	(259, 27, 57, 0, '2020-02-18 09:32:46', '2020-02-18 09:32:46'),
	(260, 28, 57, 0, '2020-02-18 09:32:46', '2020-02-18 09:32:46'),
	(261, 29, 57, 0, '2020-02-18 09:32:46', '2020-02-18 09:32:46'),
	(262, 30, 57, 0, '2020-02-18 09:32:46', '2020-02-18 09:32:46'),
	(263, 25, 58, 0, '2020-02-18 09:32:55', '2020-02-18 09:32:55'),
	(264, 26, 58, 1, '2020-02-18 09:32:55', '2020-03-03 17:28:05'),
	(265, 27, 58, 0, '2020-02-18 09:32:56', '2020-02-18 09:32:56'),
	(266, 28, 58, 0, '2020-02-18 09:32:56', '2020-02-18 09:32:56'),
	(267, 29, 58, 0, '2020-02-18 09:32:56', '2020-02-18 09:32:56'),
	(268, 30, 58, 0, '2020-02-18 09:32:56', '2020-02-18 09:32:56'),
	(269, 25, 59, 0, '2020-02-18 09:33:07', '2020-02-18 09:33:07'),
	(270, 26, 59, 1, '2020-02-18 09:33:07', '2020-03-03 17:28:05'),
	(271, 27, 59, 0, '2020-02-18 09:33:07', '2020-02-18 09:33:07'),
	(272, 28, 59, 0, '2020-02-18 09:33:07', '2020-02-18 09:33:07'),
	(273, 29, 59, 0, '2020-02-18 09:33:07', '2020-02-18 09:33:07'),
	(274, 30, 59, 0, '2020-02-18 09:33:07', '2020-02-18 09:33:07'),
	(275, 25, 60, 0, '2020-02-18 09:39:22', '2020-02-18 09:39:22'),
	(276, 26, 60, 1, '2020-02-18 09:39:22', '2020-03-03 17:28:05'),
	(277, 27, 60, 0, '2020-02-18 09:39:23', '2020-02-18 09:39:23'),
	(278, 28, 60, 0, '2020-02-18 09:39:23', '2020-02-18 09:39:23'),
	(279, 29, 60, 0, '2020-02-18 09:39:23', '2020-02-18 09:39:23'),
	(280, 30, 60, 0, '2020-02-18 09:39:23', '2020-02-18 09:39:23'),
	(281, 25, 61, 0, '2020-02-18 09:39:33', '2020-02-18 09:39:33'),
	(282, 26, 61, 1, '2020-02-18 09:39:33', '2020-03-03 17:28:05'),
	(283, 27, 61, 0, '2020-02-18 09:39:33', '2020-02-18 09:39:33'),
	(284, 28, 61, 0, '2020-02-18 09:39:33', '2020-02-18 09:39:33'),
	(285, 29, 61, 0, '2020-02-18 09:39:33', '2020-02-18 09:39:33'),
	(286, 30, 61, 0, '2020-02-18 09:39:33', '2020-02-18 09:39:33'),
	(287, 25, 62, 0, '2020-02-18 09:39:44', '2020-02-18 09:39:44'),
	(288, 26, 62, 1, '2020-02-18 09:39:44', '2020-03-03 17:28:05'),
	(289, 27, 62, 0, '2020-02-18 09:39:44', '2020-02-18 09:39:44'),
	(290, 28, 62, 0, '2020-02-18 09:39:44', '2020-02-18 09:39:44'),
	(291, 29, 62, 0, '2020-02-18 09:39:44', '2020-02-18 09:39:44'),
	(292, 30, 62, 0, '2020-02-18 09:39:44', '2020-02-18 09:39:44'),
	(293, 25, 63, 0, '2020-02-18 09:40:00', '2020-02-18 09:40:00'),
	(294, 26, 63, 1, '2020-02-18 09:40:00', '2020-03-03 17:28:05'),
	(295, 27, 63, 0, '2020-02-18 09:40:00', '2020-02-18 09:40:00'),
	(296, 28, 63, 0, '2020-02-18 09:40:00', '2020-02-18 09:40:00'),
	(297, 29, 63, 0, '2020-02-18 09:40:00', '2020-02-18 09:40:00'),
	(298, 30, 63, 0, '2020-02-18 09:40:00', '2020-02-18 09:40:00'),
	(299, 25, 64, 0, '2020-02-18 11:23:13', '2020-02-18 11:23:13'),
	(300, 26, 64, 1, '2020-02-18 11:23:13', '2020-03-03 17:28:05'),
	(301, 27, 64, 0, '2020-02-18 11:23:13', '2020-02-18 11:23:13'),
	(302, 28, 64, 0, '2020-02-18 11:23:13', '2020-02-18 11:23:13'),
	(303, 29, 64, 0, '2020-02-18 11:23:13', '2020-02-18 11:23:13'),
	(304, 30, 64, 0, '2020-02-18 11:23:13', '2020-02-18 11:23:13'),
	(305, 25, 65, 0, '2020-02-18 11:38:26', '2020-02-18 11:38:26'),
	(306, 26, 65, 1, '2020-02-18 11:38:26', '2020-03-03 17:28:05'),
	(307, 27, 65, 0, '2020-02-18 11:38:26', '2020-02-18 11:38:26'),
	(308, 28, 65, 0, '2020-02-18 11:38:26', '2020-02-18 11:38:26'),
	(309, 29, 65, 0, '2020-02-18 11:38:26', '2020-02-18 11:38:26'),
	(310, 30, 65, 0, '2020-02-18 11:38:26', '2020-02-18 11:38:26'),
	(311, 25, 66, 0, '2020-02-18 11:38:38', '2020-02-18 11:38:38'),
	(312, 26, 66, 1, '2020-02-18 11:38:38', '2020-03-03 17:28:05'),
	(313, 27, 66, 0, '2020-02-18 11:38:38', '2020-02-18 11:38:38'),
	(314, 28, 66, 0, '2020-02-18 11:38:38', '2020-02-18 11:38:38'),
	(315, 29, 66, 0, '2020-02-18 11:38:38', '2020-02-18 11:38:38'),
	(316, 30, 66, 0, '2020-02-18 11:38:38', '2020-02-18 11:38:38'),
	(317, 25, 67, 0, '2020-02-18 11:38:50', '2020-02-18 11:38:50'),
	(318, 26, 67, 1, '2020-02-18 11:38:50', '2020-03-03 17:28:05'),
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
	(376, 26, 68, 1, '2020-02-22 10:02:39', '2020-03-03 17:28:05'),
	(377, 27, 68, 0, '2020-02-22 10:02:39', '2020-02-22 10:02:39'),
	(378, 28, 68, 0, '2020-02-22 10:02:39', '2020-02-22 10:02:39'),
	(379, 29, 68, 0, '2020-02-22 10:02:39', '2020-02-22 10:02:39'),
	(380, 30, 68, 0, '2020-02-22 10:02:39', '2020-02-22 10:02:39'),
	(381, 31, 68, 0, '2020-02-22 10:02:39', '2020-02-22 10:02:39'),
	(382, 25, 69, 0, '2020-02-22 10:06:07', '2020-02-22 10:06:07'),
	(383, 26, 69, 1, '2020-02-22 10:06:07', '2020-03-03 17:28:05'),
	(384, 27, 69, 0, '2020-02-22 10:06:07', '2020-02-22 10:06:07'),
	(385, 28, 69, 0, '2020-02-22 10:06:07', '2020-02-22 10:06:07'),
	(386, 29, 69, 0, '2020-02-22 10:06:07', '2020-02-22 10:06:07'),
	(387, 30, 69, 0, '2020-02-22 10:06:07', '2020-02-22 10:06:07'),
	(388, 31, 69, 0, '2020-02-22 10:06:07', '2020-02-22 10:06:07'),
	(389, 25, 70, 0, '2020-02-22 10:06:25', '2020-02-22 10:06:25'),
	(390, 26, 70, 1, '2020-02-22 10:06:25', '2020-03-03 17:28:05'),
	(391, 27, 70, 0, '2020-02-22 10:06:25', '2020-02-22 10:06:25'),
	(392, 28, 70, 0, '2020-02-22 10:06:25', '2020-02-22 10:06:25'),
	(393, 29, 70, 0, '2020-02-22 10:06:25', '2020-02-22 10:06:25'),
	(394, 30, 70, 0, '2020-02-22 10:06:25', '2020-02-22 10:06:25'),
	(395, 31, 70, 0, '2020-02-22 10:06:25', '2020-02-22 10:06:25'),
	(396, 25, 71, 0, '2020-02-22 10:06:50', '2020-02-22 10:06:50'),
	(397, 26, 71, 1, '2020-02-22 10:06:50', '2020-03-03 17:28:05'),
	(398, 27, 71, 0, '2020-02-22 10:06:50', '2020-02-22 10:06:50'),
	(399, 28, 71, 0, '2020-02-22 10:06:50', '2020-02-22 10:06:50'),
	(400, 29, 71, 0, '2020-02-22 10:06:50', '2020-02-22 10:06:50'),
	(401, 30, 71, 0, '2020-02-22 10:06:50', '2020-02-22 10:06:50'),
	(402, 31, 71, 0, '2020-02-22 10:06:50', '2020-02-22 10:06:50'),
	(403, 25, 72, 0, '2020-02-29 06:45:50', '2020-02-29 06:45:50'),
	(404, 26, 72, 1, '2020-02-29 06:45:50', '2020-03-03 17:28:05'),
	(405, 27, 72, 0, '2020-02-29 06:45:50', '2020-02-29 06:45:50'),
	(406, 28, 72, 0, '2020-02-29 06:45:50', '2020-02-29 06:45:50'),
	(407, 29, 72, 0, '2020-02-29 06:45:50', '2020-02-29 06:45:50'),
	(408, 30, 72, 0, '2020-02-29 06:45:50', '2020-02-29 06:45:50'),
	(409, 31, 72, 0, '2020-02-29 06:45:50', '2020-02-29 06:45:50'),
	(410, 25, 73, 0, '2020-02-29 06:46:46', '2020-02-29 06:46:46'),
	(411, 26, 73, 1, '2020-02-29 06:46:46', '2020-03-03 17:28:05'),
	(412, 27, 73, 0, '2020-02-29 06:46:46', '2020-02-29 06:46:46'),
	(413, 28, 73, 0, '2020-02-29 06:46:46', '2020-02-29 06:46:46'),
	(414, 29, 73, 0, '2020-02-29 06:46:46', '2020-02-29 06:46:46'),
	(415, 30, 73, 0, '2020-02-29 06:46:46', '2020-02-29 06:46:46'),
	(416, 31, 73, 0, '2020-02-29 06:46:46', '2020-02-29 06:46:46'),
	(417, 25, 74, 0, '2020-02-29 06:46:56', '2020-02-29 06:46:56'),
	(418, 26, 74, 1, '2020-02-29 06:46:56', '2020-03-03 17:28:05'),
	(419, 27, 74, 0, '2020-02-29 06:46:56', '2020-02-29 06:46:56'),
	(420, 28, 74, 0, '2020-02-29 06:46:56', '2020-02-29 06:46:56'),
	(421, 29, 74, 0, '2020-02-29 06:46:56', '2020-02-29 06:46:56'),
	(422, 30, 74, 0, '2020-02-29 06:46:56', '2020-02-29 06:46:56'),
	(423, 31, 74, 0, '2020-02-29 06:46:56', '2020-02-29 06:46:56'),
	(424, 25, 75, 0, '2020-02-29 06:47:04', '2020-02-29 06:47:04'),
	(425, 26, 75, 1, '2020-02-29 06:47:04', '2020-03-03 17:28:05'),
	(426, 27, 75, 0, '2020-02-29 06:47:04', '2020-02-29 06:47:04'),
	(427, 28, 75, 0, '2020-02-29 06:47:04', '2020-02-29 06:47:04'),
	(428, 29, 75, 0, '2020-02-29 06:47:04', '2020-02-29 06:47:04'),
	(429, 30, 75, 0, '2020-02-29 06:47:04', '2020-02-29 06:47:04'),
	(430, 31, 75, 0, '2020-02-29 06:47:04', '2020-02-29 06:47:04'),
	(431, 25, 76, 0, '2020-03-02 09:25:05', '2020-03-02 09:25:05'),
	(432, 26, 76, 1, '2020-03-02 09:25:05', '2020-03-03 17:28:05'),
	(433, 27, 76, 0, '2020-03-02 09:25:05', '2020-03-02 09:25:05'),
	(434, 28, 76, 0, '2020-03-02 09:25:05', '2020-03-02 09:25:05'),
	(435, 29, 76, 0, '2020-03-02 09:25:05', '2020-03-02 09:25:05'),
	(436, 30, 76, 0, '2020-03-02 09:25:05', '2020-03-02 09:25:05'),
	(437, 31, 76, 0, '2020-03-02 09:25:05', '2020-03-02 09:25:05'),
	(438, 25, 77, 0, '2020-03-02 09:25:28', '2020-03-02 09:25:28'),
	(439, 26, 77, 1, '2020-03-02 09:25:28', '2020-03-03 17:28:05'),
	(440, 27, 77, 0, '2020-03-02 09:25:28', '2020-03-02 09:25:28'),
	(441, 28, 77, 0, '2020-03-02 09:25:28', '2020-03-02 09:25:28'),
	(442, 29, 77, 0, '2020-03-02 09:25:28', '2020-03-02 09:25:28'),
	(443, 30, 77, 0, '2020-03-02 09:25:28', '2020-03-02 09:25:28'),
	(444, 31, 77, 0, '2020-03-02 09:25:28', '2020-03-02 09:25:28'),
	(473, 25, 82, 0, '2020-03-03 11:25:01', '2020-03-03 11:25:01'),
	(474, 26, 82, 1, '2020-03-03 11:25:01', '2020-03-03 17:28:05'),
	(475, 27, 82, 0, '2020-03-03 11:25:01', '2020-03-03 11:25:01'),
	(476, 28, 82, 0, '2020-03-03 11:25:01', '2020-03-03 11:25:01'),
	(477, 29, 82, 0, '2020-03-03 11:25:01', '2020-03-03 11:25:01'),
	(478, 30, 82, 0, '2020-03-03 11:25:01', '2020-03-03 11:25:01'),
	(479, 31, 82, 0, '2020-03-03 11:25:01', '2020-03-03 11:25:01'),
	(480, 25, 83, 0, '2020-03-03 11:25:10', '2020-03-03 11:25:10'),
	(481, 26, 83, 1, '2020-03-03 11:25:10', '2020-03-03 17:28:05'),
	(482, 27, 83, 0, '2020-03-03 11:25:10', '2020-03-03 11:25:10'),
	(483, 28, 83, 0, '2020-03-03 11:25:10', '2020-03-03 11:25:10'),
	(484, 29, 83, 0, '2020-03-03 11:25:10', '2020-03-03 11:25:10'),
	(485, 30, 83, 0, '2020-03-03 11:25:10', '2020-03-03 11:25:10'),
	(486, 31, 83, 0, '2020-03-03 11:25:10', '2020-03-03 11:25:10'),
	(487, 25, 84, 0, '2020-03-03 11:25:19', '2020-03-03 11:25:19'),
	(488, 26, 84, 1, '2020-03-03 11:25:19', '2020-03-03 17:28:05'),
	(489, 27, 84, 0, '2020-03-03 11:25:19', '2020-03-03 11:25:19'),
	(490, 28, 84, 0, '2020-03-03 11:25:19', '2020-03-03 11:25:19'),
	(491, 29, 84, 0, '2020-03-03 11:25:19', '2020-03-03 11:25:19'),
	(492, 30, 84, 0, '2020-03-03 11:25:19', '2020-03-03 11:25:19'),
	(493, 31, 84, 0, '2020-03-03 11:25:19', '2020-03-03 11:25:19'),
	(494, 25, 85, 0, '2020-03-03 11:25:29', '2020-03-03 11:25:29'),
	(495, 26, 85, 1, '2020-03-03 11:25:29', '2020-03-03 17:28:05'),
	(496, 27, 85, 0, '2020-03-03 11:25:29', '2020-03-03 11:25:29'),
	(497, 28, 85, 0, '2020-03-03 11:25:29', '2020-03-03 11:25:29'),
	(498, 29, 85, 0, '2020-03-03 11:25:29', '2020-03-03 11:25:29'),
	(499, 30, 85, 0, '2020-03-03 11:25:29', '2020-03-03 11:25:29'),
	(500, 31, 85, 0, '2020-03-03 11:25:29', '2020-03-03 11:25:29');
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
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_new_db.web_actions: ~65 rows (approximately)
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
	(85, 'Message Category Delete', 26, 1, '2020-03-03 11:25:29', '2020-03-03 11:25:29');
/*!40000 ALTER TABLE `web_actions` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
