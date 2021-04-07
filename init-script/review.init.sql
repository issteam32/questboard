DROP DATABASE IF EXISTS reviewdb;

create database IF NOT EXISTS reviewdb;

use reviewdb;

DROP TABLE IF EXISTS review;

CREATE TABLE IF NOT EXISTS `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quest_id` int NOT NULL,
  `reviewer` varchar(45) NOT NULL,
  `quest_taker` varchar(45) NOT NULL,
  `review_msg` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;