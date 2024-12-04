-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 04, 2024 at 03:59 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tracking_map`
--

-- --------------------------------------------------------

--
-- Table structure for table `site`
--

CREATE TABLE `site` (
  `id` int(11) NOT NULL,
  `site_name` varchar(255) NOT NULL,
  `site_desc` text NOT NULL,
  `site_address` text NOT NULL,
  `site_tel` varchar(50) DEFAULT NULL,
  `site_open_time` time DEFAULT NULL,
  `site_close_time` time DEFAULT NULL,
  `location_type` varchar(50) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `updated_at` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site`
--

INSERT INTO `site` (`id`, `site_name`, `site_desc`, `site_address`, `site_tel`, `site_open_time`, `site_close_time`, `location_type`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES
(1, 'สุขุมวิท 71', 'สุขุมวิท 71', '20/1 ถนนสุขุมวิท 71 แขวงพระโขนงเหนือ เขตวัฒนา กรุงเทพฯ 10110', '(02)538-2229 ต่อ 1', '08:00:00', '20:00:00', 'Point', 13.71479100, 100.59490800, '2024-12-03 16:15:42.891777', '2024-12-03 20:07:51.532791'),
(2, 'สำนักงานใหญ่', 'สำนักงานใหญ่', '2585/2 ถนนลาดพร้าว แขวงคลองเจ้าคุณสิงห์ เขตวังทองหลาง กรุงเทพฯ 10310', '(02)538-7900', '08:00:00', '20:00:00', 'Point', 0.00000000, 0.00000000, '2024-12-03 16:15:42.891777', '2024-12-03 20:07:43.759287'),
(3, 'สุขุมวิท 103', 'สุขุมวิท 103', '120 ถนนอุดมสุข แขวงบางนาเหนือ เขตบางนา กรุงเทพฯ 10260', '(02)538-2229 ต่อ 14', '08:00:00', '20:00:00', 'Point', 13.67861800, 100.61236100, '2024-12-03 16:15:42.891777', '2024-12-03 20:07:47.168409'),
(4, 'พัฒนาการ 20', 'พัฒนาการ 20', '702-702/1 ปากซอยพัฒนาการ 20 ถนนพัฒนาการ แขวงสวนหลวง เขตสวนหลวง กรุงเทพฯ 10250', '(02)538-2229 ต่อ 16', '08:00:00', '20:00:00', 'Point', 13.73743100, 100.60919900, '2024-12-03 16:15:42.891777', '2024-12-03 20:07:31.372183'),
(5, 'หทัยราษฎร์', 'หทัยราษฎร์', '133/9 ถนนหทัยราษฏร์ หน้าหมู่บ้านรื่นฤดี (โครงการ 3) แขวงมีนบุรี เขตมีนบุรี กรุงเทพฯ 10510', '(02)538-2229 ต่อ 18', '08:00:00', '20:00:00', 'Point', 13.82950400, 100.72012400, '2024-12-03 16:15:42.891777', '2024-12-03 20:07:54.975757'),
(6, 'รังสิต คลอง 1', 'รังสิต คลอง 1', '238 ถนนเลียบคลองรังสิต (คลอง 1 สะพานแดง) ตำบลประชาธิปัตย์ อำเภอธัญบุรี จังหวัดปทุมธานี 12110', '(02)538-2229 ต่อ 19', '08:00:00', '20:00:00', 'Point', 13.98570500, 100.62634100, '2024-12-03 16:15:42.891777', '2024-12-03 20:07:34.322639'),
(7, 'ถนนจันทน์', 'ถนนจันทน์', '234, 236 ถนนจันทน์ (ใกล้ปากซอยจันทน์ 18/4) แขวงทุ่งวัดดอน เขตสาทร กรุงเทพมหานคร 10120', '(02)538-2229 ต่อ 20', '08:00:00', '20:00:00', 'Point', 13.70619300, 100.52796400, '2024-12-03 16:15:42.891777', '2024-12-03 20:07:24.189917'),
(8, 'Daytime พระราม 4 (ซอยภูมิจิตร)', 'Daytime พระราม 4 (ซอยภูมิจิตร)', '4858 ถนนพระราม 4 (ใกล้ปากซอยภูมิจิตร) แขวงพระโขนง เขตคลองเตย กรุงเทพฯ 10110', '(02)538-2229 ต่อ 21', '08:00:00', '20:00:00', 'Point', 13.71317500, 100.59157100, '2024-12-03 16:15:42.891777', '2024-12-03 20:07:13.219760'),
(9, 'นาคนิวาส', 'นาคนิวาส', '15/3 หมู่ที่ 4 ถนนนาคนิวาส (ใกล้ปากซอยนาคนิวาส 48) แขวงลาดพร้าว เขตลาดพร้าว กรุงเทพฯ 10230', '(02)538-2229 ต่อ 22', '08:00:00', '20:00:00', 'Point', 13.82076000, 100.60917700, '2024-12-03 16:15:42.891777', '2024-12-03 20:07:27.382222'),
(10, 'ลาดปลาเค้า 63', 'ลาดปลาเค้า 63', '359 ถนนลาดปลาเค้า แขวงจรเข้บัว เขตลาดพร้าว กรุงเทพมหานคร 10310', '(02)538-2229 ต่อ 25', '08:00:00', '20:00:00', 'Point', 13.84549400, 100.60134800, '2024-12-03 16:15:42.891777', '2024-12-03 20:07:39.298440');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `site`
--
ALTER TABLE `site`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `site`
--
ALTER TABLE `site`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
