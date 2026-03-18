-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 18, 2026 at 10:24 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_rsvp_whatsapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_12_21_190319_add_whatsapp_fields_to_rsvp_guests', 2),
(5, '2026_01_18_153835_create_sms_recipients_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rsvp_guests`
--

CREATE TABLE `rsvp_guests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `rsvp_image` varchar(255) DEFAULT NULL,
  `whatsapp_sent` tinyint(1) NOT NULL DEFAULT 0,
  `whatsapp_sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rsvp_guests`
--

INSERT INTO `rsvp_guests` (`id`, `full_name`, `email`, `phone`, `rsvp_image`, `whatsapp_sent`, `whatsapp_sent_at`, `created_at`, `updated_at`) VALUES
(256, 'Demola Akanbi', NULL, '+447539519778', NULL, 1, '2026-03-18 20:23:25', NULL, '2026-03-18 20:23:25'),
(257, 'Kunbi Akanbi', NULL, '+2348098766454', NULL, 1, '2026-03-18 19:21:13', NULL, '2026-03-18 19:21:13'),
(258, 'Tolu Sadipe', NULL, '+2348028335404', NULL, 1, '2026-03-18 19:25:19', NULL, '2026-03-18 19:25:19'),
(259, 'Dipo Sadipe', NULL, '+2348034000707', NULL, 0, NULL, NULL, '2026-03-18 10:06:41'),
(260, 'Ladipo Sadipe', NULL, '+2348055676556', NULL, 0, NULL, NULL, '2026-03-18 10:06:46'),
(261, 'Lamide Sadipe', NULL, '+2348055676557', NULL, 0, NULL, NULL, '2026-03-18 10:06:52'),
(262, 'Modele', NULL, '+2348069326506', NULL, 0, NULL, NULL, '2026-03-18 10:06:57'),
(263, 'Ladapo', NULL, '+2348121715542', NULL, 0, NULL, NULL, '2026-03-18 10:07:04'),
(264, 'Yinka Solebo', NULL, '+2347060773060', NULL, 0, NULL, NULL, '2026-03-18 10:07:09'),
(265, 'Tunde Solebo', NULL, '+2347017323994', NULL, 0, NULL, NULL, '2026-03-18 10:07:15'),
(266, 'Femi Solebo', NULL, '+2348059700800', NULL, 0, NULL, NULL, '2026-03-18 10:08:21'),
(267, 'Sandra Solebo', NULL, '+2348033083770', NULL, 0, NULL, NULL, '2026-03-18 10:08:26'),
(268, 'Deen Solebo', NULL, '+2347037370456', NULL, 0, NULL, NULL, '2026-03-18 10:08:33'),
(269, 'Seri Solebo', NULL, '+2348033189242', NULL, 0, NULL, NULL, '2026-03-18 10:08:38'),
(270, 'Alhaji Abdullahi Sarki Mohammed', NULL, '+2348022237009', NULL, 0, NULL, NULL, '2026-03-18 10:08:44'),
(271, 'Amaka Onwughalu', NULL, '+2348033268599', NULL, 0, NULL, NULL, '2026-03-18 10:08:49'),
(272, 'Ven Onwughalu', NULL, '+2348033081266', NULL, 0, NULL, NULL, '2026-03-18 10:08:55'),
(273, 'Chinedu Okeke', NULL, '+2347088813133', NULL, 0, NULL, NULL, '2026-03-18 10:09:01'),
(274, 'Henry Ikem Obih', NULL, '+2348035250237', NULL, 0, NULL, NULL, '2026-03-18 10:09:07'),
(275, 'Ken Opara', NULL, '+2348051194389', NULL, 0, NULL, NULL, '2026-03-18 10:09:13'),
(276, 'Kevin Ugwuoke', NULL, '+2348087183777', NULL, 0, NULL, NULL, '2026-03-18 10:10:19'),
(277, 'Nelson Nweke', NULL, '+2348035551956', NULL, 0, NULL, NULL, '2026-03-18 10:10:24'),
(278, 'Nneka Onyeali-Ikpe', NULL, '+2348034341034', NULL, 0, NULL, NULL, '2026-03-18 10:10:30'),
(279, 'Ken Onyeali-Ikpe', NULL, '+2348022242156', NULL, 0, NULL, NULL, '2026-03-18 10:10:36'),
(280, 'Obiaku Okam', NULL, '+2348023150869', NULL, 0, NULL, NULL, '2026-03-18 10:10:41'),
(281, 'Pamela Shodipo', NULL, '+2348033064107', NULL, 0, NULL, NULL, '2026-03-18 10:10:48'),
(282, 'Ronke Bammeke', NULL, '+2349030002929', NULL, 0, NULL, NULL, '2026-03-18 10:10:53'),
(283, 'Stanley Amuchie', NULL, '+2348033083761', NULL, 0, NULL, NULL, '2026-03-18 10:10:58'),
(284, 'Sufiyanu Garba', NULL, '+2348036591534', NULL, 0, NULL, NULL, '2026-03-18 10:11:04'),
(285, 'Ezinwa', NULL, '+2348060109172', NULL, 0, NULL, NULL, '2026-03-18 10:11:10'),
(286, 'Emeka Nkemakolam', NULL, '+2348063098698', NULL, 0, NULL, NULL, '2026-03-18 10:12:16'),
(287, 'Nwanja Onyekwere', NULL, '+2348023120313', NULL, 0, NULL, NULL, '2026-03-18 10:12:22'),
(288, 'Wale Mesioye', NULL, '+2348023132407', NULL, 0, NULL, NULL, '2026-03-18 10:12:28'),
(289, 'Sam Okeke', NULL, '+2348087183518', NULL, 0, NULL, NULL, '2026-03-18 10:12:33'),
(290, 'Nnenna Kayode-Lawal', NULL, '+2348033078958', NULL, 0, NULL, NULL, '2026-03-18 10:12:39'),
(291, 'Nnamdi Iloh', NULL, '+2348033250258', NULL, 0, NULL, NULL, '2026-03-18 10:12:45'),
(292, 'Vera Odu', NULL, '+2347034253553', NULL, 0, NULL, NULL, '2026-03-18 10:12:51'),
(293, 'Hillary Dukor', NULL, '+2348023125449', NULL, 0, NULL, NULL, '2026-03-18 10:12:57'),
(294, 'Blessing Onyewuchi', NULL, '+2348039830670', NULL, 0, NULL, NULL, '2026-03-18 10:13:02'),
(295, 'Ifeoma Onibuje', NULL, '+2348178805236', NULL, 0, NULL, NULL, '2026-03-18 10:13:08'),
(296, 'Boye Ogunmolade', NULL, '+2348023130363', NULL, 0, NULL, NULL, '2026-03-18 10:14:13'),
(297, 'Adetunji Mustapha', NULL, '+2348021341367', NULL, 0, NULL, NULL, '2026-03-18 10:14:20'),
(298, 'Isaiah Ndukwe', NULL, '+2348093872654', NULL, 0, NULL, NULL, '2026-03-18 10:14:26'),
(299, 'Jude Monye', NULL, '+2348023140343', NULL, 0, NULL, NULL, '2026-03-18 10:14:32'),
(300, 'Meksley Nwagboh', NULL, '+2348037937640', NULL, 0, NULL, NULL, '2026-03-18 10:14:38'),
(301, 'Nnamdi Edekobi', NULL, '+2348033090896', NULL, 0, NULL, NULL, '2026-03-18 10:14:43'),
(302, 'Obiajulu Okafor', NULL, '+2348023115106', NULL, 0, NULL, NULL, '2026-03-18 10:14:49'),
(303, 'Victor Abejegah', NULL, '+2347038604089', NULL, 0, NULL, NULL, '2026-03-18 10:14:54'),
(304, 'Henry Asiegbu', NULL, '+2348032332288', NULL, 0, NULL, NULL, '2026-03-18 10:15:00'),
(305, 'Amanda Ezeani', NULL, '+2349056562762', NULL, 0, NULL, NULL, '2026-03-18 10:15:06'),
(306, 'Tomilola Onasanya', NULL, '+2348034038331', NULL, 0, NULL, NULL, '2026-03-18 10:16:11'),
(307, 'Chimaka Anunagba', NULL, '+2347049715322', NULL, 0, NULL, NULL, '2026-03-18 10:16:17'),
(308, 'Chidebem ugonna', NULL, '+2348106435440', NULL, 0, NULL, NULL, '2026-03-18 10:16:24'),
(309, 'Mobolaji sunmoni', NULL, '+2348071496365', NULL, 0, NULL, NULL, '2026-03-18 10:16:30'),
(310, 'Omonsegho Ibironke', NULL, '+2348027585096', NULL, 0, NULL, NULL, '2026-03-18 10:16:35'),
(311, 'Folarin Osinowo', NULL, '+2348023282727', NULL, 0, NULL, NULL, '2026-03-18 10:16:42'),
(312, 'Ronke Osinowo', NULL, '+2348033032211', NULL, 0, NULL, NULL, '2026-03-18 10:16:47'),
(313, 'Bayo Fadayiro', NULL, '+2348023187763', NULL, 0, NULL, NULL, '2026-03-18 10:16:53'),
(314, 'Eniola Fadaiyiro', NULL, '+2348023303089', NULL, 0, NULL, NULL, '2026-03-18 10:16:58'),
(315, 'Fola Coker', NULL, '+17708265215', NULL, 0, NULL, NULL, '2026-03-18 10:17:04'),
(316, 'Gbolahan Joshua', NULL, '+2347034081510', NULL, 0, NULL, NULL, '2026-03-18 10:18:10'),
(317, 'Ada Joshua', NULL, '+2348022222332', NULL, 0, NULL, NULL, '2026-03-18 10:18:16'),
(318, 'Kehinde Dada', NULL, '+2348105497923', NULL, 0, NULL, NULL, '2026-03-18 10:18:22'),
(319, 'Kike Dada', NULL, '+2348023787357', NULL, 0, NULL, NULL, '2026-03-18 10:18:28'),
(320, 'Gbenga Koya', NULL, '+2348033535533', NULL, 0, NULL, NULL, '2026-03-18 10:18:34'),
(321, 'Oye Akande', NULL, '+18323759400', NULL, 0, NULL, NULL, '2026-03-18 10:18:39'),
(322, 'Sanmi Sobowale', NULL, '+2347034112654', NULL, 0, NULL, NULL, '2026-03-18 10:18:45'),
(323, 'Obiye Sobowale', NULL, '+2348037862958', NULL, 0, NULL, NULL, '2026-03-18 10:18:51'),
(324, 'Solabomi Adedeji', NULL, '+2347055573009', NULL, 0, NULL, NULL, '2026-03-18 10:18:57'),
(325, 'Lekan Akinrinmade', NULL, '+2349094040404', NULL, 0, NULL, NULL, '2026-03-18 10:19:03'),
(326, 'Sike Akinrinmade', NULL, '+2348023808266', NULL, 0, NULL, NULL, '2026-03-18 10:20:09'),
(327, 'Temitayo Odetayo', NULL, '+2348050762796', NULL, 0, NULL, NULL, '2026-03-18 10:20:14'),
(328, 'Gbeminiyi Odetayo', NULL, '+2348023171531', NULL, 0, NULL, NULL, '2026-03-18 10:20:20'),
(329, 'Wole Ladipo', NULL, '+2348023224055', NULL, 0, NULL, NULL, '2026-03-18 10:20:26'),
(330, 'Juliet Ladipo', NULL, '+2347087588879', NULL, 0, NULL, NULL, '2026-03-18 10:20:31'),
(331, 'Demola Dada', NULL, '+2348134209459', NULL, 0, NULL, NULL, '2026-03-18 10:20:36'),
(332, 'Shade Dada', NULL, '+2348134206837', NULL, 0, NULL, NULL, '2026-03-18 10:20:42'),
(333, 'Adebola Hassan', NULL, '+2348028025088', NULL, 0, NULL, NULL, '2026-03-18 10:20:48'),
(334, 'Fadekemi Hassan', NULL, '+2348181133440', NULL, 0, NULL, NULL, '2026-03-18 10:20:53'),
(335, 'Tosin Ladipo', NULL, '+2348022228068', NULL, 0, NULL, NULL, '2026-03-18 10:20:58'),
(336, 'ABIMBOLA Femi', NULL, '+2348140000300', NULL, 0, NULL, NULL, '2026-03-18 10:22:04'),
(337, 'ADEGBOMIRE Abiodun', NULL, '+2348033063842', NULL, 0, NULL, NULL, '2026-03-18 10:22:10'),
(338, 'ADEGBOMIRE Adeniyi (SAN)', NULL, '+2348051271779', NULL, 0, NULL, NULL, '2026-03-18 10:22:15'),
(339, 'ADELOYE Bayonle', NULL, '+2348059342861', NULL, 0, NULL, NULL, '2026-03-18 10:22:21'),
(340, 'ADESANOYE Adedayo (Prince)', NULL, '+2348033279242', NULL, 0, NULL, NULL, '2026-03-18 10:22:27'),
(341, 'ADESUYI Olusegun', NULL, '+2348177000222', NULL, 0, NULL, NULL, '2026-03-18 10:22:33'),
(342, 'ADETONA Adebiyi (Prince)', NULL, '+2348022226988', NULL, 0, NULL, NULL, '2026-03-18 10:22:38'),
(343, 'ADEWUMI Ayodele', NULL, '+2348023045158', NULL, 0, NULL, NULL, '2026-03-18 10:22:44'),
(344, 'ADEYEMI Tope', NULL, '+2348030620555', NULL, 0, NULL, NULL, '2026-03-18 10:22:49'),
(345, 'ADEYEMO Dapo (Prince)', NULL, '+2348032002118', NULL, 0, NULL, NULL, '2026-03-18 10:22:55'),
(346, 'AGBOOLA Taiwo', NULL, '+2348026990795', NULL, 0, NULL, NULL, '2026-03-18 10:24:01'),
(347, 'AJOMALE Oluwole', NULL, '+2348022245484', NULL, 0, NULL, NULL, '2026-03-18 10:24:07'),
(348, 'AKAPO Yomi', NULL, '+2348022902860', NULL, 0, NULL, NULL, '2026-03-18 10:24:13'),
(349, 'AKINSETE Kehinde', NULL, '+2348022238170', NULL, 0, NULL, NULL, '2026-03-18 10:24:18'),
(350, 'AKINYERA Tunde (Prince)', NULL, '+2348056000005', NULL, 0, NULL, NULL, '2026-03-18 10:24:23'),
(351, 'ALAWOYA Ayodeji', NULL, '+2348033018156', NULL, 0, NULL, NULL, '2026-03-18 10:24:29'),
(352, 'AREO William (Otunba)', NULL, '+2349095575000', NULL, 0, NULL, NULL, '2026-03-18 10:24:34'),
(353, 'BALOGUN Adetunji', NULL, '+2348132539286', NULL, 0, NULL, NULL, '2026-03-18 10:24:40'),
(354, 'BALOGUN Segun', NULL, '+2349091111485', NULL, 0, NULL, NULL, '2026-03-18 10:24:46'),
(355, 'EBHOHIMHEN Ehianeta (High Chief)', NULL, '+2348027153333', NULL, 0, NULL, NULL, '2026-03-18 10:24:52'),
(356, 'FADAYIRO Adebayo', NULL, '+2348023187763', NULL, 0, NULL, NULL, '2026-03-18 10:25:57'),
(357, 'FADAYIRO Kehinde', NULL, '+2348034054908', NULL, 0, NULL, NULL, '2026-03-18 10:26:03'),
(358, 'FALOLA Olakunle (Sir.)', NULL, '+2348023003202', NULL, 0, NULL, NULL, '2026-03-18 10:26:09'),
(359, 'FAGBOLA Poju', NULL, '+2348033009516', NULL, 0, NULL, NULL, '2026-03-18 10:26:15'),
(360, 'JOSE Abubakar (Alhaji)', NULL, '+2348033068443', NULL, 0, NULL, NULL, '2026-03-18 10:26:21'),
(361, 'KAYODE Olufemi', NULL, '+2348022222599', NULL, 0, NULL, NULL, '2026-03-18 10:26:27'),
(362, 'LAMBO Lanre', NULL, '+2348022222817', NULL, 0, NULL, NULL, '2026-03-18 10:26:32'),
(363, 'MEBUDE Ayodeji', NULL, '+2348033041001', NULL, 0, NULL, NULL, '2026-03-18 10:26:38'),
(364, 'ODIYI Adesoji', NULL, '+2348033086340', NULL, 0, NULL, NULL, '2026-03-18 10:26:43'),
(365, 'ODUNAIYA Olurotimi', NULL, '+2349025921891', NULL, 0, NULL, NULL, '2026-03-18 10:26:49'),
(366, 'OFOMATA Chijioke', NULL, '+2348022225449', NULL, 0, NULL, NULL, '2026-03-18 10:27:55'),
(367, 'OGBEBOR Usifo (Sir.)', NULL, '+2347040000290', NULL, 0, NULL, NULL, '2026-03-18 10:28:01'),
(368, 'OGUNDELE Oye', NULL, '+2348033044713', NULL, 0, NULL, NULL, '2026-03-18 10:28:07'),
(369, 'OGUNRANTI Akin', NULL, '+2348035665555', NULL, 0, NULL, NULL, '2026-03-18 10:28:13'),
(370, 'OGUNRANTI Ayo', NULL, '+2348032001961', NULL, 0, NULL, NULL, '2026-03-18 10:28:20'),
(371, 'OKORODUDU Tomi', NULL, '+2348027627752', NULL, 0, NULL, NULL, '2026-03-18 10:28:26'),
(372, 'OKUWOBI Adewale', NULL, '+2348026990127', NULL, 0, NULL, NULL, '2026-03-18 10:28:31'),
(373, 'OKUWOBI Babatunde (Sir.)', NULL, '+2348032002052', NULL, 0, NULL, NULL, '2026-03-18 10:28:38'),
(374, 'OPEKE Segun', NULL, '+2348055125678', NULL, 0, NULL, NULL, '2026-03-18 10:28:45'),
(375, 'OREAGBA Abdulgafar (Alhaji)', NULL, '+2348023229951', NULL, 0, NULL, NULL, '2026-03-18 10:28:50'),
(376, 'TAIWO Adewale', NULL, '+2348032001167', NULL, 0, NULL, NULL, '2026-03-18 10:29:56'),
(377, 'Femi Wright', NULL, '+2348083135922', NULL, 0, NULL, NULL, '2026-03-18 10:30:02'),
(378, 'Lolade Dosumu', NULL, '+2348023183709', NULL, 0, NULL, NULL, '2026-03-18 10:30:08'),
(379, 'Gbolade Akinola', NULL, '+2348070365379', NULL, 0, NULL, NULL, '2026-03-18 10:30:14'),
(380, 'Jumoke Okuwobi', NULL, '+2348173457527', NULL, 0, NULL, NULL, '2026-03-18 10:30:20'),
(381, 'Abubakar Aliyu FGCKD', NULL, '+2348037021392', NULL, 0, NULL, NULL, '2026-03-18 10:30:26'),
(382, 'Ekei Duke', NULL, '+2348065794955', NULL, 0, NULL, NULL, '2026-03-18 10:30:32'),
(383, 'Bunmi Awonuga', NULL, '+2348027332910', NULL, 0, NULL, NULL, '2026-03-18 10:30:37'),
(384, 'Seyi Gambo', NULL, '+2348164636546', NULL, 0, NULL, NULL, '2026-03-18 10:30:43'),
(385, 'Femi Lawal', NULL, '+2348023163148', NULL, 0, NULL, NULL, '2026-03-18 10:30:48'),
(386, 'Demola Rufai', NULL, '+2348033011199', NULL, 0, NULL, NULL, '2026-03-18 10:31:54'),
(387, 'Azubuike', NULL, '+2348022909089', NULL, 0, NULL, NULL, '2026-03-18 10:32:00'),
(388, 'Michael Alley', NULL, '+2348023740840', NULL, 0, NULL, NULL, '2026-03-18 10:32:06'),
(389, 'Wemimo Coker', NULL, '+2347035645991', NULL, 0, NULL, NULL, '2026-03-18 10:32:11'),
(390, 'Rotimi Ige', NULL, '+2348053384048', NULL, 0, NULL, NULL, '2026-03-18 10:32:17'),
(391, 'Deji Ajayi', NULL, '+2347034111850', NULL, 0, NULL, NULL, '2026-03-18 10:32:22'),
(392, 'Kayode Aluko', NULL, '+2348184202406', NULL, 0, NULL, NULL, '2026-03-18 10:32:29'),
(393, 'Peju Aluko', NULL, '+2348023093343', NULL, 0, NULL, NULL, '2026-03-18 10:32:34'),
(394, 'Mugabo', NULL, '+2348108923699', NULL, 0, NULL, NULL, '2026-03-18 10:32:39'),
(395, 'Toyin Rufai (Fajingbesi)', NULL, '+2348033084654', NULL, 0, NULL, NULL, '2026-03-18 10:32:45'),
(396, 'Dapo Metz', NULL, '+2348033022485', NULL, 0, NULL, NULL, '2026-03-18 10:33:51'),
(397, 'Yemi Edun', NULL, '+447947351845', NULL, 0, NULL, NULL, '2026-03-18 10:33:58'),
(398, 'Tiwalade', NULL, '+2348033127287', NULL, 0, NULL, NULL, '2026-03-18 10:34:04'),
(399, 'Lawunmi Awosedo', NULL, '+2348090443221', NULL, 0, NULL, NULL, '2026-03-18 10:34:10'),
(400, 'Kola Karim', NULL, '+2348022500000', NULL, 0, NULL, NULL, '2026-03-18 10:34:15'),
(401, 'Tunde Karim', NULL, '+2348027339922', NULL, 0, NULL, NULL, '2026-03-18 10:34:21'),
(402, 'Tunde Morakinyo', NULL, '+2347058000096', NULL, 0, NULL, NULL, '2026-03-18 10:34:27'),
(403, 'Araba Morakinyo', NULL, '+2348149990009', NULL, 0, NULL, NULL, '2026-03-18 10:34:33'),
(404, 'Osagie', NULL, '+2348024726561', NULL, 0, NULL, NULL, '2026-03-18 10:34:38'),
(405, 'Chiedu', NULL, '+2348023376784', NULL, 0, NULL, NULL, '2026-03-18 10:34:44'),
(406, 'Femi c/o Otunba', NULL, '+2348095000012', NULL, 0, NULL, NULL, '2026-03-18 10:35:50'),
(407, 'Femi Fadeni', NULL, '+2349077111111', NULL, 0, NULL, NULL, '2026-03-18 10:35:56'),
(408, 'Bisi Adebutu', NULL, '+2349087990001', NULL, 0, NULL, NULL, '2026-03-18 10:36:02'),
(409, 'Eyo Asuquo', NULL, '+2348060506052', NULL, 0, NULL, NULL, '2026-03-18 10:36:07'),
(410, 'Tolu Ogunleye', NULL, '+2348077191522', NULL, 0, NULL, NULL, '2026-03-18 10:36:14'),
(411, 'Tayo Tulcan', NULL, '+2348033595930', NULL, 0, NULL, NULL, '2026-03-18 10:36:19'),
(412, 'Lekan Akinyanmi', NULL, '+16092338986', NULL, 0, NULL, NULL, '2026-03-18 10:36:25'),
(413, 'Edward', NULL, '+971521616425', NULL, 0, NULL, NULL, '2026-03-18 10:36:30'),
(414, 'Prof Adegbulugbe', NULL, '+2348035779500', NULL, 0, NULL, NULL, '2026-03-18 10:36:36'),
(415, 'Kayode Adegbulugbe', NULL, '+2348138471198', NULL, 0, NULL, NULL, '2026-03-18 10:36:42'),
(416, 'Segun Ilori', NULL, '+2348037172701', NULL, 0, NULL, NULL, '2026-03-18 10:37:48'),
(417, 'Spenser Onosode', NULL, '+2347034069336', NULL, 0, NULL, NULL, '2026-03-18 10:37:53'),
(418, 'Joseph Penawon', NULL, '+2348077391965', NULL, 0, NULL, NULL, '2026-03-18 10:37:59'),
(419, 'Olumide Shoyombo', NULL, '+2348023227212', NULL, 0, NULL, NULL, '2026-03-18 10:38:05'),
(420, 'Bode Makanjuola', NULL, '+2348091238999', NULL, 0, NULL, NULL, '2026-03-18 10:38:11'),
(421, 'Gbenga Obadina', NULL, '+2347066791579', NULL, 0, NULL, NULL, '2026-03-18 10:38:18'),
(422, 'Olumbe', NULL, '+2348098000122', NULL, 0, NULL, NULL, '2026-03-18 10:38:23'),
(423, 'Akin Rockston', NULL, '+2348033582791', NULL, 0, NULL, NULL, '2026-03-18 10:38:29'),
(424, 'Yinka Alakija', NULL, '+2349062834645', NULL, 0, NULL, NULL, '2026-03-18 10:38:35'),
(425, 'Gbolahan Citibank', NULL, '+2348051931681', NULL, 0, NULL, NULL, '2026-03-18 10:38:40'),
(426, 'Hakeem Muri Okunola', NULL, '+2348034030263', NULL, 0, NULL, NULL, NULL),
(427, 'Ladi Bada', NULL, '+2348085861114', NULL, 0, NULL, NULL, NULL),
(428, 'Deyemi Oreagba', NULL, '+2348028338451', NULL, 0, NULL, NULL, NULL),
(429, 'Tunji Ashiru', NULL, '+2348075370950', NULL, 0, NULL, NULL, NULL),
(430, 'Lanre', NULL, '+2349018933579', NULL, 0, NULL, NULL, NULL),
(431, 'Yiga', NULL, '+2348102662669', NULL, 0, NULL, NULL, NULL),
(432, 'Wole Ogunsanya', NULL, '+2348037127228', NULL, 0, NULL, NULL, NULL),
(433, 'Kunle Soname', NULL, '+2348023108224', NULL, 0, NULL, NULL, NULL),
(434, 'Feyi Agagu', NULL, '+2348033087378', NULL, 0, NULL, NULL, NULL),
(435, 'Chike Agbakoba', NULL, '+2348033022818', NULL, 0, NULL, NULL, NULL),
(436, 'Funsho Fenchurch', NULL, '+2349080088447', NULL, 0, NULL, NULL, NULL),
(437, 'Femi Bakare', NULL, '+2347062279468', NULL, 0, NULL, NULL, NULL),
(438, 'Zibo', NULL, '+2348023191751', NULL, 0, NULL, NULL, NULL),
(439, 'Afolabi Olorode', NULL, '+2347068687920', NULL, 0, NULL, NULL, NULL),
(440, 'Dayo Osilaja', NULL, '+2348027019999', NULL, 0, NULL, NULL, NULL),
(441, 'Mrs Osilaja', NULL, '+2348022234682', NULL, 0, NULL, NULL, NULL),
(442, 'Femi Adeniji', NULL, '+2348033301544', NULL, 0, NULL, NULL, NULL),
(443, 'Gbolahan Onibuje', NULL, '+2348098766660', NULL, 0, NULL, NULL, NULL),
(444, 'Santino', NULL, '+2348098150815', NULL, 0, NULL, NULL, NULL),
(445, 'Seun Ogunseinde Sewenwe', NULL, '+2348050905548', NULL, 0, NULL, NULL, NULL),
(446, 'Seun Okuwobi', NULL, '+2347056715251', NULL, 0, NULL, NULL, NULL),
(447, 'Tosin Odusanya', NULL, '+447939214692', NULL, 0, NULL, NULL, NULL),
(448, 'Toye Akindele', NULL, '+2348039780186', NULL, 0, NULL, NULL, NULL),
(449, 'Feyi Adedeji', NULL, '+2348137389969', NULL, 0, NULL, NULL, NULL),
(450, 'Meto', NULL, '+447958065789', NULL, 0, NULL, NULL, NULL),
(451, 'Tokunbo Alomaja', NULL, '+447946510336', NULL, 0, NULL, NULL, NULL),
(452, 'Sade Tejuosho', NULL, '+2347033434744', NULL, 0, NULL, NULL, NULL),
(453, 'Bola', NULL, '+447593238305', NULL, 0, NULL, NULL, NULL),
(454, 'Dupe Adeniji', NULL, '+2348033069060', NULL, 0, NULL, NULL, NULL),
(455, 'Funmi Faloye', NULL, '+2348033066836', NULL, 0, NULL, NULL, NULL),
(456, 'Segun Faloye', NULL, '+2348034064146', NULL, 0, NULL, NULL, NULL),
(457, 'Tolu Adetugbo', NULL, '+2348023166366', NULL, 0, NULL, NULL, NULL),
(458, 'Funmi Falola', NULL, '+2349160007173', NULL, 0, NULL, NULL, NULL),
(459, 'Doja Allen', NULL, '+2348088249788', NULL, 0, NULL, NULL, NULL),
(460, 'Sola Allen', NULL, '+2347088938684', NULL, 0, NULL, NULL, NULL),
(461, 'Bolanle Asuquo', NULL, '+2348034314724', NULL, 0, NULL, NULL, NULL),
(462, 'Puabra', NULL, '+2348038633147', NULL, 0, NULL, NULL, NULL),
(463, 'Toyin', NULL, '+2348023137963', NULL, 0, NULL, NULL, NULL),
(464, 'Barbara', NULL, '+2348034055805', NULL, 0, NULL, NULL, NULL),
(465, 'Seun Onanuga', NULL, '+2348033354457', NULL, 0, NULL, NULL, NULL),
(466, 'Yemi Ogidan', NULL, '+2348077770311', NULL, 0, NULL, NULL, NULL),
(467, 'Tope Obadina', NULL, '+2347034157583', NULL, 0, NULL, NULL, NULL),
(468, 'Seun Babs Jonah', NULL, '+2348032013400', NULL, 0, NULL, NULL, NULL),
(469, 'Babi', NULL, '+2348023014025', NULL, 0, NULL, NULL, NULL),
(470, 'Idowu Moradeyo', NULL, '+2347089908225', NULL, 0, NULL, NULL, NULL),
(471, 'Bimbo Omotosho', NULL, '+2348035351844', NULL, 0, NULL, NULL, NULL),
(472, 'Leye Akingbe', NULL, '+2348099744670', NULL, 0, NULL, NULL, NULL),
(473, 'Lolu Akingbe', NULL, '+2347038342166', NULL, 0, NULL, NULL, NULL),
(474, 'Folake Wright', NULL, '+2348069808295', NULL, 0, NULL, NULL, NULL),
(475, 'Moyo', NULL, '+2348033212055', NULL, 0, NULL, NULL, NULL),
(476, 'Sisi Zibiri', NULL, '+2348186868797', NULL, 0, NULL, NULL, NULL),
(477, 'Lola Idudu', NULL, '+2348033060499', NULL, 0, NULL, NULL, NULL),
(478, 'Joke', NULL, '+2348092927833', NULL, 0, NULL, NULL, NULL),
(479, 'Hauwa', NULL, '+2348170604276', NULL, 0, NULL, NULL, NULL),
(480, 'Ayodeji Atte', NULL, '+2348023044331', NULL, 0, NULL, NULL, NULL),
(481, 'Afam', NULL, '+2348037709069', NULL, 0, NULL, NULL, NULL),
(482, 'Jide Cole', NULL, '+2348052604514', NULL, 0, NULL, NULL, NULL),
(483, 'Okwudili', NULL, '+2348081139523', NULL, 0, NULL, NULL, NULL),
(484, 'Sola Lamidi', NULL, '+2348130703372', NULL, 0, NULL, NULL, NULL),
(485, 'Nestor', NULL, '+2348033040742', NULL, 0, NULL, NULL, NULL),
(486, 'Folorunsho', NULL, '+2348091541869', NULL, 0, NULL, NULL, NULL),
(487, 'Francis', NULL, '+2348069182425', NULL, 0, NULL, NULL, NULL),
(488, 'Femi Badeji', NULL, '+2348023914615', NULL, 0, NULL, NULL, NULL),
(489, 'Gboyega Oladele Vertex', NULL, '+2348091467732', NULL, 0, NULL, NULL, NULL),
(490, 'Israel Aye', NULL, '+2348129083595', NULL, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sms_recipients`
--

CREATE TABLE `sms_recipients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `phone` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `sent` tinyint(1) NOT NULL DEFAULT 0,
  `sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sms_recipients`
--

INSERT INTO `sms_recipients` (`id`, `phone`, `code`, `sent`, `sent_at`, `created_at`, `updated_at`) VALUES
(1, '+2347063590977', 'J1D7L', 1, '2026-01-18 17:21:44', '2026-01-18 18:02:28', '2026-01-18 17:21:44'),
(2, '+2348074043726', 'T6W2R', 1, '2026-01-18 17:21:48', '2026-01-18 18:02:28', '2026-01-18 17:21:48'),
(3, '+2348036196066', 'H4P9F', 1, '2026-01-18 17:21:52', '2026-01-18 18:02:28', '2026-01-18 17:21:52'),
(4, '+2347065946192', 'A1R5P', 1, '2026-01-18 17:21:56', '2026-01-18 18:02:28', '2026-01-18 17:21:56'),
(5, '+2347061557824', 'N3Q7T', 1, '2026-01-18 17:21:59', '2026-01-18 18:02:28', '2026-01-18 17:21:59'),
(6, '+2348062339751', 'B5Z8R', 1, '2026-01-18 17:22:03', '2026-01-18 18:02:28', '2026-01-18 17:22:03'),
(7, '+2348089876146', 'F9C7Z', 1, '2026-01-18 17:22:07', '2026-01-18 18:02:28', '2026-01-18 17:22:07'),
(8, '+2347032612967', 'R4W9X', 1, '2026-01-18 17:22:11', '2026-01-18 18:02:28', '2026-01-18 17:22:11'),
(9, '+2347038018612', 'Y5D7K', 1, '2026-01-18 17:22:15', '2026-01-18 18:02:28', '2026-01-18 17:22:15'),
(10, '+2348037876561', 'Z4R8N', 1, '2026-01-18 17:22:18', '2026-01-18 18:02:28', '2026-01-18 17:22:18'),
(11, '+2347065568317', 'Q7M2L', 1, '2026-01-18 17:22:23', '2026-01-18 18:02:28', '2026-01-18 17:22:23'),
(12, '+2347012830094', 'P7M5H', 1, '2026-01-18 17:22:26', '2026-01-18 18:02:28', '2026-01-18 17:22:26'),
(13, '+2348053073578', 'M8D2Z', 1, '2026-01-18 17:22:30', '2026-01-18 18:02:28', '2026-01-18 17:22:30'),
(14, '+2348060051717', 'L4P7A', 1, '2026-01-18 17:22:33', '2026-01-18 18:02:28', '2026-01-18 17:22:33'),
(15, '+2348032428132', 'E4Q9H', 1, '2026-01-18 17:22:37', '2026-01-18 18:02:28', '2026-01-18 17:22:37'),
(16, '+2348173019765', 'A6P8K', 1, '2026-01-18 17:22:40', '2026-01-18 18:02:28', '2026-01-18 17:22:40'),
(17, '+2348056079789', 'W5A8F', 1, '2026-01-18 17:22:44', '2026-01-18 18:02:28', '2026-01-18 17:22:44'),
(18, '+2348073831176', 'S2K9Z', 1, '2026-01-18 17:22:49', '2026-01-18 18:02:28', '2026-01-18 17:22:49'),
(19, '+2348073831176', 'T6M5C', 1, '2026-01-18 17:22:52', '2026-01-18 18:02:28', '2026-01-18 17:22:52'),
(20, '+2348132614151', 'Q3D6M', 1, '2026-01-18 17:22:57', '2026-01-18 18:02:28', '2026-01-18 17:22:57'),
(21, '+2348035986632', 'L6Q9F', 1, '2026-01-18 17:23:01', '2026-01-18 18:02:28', '2026-01-18 17:23:01'),
(22, '+2349076983705', 'G4P6H', 1, '2026-01-18 17:23:04', '2026-01-18 18:02:28', '2026-01-18 17:23:04'),
(23, '+2347038937327', 'WLKVN', 1, '2026-01-18 17:23:08', '2026-01-18 18:02:28', '2026-01-18 17:23:08'),
(24, '+2347038937327', 'B7K4M', 1, '2026-01-18 17:23:12', '2026-01-18 18:02:28', '2026-01-18 17:23:12'),
(25, '+2347038937327', 'C3R8T', 1, '2026-01-18 17:23:15', '2026-01-18 18:02:28', '2026-01-18 17:23:15'),
(26, '+2348033134056', 'Q1A9D', 1, '2026-01-18 17:23:19', '2026-01-18 18:02:28', '2026-01-18 17:23:19'),
(27, '+2348034621025', 'E9YW2', 1, '2026-01-18 17:23:22', '2026-01-18 18:02:28', '2026-01-18 17:23:22'),
(28, '+2348132558955', 'M3QE4', 1, '2026-01-18 17:23:26', '2026-01-18 18:02:28', '2026-01-18 17:23:26'),
(29, '+2347030116798', 'XY9F9', 1, '2026-01-18 17:23:29', '2026-01-18 18:02:28', '2026-01-18 17:23:29'),
(30, '+2348068499525', '5C2SI', 1, '2026-01-18 17:23:33', '2026-01-18 18:02:28', '2026-01-18 17:23:33'),
(31, '+2348135291229', 'T4X8B', 1, '2026-02-10 10:22:59', NULL, '2026-02-10 10:22:59');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `rsvp_guests`
--
ALTER TABLE `rsvp_guests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `sms_recipients`
--
ALTER TABLE `sms_recipients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `rsvp_guests`
--
ALTER TABLE `rsvp_guests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=491;

--
-- AUTO_INCREMENT for table `sms_recipients`
--
ALTER TABLE `sms_recipients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
