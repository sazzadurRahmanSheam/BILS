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
  `nid_no` varchar(50) DEFAULT NULL,
  `contact_no` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `created_at` varchar(50) DEFAULT current_timestamp(),
  `updated_at` varchar(50) DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.app_users: ~0 rows (approximately)
/*!40000 ALTER TABLE `app_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_users` ENABLE KEYS */;

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
  `Column 5` int(11) DEFAULT 0,
  `serial_no` int(11) DEFAULT NULL,
  `menu_icon_class` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1:active, 0:inactive',
  `created_at` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT current_timestamp(),
  `updated_at` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_db.menus: ~15 rows (approximately)
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` (`id`, `module_name`, `menu_title`, `menu_url`, `parent_id`, `Column 5`, `serial_no`, `menu_icon_class`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'User', 'Users', '', 0, 0, 1, 'clip-user-plus', 1, '', '2020-02-04 11:46:09'),
	(2, 'User', 'Admin Users', 'admin/admin-user-management', 1, 0, 1, NULL, 1, '', '2020-02-04 12:09:48'),
	(4, 'User', 'App Users', 'app-user/app-user-management', 1, 0, 3, NULL, 1, '', '2020-02-04 12:28:13'),
	(5, 'User', 'App User Groups', 'app-user/app-group-management', 1, 0, 4, NULL, 1, '', '2020-02-04 12:28:13'),
	(6, 'Surveys', 'Surveys', 'survey/management', 0, 0, 3, 'clip-note', 1, '', '2020-02-04 12:28:13'),
	(7, 'Courses', 'Courses', '', 0, 0, 2, 'clip-book', 1, '', '2020-02-04 12:28:13'),
	(8, 'Courses', 'Open Courses', 'cources/open-course', 7, 0, 1, NULL, 1, '', '2020-02-04 12:28:13'),
	(9, 'Courses', 'Course Management', 'cources/management', 7, 0, 2, NULL, 1, '', '2020-02-04 12:28:13'),
	(10, 'Cpanel', 'Control Panel', '', 0, 0, NULL, 'clip-settings', 1, '', '2020-02-04 12:28:13'),
	(11, 'Cpanel', 'General Setting', 'general/setting', 10, 0, NULL, '', 1, '', '2020-02-04 12:28:13'),
	(13, 'Cpanel', 'Manage Module', 'module/manage-module', 10, 0, NULL, NULL, 1, '', '2020-02-04 11:28:38'),
	(21, 'Cpanel', 'Web Actions', 'web/action-management', 10, 0, NULL, NULL, 1, '2020-02-04 12:20:29', '2020-02-04 12:21:40'),
	(22, 'Test', 'TesT', '', 0, 0, NULL, 'clip-user-plus', 1, '2020-02-04 12:40:13', '2020-02-04 12:40:13'),
	(26, 'Settings', 'Settings', '', 0, 0, NULL, 'clip-settings', 1, '2020-02-05 10:05:14', '2020-02-05 10:05:14'),
	(27, 'Settings', 'User Groups', 'admin/admin-group-management', 26, 0, NULL, NULL, 1, '2020-02-05 10:06:31', '2020-02-05 10:07:23');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;

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
  `status` tinyint(1) DEFAULT 1 COMMENT '1:active, 2:in-active',
  `remarks` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_db.users: ~5 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `nid_no`, `contact_no`, `email`, `address`, `user_type`, `user_profile_image`, `password`, `remember_token`, `login_status`, `status`, `remarks`, `last_login`, `created_at`, `updated_at`) VALUES
	(1, 'Momit', '', '', 'momit@bils.com', '', 1, '', '$2y$10$ta1BmsLnz8H4tUqFJHI8puHxhCldn9DSwVfQjc3g59v9YSxM7.Trq', NULL, 0, 1, NULL, '2020-01-24 17:30:45', '2020-01-24 06:51:31', '2020-02-06 05:17:53'),
	(13, 'Momit Hasan1', '78967899', '53463435', 'momit@technolife.ee', NULL, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2020-02-02 08:44:30', '2020-02-03 16:51:37'),
	(27, 'SaM', '123123', '2132133', 'alex@gmail.com', NULL, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2020-02-06 11:33:26', '2020-02-06 11:33:26'),
	(28, 'A', '22', '123', 'alex1234@gmail.com', NULL, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2020-02-06 11:35:27', '2020-02-06 11:35:27'),
	(30, 'AB', '123456789', '123456789', 'ab@gmail.com', NULL, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2020-02-06 12:08:26', '2020-02-06 12:08:26');
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.user_groups: ~6 rows (approximately)
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
INSERT INTO `user_groups` (`id`, `group_name`, `type`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'a', 1, 1, '2020-02-05 12:00:56', '2020-02-05 12:00:56'),
	(2, 'b', 2, 0, '2020-02-05 12:02:26', '2020-02-05 12:02:26'),
	(5, 'hjghgfhg', 1, 1, '2020-02-05 12:36:00', '2020-02-05 12:36:00'),
	(6, 'hjghgfhg', 1, 1, '2020-02-05 12:36:20', '2020-02-05 12:36:20'),
	(8, 'dhdfgdfgfdgfdgfg', 1, 1, '2020-02-05 13:31:33', '2020-02-05 13:31:33'),
	(9, 'yuuuuu', 2, 1, '2020-02-05 13:31:55', '2020-02-05 13:31:55');
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
  KEY `FK_user_group_members_user_groups` (`group_id`),
  KEY `FK_user_group_members_users` (`emp_id`),
  CONSTRAINT `FK_user_group_members_user_groups` FOREIGN KEY (`group_id`) REFERENCES `user_groups` (`id`),
  CONSTRAINT `FK_user_group_members_users` FOREIGN KEY (`emp_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bils_db.user_group_members: ~7 rows (approximately)
/*!40000 ALTER TABLE `user_group_members` DISABLE KEYS */;
INSERT INTO `user_group_members` (`id`, `emp_id`, `group_id`, `status`, `created_at`, `updated_at`) VALUES
	(1, 27, 1, 1, '2020-02-06 11:33:26', '2020-02-06 11:33:26'),
	(2, 27, 5, 1, '2020-02-06 11:33:26', '2020-02-06 11:33:26'),
	(3, 27, 6, 1, '2020-02-06 11:33:26', '2020-02-06 11:33:26'),
	(4, 27, 8, 1, '2020-02-06 11:33:26', '2020-02-06 11:33:26'),
	(5, 27, 9, 1, '2020-02-06 11:33:26', '2020-02-06 11:33:26'),
	(6, 28, 1, 1, '2020-02-06 11:35:27', '2020-02-06 11:35:27'),
	(7, 28, 5, 1, '2020-02-06 11:35:27', '2020-02-06 11:35:27'),
	(8, 30, 1, 1, '2020-02-06 12:10:40', '2020-02-06 12:10:40');
/*!40000 ALTER TABLE `user_group_members` ENABLE KEYS */;

-- Dumping structure for table bils_db.user_group_permissions
CREATE TABLE IF NOT EXISTS `user_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT 0,
  `action_id` int(11) DEFAULT 0,
  `status` tinyint(1) NOT NULL COMMENT '0: Not Permit, 1: Permit',
  `created_at` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT current_timestamp(),
  `updated_at` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 2` (`group_id`,`action_id`),
  KEY `FK_user_group_permission_web_actions` (`action_id`),
  CONSTRAINT `FK_user_group_permission_user_group` FOREIGN KEY (`group_id`) REFERENCES `user_groups` (`id`),
  CONSTRAINT `FK_user_group_permission_web_actions` FOREIGN KEY (`action_id`) REFERENCES `menus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=471 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bils_db.user_group_permissions: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_group_permissions` DISABLE KEYS */;
INSERT INTO `user_group_permissions` (`id`, `group_id`, `action_id`, `status`, `created_at`, `updated_at`) VALUES
	(461, 1, 5, 1, '2020-02-06 14:29:25', '2020-02-06 14:29:25'),
	(462, 1, 8, 1, '2020-02-06 14:29:25', '2020-02-06 14:29:25'),
	(463, 1, 9, 1, '2020-02-06 14:29:25', '2020-02-06 14:29:25'),
	(464, 1, 11, 1, '2020-02-06 14:29:25', '2020-02-06 14:29:25'),
	(465, 1, 13, 1, '2020-02-06 14:29:25', '2020-02-06 14:29:25'),
	(466, 1, 21, 1, '2020-02-06 14:29:25', '2020-02-06 14:29:25'),
	(467, 1, 27, 1, '2020-02-06 14:29:25', '2020-02-06 14:29:25');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
	(10, 'App User delete', 1, 1, '', '2020-02-05 14:13:21'),
	(15, 'test1', 22, 1, '2020-02-05 09:20:04', '2020-02-05 09:50:17');
/*!40000 ALTER TABLE `web_actions` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
