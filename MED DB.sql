CREATE DATABASE IF NOT EXISTS `med_db_modell` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `med_db_modell`;

CREATE TABLE `allergen` (
  `allergen_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(150) NOT NULL,
  PRIMARY KEY (`allergen_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`)
);

CREATE TABLE `beobachtung` (
  `beobachtung_id` char(36) NOT NULL DEFAULT (UUID()),
  `patient_id` char(36) NOT NULL,
  `behandlungskontakt_id` char(36) NOT NULL,
  `art` varchar(80) NOT NULL,
  `inhalt` text NOT NULL,
  `methode` varchar(100) DEFAULT NULL,
  `geraet` varchar(100) DEFAULT NULL,
  `koerperstelle` varchar(100) DEFAULT NULL,
  `referenzbereich` varchar(100) DEFAULT NULL,
  `erhoben_am` timestamp(6) NOT NULL,
  `erhoben_von_user_id` char(36) NOT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`beobachtung_id`),
  KEY `patient_id` (`patient_id`),
  KEY `erhoben_von_user_id` (`erhoben_von_user_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  KEY `fk_beobachtung_kontakt_patient` (`behandlungskontakt_id`,`patient_id`),
  CONSTRAINT `beobachtung_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `kis_db_modell`.`patient` (`patient_id`),
  CONSTRAINT `beobachtung_ibfk_3` FOREIGN KEY (`erhoben_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `beobachtung_ibfk_4` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `beobachtung_ibfk_5` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `fk_beobachtung_kontakt` FOREIGN KEY (`behandlungskontakt_id`) REFERENCES `kis_db_modell`.`behandlungskontakt` (`behandlungskontakt_id`)
);

CREATE TABLE `diagnose` (
  `diagnose_id` char(36) NOT NULL DEFAULT (UUID()),
  `behandlungskontakt_id` char(36) NOT NULL,
  `arzt_user_id` char(36) NOT NULL,
  `beschreibung` text NOT NULL,
  `status` enum('verdacht','bestaetigt') NOT NULL,
  `icd10_code` varchar(20) DEFAULT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`diagnose_id`),
  UNIQUE KEY `uq_diagnose` (`behandlungskontakt_id`,`icd10_code`,`status`),
  KEY `arzt_user_id` (`arzt_user_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `diagnose_ibfk_1` FOREIGN KEY (`behandlungskontakt_id`) REFERENCES `kis_db_modell`.`behandlungskontakt` (`behandlungskontakt_id`),
  CONSTRAINT `diagnose_ibfk_2` FOREIGN KEY (`arzt_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `diagnose_ibfk_3` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `diagnose_ibfk_4` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`)
);

CREATE TABLE `diagnose_verlauf` (
  `verlauf_id` char(36) NOT NULL DEFAULT (UUID()),
  `diagnose_id` char(36) NOT NULL,
  `behandlungskontakt_id` char(36) NOT NULL,
  `arzt_user_id` char(36) NOT NULL,
  `verlaufsstatus` enum('unveraendert','verbessert','verschlechtert','abgeheilt','chronisch','widerlegt','unbekannt') NOT NULL,
  `bemerkung` text,
  `dokumentiert_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`verlauf_id`),
  KEY `fk_dv_diagnose` (`diagnose_id`),
  KEY `fk_dv_behandlungskontakt` (`behandlungskontakt_id`),
  KEY `fk_dv_arzt` (`arzt_user_id`),
  KEY `fk_dv_erstellt_von` (`erstellt_von_user_id`),
  CONSTRAINT `fk_dv_arzt` FOREIGN KEY (`arzt_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `fk_dv_behandlungskontakt` FOREIGN KEY (`behandlungskontakt_id`) REFERENCES `kis_db_modell`.`behandlungskontakt` (`behandlungskontakt_id`),
  CONSTRAINT `fk_dv_diagnose` FOREIGN KEY (`diagnose_id`) REFERENCES `diagnose` (`diagnose_id`),
  CONSTRAINT `fk_dv_erstellt_von` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`)
);

CREATE TABLE `einnahmeweg` (
  `einnahmeweg_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(100) NOT NULL,
  PRIMARY KEY (`einnahmeweg_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`)
);

CREATE TABLE `ekg` (
  `ekg_id` char(36) NOT NULL DEFAULT (UUID()),
  `behandlungskontakt_id` char(36) NOT NULL,
  `untersucht_am` timestamp(6) NOT NULL,
  `durchgefuehrt_von_user_id` char(36) NOT NULL,
  `kurve` mediumblob NOT NULL,
  `dateiformat` varchar(60) NOT NULL,
  `beurteilung` text,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`ekg_id`),
  KEY `behandlungskontakt_id` (`behandlungskontakt_id`),
  KEY `durchgefuehrt_von_user_id` (`durchgefuehrt_von_user_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `ekg_ibfk_1` FOREIGN KEY (`behandlungskontakt_id`) REFERENCES `kis_db_modell`.`behandlungskontakt` (`behandlungskontakt_id`),
  CONSTRAINT `ekg_ibfk_2` FOREIGN KEY (`durchgefuehrt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `ekg_ibfk_3` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `ekg_ibfk_4` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`)
);

CREATE TABLE `fachrichtung` (
  `fachrichtung_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(150) NOT NULL,
  PRIMARY KEY (`fachrichtung_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`)
);

CREATE TABLE `laboruntersuchungsart` (
  `laboruntersuchungsart_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(150) NOT NULL,
  `beschreibung` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`laboruntersuchungsart_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`)
);

CREATE TABLE `masseinheit` (
  `masseinheit_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(100) NOT NULL,
  `kuerzel` varchar(30) NOT NULL,
  PRIMARY KEY (`masseinheit_id`),
  UNIQUE KEY `kuerzel` (`kuerzel`)
);

CREATE TABLE `medikament` (
  `medikament_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(200) NOT NULL,
  `wirkstoff` varchar(200) DEFAULT NULL,
  `wirkstaerke` varchar(100) DEFAULT NULL,
  `darreichungsform` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`medikament_id`)
);

CREATE TABLE `medizinische_massnahme` (
  `massnahme_id` char(36) NOT NULL DEFAULT (UUID()),
  `behandlungskontakt_id` char(36) NOT NULL,
  `arzt_user_id` char(36) NOT NULL,
  `art` enum('Therapie','Verordnung','Ueberweisung','Laborauftrag') NOT NULL,
  `beschreibung` text NOT NULL,
  `status` enum('entwurf','freigegeben','versendet','abgeschlossen','storniert','fehler') NOT NULL DEFAULT 'entwurf',
  `freigegeben_von_user_id` char(36) DEFAULT NULL,
  `freigegeben_am` timestamp(6) NULL DEFAULT NULL,
  `versendet_am` timestamp(6) NULL DEFAULT NULL,
  `externes_system` varchar(100) DEFAULT NULL,
  `externe_kennung` varchar(120) DEFAULT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`massnahme_id`),
  UNIQUE KEY `uq_massnahme_extern` (`externes_system`,`externe_kennung`),
  KEY `behandlungskontakt_id` (`behandlungskontakt_id`),
  KEY `arzt_user_id` (`arzt_user_id`),
  KEY `freigegeben_von_user_id` (`freigegeben_von_user_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `medizinische_massnahme_ibfk_1` FOREIGN KEY (`behandlungskontakt_id`) REFERENCES `kis_db_modell`.`behandlungskontakt` (`behandlungskontakt_id`),
  CONSTRAINT `medizinische_massnahme_ibfk_2` FOREIGN KEY (`arzt_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `medizinische_massnahme_ibfk_3` FOREIGN KEY (`freigegeben_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `medizinische_massnahme_ibfk_4` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `medizinische_massnahme_ibfk_5` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `chk_massnahme_zeit` CHECK (`versendet_am` IS NULL OR `freigegeben_am` IS NULL OR `versendet_am` >= `freigegeben_am`)
);

CREATE TABLE `befundbericht` (
  `befund_id` char(36) NOT NULL DEFAULT (UUID()),
  `patient_id` char(36) NOT NULL,
  `behandlungskontakt_id` char(36) DEFAULT NULL,
  `massnahme_id` char(36) DEFAULT NULL,
  `quelle` varchar(150) NOT NULL,
  `externe_kennung` varchar(120) DEFAULT NULL,
  `externer_autor` varchar(150) DEFAULT NULL,
  `befundzeit` timestamp(6) NULL DEFAULT NULL,
  `eingangszeit` timestamp(6) NOT NULL,
  `inhalt` text NOT NULL,
  `pruefstatus` enum('offen','geprueft') NOT NULL DEFAULT 'offen',
  `geprueft_von_user_id` char(36) DEFAULT NULL,
  `pruefzeit` timestamp(6) NULL DEFAULT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`befund_id`),
  UNIQUE KEY `uq_befund_extern` (`quelle`,`externe_kennung`),
  KEY `idx_befund_massnahme` (`massnahme_id`),
  KEY `patient_id` (`patient_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  KEY `geprueft_von_user_id` (`geprueft_von_user_id`),
  KEY `fk_befund_kontakt_patient` (`behandlungskontakt_id`,`patient_id`),
  CONSTRAINT `befundbericht_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `kis_db_modell`.`patient` (`patient_id`),
  CONSTRAINT `befundbericht_ibfk_3` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `befundbericht_ibfk_4` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `befundbericht_ibfk_5` FOREIGN KEY (`geprueft_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `fk_befund_kontakt` FOREIGN KEY (`behandlungskontakt_id`) REFERENCES `kis_db_modell`.`behandlungskontakt` (`behandlungskontakt_id`),
  CONSTRAINT `fk_befund_massnahme` FOREIGN KEY (`massnahme_id`) REFERENCES `medizinische_massnahme` (`massnahme_id`)
);

CREATE TABLE `dokumentationsversion` (
  `version_id` char(36) NOT NULL DEFAULT (UUID()),
  `beobachtung_id` char(36) DEFAULT NULL,
  `befund_id` char(36) DEFAULT NULL,
  `ekg_id` char(36) DEFAULT NULL,
  `versionsnummer` int NOT NULL,
  `inhalt` longtext,
  `aenderungsgrund` text NOT NULL,
  `bearbeitet_von_user_id` char(36) NOT NULL,
  `gespeichert_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`version_id`),
  UNIQUE KEY `beobachtung_id` (`beobachtung_id`,`versionsnummer`),
  UNIQUE KEY `befund_id` (`befund_id`,`versionsnummer`),
  UNIQUE KEY `ekg_id` (`ekg_id`,`versionsnummer`),
  KEY `bearbeitet_von_user_id` (`bearbeitet_von_user_id`),
  CONSTRAINT `dokumentationsversion_ibfk_1` FOREIGN KEY (`beobachtung_id`) REFERENCES `beobachtung` (`beobachtung_id`),
  CONSTRAINT `dokumentationsversion_ibfk_2` FOREIGN KEY (`befund_id`) REFERENCES `befundbericht` (`befund_id`),
  CONSTRAINT `dokumentationsversion_ibfk_3` FOREIGN KEY (`ekg_id`) REFERENCES `ekg` (`ekg_id`),
  CONSTRAINT `dokumentationsversion_ibfk_4` FOREIGN KEY (`bearbeitet_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `dokumentationsversion_chk_1` CHECK ((`versionsnummer` >= 1))
);

CREATE TABLE `laborauftrag` (
  `laborauftrag_id` char(36) NOT NULL DEFAULT (UUID()),
  `massnahme_id` char(36) NOT NULL,
  `untersuchung` varchar(150) DEFAULT NULL,
  `fragestellung` text,
  `prioritaet` varchar(50) DEFAULT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`laborauftrag_id`),
  UNIQUE KEY `uq_laborauftrag_massnahme` (`massnahme_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_laborauftrag_massnahme` FOREIGN KEY (`massnahme_id`) REFERENCES `medizinische_massnahme` (`massnahme_id`),
  CONSTRAINT `laborauftrag_ibfk_1` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `laborauftrag_ibfk_2` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`)
);

CREATE TABLE `laborwert` (
  `laborwert_id` char(36) NOT NULL DEFAULT (UUID()),
  `befund_id` char(36) NOT NULL,
  `wert` varchar(80) NOT NULL,
  `referenzbereich` varchar(80) DEFAULT NULL,
  `bewertung` varchar(50) DEFAULT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `laboruntersuchungsart_id` char(36) NOT NULL,
  `masseinheit_id` char(36) DEFAULT NULL,
  PRIMARY KEY (`laborwert_id`),
  KEY `idx_laborwert_befund` (`befund_id`),
  KEY `fk_laborwert_untersuchungsart` (`laboruntersuchungsart_id`),
  KEY `fk_laborwert_masseinheit` (`masseinheit_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_laborwert_befund` FOREIGN KEY (`befund_id`) REFERENCES `befundbericht` (`befund_id`),
  CONSTRAINT `fk_laborwert_masseinheit` FOREIGN KEY (`masseinheit_id`) REFERENCES `masseinheit` (`masseinheit_id`),
  CONSTRAINT `fk_laborwert_untersuchungsart` FOREIGN KEY (`laboruntersuchungsart_id`) REFERENCES `laboruntersuchungsart` (`laboruntersuchungsart_id`),
  CONSTRAINT `laborwert_ibfk_1` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `laborwert_ibfk_2` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`)
);

CREATE TABLE `medizinischer_stammeintrag` (
  `eintrag_id` char(36) NOT NULL DEFAULT (UUID()),
  `patient_id` char(36) NOT NULL,
  `art` varchar(80) NOT NULL,
  `kenntnisstand` enum('bekannt','unbekannt','nicht_erhoben','nicht_zutreffend') NOT NULL,
  `inhalt` text,
  `quelle` varchar(150) NOT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`eintrag_id`),
  KEY `patient_id` (`patient_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `medizinischer_stammeintrag_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `kis_db_modell`.`patient` (`patient_id`),
  CONSTRAINT `medizinischer_stammeintrag_ibfk_2` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `medizinischer_stammeintrag_ibfk_3` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`)
);

CREATE TABLE `patient_allergie` (
  `patient_allergie_id` char(36) NOT NULL DEFAULT (UUID()),
  `patient_id` char(36) NOT NULL,
  `allergen_id` char(36) NOT NULL,
  `reaktion` text,
  `schweregrad` enum('leicht','mittel','schwer','unbekannt') NOT NULL DEFAULT 'unbekannt',
  `status` enum('vermutet','bestaetigt','widerlegt') NOT NULL DEFAULT 'vermutet',
  `gueltig_von` date NOT NULL,
  `gueltig_bis` date DEFAULT NULL,
  `bemerkung` text,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`patient_allergie_id`),
  UNIQUE KEY `patient_id` (`patient_id`,`allergen_id`,`gueltig_von`),
  KEY `fk_allergie_allergen` (`allergen_id`),
  KEY `fk_allergie_erstellt_von` (`erstellt_von_user_id`),
  KEY `fk_allergie_aktualisiert_von` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_allergie_aktualisiert_von` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `fk_allergie_allergen` FOREIGN KEY (`allergen_id`) REFERENCES `allergen` (`allergen_id`),
  CONSTRAINT `fk_allergie_erstellt_von` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `fk_allergie_patient` FOREIGN KEY (`patient_id`) REFERENCES `kis_db_modell`.`patient` (`patient_id`),
  CONSTRAINT `chk_allergie_gueltigkeit` CHECK (((`gueltig_bis` is null) or (`gueltig_bis` >= `gueltig_von`)))
);

CREATE TABLE `ueberweisung` (
  `ueberweisung_id` char(36) NOT NULL DEFAULT (UUID()),
  `massnahme_id` char(36) NOT NULL,
  `fragestellung` text,
  `dringlichkeit` varchar(50) DEFAULT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `fachrichtung_id` char(36) DEFAULT NULL,
  PRIMARY KEY (`ueberweisung_id`),
  UNIQUE KEY `uq_ueberweisung_massnahme` (`massnahme_id`),
  KEY `fk_ueberweisung_fachrichtung` (`fachrichtung_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_ueberweisung_fachrichtung` FOREIGN KEY (`fachrichtung_id`) REFERENCES `fachrichtung` (`fachrichtung_id`),
  CONSTRAINT `fk_ueberweisung_massnahme` FOREIGN KEY (`massnahme_id`) REFERENCES `medizinische_massnahme` (`massnahme_id`),
  CONSTRAINT `ueberweisung_ibfk_1` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `ueberweisung_ibfk_2` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`)
);

CREATE TABLE `verordnung` (
  `verordnung_id` char(36) NOT NULL DEFAULT (UUID()),
  `massnahme_id` char(36) NOT NULL,
  `dosis` decimal(10,3) DEFAULT NULL,
  `haeufigkeit` varchar(100) DEFAULT NULL,
  `hinweise` text,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `medikament_id` char(36) DEFAULT NULL,
  `einnahmeweg_id` char(36) DEFAULT NULL,
  `dosiseinheit_id` char(36) DEFAULT NULL,
  `einnahmebeginn` date DEFAULT NULL,
  `einnahmeende` date DEFAULT NULL,
  `ist_dauermedikation` tinyint(1) NOT NULL DEFAULT '0',
  `absetzgrund` text,
  `medikationsstatus` enum('geplant','laufend','beendet','abgesetzt') NOT NULL DEFAULT 'geplant',
  PRIMARY KEY (`verordnung_id`),
  UNIQUE KEY `uq_verordnung_massnahme` (`massnahme_id`),
  KEY `fk_verordnung_medikament` (`medikament_id`),
  KEY `fk_verordnung_einnahmeweg` (`einnahmeweg_id`),
  KEY `fk_verordnung_dosiseinheit` (`dosiseinheit_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_verordnung_dosiseinheit` FOREIGN KEY (`dosiseinheit_id`) REFERENCES `masseinheit` (`masseinheit_id`),
  CONSTRAINT `fk_verordnung_einnahmeweg` FOREIGN KEY (`einnahmeweg_id`) REFERENCES `einnahmeweg` (`einnahmeweg_id`),
  CONSTRAINT `fk_verordnung_massnahme` FOREIGN KEY (`massnahme_id`) REFERENCES `medizinische_massnahme` (`massnahme_id`),
  CONSTRAINT `fk_verordnung_medikament` FOREIGN KEY (`medikament_id`) REFERENCES `medikament` (`medikament_id`),
  CONSTRAINT `verordnung_ibfk_1` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `verordnung_ibfk_2` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `chk_verordnung_dauermedikation` CHECK ((`ist_dauermedikation` in (0,1))),
  CONSTRAINT `chk_verordnung_dosis` CHECK (((`dosis` is null) or (`dosis` > 0))),
  CONSTRAINT `chk_verordnung_einnahmezeit` CHECK (((`einnahmeende` is null) or (`einnahmebeginn` is null) or (`einnahmeende` >= `einnahmebeginn`)))
);

CREATE TABLE `vitalwerte_messrunde` (
  `messrunde_id` char(36) NOT NULL DEFAULT (UUID()),
  `behandlungskontakt_id` char(36) NOT NULL,
  `erhoben_am` timestamp(6) NOT NULL,
  `erhoben_von_user_id` char(36) NOT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`messrunde_id`),
  UNIQUE KEY `uq_messrunde_kontakt_zeit` (`behandlungskontakt_id`,`erhoben_am`),
  KEY `erhoben_von_user_id` (`erhoben_von_user_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `vitalwerte_messrunde_ibfk_1` FOREIGN KEY (`behandlungskontakt_id`) REFERENCES `kis_db_modell`.`behandlungskontakt` (`behandlungskontakt_id`),
  CONSTRAINT `vitalwerte_messrunde_ibfk_2` FOREIGN KEY (`erhoben_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `vitalwerte_messrunde_ibfk_3` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `vitalwerte_messrunde_ibfk_4` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`)
);

CREATE TABLE `vitalwerttyp` (
  `vitalwerttyp_id` char(36) NOT NULL DEFAULT (UUID()),
  `bezeichnung` varchar(100) NOT NULL,
  `masseinheit_id` char(36) NOT NULL,
  PRIMARY KEY (`vitalwerttyp_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`),
  KEY `fk_vitalwerttyp_einheit` (`masseinheit_id`),
  CONSTRAINT `fk_vitalwerttyp_einheit` FOREIGN KEY (`masseinheit_id`) REFERENCES `masseinheit` (`masseinheit_id`)
);

CREATE TABLE `vitalwert_beobachtung` (
  `einzelwert_id` char(36) NOT NULL DEFAULT (UUID()),
  `messrunde_id` char(36) NOT NULL,
  `wert` decimal(9,3) DEFAULT NULL,
  `messstatus` enum('gemessen','nicht_erhoben') NOT NULL DEFAULT 'gemessen',
  `erhoben_am` timestamp(6) NULL DEFAULT NULL,
  `erstellt_von_user_id` char(36) NOT NULL,
  `erstellt_am` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `aktualisiert_von_user_id` char(36) DEFAULT NULL,
  `aktualisiert_am` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `vitalwerttyp_id` char(36) NOT NULL,
  PRIMARY KEY (`einzelwert_id`),
  UNIQUE KEY `uq_vitalwert_messrunde_typ_neu` (`messrunde_id`,`vitalwerttyp_id`),
  KEY `fk_vitalwert_typ` (`vitalwerttyp_id`),
  KEY `erstellt_von_user_id` (`erstellt_von_user_id`),
  KEY `aktualisiert_von_user_id` (`aktualisiert_von_user_id`),
  CONSTRAINT `fk_vitalwert_messrunde` FOREIGN KEY (`messrunde_id`) REFERENCES `vitalwerte_messrunde` (`messrunde_id`),
  CONSTRAINT `fk_vitalwert_typ` FOREIGN KEY (`vitalwerttyp_id`) REFERENCES `vitalwerttyp` (`vitalwerttyp_id`),
  CONSTRAINT `vitalwert_beobachtung_ibfk_1` FOREIGN KEY (`erstellt_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`),
  CONSTRAINT `vitalwert_beobachtung_ibfk_2` FOREIGN KEY (`aktualisiert_von_user_id`) REFERENCES `user_db_modell`.`app_user` (`user_id`)
);
