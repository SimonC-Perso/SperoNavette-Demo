-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le : dim. 13 août 2023 à 17:55
-- Version du serveur :  5.7.34
-- Version de PHP : 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `SperoNavette`
--
CREATE DATABASE IF NOT EXISTS `SperoNavette` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `SperoNavette`;

-- --------------------------------------------------------

--
-- Structure de la table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `street_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `street_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `box_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `addresses`
--

INSERT INTO `addresses` (`id`, `city_id`, `street_name`, `street_number`, `box_number`) VALUES
(1, 1335, 'Brussel south charleroi airport', NULL, NULL),
(2, 277, 'Brussels airport ', NULL, NULL),
(3, 1963, 'Rue de l’Aéroport (Liège airport)', NULL, NULL),
(4, 6, 'Av. Fonsny (Bruxelles-midi)', '47B', NULL),
(5, 2782, 'Aéroport CDG (FR)', NULL, NULL),
(6, 2784, 'Rte de l\'Aéroport (Aéroport de Lille-Lesquin)', NULL, NULL),
(7, 988, 'Nieuwpoortsesteenweg', '887', NULL),
(8, 2785, 'Rte de l\'Aéroport', NULL, NULL),
(9, 2786, 'Flughafenstraße', '105', NULL),
(10, 2787, 'Kennedystraße', NULL, NULL),
(11, 2788, 'Rue de Trèves', NULL, NULL),
(12, 2783, 'Aéroport Paris-Orly (ORY)', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `airports`
--

DROP TABLE IF EXISTS `airports`;
CREATE TABLE `airports` (
  `id` int(11) NOT NULL,
  `addresse_id` int(11) NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `airports`
--

INSERT INTO `airports` (`id`, `addresse_id`, `label`, `active`) VALUES
(1, 1, 'Aéroport de charleroi', 1),
(2, 2, 'Aéroport de Bruxelles', 1),
(3, 3, 'Aéroport de Liège', 1),
(4, 4, 'Brussel-Zuid/Midi', 1),
(5, 5, 'Aéroport de Paris-Charles de Gaulle', 1),
(6, 12, 'Aéroport de Paris-Orly (ORY)', 1),
(7, 6, 'Aéroport de Lille-Lesquin', 1),
(8, 7, 'Aéroport de Bruges-Ostende', 1),
(9, 8, 'Aéroport Paris-Beauvais', 1),
(10, 9, 'Aéroport international de Düsseldorf', 1),
(11, 10, 'Aéroport Konrad-Adenauer de Cologne-Bonn', 1),
(12, 11, 'Aéroport de Luxembourg', 1);

-- --------------------------------------------------------

--
-- Structure de la table `authorizations`
--

DROP TABLE IF EXISTS `authorizations`;
CREATE TABLE `authorizations` (
  `id` int(11) NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `baggage`
--

DROP TABLE IF EXISTS `baggage`;
CREATE TABLE `baggage` (
  `id` int(11) NOT NULL,
  `baggage_types` int(11) NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `baggage`
--

INSERT INTO `baggage` (`id`, `baggage_types`, `label`, `price`, `is_active`) VALUES
(1, 1, 'Valise cabinne', '10.00', 1);

-- --------------------------------------------------------

--
-- Structure de la table `baggage_types`
--

DROP TABLE IF EXISTS `baggage_types`;
CREATE TABLE `baggage_types` (
  `id` int(11) NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `baggage_types`
--

INSERT INTO `baggage_types` (`id`, `label`, `is_active`) VALUES
(1, 'Valises', 1),
(2, 'Sacs', 1),
(3, 'Chaises Roulantes', 1);

-- --------------------------------------------------------

--
-- Structure de la table `booking`
--

DROP TABLE IF EXISTS `booking`;
CREATE TABLE `booking` (
  `id` int(11) NOT NULL,
  `travel` int(11) NOT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `booking_date` datetime NOT NULL,
  `passenger` int(11) NOT NULL,
  `departure_date` datetime NOT NULL,
  `arrival_date` datetime NOT NULL,
  `arrival_flight_number` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departure_flight_number` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `booking_type_enum` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `booking_baggage`
--

DROP TABLE IF EXISTS `booking_baggage`;
CREATE TABLE `booking_baggage` (
  `id` int(11) NOT NULL,
  `baggage_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `quantity` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cities`
--

DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zipcode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cities`
--

INSERT INTO `cities` (`id`, `country_id`, `label`, `zipcode`) VALUES
(1, 22, 'Bruxelles', '1000'),
(2, 22, 'Laeken', '1020'),
(3, 22, 'Schaerbeek', '1030'),
(4, 22, 'Etterbeek', '1040'),
(5, 22, 'Ixelles', '1050'),
(6, 22, 'Saint-Gilles', '1060'),
(7, 22, 'Anderlecht', '1070'),
(8, 22, 'Molenbeek-Saint-Jean', '1080'),
(9, 22, 'Koekelberg', '1081'),
(10, 22, 'Berchem-Sainte-Agathe', '1082'),
(11, 22, 'Ganshoren', '1083'),
(12, 22, 'Jette', '1090'),
(13, 22, 'Neder-Over-Heembeek', '1120'),
(14, 22, 'Haren', '1130'),
(15, 22, 'Evere', '1140'),
(16, 22, 'Woluwe-Saint-Pierre', '1150'),
(17, 22, 'Auderghem', '1160'),
(18, 22, 'Watermael-Boitsfort', '1170'),
(19, 22, 'Uccle', '1180'),
(20, 22, 'Forest', '1190'),
(21, 22, 'Woluwe-Saint-Lambert', '1200'),
(22, 22, 'Saint-Josse-Ten-Noode', '1210'),
(23, 22, 'Antwerpen', '2000'),
(24, 22, 'Antwerpen', '2018'),
(25, 22, 'Antwerpen', '2020'),
(26, 22, 'Antwerpen', '2030'),
(27, 22, 'Antwerpen', '2040'),
(28, 22, 'Lillo', '2040'),
(29, 22, 'Zandvliet', '2040'),
(30, 22, 'Berendrecht', '2040'),
(31, 22, 'Antwerpen', '2050'),
(32, 22, 'Antwerpen', '2060'),
(33, 22, 'Burcht', '2070'),
(34, 22, 'Zwijndrecht', '2070'),
(35, 22, 'Deurne', '2100'),
(36, 22, 'Wijnegem', '2110'),
(37, 22, 'Borgerhout', '2140'),
(38, 22, 'Borsbeek', '2150'),
(39, 22, 'Wommelgem', '2160'),
(40, 22, 'Merksem', '2170'),
(41, 22, 'Ekeren', '2180'),
(42, 22, 'Noorderwijk', '2200'),
(43, 22, 'Herentals', '2200'),
(44, 22, 'Morkhoven', '2200'),
(45, 22, 'Hallaar', '2220'),
(46, 22, 'Heist-Op-Den-Berg', '2220'),
(47, 22, 'Booischot', '2221'),
(48, 22, 'Wiekevorst', '2222'),
(49, 22, 'Itegem', '2222'),
(50, 22, 'Schriek', '2223'),
(51, 22, 'Herselt', '2230'),
(52, 22, 'Ramsel', '2230'),
(53, 22, 'Hulshout', '2235'),
(54, 22, 'Houtvenne', '2235'),
(55, 22, 'Westmeerbeek', '2235'),
(56, 22, 'Viersel', '2240'),
(57, 22, 'Massenhoven', '2240'),
(58, 22, 'Zandhoven', '2240'),
(59, 22, 'Pulderbos', '2242'),
(60, 22, 'Pulle', '2243'),
(61, 22, 'Olen', '2250'),
(62, 22, 'Oevel', '2260'),
(63, 22, 'Westerlo', '2260'),
(64, 22, 'Tongerlo', '2260'),
(65, 22, 'Zoerle-Parwijs', '2260'),
(66, 22, 'Herenthout', '2270'),
(67, 22, 'Poederlee', '2275'),
(68, 22, 'Wechelderzande', '2275'),
(69, 22, 'Lille', '2275'),
(70, 22, 'Gierle', '2275'),
(71, 22, 'Grobbendonk', '2280'),
(72, 22, 'Bouwel', '2288'),
(73, 22, 'Vorselaar', '2290'),
(74, 22, 'Turnhout', '2300'),
(75, 22, 'Rijkevorsel', '2310'),
(76, 22, 'Hoogstraten', '2320'),
(77, 22, 'Meer', '2321'),
(78, 22, 'Minderhout', '2322'),
(79, 22, 'Wortel', '2323'),
(80, 22, 'Meerle', '2328'),
(81, 22, 'Merksplas', '2330'),
(82, 22, 'Vlimmeren', '2340'),
(83, 22, 'Beerse', '2340'),
(84, 22, 'Vosselaar', '2350'),
(85, 22, 'Oud-Turnhout', '2360'),
(86, 22, 'Arendonk', '2370'),
(87, 22, 'Ravels', '2380'),
(88, 22, 'Weelde', '2381'),
(89, 22, 'Poppel', '2382'),
(90, 22, 'Baarle-Hertog', '2387'),
(91, 22, 'Oostmalle', '2390'),
(92, 22, 'Westmalle', '2390'),
(93, 22, 'Malle', '2390'),
(94, 22, 'Mol', '2400'),
(95, 22, 'Eindhout', '2430'),
(96, 22, 'Vorst', '2430'),
(97, 22, 'Laakdal', '2430'),
(98, 22, 'Veerle', '2431'),
(99, 22, 'Varendonk', '2431'),
(100, 22, 'Geel', '2440'),
(101, 22, 'Meerhout', '2450'),
(102, 22, 'Tielen', '2460'),
(103, 22, 'Kasterlee', '2460'),
(104, 22, 'Lichtaart', '2460'),
(105, 22, 'Retie', '2470'),
(106, 22, 'Dessel', '2480'),
(107, 22, 'Balen', '2490'),
(108, 22, 'Olmen', '2491'),
(109, 22, 'Lier', '2500'),
(110, 22, 'Koningshooikt', '2500'),
(111, 22, 'Ranst', '2520'),
(112, 22, 'Emblem', '2520'),
(113, 22, 'Oelegem', '2520'),
(114, 22, 'Broechem', '2520'),
(115, 22, 'Boechout', '2530'),
(116, 22, 'Vremde', '2531'),
(117, 22, 'Hove', '2540'),
(118, 22, 'Lint', '2547'),
(119, 22, 'Kontich', '2550'),
(120, 22, 'Waarloos', '2550'),
(121, 22, 'Bevel', '2560'),
(122, 22, 'Nijlen', '2560'),
(123, 22, 'Kessel', '2560'),
(124, 22, 'Duffel', '2570'),
(125, 22, 'Putte', '2580'),
(126, 22, 'Beerzel', '2580'),
(127, 22, 'Gestel', '2590'),
(128, 22, 'Berlaar', '2590'),
(129, 22, 'Berchem', '2600'),
(130, 22, 'Wilrijk', '2610'),
(131, 22, 'Hemiksem', '2620'),
(132, 22, 'Schelle', '2627'),
(133, 22, 'Aartselaar', '2630'),
(134, 22, 'Mortsel', '2640'),
(135, 22, 'Edegem', '2650'),
(136, 22, 'Hoboken', '2660'),
(137, 22, 'Mechelen', '2800'),
(138, 22, 'Walem', '2800'),
(139, 22, 'Heffen', '2801'),
(140, 22, 'Hombeek', '2811'),
(141, 22, 'Leest', '2811'),
(142, 22, 'Muizen', '2812'),
(143, 22, 'Bonheiden', '2820'),
(144, 22, 'Rijmenam', '2820'),
(145, 22, 'Heindonk', '2830'),
(146, 22, 'Tisselt', '2830'),
(147, 22, 'Blaasveld', '2830'),
(148, 22, 'Willebroek', '2830'),
(149, 22, 'Terhagen', '2840'),
(150, 22, 'Reet', '2840'),
(151, 22, 'Rumst', '2840'),
(152, 22, 'Niel', '2845'),
(153, 22, 'Boom', '2850'),
(154, 22, 'Sint-Katelijne-Waver', '2860'),
(155, 22, 'Onze-Lieve-Vrouw-Waver', '2861'),
(156, 22, 'Puurs-Sint-Amands', '2870'),
(157, 22, 'Puurs', '2870'),
(158, 22, 'Ruisbroek', '2870'),
(159, 22, 'Liezele', '2870'),
(160, 22, 'Breendonk', '2870'),
(161, 22, 'Mariekerke', '2880'),
(162, 22, 'Bornem', '2880'),
(163, 22, 'Weert', '2880'),
(164, 22, 'Hingene', '2880'),
(165, 22, 'Sint-Amands', '2890'),
(166, 22, 'Oppuurs', '2890'),
(167, 22, 'Lippelo', '2890'),
(168, 22, 'Schoten', '2900'),
(169, 22, 'Essen', '2910'),
(170, 22, 'Kalmthout', '2920'),
(171, 22, 'Brasschaat', '2930'),
(172, 22, 'Hoevenen', '2940'),
(173, 22, 'Stabroek', '2940'),
(174, 22, 'Kapellen', '2950'),
(175, 22, 'Sint-Job-In-\'T-Goor', '2960'),
(176, 22, 'Brecht', '2960'),
(177, 22, 'Sint-Lenaarts', '2960'),
(178, 22, '\'S Gravenwezel', '2970'),
(179, 22, 'Schilde', '2970'),
(180, 22, 'Zoersel', '2980'),
(181, 22, 'Halle', '2980'),
(182, 22, 'Loenhout', '2990'),
(183, 22, 'Wuustwezel', '2990'),
(184, 22, 'Halle', '1500'),
(185, 22, 'Buizingen', '1501'),
(186, 22, 'Lembeek', '1502'),
(187, 22, 'Herne', '1540'),
(188, 22, 'Herfelingen', '1540'),
(189, 22, 'Sint-Pieters-Kapelle', '1541'),
(190, 22, 'Biévène', '1547'),
(191, 22, 'Hoeilaart', '1560'),
(192, 22, 'Galmaarden', '1570'),
(193, 22, 'Vollezele', '1570'),
(194, 22, 'Tollembeek', '1570'),
(195, 22, 'Sint-Pieters-Leeuw', '1600'),
(196, 22, 'Oudenaken', '1600'),
(197, 22, 'Sint-Laureins-Berchem', '1600'),
(198, 22, 'Ruisbroek', '1601'),
(199, 22, 'Vlezenbeek', '1602'),
(200, 22, 'Drogenbos', '1620'),
(201, 22, 'Linkebeek', '1630'),
(202, 22, 'Rhode-Saint-Genèse', '1640'),
(203, 22, 'Beersel', '1650'),
(204, 22, 'Lot', '1651'),
(205, 22, 'Alsemberg', '1652'),
(206, 22, 'Dworp', '1653'),
(207, 22, 'Huizingen', '1654'),
(208, 22, 'Bogaarden', '1670'),
(209, 22, 'Pepingen', '1670'),
(210, 22, 'Heikruis', '1670'),
(211, 22, 'Elingen', '1671'),
(212, 22, 'Beert', '1673'),
(213, 22, 'Bellingen', '1674'),
(214, 22, 'Sint-Martens-Bodegem', '1700'),
(215, 22, 'Dilbeek', '1700'),
(216, 22, 'Sint-Ulriks-Kapelle', '1700'),
(217, 22, 'Itterbeek', '1701'),
(218, 22, 'Groot-Bijgaarden', '1702'),
(219, 22, 'Schepdaal', '1703'),
(220, 22, 'Bekkerzeel', '1730'),
(221, 22, 'Kobbegem', '1730'),
(222, 22, 'Mollem', '1730'),
(223, 22, 'Asse', '1730'),
(224, 22, 'Zellik', '1731'),
(225, 22, 'Relegem', '1731'),
(226, 22, 'Ternat', '1740'),
(227, 22, 'Wambeek', '1741'),
(228, 22, 'Sint-Katherina-Lombeek', '1742'),
(229, 22, 'Mazenzele', '1745'),
(230, 22, 'Opwijk', '1745'),
(231, 22, 'Lennik', '1750'),
(232, 22, 'Sint-Kwintens-Lennik', '1750'),
(233, 22, 'Gaasbeek', '1750'),
(234, 22, 'Sint-Martens-Lennik', '1750'),
(235, 22, 'Oetingen', '1755'),
(236, 22, 'Kester', '1755'),
(237, 22, 'Gooik', '1755'),
(238, 22, 'Leerbeek', '1755'),
(239, 22, 'Strijtem', '1760'),
(240, 22, 'Pamel', '1760'),
(241, 22, 'Roosdaal', '1760'),
(242, 22, 'Onze-Lieve-Vrouw-Lombeek', '1760'),
(243, 22, 'Borchtlombeek', '1761'),
(244, 22, 'Liedekerke', '1770'),
(245, 22, 'Wemmel', '1780'),
(246, 22, 'Brussegem', '1785'),
(247, 22, 'Hamme', '1785'),
(248, 22, 'Merchtem', '1785'),
(249, 22, 'Hekelgem', '1790'),
(250, 22, 'Affligem', '1790'),
(251, 22, 'Essene', '1790'),
(252, 22, 'Teralfene', '1790'),
(253, 22, 'Vilvoorde', '1800'),
(254, 22, 'Peutie', '1800'),
(255, 22, 'Steenokkerzeel', '1820'),
(256, 22, 'Perk', '1820'),
(257, 22, 'Melsbroek', '1820'),
(258, 22, 'Machelen', '1830'),
(259, 22, 'Diegem', '1831'),
(260, 22, 'Malderen', '1840'),
(261, 22, 'Londerzeel', '1840'),
(262, 22, 'Steenhuffel', '1840'),
(263, 22, 'Grimbergen', '1850'),
(264, 22, 'Humbeek', '1851'),
(265, 22, 'Beigem', '1852'),
(266, 22, 'Strombeek-Bever', '1853'),
(267, 22, 'Meise', '1860'),
(268, 22, 'Wolvertem', '1861'),
(269, 22, 'Nieuwenrode', '1880'),
(270, 22, 'Ramsdonk', '1880'),
(271, 22, 'Kapelle-Op-Den-Bos', '1880'),
(272, 22, 'Nederokkerzeel', '1910'),
(273, 22, 'Buken', '1910'),
(274, 22, 'Kampenhout', '1910'),
(275, 22, 'Berg', '1910'),
(276, 22, 'Nossegem', '1930'),
(277, 22, 'Zaventem', '1930'),
(278, 22, 'Sint-Stevens-Woluwe', '1932'),
(279, 22, 'Sterrebeek', '1933'),
(280, 22, 'Kraainem', '1950'),
(281, 22, 'Wezembeek-Oppem', '1970'),
(282, 22, 'Zemst', '1980'),
(283, 22, 'Eppegem', '1980'),
(284, 22, 'Hofstade', '1981'),
(285, 22, 'Elewijt', '1982'),
(286, 22, 'Weerde', '1982'),
(287, 22, 'Leuven', '3000'),
(288, 22, 'Heverlee', '3001'),
(289, 22, 'Kessel Lo', '3010'),
(290, 22, 'Wilsele', '3012'),
(291, 22, 'Wijgmaal', '3018'),
(292, 22, 'Winksele', '3020'),
(293, 22, 'Herent', '3020'),
(294, 22, 'Veltem-Beisem', '3020'),
(295, 22, 'Neerijse', '3040'),
(296, 22, 'Sint-Agatha-Rode', '3040'),
(297, 22, 'Loonbeek', '3040'),
(298, 22, 'Ottenburg', '3040'),
(299, 22, 'Huldenberg', '3040'),
(300, 22, 'Oud-Heverlee', '3050'),
(301, 22, 'Sint-Joris-Weert', '3051'),
(302, 22, 'Blanden', '3052'),
(303, 22, 'Haasrode', '3053'),
(304, 22, 'Vaalbeek', '3054'),
(305, 22, 'Bertem', '3060'),
(306, 22, 'Korbeek-Dijle', '3060'),
(307, 22, 'Leefdaal', '3061'),
(308, 22, 'Kortenberg', '3070'),
(309, 22, 'Erps-Kwerps', '3071'),
(310, 22, 'Everberg', '3078'),
(311, 22, 'Meerbeek', '3078'),
(312, 22, 'Tervuren', '3080'),
(313, 22, 'Duisburg', '3080'),
(314, 22, 'Vossem', '3080'),
(315, 22, 'Overijse', '3090'),
(316, 22, 'Rotselaar', '3110'),
(317, 22, 'Wezemaal', '3111'),
(318, 22, 'Werchter', '3118'),
(319, 22, 'Tremelo', '3120'),
(320, 22, 'Baal', '3128'),
(321, 22, 'Betekom', '3130'),
(322, 22, 'Begijnendijk', '3130'),
(323, 22, 'Keerbergen', '3140'),
(324, 22, 'Tildonk', '3150'),
(325, 22, 'Haacht', '3150'),
(326, 22, 'Wespelaar', '3150'),
(327, 22, 'Boortmeerbeek', '3190'),
(328, 22, 'Hever', '3191'),
(329, 22, 'Aarschot', '3200'),
(330, 22, 'Gelrode', '3200'),
(331, 22, 'Langdorp', '3201'),
(332, 22, 'Rillaar', '3202'),
(333, 22, 'Linden', '3210'),
(334, 22, 'Lubbeek', '3210'),
(335, 22, 'Binkom', '3211'),
(336, 22, 'Pellenberg', '3212'),
(337, 22, 'Kortrijk-Dutsel', '3220'),
(338, 22, 'Holsbeek', '3220'),
(339, 22, 'Sint-Pieters-Rode', '3220'),
(340, 22, 'Nieuwrode', '3221'),
(341, 22, 'Scherpenheuvel-Zichem', '3270'),
(342, 22, 'Scherpenheuvel', '3270'),
(343, 22, 'Zichem', '3271'),
(344, 22, 'Averbode', '3271'),
(345, 22, 'Messelbroek', '3272'),
(346, 22, 'Testelt', '3272'),
(347, 22, 'Deurne', '3290'),
(348, 22, 'Webbekom', '3290'),
(349, 22, 'Schaffen', '3290'),
(350, 22, 'Diest', '3290'),
(351, 22, 'Kaggevinne', '3293'),
(352, 22, 'Molenstede', '3294'),
(353, 22, 'Bost', '3300'),
(354, 22, 'Tienen', '3300'),
(355, 22, 'Oorbeek', '3300'),
(356, 22, 'Hakendover', '3300'),
(357, 22, 'Goetsenhoven', '3300'),
(358, 22, 'Vissenaken', '3300'),
(359, 22, 'Oplinter', '3300'),
(360, 22, 'Kumtich', '3300'),
(361, 22, 'Sint-Margriete-Houtem', '3300'),
(362, 22, 'Meldert', '3320'),
(363, 22, 'Hoegaarden', '3320'),
(364, 22, 'Outgaarden', '3321'),
(365, 22, 'Drieslinter', '3350'),
(366, 22, 'Wommersom', '3350'),
(367, 22, 'Neerlinter', '3350'),
(368, 22, 'Overhespen', '3350'),
(369, 22, 'Neerhespen', '3350'),
(370, 22, 'Linter', '3350'),
(371, 22, 'Melkwezer', '3350'),
(372, 22, 'Orsmaal-Gussenhoven', '3350'),
(373, 22, 'Opvelp', '3360'),
(374, 22, 'Korbeek-Lo', '3360'),
(375, 22, 'Lovenjoel', '3360'),
(376, 22, 'Bierbeek', '3360'),
(377, 22, 'Roosbeek', '3370'),
(378, 22, 'Kerkom', '3370'),
(379, 22, 'Boutersem', '3370'),
(380, 22, 'Neervelp', '3370'),
(381, 22, 'Willebringen', '3370'),
(382, 22, 'Vertrijk', '3370'),
(383, 22, 'Glabbeek', '3380'),
(384, 22, 'Bunsbeek', '3380'),
(385, 22, 'Kapellen', '3381'),
(386, 22, 'Attenrode', '3384'),
(387, 22, 'Tielt', '3390'),
(388, 22, 'Tielt-Winge', '3390'),
(389, 22, 'Houwaart', '3390'),
(390, 22, 'Sint-Joris-Winge', '3390'),
(391, 22, 'Meensel-Kiezegem', '3391'),
(392, 22, 'Wange', '3400'),
(393, 22, 'Laar', '3400'),
(394, 22, 'Ezemaal', '3400'),
(395, 22, 'Landen', '3400'),
(396, 22, 'Neerwinden', '3400'),
(397, 22, 'Eliksem', '3400'),
(398, 22, 'Rumsdorp', '3400'),
(399, 22, 'Overwinden', '3400'),
(400, 22, 'Wezeren', '3401'),
(401, 22, 'Walshoutem', '3401'),
(402, 22, 'Waasmont', '3401'),
(403, 22, 'Walsbets', '3401'),
(404, 22, 'Attenhoven', '3404'),
(405, 22, 'Neerlanden', '3404'),
(406, 22, 'Dormaal', '3440'),
(407, 22, 'Zoutleeuw', '3440'),
(408, 22, 'Helen-Bos', '3440'),
(409, 22, 'Halle-Booienhoven', '3440'),
(410, 22, 'Budingen', '3440'),
(411, 22, 'Grazen', '3450'),
(412, 22, 'Geetbets', '3450'),
(413, 22, 'Rummen', '3454'),
(414, 22, 'Bekkevoort', '3460'),
(415, 22, 'Assent', '3460'),
(416, 22, 'Molenbeek-Wersbeek', '3461'),
(417, 22, 'Kortenaken', '3470'),
(418, 22, 'Ransberg', '3470'),
(419, 22, 'Sint-Margriete-Houtem', '3470'),
(420, 22, 'Hoeleden', '3471'),
(421, 22, 'Kersbeek-Miskom', '3472'),
(422, 22, 'Waanrode', '3473'),
(423, 22, 'Sint-Lambrechts-Herk', '3500'),
(424, 22, 'Hasselt', '3500'),
(425, 22, 'Wimmertingen', '3501'),
(426, 22, 'Kermt', '3510'),
(427, 22, 'Spalbeek', '3510'),
(428, 22, 'Stokrooie', '3511'),
(429, 22, 'Kuringen', '3511'),
(430, 22, 'Stevoort', '3512'),
(431, 22, 'Zonhoven', '3520'),
(432, 22, 'Houthalen-Helchteren', '3530'),
(433, 22, 'Helchteren', '3530'),
(434, 22, 'Houthalen', '3530'),
(435, 22, 'Schulen', '3540'),
(436, 22, 'Berbroek', '3540'),
(437, 22, 'Donk', '3540'),
(438, 22, 'Herk-De-Stad', '3540'),
(439, 22, 'Zelem', '3545'),
(440, 22, 'Halen', '3545'),
(441, 22, 'Loksbergen', '3545'),
(442, 22, 'Heusden', '3550'),
(443, 22, 'Zolder', '3550'),
(444, 22, 'Heusden-Zolder', '3550'),
(445, 22, 'Meldert', '3560'),
(446, 22, 'Linkhout', '3560'),
(447, 22, 'Lummen', '3560'),
(448, 22, 'Alken', '3570'),
(449, 22, 'Beringen', '3580'),
(450, 22, 'Beverlo', '3581'),
(451, 22, 'Koersel', '3582'),
(452, 22, 'Paal', '3583'),
(453, 22, 'Diepenbeek', '3590'),
(454, 22, 'Genk', '3600'),
(455, 22, 'Lanaken', '3620'),
(456, 22, 'Gellik', '3620'),
(457, 22, 'Veldwezelt', '3620'),
(458, 22, 'Neerharen', '3620'),
(459, 22, 'Rekem', '3621'),
(460, 22, 'Maasmechelen', '3630'),
(461, 22, 'Eisden', '3630'),
(462, 22, 'Vucht', '3630'),
(463, 22, 'Meeswijk', '3630'),
(464, 22, 'Leut', '3630'),
(465, 22, 'Mechelen-Aan-De-Maas', '3630'),
(466, 22, 'Opgrimbie', '3630'),
(467, 22, 'Uikhoven', '3631'),
(468, 22, 'Boorsem', '3631'),
(469, 22, 'Kessenich', '3640'),
(470, 22, 'Molenbeersel', '3640'),
(471, 22, 'Ophoven', '3640'),
(472, 22, 'Kinrooi', '3640'),
(473, 22, 'Elen', '3650'),
(474, 22, 'Dilsen-Stokkem', '3650'),
(475, 22, 'Stokkem', '3650'),
(476, 22, 'Rotem', '3650'),
(477, 22, 'Dilsen', '3650'),
(478, 22, 'Lanklaar', '3650'),
(479, 22, 'Opglabbeek', '3660'),
(480, 22, 'As', '3665'),
(481, 22, 'Niel-Bij-As', '3668'),
(482, 22, 'Gruitrode', '3670'),
(483, 22, 'Neerglabbeek', '3670'),
(484, 22, 'Wijshagen', '3670'),
(485, 22, 'Oudsbergen', '3670'),
(486, 22, 'Ellikom', '3670'),
(487, 22, 'Meeuwen', '3670'),
(488, 22, 'Maaseik', '3680'),
(489, 22, 'Opoeteren', '3680'),
(490, 22, 'Neeroeteren', '3680'),
(491, 22, 'Zutendaal', '3690'),
(492, 22, 'Tongeren', '3700'),
(493, 22, 'Sluizen', '3700'),
(494, 22, 'Vreren', '3700'),
(495, 22, 'Koninksem', '3700'),
(496, 22, 'Overrepen', '3700'),
(497, 22, 'Rutten', '3700'),
(498, 22, 'Diets-Heur', '3700'),
(499, 22, 'Kolmont', '3700'),
(500, 22, 'Nerem', '3700'),
(501, 22, 'Riksingen', '3700'),
(502, 22, 'Haren', '3700'),
(503, 22, 'Henis', '3700'),
(504, 22, 'Widooie', '3700'),
(505, 22, 'Mal', '3700'),
(506, 22, 'Neerrepen', '3700'),
(507, 22, 'Lauw', '3700'),
(508, 22, '\'S Herenelderen', '3700'),
(509, 22, 'Berg', '3700'),
(510, 22, 'Piringen', '3700'),
(511, 22, 'Herstappe', '3717'),
(512, 22, 'Kortessem', '3720'),
(513, 22, 'Vliermaalroot', '3721'),
(514, 22, 'Wintershoven', '3722'),
(515, 22, 'Guigoven', '3723'),
(516, 22, 'Vliermaal', '3724'),
(517, 22, 'Werm', '3730'),
(518, 22, 'Romershoven', '3730'),
(519, 22, 'Hoeselt', '3730'),
(520, 22, 'Sint-Huibrechts-Hern', '3730'),
(521, 22, 'Schalkhoven', '3732'),
(522, 22, 'Kleine-Spouwen', '3740'),
(523, 22, 'Bilzen', '3740'),
(524, 22, 'Hees', '3740'),
(525, 22, 'Beverst', '3740'),
(526, 22, 'Grote-Spouwen', '3740'),
(527, 22, 'Waltwilder', '3740'),
(528, 22, 'Rijkhoven', '3740'),
(529, 22, 'Munsterbilzen', '3740'),
(530, 22, 'Eigenbilzen', '3740'),
(531, 22, 'Mopertingen', '3740'),
(532, 22, 'Rosmeer', '3740'),
(533, 22, 'Martenslinde', '3742'),
(534, 22, 'Hoelbeek', '3746'),
(535, 22, 'Herderen', '3770'),
(536, 22, 'Val-Meer', '3770'),
(537, 22, 'Kanne', '3770'),
(538, 22, 'Membruggen', '3770'),
(539, 22, 'Vlijtingen', '3770'),
(540, 22, 'Zichen-Zussen-Bolder', '3770'),
(541, 22, 'Millen', '3770'),
(542, 22, 'Vroenhoven', '3770'),
(543, 22, 'Riemst', '3770'),
(544, 22, 'Genoelselderen', '3770'),
(545, 22, 'Fouron-Saint-Martin', '3790'),
(546, 22, 'Mouland', '3790'),
(547, 22, 'Fourons', '3790'),
(548, 22, 'Remersdaal', '3791'),
(549, 22, 'Fouron-Saint-Pierre', '3792'),
(550, 22, 'Teuven', '3793'),
(551, 22, 'Fouron-Le-Comte', '3798'),
(552, 22, 'Halmaal', '3800'),
(553, 22, 'Ordingen', '3800'),
(554, 22, 'Sint-Truiden', '3800'),
(555, 22, 'Groot-Gelmen', '3800'),
(556, 22, 'Kerkom-Bij-Sint-Truiden', '3800'),
(557, 22, 'Zepperen', '3800'),
(558, 22, 'Brustem', '3800'),
(559, 22, 'Aalst', '3800'),
(560, 22, 'Engelmanshoven', '3800'),
(561, 22, 'Gelinden', '3800'),
(562, 22, 'Runkelen', '3803'),
(563, 22, 'Gorsem', '3803'),
(564, 22, 'Duras', '3803'),
(565, 22, 'Wilderen', '3803'),
(566, 22, 'Velm', '3806'),
(567, 22, 'Berlingen', '3830'),
(568, 22, 'Wellen', '3830'),
(569, 22, 'Herten', '3831'),
(570, 22, 'Ulbeek', '3832'),
(571, 22, 'Bommershoven', '3840'),
(572, 22, 'Hoepertingen', '3840'),
(573, 22, 'Kerniel', '3840'),
(574, 22, 'Jesseren', '3840'),
(575, 22, 'Broekom', '3840'),
(576, 22, 'Kolmont', '3840'),
(577, 22, 'Gotem', '3840'),
(578, 22, 'Kuttekoven', '3840'),
(579, 22, 'Hendrieken', '3840'),
(580, 22, 'Gors-Opleeuw', '3840'),
(581, 22, 'Haren', '3840'),
(582, 22, 'Borgloon', '3840'),
(583, 22, 'Groot-Loon', '3840'),
(584, 22, 'Voort', '3840'),
(585, 22, 'Rijkel', '3840'),
(586, 22, 'Nieuwerkerken', '3850'),
(587, 22, 'Kozen', '3850'),
(588, 22, 'Binderveld', '3850'),
(589, 22, 'Wijer', '3850'),
(590, 22, 'Gutshoven', '3870'),
(591, 22, 'Mettekoven', '3870'),
(592, 22, 'Rukkelingen-Loon', '3870'),
(593, 22, 'Batsheers', '3870'),
(594, 22, 'Mechelen-Bovelingen', '3870'),
(595, 22, 'Klein-Gelmen', '3870'),
(596, 22, 'Vechmaal', '3870'),
(597, 22, 'Veulen', '3870'),
(598, 22, 'Bovelingen', '3870'),
(599, 22, 'Heers', '3870'),
(600, 22, 'Heks', '3870'),
(601, 22, 'Opheers', '3870'),
(602, 22, 'Horpmaal', '3870'),
(603, 22, 'Montenaken', '3890'),
(604, 22, 'Boekhout', '3890'),
(605, 22, 'Kortijs', '3890'),
(606, 22, 'Gingelom', '3890'),
(607, 22, 'Jeuk', '3890'),
(608, 22, 'Vorsen', '3890'),
(609, 22, 'Niel-Bij-Sint-Truiden', '3890'),
(610, 22, 'Buvingen', '3891'),
(611, 22, 'Muizen', '3891'),
(612, 22, 'Mielen-Boven-Aalst', '3891'),
(613, 22, 'Borlo', '3891'),
(614, 22, 'Overpelt', '3900'),
(615, 22, 'Pelt', '3900'),
(616, 22, 'Neerpelt', '3910'),
(617, 22, 'Sint-Huibrechts-Lille', '3910'),
(618, 22, 'Lommel', '3920'),
(619, 22, 'Achel', '3930'),
(620, 22, 'Hamont-Achel', '3930'),
(621, 22, 'Hamont', '3930'),
(622, 22, 'Hechtel-Eksel', '3940'),
(623, 22, 'Hechtel', '3940'),
(624, 22, 'Eksel', '3941'),
(625, 22, 'Ham', '3945'),
(626, 22, 'Kwaadmechelen', '3945'),
(627, 22, 'Oostham', '3945'),
(628, 22, 'Kaulille', '3950'),
(629, 22, 'Reppel', '3950'),
(630, 22, 'Bocholt', '3950'),
(631, 22, 'Beek', '3960'),
(632, 22, 'Tongerlo', '3960'),
(633, 22, 'Gerdingen', '3960'),
(634, 22, 'Opitter', '3960'),
(635, 22, 'Bree', '3960'),
(636, 22, 'Leopoldsburg', '3970'),
(637, 22, 'Heppen', '3971'),
(638, 22, 'Tessenderlo', '3980'),
(639, 22, 'Peer', '3990'),
(640, 22, 'Wijchmaal', '3990'),
(641, 22, 'Grote-Brogel', '3990'),
(642, 22, 'Kleine-Brogel', '3990'),
(643, 22, 'Gent', '9000'),
(644, 22, 'Mariakerke', '9030'),
(645, 22, 'Drongen', '9031'),
(646, 22, 'Wondelgem', '9032'),
(647, 22, 'Sint-Amandsberg', '9040'),
(648, 22, 'Oostakker', '9041'),
(649, 22, 'Desteldonk', '9042'),
(650, 22, 'Mendonk', '9042'),
(651, 22, 'Sint-Kruis-Winkel', '9042'),
(652, 22, 'Gentbrugge', '9050'),
(653, 22, 'Ledeberg', '9050'),
(654, 22, 'Sint-Denijs-Westrem', '9051'),
(655, 22, 'Afsnee', '9051'),
(656, 22, 'Zwijnaarde', '9052'),
(657, 22, 'Zelzate', '9060'),
(658, 22, 'Heusden', '9070'),
(659, 22, 'Destelbergen', '9070'),
(660, 22, 'Zeveneken', '9080'),
(661, 22, 'Zaffelare', '9080'),
(662, 22, 'Lochristi', '9080'),
(663, 22, 'Beervelde', '9080'),
(664, 22, 'Melle', '9090'),
(665, 22, 'Gontrode', '9090'),
(666, 22, 'Sint-Niklaas', '9100'),
(667, 22, 'Nieuwkerken-Waas', '9100'),
(668, 22, 'Belsele', '9111'),
(669, 22, 'Sinaai-Waas', '9112'),
(670, 22, 'Vrasene', '9120'),
(671, 22, 'Kallo', '9120'),
(672, 22, 'Haasdonk', '9120'),
(673, 22, 'Melsele', '9120'),
(674, 22, 'Beveren-Waas', '9120'),
(675, 22, 'Kieldrecht', '9130'),
(676, 22, 'Kallo', '9130'),
(677, 22, 'Doel', '9130'),
(678, 22, 'Verrebroek', '9130'),
(679, 22, 'Steendorp', '9140'),
(680, 22, 'Elversele', '9140'),
(681, 22, 'Temse', '9140'),
(682, 22, 'Tielrode', '9140'),
(683, 22, 'Kruibeke', '9150'),
(684, 22, 'Rupelmonde', '9150'),
(685, 22, 'Bazel', '9150'),
(686, 22, 'Lokeren', '9160'),
(687, 22, 'Daknam', '9160'),
(688, 22, 'Eksaarde', '9160'),
(689, 22, 'Sint-Pauwels', '9170'),
(690, 22, 'Sint-Gillis-Waas', '9170'),
(691, 22, 'Meerdonk', '9170'),
(692, 22, 'De Klinge', '9170'),
(693, 22, 'Moerbeke-Waas', '9180'),
(694, 22, 'Wachtebeke', '9185'),
(695, 22, 'Kemzeke', '9190'),
(696, 22, 'Stekene', '9190'),
(697, 22, 'Appels', '9200'),
(698, 22, 'Dendermonde', '9200'),
(699, 22, 'Oudegem', '9200'),
(700, 22, 'Sint-Gillis-Dendermonde', '9200'),
(701, 22, 'Grembergen', '9200'),
(702, 22, 'Schoonaarde', '9200'),
(703, 22, 'Mespelare', '9200'),
(704, 22, 'Baasrode', '9200'),
(705, 22, 'Hamme', '9220'),
(706, 22, 'Moerzeke', '9220'),
(707, 22, 'Westrem', '9230'),
(708, 22, 'Massemen', '9230'),
(709, 22, 'Wetteren', '9230'),
(710, 22, 'Zele', '9240'),
(711, 22, 'Waasmunster', '9250'),
(712, 22, 'Opdorp', '9255'),
(713, 22, 'Buggenhout', '9255'),
(714, 22, 'Serskamp', '9260'),
(715, 22, 'Schellebelle', '9260'),
(716, 22, 'Wichelen', '9260'),
(717, 22, 'Kalken', '9270'),
(718, 22, 'Laarne', '9270'),
(719, 22, 'Lebbeke', '9280'),
(720, 22, 'Denderbelle', '9280'),
(721, 22, 'Wieze', '9280'),
(722, 22, 'Overmere', '9290'),
(723, 22, 'Uitbergen', '9290'),
(724, 22, 'Berlare', '9290'),
(725, 22, 'Aalst', '9300'),
(726, 22, 'Hofstade', '9308'),
(727, 22, 'Gijzegem', '9308'),
(728, 22, 'Meldert', '9310'),
(729, 22, 'Moorsel', '9310'),
(730, 22, 'Herdersem', '9310'),
(731, 22, 'Baardegem', '9310'),
(732, 22, 'Nieuwerkerken', '9320'),
(733, 22, 'Erembodegem', '9320'),
(734, 22, 'Oordegem', '9340'),
(735, 22, 'Smetlede', '9340'),
(736, 22, 'Wanzele', '9340'),
(737, 22, 'Impe', '9340'),
(738, 22, 'Lede', '9340'),
(739, 22, 'Lieferinge', '9400'),
(740, 22, 'Appelterre-Eichem', '9400'),
(741, 22, 'Ninove', '9400'),
(742, 22, 'Nederhasselt', '9400'),
(743, 22, 'Okegem', '9400'),
(744, 22, 'Voorde', '9400'),
(745, 22, 'Denderwindeke', '9400'),
(746, 22, 'Pollare', '9401'),
(747, 22, 'Meerbeke', '9402'),
(748, 22, 'Neigem', '9403'),
(749, 22, 'Aspelare', '9404'),
(750, 22, 'Outer', '9406'),
(751, 22, 'Erondegem', '9420'),
(752, 22, 'Bambrugge', '9420'),
(753, 22, 'Erpe', '9420'),
(754, 22, 'Vlekkem', '9420'),
(755, 22, 'Ottergem', '9420'),
(756, 22, 'Aaigem', '9420'),
(757, 22, 'Mere', '9420'),
(758, 22, 'Burst', '9420'),
(759, 22, 'Erpe-Mere', '9420'),
(760, 22, 'Denderhoutem', '9450'),
(761, 22, 'Haaltert', '9450'),
(762, 22, 'Heldergem', '9450'),
(763, 22, 'Kerksken', '9451'),
(764, 22, 'Denderleeuw', '9470'),
(765, 22, 'Iddergem', '9472'),
(766, 22, 'Welle', '9473'),
(767, 22, 'Nederboelare', '9500'),
(768, 22, 'Goeferdinge', '9500'),
(769, 22, 'Overboelare', '9500'),
(770, 22, 'Moerbeke', '9500'),
(771, 22, 'Zarlardinge', '9500'),
(772, 22, 'Ophasselt', '9500'),
(773, 22, 'Geraardsbergen', '9500'),
(774, 22, 'Onkerzele', '9500'),
(775, 22, 'Viane', '9500'),
(776, 22, 'Schendelbeke', '9506'),
(777, 22, 'Grimminge', '9506'),
(778, 22, 'Waarbeke', '9506'),
(779, 22, 'Zandbergen', '9506'),
(780, 22, 'Idegem', '9506'),
(781, 22, 'Nieuwenhove', '9506'),
(782, 22, 'Smeerebbe-Vloerzegem', '9506'),
(783, 22, 'Vlierzele', '9520'),
(784, 22, 'Sint-Lievens-Houtem', '9520'),
(785, 22, 'Bavegem', '9520'),
(786, 22, 'Oombergen', '9520'),
(787, 22, 'Zonnegem', '9520'),
(788, 22, 'Letterhoutem', '9521'),
(789, 22, 'Sint-Antelinks', '9550'),
(790, 22, 'Hillegem', '9550'),
(791, 22, 'Sint-Lievens-Esse', '9550'),
(792, 22, 'Steenhuize-Wijnhuize', '9550'),
(793, 22, 'Woubrechtegem', '9550'),
(794, 22, 'Herzele', '9550'),
(795, 22, 'Ressegem', '9551'),
(796, 22, 'Borsbeke', '9552'),
(797, 22, 'Lierde', '9570'),
(798, 22, 'Deftinge', '9570'),
(799, 22, 'Sint-Maria-Lierde', '9570'),
(800, 22, 'Hemelveerdegem', '9571'),
(801, 22, 'Sint-Martens-Lierde', '9572'),
(802, 22, 'Renaix', '9600'),
(803, 22, 'Leeuwergem', '9620'),
(804, 22, 'Godveerdegem', '9620'),
(805, 22, 'Sint-Goriks-Oudenhove', '9620'),
(806, 22, 'Velzeke-Ruddershove', '9620'),
(807, 22, 'Oombergen', '9620'),
(808, 22, 'Sint-Maria-Oudenhove', '9620'),
(809, 22, 'Zottegem', '9620'),
(810, 22, 'Strijpen', '9620'),
(811, 22, 'Grotenberge', '9620'),
(812, 22, 'Elene', '9620'),
(813, 22, 'Erwetegem', '9620'),
(814, 22, 'Dikkele', '9630'),
(815, 22, 'Sint-Maria-Latem', '9630'),
(816, 22, 'Sint-Denijs-Boekel', '9630'),
(817, 22, 'Paulatem', '9630'),
(818, 22, 'Sint-Blasius-Boekel', '9630'),
(819, 22, 'Roborst', '9630'),
(820, 22, 'Beerlegem', '9630'),
(821, 22, 'Hundelgem', '9630'),
(822, 22, 'Zwalm', '9630'),
(823, 22, 'Munkzwalm', '9630'),
(824, 22, 'Rozebeke', '9630'),
(825, 22, 'Meilegem', '9630'),
(826, 22, 'Nederzwalm-Hermelgem', '9636'),
(827, 22, 'Zegelsem', '9660'),
(828, 22, 'Michelbeke', '9660'),
(829, 22, 'Sint-Maria-Oudenhove', '9660'),
(830, 22, 'Nederbrakel', '9660'),
(831, 22, 'Elst', '9660'),
(832, 22, 'Opbrakel', '9660'),
(833, 22, 'Everbeek', '9660'),
(834, 22, 'Brakel', '9660'),
(835, 22, 'Parike', '9661'),
(836, 22, 'Sint-Kornelis-Horebeke', '9667'),
(837, 22, 'Horebeke', '9667'),
(838, 22, 'Sint-Maria-Horebeke', '9667'),
(839, 22, 'Etikhove', '9680'),
(840, 22, 'Maarke-Kerkem', '9680'),
(841, 22, 'Maarkedal', '9680'),
(842, 22, 'Nukerke', '9681'),
(843, 22, 'Schorisse', '9688'),
(844, 22, 'Kluisbergen', '9690'),
(845, 22, 'Berchem', '9690'),
(846, 22, 'Zulzeke', '9690'),
(847, 22, 'Kwaremont', '9690'),
(848, 22, 'Ruien', '9690'),
(849, 22, 'Nederename', '9700'),
(850, 22, 'Ooike', '9700'),
(851, 22, 'Eine', '9700'),
(852, 22, 'Leupegem', '9700'),
(853, 22, 'Welden', '9700'),
(854, 22, 'Oudenaarde', '9700'),
(855, 22, 'Ename', '9700'),
(856, 22, 'Volkegem', '9700'),
(857, 22, 'Melden', '9700'),
(858, 22, 'Mater', '9700'),
(859, 22, 'Mullem', '9700'),
(860, 22, 'Bevere', '9700'),
(861, 22, 'Heurne', '9700'),
(862, 22, 'Edelare', '9700'),
(863, 22, 'Ouwegem', '9750'),
(864, 22, 'Huise', '9750'),
(865, 22, 'Zingem', '9750'),
(866, 22, 'Kruisem', '9770'),
(867, 22, 'Kruishoutem', '9770'),
(868, 22, 'Nokere', '9771'),
(869, 22, 'Wannegem-Lede', '9772'),
(870, 22, 'Moregem', '9790'),
(871, 22, 'Ooike', '9790'),
(872, 22, 'Wortegem', '9790'),
(873, 22, 'Elsegem', '9790'),
(874, 22, 'Wortegem-Petegem', '9790'),
(875, 22, 'Petegem-Aan-De-Schelde', '9790'),
(876, 22, 'Wontergem', '9800'),
(877, 22, 'Zeveren', '9800'),
(878, 22, 'Bachte-Maria-Leerne', '9800'),
(879, 22, 'Astene', '9800'),
(880, 22, 'Vinkt', '9800'),
(881, 22, 'Meigem', '9800'),
(882, 22, 'Deinze', '9800'),
(883, 22, 'Gottem', '9800'),
(884, 22, 'Grammene', '9800'),
(885, 22, 'Petegem-Aan-De-Leie', '9800'),
(886, 22, 'Sint-Martens-Leerne', '9800'),
(887, 22, 'Eke', '9810'),
(888, 22, 'Nazareth', '9810'),
(889, 22, 'Schelderode', '9820'),
(890, 22, 'Lemberge', '9820'),
(891, 22, 'Munte', '9820'),
(892, 22, 'Melsen', '9820'),
(893, 22, 'Bottelare', '9820'),
(894, 22, 'Merelbeke', '9820'),
(895, 22, 'Sint-Martens-Latem', '9830'),
(896, 22, 'Deurle', '9831'),
(897, 22, 'De Pinte', '9840'),
(898, 22, 'Zevergem', '9840'),
(899, 22, 'Nevele', '9850'),
(900, 22, 'Landegem', '9850'),
(901, 22, 'Vosselare', '9850'),
(902, 22, 'Merendree', '9850'),
(903, 22, 'Hansbeke', '9850'),
(904, 22, 'Poesele', '9850'),
(905, 22, 'Balegem', '9860'),
(906, 22, 'Gijzenzele', '9860'),
(907, 22, 'Oosterzele', '9860'),
(908, 22, 'Scheldewindeke', '9860'),
(909, 22, 'Moortsele', '9860'),
(910, 22, 'Landskouter', '9860'),
(911, 22, 'Machelen', '9870'),
(912, 22, 'Olsene', '9870'),
(913, 22, 'Zulte', '9870'),
(914, 22, 'Aalter', '9880'),
(915, 22, 'Lotenhulle', '9880'),
(916, 22, 'Poeke', '9880'),
(917, 22, 'Bellem', '9881'),
(918, 22, 'Dikkelvenne', '9890'),
(919, 22, 'Baaigem', '9890'),
(920, 22, 'Semmerzake', '9890'),
(921, 22, 'Gavere', '9890'),
(922, 22, 'Vurste', '9890'),
(923, 22, 'Asper', '9890'),
(924, 22, 'Eeklo', '9900'),
(925, 22, 'Knesselare', '9910'),
(926, 22, 'Ursel', '9910'),
(927, 22, 'Lovendegem', '9920'),
(928, 22, 'Vinderhoute', '9921'),
(929, 22, 'Lievegem', '9930'),
(930, 22, 'Zomergem', '9930'),
(931, 22, 'Oostwinkel', '9931'),
(932, 22, 'Ronsele', '9932'),
(933, 22, 'Evergem', '9940'),
(934, 22, 'Sleidinge', '9940'),
(935, 22, 'Ertvelde', '9940'),
(936, 22, 'Kluizen', '9940'),
(937, 22, 'Waarschoot', '9950'),
(938, 22, 'Assenede', '9960'),
(939, 22, 'Boekhoute', '9961'),
(940, 22, 'Bassevelde', '9968'),
(941, 22, 'Oosteeklo', '9968'),
(942, 22, 'Kaprijke', '9970'),
(943, 22, 'Lembeke', '9971'),
(944, 22, 'Sint-Laureins', '9980'),
(945, 22, 'Sint-Margriete', '9981'),
(946, 22, 'Sint-Jan-In-Eremo', '9982'),
(947, 22, 'Watervliet', '9988'),
(948, 22, 'Waterland-Oudeman', '9988'),
(949, 22, 'Maldegem', '9990'),
(950, 22, 'Adegem', '9991'),
(951, 22, 'Middelburg', '9992'),
(952, 22, 'Brugge', '8000'),
(953, 22, 'Koolkerke', '8000'),
(954, 22, 'Hertsberge', '8020'),
(955, 22, 'Waardamme', '8020'),
(956, 22, 'Oostkamp', '8020'),
(957, 22, 'Ruddervoorde', '8020'),
(958, 22, 'Sint-Michiels', '8200'),
(959, 22, 'Sint-Andries', '8200'),
(960, 22, 'Veldegem', '8210'),
(961, 22, 'Zedelgem', '8210'),
(962, 22, 'Loppem', '8210'),
(963, 22, 'Aartrijke', '8211'),
(964, 22, 'Knokke-Heist', '8300'),
(965, 22, 'Knokke', '8300'),
(966, 22, 'Westkapelle', '8300'),
(967, 22, 'Ramskapelle', '8301'),
(968, 22, 'Heist-Aan-Zee', '8301'),
(969, 22, 'Sint-Kruis', '8310'),
(970, 22, 'Assebroek', '8310'),
(971, 22, 'Sijsele', '8340'),
(972, 22, 'Lapscheure', '8340'),
(973, 22, 'Hoeke', '8340'),
(974, 22, 'Damme', '8340'),
(975, 22, 'Oostkerke', '8340'),
(976, 22, 'Moerkerke', '8340'),
(977, 22, 'Uitkerke', '8370'),
(978, 22, 'Blankenberge', '8370'),
(979, 22, 'Houtave', '8377'),
(980, 22, 'Nieuwmunster', '8377'),
(981, 22, 'Meetkerke', '8377'),
(982, 22, 'Zuienkerke', '8377'),
(983, 22, 'Zeebrugge', '8380'),
(984, 22, 'Lissewege', '8380'),
(985, 22, 'Dudzele', '8380'),
(986, 22, 'Zandvoorde', '8400'),
(987, 22, 'Stene', '8400'),
(988, 22, 'Oostende', '8400'),
(989, 22, 'Wenduine', '8420'),
(990, 22, 'De Haan', '8420'),
(991, 22, 'Klemskerke', '8420'),
(992, 22, 'Vlissegem', '8421'),
(993, 22, 'Middelkerke', '8430'),
(994, 22, 'Wilskerke', '8431'),
(995, 22, 'Leffinge', '8432'),
(996, 22, 'Schore', '8433'),
(997, 22, 'Slijpe', '8433'),
(998, 22, 'Mannekensvere', '8433'),
(999, 22, 'Sint-Pieters-Kapelle', '8433'),
(1000, 22, 'Westende', '8434'),
(1001, 22, 'Lombardsijde', '8434'),
(1002, 22, 'Bredene', '8450'),
(1003, 22, 'Roksem', '8460'),
(1004, 22, 'Ettelgem', '8460'),
(1005, 22, 'Oudenburg', '8460'),
(1006, 22, 'Westkerke', '8460'),
(1007, 22, 'Moere', '8470'),
(1008, 22, 'Zevekote', '8470'),
(1009, 22, 'Gistel', '8470'),
(1010, 22, 'Snaaskerke', '8470'),
(1011, 22, 'Eernegem', '8480'),
(1012, 22, 'Ichtegem', '8480'),
(1013, 22, 'Bekegem', '8480'),
(1014, 22, 'Jabbeke', '8490'),
(1015, 22, 'Stalhille', '8490'),
(1016, 22, 'Zerkegem', '8490'),
(1017, 22, 'Varsenare', '8490'),
(1018, 22, 'Snellegem', '8490'),
(1019, 22, 'Kortrijk', '8500'),
(1020, 22, 'Bissegem', '8501'),
(1021, 22, 'Heule', '8501'),
(1022, 22, 'Kooigem', '8510'),
(1023, 22, 'Bellegem', '8510'),
(1024, 22, 'Marke', '8510'),
(1025, 22, 'Rollegem', '8510'),
(1026, 22, 'Aalbeke', '8511'),
(1027, 22, 'Kuurne', '8520'),
(1028, 22, 'Harelbeke', '8530'),
(1029, 22, 'Bavikhove', '8531'),
(1030, 22, 'Hulste', '8531'),
(1031, 22, 'Deerlijk', '8540'),
(1032, 22, 'Zwevegem', '8550'),
(1033, 22, 'Heestert', '8551'),
(1034, 22, 'Moen', '8552'),
(1035, 22, 'Otegem', '8553'),
(1036, 22, 'Sint-Denijs', '8554'),
(1037, 22, 'Wevelgem', '8560'),
(1038, 22, 'Gullegem', '8560'),
(1039, 22, 'Moorsele', '8560'),
(1040, 22, 'Anzegem', '8570'),
(1041, 22, 'Gijzelbrechtegem', '8570'),
(1042, 22, 'Vichte', '8570'),
(1043, 22, 'Ingooigem', '8570'),
(1044, 22, 'Kaster', '8572'),
(1045, 22, 'Tiegem', '8573'),
(1046, 22, 'Avelgem', '8580'),
(1047, 22, 'Waarmaarde', '8581'),
(1048, 22, 'Kerkhove', '8581'),
(1049, 22, 'Outrijve', '8582'),
(1050, 22, 'Bossuit', '8583'),
(1051, 22, 'Espierres', '8587'),
(1052, 22, 'Helchin', '8587'),
(1053, 22, 'Espierres-Helchin', '8587'),
(1054, 22, 'Driekapellen', '8600'),
(1055, 22, 'Sint-Jacobs-Kapelle', '8600'),
(1056, 22, 'Diksmuide', '8600'),
(1057, 22, 'Nieuwkapelle', '8600'),
(1058, 22, 'Oostkerke', '8600'),
(1059, 22, 'Stuivekenskerke', '8600'),
(1060, 22, 'Beerst', '8600'),
(1061, 22, 'Kaaskerke', '8600'),
(1062, 22, 'Keiem', '8600'),
(1063, 22, 'Vladslo', '8600'),
(1064, 22, 'Woumen', '8600'),
(1065, 22, 'Lampernisse', '8600'),
(1066, 22, 'Oudekapelle', '8600'),
(1067, 22, 'Esen', '8600'),
(1068, 22, 'Pervijze', '8600'),
(1069, 22, 'Leke', '8600'),
(1070, 22, 'Zarren', '8610'),
(1071, 22, 'Werken', '8610'),
(1072, 22, 'Handzame', '8610'),
(1073, 22, 'Kortemark', '8610'),
(1074, 22, 'Nieuwpoort', '8620'),
(1075, 22, 'Ramskapelle', '8620'),
(1076, 22, 'Sint-Joris', '8620'),
(1077, 22, 'De Moeren', '8630'),
(1078, 22, 'Avekapelle', '8630'),
(1079, 22, 'Veurne', '8630'),
(1080, 22, 'Booitshoeke', '8630'),
(1081, 22, 'Wulveringem', '8630'),
(1082, 22, 'Steenkerke', '8630'),
(1083, 22, 'Bulskamp', '8630'),
(1084, 22, 'Zoutenaaie', '8630'),
(1085, 22, 'Eggewaartskapelle', '8630'),
(1086, 22, 'Vinkem', '8630'),
(1087, 22, 'Houtem', '8630'),
(1088, 22, 'Oostvleteren', '8640'),
(1089, 22, 'Vleteren', '8640'),
(1090, 22, 'Woesten', '8640'),
(1091, 22, 'Westvleteren', '8640'),
(1092, 22, 'Pollinkhove', '8647'),
(1093, 22, 'Noordschote', '8647'),
(1094, 22, 'Reninge', '8647'),
(1095, 22, 'Lo', '8647'),
(1096, 22, 'Lo-Reninge', '8647'),
(1097, 22, 'Merkem', '8650'),
(1098, 22, 'Houthulst', '8650'),
(1099, 22, 'Klerken', '8650'),
(1100, 22, 'Adinkerke', '8660'),
(1101, 22, 'De Panne', '8660'),
(1102, 22, 'Koksijde', '8670'),
(1103, 22, 'Wulpen', '8670'),
(1104, 22, 'Oostduinkerke', '8670'),
(1105, 22, 'Koekelare', '8680'),
(1106, 22, 'Bovekerke', '8680'),
(1107, 22, 'Zande', '8680'),
(1108, 22, 'Oeren', '8690'),
(1109, 22, 'Sint-Rijkers', '8690'),
(1110, 22, 'Hoogstade', '8690'),
(1111, 22, 'Alveringem', '8690'),
(1112, 22, 'Izenberge', '8691'),
(1113, 22, 'Leisele', '8691'),
(1114, 22, 'Gijverinkhove', '8691'),
(1115, 22, 'Stavele', '8691'),
(1116, 22, 'Beveren-Aan-De-Ijzer', '8691'),
(1117, 22, 'Aarsele', '8700'),
(1118, 22, 'Tielt', '8700'),
(1119, 22, 'Schuiferskapelle', '8700'),
(1120, 22, 'Kanegem', '8700'),
(1121, 22, 'Ooigem', '8710'),
(1122, 22, 'Wielsbeke', '8710'),
(1123, 22, 'Sint-Baafs-Vijve', '8710'),
(1124, 22, 'Oeselgem', '8720'),
(1125, 22, 'Wakken', '8720'),
(1126, 22, 'Dentergem', '8720'),
(1127, 22, 'Markegem', '8720'),
(1128, 22, 'Sint-Joris', '8730'),
(1129, 22, 'Oedelem', '8730'),
(1130, 22, 'Beernem', '8730'),
(1131, 22, 'Egem', '8740'),
(1132, 22, 'Pittem', '8740'),
(1133, 22, 'Zwevezele', '8750'),
(1134, 22, 'Wingene', '8750'),
(1135, 22, 'Ruiselede', '8755'),
(1136, 22, 'Meulebeke', '8760'),
(1137, 22, 'Ingelmunster', '8770'),
(1138, 22, 'Oostrozebeke', '8780'),
(1139, 22, 'Waregem', '8790'),
(1140, 22, 'Beveren', '8791'),
(1141, 22, 'Desselgem', '8792'),
(1142, 22, 'Sint-Eloois-Vijve', '8793'),
(1143, 22, 'Roeselare', '8800'),
(1144, 22, 'Rumbeke', '8800'),
(1145, 22, 'Beveren', '8800'),
(1146, 22, 'Oekene', '8800'),
(1147, 22, 'Lichtervelde', '8810'),
(1148, 22, 'Torhout', '8820'),
(1149, 22, 'Hooglede', '8830'),
(1150, 22, 'Gits', '8830'),
(1151, 22, 'Staden', '8840'),
(1152, 22, 'Westrozebeke', '8840'),
(1153, 22, 'Oostnieuwkerke', '8840'),
(1154, 22, 'Ardooie', '8850'),
(1155, 22, 'Koolskamp', '8851'),
(1156, 22, 'Lendelede', '8860'),
(1157, 22, 'Izegem', '8870'),
(1158, 22, 'Emelgem', '8870'),
(1159, 22, 'Kachtem', '8870'),
(1160, 22, 'Rollegem-Kapelle', '8880'),
(1161, 22, 'Ledegem', '8880'),
(1162, 22, 'Sint-Eloois-Winkel', '8880'),
(1163, 22, 'Dadizele', '8890'),
(1164, 22, 'Moorslede', '8890'),
(1165, 22, 'Dikkebus', '8900'),
(1166, 22, 'Ieper', '8900'),
(1167, 22, 'Brielen', '8900'),
(1168, 22, 'Sint-Jan', '8900'),
(1169, 22, 'Voormezele', '8902'),
(1170, 22, 'Hollebeke', '8902'),
(1171, 22, 'Zillebeke', '8902'),
(1172, 22, 'Boezinge', '8904'),
(1173, 22, 'Zuidschote', '8904'),
(1174, 22, 'Elverdinge', '8906'),
(1175, 22, 'Vlamertinge', '8908'),
(1176, 22, 'Langemark', '8920'),
(1177, 22, 'Bikschote', '8920'),
(1178, 22, 'Langemark-Poelkapelle', '8920'),
(1179, 22, 'Poelkapelle', '8920'),
(1180, 22, 'Menen', '8930'),
(1181, 22, 'Rekkem', '8930'),
(1182, 22, 'Lauwe', '8930'),
(1183, 22, 'Wervik', '8940'),
(1184, 22, 'Geluwe', '8940'),
(1185, 22, 'Nieuwkerke', '8950'),
(1186, 22, 'Heuvelland', '8950'),
(1187, 22, 'Dranouter', '8951'),
(1188, 22, 'Wulvergem', '8952'),
(1189, 22, 'Wijtschate', '8953'),
(1190, 22, 'Westouter', '8954'),
(1191, 22, 'Kemmel', '8956'),
(1192, 22, 'Messines', '8957'),
(1193, 22, 'Loker', '8958'),
(1194, 22, 'Poperinge', '8970'),
(1195, 22, 'Reningelst', '8970'),
(1196, 22, 'Roesbrugge-Haringe', '8972'),
(1197, 22, 'Proven', '8972'),
(1198, 22, 'Krombeke', '8972'),
(1199, 22, 'Watou', '8978'),
(1200, 22, 'Zonnebeke', '8980'),
(1201, 22, 'Passendale', '8980'),
(1202, 22, 'Beselare', '8980'),
(1203, 22, 'Geluveld', '8980'),
(1204, 22, 'Zandvoorde', '8980'),
(1205, 22, 'Limal', '1300'),
(1206, 22, 'Wavre', '1300'),
(1207, 22, 'Bierges', '1301'),
(1208, 22, 'La Hulpe', '1310'),
(1209, 22, 'Roux-Miroir', '1315'),
(1210, 22, 'Piétrebais', '1315'),
(1211, 22, 'Glimes', '1315'),
(1212, 22, 'Incourt', '1315'),
(1213, 22, 'Opprebais', '1315'),
(1214, 22, 'Nodebais', '1320'),
(1215, 22, 'Beauvechain', '1320'),
(1216, 22, 'L\'Ecluse', '1320'),
(1217, 22, 'Hamme-Mille', '1320'),
(1218, 22, 'Tourinnes-La-Grosse', '1320'),
(1219, 22, 'Chaumont-Gistoux', '1325'),
(1220, 22, 'Longueville', '1325'),
(1221, 22, 'Dion-Valmont', '1325'),
(1222, 22, 'Bonlez', '1325'),
(1223, 22, 'Corroy-Le-Grand', '1325'),
(1224, 22, 'Rixensart', '1330'),
(1225, 22, 'Rosières', '1331'),
(1226, 22, 'Genval', '1332'),
(1227, 22, 'Ottignies', '1340'),
(1228, 22, 'Ottignies-Louvain-La-Neuve', '1340'),
(1229, 22, 'Céroux-Mousty', '1341'),
(1230, 22, 'Limelette', '1342'),
(1231, 22, 'Louvain-La-Neuve', '1348'),
(1232, 22, 'Jandrain-Jandrenouille', '1350'),
(1233, 22, 'Orp-Jauche', '1350'),
(1234, 22, 'Enines', '1350'),
(1235, 22, 'Jauche', '1350'),
(1236, 22, 'Noduwez', '1350'),
(1237, 22, 'Marilles', '1350'),
(1238, 22, 'Orp-Le-Grand', '1350'),
(1239, 22, 'Folx-Les-Caves', '1350'),
(1240, 22, 'Hélécine', '1357'),
(1241, 22, 'Neerheylissem', '1357'),
(1242, 22, 'Opheylissem', '1357'),
(1243, 22, 'Linsmeau', '1357'),
(1244, 22, 'Thorembais-Saint-Trond', '1360'),
(1245, 22, 'Orbais', '1360'),
(1246, 22, 'Thorembais-Les-Béguines', '1360'),
(1247, 22, 'Malèves-Sainte-Marie-Wastinnes', '1360'),
(1248, 22, 'Perwez', '1360'),
(1249, 22, 'Mont-Saint-André', '1367'),
(1250, 22, 'Ramillies', '1367'),
(1251, 22, 'Geest-Gérompont-Petit-Rosière', '1367'),
(1252, 22, 'Autre-Eglise', '1367'),
(1253, 22, 'Bomal', '1367'),
(1254, 22, 'Huppaye', '1367'),
(1255, 22, 'Gérompont', '1367'),
(1256, 22, 'Grand-Rosière-Hottomont', '1367'),
(1257, 22, 'Saint-Jean-Geest', '1370'),
(1258, 22, 'Saint-Remy-Geest', '1370'),
(1259, 22, 'Jodoigne', '1370'),
(1260, 22, 'Zétrud-Lumay', '1370'),
(1261, 22, 'Dongelberg', '1370'),
(1262, 22, 'Lathuy', '1370'),
(1263, 22, 'Mélin', '1370'),
(1264, 22, 'Jodoigne-Souveraine', '1370'),
(1265, 22, 'Piétrain', '1370'),
(1266, 22, 'Jauchelette', '1370'),
(1267, 22, 'Couture-Saint-Germain', '1380'),
(1268, 22, 'Ohain', '1380'),
(1269, 22, 'Lasne-Chapelle-Saint-Lambert', '1380'),
(1270, 22, 'Lasne', '1380'),
(1271, 22, 'Plancenoit', '1380'),
(1272, 22, 'Maransart', '1380'),
(1273, 22, 'Archennes', '1390'),
(1274, 22, 'Bossut-Gottechain', '1390'),
(1275, 22, 'Biez', '1390'),
(1276, 22, 'Nethen', '1390'),
(1277, 22, 'Grez-Doiceau', '1390'),
(1278, 22, 'Monstreux', '1400'),
(1279, 22, 'Nivelles', '1400'),
(1280, 22, 'Baulers', '1401'),
(1281, 22, 'Thines', '1402'),
(1282, 22, 'Bornival', '1404'),
(1283, 22, 'Waterloo', '1410'),
(1284, 22, 'Braine-L\'Alleud', '1420'),
(1285, 22, 'Ophain-Bois-Seigneur-Isaac', '1421'),
(1286, 22, 'Lillois-Witterzée', '1428'),
(1287, 22, 'Rebecq-Rognon', '1430'),
(1288, 22, 'Bierghes', '1430'),
(1289, 22, 'Rebecq', '1430'),
(1290, 22, 'Quenast', '1430'),
(1291, 22, 'Hévillers', '1435'),
(1292, 22, 'Corbais', '1435'),
(1293, 22, 'Mont-Saint-Guibert', '1435'),
(1294, 22, 'Wauthier-Braine', '1440'),
(1295, 22, 'Braine-Le-Château', '1440'),
(1296, 22, 'Chastre-Villeroux-Blanmont', '1450'),
(1297, 22, 'Saint-Géry', '1450'),
(1298, 22, 'Cortil-Noirmont', '1450'),
(1299, 22, 'Gentinnes', '1450'),
(1300, 22, 'Chastre', '1450'),
(1301, 22, 'Nil-Saint-Vincent-Saint-Martin', '1457'),
(1302, 22, 'Walhain', '1457'),
(1303, 22, 'Tourinnes-Saint-Lambert', '1457'),
(1304, 22, 'Walhain-Saint-Paul', '1457'),
(1305, 22, 'Virginal-Samme', '1460'),
(1306, 22, 'Ittre', '1460'),
(1307, 22, 'Haut-Ittre', '1461'),
(1308, 22, 'Bousval', '1470'),
(1309, 22, 'Baisy-Thy', '1470'),
(1310, 22, 'Genappe', '1470'),
(1311, 22, 'Loupoigne', '1471'),
(1312, 22, 'Vieux-Genappe', '1472'),
(1313, 22, 'Glabais', '1473'),
(1314, 22, 'Ways', '1474'),
(1315, 22, 'Houtain-Le-Val', '1476'),
(1316, 22, 'Tubize', '1480'),
(1317, 22, 'Oisquercq', '1480'),
(1318, 22, 'Clabecq', '1480'),
(1319, 22, 'Saintes', '1480'),
(1320, 22, 'Court-Saint-Etienne', '1490'),
(1321, 22, 'Mellery', '1495'),
(1322, 22, 'Tilly', '1495'),
(1323, 22, 'Villers-La-Ville', '1495'),
(1324, 22, 'Marbais', '1495'),
(1325, 22, 'Sart-Dames-Avelines', '1495'),
(1326, 22, 'Charleroi', '6000'),
(1327, 22, 'Marcinelle', '6001'),
(1328, 22, 'Couillet', '6010'),
(1329, 22, 'Dampremy', '6020'),
(1330, 22, 'Goutroux', '6030'),
(1331, 22, 'Marchienne-Au-Pont', '6030'),
(1332, 22, 'Monceau-Sur-Sambre', '6031'),
(1333, 22, 'Mont-Sur-Marchienne', '6032'),
(1334, 22, 'Jumet', '6040'),
(1335, 22, 'Gosselies', '6041'),
(1336, 22, 'Lodelinsart', '6042'),
(1337, 22, 'Ransart', '6043'),
(1338, 22, 'Roux', '6044'),
(1339, 22, 'Gilly', '6060'),
(1340, 22, 'Montignies-Sur-Sambre', '6061'),
(1341, 22, 'Montigny-Le-Tilleul', '6110'),
(1342, 22, 'Landelies', '6111'),
(1343, 22, 'Marbaix', '6120'),
(1344, 22, 'Ham-Sur-Heure', '6120'),
(1345, 22, 'Cour-Sur-Heure', '6120'),
(1346, 22, 'Nalinnes', '6120'),
(1347, 22, 'Jamioulx', '6120'),
(1348, 22, 'Fontaine-L\'Evêque', '6140'),
(1349, 22, 'Forchies-La-Marche', '6141'),
(1350, 22, 'Leernes', '6142'),
(1351, 22, 'Anderlues', '6150'),
(1352, 22, 'Courcelles', '6180'),
(1353, 22, 'Gouy-Lez-Piéton', '6181'),
(1354, 22, 'Souvret', '6182'),
(1355, 22, 'Trazegnies', '6183'),
(1356, 22, 'Châtelineau', '6200'),
(1357, 22, 'Châtelet', '6200'),
(1358, 22, 'Bouffioulx', '6200'),
(1359, 22, 'Rèves', '6210'),
(1360, 22, 'Villers-Perwin', '6210'),
(1361, 22, 'Les Bons Villers', '6210'),
(1362, 22, 'Wayaux', '6210'),
(1363, 22, 'Frasnes-Lez-Gosselies', '6210'),
(1364, 22, 'Mellet', '6211'),
(1365, 22, 'Lambusart', '6220'),
(1366, 22, 'Heppignies', '6220'),
(1367, 22, 'Fleurus', '6220'),
(1368, 22, 'Wangenies', '6220'),
(1369, 22, 'Saint-Amand', '6221'),
(1370, 22, 'Brye', '6222'),
(1371, 22, 'Wagnelée', '6223'),
(1372, 22, 'Wanfercée-Baulet', '6224'),
(1373, 22, 'Thiméon', '6230'),
(1374, 22, 'Pont-À-Celles', '6230'),
(1375, 22, 'Viesville', '6230'),
(1376, 22, 'Buzet', '6230'),
(1377, 22, 'Obaix', '6230'),
(1378, 22, 'Luttre', '6238'),
(1379, 22, 'Liberchies', '6238'),
(1380, 22, 'Farciennes', '6240'),
(1381, 22, 'Pironchamps', '6240'),
(1382, 22, 'Presles', '6250'),
(1383, 22, 'Roselies', '6250'),
(1384, 22, 'Aiseau', '6250'),
(1385, 22, 'Aiseau-Presles', '6250'),
(1386, 22, 'Pont-De-Loup', '6250'),
(1387, 22, 'Gerpinnes', '6280'),
(1388, 22, 'Gougnies', '6280'),
(1389, 22, 'Loverval', '6280'),
(1390, 22, 'Villers-Poterie', '6280'),
(1391, 22, 'Acoz', '6280'),
(1392, 22, 'Joncret', '6280'),
(1393, 22, 'Vergnies', '6440'),
(1394, 22, 'Boussu-Lez-Walcourt', '6440'),
(1395, 22, 'Fourbechies', '6440'),
(1396, 22, 'Froidchapelle', '6440'),
(1397, 22, 'Erpion', '6441'),
(1398, 22, 'Villers-La-Tour', '6460'),
(1399, 22, 'Bailièvre', '6460'),
(1400, 22, 'Salles', '6460'),
(1401, 22, 'Robechies', '6460'),
(1402, 22, 'Saint-Remy', '6460'),
(1403, 22, 'Chimay', '6460'),
(1404, 22, 'Virelles', '6461'),
(1405, 22, 'Vaulx-Lez-Chimay', '6462'),
(1406, 22, 'Lompret', '6463'),
(1407, 22, 'L\'Escaillère', '6464'),
(1408, 22, 'Baileux', '6464'),
(1409, 22, 'Forges', '6464'),
(1410, 22, 'Bourlers', '6464'),
(1411, 22, 'Rièzes', '6464'),
(1412, 22, 'Grandrieu', '6470'),
(1413, 22, 'Sivry-Rance', '6470'),
(1414, 22, 'Rance', '6470'),
(1415, 22, 'Sivry', '6470'),
(1416, 22, 'Sautin', '6470'),
(1417, 22, 'Montbliart', '6470'),
(1418, 22, 'Solre-Saint-Géry', '6500'),
(1419, 22, 'Leval-Chaudeville', '6500'),
(1420, 22, 'Renlies', '6500'),
(1421, 22, 'Barbençon', '6500'),
(1422, 22, 'Thirimont', '6500'),
(1423, 22, 'Leugnies', '6500'),
(1424, 22, 'Beaumont', '6500'),
(1425, 22, 'Strée', '6511'),
(1426, 22, 'Thuin', '6530'),
(1427, 22, 'Leers-Et-Fosteau', '6530'),
(1428, 22, 'Biesme-Sous-Thuin', '6531'),
(1429, 22, 'Ragnies', '6532'),
(1430, 22, 'Biercée', '6533'),
(1431, 22, 'Gozée', '6534'),
(1432, 22, 'Thuillies', '6536'),
(1433, 22, 'Donstiennes', '6536'),
(1434, 22, 'Lobbes', '6540'),
(1435, 22, 'Mont-Sainte-Geneviève', '6540'),
(1436, 22, 'Sars-La-Buissière', '6542'),
(1437, 22, 'Bienne-Lez-Happart', '6543'),
(1438, 22, 'Solre-Sur-Sambre', '6560'),
(1439, 22, 'Hantes-Wihéries', '6560'),
(1440, 22, 'Erquelinnes', '6560'),
(1441, 22, 'Bersillies-L\'Abbaye', '6560'),
(1442, 22, 'Montignies-Saint-Christophe', '6560'),
(1443, 22, 'Grand-Reng', '6560'),
(1444, 22, 'Merbes-Sainte-Marie', '6567'),
(1445, 22, 'Labuissière', '6567'),
(1446, 22, 'Fontaine-Valmont', '6567'),
(1447, 22, 'Merbes-Le-Château', '6567'),
(1448, 22, 'Momignies', '6590'),
(1449, 22, 'Macon', '6591'),
(1450, 22, 'Monceau-Imbrechies', '6592'),
(1451, 22, 'Macquenoise', '6593'),
(1452, 22, 'Beauwelz', '6594'),
(1453, 22, 'Forge-Philippe', '6596'),
(1454, 22, 'Seloignes', '6596'),
(1455, 22, 'Mons', '7000'),
(1456, 22, 'Ghlin', '7011'),
(1457, 22, 'Jemappes', '7012'),
(1458, 22, 'Flénu', '7012'),
(1459, 22, 'Nimy', '7020'),
(1460, 22, 'Maisières', '7020'),
(1461, 22, 'Havré', '7021'),
(1462, 22, 'Mesvin', '7022'),
(1463, 22, 'Nouvelles', '7022'),
(1464, 22, 'Hyon', '7022'),
(1465, 22, 'Harmignies', '7022'),
(1466, 22, 'Harveng', '7022'),
(1467, 22, 'Ciply', '7024'),
(1468, 22, 'Saint-Symphorien', '7030'),
(1469, 22, 'Villers-Saint-Ghislain', '7031'),
(1470, 22, 'Spiennes', '7032'),
(1471, 22, 'Cuesmes', '7033'),
(1472, 22, 'Obourg', '7034'),
(1473, 22, 'Saint-Denis', '7034'),
(1474, 22, 'Bougnies', '7040'),
(1475, 22, 'Quévy', '7040'),
(1476, 22, 'Aulnois', '7040'),
(1477, 22, 'Quévy-Le-Petit', '7040'),
(1478, 22, 'Quévy-Le-Grand', '7040'),
(1479, 22, 'Blaregnies', '7040'),
(1480, 22, 'Asquillies', '7040'),
(1481, 22, 'Goegnies-Chaussée', '7040'),
(1482, 22, 'Genly', '7040'),
(1483, 22, 'Havay', '7041'),
(1484, 22, 'Givry', '7041'),
(1485, 22, 'Jurbise', '7050'),
(1486, 22, 'Masnuy-Saint-Pierre', '7050'),
(1487, 22, 'Herchies', '7050'),
(1488, 22, 'Erbaut', '7050'),
(1489, 22, 'Masnuy-Saint-Jean', '7050'),
(1490, 22, 'Erbisoeul', '7050'),
(1491, 22, 'Horrues', '7060'),
(1492, 22, 'Soignies', '7060'),
(1493, 22, 'Casteau', '7061'),
(1494, 22, 'Thieusies', '7061'),
(1495, 22, 'Naast', '7062'),
(1496, 22, 'Chaussée-Notre-Dame-Louvignies', '7063'),
(1497, 22, 'Neufvilles', '7063'),
(1498, 22, 'Mignault', '7070'),
(1499, 22, 'Le Roeulx', '7070'),
(1500, 22, 'Ville-Sur-Haine', '7070'),
(1501, 22, 'Gottignies', '7070'),
(1502, 22, 'Thieu', '7070'),
(1503, 22, 'Noirchain', '7080'),
(1504, 22, 'Eugies', '7080'),
(1505, 22, 'La Bouverie', '7080'),
(1506, 22, 'Sars-La-Bruyère', '7080'),
(1507, 22, 'Frameries', '7080'),
(1508, 22, 'Steenkerque', '7090'),
(1509, 22, 'Ronquières', '7090'),
(1510, 22, 'Hennuyères', '7090'),
(1511, 22, 'Henripont', '7090'),
(1512, 22, 'Braine-Le-Comte', '7090'),
(1513, 22, 'Petit-Roeulx-Lez-Braine', '7090'),
(1514, 22, 'Haine-Saint-Pierre', '7100'),
(1515, 22, 'La Louvière', '7100'),
(1516, 22, 'Saint-Vaast', '7100'),
(1517, 22, 'Haine-Saint-Paul', '7100'),
(1518, 22, 'Trivières', '7100'),
(1519, 22, 'Houdeng-Goegnies', '7110'),
(1520, 22, 'Strépy-Bracquegnies', '7110'),
(1521, 22, 'Maurage', '7110'),
(1522, 22, 'Boussoit', '7110'),
(1523, 22, 'Houdeng-Aimeries', '7110'),
(1524, 22, 'Estinnes-Au-Val', '7120'),
(1525, 22, 'Croix-Lez-Rouveroy', '7120'),
(1526, 22, 'Rouveroy', '7120'),
(1527, 22, 'Vellereille-Les-Brayeux', '7120'),
(1528, 22, 'Haulchin', '7120'),
(1529, 22, 'Fauroeulx', '7120'),
(1530, 22, 'Vellereille-Le-Sec', '7120'),
(1531, 22, 'Estinnes-Au-Mont', '7120'),
(1532, 22, 'Peissant', '7120'),
(1533, 22, 'Estinnes', '7120'),
(1534, 22, 'Battignies', '7130'),
(1535, 22, 'Binche', '7130'),
(1536, 22, 'Bray', '7130'),
(1537, 22, 'Waudrez', '7131'),
(1538, 22, 'Buvrinnes', '7133'),
(1539, 22, 'Péronnes-Lez-Binche', '7134'),
(1540, 22, 'Epinois', '7134'),
(1541, 22, 'Leval-Trahegnies', '7134'),
(1542, 22, 'Ressaix', '7134'),
(1543, 22, 'Morlanwelz', '7140'),
(1544, 22, 'Morlanwelz-Mariemont', '7140'),
(1545, 22, 'Carnières', '7141'),
(1546, 22, 'Mont-Sainte-Aldegonde', '7141'),
(1547, 22, 'Chapelle-Lez-Herlaimont', '7160'),
(1548, 22, 'Piéton', '7160'),
(1549, 22, 'Godarville', '7160'),
(1550, 22, 'Fayt-Lez-Manage', '7170'),
(1551, 22, 'Bellecourt', '7170'),
(1552, 22, 'Bois-D\'Haine', '7170'),
(1553, 22, 'Manage', '7170'),
(1554, 22, 'La Hestre', '7170'),
(1555, 22, 'Seneffe', '7180'),
(1556, 22, 'Arquennes', '7181'),
(1557, 22, 'Familleureux', '7181'),
(1558, 22, 'Feluy', '7181'),
(1559, 22, 'Petit-Roeulx-Lez-Nivelles', '7181'),
(1560, 22, 'Marche-Lez-Ecaussinnes', '7190'),
(1561, 22, 'Ecaussinnes', '7190'),
(1562, 22, 'Ecaussinnes-D\'Enghien', '7190'),
(1563, 22, 'Ecaussinnes-Lalaing', '7191'),
(1564, 22, 'Boussu', '7300'),
(1565, 22, 'Hornu', '7301'),
(1566, 22, 'Bernissart', '7320'),
(1567, 22, 'Blaton', '7321'),
(1568, 22, 'Harchies', '7321'),
(1569, 22, 'Ville-Pommeroeul', '7322'),
(1570, 22, 'Pommeroeul', '7322'),
(1571, 22, 'Saint-Ghislain', '7330'),
(1572, 22, 'Baudour', '7331'),
(1573, 22, 'Neufmaison', '7332'),
(1574, 22, 'Sirault', '7332'),
(1575, 22, 'Tertre', '7333'),
(1576, 22, 'Hautrage', '7334'),
(1577, 22, 'Villerot', '7334'),
(1578, 22, 'Pâturages', '7340'),
(1579, 22, 'Colfontaine', '7340'),
(1580, 22, 'Warquignies', '7340'),
(1581, 22, 'Wasmes', '7340'),
(1582, 22, 'Thulin', '7350'),
(1583, 22, 'Hainin', '7350'),
(1584, 22, 'Hensies', '7350'),
(1585, 22, 'Montroeul-Sur-Haine', '7350'),
(1586, 22, 'Blaugies', '7370'),
(1587, 22, 'Wihéries', '7370'),
(1588, 22, 'Dour', '7370'),
(1589, 22, 'Elouges', '7370'),
(1590, 22, 'Quiévrain', '7380'),
(1591, 22, 'Baisieux', '7380'),
(1592, 22, 'Audregnies', '7382'),
(1593, 22, 'Athis', '7387'),
(1594, 22, 'Angre', '7387'),
(1595, 22, 'Fayt-Le-Franc', '7387'),
(1596, 22, 'Montignies-Sur-Roc', '7387'),
(1597, 22, 'Erquennes', '7387'),
(1598, 22, 'Roisin', '7387'),
(1599, 22, 'Marchipont', '7387'),
(1600, 22, 'Onnezies', '7387'),
(1601, 22, 'Honnelles', '7387'),
(1602, 22, 'Angreau', '7387'),
(1603, 22, 'Autreppe', '7387'),
(1604, 22, 'Wasmuel', '7390'),
(1605, 22, 'Quaregnon', '7390'),
(1606, 22, 'Tournai', '7500'),
(1607, 22, 'Ere', '7500'),
(1608, 22, 'Saint-Maur', '7500'),
(1609, 22, 'Orcq', '7501'),
(1610, 22, 'Esplechin', '7502'),
(1611, 22, 'Froyennes', '7503'),
(1612, 22, 'Froidmont', '7504'),
(1613, 22, 'Willemeau', '7506'),
(1614, 22, 'Ramegnies-Chin', '7520'),
(1615, 22, 'Templeuve', '7520'),
(1616, 22, 'Chercq', '7521'),
(1617, 22, 'Lamain', '7522'),
(1618, 22, 'Marquain', '7522'),
(1619, 22, 'Hertain', '7522'),
(1620, 22, 'Blandain', '7522'),
(1621, 22, 'Gaurain-Ramecroix', '7530'),
(1622, 22, 'Havinnes', '7531'),
(1623, 22, 'Béclers', '7532'),
(1624, 22, 'Thimougies', '7533'),
(1625, 22, 'Barry', '7534'),
(1626, 22, 'Maulde', '7534'),
(1627, 22, 'Vaulx', '7536'),
(1628, 22, 'Vezon', '7538');
INSERT INTO `cities` (`id`, `country_id`, `label`, `zipcode`) VALUES
(1629, 22, 'Quartes', '7540'),
(1630, 22, 'Rumillies', '7540'),
(1631, 22, 'Melles', '7540'),
(1632, 22, 'Kain', '7540'),
(1633, 22, 'Mont-Saint-Aubert', '7542'),
(1634, 22, 'Mourcourt', '7543'),
(1635, 22, 'Warchin', '7548'),
(1636, 22, 'Péruwelz', '7600'),
(1637, 22, 'Roucourt', '7601'),
(1638, 22, 'Bury', '7602'),
(1639, 22, 'Bon-Secours', '7603'),
(1640, 22, 'Callenelle', '7604'),
(1641, 22, 'Brasménil', '7604'),
(1642, 22, 'Wasmes-Audemez-Briffoeil', '7604'),
(1643, 22, 'Baugnies', '7604'),
(1644, 22, 'Braffe', '7604'),
(1645, 22, 'Wiers', '7608'),
(1646, 22, 'Rumes', '7610'),
(1647, 22, 'La Glanerie', '7611'),
(1648, 22, 'Taintignies', '7618'),
(1649, 22, 'Jollain-Merlin', '7620'),
(1650, 22, 'Wez-Velvain', '7620'),
(1651, 22, 'Brunehaut', '7620'),
(1652, 22, 'Bléharies', '7620'),
(1653, 22, 'Guignies', '7620'),
(1654, 22, 'Hollain', '7620'),
(1655, 22, 'Lesdain', '7621'),
(1656, 22, 'Laplaigne', '7622'),
(1657, 22, 'Rongy', '7623'),
(1658, 22, 'Howardries', '7624'),
(1659, 22, 'Antoing', '7640'),
(1660, 22, 'Maubray', '7640'),
(1661, 22, 'Péronnes-Lez-Antoing', '7640'),
(1662, 22, 'Bruyelle', '7641'),
(1663, 22, 'Calonne', '7642'),
(1664, 22, 'Fontenoy', '7643'),
(1665, 22, 'Luingne', '7700'),
(1666, 22, 'Mouscron', '7700'),
(1667, 22, 'Dottignies', '7711'),
(1668, 22, 'Herseaux', '7712'),
(1669, 22, 'Evregnies', '7730'),
(1670, 22, 'Leers-Nord', '7730'),
(1671, 22, 'Bailleul', '7730'),
(1672, 22, 'Estaimpuis', '7730'),
(1673, 22, 'Néchin', '7730'),
(1674, 22, 'Saint-Léger', '7730'),
(1675, 22, 'Estaimbourg', '7730'),
(1676, 22, 'Pecq', '7740'),
(1677, 22, 'Warcoing', '7740'),
(1678, 22, 'Hérinnes-Lez-Pecq', '7742'),
(1679, 22, 'Esquelmes', '7743'),
(1680, 22, 'Obigies', '7743'),
(1681, 22, 'Russeignies', '7750'),
(1682, 22, 'Amougies', '7750'),
(1683, 22, 'Mont-De-L\'Enclus', '7750'),
(1684, 22, 'Orroir', '7750'),
(1685, 22, 'Anseroeul', '7750'),
(1686, 22, 'Velaines', '7760'),
(1687, 22, 'Pottes', '7760'),
(1688, 22, 'Escanaffles', '7760'),
(1689, 22, 'Popuelles', '7760'),
(1690, 22, 'Molenbaix', '7760'),
(1691, 22, 'Celles', '7760'),
(1692, 22, 'Comines-Warneton', '7780'),
(1693, 22, 'Comines', '7780'),
(1694, 22, 'Houthem', '7781'),
(1695, 22, 'Ploegsteert', '7782'),
(1696, 22, 'Bizet', '7783'),
(1697, 22, 'Warneton', '7784'),
(1698, 22, 'Bas-Warneton', '7784'),
(1699, 22, 'Lanquesaint', '7800'),
(1700, 22, 'Ath', '7800'),
(1701, 22, 'Irchonwelz', '7801'),
(1702, 22, 'Ormeignies', '7802'),
(1703, 22, 'Bouvignies', '7803'),
(1704, 22, 'Rebaix', '7804'),
(1705, 22, 'Ostiches', '7804'),
(1706, 22, 'Maffle', '7810'),
(1707, 22, 'Arbre', '7811'),
(1708, 22, 'Ligne', '7812'),
(1709, 22, 'Moulbaix', '7812'),
(1710, 22, 'Villers-Saint-Amand', '7812'),
(1711, 22, 'Villers-Notre-Dame', '7812'),
(1712, 22, 'Mainvault', '7812'),
(1713, 22, 'Houtaing', '7812'),
(1714, 22, 'Meslin-L\'Evêque', '7822'),
(1715, 22, 'Ghislenghien', '7822'),
(1716, 22, 'Isières', '7822'),
(1717, 22, 'Gibecq', '7823'),
(1718, 22, 'Bassilly', '7830'),
(1719, 22, 'Thoricourt', '7830'),
(1720, 22, 'Fouleng', '7830'),
(1721, 22, 'Gondregnies', '7830'),
(1722, 22, 'Hellebecq', '7830'),
(1723, 22, 'Silly', '7830'),
(1724, 22, 'Graty', '7830'),
(1725, 22, 'Hoves', '7830'),
(1726, 22, 'Marcq', '7850'),
(1727, 22, 'Petit-Enghien', '7850'),
(1728, 22, 'Enghien', '7850'),
(1729, 22, 'Lessines', '7860'),
(1730, 22, 'Wannebecq', '7861'),
(1731, 22, 'Papignies', '7861'),
(1732, 22, 'Ogy', '7862'),
(1733, 22, 'Ghoy', '7863'),
(1734, 22, 'Deux-Acren', '7864'),
(1735, 22, 'Ollignies', '7866'),
(1736, 22, 'Bois-De-Lessines', '7866'),
(1737, 22, 'Bauffe', '7870'),
(1738, 22, 'Lombise', '7870'),
(1739, 22, 'Cambron-Saint-Vincent', '7870'),
(1740, 22, 'Lens', '7870'),
(1741, 22, 'Montignies-Lez-Lens', '7870'),
(1742, 22, 'Flobecq', '7880'),
(1743, 22, 'Lahamaide', '7890'),
(1744, 22, 'Wodecq', '7890'),
(1745, 22, 'Ellezelles', '7890'),
(1746, 22, 'Grandmetz', '7900'),
(1747, 22, 'Leuze-En-Hainaut', '7900'),
(1748, 22, 'Thieulain', '7901'),
(1749, 22, 'Blicquy', '7903'),
(1750, 22, 'Chapelle-À-Oie', '7903'),
(1751, 22, 'Chapelle-À-Wattines', '7903'),
(1752, 22, 'Pipaix', '7904'),
(1753, 22, 'Tourpes', '7904'),
(1754, 22, 'Willaupuis', '7904'),
(1755, 22, 'Gallaix', '7906'),
(1756, 22, 'Ellignies-Lez-Frasnes', '7910'),
(1757, 22, 'Arc-Ainières', '7910'),
(1758, 22, 'Frasnes-Lez-Anvaing', '7910'),
(1759, 22, 'Wattripont', '7910'),
(1760, 22, 'Cordes', '7910'),
(1761, 22, 'Forest', '7910'),
(1762, 22, 'Anvaing', '7910'),
(1763, 22, 'Arc-Wattripont', '7910'),
(1764, 22, 'Herquegies', '7911'),
(1765, 22, 'Moustier', '7911'),
(1766, 22, 'Frasnes-Lez-Buissenal', '7911'),
(1767, 22, 'Oeudeghien', '7911'),
(1768, 22, 'Montroeul-Au-Bois', '7911'),
(1769, 22, 'Buissenal', '7911'),
(1770, 22, 'Hacquegnies', '7911'),
(1771, 22, 'Dergneau', '7912'),
(1772, 22, 'Saint-Sauveur', '7912'),
(1773, 22, 'Brugelette', '7940'),
(1774, 22, 'Cambron-Casteau', '7940'),
(1775, 22, 'Attre', '7941'),
(1776, 22, 'Mévergnies-Lez-Lens', '7942'),
(1777, 22, 'Gages', '7943'),
(1778, 22, 'Huissignies', '7950'),
(1779, 22, 'Tongre-Saint-Martin', '7950'),
(1780, 22, 'Grosage', '7950'),
(1781, 22, 'Ladeuze', '7950'),
(1782, 22, 'Chièvres', '7950'),
(1783, 22, 'Tongre-Notre-Dame', '7951'),
(1784, 22, 'Beloeil', '7970'),
(1785, 22, 'Wadelincourt', '7971'),
(1786, 22, 'Ramegnies', '7971'),
(1787, 22, 'Basècles', '7971'),
(1788, 22, 'Thumaide', '7971'),
(1789, 22, 'Aubechies', '7972'),
(1790, 22, 'Quevaucamps', '7972'),
(1791, 22, 'Ellignies-Sainte-Anne', '7972'),
(1792, 22, 'Stambruges', '7973'),
(1793, 22, 'Grandglise', '7973'),
(1794, 22, 'Glain', '4000'),
(1795, 22, 'Liège', '4000'),
(1796, 22, 'Rocourt', '4000'),
(1797, 22, 'Liège', '4020'),
(1798, 22, 'Wandre', '4020'),
(1799, 22, 'Jupille-Sur-Meuse', '4020'),
(1800, 22, 'Bressoux', '4020'),
(1801, 22, 'Grivegnée', '4030'),
(1802, 22, 'Angleur', '4031'),
(1803, 22, 'Chênée', '4032'),
(1804, 22, 'Herstal', '4040'),
(1805, 22, 'Milmort', '4041'),
(1806, 22, 'Vottem', '4041'),
(1807, 22, 'Liers', '4042'),
(1808, 22, 'Chaudfontaine', '4050'),
(1809, 22, 'Vaux-Sous-Chèvremont', '4051'),
(1810, 22, 'Beaufays', '4052'),
(1811, 22, 'Embourg', '4053'),
(1812, 22, 'Boncelles', '4100'),
(1813, 22, 'Seraing', '4100'),
(1814, 22, 'Jemeppe-Sur-Meuse', '4101'),
(1815, 22, 'Ougrée', '4102'),
(1816, 22, 'Neupré', '4120'),
(1817, 22, 'Ehein', '4120'),
(1818, 22, 'Rotheux-Rimière', '4120'),
(1819, 22, 'Neuville-En-Condroz', '4121'),
(1820, 22, 'Plainevaux', '4122'),
(1821, 22, 'Esneux', '4130'),
(1822, 22, 'Tilff', '4130'),
(1823, 22, 'Gomzé-Andoumont', '4140'),
(1824, 22, 'Dolembreux', '4140'),
(1825, 22, 'Sprimont', '4140'),
(1826, 22, 'Rouvreux', '4140'),
(1827, 22, 'Louveigné', '4141'),
(1828, 22, 'Anthisnes', '4160'),
(1829, 22, 'Villers-Aux-Tours', '4161'),
(1830, 22, 'Hody', '4162'),
(1831, 22, 'Tavier', '4163'),
(1832, 22, 'Comblain-Au-Pont', '4170'),
(1833, 22, 'Poulseur', '4171'),
(1834, 22, 'Comblain-La-Tour', '4180'),
(1835, 22, 'Comblain-Fairon', '4180'),
(1836, 22, 'Hamoir', '4180'),
(1837, 22, 'Filot', '4181'),
(1838, 22, 'Xhoris', '4190'),
(1839, 22, 'Werbomont', '4190'),
(1840, 22, 'My', '4190'),
(1841, 22, 'Vieuxville', '4190'),
(1842, 22, 'Ferrières', '4190'),
(1843, 22, 'Burdinne', '4210'),
(1844, 22, 'Oteppe', '4210'),
(1845, 22, 'Lamontzée', '4210'),
(1846, 22, 'Hannêche', '4210'),
(1847, 22, 'Marneffe', '4210'),
(1848, 22, 'Héron', '4217'),
(1849, 22, 'Lavoir', '4217'),
(1850, 22, 'Waret-L\'Evêque', '4217'),
(1851, 22, 'Couthuin', '4218'),
(1852, 22, 'Wasseiges', '4219'),
(1853, 22, 'Meeffe', '4219'),
(1854, 22, 'Acosse', '4219'),
(1855, 22, 'Ambresin', '4219'),
(1856, 22, 'Geer', '4250'),
(1857, 22, 'Boëlhe', '4250'),
(1858, 22, 'Hollogne-Sur-Geer', '4250'),
(1859, 22, 'Lens-Saint-Servais', '4250'),
(1860, 22, 'Omal', '4252'),
(1861, 22, 'Darion', '4253'),
(1862, 22, 'Ligney', '4254'),
(1863, 22, 'Corswarem', '4257'),
(1864, 22, 'Berloz', '4257'),
(1865, 22, 'Rosoux-Crenwick', '4257'),
(1866, 22, 'Braives', '4260'),
(1867, 22, 'Avennes', '4260'),
(1868, 22, 'Fallais', '4260'),
(1869, 22, 'Ciplet', '4260'),
(1870, 22, 'Fumal', '4260'),
(1871, 22, 'Ville-En-Hesbaye', '4260'),
(1872, 22, 'Latinne', '4261'),
(1873, 22, 'Tourinne', '4263'),
(1874, 22, 'Thisnes', '4280'),
(1875, 22, 'Poucet', '4280'),
(1876, 22, 'Lens-Saint-Remy', '4280'),
(1877, 22, 'Blehen', '4280'),
(1878, 22, 'Bertrée', '4280'),
(1879, 22, 'Avernas-Le-Bauduin', '4280'),
(1880, 22, 'Trognée', '4280'),
(1881, 22, 'Hannut', '4280'),
(1882, 22, 'Abolens', '4280'),
(1883, 22, 'Moxhe', '4280'),
(1884, 22, 'Grand-Hallet', '4280'),
(1885, 22, 'Wansin', '4280'),
(1886, 22, 'Avin', '4280'),
(1887, 22, 'Villers-Le-Peuplier', '4280'),
(1888, 22, 'Merdorp', '4280'),
(1889, 22, 'Cras-Avernas', '4280'),
(1890, 22, 'Crehen', '4280'),
(1891, 22, 'Petit-Hallet', '4280'),
(1892, 22, 'Lincent', '4287'),
(1893, 22, 'Racour', '4287'),
(1894, 22, 'Pellaines', '4287'),
(1895, 22, 'Waremme', '4300'),
(1896, 22, 'Bettincourt', '4300'),
(1897, 22, 'Grand-Axhe', '4300'),
(1898, 22, 'Lantremange', '4300'),
(1899, 22, 'Bovenistier', '4300'),
(1900, 22, 'Bleret', '4300'),
(1901, 22, 'Oleye', '4300'),
(1902, 22, 'Faimes', '4317'),
(1903, 22, 'Les Waleffes', '4317'),
(1904, 22, 'Celles', '4317'),
(1905, 22, 'Borlez', '4317'),
(1906, 22, 'Viemme', '4317'),
(1907, 22, 'Aineffe', '4317'),
(1908, 22, 'Fooz', '4340'),
(1909, 22, 'Villers-L\'Evêque', '4340'),
(1910, 22, 'Awans', '4340'),
(1911, 22, 'Othée', '4340'),
(1912, 22, 'Hognoul', '4342'),
(1913, 22, 'Noville', '4347'),
(1914, 22, 'Fexhe-Le-Haut-Clocher', '4347'),
(1915, 22, 'Voroux-Goreux', '4347'),
(1916, 22, 'Freloux', '4347'),
(1917, 22, 'Roloux', '4347'),
(1918, 22, 'Pousset', '4350'),
(1919, 22, 'Remicourt', '4350'),
(1920, 22, 'Lamine', '4350'),
(1921, 22, 'Momalle', '4350'),
(1922, 22, 'Hodeige', '4351'),
(1923, 22, 'Jeneffe', '4357'),
(1924, 22, 'Limont', '4357'),
(1925, 22, 'Donceel', '4357'),
(1926, 22, 'Haneffe', '4357'),
(1927, 22, 'Bergilers', '4360'),
(1928, 22, 'Otrange', '4360'),
(1929, 22, 'Grandville', '4360'),
(1930, 22, 'Lens-Sur-Geer', '4360'),
(1931, 22, 'Oreye', '4360'),
(1932, 22, 'Kemexhe', '4367'),
(1933, 22, 'Odeur', '4367'),
(1934, 22, 'Crisnée', '4367'),
(1935, 22, 'Thys', '4367'),
(1936, 22, 'Fize-Le-Marsal', '4367'),
(1937, 22, 'Chokier', '4400'),
(1938, 22, 'Awirs', '4400'),
(1939, 22, 'Mons-Lez-Liège', '4400'),
(1940, 22, 'Flémalle', '4400'),
(1941, 22, 'Flémalle-Haute', '4400'),
(1942, 22, 'Gleixhe', '4400'),
(1943, 22, 'Flémalle-Grande', '4400'),
(1944, 22, 'Ivoz-Ramet', '4400'),
(1945, 22, 'Saint-Nicolas', '4420'),
(1946, 22, 'Tilleur', '4420'),
(1947, 22, 'Montegnée', '4420'),
(1948, 22, 'Ans', '4430'),
(1949, 22, 'Loncin', '4431'),
(1950, 22, 'Xhendremael', '4432'),
(1951, 22, 'Alleur', '4432'),
(1952, 22, 'Lantin', '4450'),
(1953, 22, 'Juprelle', '4450'),
(1954, 22, 'Slins', '4450'),
(1955, 22, 'Voroux-Lez-Liers', '4451'),
(1956, 22, 'Wihogne', '4452'),
(1957, 22, 'Paifve', '4452'),
(1958, 22, 'Villers-Saint-Siméon', '4453'),
(1959, 22, 'Fexhe-Slins', '4458'),
(1960, 22, 'Grâce-Berleur', '4460'),
(1961, 22, 'Hollogne-Aux-Pierres', '4460'),
(1962, 22, 'Bierset', '4460'),
(1963, 22, 'Grâce-Hollogne', '4460'),
(1964, 22, 'Horion-Hozémont', '4460'),
(1965, 22, 'Velroux', '4460'),
(1966, 22, 'Saint-Georges-Sur-Meuse', '4470'),
(1967, 22, 'Clermont-Sous-Huy', '4480'),
(1968, 22, 'Engis', '4480'),
(1969, 22, 'Ehein', '4480'),
(1970, 22, 'Hermalle-Sous-Huy', '4480'),
(1971, 22, 'Ben-Ahin', '4500'),
(1972, 22, 'Huy', '4500'),
(1973, 22, 'Tihange', '4500'),
(1974, 22, 'Vinalmont', '4520'),
(1975, 22, 'Wanze', '4520'),
(1976, 22, 'Moha', '4520'),
(1977, 22, 'Bas-Oha', '4520'),
(1978, 22, 'Huccorgne', '4520'),
(1979, 22, 'Antheit', '4520'),
(1980, 22, 'Warnant-Dreye', '4530'),
(1981, 22, 'Vieux-Waleffe', '4530'),
(1982, 22, 'Vaux-Et-Borset', '4530'),
(1983, 22, 'Villers-Le-Bouillet', '4530'),
(1984, 22, 'Fize-Fontaine', '4530'),
(1985, 22, 'Seraing-Le-Château', '4537'),
(1986, 22, 'Bodegnée', '4537'),
(1987, 22, 'Chapon-Seraing', '4537'),
(1988, 22, 'Verlaine', '4537'),
(1989, 22, 'Ampsin', '4540'),
(1990, 22, 'Ombret', '4540'),
(1991, 22, 'Amay', '4540'),
(1992, 22, 'Flône', '4540'),
(1993, 22, 'Jehay', '4540'),
(1994, 22, 'Saint-Séverin', '4550'),
(1995, 22, 'Villers-Le-Temple', '4550'),
(1996, 22, 'Nandrin', '4550'),
(1997, 22, 'Yernée-Fraineux', '4550'),
(1998, 22, 'Ramelot', '4557'),
(1999, 22, 'Soheit-Tinlot', '4557'),
(2000, 22, 'Tinlot', '4557'),
(2001, 22, 'Abée', '4557'),
(2002, 22, 'Seny', '4557'),
(2003, 22, 'Fraiture', '4557'),
(2004, 22, 'Clavier', '4560'),
(2005, 22, 'Terwagne', '4560'),
(2006, 22, 'Bois-Et-Borsu', '4560'),
(2007, 22, 'Les Avins', '4560'),
(2008, 22, 'Pailhe', '4560'),
(2009, 22, 'Ocquier', '4560'),
(2010, 22, 'Marchin', '4570'),
(2011, 22, 'Vyle-Et-Tharoul', '4570'),
(2012, 22, 'Strée-Lez-Huy', '4577'),
(2013, 22, 'Vierset-Barse', '4577'),
(2014, 22, 'Outrelouxhe', '4577'),
(2015, 22, 'Modave', '4577'),
(2016, 22, 'Warzée', '4590'),
(2017, 22, 'Ellemelle', '4590'),
(2018, 22, 'Ouffet', '4590'),
(2019, 22, 'Lixhe', '4600'),
(2020, 22, 'Lanaye', '4600'),
(2021, 22, 'Richelle', '4600'),
(2022, 22, 'Visé', '4600'),
(2023, 22, 'Argenteau', '4601'),
(2024, 22, 'Cheratte', '4602'),
(2025, 22, 'Saint-André', '4606'),
(2026, 22, 'Feneur', '4607'),
(2027, 22, 'Berneau', '4607'),
(2028, 22, 'Dalhem', '4607'),
(2029, 22, 'Bombaye', '4607'),
(2030, 22, 'Mortroux', '4607'),
(2031, 22, 'Warsage', '4608'),
(2032, 22, 'Neufchâteau', '4608'),
(2033, 22, 'Beyne-Heusay', '4610'),
(2034, 22, 'Bellaire', '4610'),
(2035, 22, 'Queue-Du-Bois', '4610'),
(2036, 22, 'Fléron', '4620'),
(2037, 22, 'Retinne', '4621'),
(2038, 22, 'Magnée', '4623'),
(2039, 22, 'Romsée', '4624'),
(2040, 22, 'Ayeneux', '4630'),
(2041, 22, 'Soumagne', '4630'),
(2042, 22, 'Tignée', '4630'),
(2043, 22, 'Micheroux', '4630'),
(2044, 22, 'Evegnée', '4631'),
(2045, 22, 'Cérexhe-Heuseux', '4632'),
(2046, 22, 'Melen', '4633'),
(2047, 22, 'Chaineux', '4650'),
(2048, 22, 'Grand-Rechain', '4650'),
(2049, 22, 'Herve', '4650'),
(2050, 22, 'Julémont', '4650'),
(2051, 22, 'Battice', '4651'),
(2052, 22, 'Xhendelesse', '4652'),
(2053, 22, 'Bolland', '4653'),
(2054, 22, 'Charneux', '4654'),
(2055, 22, 'Mortier', '4670'),
(2056, 22, 'Blégny', '4670'),
(2057, 22, 'Trembleur', '4670'),
(2058, 22, 'Saive', '4671'),
(2059, 22, 'Housse', '4671'),
(2060, 22, 'Barchon', '4671'),
(2061, 22, 'Saint-Remy', '4672'),
(2062, 22, 'Oupeye', '4680'),
(2063, 22, 'Hermée', '4680'),
(2064, 22, 'Hermalle-Sous-Argenteau', '4681'),
(2065, 22, 'Houtain-Saint-Siméon', '4682'),
(2066, 22, 'Heure-Le-Romain', '4682'),
(2067, 22, 'Vivegnis', '4683'),
(2068, 22, 'Haccourt', '4684'),
(2069, 22, 'Glons', '4690'),
(2070, 22, 'Boirs', '4690'),
(2071, 22, 'Roclenge-Sur-Geer', '4690'),
(2072, 22, 'Bassenge', '4690'),
(2073, 22, 'Wonck', '4690'),
(2074, 22, 'Eben-Emael', '4690'),
(2075, 22, 'Eupen', '4700'),
(2076, 22, 'Kettenis', '4701'),
(2077, 22, 'Lontzen', '4710'),
(2078, 22, 'Walhorn', '4711'),
(2079, 22, 'La Calamine', '4720'),
(2080, 22, 'Neu-Moresnet', '4721'),
(2081, 22, 'Hergenrath', '4728'),
(2082, 22, 'Hauset', '4730'),
(2083, 22, 'Raeren', '4730'),
(2084, 22, 'Eynatten', '4731'),
(2085, 22, 'Butgenbach', '4750'),
(2086, 22, 'Elsenborn', '4750'),
(2087, 22, 'Bullange', '4760'),
(2088, 22, 'Manderfeld', '4760'),
(2089, 22, 'Rocherath', '4761'),
(2090, 22, 'Amblève', '4770'),
(2091, 22, 'Meyerode', '4770'),
(2092, 22, 'Heppenbach', '4771'),
(2093, 22, 'Saint-Vith', '4780'),
(2094, 22, 'Recht', '4780'),
(2095, 22, 'Schoenberg', '4782'),
(2096, 22, 'Lommersweiler', '4783'),
(2097, 22, 'Crombach', '4784'),
(2098, 22, 'Burg-Reuland', '4790'),
(2099, 22, 'Reuland', '4790'),
(2100, 22, 'Thommen', '4791'),
(2101, 22, 'Polleur', '4800'),
(2102, 22, 'Ensival', '4800'),
(2103, 22, 'Verviers', '4800'),
(2104, 22, 'Petit-Rechain', '4800'),
(2105, 22, 'Lambermont', '4800'),
(2106, 22, 'Stembert', '4801'),
(2107, 22, 'Heusy', '4802'),
(2108, 22, 'Dison', '4820'),
(2109, 22, 'Andrimont', '4821'),
(2110, 22, 'Limbourg', '4830'),
(2111, 22, 'Bilstain', '4831'),
(2112, 22, 'Goé', '4834'),
(2113, 22, 'Baelen', '4837'),
(2114, 22, 'Membach', '4837'),
(2115, 22, 'Welkenraedt', '4840'),
(2116, 22, 'Henri-Chapelle', '4841'),
(2117, 22, 'Jalhay', '4845'),
(2118, 22, 'Sart-Lez-Spa', '4845'),
(2119, 22, 'Montzen', '4850'),
(2120, 22, 'Plombières', '4850'),
(2121, 22, 'Moresnet', '4850'),
(2122, 22, 'Gemmenich', '4851'),
(2123, 22, 'Sippenaeken', '4851'),
(2124, 22, 'Hombourg', '4852'),
(2125, 22, 'Pepinster', '4860'),
(2126, 22, 'Cornesse', '4860'),
(2127, 22, 'Wegnez', '4860'),
(2128, 22, 'Soiron', '4861'),
(2129, 22, 'Trooz', '4870'),
(2130, 22, 'Forêt', '4870'),
(2131, 22, 'Fraipont', '4870'),
(2132, 22, 'Nessonvaux', '4870'),
(2133, 22, 'Olne', '4877'),
(2134, 22, 'Aubel', '4880'),
(2135, 22, 'Clermont', '4890'),
(2136, 22, 'Thimister-Clermont', '4890'),
(2137, 22, 'Thimister', '4890'),
(2138, 22, 'Spa', '4900'),
(2139, 22, 'La Reid', '4910'),
(2140, 22, 'Theux', '4910'),
(2141, 22, 'Polleur', '4910'),
(2142, 22, 'Aywaille', '4920'),
(2143, 22, 'Louveigné', '4920'),
(2144, 22, 'Harzé', '4920'),
(2145, 22, 'Sougné-Remouchamps', '4920'),
(2146, 22, 'Ernonheid', '4920'),
(2147, 22, 'Sourbrodt', '4950'),
(2148, 22, 'Waimes', '4950'),
(2149, 22, 'Robertville', '4950'),
(2150, 22, 'Faymonville', '4950'),
(2151, 22, 'Bellevaux-Ligneuville', '4960'),
(2152, 22, 'Malmedy', '4960'),
(2153, 22, 'Bevercé', '4960'),
(2154, 22, 'Stavelot', '4970'),
(2155, 22, 'Francorchamps', '4970'),
(2156, 22, 'Fosse', '4980'),
(2157, 22, 'Wanne', '4980'),
(2158, 22, 'Trois-Ponts', '4980'),
(2159, 22, 'Basse-Bodeux', '4983'),
(2160, 22, 'Stoumont', '4987'),
(2161, 22, 'La Gleize', '4987'),
(2162, 22, 'Chevron', '4987'),
(2163, 22, 'Lorcé', '4987'),
(2164, 22, 'Rahier', '4987'),
(2165, 22, 'Lierneux', '4990'),
(2166, 22, 'Bra', '4990'),
(2167, 22, 'Arbrefontaine', '4990'),
(2168, 22, 'Villers-La-Bonne-Eau', '6600'),
(2169, 22, 'Bastogne', '6600'),
(2170, 22, 'Noville', '6600'),
(2171, 22, 'Longvilly', '6600'),
(2172, 22, 'Wardin', '6600'),
(2173, 22, 'Martelange', '6630'),
(2174, 22, 'Fauvillers', '6637'),
(2175, 22, 'Tintange', '6637'),
(2176, 22, 'Hollange', '6637'),
(2177, 22, 'Sibret', '6640'),
(2178, 22, 'Nives', '6640'),
(2179, 22, 'Vaux-Sur-Sûre', '6640'),
(2180, 22, 'Morhet', '6640'),
(2181, 22, 'Hompré', '6640'),
(2182, 22, 'Vaux-Lez-Rosières', '6640'),
(2183, 22, 'Juseret', '6642'),
(2184, 22, 'Houffalize', '6660'),
(2185, 22, 'Nadrin', '6660'),
(2186, 22, 'Tailles', '6661'),
(2187, 22, 'Mont', '6661'),
(2188, 22, 'Tavigny', '6662'),
(2189, 22, 'Mabompré', '6663'),
(2190, 22, 'Wibrin', '6666'),
(2191, 22, 'Gouvy', '6670'),
(2192, 22, 'Limerlé', '6670'),
(2193, 22, 'Bovigny', '6671'),
(2194, 22, 'Beho', '6672'),
(2195, 22, 'Cherain', '6673'),
(2196, 22, 'Montleban', '6674'),
(2197, 22, 'Sainte-Ode', '6680'),
(2198, 22, 'Amberloup', '6680'),
(2199, 22, 'Tillet', '6680'),
(2200, 22, 'Lavacherie', '6681'),
(2201, 22, 'Flamierge', '6686'),
(2202, 22, 'Bertogne', '6687'),
(2203, 22, 'Longchamps', '6688'),
(2204, 22, 'Vielsalm', '6690'),
(2205, 22, 'Bihain', '6690'),
(2206, 22, 'Petit-Thier', '6692'),
(2207, 22, 'Grand-Halleux', '6698'),
(2208, 22, 'Toernich', '6700'),
(2209, 22, 'Arlon', '6700'),
(2210, 22, 'Heinsch', '6700'),
(2211, 22, 'Bonnert', '6700'),
(2212, 22, 'Guirsch', '6704'),
(2213, 22, 'Autelbas', '6706'),
(2214, 22, 'Attert', '6717'),
(2215, 22, 'Tontelange', '6717'),
(2216, 22, 'Thiaumont', '6717'),
(2217, 22, 'Nothomb', '6717'),
(2218, 22, 'Nobressart', '6717'),
(2219, 22, 'Habay', '6720'),
(2220, 22, 'Habay-La-Neuve', '6720'),
(2221, 22, 'Hachy', '6720'),
(2222, 22, 'Anlier', '6721'),
(2223, 22, 'Habay-La-Vieille', '6723'),
(2224, 22, 'Houdemont', '6724'),
(2225, 22, 'Rulles', '6724'),
(2226, 22, 'Tintigny', '6730'),
(2227, 22, 'Bellefontaine', '6730'),
(2228, 22, 'Rossignol', '6730'),
(2229, 22, 'Saint-Vincent', '6730'),
(2230, 22, 'Etalle', '6740'),
(2231, 22, 'Villers-Sur-Semois', '6740'),
(2232, 22, 'Sainte-Marie-Sur-Semois', '6740'),
(2233, 22, 'Vance', '6741'),
(2234, 22, 'Chantemelle', '6742'),
(2235, 22, 'Buzenol', '6743'),
(2236, 22, 'Châtillon', '6747'),
(2237, 22, 'Meix-Le-Tige', '6747'),
(2238, 22, 'Saint-Léger', '6747'),
(2239, 22, 'Musson', '6750'),
(2240, 22, 'Signeulx', '6750'),
(2241, 22, 'Mussy-La-Ville', '6750'),
(2242, 22, 'Virton', '6760'),
(2243, 22, 'Bleid', '6760'),
(2244, 22, 'Ethe', '6760'),
(2245, 22, 'Ruette', '6760'),
(2246, 22, 'Latour', '6761'),
(2247, 22, 'Saint-Mard', '6762'),
(2248, 22, 'Harnoncourt', '6767'),
(2249, 22, 'Rouvroy', '6767'),
(2250, 22, 'Torgny', '6767'),
(2251, 22, 'Dampicourt', '6767'),
(2252, 22, 'Lamorteau', '6767'),
(2253, 22, 'Villers-La-Loue', '6769'),
(2254, 22, 'Sommethonne', '6769'),
(2255, 22, 'Meix-Devant-Virton', '6769'),
(2256, 22, 'Robelmont', '6769'),
(2257, 22, 'Gérouville', '6769'),
(2258, 22, 'Hondelange', '6780'),
(2259, 22, 'Wolkrange', '6780'),
(2260, 22, 'Messancy', '6780'),
(2261, 22, 'Sélange', '6781'),
(2262, 22, 'Habergy', '6782'),
(2263, 22, 'Aubange', '6790'),
(2264, 22, 'Athus', '6791'),
(2265, 22, 'Rachecourt', '6792'),
(2266, 22, 'Halanzy', '6792'),
(2267, 22, 'Recogne', '6800'),
(2268, 22, 'Sainte-Marie-Chevigny', '6800'),
(2269, 22, 'Bras', '6800'),
(2270, 22, 'Saint-Pierre', '6800'),
(2271, 22, 'Freux', '6800'),
(2272, 22, 'Moircy', '6800'),
(2273, 22, 'Remagne', '6800'),
(2274, 22, 'Libramont-Chevigny', '6800'),
(2275, 22, 'Jamoigne', '6810'),
(2276, 22, 'Izel', '6810'),
(2277, 22, 'Chiny', '6810'),
(2278, 22, 'Les Bulles', '6811'),
(2279, 22, 'Suxy', '6812'),
(2280, 22, 'Termes', '6813'),
(2281, 22, 'Sainte-Cécile', '6820'),
(2282, 22, 'Fontenoille', '6820'),
(2283, 22, 'Florenville', '6820'),
(2284, 22, 'Muno', '6820'),
(2285, 22, 'Lacuisine', '6821'),
(2286, 22, 'Villers-Devant-Orval', '6823'),
(2287, 22, 'Chassepierre', '6824'),
(2288, 22, 'Les Hayons', '6830'),
(2289, 22, 'Bouillon', '6830'),
(2290, 22, 'Rochehaut', '6830'),
(2291, 22, 'Poupehan', '6830'),
(2292, 22, 'Noirfontaine', '6831'),
(2293, 22, 'Sensenruth', '6832'),
(2294, 22, 'Vivy', '6833'),
(2295, 22, 'Ucimont', '6833'),
(2296, 22, 'Bellevaux', '6834'),
(2297, 22, 'Dohan', '6836'),
(2298, 22, 'Corbion', '6838'),
(2299, 22, 'Grapfontaine', '6840'),
(2300, 22, 'Grandvoir', '6840'),
(2301, 22, 'Longlier', '6840'),
(2302, 22, 'Tournay', '6840'),
(2303, 22, 'Hamipré', '6840'),
(2304, 22, 'Neufchâteau', '6840'),
(2305, 22, 'Offagne', '6850'),
(2306, 22, 'Paliseul', '6850'),
(2307, 22, 'Carlsbourg', '6850'),
(2308, 22, 'Nollevaux', '6851'),
(2309, 22, 'Maissin', '6852'),
(2310, 22, 'Opont', '6852'),
(2311, 22, 'Framont', '6853'),
(2312, 22, 'Fays-Les-Veneurs', '6856'),
(2313, 22, 'Léglise', '6860'),
(2314, 22, 'Ebly', '6860'),
(2315, 22, 'Mellier', '6860'),
(2316, 22, 'Assenois', '6860'),
(2317, 22, 'Witry', '6860'),
(2318, 22, 'Awenne', '6870'),
(2319, 22, 'Mirwart', '6870'),
(2320, 22, 'Vesqueville', '6870'),
(2321, 22, 'Saint-Hubert', '6870'),
(2322, 22, 'Arville', '6870'),
(2323, 22, 'Hatrival', '6870'),
(2324, 22, 'Jehonville', '6880'),
(2325, 22, 'Cugnon', '6880'),
(2326, 22, 'Bertrix', '6880'),
(2327, 22, 'Auby-Sur-Semois', '6880'),
(2328, 22, 'Orgeo', '6880'),
(2329, 22, 'Saint-Médard', '6887'),
(2330, 22, 'Straimont', '6887'),
(2331, 22, 'Herbeumont', '6887'),
(2332, 22, 'Redu', '6890'),
(2333, 22, 'Transinne', '6890'),
(2334, 22, 'Libin', '6890'),
(2335, 22, 'Smuid', '6890'),
(2336, 22, 'Anloy', '6890'),
(2337, 22, 'Villance', '6890'),
(2338, 22, 'Ochamps', '6890'),
(2339, 22, 'Aye', '6900'),
(2340, 22, 'Marche-En-Famenne', '6900'),
(2341, 22, 'Waha', '6900'),
(2342, 22, 'Humain', '6900'),
(2343, 22, 'On', '6900'),
(2344, 22, 'Hargimont', '6900'),
(2345, 22, 'Roy', '6900'),
(2346, 22, 'Wellin', '6920'),
(2347, 22, 'Sohier', '6920'),
(2348, 22, 'Chanly', '6921'),
(2349, 22, 'Halma', '6922'),
(2350, 22, 'Lomprez', '6924'),
(2351, 22, 'Bure', '6927'),
(2352, 22, 'Resteigne', '6927'),
(2353, 22, 'Grupont', '6927'),
(2354, 22, 'Tellin', '6927'),
(2355, 22, 'Daverdisse', '6929'),
(2356, 22, 'Porcheresse', '6929'),
(2357, 22, 'Gembes', '6929'),
(2358, 22, 'Haut-Fays', '6929'),
(2359, 22, 'Grandhan', '6940'),
(2360, 22, 'Wéris', '6940'),
(2361, 22, 'Septon', '6940'),
(2362, 22, 'Barvaux-Sur-Ourthe', '6940'),
(2363, 22, 'Durbuy', '6940'),
(2364, 22, 'Villers-Sainte-Gertrude', '6941'),
(2365, 22, 'Heyd', '6941'),
(2366, 22, 'Bende', '6941'),
(2367, 22, 'Izier', '6941'),
(2368, 22, 'Borlon', '6941'),
(2369, 22, 'Tohogne', '6941'),
(2370, 22, 'Bomal-Sur-Ourthe', '6941'),
(2371, 22, 'Nassogne', '6950'),
(2372, 22, 'Harsin', '6950'),
(2373, 22, 'Bande', '6951'),
(2374, 22, 'Grune', '6952'),
(2375, 22, 'Lesterny', '6953'),
(2376, 22, 'Forrières', '6953'),
(2377, 22, 'Masbourg', '6953'),
(2378, 22, 'Ambly', '6953'),
(2379, 22, 'Dochamps', '6960'),
(2380, 22, 'Vaux-Chavanne', '6960'),
(2381, 22, 'Grandménil', '6960'),
(2382, 22, 'Harre', '6960'),
(2383, 22, 'Odeigne', '6960'),
(2384, 22, 'Malempré', '6960'),
(2385, 22, 'Manhay', '6960'),
(2386, 22, 'Tenneville', '6970'),
(2387, 22, 'Champlon', '6971'),
(2388, 22, 'Erneuville', '6972'),
(2389, 22, 'Beausaint', '6980'),
(2390, 22, 'La Roche-En-Ardenne', '6980'),
(2391, 22, 'Samrée', '6982'),
(2392, 22, 'Ortho', '6983'),
(2393, 22, 'Hives', '6984'),
(2394, 22, 'Halleux', '6986'),
(2395, 22, 'Hodister', '6987'),
(2396, 22, 'Rendeux', '6987'),
(2397, 22, 'Marcourt', '6987'),
(2398, 22, 'Beffe', '6987'),
(2399, 22, 'Marenne', '6990'),
(2400, 22, 'Hotton', '6990'),
(2401, 22, 'Fronville', '6990'),
(2402, 22, 'Hampteau', '6990'),
(2403, 22, 'Erezée', '6997'),
(2404, 22, 'Amonines', '6997'),
(2405, 22, 'Mormont', '6997'),
(2406, 22, 'Soy', '6997'),
(2407, 22, 'Beez', '5000'),
(2408, 22, 'Namur', '5000'),
(2409, 22, 'Belgrade', '5001'),
(2410, 22, 'Saint-Servais', '5002'),
(2411, 22, 'Saint-Marc', '5003'),
(2412, 22, 'Bouge', '5004'),
(2413, 22, 'Malonne', '5020'),
(2414, 22, 'Suarlée', '5020'),
(2415, 22, 'Flawinne', '5020'),
(2416, 22, 'Vedrin', '5020'),
(2417, 22, 'Temploux', '5020'),
(2418, 22, 'Daussoulx', '5020'),
(2419, 22, 'Champion', '5020'),
(2420, 22, 'Boninne', '5021'),
(2421, 22, 'Cognelée', '5022'),
(2422, 22, 'Marche-Les-Dames', '5024'),
(2423, 22, 'Gelbressée', '5024'),
(2424, 22, 'Ernage', '5030'),
(2425, 22, 'Sauvenière', '5030'),
(2426, 22, 'Gembloux', '5030'),
(2427, 22, 'Beuzet', '5030'),
(2428, 22, 'Grand-Manil', '5030'),
(2429, 22, 'Lonzée', '5030'),
(2430, 22, 'Grand-Leez', '5031'),
(2431, 22, 'Bothey', '5032'),
(2432, 22, 'Mazy', '5032'),
(2433, 22, 'Bossière', '5032'),
(2434, 22, 'Corroy-Le-Château', '5032'),
(2435, 22, 'Isnes', '5032'),
(2436, 22, 'Velaine-Sur-Sambre', '5060'),
(2437, 22, 'Auvelais', '5060'),
(2438, 22, 'Arsimont', '5060'),
(2439, 22, 'Moignelée', '5060'),
(2440, 22, 'Falisolle', '5060'),
(2441, 22, 'Sambreville', '5060'),
(2442, 22, 'Tamines', '5060'),
(2443, 22, 'Keumiée', '5060'),
(2444, 22, 'Sart-Saint-Laurent', '5070'),
(2445, 22, 'Vitrival', '5070'),
(2446, 22, 'Aisemont', '5070'),
(2447, 22, 'Sart-Eustache', '5070'),
(2448, 22, 'Le Roux', '5070'),
(2449, 22, 'Fosses-La-Ville', '5070'),
(2450, 22, 'Emines', '5080'),
(2451, 22, 'La Bruyère', '5080'),
(2452, 22, 'Villers-Lez-Heest', '5080'),
(2453, 22, 'Rhisnes', '5080'),
(2454, 22, 'Warisoulx', '5080'),
(2455, 22, 'Saint-Denis-Bovesse', '5081'),
(2456, 22, 'Bovesse', '5081'),
(2457, 22, 'Meux', '5081'),
(2458, 22, 'Dave', '5100'),
(2459, 22, 'Naninne', '5100'),
(2460, 22, 'Jambes', '5100'),
(2461, 22, 'Wierde', '5100'),
(2462, 22, 'Wépion', '5100'),
(2463, 22, 'Erpent', '5101'),
(2464, 22, 'Loyers', '5101'),
(2465, 22, 'Lives-Sur-Meuse', '5101'),
(2466, 22, 'Ligny', '5140'),
(2467, 22, 'Boignée', '5140'),
(2468, 22, 'Tongrinne', '5140'),
(2469, 22, 'Sombreffe', '5140'),
(2470, 22, 'Soye', '5150'),
(2471, 22, 'Floriffoux', '5150'),
(2472, 22, 'Floreffe', '5150'),
(2473, 22, 'Franière', '5150'),
(2474, 22, 'Lesve', '5170'),
(2475, 22, 'Arbre', '5170'),
(2476, 22, 'Profondeville', '5170'),
(2477, 22, 'Rivière', '5170'),
(2478, 22, 'Lustin', '5170'),
(2479, 22, 'Bois-De-Villers', '5170'),
(2480, 22, 'Mornimont', '5190'),
(2481, 22, 'Moustier-Sur-Sambre', '5190'),
(2482, 22, 'Balâtre', '5190'),
(2483, 22, 'Spy', '5190'),
(2484, 22, 'Onoz', '5190'),
(2485, 22, 'Jemeppe-Sur-Sambre', '5190'),
(2486, 22, 'Ham-Sur-Sambre', '5190'),
(2487, 22, 'Saint-Martin', '5190'),
(2488, 22, 'Andenne', '5300'),
(2489, 22, 'Coutisse', '5300'),
(2490, 22, 'Landenne', '5300'),
(2491, 22, 'Vezin', '5300'),
(2492, 22, 'Seilles', '5300'),
(2493, 22, 'Sclayn', '5300'),
(2494, 22, 'Maizeret', '5300'),
(2495, 22, 'Namêche', '5300'),
(2496, 22, 'Thon', '5300'),
(2497, 22, 'Bonneville', '5300'),
(2498, 22, 'Saint-Germain', '5310'),
(2499, 22, 'Leuze', '5310'),
(2500, 22, 'Noville-Sur-Mehaigne', '5310'),
(2501, 22, 'Taviers', '5310'),
(2502, 22, 'Mehaigne', '5310'),
(2503, 22, 'Upigny', '5310'),
(2504, 22, 'Eghezée', '5310'),
(2505, 22, 'Boneffe', '5310'),
(2506, 22, 'Dhuy', '5310'),
(2507, 22, 'Waret-La-Chaussée', '5310'),
(2508, 22, 'Liernu', '5310'),
(2509, 22, 'Hanret', '5310'),
(2510, 22, 'Branchon', '5310'),
(2511, 22, 'Bolinne', '5310'),
(2512, 22, 'Longchamps', '5310'),
(2513, 22, 'Aische-En-Refail', '5310'),
(2514, 22, 'Maillen', '5330'),
(2515, 22, 'Sart-Bernard', '5330'),
(2516, 22, 'Assesse', '5330'),
(2517, 22, 'Crupet', '5332'),
(2518, 22, 'Sorinne-La-Longue', '5333'),
(2519, 22, 'Florée', '5334'),
(2520, 22, 'Courrière', '5336'),
(2521, 22, 'Sorée', '5340'),
(2522, 22, 'Mozet', '5340'),
(2523, 22, 'Gesves', '5340'),
(2524, 22, 'Haltinne', '5340'),
(2525, 22, 'Faulx-Les-Tombes', '5340'),
(2526, 22, 'Ohey', '5350'),
(2527, 22, 'Evelette', '5350'),
(2528, 22, 'Haillot', '5351'),
(2529, 22, 'Perwez-Haillot', '5352'),
(2530, 22, 'Goesnes', '5353'),
(2531, 22, 'Jallet', '5354'),
(2532, 22, 'Natoye', '5360'),
(2533, 22, 'Hamois', '5360'),
(2534, 22, 'Scy', '5361'),
(2535, 22, 'Mohiville', '5361'),
(2536, 22, 'Achet', '5362'),
(2537, 22, 'Emptinne', '5363'),
(2538, 22, 'Schaltin', '5364'),
(2539, 22, 'Flostoy', '5370'),
(2540, 22, 'Barvaux-Condroz', '5370'),
(2541, 22, 'Porcheresse', '5370'),
(2542, 22, 'Havelange', '5370'),
(2543, 22, 'Jeneffe', '5370'),
(2544, 22, 'Verlée', '5370'),
(2545, 22, 'Méan', '5372'),
(2546, 22, 'Maffe', '5374'),
(2547, 22, 'Miécret', '5376'),
(2548, 22, 'Noiseux', '5377'),
(2549, 22, 'Nettinne', '5377'),
(2550, 22, 'Bonsin', '5377'),
(2551, 22, 'Hogne', '5377'),
(2552, 22, 'Heure', '5377'),
(2553, 22, 'Baillonville', '5377'),
(2554, 22, 'Waillet', '5377'),
(2555, 22, 'Sinsin', '5377'),
(2556, 22, 'Somme-Leuze', '5377'),
(2557, 22, 'Hingeon', '5380'),
(2558, 22, 'Marchovelette', '5380'),
(2559, 22, 'Bierwart', '5380'),
(2560, 22, 'Noville-Les-Bois', '5380'),
(2561, 22, 'Cortil-Wodon', '5380'),
(2562, 22, 'Tillier', '5380'),
(2563, 22, 'Hemptinne', '5380'),
(2564, 22, 'Franc-Waret', '5380'),
(2565, 22, 'Fernelmont', '5380'),
(2566, 22, 'Pontillas', '5380'),
(2567, 22, 'Forville', '5380'),
(2568, 22, 'Anseremme', '5500'),
(2569, 22, 'Furfooz', '5500'),
(2570, 22, 'Falmignoul', '5500'),
(2571, 22, 'Dinant', '5500'),
(2572, 22, 'Falmagne', '5500'),
(2573, 22, 'Dréhance', '5500'),
(2574, 22, 'Bouvignes-Sur-Meuse', '5500'),
(2575, 22, 'Lisogne', '5501'),
(2576, 22, 'Thynes', '5502'),
(2577, 22, 'Sorinnes', '5503'),
(2578, 22, 'Foy-Notre-Dame', '5504'),
(2579, 22, 'Onhaye', '5520'),
(2580, 22, 'Anthée', '5520'),
(2581, 22, 'Serville', '5521'),
(2582, 22, 'Falaën', '5522'),
(2583, 22, 'Weillen', '5523'),
(2584, 22, 'Sommière', '5523'),
(2585, 22, 'Gérin', '5524'),
(2586, 22, 'Yvoir', '5530'),
(2587, 22, 'Evrehailles', '5530'),
(2588, 22, 'Dorinne', '5530'),
(2589, 22, 'Houx', '5530'),
(2590, 22, 'Godinne', '5530'),
(2591, 22, 'Spontin', '5530'),
(2592, 22, 'Mont', '5530'),
(2593, 22, 'Purnode', '5530'),
(2594, 22, 'Durnal', '5530'),
(2595, 22, 'Sosoye', '5537'),
(2596, 22, 'Denée', '5537'),
(2597, 22, 'Anhée', '5537'),
(2598, 22, 'Warnant', '5537'),
(2599, 22, 'Annevoie-Rouillon', '5537'),
(2600, 22, 'Bioul', '5537'),
(2601, 22, 'Haut-Le-Wastia', '5537'),
(2602, 22, 'Hastière', '5540'),
(2603, 22, 'Waulsort', '5540'),
(2604, 22, 'Hermeton-Sur-Meuse', '5540'),
(2605, 22, 'Hastière-Lavaux', '5540'),
(2606, 22, 'Hastière-Par-Delà', '5541'),
(2607, 22, 'Blaimont', '5542'),
(2608, 22, 'Heer', '5543'),
(2609, 22, 'Agimont', '5544'),
(2610, 22, 'Bohan', '5550'),
(2611, 22, 'Pussemange', '5550'),
(2612, 22, 'Nafraiture', '5550'),
(2613, 22, 'Vresse-Sur-Semois', '5550'),
(2614, 22, 'Orchimont', '5550'),
(2615, 22, 'Laforêt', '5550'),
(2616, 22, 'Bagimont', '5550'),
(2617, 22, 'Alle', '5550'),
(2618, 22, 'Sugny', '5550'),
(2619, 22, 'Chairière', '5550'),
(2620, 22, 'Membre', '5550'),
(2621, 22, 'Mouzaive', '5550'),
(2622, 22, 'Bellefontaine', '5555'),
(2623, 22, 'Baillamont', '5555'),
(2624, 22, 'Bièvre', '5555'),
(2625, 22, 'Gros-Fays', '5555'),
(2626, 22, 'Oizy', '5555'),
(2627, 22, 'Petit-Fays', '5555'),
(2628, 22, 'Graide', '5555'),
(2629, 22, 'Cornimont', '5555'),
(2630, 22, 'Naomé', '5555'),
(2631, 22, 'Monceau-En-Ardenne', '5555'),
(2632, 22, 'Mesnil-Saint-Blaise', '5560'),
(2633, 22, 'Mesnil-Eglise', '5560'),
(2634, 22, 'Finnevaux', '5560'),
(2635, 22, 'Ciergnon', '5560'),
(2636, 22, 'Houyet', '5560'),
(2637, 22, 'Hulsonniaux', '5560'),
(2638, 22, 'Celles', '5561'),
(2639, 22, 'Custinne', '5562'),
(2640, 22, 'Hour', '5563'),
(2641, 22, 'Wanlin', '5564'),
(2642, 22, 'Vonêche', '5570'),
(2643, 22, 'Javingue', '5570'),
(2644, 22, 'Feschaux', '5570'),
(2645, 22, 'Dion', '5570'),
(2646, 22, 'Beauraing', '5570'),
(2647, 22, 'Winenne', '5570'),
(2648, 22, 'Honnay', '5570'),
(2649, 22, 'Baronville', '5570'),
(2650, 22, 'Felenne', '5570'),
(2651, 22, 'Wancennes', '5570'),
(2652, 22, 'Wiesme', '5571'),
(2653, 22, 'Focant', '5572'),
(2654, 22, 'Martouzin-Neuville', '5573'),
(2655, 22, 'Pondrôme', '5574'),
(2656, 22, 'Rienne', '5575'),
(2657, 22, 'Bourseigne-Vieille', '5575'),
(2658, 22, 'Malvoisin', '5575'),
(2659, 22, 'Louette-Saint-Pierre', '5575'),
(2660, 22, 'Sart-Custinne', '5575'),
(2661, 22, 'Vencimont', '5575'),
(2662, 22, 'Houdremont', '5575'),
(2663, 22, 'Louette-Saint-Denis', '5575'),
(2664, 22, 'Willerzie', '5575'),
(2665, 22, 'Bourseigne-Neuve', '5575'),
(2666, 22, 'Patignies', '5575'),
(2667, 22, 'Gedinne', '5575'),
(2668, 22, 'Froidfontaine', '5576'),
(2669, 22, 'Ave-Et-Auffe', '5580'),
(2670, 22, 'Lessive', '5580'),
(2671, 22, 'Mont-Gauthier', '5580'),
(2672, 22, 'Eprave', '5580'),
(2673, 22, 'Rochefort', '5580'),
(2674, 22, 'Villers-Sur-Lesse', '5580'),
(2675, 22, 'Han-Sur-Lesse', '5580'),
(2676, 22, 'Jemelle', '5580'),
(2677, 22, 'Buissonville', '5580'),
(2678, 22, 'Lavaux-Sainte-Anne', '5580'),
(2679, 22, 'Wavreille', '5580'),
(2680, 22, 'Chevetogne', '5590'),
(2681, 22, 'Pessoux', '5590'),
(2682, 22, 'Conneux', '5590'),
(2683, 22, 'Achêne', '5590'),
(2684, 22, 'Braibant', '5590'),
(2685, 22, 'Haversin', '5590'),
(2686, 22, 'Ciney', '5590'),
(2687, 22, 'Serinchamps', '5590'),
(2688, 22, 'Leignon', '5590'),
(2689, 22, 'Sovet', '5590'),
(2690, 22, 'Jamagne', '5600'),
(2691, 22, 'Neuville', '5600'),
(2692, 22, 'Merlemont', '5600'),
(2693, 22, 'Sautour', '5600'),
(2694, 22, 'Omezée', '5600'),
(2695, 22, 'Romedenne', '5600'),
(2696, 22, 'Samart', '5600'),
(2697, 22, 'Philippeville', '5600'),
(2698, 22, 'Villers-Le-Gambon', '5600'),
(2699, 22, 'Villers-En-Fagne', '5600'),
(2700, 22, 'Roly', '5600'),
(2701, 22, 'Jamiolle', '5600'),
(2702, 22, 'Vodecée', '5600'),
(2703, 22, 'Sart-En-Fagne', '5600'),
(2704, 22, 'Fagnolle', '5600'),
(2705, 22, 'Franchimont', '5600'),
(2706, 22, 'Surice', '5600'),
(2707, 22, 'Saint-Aubin', '5620'),
(2708, 22, 'Florennes', '5620'),
(2709, 22, 'Morville', '5620'),
(2710, 22, 'Flavion', '5620'),
(2711, 22, 'Rosée', '5620'),
(2712, 22, 'Hemptinne-Lez-Florennes', '5620'),
(2713, 22, 'Corenne', '5620'),
(2714, 22, 'Hanzinne', '5621'),
(2715, 22, 'Hanzinelle', '5621'),
(2716, 22, 'Morialmé', '5621'),
(2717, 22, 'Thy-Le-Baudouin', '5621'),
(2718, 22, 'Senzeilles', '5630'),
(2719, 22, 'Soumoy', '5630'),
(2720, 22, 'Silenrieux', '5630'),
(2721, 22, 'Daussois', '5630'),
(2722, 22, 'Cerfontaine', '5630'),
(2723, 22, 'Villers-Deux-Eglises', '5630'),
(2724, 22, 'Biesme', '5640'),
(2725, 22, 'Graux', '5640'),
(2726, 22, 'Oret', '5640'),
(2727, 22, 'Saint-Gérard', '5640'),
(2728, 22, 'Mettet', '5640'),
(2729, 22, 'Biesmerée', '5640'),
(2730, 22, 'Furnaux', '5641'),
(2731, 22, 'Ermeton-Sur-Biert', '5644'),
(2732, 22, 'Stave', '5646'),
(2733, 22, 'Fraire', '5650'),
(2734, 22, 'Pry', '5650'),
(2735, 22, 'Clermont', '5650'),
(2736, 22, 'Yves-Gomezée', '5650'),
(2737, 22, 'Vogenée', '5650'),
(2738, 22, 'Castillon', '5650'),
(2739, 22, 'Chastrès', '5650'),
(2740, 22, 'Fontenelle', '5650'),
(2741, 22, 'Walcourt', '5650'),
(2742, 22, 'Gourdinne', '5651'),
(2743, 22, 'Somzée', '5651'),
(2744, 22, 'Berzée', '5651'),
(2745, 22, 'Laneffe', '5651'),
(2746, 22, 'Tarcienne', '5651'),
(2747, 22, 'Thy-Le-Château', '5651'),
(2748, 22, 'Rognée', '5651'),
(2749, 22, 'Couvin', '5660'),
(2750, 22, 'Dailly', '5660'),
(2751, 22, 'Pesche', '5660'),
(2752, 22, 'Pétigny', '5660'),
(2753, 22, 'Presgaux', '5660'),
(2754, 22, 'Petite-Chapelle', '5660'),
(2755, 22, 'Gonrieux', '5660'),
(2756, 22, 'Boussu-En-Fagne', '5660'),
(2757, 22, 'Cul-Des-Sarts', '5660'),
(2758, 22, 'Frasnes', '5660'),
(2759, 22, 'Brûly', '5660'),
(2760, 22, 'Aublain', '5660'),
(2761, 22, 'Brûly-De-Pesche', '5660'),
(2762, 22, 'Mariembourg', '5660'),
(2763, 22, 'Viroinval', '5670'),
(2764, 22, 'Le Mesnil', '5670'),
(2765, 22, 'Olloy-Sur-Viroin', '5670'),
(2766, 22, 'Mazée', '5670'),
(2767, 22, 'Dourbes', '5670'),
(2768, 22, 'Vierves-Sur-Viroin', '5670'),
(2769, 22, 'Nismes', '5670'),
(2770, 22, 'Treignes', '5670'),
(2771, 22, 'Oignies-En-Thiérache', '5670'),
(2772, 22, 'Vodelée', '5680'),
(2773, 22, 'Gochenée', '5680'),
(2774, 22, 'Soulme', '5680'),
(2775, 22, 'Gimnée', '5680'),
(2776, 22, 'Niverlée', '5680'),
(2777, 22, 'Matagne-La-Petite', '5680'),
(2778, 22, 'Romerée', '5680'),
(2779, 22, 'Vaucelles', '5680'),
(2780, 22, 'Matagne-La-Grande', '5680'),
(2781, 22, 'Doische', '5680'),
(2782, 77, 'Roissy-en-France', '95700'),
(2783, 77, 'Orly', '94390'),
(2784, 77, 'Lesquin', '59810'),
(2785, 77, 'Tillé', '60000'),
(2786, 84, 'Düsseldorf', '40474'),
(2787, 84, 'Köln', '51147'),
(2788, 130, 'Findel', '2632');

-- --------------------------------------------------------

--
-- Structure de la table `countries`
--

DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries` (
  `id` int(11) NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `iso_alpha3` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `countries`
--

INSERT INTO `countries` (`id`, `label`, `iso_alpha3`) VALUES
(1, 'Afghanistan', 'AFG'),
(2, 'Îles Åland', 'ALA'),
(3, 'Albanie', 'ALB'),
(4, 'Algérie', 'DZA'),
(5, 'Samoa américaines', 'ASM'),
(6, 'Andorre', 'AND'),
(7, 'Angola', 'AGO'),
(8, 'Anguilla', 'AIA'),
(9, 'Antarctique', 'ATA'),
(10, 'Antigua-et-Barbuda', 'ATG'),
(11, 'Argentine', 'ARG'),
(12, 'Arménie', 'ARM'),
(13, 'Aruba', 'ABW'),
(14, 'Australie', 'AUS'),
(15, 'Autriche', 'AUT'),
(16, 'Azerbaïdjan', 'AZE'),
(17, 'Bahamas', 'BHS'),
(18, 'Bahreïn', 'BHR'),
(19, 'Bangladesh', 'BGD'),
(20, 'Barbade', 'BRB'),
(21, 'Biélorussie', 'BLR'),
(22, 'Belgique', 'BEL'),
(23, 'Belize', 'BLZ'),
(24, 'Bénin', 'BEN'),
(25, 'Bermudes', 'BMU'),
(26, 'Bhoutan', 'BTN'),
(27, 'Bolivie', 'BOL'),
(28, 'Bosnie-Herzégovine', 'BIH'),
(29, 'Botswana', 'BWA'),
(30, 'Île Bouvet', 'BVT'),
(31, 'Brésil', 'BRA'),
(32, 'British Virgin Islands', 'VGB'),
(33, 'Territoire britannique de l’Océan Indien', 'IOT'),
(34, 'Brunei Darussalam', 'BRN'),
(35, 'Bulgarie', 'BGR'),
(36, 'Burkina Faso', 'BFA'),
(37, 'Burundi', 'BDI'),
(38, 'Cambodge', 'KHM'),
(39, 'Cameroun', 'CMR'),
(40, 'Canada', 'CAN'),
(41, 'Cap-Vert', 'CPV'),
(42, 'Iles Cayman', 'CYM'),
(43, 'République centrafricaine', 'CAF'),
(44, 'Tchad', 'TCD'),
(45, 'Chili', 'CHL'),
(46, 'Chine', 'CHN'),
(47, 'Hong Kong', 'HKG'),
(48, 'Macao', 'MAC'),
(49, 'Île Christmas', 'CXR'),
(50, 'Îles Cocos', 'CCK'),
(51, 'Colombie', 'COL'),
(52, 'Comores', 'COM'),
(53, 'République du Congo', 'COG'),
(54, 'République démocratique du Congo', 'COD'),
(55, 'Îles Cook', 'COK'),
(56, 'Costa Rica', 'CRI'),
(57, 'Côte d’Ivoire', 'CIV'),
(58, 'Croatie', 'HRV'),
(59, 'Cuba', 'CUB'),
(60, 'Chypre', 'CYP'),
(61, 'République tchèque', 'CZE'),
(62, 'Danemark', 'DNK'),
(63, 'Djibouti', 'DJI'),
(64, 'Dominique', 'DMA'),
(65, 'République dominicaine', 'DOM'),
(66, 'Équateur', 'ECU'),
(67, 'Égypte', 'EGY'),
(68, 'Salvador', 'SLV'),
(69, 'Guinée équatoriale', 'GNQ'),
(70, 'Érythrée', 'ERI'),
(71, 'Estonie', 'EST'),
(72, 'Éthiopie', 'ETH'),
(73, 'Îles Falkland', 'FLK'),
(74, 'Îles Féroé', 'FRO'),
(75, 'Fidji', 'FJI'),
(76, 'Finlande', 'FIN'),
(77, 'France', 'FRA'),
(78, 'Guyane française', 'GUF'),
(79, 'Polynésie française', 'PYF'),
(80, 'Terres australes et antarctiques françaises', 'ATF'),
(81, 'Gabon', 'GAB'),
(82, 'Gambie', 'GMB'),
(83, 'Géorgie', 'GEO'),
(84, 'Allemagne', 'DEU'),
(85, 'Ghana', 'GHA'),
(86, 'Gibraltar', 'GIB'),
(87, 'Grèce', 'GRC'),
(88, 'Groenland', 'GRL'),
(89, 'Grenade', 'GRD'),
(90, 'Guadeloupe', 'GLP'),
(91, 'Guam', 'GUM'),
(92, 'Guatemala', 'GTM'),
(93, 'Guernesey', 'GGY'),
(94, 'Guinée', 'GIN'),
(95, 'Guinée-Bissau', 'GNB'),
(96, 'Guyane', 'GUY'),
(97, 'Haïti', 'HTI'),
(98, 'Îles Heard-et-MacDonald', 'HMD'),
(99, 'Saint-Siège (Vatican)', 'VAT'),
(100, 'Honduras', 'HND'),
(101, 'Hongrie', 'HUN'),
(102, 'Islande', 'ISL'),
(103, 'Inde', 'IND'),
(104, 'Indonésie', 'IDN'),
(105, 'Iran', 'IRN'),
(106, 'Irak', 'IRQ'),
(107, 'Irlande', 'IRL'),
(108, 'Ile de Man', 'IMN'),
(109, 'Israël', 'ISR'),
(110, 'Italie', 'ITA'),
(111, 'Jamaïque', 'JAM'),
(112, 'Japon', 'JPN'),
(113, 'Jersey', 'JEY'),
(114, 'Jordanie', 'JOR'),
(115, 'Kazakhstan', 'KAZ'),
(116, 'Kenya', 'KEN'),
(117, 'Kiribati', 'KIR'),
(118, 'Corée du Nord', 'PRK'),
(119, 'Corée du Sud', 'KOR'),
(120, 'Koweït', 'KWT'),
(121, 'Kirghizistan', 'KGZ'),
(122, 'Laos', 'LAO'),
(123, 'Lettonie', 'LVA'),
(124, 'Liban', 'LBN'),
(125, 'Lesotho', 'LSO'),
(126, 'Libéria', 'LBR'),
(127, 'Libye', 'LBY'),
(128, 'Liechtenstein', 'LIE'),
(129, 'Lituanie', 'LTU'),
(130, 'Luxembourg', 'LUX'),
(131, 'Macédoine', 'MKD'),
(132, 'Madagascar', 'MDG'),
(133, 'Malawi', 'MWI'),
(134, 'Malaisie', 'MYS'),
(135, 'Maldives', 'MDV'),
(136, 'Mali', 'MLI'),
(137, 'Malte', 'MLT'),
(138, 'Îles Marshall', 'MHL'),
(139, 'Martinique', 'MTQ'),
(140, 'Mauritanie', 'MRT'),
(141, 'Maurice', 'MUS'),
(142, 'Mayotte', 'MYT'),
(143, 'Mexique', 'MEX'),
(144, 'Micronésie', 'FSM'),
(145, 'Moldavie', 'MDA'),
(146, 'Monaco', 'MCO'),
(147, 'Mongolie', 'MNG'),
(148, 'Monténégro', 'MNE'),
(149, 'Montserrat', 'MSR'),
(150, 'Maroc', 'MAR'),
(151, 'Mozambique', 'MOZ'),
(152, 'Myanmar', 'MMR'),
(153, 'Namibie', 'NAM'),
(154, 'Nauru', 'NRU'),
(155, 'Népal', 'NPL'),
(156, 'Pays-Bas', 'NLD'),
(157, 'Nouvelle-Calédonie', 'NCL'),
(158, 'Nouvelle-Zélande', 'NZL'),
(159, 'Nicaragua', 'NIC'),
(160, 'Niger', 'NER'),
(161, 'Nigeria', 'NGA'),
(162, 'Niue', 'NIU'),
(163, 'Île Norfolk', 'NFK'),
(164, 'Îles Mariannes du Nord', 'MNP'),
(165, 'Norvège', 'NOR'),
(166, 'Oman', 'OMN'),
(167, 'Pakistan', 'PAK'),
(168, 'Palau', 'PLW'),
(169, 'Palestine', 'PSE'),
(170, 'Panama', 'PAN'),
(171, 'Papouasie-Nouvelle-Guinée', 'PNG'),
(172, 'Paraguay', 'PRY'),
(173, 'Pérou', 'PER'),
(174, 'Philippines', 'PHL'),
(175, 'Pitcairn', 'PCN'),
(176, 'Pologne', 'POL'),
(177, 'Portugal', 'PRT'),
(178, 'Puerto Rico', 'PRI'),
(179, 'Qatar', 'QAT'),
(180, 'Réunion', 'REU'),
(181, 'Roumanie', 'ROU'),
(182, 'Russie', 'RUS'),
(183, 'Rwanda', 'RWA'),
(184, 'Saint-Barthélemy', 'BLM'),
(185, 'Sainte-Hélène', 'SHN'),
(186, 'Saint-Kitts-et-Nevis', 'KNA'),
(187, 'Sainte-Lucie', 'LCA'),
(188, 'Saint-Martin (partie française)', 'MAF'),
(189, 'Saint-Martin (partie néerlandaise)', 'SXM'),
(190, 'Saint-Pierre-et-Miquelon', 'SPM'),
(191, 'Saint-Vincent-et-les Grenadines', 'VCT'),
(192, 'Samoa', 'WSM'),
(193, 'Saint-Marin', 'SMR'),
(194, 'Sao Tomé-et-Principe', 'STP'),
(195, 'Arabie Saoudite', 'SAU'),
(196, 'Sénégal', 'SEN'),
(197, 'Serbie', 'SRB'),
(198, 'Seychelles', 'SYC'),
(199, 'Sierra Leone', 'SLE'),
(200, 'Singapour', 'SGP'),
(201, 'Slovaquie', 'SVK'),
(202, 'Slovénie', 'SVN'),
(203, 'Îles Salomon', 'SLB'),
(204, 'Somalie', 'SOM'),
(205, 'Afrique du Sud', 'ZAF'),
(206, 'Géorgie du Sud et les îles Sandwich du Sud', 'SGS'),
(207, 'Sud-Soudan', 'SSD'),
(208, 'Espagne', 'ESP'),
(209, 'Sri Lanka', 'LKA'),
(210, 'Soudan', 'SDN'),
(211, 'Suriname', 'SUR'),
(212, 'Svalbard et Jan Mayen', 'SJM'),
(213, 'Eswatini', 'SWZ'),
(214, 'Suède', 'SWE'),
(215, 'Suisse', 'CHE'),
(216, 'Syrie', 'SYR'),
(217, 'Taiwan', 'TWN'),
(218, 'Tadjikistan', 'TJK'),
(219, 'Tanzanie', 'TZA'),
(220, 'Thaïlande', 'THA'),
(221, 'Timor-Leste', 'TLS'),
(222, 'Togo', 'TGO'),
(223, 'Tokelau', 'TKL'),
(224, 'Tonga', 'TON'),
(225, 'Trinité-et-Tobago', 'TTO'),
(226, 'Tunisie', 'TUN'),
(227, 'Turquie', 'TUR'),
(228, 'Turkménistan', 'TKM'),
(229, 'Îles Turques-et-Caïques', 'TCA'),
(230, 'Tuvalu', 'TUV'),
(231, 'Ouganda', 'UGA'),
(232, 'Ukraine', 'UKR'),
(233, 'Émirats Arabes Unis', 'ARE'),
(234, 'Royaume-Uni', 'GBR'),
(235, 'États-Unis', 'USA'),
(236, 'Îles mineures éloignées des États-Unis', 'UMI'),
(237, 'Uruguay', 'URY'),
(238, 'Ouzbékistan', 'UZB'),
(239, 'Vanuatu', 'VUT'),
(240, 'Venezuela', 'VEN'),
(241, 'Viêt Nam', 'VNM'),
(242, 'Îles Vierges américaines', 'VIR'),
(243, 'Wallis-et-Futuna', 'WLF'),
(244, 'Sahara occidental', 'ESH'),
(245, 'Yémen', 'YEM'),
(246, 'Zambie', 'ZMB'),
(247, 'Zimbabwe', 'ZWE');

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230811090751', '2023-08-11 20:46:45', 1686);

-- --------------------------------------------------------

--
-- Structure de la table `enterprises`
--

DROP TABLE IF EXISTS `enterprises`;
CREATE TABLE `enterprises` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `prices`
--

DROP TABLE IF EXISTS `prices`;
CREATE TABLE `prices` (
  `id` int(11) NOT NULL,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- --------------------------------------------------------

--
-- Structure de la table `prices_histories`
--

DROP TABLE IF EXISTS `prices_histories`;
CREATE TABLE `prices_histories` (
  `id` int(11) NOT NULL,
  `price_id` int(11) NOT NULL,
  `begin_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `previous_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reports`
--

DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `text` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reports_history`
--

DROP TABLE IF EXISTS `reports_history`;
CREATE TABLE `reports_history` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `text` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `roles_authorizations`
--

DROP TABLE IF EXISTS `roles_authorizations`;
CREATE TABLE `roles_authorizations` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `authorization_id` int(11) NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `travel`
--

DROP TABLE IF EXISTS `travel`;
CREATE TABLE `travel` (
  `id` int(11) NOT NULL,
  `starting_address` int(11) NOT NULL,
  `arrival_address` int(11) NOT NULL,
  `step_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `address_id` int(11) DEFAULT NULL,
  `last_name` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_status_enum` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6FCA75168BAC62AF` (`city_id`);

--
-- Index pour la table `airports`
--
ALTER TABLE `airports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6E1AFD60B299877A` (`addresse_id`);

--
-- Index pour la table `authorizations`
--
ALTER TABLE `authorizations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `baggage`
--
ALTER TABLE `baggage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_917FF30AB28A0E4A` (`baggage_types`);

--
-- Index pour la table `baggage_types`
--
ALTER TABLE `baggage_types`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E00CEDDE2D0B6BCE` (`travel`),
  ADD KEY `IDX_E00CEDDEC3423909` (`driver_id`),
  ADD KEY `IDX_E00CEDDEA76ED395` (`user_id`);

--
-- Index pour la table `booking_baggage`
--
ALTER TABLE `booking_baggage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_CBC1B62A94FD9EA4` (`baggage_id`),
  ADD KEY `IDX_CBC1B62A3301C60` (`booking_id`);

--
-- Index pour la table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D95DB16BF92F3E70` (`country_id`);

--
-- Index pour la table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `enterprises`
--
ALTER TABLE `enterprises`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `prices`
--
ALTER TABLE `prices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E4CB6D5978CED90B` (`from_id`),
  ADD KEY `IDX_E4CB6D5930354A65` (`to_id`);

--
-- Index pour la table `prices_histories`
--
ALTER TABLE `prices_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_BA637DAAD614C7E7` (`price_id`);

--
-- Index pour la table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F11FA7453301C60` (`booking_id`),
  ADD KEY `IDX_F11FA745A76ED395` (`user_id`);

--
-- Index pour la table `reports_history`
--
ALTER TABLE `reports_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_375779FC4BD2A4C0` (`report_id`);

--
-- Index pour la table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `roles_authorizations`
--
ALTER TABLE `roles_authorizations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_8876B4F9D60322AC` (`role_id`),
  ADD KEY `IDX_8876B4F92F8B0EB2` (`authorization_id`);

--
-- Index pour la table `travel`
--
ALTER TABLE `travel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_2D0B6BCE73B21E9C` (`step_id`),
  ADD KEY `IDX_2D0B6BCEBA92CFEC` (`starting_address`),
  ADD KEY `IDX_2D0B6BCEC685A189` (`arrival_address`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_1483A5E9E7927C74` (`email`),
  ADD KEY `IDX_1483A5E9D60322AC` (`role_id`),
  ADD KEY `IDX_1483A5E9F5B7AF75` (`address_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `airports`
--
ALTER TABLE `airports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `authorizations`
--
ALTER TABLE `authorizations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `baggage`
--
ALTER TABLE `baggage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `baggage_types`
--
ALTER TABLE `baggage_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `booking_baggage`
--
ALTER TABLE `booking_baggage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2789;

--
-- AUTO_INCREMENT pour la table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=248;

--
-- AUTO_INCREMENT pour la table `enterprises`
--
ALTER TABLE `enterprises`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `prices`
--
ALTER TABLE `prices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `prices_histories`
--
ALTER TABLE `prices_histories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reports_history`
--
ALTER TABLE `reports_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `roles_authorizations`
--
ALTER TABLE `roles_authorizations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `travel`
--
ALTER TABLE `travel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `FK_6FCA75168BAC62AF` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`);

--
-- Contraintes pour la table `airports`
--
ALTER TABLE `airports`
  ADD CONSTRAINT `FK_6E1AFD60B299877A` FOREIGN KEY (`addresse_id`) REFERENCES `addresses` (`id`);

--
-- Contraintes pour la table `baggage`
--
ALTER TABLE `baggage`
  ADD CONSTRAINT `FK_917FF30AB28A0E4A` FOREIGN KEY (`baggage_types`) REFERENCES `baggage_types` (`id`);

--
-- Contraintes pour la table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `FK_E00CEDDE2D0B6BCE` FOREIGN KEY (`travel`) REFERENCES `travel` (`id`),
  ADD CONSTRAINT `FK_E00CEDDEA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FK_E00CEDDEC3423909` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `booking_baggage`
--
ALTER TABLE `booking_baggage`
  ADD CONSTRAINT `FK_CBC1B62A3301C60` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`),
  ADD CONSTRAINT `FK_CBC1B62A94FD9EA4` FOREIGN KEY (`baggage_id`) REFERENCES `baggage` (`id`);

--
-- Contraintes pour la table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `FK_D95DB16BF92F3E70` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`);

--
-- Contraintes pour la table `prices`
--
ALTER TABLE `prices`
  ADD CONSTRAINT `FK_E4CB6D5930354A65` FOREIGN KEY (`to_id`) REFERENCES `cities` (`id`),
  ADD CONSTRAINT `FK_E4CB6D5978CED90B` FOREIGN KEY (`from_id`) REFERENCES `cities` (`id`);

--
-- Contraintes pour la table `prices_histories`
--
ALTER TABLE `prices_histories`
  ADD CONSTRAINT `FK_BA637DAAD614C7E7` FOREIGN KEY (`price_id`) REFERENCES `prices` (`id`);

--
-- Contraintes pour la table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `FK_F11FA7453301C60` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`),
  ADD CONSTRAINT `FK_F11FA745A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `reports_history`
--
ALTER TABLE `reports_history`
  ADD CONSTRAINT `FK_375779FC4BD2A4C0` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`);

--
-- Contraintes pour la table `roles_authorizations`
--
ALTER TABLE `roles_authorizations`
  ADD CONSTRAINT `FK_8876B4F92F8B0EB2` FOREIGN KEY (`authorization_id`) REFERENCES `authorizations` (`id`),
  ADD CONSTRAINT `FK_8876B4F9D60322AC` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Contraintes pour la table `travel`
--
ALTER TABLE `travel`
  ADD CONSTRAINT `FK_2D0B6BCE73B21E9C` FOREIGN KEY (`step_id`) REFERENCES `travel` (`id`),
  ADD CONSTRAINT `FK_2D0B6BCEBA92CFEC` FOREIGN KEY (`starting_address`) REFERENCES `addresses` (`id`),
  ADD CONSTRAINT `FK_2D0B6BCEC685A189` FOREIGN KEY (`arrival_address`) REFERENCES `addresses` (`id`);

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_1483A5E9D60322AC` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `FK_1483A5E9F5B7AF75` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WAVRE')),(select id from cities where LOWER(label) = 'zaventem'),85 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bierges')),(select id from cities where LOWER(label) = 'zaventem'),88 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LA HULPE')),(select id from cities where LOWER(label) = 'zaventem'),86 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('INCOURT')),(select id from cities where LOWER(label) = 'zaventem'),99 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BEAUVECHAIN')),(select id from cities where LOWER(label) = 'zaventem'),97 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHAUMONT-GISTOUX')),(select id from cities where LOWER(label) = 'zaventem'),94 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('RIXENSART')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Rosières')),(select id from cities where LOWER(label) = 'zaventem'),86 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Genval')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('OTTIGNIES-LOUVAIN-LA-NEUVE')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Céroux-Mousty')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Limelette')),(select id from cities where LOWER(label) = 'zaventem'),87 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Louvain-La-Neuve')),(select id from cities where LOWER(label) = 'zaventem'),85 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ORP-JAUCHE')),(select id from cities where LOWER(label) = 'zaventem'),101);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HÉLÉCINE')),(select id from cities where LOWER(label) = 'zaventem'),104);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PERWEZ')),(select id from cities where LOWER(label) = 'zaventem'),95 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('RAMILLIES')),(select id from cities where LOWER(label) = 'zaventem'),102);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('JODOIGNE')),(select id from cities where LOWER(label) = 'zaventem'),101);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LASNE')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GREZ-DOICEAU')),(select id from cities where LOWER(label) = 'zaventem'),90 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('NIVELLES')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Baulers')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thines')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bornival')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WATERLOO')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BRAINE-L\'ALLEUD')),(select id from cities where LOWER(label) = 'zaventem'),84);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ophain-Bois-Seigneur-Isaac')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lillois-Witterzée')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('REBECQ')),(select id from cities where LOWER(label) = 'zaventem'),101);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MONT-SAINT-GUIBERT')),(select id from cities where LOWER(label) = 'zaventem'),87 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BRAINE-LE-CHÂTEAU')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHASTRE')),(select id from cities where LOWER(label) = 'zaventem'),88 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WALHAIN')),(select id from cities where LOWER(label) = 'zaventem'),89 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ITTRE')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Haut-Ittre')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GENAPPE')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Loupoigne')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Vieux-Genappe')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Glabais')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ways')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Houtain-Le-Val')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TUBIZE')),(select id from cities where LOWER(label) = 'zaventem'),94 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('COURT-SAINT-ETIENNE')),(select id from cities where LOWER(label) = 'zaventem'),87 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VILLERS-LA-VILLE')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values (1795,(select id from cities where LOWER(label) = 'zaventem'),128);
insert into prices (from_id,to_id,price) values (1797,(select id from cities where LOWER(label) = 'zaventem'),144);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Grivegnée')),(select id from cities where LOWER(label) = 'zaventem'),138);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Angleur')),(select id from cities where LOWER(label) = 'zaventem'),140);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Chênée')),(select id from cities where LOWER(label) = 'zaventem'),141);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HERSTAL')),(select id from cities where LOWER(label) = 'zaventem'),138);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Milmort')),(select id from cities where LOWER(label) = 'zaventem'),129);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Liers')),(select id from cities where LOWER(label) = 'zaventem'),128);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHAUDFONTAINE')),(select id from cities where LOWER(label) = 'zaventem'),151);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Vaux-Sous-Chèvremont')),(select id from cities where LOWER(label) = 'zaventem'),144);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Beaufays')),(select id from cities where LOWER(label) = 'zaventem'),149);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Embourg')),(select id from cities where LOWER(label) = 'zaventem'),142);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SERAING')),(select id from cities where LOWER(label) = 'zaventem'),137);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Jemeppe-Sur-Meuse')),(select id from cities where LOWER(label) = 'zaventem'),124);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ougrée')),(select id from cities where LOWER(label) = 'zaventem'),136);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('NEUPRÉ')),(select id from cities where LOWER(label) = 'zaventem'),143);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Neuville-En-Condroz')),(select id from cities where LOWER(label) = 'zaventem'),140);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Plainevaux')),(select id from cities where LOWER(label) = 'zaventem'),144);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ESNEUX')),(select id from cities where LOWER(label) = 'zaventem'),156);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SPRIMONT')),(select id from cities where LOWER(label) = 'zaventem'),160);
insert into prices (from_id,to_id,price) values (1827,(select id from cities where LOWER(label) = 'zaventem'),161);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ANTHISNES')),(select id from cities where LOWER(label) = 'zaventem'),156);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Villers-Aux-Tours')),(select id from cities where LOWER(label) = 'zaventem'),155);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hody')),(select id from cities where LOWER(label) = 'zaventem'),153);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Tavier')),(select id from cities where LOWER(label) = 'zaventem'),152);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('COMBLAIN-AU-PONT')),(select id from cities where LOWER(label) = 'zaventem'),172);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Poulseur')),(select id from cities where LOWER(label) = 'zaventem'),158);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HAMOIR')),(select id from cities where LOWER(label) = 'zaventem'),169);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Filot')),(select id from cities where LOWER(label) = 'zaventem'),170);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FERRIÈRES')),(select id from cities where LOWER(label) = 'zaventem'),185);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BURDINNE')),(select id from cities where LOWER(label) = 'zaventem'),105);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HÉRON')),(select id from cities where LOWER(label) = 'zaventem'),106);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Couthuin')),(select id from cities where LOWER(label) = 'zaventem'),108);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WASSEIGES')),(select id from cities where LOWER(label) = 'zaventem'),108);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GEER')),(select id from cities where LOWER(label) = 'zaventem'),109);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Omal')),(select id from cities where LOWER(label) = 'zaventem'),111);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Darion')),(select id from cities where LOWER(label) = 'zaventem'),110);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ligney')),(select id from cities where LOWER(label) = 'zaventem'),110);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BERLOZ')),(select id from cities where LOWER(label) = 'zaventem'),112);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BRAIVES')),(select id from cities where LOWER(label) = 'zaventem'),106);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Latinne')),(select id from cities where LOWER(label) = 'zaventem'),109);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Tourinne')),(select id from cities where LOWER(label) = 'zaventem'),109);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HANNUT')),(select id from cities where LOWER(label) = 'zaventem'),103);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LINCENT')),(select id from cities where LOWER(label) = 'zaventem'),103);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WAREMME')),(select id from cities where LOWER(label) = 'zaventem'),115);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FAIMES')),(select id from cities where LOWER(label) = 'zaventem'),112);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('AWANS')),(select id from cities where LOWER(label) = 'zaventem'),123);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hognoul')),(select id from cities where LOWER(label) = 'zaventem'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FEXHE-LE-HAUT-CLOCHER')),(select id from cities where LOWER(label) = 'zaventem'),119);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('REMICOURT')),(select id from cities where LOWER(label) = 'zaventem'),117);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hodeige')),(select id from cities where LOWER(label) = 'zaventem'),118);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DONCEEL')),(select id from cities where LOWER(label) = 'zaventem'),116);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('OREYE')),(select id from cities where LOWER(label) = 'zaventem'),120);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CRISNÉE')),(select id from cities where LOWER(label) = 'zaventem'),120);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FLÉMALLE')),(select id from cities where LOWER(label) = 'zaventem'),123);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SAINT-NICOLAS')),(select id from cities where LOWER(label) = 'zaventem'),126);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ANS')),(select id from cities where LOWER(label) = 'zaventem'),125);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Loncin')),(select id from cities where LOWER(label) = 'zaventem'),123);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Alleur')),(select id from cities where LOWER(label) = 'zaventem'),124);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('JUPRELLE')),(select id from cities where LOWER(label) = 'zaventem'),129);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Voroux-Lez-Liers')),(select id from cities where LOWER(label) = 'zaventem'),129);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wihogne')),(select id from cities where LOWER(label) = 'zaventem'),139);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Villers-Saint-Siméon')),(select id from cities where LOWER(label) = 'zaventem'),136);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Fexhe-Slins')),(select id from cities where LOWER(label) = 'zaventem'),138);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GRÂCE-HOLLOGNE')),(select id from cities where LOWER(label) = 'zaventem'),120);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SAINT-GEORGES-SUR-MEUSE')),(select id from cities where LOWER(label) = 'zaventem'),120);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ENGIS')),(select id from cities where LOWER(label) = 'zaventem'),140);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HUY')),(select id from cities where LOWER(label) = 'zaventem'),114);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WANZE')),(select id from cities where LOWER(label) = 'zaventem'),112);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VILLERS-LE-BOUILLET')),(select id from cities where LOWER(label) = 'zaventem'),112);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VERLAINE')),(select id from cities where LOWER(label) = 'zaventem'),114);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('AMAY')),(select id from cities where LOWER(label) = 'zaventem'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('NANDRIN')),(select id from cities where LOWER(label) = 'zaventem'),137);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TINLOT')),(select id from cities where LOWER(label) = 'zaventem'),137);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CLAVIER')),(select id from cities where LOWER(label) = 'zaventem'),146);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MARCHIN')),(select id from cities where LOWER(label) = 'zaventem'),123);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MODAVE')),(select id from cities where LOWER(label) = 'zaventem'),134);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('OUFFET')),(select id from cities where LOWER(label) = 'zaventem'),151);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VISÉ')),(select id from cities where LOWER(label) = 'zaventem'),147);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Argenteau')),(select id from cities where LOWER(label) = 'zaventem'),142);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Cheratte')),(select id from cities where LOWER(label) = 'zaventem'),141);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-André')),(select id from cities where LOWER(label) = 'zaventem'),157);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DALHEM')),(select id from cities where LOWER(label) = 'zaventem'),149);
insert into prices (from_id,to_id,price) values (2032,(select id from cities where LOWER(label) = 'zaventem'),161);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BEYNE-HEUSAY')),(select id from cities where LOWER(label) = 'zaventem'),153);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FLÉRON')),(select id from cities where LOWER(label) = 'zaventem'),155);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Retinne')),(select id from cities where LOWER(label) = 'zaventem'),146);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Magnée')),(select id from cities where LOWER(label) = 'zaventem'),157);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Romsée')),(select id from cities where LOWER(label) = 'zaventem'),154);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SOUMAGNE')),(select id from cities where LOWER(label) = 'zaventem'),156);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Evegnée')),(select id from cities where LOWER(label) = 'zaventem'),144);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Cérexhe-Heuseux')),(select id from cities where LOWER(label) = 'zaventem'),145);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Melen')),(select id from cities where LOWER(label) = 'zaventem'),147);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HERVE')),(select id from cities where LOWER(label) = 'zaventem'),150);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Battice')),(select id from cities where LOWER(label) = 'zaventem'),150);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Xhendelesse')),(select id from cities where LOWER(label) = 'zaventem'),158);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bolland')),(select id from cities where LOWER(label) = 'zaventem'),147);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Charneux')),(select id from cities where LOWER(label) = 'zaventem'),160);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BLÉGNY')),(select id from cities where LOWER(label) = 'zaventem'),145);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Barchon')),(select id from cities where LOWER(label) = 'zaventem'),141);
insert into prices (from_id,to_id,price) values (1402,(select id from cities where LOWER(label) = 'zaventem'),147);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('OUPEYE')),(select id from cities where LOWER(label) = 'zaventem'),139);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hermalle-Sous-Argenteau')),(select id from cities where LOWER(label) = 'zaventem'),141);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Houtain-Saint-Siméon')),(select id from cities where LOWER(label) = 'zaventem'),142);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Vivegnis')),(select id from cities where LOWER(label) = 'zaventem'),139);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Haccourt')),(select id from cities where LOWER(label) = 'zaventem'),147);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BASSENGE')),(select id from cities where LOWER(label) = 'zaventem'),143);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('EUPEN')),(select id from cities where LOWER(label) = 'zaventem'),187);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Kettenis')),(select id from cities where LOWER(label) = 'zaventem'),181);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LONTZEN')),(select id from cities where LOWER(label) = 'zaventem'),180);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Walhorn')),(select id from cities where LOWER(label) = 'zaventem'),181);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LA CALAMINE')),(select id from cities where LOWER(label) = 'zaventem'),183);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Neu-Moresnet')),(select id from cities where LOWER(label) = 'zaventem'),184);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hergenrath')),(select id from cities where LOWER(label) = 'zaventem'),184);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('RAEREN')),(select id from cities where LOWER(label) = 'zaventem'),199);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Eynatten')),(select id from cities where LOWER(label) = 'zaventem'),185);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BUTGENBACH')),(select id from cities where LOWER(label) = 'zaventem'),222);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BULLANGE')),(select id from cities where LOWER(label) = 'zaventem'),243);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Rocherath')),(select id from cities where LOWER(label) = 'zaventem'),239);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('AMBLÈVE')),(select id from cities where LOWER(label) = 'zaventem'),219);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Heppenbach')),(select id from cities where LOWER(label) = 'zaventem'),231);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SAINT-VITH')),(select id from cities where LOWER(label) = 'zaventem'),224);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Schoenberg')),(select id from cities where LOWER(label) = 'zaventem'),238);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lommersweiler')),(select id from cities where LOWER(label) = 'zaventem'),225);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Crombach')),(select id from cities where LOWER(label) = 'zaventem'),223);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BURG-REULAND')),(select id from cities where LOWER(label) = 'zaventem'),237);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thommen')),(select id from cities where LOWER(label) = 'zaventem'),230);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VERVIERS')),(select id from cities where LOWER(label) = 'zaventem'),164);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Stembert')),(select id from cities where LOWER(label) = 'zaventem'),176);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Heusy')),(select id from cities where LOWER(label) = 'zaventem'),165);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DISON')),(select id from cities where LOWER(label) = 'zaventem'),160);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Andrimont')),(select id from cities where LOWER(label) = 'zaventem'),165);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LIMBOURG')),(select id from cities where LOWER(label) = 'zaventem'),180);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bilstain')),(select id from cities where LOWER(label) = 'zaventem'),163);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Goé')),(select id from cities where LOWER(label) = 'zaventem'),181);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BAELEN')),(select id from cities where LOWER(label) = 'zaventem'),187);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WELKENRAEDT')),(select id from cities where LOWER(label) = 'zaventem'),169);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Henri-Chapelle')),(select id from cities where LOWER(label) = 'zaventem'),165);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('JALHAY')),(select id from cities where LOWER(label) = 'zaventem'),189);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PLOMBIÈRES')),(select id from cities where LOWER(label) = 'zaventem'),181);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gemmenich')),(select id from cities where LOWER(label) = 'zaventem'),189);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sippenaeken')),(select id from cities where LOWER(label) = 'zaventem'),189);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hombourg')),(select id from cities where LOWER(label) = 'zaventem'),179);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PEPINSTER')),(select id from cities where LOWER(label) = 'zaventem'),177);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Soiron')),(select id from cities where LOWER(label) = 'zaventem'),160);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TROOZ')),(select id from cities where LOWER(label) = 'zaventem'),159);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('OLNE')),(select id from cities where LOWER(label) = 'zaventem'),161);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('AUBEL')),(select id from cities where LOWER(label) = 'zaventem'),166);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('THIMISTER-CLERMONT')),(select id from cities where LOWER(label) = 'zaventem'),163);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SPA')),(select id from cities where LOWER(label) = 'zaventem'),189);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('THEUX')),(select id from cities where LOWER(label) = 'zaventem'),183);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('AYWAILLE')),(select id from cities where LOWER(label) = 'zaventem'),168);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WAIMES')),(select id from cities where LOWER(label) = 'zaventem'),212);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MALMEDY')),(select id from cities where LOWER(label) = 'zaventem'),204);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('STAVELOT')),(select id from cities where LOWER(label) = 'zaventem'),205);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TROIS-PONTS')),(select id from cities where LOWER(label) = 'zaventem'),215);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Basse-Bodeux')),(select id from cities where LOWER(label) = 'zaventem'),200);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('STOUMONT')),(select id from cities where LOWER(label) = 'zaventem'),198);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LIERNEUX')),(select id from cities where LOWER(label) = 'zaventem'),206);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('NAMUR')),(select id from cities where LOWER(label) = 'zaventem'),99 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Belgrade')),(select id from cities where LOWER(label) = 'zaventem'),93 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-Servais')),(select id from cities where LOWER(label) = 'zaventem'),95 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-Marc')),(select id from cities where LOWER(label) = 'zaventem'),93 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bouge')),(select id from cities where LOWER(label) = 'zaventem'),95 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Champion')),(select id from cities where LOWER(label) = 'zaventem'),92 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Boninne')),(select id from cities where LOWER(label) = 'zaventem'),97 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Cognelée')),(select id from cities where LOWER(label) = 'zaventem'),94 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gelbressée')),(select id from cities where LOWER(label) = 'zaventem'),100);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GEMBLOUX')),(select id from cities where LOWER(label) = 'zaventem'),86 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Grand-Leez')),(select id from cities where LOWER(label) = 'zaventem'),90 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Corroy-Le-Château')),(select id from cities where LOWER(label) = 'zaventem'),88 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SAMBREVILLE')),(select id from cities where LOWER(label) = 'zaventem'),89 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FOSSES-LA-VILLE')),(select id from cities where LOWER(label) = 'zaventem'),98 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LA BRUYÈRE')),(select id from cities where LOWER(label) = 'zaventem'),90 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Meux')),(select id from cities where LOWER(label) = 'zaventem'),89 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Jambes')),(select id from cities where LOWER(label) = 'zaventem'),101);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Erpent')),(select id from cities where LOWER(label) = 'zaventem'),97 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SOMBREFFE')),(select id from cities where LOWER(label) = 'zaventem'),87 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FLOREFFE')),(select id from cities where LOWER(label) = 'zaventem'),93 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PROFONDEVILLE')),(select id from cities where LOWER(label) = 'zaventem'),100);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('JEMEPPE-SUR-SAMBRE')),(select id from cities where LOWER(label) = 'zaventem'),91 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ANDENNE')),(select id from cities where LOWER(label) = 'zaventem'),111);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('EGHEZÉE')),(select id from cities where LOWER(label) = 'zaventem'),97 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ASSESSE')),(select id from cities where LOWER(label) = 'zaventem'),108);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Crupet')),(select id from cities where LOWER(label) = 'zaventem'),110);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sorinne-La-Longue')),(select id from cities where LOWER(label) = 'zaventem'),107);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Florée')),(select id from cities where LOWER(label) = 'zaventem'),111);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Courrière')),(select id from cities where LOWER(label) = 'zaventem'),105);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GESVES')),(select id from cities where LOWER(label) = 'zaventem'),110);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('OHEY')),(select id from cities where LOWER(label) = 'zaventem'),122);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Haillot')),(select id from cities where LOWER(label) = 'zaventem'),118);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Perwez-Haillot')),(select id from cities where LOWER(label) = 'zaventem'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Goesnes')),(select id from cities where LOWER(label) = 'zaventem'),125);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Jallet')),(select id from cities where LOWER(label) = 'zaventem'),125);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HAMOIS')),(select id from cities where LOWER(label) = 'zaventem'),116);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Mohiville')),(select id from cities where LOWER(label) = 'zaventem'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Scy')),(select id from cities where LOWER(label) = 'zaventem'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Achet')),(select id from cities where LOWER(label) = 'zaventem'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Emptinne')),(select id from cities where LOWER(label) = 'zaventem'),114);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Schaltin')),(select id from cities where LOWER(label) = 'zaventem'),117);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HAVELANGE')),(select id from cities where LOWER(label) = 'zaventem'),126);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Méan')),(select id from cities where LOWER(label) = 'zaventem'),156);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Maffe')),(select id from cities where LOWER(label) = 'zaventem'),138);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Miécret')),(select id from cities where LOWER(label) = 'zaventem'),128);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SOMME-LEUZE')),(select id from cities where LOWER(label) = 'zaventem'),138);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FERNELMONT')),(select id from cities where LOWER(label) = 'zaventem'),98 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DINANT')),(select id from cities where LOWER(label) = 'zaventem'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lisogne')),(select id from cities where LOWER(label) = 'zaventem'),119);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thynes')),(select id from cities where LOWER(label) = 'zaventem'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sorinnes')),(select id from cities where LOWER(label) = 'zaventem'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Foy-Notre-Dame')),(select id from cities where LOWER(label) = 'zaventem'),116);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ONHAYE')),(select id from cities where LOWER(label) = 'zaventem'),115);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Serville')),(select id from cities where LOWER(label) = 'zaventem'),119);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Falaën')),(select id from cities where LOWER(label) = 'zaventem'),116);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sommière')),(select id from cities where LOWER(label) = 'zaventem'),118);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gérin')),(select id from cities where LOWER(label) = 'zaventem'),115);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('YVOIR')),(select id from cities where LOWER(label) = 'zaventem'),117);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ANHÉE')),(select id from cities where LOWER(label) = 'zaventem'),107);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HASTIÈRE')),(select id from cities where LOWER(label) = 'zaventem'),122);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hastière-Par-Delà')),(select id from cities where LOWER(label) = 'zaventem'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Blaimont')),(select id from cities where LOWER(label) = 'zaventem'),130);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Heer')),(select id from cities where LOWER(label) = 'zaventem'),129);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Agimont')),(select id from cities where LOWER(label) = 'zaventem'),123);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VRESSE-SUR-SEMOIS')),(select id from cities where LOWER(label) = 'zaventem'),193);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BIÈVRE')),(select id from cities where LOWER(label) = 'zaventem'),168);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HOUYET')),(select id from cities where LOWER(label) = 'zaventem'),133);
insert into prices (from_id,to_id,price) values (2638,(select id from cities where LOWER(label) = 'zaventem'),122);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Custinne')),(select id from cities where LOWER(label) = 'zaventem'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hour')),(select id from cities where LOWER(label) = 'zaventem'),130);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wanlin')),(select id from cities where LOWER(label) = 'zaventem'),139);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BEAURAING')),(select id from cities where LOWER(label) = 'zaventem'),134);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wiesme')),(select id from cities where LOWER(label) = 'zaventem'),135);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Focant')),(select id from cities where LOWER(label) = 'zaventem'),135);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Martouzin-Neuville')),(select id from cities where LOWER(label) = 'zaventem'),134);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Pondrôme')),(select id from cities where LOWER(label) = 'zaventem'),136);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GEDINNE')),(select id from cities where LOWER(label) = 'zaventem'),158);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Froidfontaine')),(select id from cities where LOWER(label) = 'zaventem'),140);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ROCHEFORT')),(select id from cities where LOWER(label) = 'zaventem'),141);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Jemelle')),(select id from cities where LOWER(label) = 'zaventem'),147);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CINEY')),(select id from cities where LOWER(label) = 'zaventem'),125);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PHILIPPEVILLE')),(select id from cities where LOWER(label) = 'zaventem'),114);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FLORENNES')),(select id from cities where LOWER(label) = 'zaventem'),112);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thy-Le-Baudouin')),(select id from cities where LOWER(label) = 'zaventem'),98 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CERFONTAINE')),(select id from cities where LOWER(label) = 'zaventem'),115);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('METTET')),(select id from cities where LOWER(label) = 'zaventem'),102);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Furnaux')),(select id from cities where LOWER(label) = 'zaventem'),106);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ermeton-Sur-Biert')),(select id from cities where LOWER(label) = 'zaventem'),107);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Stave')),(select id from cities where LOWER(label) = 'zaventem'),106);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WALCOURT')),(select id from cities where LOWER(label) = 'zaventem'),100);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thy-Le-Château')),(select id from cities where LOWER(label) = 'zaventem'),97 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('COUVIN')),(select id from cities where LOWER(label) = 'zaventem'),122);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VIROINVAL')),(select id from cities where LOWER(label) = 'zaventem'),132);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DOISCHE')),(select id from cities where LOWER(label) = 'zaventem'),122);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHARLEROI')),(select id from cities where LOWER(label) = 'zaventem'),84);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Marcinelle')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Couillet')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Dampremy')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Marchienne-Au-Pont')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Monceau-Sur-Sambre')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Mont-Sur-Marchienne')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Jumet')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gosselies')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lodelinsart')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ransart')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Roux')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gilly')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Montignies-Sur-Sambre')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MONTIGNY-LE-TILLEUL')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Landelies')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HAM-SUR-HEURE')),(select id from cities where LOWER(label) = 'zaventem'),87 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FONTAINE-L\'EVÊQUE')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Forchies-La-Marche')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Leernes')),(select id from cities where LOWER(label) = 'zaventem'),87 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ANDERLUES')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('COURCELLES')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gouy-Lez-Piéton')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Souvret')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Trazegnies')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHÂTELET')),(select id from cities where LOWER(label) = 'zaventem'),85 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LES BONS VILLERS')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Mellet')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FLEURUS')),(select id from cities where LOWER(label) = 'zaventem'),88 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-Amand')),(select id from cities where LOWER(label) = 'zaventem'),86 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Brye')),(select id from cities where LOWER(label) = 'zaventem'),86 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wagnelée')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wanfercée-Baulet')),(select id from cities where LOWER(label) = 'zaventem'),88 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PONT-À-CELLES')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Luttre')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FARCIENNES')),(select id from cities where LOWER(label) = 'zaventem'),86 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('AISEAU-PRESLES')),(select id from cities where LOWER(label) = 'zaventem'),90) ;
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GERPINNES')),(select id from cities where LOWER(label) = 'zaventem'),89 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FROIDCHAPELLE')),(select id from cities where LOWER(label) = 'zaventem'),117);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Erpion')),(select id from cities where LOWER(label) = 'zaventem'),111);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHIMAY')),(select id from cities where LOWER(label) = 'zaventem'),133);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Virelles')),(select id from cities where LOWER(label) = 'zaventem'),130);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Vaulx-Lez-Chimay')),(select id from cities where LOWER(label) = 'zaventem'),131);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lompret')),(select id from cities where LOWER(label) = 'zaventem'),130);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Baileux')),(select id from cities where LOWER(label) = 'zaventem'),148);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SIVRY-RANCE')),(select id from cities where LOWER(label) = 'zaventem'),112);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BEAUMONT')),(select id from cities where LOWER(label) = 'zaventem'),104);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Strée')),(select id from cities where LOWER(label) = 'zaventem'),98 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('THUIN')),(select id from cities where LOWER(label) = 'zaventem'),91 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Biesme-Sous-Thuin')),(select id from cities where LOWER(label) = 'zaventem'),95 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ragnies')),(select id from cities where LOWER(label) = 'zaventem'),94 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Biercée')),(select id from cities where LOWER(label) = 'zaventem'),91 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gozée')),(select id from cities where LOWER(label) = 'zaventem'),88 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thuillies')),(select id from cities where LOWER(label) = 'zaventem'),94 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LOBBES')),(select id from cities where LOWER(label) = 'zaventem'),86 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sars-La-Buissière')),(select id from cities where LOWER(label) = 'zaventem'),96 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bienne-Lez-Happart')),(select id from cities where LOWER(label) = 'zaventem'),93 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ERQUELINNES')),(select id from cities where LOWER(label) = 'zaventem'),103);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MERBES-LE-CHÂTEAU')),(select id from cities where LOWER(label) = 'zaventem'),100);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MOMIGNIES')),(select id from cities where LOWER(label) = 'zaventem'),147);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Macon')),(select id from cities where LOWER(label) = 'zaventem'),141);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Monceau-Imbrechies')),(select id from cities where LOWER(label) = 'zaventem'),142);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Macquenoise')),(select id from cities where LOWER(label) = 'zaventem'),150);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Beauwelz')),(select id from cities where LOWER(label) = 'zaventem'),149);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Seloignes')),(select id from cities where LOWER(label) = 'zaventem'),147);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BASTOGNE')),(select id from cities where LOWER(label) = 'zaventem'),207);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MARTELANGE')),(select id from cities where LOWER(label) = 'zaventem'),220);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FAUVILLERS')),(select id from cities where LOWER(label) = 'zaventem'),214);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VAUX-SUR-SÛRE')),(select id from cities where LOWER(label) = 'zaventem'),211);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Juseret')),(select id from cities where LOWER(label) = 'zaventem'),204);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HOUFFALIZE')),(select id from cities where LOWER(label) = 'zaventem'),197);
insert into prices (from_id,to_id,price) values (2187,(select id from cities where LOWER(label) = 'zaventem'),213);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Tavigny')),(select id from cities where LOWER(label) = 'zaventem'),218);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Mabompré')),(select id from cities where LOWER(label) = 'zaventem'),203);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wibrin')),(select id from cities where LOWER(label) = 'zaventem'),201);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GOUVY')),(select id from cities where LOWER(label) = 'zaventem'),227);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bovigny')),(select id from cities where LOWER(label) = 'zaventem'),227);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Beho')),(select id from cities where LOWER(label) = 'zaventem'),236);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Cherain')),(select id from cities where LOWER(label) = 'zaventem'),219);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Montleban')),(select id from cities where LOWER(label) = 'zaventem'),219);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SAINTE-ODE')),(select id from cities where LOWER(label) = 'zaventem'),184);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lavacherie')),(select id from cities where LOWER(label) = 'zaventem'),184);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Flamierge')),(select id from cities where LOWER(label) = 'zaventem'),181);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BERTOGNE')),(select id from cities where LOWER(label) = 'zaventem'),198);
insert into prices (from_id,to_id,price) values (2203,(select id from cities where LOWER(label) = 'zaventem'),200);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VIELSALM')),(select id from cities where LOWER(label) = 'zaventem'),221);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Petit-Thier')),(select id from cities where LOWER(label) = 'zaventem'),223);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Grand-Halleux')),(select id from cities where LOWER(label) = 'zaventem'),219);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ARLON')),(select id from cities where LOWER(label) = 'zaventem'),236);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Guirsch')),(select id from cities where LOWER(label) = 'zaventem'),243);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Autelbas')),(select id from cities where LOWER(label) = 'zaventem'),243);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ATTERT')),(select id from cities where LOWER(label) = 'zaventem'),235);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HABAY')),(select id from cities where LOWER(label) = 'zaventem'),223);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Anlier')),(select id from cities where LOWER(label) = 'zaventem'),217);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Habay-La-Vieille')),(select id from cities where LOWER(label) = 'zaventem'),220);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Rulles')),(select id from cities where LOWER(label) = 'zaventem'),216);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TINTIGNY')),(select id from cities where LOWER(label) = 'zaventem'),225);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ETALLE')),(select id from cities where LOWER(label) = 'zaventem'),224);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Vance')),(select id from cities where LOWER(label) = 'zaventem'),228);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Chantemelle')),(select id from cities where LOWER(label) = 'zaventem'),231);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Buzenol')),(select id from cities where LOWER(label) = 'zaventem'),230);
insert into prices (from_id,to_id,price) values (2238,(select id from cities where LOWER(label) = 'zaventem'),239);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MUSSON')),(select id from cities where LOWER(label) = 'zaventem'),252);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VIRTON')),(select id from cities where LOWER(label) = 'zaventem'),239);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Latour')),(select id from cities where LOWER(label) = 'zaventem'),245);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-Mard')),(select id from cities where LOWER(label) = 'zaventem'),244);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ROUVROY')),(select id from cities where LOWER(label) = 'zaventem'),244);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MEIX-DEVANT-VIRTON')),(select id from cities where LOWER(label) = 'zaventem'),241);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MESSANCY')),(select id from cities where LOWER(label) = 'zaventem'),241);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sélange')),(select id from cities where LOWER(label) = 'zaventem'),243);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Habergy')),(select id from cities where LOWER(label) = 'zaventem'),239);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('AUBANGE')),(select id from cities where LOWER(label) = 'zaventem'),249);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Athus')),(select id from cities where LOWER(label) = 'zaventem'),251);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Rachecourt')),(select id from cities where LOWER(label) = 'zaventem'),248);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LIBRAMONT-CHEVIGNY')),(select id from cities where LOWER(label) = 'zaventem'),192);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHINY')),(select id from cities where LOWER(label) = 'zaventem'),221);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Les Bulles')),(select id from cities where LOWER(label) = 'zaventem'),219);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Suxy')),(select id from cities where LOWER(label) = 'zaventem'),214);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Termes')),(select id from cities where LOWER(label) = 'zaventem'),222);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FLORENVILLE')),(select id from cities where LOWER(label) = 'zaventem'),216);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lacuisine')),(select id from cities where LOWER(label) = 'zaventem'),219);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Villers-Devant-Orval')),(select id from cities where LOWER(label) = 'zaventem'),236);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Chassepierre')),(select id from cities where LOWER(label) = 'zaventem'),218);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BOUILLON')),(select id from cities where LOWER(label) = 'zaventem'),204);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Noirfontaine')),(select id from cities where LOWER(label) = 'zaventem'),192);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sensenruth')),(select id from cities where LOWER(label) = 'zaventem'),189);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ucimont')),(select id from cities where LOWER(label) = 'zaventem'),181);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bellevaux')),(select id from cities where LOWER(label) = 'zaventem'),189);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Dohan')),(select id from cities where LOWER(label) = 'zaventem'),197);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Corbion')),(select id from cities where LOWER(label) = 'zaventem'),203);
insert into prices (from_id,to_id,price) values (2304,(select id from cities where LOWER(label) = 'zaventem'),192);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PALISEUL')),(select id from cities where LOWER(label) = 'zaventem'),174);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Nollevaux')),(select id from cities where LOWER(label) = 'zaventem'),184);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Opont')),(select id from cities where LOWER(label) = 'zaventem'),178);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Framont')),(select id from cities where LOWER(label) = 'zaventem'),177);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Fays-Les-Veneurs')),(select id from cities where LOWER(label) = 'zaventem'),191);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LÉGLISE')),(select id from cities where LOWER(label) = 'zaventem'),208);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SAINT-HUBERT')),(select id from cities where LOWER(label) = 'zaventem'),179);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BERTRIX')),(select id from cities where LOWER(label) = 'zaventem'),192);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HERBEUMONT')),(select id from cities where LOWER(label) = 'zaventem'),205);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LIBIN')),(select id from cities where LOWER(label) = 'zaventem'),164);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MARCHE-EN-FAMENNE')),(select id from cities where LOWER(label) = 'zaventem'),138);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WELLIN')),(select id from cities where LOWER(label) = 'zaventem'),147);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Chanly')),(select id from cities where LOWER(label) = 'zaventem'),154);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Halma')),(select id from cities where LOWER(label) = 'zaventem'),144);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lomprez')),(select id from cities where LOWER(label) = 'zaventem'),147);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TELLIN')),(select id from cities where LOWER(label) = 'zaventem'),157);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DAVERDISSE')),(select id from cities where LOWER(label) = 'zaventem'),163);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DURBUY')),(select id from cities where LOWER(label) = 'zaventem'),154);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Villers-Sainte-Gertrude')),(select id from cities where LOWER(label) = 'zaventem'),174);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('NASSOGNE')),(select id from cities where LOWER(label) = 'zaventem'),163);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bande')),(select id from cities where LOWER(label) = 'zaventem'),148);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Grune')),(select id from cities where LOWER(label) = 'zaventem'),147);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Forrières')),(select id from cities where LOWER(label) = 'zaventem'),159);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MANHAY')),(select id from cities where LOWER(label) = 'zaventem'),203);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TENNEVILLE')),(select id from cities where LOWER(label) = 'zaventem'),164);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Champlon')),(select id from cities where LOWER(label) = 'zaventem'),165);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Erneuville')),(select id from cities where LOWER(label) = 'zaventem'),169);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LA ROCHE-EN-ARDENNE')),(select id from cities where LOWER(label) = 'zaventem'),162);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Samrée')),(select id from cities where LOWER(label) = 'zaventem'),184);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ortho')),(select id from cities where LOWER(label) = 'zaventem'),178);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hives')),(select id from cities where LOWER(label) = 'zaventem'),179);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Halleux')),(select id from cities where LOWER(label) = 'zaventem'),160);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('RENDEUX')),(select id from cities where LOWER(label) = 'zaventem'),160);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HOTTON')),(select id from cities where LOWER(label) = 'zaventem'),155);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('EREZÉE')),(select id from cities where LOWER(label) = 'zaventem'),172);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MONS')),(select id from cities where LOWER(label) = 'zaventem'),97 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ghlin')),(select id from cities where LOWER(label) = 'zaventem'),100);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Jemappes')),(select id from cities where LOWER(label) = 'zaventem'),105);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Nimy')),(select id from cities where LOWER(label) = 'zaventem'),97 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Havré')),(select id from cities where LOWER(label) = 'zaventem'),93 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hyon')),(select id from cities where LOWER(label) = 'zaventem'),104);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ciply')),(select id from cities where LOWER(label) = 'zaventem'),108);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-Symphorien')),(select id from cities where LOWER(label) = 'zaventem'),96 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Villers-Saint-Ghislain')),(select id from cities where LOWER(label) = 'zaventem'),97 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Spiennes')),(select id from cities where LOWER(label) = 'zaventem'),100);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Cuesmes')),(select id from cities where LOWER(label) = 'zaventem'),105);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Obourg')),(select id from cities where LOWER(label) = 'zaventem'),93 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-Denis')),(select id from cities where LOWER(label) = 'zaventem'),93 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('QUÉVY')),(select id from cities where LOWER(label) = 'zaventem'),117);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('JURBISE')),(select id from cities where LOWER(label) = 'zaventem'),104);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SOIGNIES')),(select id from cities where LOWER(label) = 'zaventem'),96 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Casteau')),(select id from cities where LOWER(label) = 'zaventem'),96 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Naast')),(select id from cities where LOWER(label) = 'zaventem'),92 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Neufvilles')),(select id from cities where LOWER(label) = 'zaventem'),102);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LE ROEULX')),(select id from cities where LOWER(label) = 'zaventem'),88 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FRAMERIES')),(select id from cities where LOWER(label) = 'zaventem'),109);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BRAINE-LE-COMTE')),(select id from cities where LOWER(label) = 'zaventem'),92 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LA LOUVIÈRE')),(select id from cities where LOWER(label) = 'zaventem'),87 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Strépy-Bracquegnies')),(select id from cities where LOWER(label) = 'zaventem'),87 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ESTINNES')),(select id from cities where LOWER(label) = 'zaventem'),97 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BINCHE')),(select id from cities where LOWER(label) = 'zaventem'),92 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Waudrez')),(select id from cities where LOWER(label) = 'zaventem'),92 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Buvrinnes')),(select id from cities where LOWER(label) = 'zaventem'),91 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Leval-Trahegnies')),(select id from cities where LOWER(label) = 'zaventem'),88 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MORLANWELZ')),(select id from cities where LOWER(label) = 'zaventem'),86 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Carnières')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHAPELLE-LEZ-HERLAIMONT')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MANAGE')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SENEFFE')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Feluy')),(select id from cities where LOWER(label) = 'zaventem'),84 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ECAUSSINNES')),(select id from cities where LOWER(label) = 'zaventem'),87 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ecaussinnes-Lalaing')),(select id from cities where LOWER(label) = 'zaventem'),86 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BOUSSU')),(select id from cities where LOWER(label) = 'zaventem'),110);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hornu')),(select id from cities where LOWER(label) = 'zaventem'),109);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BERNISSART')),(select id from cities where LOWER(label) = 'zaventem'),119);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Blaton')),(select id from cities where LOWER(label) = 'zaventem'),116);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Pommeroeul')),(select id from cities where LOWER(label) = 'zaventem'),112);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SAINT-GHISLAIN')),(select id from cities where LOWER(label) = 'zaventem'),106);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Baudour')),(select id from cities where LOWER(label) = 'zaventem'),107);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sirault')),(select id from cities where LOWER(label) = 'zaventem'),114);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Tertre')),(select id from cities where LOWER(label) = 'zaventem'),108);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hautrage')),(select id from cities where LOWER(label) = 'zaventem'),111);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('COLFONTAINE')),(select id from cities where LOWER(label) = 'zaventem'),113);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HENSIES')),(select id from cities where LOWER(label) = 'zaventem'),113);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DOUR')),(select id from cities where LOWER(label) = 'zaventem'),118);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('QUIÉVRAIN')),(select id from cities where LOWER(label) = 'zaventem'),120);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HONNELLES')),(select id from cities where LOWER(label) = 'zaventem'),125);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('QUAREGNON')),(select id from cities where LOWER(label) = 'zaventem'),109);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TOURNAI')),(select id from cities where LOWER(label) = 'zaventem'),142);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Orcq')),(select id from cities where LOWER(label) = 'zaventem'),145);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Esplechin')),(select id from cities where LOWER(label) = 'zaventem'),148);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Froyennes')),(select id from cities where LOWER(label) = 'zaventem'),141);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Froidmont')),(select id from cities where LOWER(label) = 'zaventem'),145);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Willemeau')),(select id from cities where LOWER(label) = 'zaventem'),146);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Chercq')),(select id from cities where LOWER(label) = 'zaventem'),138);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Marquain')),(select id from cities where LOWER(label) = 'zaventem'),145);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gaurain-Ramecroix')),(select id from cities where LOWER(label) = 'zaventem'),130);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Havinnes')),(select id from cities where LOWER(label) = 'zaventem'),135);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Béclers')),(select id from cities where LOWER(label) = 'zaventem'),128);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thimougies')),(select id from cities where LOWER(label) = 'zaventem'),134);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Maulde')),(select id from cities where LOWER(label) = 'zaventem'),127);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Vaulx')),(select id from cities where LOWER(label) = 'zaventem'),129);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Vezon')),(select id from cities where LOWER(label) = 'zaventem'),130);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Kain')),(select id from cities where LOWER(label) = 'zaventem'),137);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Mont-Saint-Aubert')),(select id from cities where LOWER(label) = 'zaventem'),141);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Mourcourt')),(select id from cities where LOWER(label) = 'zaventem'),131);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Warchin')),(select id from cities where LOWER(label) = 'zaventem'),132);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PÉRUWELZ')),(select id from cities where LOWER(label) = 'zaventem'),123);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Roucourt')),(select id from cities where LOWER(label) = 'zaventem'),123);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bury')),(select id from cities where LOWER(label) = 'zaventem'),122);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bon-Secours')),(select id from cities where LOWER(label) = 'zaventem'),122);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Baugnies')),(select id from cities where LOWER(label) = 'zaventem'),128);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wiers')),(select id from cities where LOWER(label) = 'zaventem'),138);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('RUMES')),(select id from cities where LOWER(label) = 'zaventem'),155);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('La Glanerie')),(select id from cities where LOWER(label) = 'zaventem'),159);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Taintignies')),(select id from cities where LOWER(label) = 'zaventem'),155);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BRUNEHAUT')),(select id from cities where LOWER(label) = 'zaventem'),143);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lesdain')),(select id from cities where LOWER(label) = 'zaventem'),146);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Laplaigne')),(select id from cities where LOWER(label) = 'zaventem'),146);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Rongy')),(select id from cities where LOWER(label) = 'zaventem'),154);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Howardries')),(select id from cities where LOWER(label) = 'zaventem'),157);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ANTOING')),(select id from cities where LOWER(label) = 'zaventem'),139);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bruyelle')),(select id from cities where LOWER(label) = 'zaventem'),141);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Calonne')),(select id from cities where LOWER(label) = 'zaventem'),138);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Fontenoy')),(select id from cities where LOWER(label) = 'zaventem'),136);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MOUSCRON')),(select id from cities where LOWER(label) = 'zaventem'),149);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Dottignies')),(select id from cities where LOWER(label) = 'zaventem'),149);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Herseaux')),(select id from cities where LOWER(label) = 'zaventem'),158);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ESTAIMPUIS')),(select id from cities where LOWER(label) = 'zaventem'),156);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PECQ')),(select id from cities where LOWER(label) = 'zaventem'),155);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hérinnes-Lez-Pecq')),(select id from cities where LOWER(label) = 'zaventem'),153);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Obigies')),(select id from cities where LOWER(label) = 'zaventem'),143);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MONT-DE-L\'ENCLUS')),(select id from cities where LOWER(label) = 'zaventem'),152);
insert into prices (from_id,to_id,price) values (1691,(select id from cities where LOWER(label) = 'zaventem'),153);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('COMINES-WARNETON')),(select id from cities where LOWER(label) = 'zaventem'),181);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Houthem')),(select id from cities where LOWER(label) = 'zaventem'),186);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ploegsteert')),(select id from cities where LOWER(label) = 'zaventem'),200);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bizet')),(select id from cities where LOWER(label) = 'zaventem'),187);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Warneton')),(select id from cities where LOWER(label) = 'zaventem'),188);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ATH')),(select id from cities where LOWER(label) = 'zaventem'),111);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Irchonwelz')),(select id from cities where LOWER(label) = 'zaventem'),114);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ormeignies')),(select id from cities where LOWER(label) = 'zaventem'),119);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bouvignies')),(select id from cities where LOWER(label) = 'zaventem'),113);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Rebaix')),(select id from cities where LOWER(label) = 'zaventem'),115);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Maffle')),(select id from cities where LOWER(label) = 'zaventem'),112);
insert into prices (from_id,to_id,price) values (1707,(select id from cities where LOWER(label) = 'zaventem'),111);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Houtaing')),(select id from cities where LOWER(label) = 'zaventem'),116);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ghislenghien')),(select id from cities where LOWER(label) = 'zaventem'),105);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gibecq')),(select id from cities where LOWER(label) = 'zaventem'),106);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SILLY')),(select id from cities where LOWER(label) = 'zaventem'),101);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ENGHIEN')),(select id from cities where LOWER(label) = 'zaventem'),96 );
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LESSINES')),(select id from cities where LOWER(label) = 'zaventem'),111);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wannebecq')),(select id from cities where LOWER(label) = 'zaventem'),113);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ogy')),(select id from cities where LOWER(label) = 'zaventem'),116);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ghoy')),(select id from cities where LOWER(label) = 'zaventem'),118);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Deux-Acren')),(select id from cities where LOWER(label) = 'zaventem'),113);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bois-De-Lessines')),(select id from cities where LOWER(label) = 'zaventem'),107);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LENS')),(select id from cities where LOWER(label) = 'zaventem'),105);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FLOBECQ')),(select id from cities where LOWER(label) = 'zaventem'),123);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ELLEZELLES')),(select id from cities where LOWER(label) = 'zaventem'),130);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LEUZE-EN-HAINAUT')),(select id from cities where LOWER(label) = 'zaventem'),124);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thieulain')),(select id from cities where LOWER(label) = 'zaventem'),126);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Blicquy')),(select id from cities where LOWER(label) = 'zaventem'),123);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Tourpes')),(select id from cities where LOWER(label) = 'zaventem'),123);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gallaix')),(select id from cities where LOWER(label) = 'zaventem'),126);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FRASNES-LEZ-ANVAING')),(select id from cities where LOWER(label) = 'zaventem'),135);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Moustier')),(select id from cities where LOWER(label) = 'zaventem'),126);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-Sauveur')),(select id from cities where LOWER(label) = 'zaventem'),134);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BRUGELETTE')),(select id from cities where LOWER(label) = 'zaventem'),108);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Attre')),(select id from cities where LOWER(label) = 'zaventem'),110);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Mévergnies-Lez-Lens')),(select id from cities where LOWER(label) = 'zaventem'),108);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gages')),(select id from cities where LOWER(label) = 'zaventem'),107);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHIÈVRES')),(select id from cities where LOWER(label) = 'zaventem'),116);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Tongre-Notre-Dame')),(select id from cities where LOWER(label) = 'zaventem'),117);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BELOEIL')),(select id from cities where LOWER(label) = 'zaventem'),120);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Basècles')),(select id from cities where LOWER(label) = 'zaventem'),122);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Quevaucamps')),(select id from cities where LOWER(label) = 'zaventem'),118);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Stambruges')),(select id from cities where LOWER(label) = 'zaventem'),116);

insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WAVRE')),(select id from cities where LOWER(label) = 'gosselies'),83);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bierges')),(select id from cities where LOWER(label) = 'gosselies'),87);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LA HULPE')),(select id from cities where LOWER(label) = 'gosselies'),82);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('INCOURT')),(select id from cities where LOWER(label) = 'gosselies'),89);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BEAUVECHAIN')),(select id from cities where LOWER(label) = 'gosselies'),96);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHAUMONT-GISTOUX')),(select id from cities where LOWER(label) = 'gosselies'),82);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('RIXENSART')),(select id from cities where LOWER(label) = 'gosselies'),71);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Rosières')),(select id from cities where LOWER(label) = 'gosselies'),86);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Genval')),(select id from cities where LOWER(label) = 'gosselies'),72);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('OTTIGNIES-LOUVAIN-LA-NEUVE')),(select id from cities where LOWER(label) = 'gosselies'),67);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Céroux-Mousty')),(select id from cities where LOWER(label) = 'gosselies'),61);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Limelette')),(select id from cities where LOWER(label) = 'gosselies'),73);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Louvain-La-Neuve')),(select id from cities where LOWER(label) = 'gosselies'),70);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ORP-JAUCHE')),(select id from cities where LOWER(label) = 'gosselies'),89);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HÉLÉCINE')),(select id from cities where LOWER(label) = 'gosselies'),100);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PERWEZ')),(select id from cities where LOWER(label) = 'gosselies'),77);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('RAMILLIES')),(select id from cities where LOWER(label) = 'gosselies'),83);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('JODOIGNE')),(select id from cities where LOWER(label) = 'gosselies'),89);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LASNE')),(select id from cities where LOWER(label) = 'gosselies'),65);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GREZ-DOICEAU')),(select id from cities where LOWER(label) = 'gosselies'),84);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('NIVELLES')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Baulers')),(select id from cities where LOWER(label) = 'gosselies'),56);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thines')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bornival')),(select id from cities where LOWER(label) = 'gosselies'),55);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WATERLOO')),(select id from cities where LOWER(label) = 'gosselies'),67);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BRAINE-L\'ALLEUD')),(select id from cities where LOWER(label) = 'gosselies'),64);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ophain-Bois-Seigneur-Isaac')),(select id from cities where LOWER(label) = 'gosselies'),57);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lillois-Witterzée')),(select id from cities where LOWER(label) = 'gosselies'),61);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('REBECQ')),(select id from cities where LOWER(label) = 'gosselies'),78);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MONT-SAINT-GUIBERT')),(select id from cities where LOWER(label) = 'gosselies'),67);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BRAINE-LE-CHÂTEAU')),(select id from cities where LOWER(label) = 'gosselies'),59);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHASTRE')),(select id from cities where LOWER(label) = 'gosselies'),61);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WALHAIN')),(select id from cities where LOWER(label) = 'gosselies'),69);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ITTRE')),(select id from cities where LOWER(label) = 'gosselies'),56);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Haut-Ittre')),(select id from cities where LOWER(label) = 'gosselies'),59);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GENAPPE')),(select id from cities where LOWER(label) = 'gosselies'),55);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Loupoigne')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Vieux-Genappe')),(select id from cities where LOWER(label) = 'gosselies'),55);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Glabais')),(select id from cities where LOWER(label) = 'gosselies'),53);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ways')),(select id from cities where LOWER(label) = 'gosselies'),53);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Houtain-Le-Val')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TUBIZE')),(select id from cities where LOWER(label) = 'gosselies'),75);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('COURT-SAINT-ETIENNE')),(select id from cities where LOWER(label) = 'gosselies'),61);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VILLERS-LA-VILLE')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values (1795,(select id from cities where LOWER(label) = 'gosselies'),110);
insert into prices (from_id,to_id,price) values (1797,(select id from cities where LOWER(label) = 'gosselies'),129);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Grivegnée')),(select id from cities where LOWER(label) = 'gosselies'),120);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Angleur')),(select id from cities where LOWER(label) = 'gosselies'),120);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Chênée')),(select id from cities where LOWER(label) = 'gosselies'),122);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HERSTAL')),(select id from cities where LOWER(label) = 'gosselies'),122);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Milmort')),(select id from cities where LOWER(label) = 'gosselies'),113);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Liers')),(select id from cities where LOWER(label) = 'gosselies'),111);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHAUDFONTAINE')),(select id from cities where LOWER(label) = 'gosselies'),128);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Vaux-Sous-Chèvremont')),(select id from cities where LOWER(label) = 'gosselies'),125);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Beaufays')),(select id from cities where LOWER(label) = 'gosselies'),131);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Embourg')),(select id from cities where LOWER(label) = 'gosselies'),125);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SERAING')),(select id from cities where LOWER(label) = 'gosselies'),112);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Jemeppe-Sur-Meuse')),(select id from cities where LOWER(label) = 'gosselies'),104);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ougrée')),(select id from cities where LOWER(label) = 'gosselies'),112);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('NEUPRÉ')),(select id from cities where LOWER(label) = 'gosselies'),116);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Neuville-En-Condroz')),(select id from cities where LOWER(label) = 'gosselies'),113);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Plainevaux')),(select id from cities where LOWER(label) = 'gosselies'),124);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ESNEUX')),(select id from cities where LOWER(label) = 'gosselies'),131);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SPRIMONT')),(select id from cities where LOWER(label) = 'gosselies'),137);
insert into prices (from_id,to_id,price) values (1827,(select id from cities where LOWER(label) = 'gosselies'),139);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ANTHISNES')),(select id from cities where LOWER(label) = 'gosselies'),119);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Villers-Aux-Tours')),(select id from cities where LOWER(label) = 'gosselies'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hody')),(select id from cities where LOWER(label) = 'gosselies'),117);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Tavier')),(select id from cities where LOWER(label) = 'gosselies'),116);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('COMBLAIN-AU-PONT')),(select id from cities where LOWER(label) = 'gosselies'),130);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Poulseur')),(select id from cities where LOWER(label) = 'gosselies'),131);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HAMOIR')),(select id from cities where LOWER(label) = 'gosselies'),127);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Filot')),(select id from cities where LOWER(label) = 'gosselies'),127);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FERRIÈRES')),(select id from cities where LOWER(label) = 'gosselies'),147);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BURDINNE')),(select id from cities where LOWER(label) = 'gosselies'),77);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HÉRON')),(select id from cities where LOWER(label) = 'gosselies'),76);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Couthuin')),(select id from cities where LOWER(label) = 'gosselies'),79);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WASSEIGES')),(select id from cities where LOWER(label) = 'gosselies'),86);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GEER')),(select id from cities where LOWER(label) = 'gosselies'),95);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Omal')),(select id from cities where LOWER(label) = 'gosselies'),94);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Darion')),(select id from cities where LOWER(label) = 'gosselies'),96);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ligney')),(select id from cities where LOWER(label) = 'gosselies'),93);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BERLOZ')),(select id from cities where LOWER(label) = 'gosselies'),103);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BRAIVES')),(select id from cities where LOWER(label) = 'gosselies'),84);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Latinne')),(select id from cities where LOWER(label) = 'gosselies'),89);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Tourinne')),(select id from cities where LOWER(label) = 'gosselies'),90);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HANNUT')),(select id from cities where LOWER(label) = 'gosselies'),89);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LINCENT')),(select id from cities where LOWER(label) = 'gosselies'),95);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WAREMME')),(select id from cities where LOWER(label) = 'gosselies'),102);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FAIMES')),(select id from cities where LOWER(label) = 'gosselies'),94);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('AWANS')),(select id from cities where LOWER(label) = 'gosselies'),109);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hognoul')),(select id from cities where LOWER(label) = 'gosselies'),106);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FEXHE-LE-HAUT-CLOCHER')),(select id from cities where LOWER(label) = 'gosselies'),101);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('REMICOURT')),(select id from cities where LOWER(label) = 'gosselies'),102);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hodeige')),(select id from cities where LOWER(label) = 'gosselies'),106);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DONCEEL')),(select id from cities where LOWER(label) = 'gosselies'),97);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('OREYE')),(select id from cities where LOWER(label) = 'gosselies'),110);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CRISNÉE')),(select id from cities where LOWER(label) = 'gosselies'),106);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FLÉMALLE')),(select id from cities where LOWER(label) = 'gosselies'),99);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SAINT-NICOLAS')),(select id from cities where LOWER(label) = 'gosselies'),109);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ANS')),(select id from cities where LOWER(label) = 'gosselies'),107);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Loncin')),(select id from cities where LOWER(label) = 'gosselies'),105);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Alleur')),(select id from cities where LOWER(label) = 'gosselies'),109);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('JUPRELLE')),(select id from cities where LOWER(label) = 'gosselies'),114);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Voroux-Lez-Liers')),(select id from cities where LOWER(label) = 'gosselies'),112);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wihogne')),(select id from cities where LOWER(label) = 'gosselies'),124);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Villers-Saint-Siméon')),(select id from cities where LOWER(label) = 'gosselies'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Fexhe-Slins')),(select id from cities where LOWER(label) = 'gosselies'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GRÂCE-HOLLOGNE')),(select id from cities where LOWER(label) = 'gosselies'),99);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SAINT-GEORGES-SUR-MEUSE')),(select id from cities where LOWER(label) = 'gosselies'),95);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ENGIS')),(select id from cities where LOWER(label) = 'gosselies'),110);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HUY')),(select id from cities where LOWER(label) = 'gosselies'),85);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WANZE')),(select id from cities where LOWER(label) = 'gosselies'),83);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VILLERS-LE-BOUILLET')),(select id from cities where LOWER(label) = 'gosselies'),87);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VERLAINE')),(select id from cities where LOWER(label) = 'gosselies'),92);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('AMAY')),(select id from cities where LOWER(label) = 'gosselies'),95);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('NANDRIN')),(select id from cities where LOWER(label) = 'gosselies'),107);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TINLOT')),(select id from cities where LOWER(label) = 'gosselies'),103);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CLAVIER')),(select id from cities where LOWER(label) = 'gosselies'),118);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MARCHIN')),(select id from cities where LOWER(label) = 'gosselies'),94);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MODAVE')),(select id from cities where LOWER(label) = 'gosselies'),100);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('OUFFET')),(select id from cities where LOWER(label) = 'gosselies'),114);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VISÉ')),(select id from cities where LOWER(label) = 'gosselies'),131);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Argenteau')),(select id from cities where LOWER(label) = 'gosselies'),126);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Cheratte')),(select id from cities where LOWER(label) = 'gosselies'),126);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-André')),(select id from cities where LOWER(label) = 'gosselies'),137);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DALHEM')),(select id from cities where LOWER(label) = 'gosselies'),134);
insert into prices (from_id,to_id,price) values (2032,(select id from cities where LOWER(label) = 'gosselies'),139);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BEYNE-HEUSAY')),(select id from cities where LOWER(label) = 'gosselies'),127);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FLÉRON')),(select id from cities where LOWER(label) = 'gosselies'),134);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Retinne')),(select id from cities where LOWER(label) = 'gosselies'),130);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Magnée')),(select id from cities where LOWER(label) = 'gosselies'),135);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Romsée')),(select id from cities where LOWER(label) = 'gosselies'),130);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SOUMAGNE')),(select id from cities where LOWER(label) = 'gosselies'),135);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Evegnée')),(select id from cities where LOWER(label) = 'gosselies'),128);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Cérexhe-Heuseux')),(select id from cities where LOWER(label) = 'gosselies'),129);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Melen')),(select id from cities where LOWER(label) = 'gosselies'),132);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HERVE')),(select id from cities where LOWER(label) = 'gosselies'),136);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Battice')),(select id from cities where LOWER(label) = 'gosselies'),135);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Xhendelesse')),(select id from cities where LOWER(label) = 'gosselies'),137);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bolland')),(select id from cities where LOWER(label) = 'gosselies'),132);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Charneux')),(select id from cities where LOWER(label) = 'gosselies'),139);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BLÉGNY')),(select id from cities where LOWER(label) = 'gosselies'),129);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Barchon')),(select id from cities where LOWER(label) = 'gosselies'),125);
insert into prices (from_id,to_id,price) values (1402,(select id from cities where LOWER(label) = 'gosselies'),131);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('OUPEYE')),(select id from cities where LOWER(label) = 'gosselies'),123);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hermalle-Sous-Argenteau')),(select id from cities where LOWER(label) = 'gosselies'),126);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Houtain-Saint-Siméon')),(select id from cities where LOWER(label) = 'gosselies'),126);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Vivegnis')),(select id from cities where LOWER(label) = 'gosselies'),123);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Haccourt')),(select id from cities where LOWER(label) = 'gosselies'),132);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BASSENGE')),(select id from cities where LOWER(label) = 'gosselies'),128);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('EUPEN')),(select id from cities where LOWER(label) = 'gosselies'),160);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Kettenis')),(select id from cities where LOWER(label) = 'gosselies'),155);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LONTZEN')),(select id from cities where LOWER(label) = 'gosselies'),154);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Walhorn')),(select id from cities where LOWER(label) = 'gosselies'),156);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LA CALAMINE')),(select id from cities where LOWER(label) = 'gosselies'),157);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Neu-Moresnet')),(select id from cities where LOWER(label) = 'gosselies'),157);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hergenrath')),(select id from cities where LOWER(label) = 'gosselies'),158);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('RAEREN')),(select id from cities where LOWER(label) = 'gosselies'),160);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Eynatten')),(select id from cities where LOWER(label) = 'gosselies'),160);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BUTGENBACH')),(select id from cities where LOWER(label) = 'gosselies'),191);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BULLANGE')),(select id from cities where LOWER(label) = 'gosselies'),207);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Rocherath')),(select id from cities where LOWER(label) = 'gosselies'),203);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('AMBLÈVE')),(select id from cities where LOWER(label) = 'gosselies'),187);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Heppenbach')),(select id from cities where LOWER(label) = 'gosselies'),198);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SAINT-VITH')),(select id from cities where LOWER(label) = 'gosselies'),190);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Schoenberg')),(select id from cities where LOWER(label) = 'gosselies'),208);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lommersweiler')),(select id from cities where LOWER(label) = 'gosselies'),194);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Crombach')),(select id from cities where LOWER(label) = 'gosselies'),191);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BURG-REULAND')),(select id from cities where LOWER(label) = 'gosselies'),205);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thommen')),(select id from cities where LOWER(label) = 'gosselies'),198);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VERVIERS')),(select id from cities where LOWER(label) = 'gosselies'),144);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Stembert')),(select id from cities where LOWER(label) = 'gosselies'),150);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Heusy')),(select id from cities where LOWER(label) = 'gosselies'),146);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DISON')),(select id from cities where LOWER(label) = 'gosselies'),140);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Andrimont')),(select id from cities where LOWER(label) = 'gosselies'),145);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LIMBOURG')),(select id from cities where LOWER(label) = 'gosselies'),153);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bilstain')),(select id from cities where LOWER(label) = 'gosselies'),143);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Goé')),(select id from cities where LOWER(label) = 'gosselies'),154);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BAELEN')),(select id from cities where LOWER(label) = 'gosselies'),161);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WELKENRAEDT')),(select id from cities where LOWER(label) = 'gosselies'),150);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Henri-Chapelle')),(select id from cities where LOWER(label) = 'gosselies'),145);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('JALHAY')),(select id from cities where LOWER(label) = 'gosselies'),162);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PLOMBIÈRES')),(select id from cities where LOWER(label) = 'gosselies'),154);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gemmenich')),(select id from cities where LOWER(label) = 'gosselies'),163);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sippenaeken')),(select id from cities where LOWER(label) = 'gosselies'),163);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hombourg')),(select id from cities where LOWER(label) = 'gosselies'),153);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PEPINSTER')),(select id from cities where LOWER(label) = 'gosselies'),150);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Soiron')),(select id from cities where LOWER(label) = 'gosselies'),139);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TROOZ')),(select id from cities where LOWER(label) = 'gosselies'),138);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('OLNE')),(select id from cities where LOWER(label) = 'gosselies'),140);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('AUBEL')),(select id from cities where LOWER(label) = 'gosselies'),146);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('THIMISTER-CLERMONT')),(select id from cities where LOWER(label) = 'gosselies'),144);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SPA')),(select id from cities where LOWER(label) = 'gosselies'),163);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('THEUX')),(select id from cities where LOWER(label) = 'gosselies'),155);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('AYWAILLE')),(select id from cities where LOWER(label) = 'gosselies'),146);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WAIMES')),(select id from cities where LOWER(label) = 'gosselies'),181);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MALMEDY')),(select id from cities where LOWER(label) = 'gosselies'),172);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('STAVELOT')),(select id from cities where LOWER(label) = 'gosselies'),173);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TROIS-PONTS')),(select id from cities where LOWER(label) = 'gosselies'),183);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Basse-Bodeux')),(select id from cities where LOWER(label) = 'gosselies'),166);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('STOUMONT')),(select id from cities where LOWER(label) = 'gosselies'),163);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LIERNEUX')),(select id from cities where LOWER(label) = 'gosselies'),172);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('NAMUR')),(select id from cities where LOWER(label) = 'gosselies'),66);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Belgrade')),(select id from cities where LOWER(label) = 'gosselies'),56);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-Servais')),(select id from cities where LOWER(label) = 'gosselies'),60);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-Marc')),(select id from cities where LOWER(label) = 'gosselies'),63);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bouge')),(select id from cities where LOWER(label) = 'gosselies'),66);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Champion')),(select id from cities where LOWER(label) = 'gosselies'),54);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Boninne')),(select id from cities where LOWER(label) = 'gosselies'),68);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Cognelée')),(select id from cities where LOWER(label) = 'gosselies'),65);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gelbressée')),(select id from cities where LOWER(label) = 'gosselies'),70);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GEMBLOUX')),(select id from cities where LOWER(label) = 'gosselies'),57);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Grand-Leez')),(select id from cities where LOWER(label) = 'gosselies'),64);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Corroy-Le-Château')),(select id from cities where LOWER(label) = 'gosselies'),53);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SAMBREVILLE')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FOSSES-LA-VILLE')),(select id from cities where LOWER(label) = 'gosselies'),51);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LA BRUYÈRE')),(select id from cities where LOWER(label) = 'gosselies'),57);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Meux')),(select id from cities where LOWER(label) = 'gosselies'),59);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Jambes')),(select id from cities where LOWER(label) = 'gosselies'),72);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Erpent')),(select id from cities where LOWER(label) = 'gosselies'),69);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SOMBREFFE')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FLOREFFE')),(select id from cities where LOWER(label) = 'gosselies'),55);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PROFONDEVILLE')),(select id from cities where LOWER(label) = 'gosselies'),62);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('JEMEPPE-SUR-SAMBRE')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ANDENNE')),(select id from cities where LOWER(label) = 'gosselies'),80);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('EGHEZÉE')),(select id from cities where LOWER(label) = 'gosselies'),71);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ASSESSE')),(select id from cities where LOWER(label) = 'gosselies'),79);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Crupet')),(select id from cities where LOWER(label) = 'gosselies'),82);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sorinne-La-Longue')),(select id from cities where LOWER(label) = 'gosselies'),78);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Florée')),(select id from cities where LOWER(label) = 'gosselies'),83);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Courrière')),(select id from cities where LOWER(label) = 'gosselies'),76);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GESVES')),(select id from cities where LOWER(label) = 'gosselies'),82);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('OHEY')),(select id from cities where LOWER(label) = 'gosselies'),93);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Haillot')),(select id from cities where LOWER(label) = 'gosselies'),89);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Perwez-Haillot')),(select id from cities where LOWER(label) = 'gosselies'),91);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Goesnes')),(select id from cities where LOWER(label) = 'gosselies'),95);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Jallet')),(select id from cities where LOWER(label) = 'gosselies'),96);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HAMOIS')),(select id from cities where LOWER(label) = 'gosselies'),87);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Mohiville')),(select id from cities where LOWER(label) = 'gosselies'),92);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Scy')),(select id from cities where LOWER(label) = 'gosselies'),92);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Achet')),(select id from cities where LOWER(label) = 'gosselies'),92);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Emptinne')),(select id from cities where LOWER(label) = 'gosselies'),87);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Schaltin')),(select id from cities where LOWER(label) = 'gosselies'),89);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HAVELANGE')),(select id from cities where LOWER(label) = 'gosselies'),98);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Méan')),(select id from cities where LOWER(label) = 'gosselies'),118);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Maffe')),(select id from cities where LOWER(label) = 'gosselies'),105);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Miécret')),(select id from cities where LOWER(label) = 'gosselies'),99);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SOMME-LEUZE')),(select id from cities where LOWER(label) = 'gosselies'),105);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FERNELMONT')),(select id from cities where LOWER(label) = 'gosselies'),69);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DINANT')),(select id from cities where LOWER(label) = 'gosselies'),92);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lisogne')),(select id from cities where LOWER(label) = 'gosselies'),90);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thynes')),(select id from cities where LOWER(label) = 'gosselies'),92);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sorinnes')),(select id from cities where LOWER(label) = 'gosselies'),91);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Foy-Notre-Dame')),(select id from cities where LOWER(label) = 'gosselies'),88);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ONHAYE')),(select id from cities where LOWER(label) = 'gosselies'),78);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Serville')),(select id from cities where LOWER(label) = 'gosselies'),76);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Falaën')),(select id from cities where LOWER(label) = 'gosselies'),70);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sommière')),(select id from cities where LOWER(label) = 'gosselies'),79);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gérin')),(select id from cities where LOWER(label) = 'gosselies'),76);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('YVOIR')),(select id from cities where LOWER(label) = 'gosselies'),89);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ANHÉE')),(select id from cities where LOWER(label) = 'gosselies'),66);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HASTIÈRE')),(select id from cities where LOWER(label) = 'gosselies'),84);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hastière-Par-Delà')),(select id from cities where LOWER(label) = 'gosselies'),83);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Blaimont')),(select id from cities where LOWER(label) = 'gosselies'),87);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Heer')),(select id from cities where LOWER(label) = 'gosselies'),86);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Agimont')),(select id from cities where LOWER(label) = 'gosselies'),81);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VRESSE-SUR-SEMOIS')),(select id from cities where LOWER(label) = 'gosselies'),143);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BIÈVRE')),(select id from cities where LOWER(label) = 'gosselies'),126);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HOUYET')),(select id from cities where LOWER(label) = 'gosselies'),100);
insert into prices (from_id,to_id,price) values (2638,(select id from cities where LOWER(label) = 'gosselies'),88);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Custinne')),(select id from cities where LOWER(label) = 'gosselies'),94);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hour')),(select id from cities where LOWER(label) = 'gosselies'),103);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wanlin')),(select id from cities where LOWER(label) = 'gosselies'),102);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BEAURAING')),(select id from cities where LOWER(label) = 'gosselies'),94);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wiesme')),(select id from cities where LOWER(label) = 'gosselies'),103);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Focant')),(select id from cities where LOWER(label) = 'gosselies'),106);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Martouzin-Neuville')),(select id from cities where LOWER(label) = 'gosselies'),99);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Pondrôme')),(select id from cities where LOWER(label) = 'gosselies'),102);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GEDINNE')),(select id from cities where LOWER(label) = 'gosselies'),120);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Froidfontaine')),(select id from cities where LOWER(label) = 'gosselies'),107);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ROCHEFORT')),(select id from cities where LOWER(label) = 'gosselies'),108);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Jemelle')),(select id from cities where LOWER(label) = 'gosselies'),115);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CINEY')),(select id from cities where LOWER(label) = 'gosselies'),97);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PHILIPPEVILLE')),(select id from cities where LOWER(label) = 'gosselies'),68);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FLORENNES')),(select id from cities where LOWER(label) = 'gosselies'),65);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thy-Le-Baudouin')),(select id from cities where LOWER(label) = 'gosselies'),50);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CERFONTAINE')),(select id from cities where LOWER(label) = 'gosselies'),69);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('METTET')),(select id from cities where LOWER(label) = 'gosselies'),54);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Furnaux')),(select id from cities where LOWER(label) = 'gosselies'),59);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ermeton-Sur-Biert')),(select id from cities where LOWER(label) = 'gosselies'),63);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Stave')),(select id from cities where LOWER(label) = 'gosselies'),59);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WALCOURT')),(select id from cities where LOWER(label) = 'gosselies'),53);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thy-Le-Château')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('COUVIN')),(select id from cities where LOWER(label) = 'gosselies'),77);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VIROINVAL')),(select id from cities where LOWER(label) = 'gosselies'),83);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DOISCHE')),(select id from cities where LOWER(label) = 'gosselies'),76);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHARLEROI')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Marcinelle')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Couillet')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Dampremy')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Marchienne-Au-Pont')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Monceau-Sur-Sambre')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Mont-Sur-Marchienne')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Jumet')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gosselies')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lodelinsart')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ransart')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Roux')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gilly')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Montignies-Sur-Sambre')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MONTIGNY-LE-TILLEUL')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Landelies')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HAM-SUR-HEURE')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FONTAINE-L\'EVÊQUE')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Forchies-La-Marche')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Leernes')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ANDERLUES')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('COURCELLES')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gouy-Lez-Piéton')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Souvret')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Trazegnies')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHÂTELET')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LES BONS VILLERS')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Mellet')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FLEURUS')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-Amand')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Brye')),(select id from cities where LOWER(label) = 'gosselies'),50);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wagnelée')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wanfercée-Baulet')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PONT-À-CELLES')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Luttre')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FARCIENNES')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('AISEAU-PRESLES')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GERPINNES')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FROIDCHAPELLE')),(select id from cities where LOWER(label) = 'gosselies'),71);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Erpion')),(select id from cities where LOWER(label) = 'gosselies'),65);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHIMAY')),(select id from cities where LOWER(label) = 'gosselies'),87);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Virelles')),(select id from cities where LOWER(label) = 'gosselies'),81);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Vaulx-Lez-Chimay')),(select id from cities where LOWER(label) = 'gosselies'),81);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lompret')),(select id from cities where LOWER(label) = 'gosselies'),81);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Baileux')),(select id from cities where LOWER(label) = 'gosselies'),93);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SIVRY-RANCE')),(select id from cities where LOWER(label) = 'gosselies'),71);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BEAUMONT')),(select id from cities where LOWER(label) = 'gosselies'),62);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Strée')),(select id from cities where LOWER(label) = 'gosselies'),53);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('THUIN')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Biesme-Sous-Thuin')),(select id from cities where LOWER(label) = 'gosselies'),50);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ragnies')),(select id from cities where LOWER(label) = 'gosselies'),52);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Biercée')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gozée')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thuillies')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LOBBES')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sars-La-Buissière')),(select id from cities where LOWER(label) = 'gosselies'),53);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bienne-Lez-Happart')),(select id from cities where LOWER(label) = 'gosselies'),50);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ERQUELINNES')),(select id from cities where LOWER(label) = 'gosselies'),64);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MERBES-LE-CHÂTEAU')),(select id from cities where LOWER(label) = 'gosselies'),60);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MOMIGNIES')),(select id from cities where LOWER(label) = 'gosselies'),96);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Macon')),(select id from cities where LOWER(label) = 'gosselies'),91);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Monceau-Imbrechies')),(select id from cities where LOWER(label) = 'gosselies'),92);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Macquenoise')),(select id from cities where LOWER(label) = 'gosselies'),99);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Beauwelz')),(select id from cities where LOWER(label) = 'gosselies'),98);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Seloignes')),(select id from cities where LOWER(label) = 'gosselies'),96);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BASTOGNE')),(select id from cities where LOWER(label) = 'gosselies'),162);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MARTELANGE')),(select id from cities where LOWER(label) = 'gosselies'),175);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FAUVILLERS')),(select id from cities where LOWER(label) = 'gosselies'),169);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VAUX-SUR-SÛRE')),(select id from cities where LOWER(label) = 'gosselies'),168);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Juseret')),(select id from cities where LOWER(label) = 'gosselies'),161);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HOUFFALIZE')),(select id from cities where LOWER(label) = 'gosselies'),152);
insert into prices (from_id,to_id,price) values (2187,(select id from cities where LOWER(label) = 'gosselies'),166);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Tavigny')),(select id from cities where LOWER(label) = 'gosselies'),173);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Mabompré')),(select id from cities where LOWER(label) = 'gosselies'),157);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wibrin')),(select id from cities where LOWER(label) = 'gosselies'),153);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('GOUVY')),(select id from cities where LOWER(label) = 'gosselies'),186);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bovigny')),(select id from cities where LOWER(label) = 'gosselies'),174);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Beho')),(select id from cities where LOWER(label) = 'gosselies'),181);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Cherain')),(select id from cities where LOWER(label) = 'gosselies'),176);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Montleban')),(select id from cities where LOWER(label) = 'gosselies'),167);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SAINTE-ODE')),(select id from cities where LOWER(label) = 'gosselies'),146);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lavacherie')),(select id from cities where LOWER(label) = 'gosselies'),143);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Flamierge')),(select id from cities where LOWER(label) = 'gosselies'),143);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BERTOGNE')),(select id from cities where LOWER(label) = 'gosselies'),152);
insert into prices (from_id,to_id,price) values (2203,(select id from cities where LOWER(label) = 'gosselies'),154);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VIELSALM')),(select id from cities where LOWER(label) = 'gosselies'),168);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Petit-Thier')),(select id from cities where LOWER(label) = 'gosselies'),190);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Grand-Halleux')),(select id from cities where LOWER(label) = 'gosselies'),186);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ARLON')),(select id from cities where LOWER(label) = 'gosselies'),193);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Guirsch')),(select id from cities where LOWER(label) = 'gosselies'),199);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Autelbas')),(select id from cities where LOWER(label) = 'gosselies'),192);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ATTERT')),(select id from cities where LOWER(label) = 'gosselies'),193);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HABAY')),(select id from cities where LOWER(label) = 'gosselies'),180);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Anlier')),(select id from cities where LOWER(label) = 'gosselies'),173);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Habay-La-Vieille')),(select id from cities where LOWER(label) = 'gosselies'),177);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Rulles')),(select id from cities where LOWER(label) = 'gosselies'),173);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TINTIGNY')),(select id from cities where LOWER(label) = 'gosselies'),181);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ETALLE')),(select id from cities where LOWER(label) = 'gosselies'),182);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Vance')),(select id from cities where LOWER(label) = 'gosselies'),185);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Chantemelle')),(select id from cities where LOWER(label) = 'gosselies'),190);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Buzenol')),(select id from cities where LOWER(label) = 'gosselies'),186);
insert into prices (from_id,to_id,price) values (2238,(select id from cities where LOWER(label) = 'gosselies'),196);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MUSSON')),(select id from cities where LOWER(label) = 'gosselies'),208);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('VIRTON')),(select id from cities where LOWER(label) = 'gosselies'),195);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Latour')),(select id from cities where LOWER(label) = 'gosselies'),200);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-Mard')),(select id from cities where LOWER(label) = 'gosselies'),200);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ROUVROY')),(select id from cities where LOWER(label) = 'gosselies'),201);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MEIX-DEVANT-VIRTON')),(select id from cities where LOWER(label) = 'gosselies'),195);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MESSANCY')),(select id from cities where LOWER(label) = 'gosselies'),198);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sélange')),(select id from cities where LOWER(label) = 'gosselies'),200);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Habergy')),(select id from cities where LOWER(label) = 'gosselies'),196);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('AUBANGE')),(select id from cities where LOWER(label) = 'gosselies'),206);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Athus')),(select id from cities where LOWER(label) = 'gosselies'),208);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Rachecourt')),(select id from cities where LOWER(label) = 'gosselies'),204);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LIBRAMONT-CHEVIGNY')),(select id from cities where LOWER(label) = 'gosselies'),152);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHINY')),(select id from cities where LOWER(label) = 'gosselies'),176);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Les Bulles')),(select id from cities where LOWER(label) = 'gosselies'),173);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Suxy')),(select id from cities where LOWER(label) = 'gosselies'),165);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Termes')),(select id from cities where LOWER(label) = 'gosselies'),178);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FLORENVILLE')),(select id from cities where LOWER(label) = 'gosselies'),170);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lacuisine')),(select id from cities where LOWER(label) = 'gosselies'),174);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Villers-Devant-Orval')),(select id from cities where LOWER(label) = 'gosselies'),189);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Chassepierre')),(select id from cities where LOWER(label) = 'gosselies'),173);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BOUILLON')),(select id from cities where LOWER(label) = 'gosselies'),157);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Noirfontaine')),(select id from cities where LOWER(label) = 'gosselies'),144);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sensenruth')),(select id from cities where LOWER(label) = 'gosselies'),141);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ucimont')),(select id from cities where LOWER(label) = 'gosselies'),139);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bellevaux')),(select id from cities where LOWER(label) = 'gosselies'),140);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Dohan')),(select id from cities where LOWER(label) = 'gosselies'),148);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Corbion')),(select id from cities where LOWER(label) = 'gosselies'),156);
insert into prices (from_id,to_id,price) values (2304,(select id from cities where LOWER(label) = 'gosselies'),156);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PALISEUL')),(select id from cities where LOWER(label) = 'gosselies'),132);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Nollevaux')),(select id from cities where LOWER(label) = 'gosselies'),146);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Opont')),(select id from cities where LOWER(label) = 'gosselies'),139);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Framont')),(select id from cities where LOWER(label) = 'gosselies'),139);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Fays-Les-Veneurs')),(select id from cities where LOWER(label) = 'gosselies'),155);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LÉGLISE')),(select id from cities where LOWER(label) = 'gosselies'),165);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SAINT-HUBERT')),(select id from cities where LOWER(label) = 'gosselies'),141);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BERTRIX')),(select id from cities where LOWER(label) = 'gosselies'),154);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HERBEUMONT')),(select id from cities where LOWER(label) = 'gosselies'),160);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LIBIN')),(select id from cities where LOWER(label) = 'gosselies'),132);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MARCHE-EN-FAMENNE')),(select id from cities where LOWER(label) = 'gosselies'),106);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('WELLIN')),(select id from cities where LOWER(label) = 'gosselies'),119);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Chanly')),(select id from cities where LOWER(label) = 'gosselies'),120);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Halma')),(select id from cities where LOWER(label) = 'gosselies'),112);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lomprez')),(select id from cities where LOWER(label) = 'gosselies'),112);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TELLIN')),(select id from cities where LOWER(label) = 'gosselies'),124);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DAVERDISSE')),(select id from cities where LOWER(label) = 'gosselies'),130);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DURBUY')),(select id from cities where LOWER(label) = 'gosselies'),122);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Villers-Sainte-Gertrude')),(select id from cities where LOWER(label) = 'gosselies'),133);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('NASSOGNE')),(select id from cities where LOWER(label) = 'gosselies'),130);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bande')),(select id from cities where LOWER(label) = 'gosselies'),115);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Grune')),(select id from cities where LOWER(label) = 'gosselies'),115);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Forrières')),(select id from cities where LOWER(label) = 'gosselies'),125);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MANHAY')),(select id from cities where LOWER(label) = 'gosselies'),161);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TENNEVILLE')),(select id from cities where LOWER(label) = 'gosselies'),133);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Champlon')),(select id from cities where LOWER(label) = 'gosselies'),133);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Erneuville')),(select id from cities where LOWER(label) = 'gosselies'),136);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LA ROCHE-EN-ARDENNE')),(select id from cities where LOWER(label) = 'gosselies'),129);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Samrée')),(select id from cities where LOWER(label) = 'gosselies'),145);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ortho')),(select id from cities where LOWER(label) = 'gosselies'),139);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hives')),(select id from cities where LOWER(label) = 'gosselies'),140);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Halleux')),(select id from cities where LOWER(label) = 'gosselies'),127);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('RENDEUX')),(select id from cities where LOWER(label) = 'gosselies'),127);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HOTTON')),(select id from cities where LOWER(label) = 'gosselies'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('EREZÉE')),(select id from cities where LOWER(label) = 'gosselies'),132);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MONS')),(select id from cities where LOWER(label) = 'gosselies'),66);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ghlin')),(select id from cities where LOWER(label) = 'gosselies'),69);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Jemappes')),(select id from cities where LOWER(label) = 'gosselies'),74);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Nimy')),(select id from cities where LOWER(label) = 'gosselies'),66);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Havré')),(select id from cities where LOWER(label) = 'gosselies'),61);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hyon')),(select id from cities where LOWER(label) = 'gosselies'),73);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ciply')),(select id from cities where LOWER(label) = 'gosselies'),77);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-Symphorien')),(select id from cities where LOWER(label) = 'gosselies'),64);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Villers-Saint-Ghislain')),(select id from cities where LOWER(label) = 'gosselies'),66);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Spiennes')),(select id from cities where LOWER(label) = 'gosselies'),68);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Cuesmes')),(select id from cities where LOWER(label) = 'gosselies'),73);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Obourg')),(select id from cities where LOWER(label) = 'gosselies'),61);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-Denis')),(select id from cities where LOWER(label) = 'gosselies'),61);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('QUÉVY')),(select id from cities where LOWER(label) = 'gosselies'),87);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('JURBISE')),(select id from cities where LOWER(label) = 'gosselies'),72);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SOIGNIES')),(select id from cities where LOWER(label) = 'gosselies'),66);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Casteau')),(select id from cities where LOWER(label) = 'gosselies'),64);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Naast')),(select id from cities where LOWER(label) = 'gosselies'),60);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Neufvilles')),(select id from cities where LOWER(label) = 'gosselies'),71);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LE ROEULX')),(select id from cities where LOWER(label) = 'gosselies'),55);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FRAMERIES')),(select id from cities where LOWER(label) = 'gosselies'),78);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BRAINE-LE-COMTE')),(select id from cities where LOWER(label) = 'gosselies'),67);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LA LOUVIÈRE')),(select id from cities where LOWER(label) = 'gosselies'),52);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Strépy-Bracquegnies')),(select id from cities where LOWER(label) = 'gosselies'),55);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ESTINNES')),(select id from cities where LOWER(label) = 'gosselies'),65);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BINCHE')),(select id from cities where LOWER(label) = 'gosselies'),60);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Waudrez')),(select id from cities where LOWER(label) = 'gosselies'),57);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Buvrinnes')),(select id from cities where LOWER(label) = 'gosselies'),54);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Leval-Trahegnies')),(select id from cities where LOWER(label) = 'gosselies'),52);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MORLANWELZ')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Carnières')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHAPELLE-LEZ-HERLAIMONT')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MANAGE')),(select id from cities where LOWER(label) = 'gosselies'),49);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SENEFFE')),(select id from cities where LOWER(label) = 'gosselies'),54);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Feluy')),(select id from cities where LOWER(label) = 'gosselies'),53);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ECAUSSINNES')),(select id from cities where LOWER(label) = 'gosselies'),56);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ecaussinnes-Lalaing')),(select id from cities where LOWER(label) = 'gosselies'),57);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BOUSSU')),(select id from cities where LOWER(label) = 'gosselies'),79);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hornu')),(select id from cities where LOWER(label) = 'gosselies'),78);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BERNISSART')),(select id from cities where LOWER(label) = 'gosselies'),89);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Blaton')),(select id from cities where LOWER(label) = 'gosselies'),86);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Pommeroeul')),(select id from cities where LOWER(label) = 'gosselies'),81);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SAINT-GHISLAIN')),(select id from cities where LOWER(label) = 'gosselies'),75);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Baudour')),(select id from cities where LOWER(label) = 'gosselies'),76);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Sirault')),(select id from cities where LOWER(label) = 'gosselies'),83);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Tertre')),(select id from cities where LOWER(label) = 'gosselies'),77);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hautrage')),(select id from cities where LOWER(label) = 'gosselies'),81);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('COLFONTAINE')),(select id from cities where LOWER(label) = 'gosselies'),82);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HENSIES')),(select id from cities where LOWER(label) = 'gosselies'),83);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('DOUR')),(select id from cities where LOWER(label) = 'gosselies'),88);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('QUIÉVRAIN')),(select id from cities where LOWER(label) = 'gosselies'),90);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('HONNELLES')),(select id from cities where LOWER(label) = 'gosselies'),94);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('QUAREGNON')),(select id from cities where LOWER(label) = 'gosselies'),78);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('TOURNAI')),(select id from cities where LOWER(label) = 'gosselies'),113);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Orcq')),(select id from cities where LOWER(label) = 'gosselies'),125);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Esplechin')),(select id from cities where LOWER(label) = 'gosselies'),129);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Froyennes')),(select id from cities where LOWER(label) = 'gosselies'),115);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Froidmont')),(select id from cities where LOWER(label) = 'gosselies'),127);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Willemeau')),(select id from cities where LOWER(label) = 'gosselies'),120);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Chercq')),(select id from cities where LOWER(label) = 'gosselies'),106);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Marquain')),(select id from cities where LOWER(label) = 'gosselies'),125);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gaurain-Ramecroix')),(select id from cities where LOWER(label) = 'gosselies'),102);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Havinnes')),(select id from cities where LOWER(label) = 'gosselies'),109);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Béclers')),(select id from cities where LOWER(label) = 'gosselies'),108);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thimougies')),(select id from cities where LOWER(label) = 'gosselies'),110);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Maulde')),(select id from cities where LOWER(label) = 'gosselies'),103);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Vaulx')),(select id from cities where LOWER(label) = 'gosselies'),104);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Vezon')),(select id from cities where LOWER(label) = 'gosselies'),100);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Kain')),(select id from cities where LOWER(label) = 'gosselies'),113);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Mont-Saint-Aubert')),(select id from cities where LOWER(label) = 'gosselies'),120);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Mourcourt')),(select id from cities where LOWER(label) = 'gosselies'),110);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Warchin')),(select id from cities where LOWER(label) = 'gosselies'),106);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PÉRUWELZ')),(select id from cities where LOWER(label) = 'gosselies'),93);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Roucourt')),(select id from cities where LOWER(label) = 'gosselies'),94);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bury')),(select id from cities where LOWER(label) = 'gosselies'),93);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bon-Secours')),(select id from cities where LOWER(label) = 'gosselies'),92);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Baugnies')),(select id from cities where LOWER(label) = 'gosselies'),97);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wiers')),(select id from cities where LOWER(label) = 'gosselies'),103);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('RUMES')),(select id from cities where LOWER(label) = 'gosselies'),126);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('La Glanerie')),(select id from cities where LOWER(label) = 'gosselies'),129);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Taintignies')),(select id from cities where LOWER(label) = 'gosselies'),122);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BRUNEHAUT')),(select id from cities where LOWER(label) = 'gosselies'),109);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Lesdain')),(select id from cities where LOWER(label) = 'gosselies'),113);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Laplaigne')),(select id from cities where LOWER(label) = 'gosselies'),113);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Rongy')),(select id from cities where LOWER(label) = 'gosselies'),120);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Howardries')),(select id from cities where LOWER(label) = 'gosselies'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ANTOING')),(select id from cities where LOWER(label) = 'gosselies'),106);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bruyelle')),(select id from cities where LOWER(label) = 'gosselies'),107);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Calonne')),(select id from cities where LOWER(label) = 'gosselies'),108);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Fontenoy')),(select id from cities where LOWER(label) = 'gosselies'),103);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MOUSCRON')),(select id from cities where LOWER(label) = 'gosselies'),141);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Dottignies')),(select id from cities where LOWER(label) = 'gosselies'),136);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Herseaux')),(select id from cities where LOWER(label) = 'gosselies'),139);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ESTAIMPUIS')),(select id from cities where LOWER(label) = 'gosselies'),128);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('PECQ')),(select id from cities where LOWER(label) = 'gosselies'),130);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Hérinnes-Lez-Pecq')),(select id from cities where LOWER(label) = 'gosselies'),127);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Obigies')),(select id from cities where LOWER(label) = 'gosselies'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('MONT-DE-L\'ENCLUS')),(select id from cities where LOWER(label) = 'gosselies'),132);
insert into prices (from_id,to_id,price) values (1691,(select id from cities where LOWER(label) = 'gosselies'),123);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('COMINES-WARNETON')),(select id from cities where LOWER(label) = 'gosselies'),166);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Houthem')),(select id from cities where LOWER(label) = 'gosselies'),172);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ploegsteert')),(select id from cities where LOWER(label) = 'gosselies'),173);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bizet')),(select id from cities where LOWER(label) = 'gosselies'),167);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Warneton')),(select id from cities where LOWER(label) = 'gosselies'),171);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ATH')),(select id from cities where LOWER(label) = 'gosselies'),89);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Irchonwelz')),(select id from cities where LOWER(label) = 'gosselies'),91);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ormeignies')),(select id from cities where LOWER(label) = 'gosselies'),96);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bouvignies')),(select id from cities where LOWER(label) = 'gosselies'),93);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Rebaix')),(select id from cities where LOWER(label) = 'gosselies'),100);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Maffle')),(select id from cities where LOWER(label) = 'gosselies'),87);
insert into prices (from_id,to_id,price) values (1707,(select id from cities where LOWER(label) = 'gosselies'),88);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Houtaing')),(select id from cities where LOWER(label) = 'gosselies'),95);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ghislenghien')),(select id from cities where LOWER(label) = 'gosselies'),84);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gibecq')),(select id from cities where LOWER(label) = 'gosselies'),83);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('SILLY')),(select id from cities where LOWER(label) = 'gosselies'),79);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ENGHIEN')),(select id from cities where LOWER(label) = 'gosselies'),80);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LESSINES')),(select id from cities where LOWER(label) = 'gosselies'),96);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Wannebecq')),(select id from cities where LOWER(label) = 'gosselies'),97);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ogy')),(select id from cities where LOWER(label) = 'gosselies'),101);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Ghoy')),(select id from cities where LOWER(label) = 'gosselies'),103);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Deux-Acren')),(select id from cities where LOWER(label) = 'gosselies'),98);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Bois-De-Lessines')),(select id from cities where LOWER(label) = 'gosselies'),90);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LENS')),(select id from cities where LOWER(label) = 'gosselies'),77);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FLOBECQ')),(select id from cities where LOWER(label) = 'gosselies'),108);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('ELLEZELLES')),(select id from cities where LOWER(label) = 'gosselies'),113);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('LEUZE-EN-HAINAUT')),(select id from cities where LOWER(label) = 'gosselies'),100);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Thieulain')),(select id from cities where LOWER(label) = 'gosselies'),107);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Blicquy')),(select id from cities where LOWER(label) = 'gosselies'),104);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Tourpes')),(select id from cities where LOWER(label) = 'gosselies'),97);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gallaix')),(select id from cities where LOWER(label) = 'gosselies'),103);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('FRASNES-LEZ-ANVAING')),(select id from cities where LOWER(label) = 'gosselies'),121);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Moustier')),(select id from cities where LOWER(label) = 'gosselies'),112);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Saint-Sauveur')),(select id from cities where LOWER(label) = 'gosselies'),119);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BRUGELETTE')),(select id from cities where LOWER(label) = 'gosselies'),82);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Attre')),(select id from cities where LOWER(label) = 'gosselies'),87);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Mévergnies-Lez-Lens')),(select id from cities where LOWER(label) = 'gosselies'),86);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Gages')),(select id from cities where LOWER(label) = 'gosselies'),83);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('CHIÈVRES')),(select id from cities where LOWER(label) = 'gosselies'),90);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Tongre-Notre-Dame')),(select id from cities where LOWER(label) = 'gosselies'),91);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('BELOEIL')),(select id from cities where LOWER(label) = 'gosselies'),90);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Basècles')),(select id from cities where LOWER(label) = 'gosselies'),92);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Quevaucamps')),(select id from cities where LOWER(label) = 'gosselies'),92);
insert into prices (from_id,to_id,price) values ((select id from cities where LOWER(label) = LOWER('Stambruges')),(select id from cities where LOWER(label) = 'gosselies'),86);

