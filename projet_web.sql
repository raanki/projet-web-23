-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : sam. 08 juin 2024 à 11:12
-- Version du serveur : 8.0.36-0ubuntu0.22.04.1
-- Version de PHP : 8.1.2-1ubuntu2.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `projet_web`
--

-- --------------------------------------------------------

--
-- Structure de la table `equipment`
--

CREATE TABLE `equipment` (
  `material_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `barcode` text,
  `description` varchar(255) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_price` decimal(15,2) DEFAULT NULL,
  `supplier` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `availability` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `image_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `equipment`
--

INSERT INTO `equipment` (`material_id`, `name`, `barcode`, `description`, `purchase_date`, `purchase_price`, `supplier`, `status`, `availability`, `created_at`, `image_id`) VALUES
(17, 'Laptop', NULL, 'Portable computer for daily work', '2023-01-08', '1200.00', 'TechCorp', NULL, 1, NULL, NULL),
(18, 'Printer', NULL, 'Color laser printer', '2020-06-08', '350.00', 'PrintSolutions', NULL, 1, NULL, NULL),
(19, 'Projector', NULL, 'HD projector for presentations', '2020-06-08', '500.00', 'Visuals Inc', NULL, 1, NULL, NULL),
(20, 'Tablet', NULL, 'Graphic tablet for designers', '2021-06-09', '800.00', 'ArtTech', NULL, 1, NULL, NULL),
(21, 'Router', NULL, 'Wi-Fi router for office', '2007-06-08', '150.00', 'NetConnect', NULL, 1, NULL, NULL),
(23, 'IP Phone', NULL, 'IP phone for VoIP calls', '2018-06-12', '120.00', 'VoipSolutions', NULL, 1, NULL, NULL),
(24, 'Server', NULL, 'Server for internal hosting', '2012-06-29', '2500.00', 'DataCenter', NULL, 1, NULL, NULL),
(25, 'Monitor', NULL, '27-inch office monitor', '2017-06-13', '300.00', 'DisplayTech', NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `image`
--

CREATE TABLE `image` (
  `image_id` int NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `mail` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `to_loan`
--

CREATE TABLE `to_loan` (
  `loan_id` int NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `expect_end_date` datetime DEFAULT NULL,
  `commentary` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `mail` varchar(50) DEFAULT NULL,
  `material_id` int NOT NULL,
  `actual_end_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `to_loan`
--

INSERT INTO `to_loan` (`loan_id`, `start_date`, `expect_end_date`, `commentary`, `created_at`, `mail`, `material_id`, `actual_end_date`) VALUES
(4, '2024-06-06 00:00:00', '2024-06-09 00:00:00', 'The laptop is in excellent condition, with all necessary software installed for daily work', NULL, 'jane.smith@example.com', 22, NULL),
(5, '2024-06-03 00:00:00', '2024-06-06 00:00:00', 'The color laser printer is reliable and has sufficient toner for at least 500 more pages.', NULL, 'alice.johnson@example.com', 18, NULL),
(6, '2024-02-07 00:00:00', '2024-08-09 00:00:00', 'The high-resolution scanner is perfect for digitizing documents and images quickly.', NULL, 'bob.brown@example.com', 19, NULL),
(7, '2024-06-01 00:00:00', '2024-06-27 00:00:00', 'The graphic tablet is essential for designers, offering precise and responsive input.', NULL, 'john.doe@example.com', 20, NULL),
(8, '2024-06-10 00:00:00', '2024-06-27 00:00:00', 'The server is powerful and reliable, suitable for hosting various internal applications.', NULL, 'charlie.davis@example.com', 24, NULL),
(9, '2024-06-02 00:00:00', '2024-06-05 00:00:00', 'The 27-inch monitor offers a sharp and vibrant display, enhancing productivity and user comfort.', NULL, 'rabalone94@gmail.com', 25, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `mail` varchar(50) NOT NULL,
  `student_number` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `job` varchar(50) DEFAULT NULL,
  `birth_date` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`mail`, `student_number`, `firstname`, `lastname`, `address`, `password`, `phone`, `job`, `birth_date`, `created_at`) VALUES
(' jane.smith@example.com', '0xC1D4A2B3', 'Jane', 'Smith', '456 Oak Street', NULL, '+0987654321', 'Student', '2024-05-22 00:00:00', '2024-06-08 10:36:52'),
('alice.johnson@example.com', '0xB2C3A1D4', 'Alice', 'Johnson', '789 Pine Street', NULL, '+1122334455', 'Student', '2009-10-21 00:00:00', '2024-06-08 10:37:39'),
('bob.brown@example.com', '1232616265', 'Bob', 'Brown', '101 Maple Street', NULL, '2233445566', '+2233445566', '2024-06-06 00:00:00', '2024-06-08 10:38:59'),
('celine.etudiant@efrei.net', '0', 'Celine', 'Martin-Parisot', '27 rue bressons', '$2y$10$NM2AIZsVNrAX7zF1xG.OVeFjbHBXGEXFxPGvlakSjzalxMuoyh7ka', '06 68 95 36 95', 'Developpeuse', '2024-03-05 00:00:00', '2024-06-08 10:09:29'),
('charlie.davis@example.com', '0xA4B1C2D3', 'Charlie', 'Davis', ' 202 Birch Street', NULL, '+3344556677', 'Student', '2006-07-05 00:00:00', '2024-06-08 10:39:39'),
('diana.evans@example.com', '0xC1D4A2B3', 'Diana', 'Evans', '303 Cedar Street', NULL, '+4455667788', 'Student', '1993-10-05 00:00:00', '2024-06-08 10:40:44'),
('john.doe@example.com', '0xA1B2C3D4', 'John', 'Doe', '123 Elm Street', NULL, '06 45 67 89 04', 'Student', '2024-05-29 00:00:00', '2024-06-08 10:34:25'),
('mahdi.etudiant@efrei.net', '0', 'Mahdi', 'Oui', '15 rue savoir', '$2y$10$Qi2235YB.gQOLWmbzRj0T.wHJ8NFGM4rfBiaKjwq9jn9zmtm0nhSS', '06 64 35 38 63', 'Coach', '2002-06-13 00:00:00', '2024-06-08 10:13:03'),
('rabalone94@gmail.com', '0xA3B2C4D1', 'Rayan', 'Anki', '32 Rue de Strasbourg', '', '0664353863', 'test24', '2024-06-13 00:00:00', '2024-06-01 18:09:37'),
('rayan.anki@efrei.net', '0xB1C2D3A4', 'rayan', 'anki', '32 rue de strasbourg', 'mtco1234', '0664353863', 'informaticien', '2024-05-30 01:28:37', '2024-05-30 01:28:37'),
('yessi.etudiant@efrei.net', '0', 'Yessi', 'Racerlyn', '17 rue kaaris', '$2y$10$0Zpxzh70DSeDA5BCsTEWAunIO3WVZpqRQNVIcu9bRjbgLO8P8Kqri', '06 64 69 42 56', 'Jardinnier', '1993-06-16 00:00:00', '2024-06-08 10:11:17');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`material_id`),
  ADD KEY `image_id` (`image_id`);

--
-- Index pour la table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`image_id`),
  ADD UNIQUE KEY `mail` (`mail`);

--
-- Index pour la table `to_loan`
--
ALTER TABLE `to_loan`
  ADD PRIMARY KEY (`loan_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`mail`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `material_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `to_loan`
--
ALTER TABLE `to_loan`
  MODIFY `loan_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `equipment`
--
ALTER TABLE `equipment`
  ADD CONSTRAINT `equipment_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`);

--
-- Contraintes pour la table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `image_ibfk_1` FOREIGN KEY (`mail`) REFERENCES `users` (`mail`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
