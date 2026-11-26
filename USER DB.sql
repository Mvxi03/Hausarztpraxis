CREATE DATABASE IF NOT EXISTS `user_db_modell` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `user_db_modell`;

CREATE TABLE `app_user` (
  `user_id` char(36) NOT NULL DEFAULT (UUID()),
  `benutzername` varchar(80) NOT NULL,
  `anzeigename` varchar(180) NOT NULL,
  `passwort_hash` varchar(255) NOT NULL,
  `ist_aktiv` tinyint(1) NOT NULL DEFAULT '1',
  `letzter_login` timestamp(6) NULL DEFAULT NULL,
  `erstellt_von_user_id` char(36) DEFAULT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_app_user_benutzername` (`benutzername`),
  KEY `fk_app_user_erstellt_von` (`erstellt_von_user_id`),
  KEY `fk_app_user_aktualisiert_von` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_app_user_aktualisiert_von` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `app_user` (`user_id`),
  CONSTRAINT `fk_app_user_erstellt_von` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `app_user` (`user_id`),
  CONSTRAINT `chk_user_ist_aktiv` CHECK ((`ist_aktiv` in (0,1)))
);

CREATE TABLE `audit_log` (
  `log_id` char(36) NOT NULL DEFAULT (UUID()),
  `bearbeitet_von_user_id` char(36) NOT NULL,
  `instanz` varchar(30) NOT NULL,
  `tabelle` varchar(80) NOT NULL,
  `datensatz_id` char(36) NOT NULL,
  `feld` varchar(80) NOT NULL,
  `aktion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `alter_wert` longtext,
  `neuer_wert` longtext,
  `geaendert_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `vorgang_id` char(36) DEFAULT NULL,
  `aenderungsgrund` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `idx_audit_log_user` (`bearbeitet_von_user_id`),
  KEY `idx_audit_vorgang` (`vorgang_id`),
  KEY `idx_audit_datensatz` (`instanz`,`tabelle`,`datensatz_id`,`geaendert_am`),
  CONSTRAINT `fk_audit_log_user` FOREIGN KEY (`bearbeitet_von_user_id`) REFERENCES `app_user` (`user_id`)
);

CREATE TABLE `berechtigung` (
  `berechtigung_id` char(36) NOT NULL DEFAULT (UUID()),
  `code` varchar(80) NOT NULL,
  `beschreibung` varchar(255) DEFAULT NULL,
  `erstellt_von_user_id` char(36) DEFAULT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`berechtigung_id`),
  UNIQUE KEY `uq_berechtigung_code` (`code`),
  KEY `fk_berechtigung_erstellt_von` (`erstellt_von_user_id`),
  KEY `fk_berechtigung_aktualisiert_von` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_berechtigung_aktualisiert_von` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `app_user` (`user_id`),
  CONSTRAINT `fk_berechtigung_erstellt_von` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `app_user` (`user_id`)
);

CREATE TABLE `rolle` (
  `rolle_id` char(36) NOT NULL DEFAULT (UUID()),
  `code` varchar(50) NOT NULL,
  `beschreibung` varchar(255) DEFAULT NULL,
  `erstellt_von_user_id` char(36) DEFAULT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`rolle_id`),
  UNIQUE KEY `uq_rolle_code` (`code`),
  KEY `fk_rolle_erstellt_von` (`erstellt_von_user_id`),
  KEY `fk_rolle_aktualisiert_von` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_rolle_aktualisiert_von` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `app_user` (`user_id`),
  CONSTRAINT `fk_rolle_erstellt_von` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `app_user` (`user_id`)
);

CREATE TABLE `benutzer_rolle` (
  `zuordnung_id` char(36) NOT NULL DEFAULT (UUID()),
  `user_id` char(36) NOT NULL,
  `rolle_id` char(36) NOT NULL,
  `erstellt_von_user_id` char(36) DEFAULT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`zuordnung_id`),
  UNIQUE KEY `uq_benutzer_rolle` (`user_id`,`rolle_id`),
  KEY `idx_benutzer_rolle_rolle` (`rolle_id`),
  KEY `fk_benutzer_rolle_erstellt_von` (`erstellt_von_user_id`),
  KEY `fk_benutzer_rolle_aktualisiert_von` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_benutzer_rolle_aktualisiert_von` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `app_user` (`user_id`),
  CONSTRAINT `fk_benutzer_rolle_erstellt_von` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `app_user` (`user_id`),
  CONSTRAINT `fk_benutzer_rolle_rolle` FOREIGN KEY (`rolle_id`) REFERENCES `rolle` (`rolle_id`),
  CONSTRAINT `fk_benutzer_rolle_user` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`user_id`)
);

CREATE TABLE `rolle_berechtigung` (
  `zuordnung_id` char(36) NOT NULL DEFAULT (UUID()),
  `rolle_id` char(36) NOT NULL,
  `berechtigung_id` char(36) NOT NULL,
  `erstellt_von_user_id` char(36) DEFAULT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`zuordnung_id`),
  UNIQUE KEY `uq_rolle_berechtigung` (`rolle_id`,`berechtigung_id`),
  KEY `idx_rolle_berechtigung_berechtigung` (`berechtigung_id`),
  KEY `fk_rolle_berechtigung_erstellt_von` (`erstellt_von_user_id`),
  KEY `fk_rolle_berechtigung_aktualisiert_von` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_rolle_berechtigung_aktualisiert_von` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `app_user` (`user_id`),
  CONSTRAINT `fk_rolle_berechtigung_berechtigung` FOREIGN KEY (`berechtigung_id`) REFERENCES `berechtigung` (`berechtigung_id`),
  CONSTRAINT `fk_rolle_berechtigung_erstellt_von` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `app_user` (`user_id`),
  CONSTRAINT `fk_rolle_berechtigung_rolle` FOREIGN KEY (`rolle_id`) REFERENCES `rolle` (`rolle_id`)
);
