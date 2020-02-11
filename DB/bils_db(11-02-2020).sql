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

-- Dumping structure for table bils_db.app_users
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
  `created_at` varchar(50) DEFAULT current_timestamp(),
  `updated_at` varchar(50) DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.app_users: ~1 rows (approximately)
/*!40000 ALTER TABLE `app_users` DISABLE KEYS */;
INSERT INTO `app_users` (`id`, `name`, `nid_no`, `contact_no`, `email`, `address`, `password`, `user_profile_image`, `remarks`, `status`, `user_type`, `created_at`, `updated_at`) VALUES
	(5, 'Sazzadur', '123', '123', 'sazzadur@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, 2, '2020-02-10 09:12:29', '2020-02-11 12:47:09');
/*!40000 ALTER TABLE `app_users` ENABLE KEYS */;

-- Dumping structure for table bils_db.app_user_group_members
CREATE TABLE IF NOT EXISTS `app_user_group_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0 : no access, 1 : access',
  `created_at` varchar(50) DEFAULT current_timestamp(),
  `updated_at` varchar(50) DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 2` (`group_id`,`app_user_id`),
  KEY `FK_app_user_group_members_app_users` (`app_user_id`),
  CONSTRAINT `FK_app_user_group_members_app_users` FOREIGN KEY (`app_user_id`) REFERENCES `app_users` (`id`),
  CONSTRAINT `FK_app_user_group_members_user_groups` FOREIGN KEY (`group_id`) REFERENCES `user_groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.app_user_group_members: ~2 rows (approximately)
/*!40000 ALTER TABLE `app_user_group_members` DISABLE KEYS */;
INSERT INTO `app_user_group_members` (`id`, `app_user_id`, `group_id`, `status`, `created_at`, `updated_at`) VALUES
	(1, 5, 30, 1, '2020-02-10 09:12:29', '2020-02-10 09:12:29'),
	(2, 5, 27, 1, '2020-02-10 09:48:22', '2020-02-10 09:48:22');
/*!40000 ALTER TABLE `app_user_group_members` ENABLE KEYS */;

-- Dumping structure for table bils_db.course_categories
CREATE TABLE IF NOT EXISTS `course_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0: In-active, 1: Active',
  `created_at` varchar(30) DEFAULT current_timestamp(),
  `updated_at` varchar(30) DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.course_categories: ~1 rows (approximately)
/*!40000 ALTER TABLE `course_categories` DISABLE KEYS */;
INSERT INTO `course_categories` (`id`, `category_name`, `details`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Math', 'Basic Math Will Here', 1, '2020-02-11 06:19:33', '2020-02-11 07:10:45');
/*!40000 ALTER TABLE `course_categories` ENABLE KEYS */;

-- Dumping structure for table bils_db.course_masters
CREATE TABLE IF NOT EXISTS `course_masters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_title` varchar(100) NOT NULL,
  `duration` int(11) NOT NULL,
  `appx_start_time` varchar(50) NOT NULL,
  `appx_end_time` varchar(50) NOT NULL,
  `act_start_time` varchar(50) NOT NULL,
  `act_end_time` varchar(50) NOT NULL,
  `course_type` tinyint(1) NOT NULL COMMENT 'from course categories table',
  `course_teacher` int(11) NOT NULL COMMENT 'form teacher table',
  `course_responsible_person` varchar(15) NOT NULL DEFAULT 'admin',
  `details` text DEFAULT NULL,
  `course_status` tinyint(1) DEFAULT NULL COMMENT '1: Initiate, 2: Valid, 3: Rejected, 4: Started, 5: Completed',
  `payment_fee` double NOT NULL,
  `payment_method` tinyint(1) NOT NULL COMMENT 'from paymet_methods table',
  `discount_message` text NOT NULL,
  `Column 16` text NOT NULL,
  `attachment` varchar(50) NOT NULL,
  `pub_status` tinyint(1) NOT NULL COMMENT '0: Not-published, 1: Published',
  `created_by` varchar(20) NOT NULL,
  `updated_by` varchar(20) NOT NULL,
  `created_at` varchar(20) NOT NULL DEFAULT current_timestamp(),
  `updated_at` varchar(20) NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.course_masters: ~0 rows (approximately)
/*!40000 ALTER TABLE `course_masters` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_masters` ENABLE KEYS */;

-- Dumping structure for table bils_db.course_perticipants
CREATE TABLE IF NOT EXISTS `course_perticipants` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `perticipant_id` int(11) NOT NULL,
  `is_interested` tinyint(1) NOT NULL COMMENT '0: Not-interested, 1: Interested',
  `is_selected` tinyint(1) NOT NULL COMMENT '0: Not-selected, 1: Selected',
  `status` tinyint(1) NOT NULL COMMENT '1: Active, 2: Removed',
  `created_at` varchar(50) NOT NULL DEFAULT current_timestamp(),
  `updated_at` varchar(50) NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.course_perticipants: ~0 rows (approximately)
/*!40000 ALTER TABLE `course_perticipants` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_perticipants` ENABLE KEYS */;

-- Dumping structure for table bils_db.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8_unicode_ci NOT NULL,
  `queue` text COLLATE utf8_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_db.failed_jobs: ~0 rows (approximately)
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Dumping structure for table bils_db.jobs
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

-- Dumping data for table bils_db.jobs: ~0 rows (approximately)
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dumping structure for table bils_db.menus
CREATE TABLE IF NOT EXISTS `menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `menu_title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `menu_url` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT 0,
  `serial_no` int(11) DEFAULT NULL,
  `menu_icon_class` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1:active, 0:inactive',
  `created_at` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT current_timestamp(),
  `updated_at` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_db.menus: ~21 rows (approximately)
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` (`id`, `module_name`, `menu_title`, `menu_url`, `parent_id`, `serial_no`, `menu_icon_class`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'User', 'Users', '', 0, 1, 'clip-user-plus', 1, '', '2020-02-04 11:46:09'),
	(2, 'User', 'Admin Users', 'user/admin/admin-user-management', 1, 1, NULL, 1, '', '2020-02-04 12:09:48'),
	(4, 'User', 'App Users', 'user/app-user/app-user-management', 1, 3, NULL, 1, '', '2020-02-04 12:28:13'),
	(6, 'Surveys', 'Surveys', 'survey/management', 0, 3, 'clip-note', 1, '', '2020-02-04 12:28:13'),
	(7, 'Courses', 'Courses', '', 0, 2, 'clip-book', 1, '', '2020-02-04 12:28:13'),
	(8, 'Courses', 'Open Courses', 'courses/open-course', 7, 1, NULL, 1, '', '2020-02-04 12:28:13'),
	(10, 'Cpanel', 'Control Panel', '', 0, NULL, 'clip-settings', 1, '', '2020-02-04 12:28:13'),
	(11, 'Cpanel', 'General Setting', 'cp/general/general-setting', 10, NULL, '', 1, '', '2020-02-04 12:28:13'),
	(13, 'Cpanel', 'Manage Module', 'cp/module/manage-module', 10, NULL, NULL, 1, '', '2020-02-04 11:28:38'),
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
	(36, 'Settings', 'Survey Category', 'settings/survey/manage-survey-category', 26, NULL, NULL, 1, '2020-02-11 13:08:18', '2020-02-11 13:08:18');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;

-- Dumping structure for table bils_db.message_masters
CREATE TABLE IF NOT EXISTS `message_masters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `admin_message` text NOT NULL,
  `app_user_id` int(11) NOT NULL,
  `app_user_message` text NOT NULL,
  `is_seen` tinyint(1) NOT NULL COMMENT '0: Not-seen, 1: Seen',
  `message_category` int(11) NOT NULL,
  `message_date_time` varchar(50) NOT NULL DEFAULT current_timestamp(),
  `attachment` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '1: Active, 2: Deleted',
  `created_at` varchar(50) NOT NULL DEFAULT current_timestamp(),
  `updated_at` varchar(50) NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.message_masters: ~0 rows (approximately)
/*!40000 ALTER TABLE `message_masters` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_masters` ENABLE KEYS */;

-- Dumping structure for table bils_db.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_db.migrations: ~4 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2020_01_24_063021_create_jobs_table', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table bils_db.notices
CREATE TABLE IF NOT EXISTS `notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `details` text NOT NULL,
  `date` date NOT NULL,
  `expire_date` date NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0: In-active, 1: Active',
  `created_by` varchar(20) NOT NULL,
  `updated_by` varchar(20) NOT NULL,
  `created_at` varchar(20) NOT NULL DEFAULT current_timestamp(),
  `updated_at` varchar(20) NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.notices: ~0 rows (approximately)
/*!40000 ALTER TABLE `notices` DISABLE KEYS */;
/*!40000 ALTER TABLE `notices` ENABLE KEYS */;

-- Dumping structure for table bils_db.notice_categories
CREATE TABLE IF NOT EXISTS `notice_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0: In-active, 1: Active',
  `created_at` varchar(30) DEFAULT current_timestamp(),
  `updated_at` varchar(30) DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.notice_categories: ~2 rows (approximately)
/*!40000 ALTER TABLE `notice_categories` DISABLE KEYS */;
INSERT INTO `notice_categories` (`id`, `category_name`, `details`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Notice Category', 'DetailS', 1, '2020-02-11 12:24:04', '2020-02-11 12:42:34'),
	(2, 'Notice Category1', 'notice details', 0, '2020-02-11 12:40:21', '2020-02-11 12:50:57');
/*!40000 ALTER TABLE `notice_categories` ENABLE KEYS */;

-- Dumping structure for table bils_db.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `date_time` varchar(50) NOT NULL DEFAULT current_timestamp(),
  `message` text NOT NULL,
  `type` varchar(50) NOT NULL,
  `created_at` varchar(50) NOT NULL DEFAULT current_timestamp(),
  `updated_at` varchar(50) NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.notifications: ~0 rows (approximately)
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;

-- Dumping structure for table bils_db.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_db.password_resets: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table bils_db.publications
CREATE TABLE IF NOT EXISTS `publications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publication_title` varchar(150) NOT NULL,
  `details` text NOT NULL,
  `publication_type` tinyint(1) NOT NULL COMMENT 'From publication_categories table',
  `authors` varchar(50) NOT NULL,
  `attachment` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0: In-active, 1: Active',
  `created_by` varchar(20) NOT NULL,
  `updated_by` varchar(20) NOT NULL,
  `created_at` varchar(20) NOT NULL DEFAULT current_timestamp(),
  `updated_at` varchar(20) NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.publications: ~0 rows (approximately)
/*!40000 ALTER TABLE `publications` DISABLE KEYS */;
/*!40000 ALTER TABLE `publications` ENABLE KEYS */;

-- Dumping structure for table bils_db.publication_categories
CREATE TABLE IF NOT EXISTS `publication_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0: In-active, 1: Active',
  `created_at` varchar(30) DEFAULT current_timestamp(),
  `updated_at` varchar(30) DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.publication_categories: ~3 rows (approximately)
/*!40000 ALTER TABLE `publication_categories` DISABLE KEYS */;
INSERT INTO `publication_categories` (`id`, `category_name`, `details`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Article', 'some article type will goes here', 1, '2020-02-10 11:38:13', '2020-02-10 11:38:13'),
	(2, 'test', 'some article type will goes here', 0, '2020-02-10 12:17:31', '2020-02-10 12:17:31');
/*!40000 ALTER TABLE `publication_categories` ENABLE KEYS */;

-- Dumping structure for table bils_db.settings
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
  `created_at` varchar(255) COLLATE utf8_unicode_ci DEFAULT current_timestamp(),
  `updated_at` varchar(255) COLLATE utf8_unicode_ci DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_db.settings: ~1 rows (approximately)
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`id`, `company_name`, `short_name`, `site_name`, `admin_email`, `admin_mobile`, `site_url`, `admin_url`, `logo`, `address`, `created_at`, `updated_at`) VALUES
	(1, 'Bangladesh Institute of Labour Studies', 'BILS', 'BILS APPLICATION', 'admin@bils.com', '01980340482', NULL, '/admin', NULL, 'Dhaka', NULL, '2020-02-03 17:14:58');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;

-- Dumping structure for table bils_db.survey_categories
CREATE TABLE IF NOT EXISTS `survey_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0: In-active, 1: Active',
  `created_at` varchar(30) DEFAULT current_timestamp(),
  `updated_at` varchar(30) DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.survey_categories: ~0 rows (approximately)
/*!40000 ALTER TABLE `survey_categories` DISABLE KEYS */;
INSERT INTO `survey_categories` (`id`, `category_name`, `details`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Survey Category 1', NULL, 1, '2020-02-11 14:00:45', '2020-02-11 14:00:45'),
	(3, 'Survey Category 3', 'asda', 0, '2020-02-11 14:04:45', '2020-02-11 14:06:11');
/*!40000 ALTER TABLE `survey_categories` ENABLE KEYS */;

-- Dumping structure for table bils_db.survey_groups
CREATE TABLE IF NOT EXISTS `survey_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL COMMENT 'From app_user_groups',
  `status` tinyint(1) NOT NULL COMMENT '0: In-active, 1: Active',
  `created_at` varchar(50) DEFAULT current_timestamp(),
  `updated_at` varchar(50) DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.survey_groups: ~0 rows (approximately)
/*!40000 ALTER TABLE `survey_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_groups` ENABLE KEYS */;

-- Dumping structure for table bils_db.survey_masters
CREATE TABLE IF NOT EXISTS `survey_masters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_name` varchar(200) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `survey_category` int(11) NOT NULL COMMENT 'From survey_categories ',
  `survey_type` int(11) NOT NULL,
  `details` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0: In-active, 1: Active',
  `created_by` int(11) NOT NULL COMMENT 'Admin User ID',
  `updated_by` int(11) NOT NULL COMMENT 'Admin User ID',
  `created_at` varchar(50) NOT NULL DEFAULT current_timestamp(),
  `updated_at` varchar(50) NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.survey_masters: ~0 rows (approximately)
/*!40000 ALTER TABLE `survey_masters` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_masters` ENABLE KEYS */;

-- Dumping structure for table bils_db.survey_participants
CREATE TABLE IF NOT EXISTS `survey_participants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_user_id` int(11) NOT NULL,
  `survey_id` int(11) NOT NULL,
  `answer_date` date NOT NULL,
  `notification_date` date NOT NULL,
  `is_answered` tinyint(1) DEFAULT NULL COMMENT '0: Not-answer, 1: Answer',
  `survey_completed` tinyint(1) DEFAULT NULL COMMENT '0: Not-completed, 1: Completed',
  `status` tinyint(1) DEFAULT NULL COMMENT '0: In-active, 1: Active',
  `created_at` varchar(50) DEFAULT current_timestamp(),
  `updated_at` varchar(50) DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.survey_participants: ~0 rows (approximately)
/*!40000 ALTER TABLE `survey_participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_participants` ENABLE KEYS */;

-- Dumping structure for table bils_db.survey_participant_answers
CREATE TABLE IF NOT EXISTS `survey_participant_answers` (
  `survey_participan_id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_question_id` int(11) NOT NULL,
  `answer` text NOT NULL,
  `created_at` varchar(50) DEFAULT current_timestamp(),
  `updated_at` varchar(50) DEFAULT current_timestamp(),
  PRIMARY KEY (`survey_participan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.survey_participant_answers: ~0 rows (approximately)
/*!40000 ALTER TABLE `survey_participant_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_participant_answers` ENABLE KEYS */;

-- Dumping structure for table bils_db.survey_questions
CREATE TABLE IF NOT EXISTS `survey_questions` (
  `survey_question_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_details` text NOT NULL,
  `question_type` int(11) NOT NULL COMMENT 'From question_categories ',
  `created_at` varchar(50) DEFAULT current_timestamp(),
  `updated_at` varchar(50) DEFAULT current_timestamp(),
  PRIMARY KEY (`survey_question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.survey_questions: ~0 rows (approximately)
/*!40000 ALTER TABLE `survey_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_questions` ENABLE KEYS */;

-- Dumping structure for table bils_db.users
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
  `remarks` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_db.users: ~3 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `nid_no`, `contact_no`, `email`, `address`, `user_type`, `user_profile_image`, `password`, `remember_token`, `login_status`, `status`, `remarks`, `last_login`, `created_at`, `updated_at`) VALUES
	(1, 'Momit', '123456', '017', 'momit@bils.com', 'mohammadpur', 1, '', '$2y$10$ta1BmsLnz8H4tUqFJHI8puHxhCldn9DSwVfQjc3g59v9YSxM7.Trq', NULL, 0, 1, NULL, '2020-01-24 17:30:45', '2020-01-24 06:51:31', '2020-02-11 09:48:09'),
	(13, 'Momit Hasan', '78967899', '53463435', 'momit@technolife.ee', NULL, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2020-02-02 08:44:30', '2020-02-08 10:03:50'),
	(31, 'SiaM', '123', '01747083028', 'siam@gmail.com', NULL, 1, NULL, NULL, NULL, NULL, 2, NULL, NULL, '2020-02-09 13:25:51', '2020-02-10 07:15:45');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table bils_db.user_groups
CREATE TABLE IF NOT EXISTS `user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(50) DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1: Admin User, 2: App User',
  `status` int(11) NOT NULL COMMENT '1: Active, 0: In-active',
  `created_at` varchar(50) DEFAULT current_timestamp(),
  `updated_at` varchar(50) DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.user_groups: ~6 rows (approximately)
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
INSERT INTO `user_groups` (`id`, `group_name`, `type`, `status`, `created_at`, `updated_at`) VALUES
	(25, 'Sub Admin', 1, 1, '2020-02-07 10:23:56', '2020-02-08 11:34:48'),
	(26, 'Admin', 1, 1, '2020-02-08 11:39:02', '2020-02-08 11:39:02'),
	(27, 'Web View', 2, 1, '2020-02-08 13:02:57', '2020-02-09 12:00:49'),
	(28, 'Sub Admin 1', 1, 0, '2020-02-09 09:57:24', '2020-02-09 09:57:24'),
	(29, 'Sub Admin 2', 1, 0, '2020-02-09 10:48:54', '2020-02-09 10:51:34'),
	(30, 'App View', 2, 1, '2020-02-09 11:37:38', '2020-02-09 11:59:25');
/*!40000 ALTER TABLE `user_groups` ENABLE KEYS */;

-- Dumping structure for table bils_db.user_group_members
CREATE TABLE IF NOT EXISTS `user_group_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_id` bigint(20) unsigned NOT NULL,
  `group_id` int(11) NOT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '0 : no access, 1 : access',
  `created_at` varchar(50) DEFAULT current_timestamp(),
  `updated_at` varchar(50) DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 4` (`emp_id`,`group_id`),
  KEY `FK_user_group_members_user_groups` (`group_id`),
  CONSTRAINT `FK_user_group_members_user_groups` FOREIGN KEY (`group_id`) REFERENCES `user_groups` (`id`),
  CONSTRAINT `FK_user_group_members_users` FOREIGN KEY (`emp_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.user_group_members: ~4 rows (approximately)
/*!40000 ALTER TABLE `user_group_members` DISABLE KEYS */;
INSERT INTO `user_group_members` (`id`, `emp_id`, `group_id`, `status`, `created_at`, `updated_at`) VALUES
	(1, 31, 25, 1, '2020-02-09 13:25:51', '2020-02-09 13:25:51'),
	(2, 1, 26, 1, '2020-02-09 13:27:08', '2020-02-09 13:27:08'),
	(3, 1, 25, 1, '2020-02-09 13:27:24', '2020-02-09 13:27:24'),
	(6, 31, 26, 0, '2020-02-09 13:42:22', '2020-02-09 13:42:22');
/*!40000 ALTER TABLE `user_group_members` ENABLE KEYS */;

-- Dumping structure for table bils_db.user_group_permissions
CREATE TABLE IF NOT EXISTS `user_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL DEFAULT 0,
  `action_id` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL COMMENT '0: Not Permit, 1: Permit',
  `created_at` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT current_timestamp(),
  `updated_at` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 2` (`group_id`,`action_id`),
  KEY `FK_user_group_permission_web_actions` (`action_id`),
  CONSTRAINT `FK_user_group_permission_user_group` FOREIGN KEY (`group_id`) REFERENCES `user_groups` (`id`),
  CONSTRAINT `FK_user_group_permission_web_actions` FOREIGN KEY (`action_id`) REFERENCES `web_actions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_db.user_group_permissions: ~46 rows (approximately)
/*!40000 ALTER TABLE `user_group_permissions` DISABLE KEYS */;
INSERT INTO `user_group_permissions` (`id`, `group_id`, `action_id`, `status`, `created_at`, `updated_at`) VALUES
	(8, 25, 1, 1, '2020-02-07 10:23:56', '2020-02-07 10:23:56'),
	(9, 25, 2, 0, '2020-02-07 10:23:56', '2020-02-07 10:23:56'),
	(10, 25, 4, 0, '2020-02-07 10:23:56', '2020-02-07 10:23:56'),
	(11, 25, 6, 0, '2020-02-07 10:23:56', '2020-02-07 10:23:56'),
	(12, 25, 7, 1, '2020-02-07 10:23:56', '2020-02-07 10:23:56'),
	(13, 25, 8, 1, '2020-02-07 10:23:56', '2020-02-07 10:23:56'),
	(14, 25, 9, 0, '2020-02-07 10:23:56', '2020-02-07 10:23:56'),
	(15, 25, 10, 0, '2020-02-07 10:23:56', '2020-02-07 10:23:56'),
	(19, 26, 1, 0, '2020-02-08 11:39:02', '2020-02-08 11:39:02'),
	(20, 26, 2, 1, '2020-02-08 11:39:02', '2020-02-08 11:39:02'),
	(21, 26, 4, 0, '2020-02-08 11:39:02', '2020-02-08 11:39:02'),
	(22, 26, 6, 0, '2020-02-08 11:39:02', '2020-02-08 11:39:02'),
	(23, 26, 7, 0, '2020-02-08 11:39:02', '2020-02-08 11:39:02'),
	(24, 26, 8, 0, '2020-02-08 11:39:02', '2020-02-08 11:39:02'),
	(25, 26, 9, 0, '2020-02-08 11:39:02', '2020-02-08 11:39:02'),
	(26, 26, 10, 0, '2020-02-08 11:39:02', '2020-02-08 11:39:02'),
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
	(58, 30, 10, 0, '2020-02-09 11:37:39', '2020-02-09 11:37:39');
/*!40000 ALTER TABLE `user_group_permissions` ENABLE KEYS */;

-- Dumping structure for table bils_db.web_actions
CREATE TABLE IF NOT EXISTS `web_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `module_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1:active, 0:inactive',
  `created_at` varchar(50) COLLATE utf8_unicode_ci DEFAULT current_timestamp(),
  `updated_at` varchar(50) COLLATE utf8_unicode_ci DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_name_module_id` (`activity_name`,`module_id`),
  KEY `module_id` (`module_id`),
  CONSTRAINT `FK_web_actions_menus` FOREIGN KEY (`module_id`) REFERENCES `menus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_db.web_actions: ~9 rows (approximately)
/*!40000 ALTER TABLE `web_actions` DISABLE KEYS */;
INSERT INTO `web_actions` (`id`, `activity_name`, `module_id`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Admin Users', 1, 1, '', '2020-02-05 14:13:21'),
	(2, 'Admin User Entry', 1, 1, '', '2020-02-05 14:13:21'),
	(4, 'Admin User update', 1, 1, '', '2020-02-05 14:13:21'),
	(6, 'Admin User delete', 1, 1, '', '2020-02-05 14:13:21'),
	(7, 'App Users', 1, 1, '', '2020-02-05 14:13:21'),
	(8, 'App User Entry', 1, 1, '', '2020-02-05 14:13:21'),
	(9, 'App User update', 1, 1, '', '2020-02-05 14:13:21'),
	(10, 'App User delete', 1, 1, '', '2020-02-05 14:13:21');
/*!40000 ALTER TABLE `web_actions` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
