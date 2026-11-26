CREATE DATABASE IF NOT EXISTS `kis_db_modell` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `kis_db_modell`;

CREATE TABLE `adressart` (
  `adressart_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(80) NOT NULL,
  PRIMARY KEY (`adressart_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`)
);

CREATE TABLE `anrede` (
  `anrede_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(50) NOT NULL,
  PRIMARY KEY (`anrede_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`)
);

CREATE TABLE `beziehungsart` (
  `beziehungsart_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(80) NOT NULL,
  PRIMARY KEY (`beziehungsart_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`)
);

CREATE TABLE `beziehungsstatus` (
  `beziehungsstatus_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(80) NOT NULL,
  PRIMARY KEY (`beziehungsstatus_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`)
);

CREATE TABLE `geschlecht` (
  `geschlecht_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(50) NOT NULL,
  PRIMARY KEY (`geschlecht_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`)
);

CREATE TABLE `kontaktart` (
  `kontaktart_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(80) NOT NULL,
  PRIMARY KEY (`kontaktart_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`)
);

CREATE TABLE `religion` (
  `religion_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(100) NOT NULL,
  PRIMARY KEY (`religion_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`)
);

CREATE TABLE `staat` (
  `staat_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(100) NOT NULL,
  `iso_code` char(2) NOT NULL,
  PRIMARY KEY (`staat_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`),
  UNIQUE KEY `iso_code` (`iso_code`)
);

CREATE TABLE `patient` (
  `patient_id` char(36) NOT NULL DEFAULT (UUID()),
  `vorname` varchar(100) NOT NULL,
  `weitere_vornamen` varchar(150) DEFAULT NULL,
  `nachname` varchar(100) NOT NULL,
  `geburtsdatum` date NOT NULL,
  `pronomen` varchar(100) DEFAULT NULL,
  `sozialversicherungsnummer` varchar(50) DEFAULT NULL,
  `telefon` varchar(50) DEFAULT NULL,
  `email` varchar(160) DEFAULT NULL,
  `hausarzt_user_id` char(36) DEFAULT NULL,
  `ist_aktiv` tinyint(1) NOT NULL DEFAULT '1',
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `religion_id` char(36) DEFAULT NULL,
  `geschlecht_id` char(36) DEFAULT NULL,
  `beziehungsstatus_id` char(36) DEFAULT NULL,
  `anrede_id` char(36) DEFAULT NULL,
  `kontaktart_id` char(36) DEFAULT NULL,
  `staat_id` char(36) DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `uq_patient_svn` (`sozialversicherungsnummer`),
  KEY `fk_patient_staat` (`staat_id`),
  KEY `fk_patient_religion` (`religion_id`),
  KEY `fk_patient_geschlecht` (`geschlecht_id`),
  KEY `fk_patient_beziehungsstatus` (`beziehungsstatus_id`),
  KEY `fk_patient_anrede` (`anrede_id`),
  KEY `fk_patient_kontaktart` (`kontaktart_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  KEY `hausarzt_user_id` (`hausarzt_user_id`),
  CONSTRAINT `fk_patient_staat` FOREIGN KEY (`staat_id`) REFERENCES `staat` (`staat_id`),
  CONSTRAINT `fk_patient_anrede` FOREIGN KEY (`anrede_id`) REFERENCES `anrede` (`anrede_id`),
  CONSTRAINT `fk_patient_beziehungsstatus` FOREIGN KEY (`beziehungsstatus_id`) REFERENCES `beziehungsstatus` (`beziehungsstatus_id`),
  CONSTRAINT `fk_patient_geschlecht` FOREIGN KEY (`geschlecht_id`) REFERENCES `geschlecht` (`geschlecht_id`),
  CONSTRAINT `fk_patient_kontaktart` FOREIGN KEY (`kontaktart_id`) REFERENCES `kontaktart` (`kontaktart_id`),
  CONSTRAINT `fk_patient_religion` FOREIGN KEY (`religion_id`) REFERENCES `religion` (`religion_id`),
  CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `patient_ibfk_2` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `patient_ibfk_3` FOREIGN KEY (`hausarzt_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `chk_patient_ist_aktiv` CHECK ((`ist_aktiv` in (0,1)))
);

CREATE TABLE `region` (
  `region_id` char(36) NOT NULL DEFAULT (UUID()),
  `staat_id` char(36) NOT NULL,
  `bezeichnung` varchar(100) NOT NULL,
  PRIMARY KEY (`region_id`),
  UNIQUE KEY `staat_id` (`staat_id`,`bezeichnung`),
  UNIQUE KEY `uq_region_staat` (`region_id`,`staat_id`),
  CONSTRAINT `fk_region_staat` FOREIGN KEY (`staat_id`) REFERENCES `staat` (`staat_id`)
);

CREATE TABLE `adresse` (
  `adresse_id` char(36) NOT NULL DEFAULT (UUID()),
  `strasse` varchar(150) DEFAULT NULL,
  `hausnummer` varchar(20) DEFAULT NULL,
  `stiege_tuer` varchar(30) DEFAULT NULL,
  `plz` varchar(20) DEFAULT NULL,
  `ort` varchar(100) DEFAULT NULL,
  `bezirk` varchar(100) DEFAULT NULL,
  `staat_id` char(36) NOT NULL,
  `region_id` char(36) DEFAULT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `region_freitext` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`adresse_id`),
  KEY `fk_adresse_staat` (`staat_id`),
  KEY `fk_adresse_region_staat` (`region_id`,`staat_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `adresse_ibfk_1` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `adresse_ibfk_2` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `fk_adresse_region` FOREIGN KEY (`region_id`) REFERENCES `region` (`region_id`),
  CONSTRAINT `fk_adresse_staat` FOREIGN KEY (`staat_id`) REFERENCES `staat` (`staat_id`),
  CONSTRAINT `chk_adresse_region_auswahl` CHECK (((`region_id` is null) or (`region_freitext` is null)))
);

CREATE TABLE `notfallkontakt` (
  `notfallkontakt_id` char(36) NOT NULL DEFAULT (UUID()),
  `patient_id` char(36) NOT NULL,
  `titel_vor` varchar(50) DEFAULT NULL,
  `vorname` varchar(100) NOT NULL,
  `weitere_vornamen` varchar(150) DEFAULT NULL,
  `nachname` varchar(100) NOT NULL,
  `titel_nach` varchar(50) DEFAULT NULL,
  `geburtsdatum` date DEFAULT NULL,
  `pronomen` varchar(100) DEFAULT NULL,
  `telefon` varchar(50) NOT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `geschlecht_id` char(36) DEFAULT NULL,
  `anrede_id` char(36) DEFAULT NULL,
  `beziehungsart_id` char(36) NOT NULL,
  `adresse_id` char(36) DEFAULT NULL,
  PRIMARY KEY (`notfallkontakt_id`),
  KEY `fk_nk_adresse` (`adresse_id`),
  KEY `idx_notfallkontakt_patient` (`patient_id`),
  KEY `fk_nk_geschlecht` (`geschlecht_id`),
  KEY `fk_nk_anrede` (`anrede_id`),
  KEY `fk_nk_beziehungsart` (`beziehungsart_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_nk_adresse` FOREIGN KEY (`adresse_id`) REFERENCES `adresse` (`adresse_id`),
  CONSTRAINT `fk_nk_anrede` FOREIGN KEY (`anrede_id`) REFERENCES `anrede` (`anrede_id`),
  CONSTRAINT `fk_nk_beziehungsart` FOREIGN KEY (`beziehungsart_id`) REFERENCES `beziehungsart` (`beziehungsart_id`),
  CONSTRAINT `fk_nk_geschlecht` FOREIGN KEY (`geschlecht_id`) REFERENCES `geschlecht` (`geschlecht_id`),
  CONSTRAINT `fk_notfallkontakt_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `notfallkontakt_ibfk_1` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `notfallkontakt_ibfk_2` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`)
);

CREATE TABLE `patienten_adresse` (
  `zuordnung_id` char(36) NOT NULL DEFAULT (UUID()),
  `patient_id` char(36) NOT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `adresse_id` char(36) NOT NULL,
  `adressart_id` char(36) NOT NULL,
  `gueltig_von` date NOT NULL,
  `gueltig_bis` date DEFAULT NULL,
  PRIMARY KEY (`zuordnung_id`),
  UNIQUE KEY `uq_patient_adresse_zeit` (`patient_id`,`adresse_id`,`adressart_id`,`gueltig_von`),
  KEY `idx_patienten_adresse_patient` (`patient_id`),
  KEY `fk_patienten_adresse_adresse` (`adresse_id`),
  KEY `fk_patienten_adresse_art` (`adressart_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_patienten_adresse_adresse` FOREIGN KEY (`adresse_id`) REFERENCES `adresse` (`adresse_id`),
  CONSTRAINT `fk_patienten_adresse_art` FOREIGN KEY (`adressart_id`) REFERENCES `adressart` (`adressart_id`),
  CONSTRAINT `fk_patienten_adresse_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `patienten_adresse_ibfk_1` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `patienten_adresse_ibfk_2` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `chk_patienten_adresse_gueltigkeit` CHECK (((`gueltig_bis` is null) or (`gueltig_bis` >= `gueltig_von`)))
);

CREATE TABLE `termin` (
  `termin_id` char(36) NOT NULL DEFAULT (UUID()),
  `patient_id` char(36) NOT NULL,
  `arzt_user_id` char(36) NOT NULL,
  `beginn` timestamp(6) NOT NULL,
  `ende` timestamp(6) NOT NULL,
  `anlass` varchar(255) DEFAULT NULL,
  `status` enum('geplant','bestaetigt','abgesagt','erledigt','nicht_erschienen') NOT NULL DEFAULT 'geplant',
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`termin_id`),
  UNIQUE KEY `uq_termin_patient` (`termin_id`,`patient_id`),
  KEY `idx_termin_arzt_zeit` (`arzt_user_id`,`beginn`,`ende`),
  KEY `idx_termin_patient_zeit` (`patient_id`,`beginn`,`ende`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_termin_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `termin_ibfk_1` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `termin_ibfk_2` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `termin_ibfk_3` FOREIGN KEY (`arzt_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `chk_termin_zeit` CHECK ((`ende` > `beginn`))
);

CREATE TABLE `behandlungskontakt` (
  `behandlungskontakt_id` char(36) NOT NULL DEFAULT (UUID()),
  `patient_id` char(36) NOT NULL,
  `arzt_user_id` char(36) NOT NULL,
  `termin_id` char(36) DEFAULT NULL,
  `art` varchar(60) NOT NULL,
  `besuchsgrund` text NOT NULL,
  `beginn` timestamp(6) NOT NULL,
  `status` enum('offen','abgeschlossen') NOT NULL DEFAULT 'offen',
  `abschlusszeit` timestamp(6) NULL DEFAULT NULL,
  `abschlussnotiz` text,
  `kontrolle_noetig` tinyint(1) NOT NULL DEFAULT '0',
  `kontrollhinweis` varchar(255) DEFAULT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`behandlungskontakt_id`),
  UNIQUE KEY `uq_kontakt_patient` (`behandlungskontakt_id`,`patient_id`),
  UNIQUE KEY `uq_behandlungskontakt_termin` (`termin_id`),
  KEY `idx_behandlungskontakt_patient` (`patient_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  KEY `arzt_user_id` (`arzt_user_id`),
  KEY `fk_behandlungskontakt_termin_patient` (`termin_id`,`patient_id`),
  CONSTRAINT `behandlungskontakt_ibfk_1` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `behandlungskontakt_ibfk_2` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `behandlungskontakt_ibfk_3` FOREIGN KEY (`arzt_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `fk_behandlungskontakt_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fk_behandlungskontakt_termin` FOREIGN KEY (`termin_id`) REFERENCES `termin` (`termin_id`),
  CONSTRAINT `chk_behandlungskontakt_zeit` CHECK (`abschlusszeit` IS NULL OR `abschlusszeit` >= `beginn`),
  CONSTRAINT `chk_behandlungskontakt_kontrolle` CHECK ((`kontrolle_noetig` in (0,1)))
);

CREATE TABLE `kontakt_beteiligung` (
  `beteiligung_id` char(36) NOT NULL DEFAULT (UUID()),
  `behandlungskontakt_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `beginn` timestamp(6) NOT NULL,
  `ende` timestamp(6) NULL DEFAULT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`beteiligung_id`),
  UNIQUE KEY `uq_kontakt_beteiligung` (`behandlungskontakt_id`,`user_id`,`beginn`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `fk_kontakt_beteiligung_kontakt` FOREIGN KEY (`behandlungskontakt_id`) REFERENCES `behandlungskontakt` (`behandlungskontakt_id`),
  CONSTRAINT `kontakt_beteiligung_ibfk_1` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `kontakt_beteiligung_ibfk_2` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `kontakt_beteiligung_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `chk_kontakt_beteiligung_zeit` CHECK (((`ende` is null) or (`ende` >= `beginn`)))
);

CREATE TABLE `titel` (
  `titel_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(80) NOT NULL,
  PRIMARY KEY (`titel_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`)
);

CREATE TABLE `patient_titel` (
  `zuordnung_id` char(36) NOT NULL DEFAULT (UUID()),
  `patient_id` char(36) NOT NULL,
  `titel_id` char(36) NOT NULL,
  `position` enum('VOR','NACH') NOT NULL,
  `reihenfolge` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`zuordnung_id`),
  UNIQUE KEY `patient_id` (`patient_id`,`titel_id`),
  UNIQUE KEY `uq_patient_titel_reihenfolge` (`patient_id`,`position`,`reihenfolge`),
  KEY `fk_pt_titel` (`titel_id`),
  CONSTRAINT `fk_pt_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fk_pt_titel` FOREIGN KEY (`titel_id`) REFERENCES `titel` (`titel_id`),
  CONSTRAINT `patient_titel_chk_1` CHECK ((`reihenfolge` >= 1))
);

CREATE TABLE `versicherungstraeger` (
  `versicherungstraeger_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(150) NOT NULL,
  `kurzbezeichnung` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`versicherungstraeger_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`)
);

CREATE TABLE `versicherung` (
  `versicherung_id` char(36) NOT NULL DEFAULT (UUID()),
  `patient_id` char(36) NOT NULL,
  `versicherungsnummer` varchar(50) DEFAULT NULL,
  `art` enum('gesetzlich','zusatz') NOT NULL,
  `status` enum('unbekannt','aktiv','inaktiv') NOT NULL DEFAULT 'unbekannt',
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `versicherungstraeger_id` char(36) NOT NULL,
  `gueltig_von` date DEFAULT NULL,
  `gueltig_bis` date DEFAULT NULL,
  PRIMARY KEY (`versicherung_id`),
  UNIQUE KEY `uq_versicherung` (`patient_id`,`art`,`versicherungsnummer`),
  KEY `fk_versicherung_traeger` (`versicherungstraeger_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_versicherung_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fk_versicherung_traeger` FOREIGN KEY (`versicherungstraeger_id`) REFERENCES `versicherungstraeger` (`versicherungstraeger_id`),
  CONSTRAINT `versicherung_ibfk_1` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `versicherung_ibfk_2` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `chk_versicherung_gueltigkeit` CHECK (`gueltig_bis` IS NULL OR `gueltig_von` IS NULL OR `gueltig_bis` >= `gueltig_von`)
);

CREATE TABLE `rechnung` (
  `rechnung_id` CHAR(36) NOT NULL DEFAULT (UUID()),
  `behandlungskontakt_id` CHAR(36) NOT NULL,
  `rechnungsnummer` VARCHAR(30) NOT NULL,
  `rechnungsdatum` DATE NOT NULL,
  `zahlungsstatus` ENUM('offen','bezahlt') NOT NULL DEFAULT 'offen',
  `zahlungsart` ENUM('bar','karte') DEFAULT NULL,
  `bezahlt_am` DATE DEFAULT NULL,
  PRIMARY KEY (`rechnung_id`),
  UNIQUE KEY `uq_rechnungsnummer` (`rechnungsnummer`),
  KEY `fk_rechnung_kontakt` (`behandlungskontakt_id`),
  CONSTRAINT `fk_rechnung_kontakt` FOREIGN KEY (`behandlungskontakt_id`) REFERENCES `behandlungskontakt` (`behandlungskontakt_id`),
  CONSTRAINT `chk_rechnung_zahlung` CHECK
   ((`zahlungsstatus` = 'offen' AND `bezahlt_am` IS NULL) OR
    (`zahlungsstatus` = 'bezahlt' AND `bezahlt_am` IS NOT NULL AND `zahlungsart` IS NOT NULL))
);

CREATE TABLE `rechnungsposition` (
  `position_id` CHAR(36) NOT NULL DEFAULT (UUID()),
  `rechnung_id` CHAR(36) NOT NULL,
  `bezeichnung` VARCHAR(150) NOT NULL,
  `menge` INT NOT NULL DEFAULT 1,
  `einzelpreis` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`position_id`),
  KEY `fk_position_rechnung` (`rechnung_id`),
  CONSTRAINT `fk_position_rechnung` FOREIGN KEY (`rechnung_id`) REFERENCES `rechnung` (`rechnung_id`),
  CONSTRAINT `chk_menge` CHECK (`menge` > 0),
  CONSTRAINT `chk_preis` CHECK (`einzelpreis` >= 0)
);
