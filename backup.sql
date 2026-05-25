-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 25, 2026 at 07:03 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `swms_db`
--
CREATE DATABASE IF NOT EXISTS `swms_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `swms_db`;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `sku` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `status` varchar(20) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `sku`, `category`, `stock`, `price`, `status`, `image`, `created_at`) VALUES
(1, 'Pioneer AVH-Z9280BT', 'Head Unit Audio Mobil', 'PAVH-9280', 'audio', 34, '1500000.00', 'aman', NULL, '2026-05-11 09:48:46'),
(2, 'JBL Club 6500C', 'Speaker Mobil 6.5\"', 'JCLUB-6500', 'audio', 12, '1500000.00', 'menipis', NULL, '2026-05-11 09:48:46'),
(3, 'Michelin Pilot Sport 4', 'Ban Performansi 205/55R16', 'MPS4-205', 'ban', 2, '1200000.00', 'kritis', NULL, '2026-05-11 09:48:46'),
(4, 'Enkei RP-F1', 'Velg Alloy 17\" Silver', 'ENKF1-17', 'velg', 23, '2500000.00', 'aman', NULL, '2026-05-11 09:48:46'),
(5, 'Hella Projector H7', 'Lampu Projector LED H7', 'HELLA-H7', 'lampu', 8, '350000.00', 'menipis', NULL, '2026-05-11 09:48:46'),
(6, 'TRD Body Kit', 'Body Kit Aerodinamis Toyota', 'TRD-BK001', 'bodykit', 1, '8500000.00', 'kritis', NULL, '2026-05-11 09:48:46');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int NOT NULL,
  `product_id` int NOT NULL,
  `type` enum('in','out') NOT NULL,
  `quantity` int NOT NULL,
  `total_price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `supplier` varchar(100) DEFAULT NULL,
  `destination` varchar(100) DEFAULT NULL,
  `notes` text,
  `admin` varchar(50) DEFAULT 'Admin User',
  `date` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `product_id`, `type`, `quantity`, `total_price`, `supplier`, `destination`, `notes`, `admin`, `date`) VALUES
(1, 5, 'in', 3, '1050000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 11:48:00'),
(2, 1, 'in', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 15:31:00'),
(3, 1, 'in', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 17:26:00'),
(4, 5, 'in', 2, '700000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 15:36:00'),
(5, 1, 'in', 5, '7500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 17:19:00'),
(6, 1, 'in', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 16:19:00'),
(7, 1, 'in', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 14:40:00'),
(8, 2, 'in', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 12:43:00'),
(9, 1, 'in', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 14:09:00'),
(10, 3, 'in', 5, '6000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 14:21:00'),
(11, 5, 'in', 5, '1750000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 09:24:00'),
(12, 4, 'in', 4, '10000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 10:02:00'),
(13, 3, 'in', 4, '4800000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 17:43:00'),
(14, 5, 'in', 2, '700000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 09:45:00'),
(15, 2, 'in', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 11:50:00'),
(16, 5, 'in', 5, '1750000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 13:43:00'),
(17, 2, 'in', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 14:18:00'),
(18, 1, 'in', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 16:20:00'),
(19, 6, 'in', 4, '34000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 12:27:00'),
(20, 5, 'in', 4, '1400000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 14:46:00'),
(21, 1, 'in', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 15:56:00'),
(22, 4, 'in', 5, '12500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 12:28:00'),
(23, 6, 'out', 1, '8500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 17:29:00'),
(24, 3, 'out', 3, '3600000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 11:25:00'),
(25, 2, 'out', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 16:06:00'),
(26, 3, 'out', 2, '2400000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 10:28:00'),
(27, 4, 'out', 1, '2500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 15:57:00'),
(28, 4, 'out', 3, '7500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 12:56:00'),
(29, 3, 'out', 1, '1200000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 13:04:00'),
(30, 5, 'out', 3, '1050000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 12:33:00'),
(31, 2, 'out', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 11:23:00'),
(32, 5, 'out', 2, '700000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 14:49:00'),
(33, 2, 'out', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 15:40:00'),
(34, 1, 'out', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 17:59:00'),
(35, 2, 'out', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 13:57:00'),
(36, 5, 'out', 3, '1050000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 14:29:00'),
(37, 1, 'out', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-05 12:24:00'),
(38, 3, 'in', 3, '3600000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 11:06:00'),
(39, 1, 'in', 5, '7500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 08:31:00'),
(40, 4, 'in', 1, '2500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 16:35:00'),
(41, 2, 'in', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 10:11:00'),
(42, 2, 'in', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 10:46:00'),
(43, 6, 'in', 4, '34000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 09:20:00'),
(44, 4, 'in', 3, '7500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 12:05:00'),
(45, 5, 'in', 1, '350000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 15:22:00'),
(46, 6, 'in', 2, '17000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 17:11:00'),
(47, 6, 'in', 1, '8500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 12:50:00'),
(48, 4, 'in', 5, '12500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 15:07:00'),
(49, 4, 'in', 4, '10000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 17:16:00'),
(50, 1, 'in', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 08:09:00'),
(51, 1, 'out', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 13:25:00'),
(52, 2, 'out', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 12:21:00'),
(53, 3, 'out', 1, '1200000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 15:18:00'),
(54, 6, 'out', 3, '25500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 12:11:00'),
(55, 3, 'out', 3, '3600000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 12:50:00'),
(56, 2, 'out', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 10:01:00'),
(57, 1, 'out', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 12:15:00'),
(58, 5, 'out', 2, '700000.00', NULL, NULL, NULL, 'Admin User', '2026-05-06 09:42:00'),
(59, 5, 'in', 2, '700000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 08:34:00'),
(60, 1, 'in', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 12:39:00'),
(61, 3, 'in', 1, '1200000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 09:59:00'),
(62, 3, 'in', 3, '3600000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 16:03:00'),
(63, 3, 'in', 2, '2400000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 11:10:00'),
(64, 3, 'in', 4, '4800000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 16:33:00'),
(65, 2, 'in', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 13:16:00'),
(66, 2, 'in', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 16:48:00'),
(67, 2, 'in', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 09:12:00'),
(68, 2, 'in', 4, '6000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 15:39:00'),
(69, 4, 'in', 2, '5000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 10:19:00'),
(70, 3, 'in', 3, '3600000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 15:20:00'),
(71, 3, 'in', 4, '4800000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 12:07:00'),
(72, 3, 'in', 1, '1200000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 16:49:00'),
(73, 4, 'in', 2, '5000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 17:09:00'),
(74, 3, 'in', 4, '4800000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 15:59:00'),
(75, 4, 'in', 4, '10000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 17:29:00'),
(76, 5, 'in', 5, '1750000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 11:42:00'),
(77, 1, 'in', 4, '6000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 17:24:00'),
(78, 3, 'in', 2, '2400000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 11:50:00'),
(79, 1, 'in', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 17:38:00'),
(80, 5, 'in', 1, '350000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 16:01:00'),
(81, 3, 'out', 1, '1200000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 15:52:00'),
(82, 6, 'out', 1, '8500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 12:39:00'),
(83, 5, 'out', 3, '1050000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 17:02:00'),
(84, 3, 'out', 2, '2400000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 11:44:00'),
(85, 3, 'out', 2, '2400000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 16:00:00'),
(86, 4, 'out', 1, '2500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 08:16:00'),
(87, 5, 'out', 1, '350000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 10:28:00'),
(88, 6, 'out', 3, '25500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 11:29:00'),
(89, 2, 'out', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 16:20:00'),
(90, 4, 'out', 2, '5000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-07 13:38:00'),
(91, 5, 'in', 5, '1750000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 14:58:00'),
(92, 2, 'in', 5, '7500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 16:10:00'),
(93, 5, 'in', 5, '1750000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 16:15:00'),
(94, 6, 'in', 1, '8500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 17:16:00'),
(95, 2, 'in', 4, '6000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 15:19:00'),
(96, 6, 'in', 4, '34000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 12:29:00'),
(97, 6, 'in', 2, '17000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 17:52:00'),
(98, 4, 'in', 5, '12500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 10:25:00'),
(99, 5, 'in', 1, '350000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 17:33:00'),
(100, 3, 'in', 2, '2400000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 10:44:00'),
(101, 2, 'in', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 10:17:00'),
(102, 6, 'in', 2, '17000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 17:30:00'),
(103, 1, 'in', 4, '6000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 14:27:00'),
(104, 6, 'in', 2, '17000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 09:35:00'),
(105, 6, 'in', 1, '8500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 08:32:00'),
(106, 1, 'out', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 09:05:00'),
(107, 6, 'out', 1, '8500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 08:53:00'),
(108, 6, 'out', 2, '17000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 13:04:00'),
(109, 5, 'out', 3, '1050000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 13:33:00'),
(110, 3, 'out', 3, '3600000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 14:20:00'),
(111, 1, 'out', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 13:48:00'),
(112, 4, 'out', 2, '5000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 11:15:00'),
(113, 3, 'out', 1, '1200000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 16:45:00'),
(114, 3, 'out', 3, '3600000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 17:19:00'),
(115, 6, 'out', 1, '8500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 08:42:00'),
(116, 4, 'out', 3, '7500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 12:52:00'),
(117, 6, 'out', 2, '17000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 13:28:00'),
(118, 1, 'out', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-08 12:27:00'),
(119, 4, 'in', 3, '7500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 13:37:00'),
(120, 5, 'in', 2, '700000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 13:44:00'),
(121, 4, 'in', 3, '7500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 14:35:00'),
(122, 4, 'in', 3, '7500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 15:42:00'),
(123, 6, 'in', 1, '8500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 11:03:00'),
(124, 6, 'in', 1, '8500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 17:03:00'),
(125, 2, 'in', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 13:33:00'),
(126, 1, 'in', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 12:04:00'),
(127, 6, 'in', 3, '25500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 08:50:00'),
(128, 6, 'in', 4, '34000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 12:05:00'),
(129, 5, 'in', 5, '1750000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 08:02:00'),
(130, 4, 'in', 1, '2500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 14:07:00'),
(131, 3, 'out', 2, '2400000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 11:26:00'),
(132, 1, 'out', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 10:43:00'),
(133, 4, 'out', 1, '2500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 09:34:00'),
(134, 2, 'out', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 16:17:00'),
(135, 2, 'out', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 11:15:00'),
(136, 5, 'out', 3, '1050000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 09:40:00'),
(137, 4, 'out', 3, '7500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 17:47:00'),
(138, 6, 'out', 3, '25500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-09 16:38:00'),
(139, 6, 'in', 4, '34000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 14:42:00'),
(140, 3, 'in', 5, '6000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 17:24:00'),
(141, 3, 'in', 3, '3600000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 10:31:00'),
(142, 3, 'in', 1, '1200000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 09:13:00'),
(143, 2, 'in', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 17:01:00'),
(144, 4, 'in', 5, '12500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 11:46:00'),
(145, 3, 'in', 5, '6000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 15:04:00'),
(146, 4, 'in', 5, '12500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 08:56:00'),
(147, 3, 'in', 4, '4800000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 11:29:00'),
(148, 5, 'in', 3, '1050000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 09:37:00'),
(149, 3, 'in', 3, '3600000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 14:49:00'),
(150, 2, 'in', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 16:38:00'),
(151, 1, 'in', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 16:24:00'),
(152, 6, 'in', 4, '34000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 12:08:00'),
(153, 2, 'in', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 10:46:00'),
(154, 2, 'in', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 10:10:00'),
(155, 4, 'in', 5, '12500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 10:02:00'),
(156, 1, 'in', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 14:43:00'),
(157, 2, 'in', 4, '6000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 08:05:00'),
(158, 1, 'out', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 16:30:00'),
(159, 2, 'out', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 17:46:00'),
(160, 4, 'out', 3, '7500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 17:03:00'),
(161, 6, 'out', 2, '17000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 12:36:00'),
(162, 2, 'out', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 11:40:00'),
(163, 4, 'out', 3, '7500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-10 09:19:00'),
(164, 5, 'in', 4, '1400000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 08:41:00'),
(165, 6, 'in', 2, '17000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 12:22:00'),
(166, 6, 'in', 5, '42500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 12:49:00'),
(167, 6, 'in', 3, '25500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 11:32:00'),
(168, 6, 'in', 3, '25500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 08:22:00'),
(169, 1, 'in', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 08:47:00'),
(170, 5, 'in', 4, '1400000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 11:44:00'),
(171, 2, 'in', 4, '6000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 12:31:00'),
(172, 2, 'in', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 13:26:00'),
(173, 4, 'in', 3, '7500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 16:16:00'),
(174, 5, 'in', 5, '1750000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 16:20:00'),
(175, 3, 'in', 5, '6000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 12:13:00'),
(176, 3, 'in', 3, '3600000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 09:09:00'),
(177, 2, 'in', 5, '7500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 12:11:00'),
(178, 6, 'in', 5, '42500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 15:20:00'),
(179, 2, 'in', 4, '6000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 08:39:00'),
(180, 2, 'out', 1, '1500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 08:24:00'),
(181, 1, 'out', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 09:44:00'),
(182, 2, 'out', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 08:22:00'),
(183, 3, 'out', 2, '2400000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 14:36:00'),
(184, 3, 'out', 1, '1200000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 10:47:00'),
(185, 4, 'out', 2, '5000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 11:25:00'),
(186, 3, 'out', 3, '3600000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 11:50:00'),
(187, 3, 'out', 2, '2400000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 16:12:00'),
(188, 4, 'out', 2, '5000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 14:02:00'),
(189, 3, 'out', 2, '2400000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 16:12:00'),
(190, 1, 'out', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 09:54:00'),
(191, 3, 'out', 3, '3600000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 16:58:00'),
(192, 3, 'out', 1, '1200000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 10:28:00'),
(193, 1, 'out', 3, '4500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 11:34:00'),
(194, 2, 'out', 2, '3000000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 08:25:00'),
(195, 6, 'out', 1, '8500000.00', NULL, NULL, NULL, 'Admin User', '2026-05-11 15:11:00'),
(196, 4, 'in', 5, '12500000.00', 'hsr', NULL, NULL, 'Admin User', '2026-05-13 14:39:54'),
(197, 6, 'out', 4, '34000000.00', NULL, '67', NULL, 'Admin User', '2026-05-13 14:41:51');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `created_at`) VALUES
(1, 'admin', 'admin123', 'admin', '2026-05-11 09:48:46');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=198;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
