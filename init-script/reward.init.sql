DROP DATABASE IF EXISTS rewarddb;

create database IF NOT EXISTS rewarddb;

use rewarddb;

DROP TABLE IF EXISTS reward;

CREATE TABLE IF NOT EXISTS `reward` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quest_id` int NOT NULL,
  `quest_giver` varchar(120) NOT NULL,
  `quest_taker` varchar(120) NOT NULL,
  `initial_amount` double NOT NULL,
  `proposed_amount` double DEFAULT NULL,
  `status` int DEFAULT 1,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;