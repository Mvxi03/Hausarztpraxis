-- Beispieldaten Hausarztpraxis: USER, KIS und MED
-- Erst nach dem Erstellen der drei Datenbanken ausfuehren.

INSERT INTO `user_db_modell`.`app_user` (`user_id`, `benutzername`, `anzeigename`, `passwort_hash`, `ist_aktiv`, `letzter_login`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('edaf440a-e386-11f1-8f27-bfcfcfa0b3a1','test_admin','Test Administrator','TEST_KEIN_LOGIN',1,NULL,NULL,'2026-11-18 19:33:27.800390',NULL,NULL),
('edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','test_arzt','Dr. Thomas Muster','TEST_KEIN_LOGIN',1,NULL,NULL,'2026-11-18 19:33:27.800390',NULL,NULL),
('edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','test_assistenz','Anna Muster','TEST_KEIN_LOGIN',1,NULL,NULL,'2026-11-18 19:33:27.800390',NULL,NULL);

INSERT INTO `user_db_modell`.`audit_log` (`log_id`, `bearbeitet_von_user_id`, `instanz`, `tabelle`, `datensatz_id`, `feld`, `aktion`, `alter_wert`, `neuer_wert`, `geaendert_am`, `vorgang_id`, `aenderungsgrund`) VALUES
('b85ae1ef-e414-11f1-8f27-bfcfcfa0b3a1','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','KIS','patient','5a8ca2e4-e387-11f1-8f27-bfcfcfa0b3a1','datensatz','INSERT',NULL,'Patient angelegt','2026-11-19 12:28:26.863628','b85ae1df-e414-11f1-8f27-bfcfcfa0b3a1',NULL);

INSERT INTO `user_db_modell`.`berechtigung` (`berechtigung_id`, `code`, `beschreibung`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('edb21bda-e386-11f1-8f27-bfcfcfa0b3a1','USER_VERWALTEN','Benutzer verwalten',NULL,'2026-11-18 19:33:27.818841',NULL,NULL),
('edb2214a-e386-11f1-8f27-bfcfcfa0b3a1','PATIENT_LESEN','Patientendaten lesen',NULL,'2026-11-18 19:33:27.818841',NULL,NULL),
('edb22222-e386-11f1-8f27-bfcfcfa0b3a1','PATIENT_BEARBEITEN','Patientendaten bearbeiten',NULL,'2026-11-18 19:33:27.818841',NULL,NULL),
('edb23060-e386-11f1-8f27-bfcfcfa0b3a1','TERMIN_VERWALTEN','Termine verwalten',NULL,'2026-11-18 19:33:27.818841',NULL,NULL),
('edb23199-e386-11f1-8f27-bfcfcfa0b3a1','MED_LESEN','Medizinische Daten lesen',NULL,'2026-11-18 19:33:27.818841',NULL,NULL),
('edb23229-e386-11f1-8f27-bfcfcfa0b3a1','VITALWERTE_ERFASSEN','Vitalwerte erfassen',NULL,'2026-11-18 19:33:27.818841',NULL,NULL),
('edb232a6-e386-11f1-8f27-bfcfcfa0b3a1','MED_BEARBEITEN','Medizinische Daten bearbeiten',NULL,'2026-11-18 19:33:27.818841',NULL,NULL),
('edb23322-e386-11f1-8f27-bfcfcfa0b3a1','MASSNAHME_FREIGEBEN','Medizinische Maßnahmen freigeben',NULL,'2026-11-18 19:33:27.818841',NULL,NULL);

INSERT INTO `user_db_modell`.`rolle` (`rolle_id`, `code`, `beschreibung`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('edb17596-e386-11f1-8f27-bfcfcfa0b3a1','ADMIN','Administrator',NULL,'2026-11-18 19:33:27.814713',NULL,NULL),
('edb17b2e-e386-11f1-8f27-bfcfcfa0b3a1','ARZT','Hausarzt',NULL,'2026-11-18 19:33:27.814713',NULL,NULL),
('edb17c12-e386-11f1-8f27-bfcfcfa0b3a1','ASSISTENZ','Ordinationsassistenz',NULL,'2026-11-18 19:33:27.814713',NULL,NULL);

INSERT INTO `user_db_modell`.`benutzer_rolle` (`zuordnung_id`, `user_id`, `rolle_id`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('1ea1e6b1-e387-11f1-8f27-bfcfcfa0b3a1','edaf440a-e386-11f1-8f27-bfcfcfa0b3a1','edb17596-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.893236',NULL,NULL),
('1ea1eec4-e387-11f1-8f27-bfcfcfa0b3a1','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','edb17b2e-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.893236',NULL,NULL),
('1ea1f030-e387-11f1-8f27-bfcfcfa0b3a1','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','edb17c12-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.893236',NULL,NULL);

INSERT INTO `user_db_modell`.`rolle_berechtigung` (`zuordnung_id`, `rolle_id`, `berechtigung_id`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('1ea76bd4-e387-11f1-8f27-bfcfcfa0b3a1','edb17b2e-e386-11f1-8f27-bfcfcfa0b3a1','edb23322-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.957017',NULL,NULL),
('1ea77443-e387-11f1-8f27-bfcfcfa0b3a1','edb17b2e-e386-11f1-8f27-bfcfcfa0b3a1','edb232a6-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.957017',NULL,NULL),
('1ea7759f-e387-11f1-8f27-bfcfcfa0b3a1','edb17b2e-e386-11f1-8f27-bfcfcfa0b3a1','edb23199-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.957017',NULL,NULL),
('1ea7766d-e387-11f1-8f27-bfcfcfa0b3a1','edb17c12-e386-11f1-8f27-bfcfcfa0b3a1','edb22222-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.957017',NULL,NULL),
('1ea77725-e387-11f1-8f27-bfcfcfa0b3a1','edb17b2e-e386-11f1-8f27-bfcfcfa0b3a1','edb22222-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.957017',NULL,NULL),
('1ea777f0-e387-11f1-8f27-bfcfcfa0b3a1','edb17c12-e386-11f1-8f27-bfcfcfa0b3a1','edb2214a-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.957017',NULL,NULL),
('1ea78a77-e387-11f1-8f27-bfcfcfa0b3a1','edb17b2e-e386-11f1-8f27-bfcfcfa0b3a1','edb2214a-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.957017',NULL,NULL),
('1ea78c53-e387-11f1-8f27-bfcfcfa0b3a1','edb17c12-e386-11f1-8f27-bfcfcfa0b3a1','edb23060-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.957017',NULL,NULL),
('1ea78d57-e387-11f1-8f27-bfcfcfa0b3a1','edb17b2e-e386-11f1-8f27-bfcfcfa0b3a1','edb23060-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.957017',NULL,NULL),
('1ea78e26-e387-11f1-8f27-bfcfcfa0b3a1','edb17596-e386-11f1-8f27-bfcfcfa0b3a1','edb21bda-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.957017',NULL,NULL),
('1ea78edf-e387-11f1-8f27-bfcfcfa0b3a1','edb17c12-e386-11f1-8f27-bfcfcfa0b3a1','edb23229-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.957017',NULL,NULL),
('1ea78fab-e387-11f1-8f27-bfcfcfa0b3a1','edb17b2e-e386-11f1-8f27-bfcfcfa0b3a1','edb23229-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'2026-11-18 19:34:49.957017',NULL,NULL);

INSERT INTO `kis_db_modell`.`adressart` (`adressart_id`, `bezeichnung`) VALUES
('9d01e213-e36d-11f1-8f27-bfcfcfa0b3a1','Hauptwohnsitz'),
('9d01e5b8-e36d-11f1-8f27-bfcfcfa0b3a1','Nebenwohnsitz'),
('9d01e65d-e36d-11f1-8f27-bfcfcfa0b3a1','Postanschrift'),
('9d01e6e9-e36d-11f1-8f27-bfcfcfa0b3a1','Sonstige Adresse'),
('9d01e6a7-e36d-11f1-8f27-bfcfcfa0b3a1','Vorübergehender Wohnsitz');

INSERT INTO `kis_db_modell`.`anrede` (`anrede_id`, `bezeichnung`) VALUES
('9cffe33a-e36d-11f1-8f27-bfcfcfa0b3a1','Frau'),
('9cffe004-e36d-11f1-8f27-bfcfcfa0b3a1','Herr'),
('9cffe3b4-e36d-11f1-8f27-bfcfcfa0b3a1','Neutrale Anrede');

INSERT INTO `kis_db_modell`.`beziehungsart` (`beziehungsart_id`, `bezeichnung`) VALUES
('9d015738-e36d-11f1-8f27-bfcfcfa0b3a1','Bruder'),
('9d015784-e36d-11f1-8f27-bfcfcfa0b3a1','Ehepartner/in'),
('9d0158b5-e36d-11f1-8f27-bfcfcfa0b3a1','Freund/in'),
('9d015913-e36d-11f1-8f27-bfcfcfa0b3a1','Gesetzliche Vertretung'),
('9d015825-e36d-11f1-8f27-bfcfcfa0b3a1','Großmutter'),
('9d015870-e36d-11f1-8f27-bfcfcfa0b3a1','Großvater'),
('9d0157c7-e36d-11f1-8f27-bfcfcfa0b3a1','Lebenspartner/in'),
('9d0151db-e36d-11f1-8f27-bfcfcfa0b3a1','Mutter'),
('9d0156f2-e36d-11f1-8f27-bfcfcfa0b3a1','Schwester'),
('9d0156a3-e36d-11f1-8f27-bfcfcfa0b3a1','Sohn'),
('9d015958-e36d-11f1-8f27-bfcfcfa0b3a1','Sonstige Bezugsperson'),
('9d015650-e36d-11f1-8f27-bfcfcfa0b3a1','Tochter'),
('9d015587-e36d-11f1-8f27-bfcfcfa0b3a1','Vater');

INSERT INTO `kis_db_modell`.`beziehungsstatus` (`beziehungsstatus_id`, `bezeichnung`) VALUES
('9cfee5ea-e36d-11f1-8f27-bfcfcfa0b3a1','Eingetragene Partnerschaft'),
('9cfee54e-e36d-11f1-8f27-bfcfcfa0b3a1','Geschieden'),
('9cfee630-e36d-11f1-8f27-bfcfcfa0b3a1','In Partnerschaft'),
('9cfed9d3-e36d-11f1-8f27-bfcfcfa0b3a1','Ledig'),
('9cfee313-e36d-11f1-8f27-bfcfcfa0b3a1','Verheiratet'),
('9cfee59e-e36d-11f1-8f27-bfcfcfa0b3a1','Verwitwet');

INSERT INTO `kis_db_modell`.`geschlecht` (`geschlecht_id`, `bezeichnung`) VALUES
('9cfe733b-e36d-11f1-8f27-bfcfcfa0b3a1','Divers'),
('9cfe737d-e36d-11f1-8f27-bfcfcfa0b3a1','Keine Angabe'),
('9cfe72a7-e36d-11f1-8f27-bfcfcfa0b3a1','Männlich'),
('9cfe6f5a-e36d-11f1-8f27-bfcfcfa0b3a1','Weiblich');

INSERT INTO `kis_db_modell`.`kontaktart` (`kontaktart_id`, `bezeichnung`) VALUES
('9d00d9e8-e36d-11f1-8f27-bfcfcfa0b3a1','E-Mail'),
('9d00da91-e36d-11f1-8f27-bfcfcfa0b3a1','Post'),
('9d00dad8-e36d-11f1-8f27-bfcfcfa0b3a1','SMS'),
('9d00d6ec-e36d-11f1-8f27-bfcfcfa0b3a1','Telefon');

INSERT INTO `kis_db_modell`.`patient` (`patient_id`, `vorname`, `weitere_vornamen`, `nachname`, `geburtsdatum`, `pronomen`, `sozialversicherungsnummer`, `telefon`, `email`, `hausarzt_user_id`, `ist_aktiv`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`, `religion_id`, `geschlecht_id`, `beziehungsstatus_id`, `anrede_id`, `kontaktart_id`, `staat_id`) VALUES
('5a8ca2e4-e387-11f1-8f27-bfcfcfa0b3a1','Max',NULL,'Mustermann','1980-05-12',NULL,NULL,NULL,NULL,'edafaca9-e386-11f1-8f27-bfcfcfa0b3a1',1,'edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:36:30.429130',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('5a8cb736-e387-11f1-8f27-bfcfcfa0b3a1','Lena',NULL,'Musterfrau','1995-08-23',NULL,NULL,NULL,NULL,'edafaca9-e386-11f1-8f27-bfcfcfa0b3a1',1,'edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:36:30.429130',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('5a8cb9e0-e387-11f1-8f27-bfcfcfa0b3a1','Peter',NULL,'Beispiel','1965-03-17',NULL,NULL,NULL,NULL,'edafaca9-e386-11f1-8f27-bfcfcfa0b3a1',0,'edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:36:30.429130',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO `kis_db_modell`.`religion` (`religion_id`, `bezeichnung`) VALUES
('9cfcff04-e36d-11f1-8f27-bfcfcfa0b3a1','Buddhismus'),
('9cfcfd7e-e36d-11f1-8f27-bfcfcfa0b3a1','Evangelisch'),
('9cfcff47-e36d-11f1-8f27-bfcfcfa0b3a1','Hinduismus'),
('9cfcfe74-e36d-11f1-8f27-bfcfcfa0b3a1','Islam'),
('9cfcfebb-e36d-11f1-8f27-bfcfcfa0b3a1','Judentum'),
('9cfcff8b-e36d-11f1-8f27-bfcfcfa0b3a1','Ohne Religionsbekenntnis'),
('9cfcfe27-e36d-11f1-8f27-bfcfcfa0b3a1','Orthodox'),
('9cfcf91c-e36d-11f1-8f27-bfcfcfa0b3a1','Römisch-katholisch'),
('9cfcffd9-e36d-11f1-8f27-bfcfcfa0b3a1','Sonstige');

INSERT INTO `kis_db_modell`.`staat` (`staat_id`, `bezeichnung`, `iso_code`) VALUES
('f2bd2dd6-e36b-11f1-8f27-bfcfcfa0b3a1','Österreich','AT'),
('f2bdaabc-e36b-11f1-8f27-bfcfcfa0b3a1','Deutschland','DE'),
('f2bdaf1c-e36b-11f1-8f27-bfcfcfa0b3a1','Italien','IT'),
('f2bdb029-e36b-11f1-8f27-bfcfcfa0b3a1','Schweiz','CH'),
('f2bdb26a-e36b-11f1-8f27-bfcfcfa0b3a1','Slowenien','SI'),
('f2bdb332-e36b-11f1-8f27-bfcfcfa0b3a1','Ungarn','HU'),
('f2bdb3f2-e36b-11f1-8f27-bfcfcfa0b3a1','Kroatien','HR'),
('f2bdb5fb-e36b-11f1-8f27-bfcfcfa0b3a1','Slowakei','SK'),
('f2bdb6f2-e36b-11f1-8f27-bfcfcfa0b3a1','Tschechien','CZ'),
('f2bdb78f-e36b-11f1-8f27-bfcfcfa0b3a1','Liechtenstein','LI');

INSERT INTO `kis_db_modell`.`region` (`region_id`, `staat_id`, `bezeichnung`) VALUES
('f2be8191-e36b-11f1-8f27-bfcfcfa0b3a1','f2bd2dd6-e36b-11f1-8f27-bfcfcfa0b3a1','Burgenland'),
('f2bea1d5-e36b-11f1-8f27-bfcfcfa0b3a1','f2bd2dd6-e36b-11f1-8f27-bfcfcfa0b3a1','Kärnten'),
('f2bea952-e36b-11f1-8f27-bfcfcfa0b3a1','f2bd2dd6-e36b-11f1-8f27-bfcfcfa0b3a1','Niederösterreich'),
('f2bea9f9-e36b-11f1-8f27-bfcfcfa0b3a1','f2bd2dd6-e36b-11f1-8f27-bfcfcfa0b3a1','Oberösterreich'),
('f2beaa87-e36b-11f1-8f27-bfcfcfa0b3a1','f2bd2dd6-e36b-11f1-8f27-bfcfcfa0b3a1','Salzburg'),
('f2beab0a-e36b-11f1-8f27-bfcfcfa0b3a1','f2bd2dd6-e36b-11f1-8f27-bfcfcfa0b3a1','Steiermark'),
('f2beab97-e36b-11f1-8f27-bfcfcfa0b3a1','f2bd2dd6-e36b-11f1-8f27-bfcfcfa0b3a1','Tirol'),
('f2beac0d-e36b-11f1-8f27-bfcfcfa0b3a1','f2bd2dd6-e36b-11f1-8f27-bfcfcfa0b3a1','Vorarlberg'),
('f2beaca3-e36b-11f1-8f27-bfcfcfa0b3a1','f2bd2dd6-e36b-11f1-8f27-bfcfcfa0b3a1','Wien');

INSERT INTO `kis_db_modell`.`adresse` (`adresse_id`, `strasse`, `hausnummer`, `stiege_tuer`, `plz`, `ort`, `bezirk`, `staat_id`, `region_id`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`, `region_freitext`) VALUES
('23fbd4ae-e389-11f1-8f27-bfcfcfa0b3a1','Musterstraße','10',NULL,'9020','Klagenfurt',NULL,'f2bd2dd6-e36b-11f1-8f27-bfcfcfa0b3a1','f2bea1d5-e36b-11f1-8f27-bfcfcfa0b3a1','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:49:17.897462',NULL,NULL,NULL),
('23fbfbc9-e389-11f1-8f27-bfcfcfa0b3a1','Beispielweg','5',NULL,'9500','Villach',NULL,'f2bd2dd6-e36b-11f1-8f27-bfcfcfa0b3a1','f2bea1d5-e36b-11f1-8f27-bfcfcfa0b3a1','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:49:17.897462',NULL,NULL,NULL),
('ac664a4f-e388-11f1-8f27-bfcfcfa0b3a1','Musterstraße','10',NULL,'9020','Klagenfurt',NULL,'f2bd2dd6-e36b-11f1-8f27-bfcfcfa0b3a1','f2bea1d5-e36b-11f1-8f27-bfcfcfa0b3a1','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:45:57.266537',NULL,NULL,NULL),
('ac666a72-e388-11f1-8f27-bfcfcfa0b3a1','Beispielweg','5',NULL,'9500','Villach',NULL,'f2bd2dd6-e36b-11f1-8f27-bfcfcfa0b3a1','f2bea1d5-e36b-11f1-8f27-bfcfcfa0b3a1','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:45:57.266537',NULL,NULL,NULL);

INSERT INTO `kis_db_modell`.`notfallkontakt` (`notfallkontakt_id`, `patient_id`, `titel_vor`, `vorname`, `weitere_vornamen`, `nachname`, `titel_nach`, `geburtsdatum`, `pronomen`, `telefon`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`, `geschlecht_id`, `anrede_id`, `beziehungsart_id`, `adresse_id`) VALUES
('23fc5493-e389-11f1-8f27-bfcfcfa0b3a1','5a8ca2e4-e387-11f1-8f27-bfcfcfa0b3a1',NULL,'Maria',NULL,'Mustermann',NULL,NULL,NULL,'TEST-001','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:49:17.960198',NULL,NULL,NULL,NULL,'9d0156f2-e36d-11f1-8f27-bfcfcfa0b3a1','23fbd4ae-e389-11f1-8f27-bfcfcfa0b3a1'),
('ac668e07-e388-11f1-8f27-bfcfcfa0b3a1','5a8ca2e4-e387-11f1-8f27-bfcfcfa0b3a1',NULL,'Maria',NULL,'Mustermann',NULL,NULL,NULL,'TEST-001','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:45:57.280612',NULL,NULL,NULL,NULL,'9d0156f2-e36d-11f1-8f27-bfcfcfa0b3a1',NULL);

INSERT INTO `kis_db_modell`.`patienten_adresse` (`zuordnung_id`, `patient_id`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`, `adresse_id`, `adressart_id`, `gueltig_von`, `gueltig_bis`) VALUES
('2405845a-e389-11f1-8f27-bfcfcfa0b3a1','5a8ca2e4-e387-11f1-8f27-bfcfcfa0b3a1','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:49:17.956103',NULL,NULL,'23fbd4ae-e389-11f1-8f27-bfcfcfa0b3a1','9d01e213-e36d-11f1-8f27-bfcfcfa0b3a1','2026-01-01',NULL),
('240588fd-e389-11f1-8f27-bfcfcfa0b3a1','5a8cb736-e387-11f1-8f27-bfcfcfa0b3a1','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:49:17.956103',NULL,NULL,'23fbfbc9-e389-11f1-8f27-bfcfcfa0b3a1','9d01e213-e36d-11f1-8f27-bfcfcfa0b3a1','2026-01-01',NULL),
('ac6880c3-e388-11f1-8f27-bfcfcfa0b3a1','5a8ca2e4-e387-11f1-8f27-bfcfcfa0b3a1','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:45:57.278226',NULL,NULL,'ac664a4f-e388-11f1-8f27-bfcfcfa0b3a1','9d01e213-e36d-11f1-8f27-bfcfcfa0b3a1','2026-01-01',NULL),
('ac6889d0-e388-11f1-8f27-bfcfcfa0b3a1','5a8cb736-e387-11f1-8f27-bfcfcfa0b3a1','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:45:57.278226',NULL,NULL,'ac666a72-e388-11f1-8f27-bfcfcfa0b3a1','9d01e213-e36d-11f1-8f27-bfcfcfa0b3a1','2026-01-01',NULL);

INSERT INTO `kis_db_modell`.`termin` (`termin_id`, `patient_id`, `arzt_user_id`, `beginn`, `ende`, `anlass`, `status`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('33e2fac0-e388-11f1-8f27-bfcfcfa0b3a1','5a8ca2e4-e387-11f1-8f27-bfcfcfa0b3a1','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 08:00:00.000000','2026-11-18 08:30:00.000000','Blutdruckkontrolle','erledigt','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:42:35.078949',NULL,NULL),
('33e36094-e388-11f1-8f27-bfcfcfa0b3a1','5a8cb736-e387-11f1-8f27-bfcfcfa0b3a1','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-20 09:00:00.000000','2026-11-20 09:30:00.000000','Kontrolluntersuchung','geplant','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:42:35.078949',NULL,NULL);

INSERT INTO `kis_db_modell`.`behandlungskontakt` (`behandlungskontakt_id`, `patient_id`, `arzt_user_id`, `termin_id`, `art`, `besuchsgrund`, `beginn`, `status`, `abschlusszeit`, `abschlussnotiz`, `kontrolle_noetig`, `kontrollhinweis`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('33e94163-e388-11f1-8f27-bfcfcfa0b3a1','5a8ca2e4-e387-11f1-8f27-bfcfcfa0b3a1','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','33e2fac0-e388-11f1-8f27-bfcfcfa0b3a1','Ordinationsbesuch','Blutdruckkontrolle','2026-11-18 08:00:00.000000','offen',NULL,NULL,0,NULL,'edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:42:35.117543',NULL,NULL),
('33e94727-e388-11f1-8f27-bfcfcfa0b3a1','5a8cb736-e387-11f1-8f27-bfcfcfa0b3a1','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1',NULL,'Ordinationsbesuch','Kopfschmerzen','2026-11-18 09:00:00.000000','offen',NULL,NULL,0,NULL,'edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:42:35.117543',NULL,NULL);

INSERT INTO `kis_db_modell`.`rechnung` (`rechnung_id`, `behandlungskontakt_id`, `rechnungsnummer`, `rechnungsdatum`, `zahlungsstatus`, `zahlungsart`, `bezahlt_am`) VALUES ('11111111-1111-4111-8111-111111111111', '33e94163-e388-11f1-8f27-bfcfcfa0b3a1', 'R-2026-001', '2026-11-18', 'bezahlt', 'bar', '2026-11-18');

INSERT INTO `kis_db_modell`.`rechnungsposition` (`rechnung_id`, `bezeichnung`, `menge`, `einzelpreis`) VALUES ('11111111-1111-4111-8111-111111111111', 'Privatleistung', 1, 30.00);

INSERT INTO `kis_db_modell`.`titel` (`titel_id`, `bezeichnung`) VALUES
('9d0069b0-e36d-11f1-8f27-bfcfcfa0b3a1','BA'),
('9d006a28-e36d-11f1-8f27-bfcfcfa0b3a1','BEd'),
('9d0069eb-e36d-11f1-8f27-bfcfcfa0b3a1','BSc'),
('9d00689d-e36d-11f1-8f27-bfcfcfa0b3a1','Dipl.-Ing.'),
('9d0061be-e36d-11f1-8f27-bfcfcfa0b3a1','Dr.'),
('9d00671f-e36d-11f1-8f27-bfcfcfa0b3a1','Dr. med. univ.'),
('9d0067d4-e36d-11f1-8f27-bfcfcfa0b3a1','Dr. techn.'),
('9d0068e1-e36d-11f1-8f27-bfcfcfa0b3a1','Ing.'),
('9d006b51-e36d-11f1-8f27-bfcfcfa0b3a1','LL.B.'),
('9d006b8c-e36d-11f1-8f27-bfcfcfa0b3a1','LL.M.'),
('9d006a62-e36d-11f1-8f27-bfcfcfa0b3a1','MA'),
('9d00681e-e36d-11f1-8f27-bfcfcfa0b3a1','Mag.'),
('9d00685f-e36d-11f1-8f27-bfcfcfa0b3a1','Mag. (FH)'),
('9d006b17-e36d-11f1-8f27-bfcfcfa0b3a1','MBA'),
('9d006ade-e36d-11f1-8f27-bfcfcfa0b3a1','MEd'),
('9d006aa3-e36d-11f1-8f27-bfcfcfa0b3a1','MSc'),
('9d006bc6-e36d-11f1-8f27-bfcfcfa0b3a1','PhD'),
('9d00691d-e36d-11f1-8f27-bfcfcfa0b3a1','Prof.'),
('9d006970-e36d-11f1-8f27-bfcfcfa0b3a1','Univ.-Prof.');

INSERT INTO `kis_db_modell`.`versicherungstraeger` (`versicherungstraeger_id`, `bezeichnung`, `kurzbezeichnung`) VALUES
('9cff614f-e36d-11f1-8f27-bfcfcfa0b3a1','Österreichische Gesundheitskasse','ÖGK'),
('9cff668e-e36d-11f1-8f27-bfcfcfa0b3a1','Sozialversicherung der Selbständigen','SVS'),
('9cff6744-e36d-11f1-8f27-bfcfcfa0b3a1','Versicherungsanstalt öffentlich Bediensteter, Eisenbahnen und Bergbau','BVAEB'),
('9cff67b2-e36d-11f1-8f27-bfcfcfa0b3a1','Sonstiger Versicherungsträger',NULL);

INSERT INTO `kis_db_modell`.`versicherung` (`versicherung_id`, `patient_id`, `versicherungsnummer`, `art`, `status`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`, `versicherungstraeger_id`, `gueltig_von`, `gueltig_bis`) VALUES
('4d26d950-e389-11f1-8f27-bfcfcfa0b3a1','5a8ca2e4-e387-11f1-8f27-bfcfcfa0b3a1',NULL,'gesetzlich','aktiv','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:50:26.960900',NULL,NULL,'9cff614f-e36d-11f1-8f27-bfcfcfa0b3a1','2026-01-01',NULL),
('4d26e707-e389-11f1-8f27-bfcfcfa0b3a1','5a8cb736-e387-11f1-8f27-bfcfcfa0b3a1',NULL,'gesetzlich','aktiv','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:50:26.960900',NULL,NULL,'9cff668e-e36d-11f1-8f27-bfcfcfa0b3a1','2026-01-01',NULL);

INSERT INTO `med_db_modell`.`allergen` (`allergen_id`, `bezeichnung`) VALUES
('067989e1-e384-11f1-8f27-bfcfcfa0b3a1','Erdnüsse'),
('06798984-e384-11f1-8f27-bfcfcfa0b3a1','Hausstaubmilben'),
('06798aea-e384-11f1-8f27-bfcfcfa0b3a1','Ibuprofen'),
('06798a39-e384-11f1-8f27-bfcfcfa0b3a1','Insektengift'),
('06798a90-e384-11f1-8f27-bfcfcfa0b3a1','Kontrastmittel'),
('06798890-e384-11f1-8f27-bfcfcfa0b3a1','Latex'),
('06798679-e384-11f1-8f27-bfcfcfa0b3a1','Penicillin'),
('0679891f-e384-11f1-8f27-bfcfcfa0b3a1','Pollen');

INSERT INTO `med_db_modell`.`beobachtung` (`beobachtung_id`, `patient_id`, `behandlungskontakt_id`, `art`, `inhalt`, `methode`, `geraet`, `koerperstelle`, `referenzbereich`, `erhoben_am`, `erhoben_von_user_id`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('66b53d00-e414-11f1-8f27-bfcfcfa0b3a1','5a8ca2e4-e387-11f1-8f27-bfcfcfa0b3a1','33e94163-e388-11f1-8f27-bfcfcfa0b3a1','Anamnese','Patient berichtet über gelegentlichen Schwindel.',NULL,NULL,NULL,NULL,'2026-11-18 08:10:00.000000','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-19 12:26:09.983623',NULL,NULL);

INSERT INTO `med_db_modell`.`diagnose` (`diagnose_id`, `behandlungskontakt_id`, `arzt_user_id`, `beschreibung`, `status`, `icd10_code`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('cfd3eba7-e389-11f1-8f27-bfcfcfa0b3a1','33e94163-e388-11f1-8f27-bfcfcfa0b3a1','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','Verdacht auf arterielle Hypertonie','verdacht',NULL,'edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:54:06.198526',NULL,NULL);

INSERT INTO `med_db_modell`.`dokumentationsversion` (`version_id`, `beobachtung_id`, `befund_id`, `ekg_id`, `versionsnummer`, `inhalt`, `aenderungsgrund`, `bearbeitet_von_user_id`, `gespeichert_am`) VALUES
('b85cbb09-e414-11f1-8f27-bfcfcfa0b3a1','66b53d00-e414-11f1-8f27-bfcfcfa0b3a1',NULL,NULL,1,'Patient berichtet über gelegentlichen Schwindel.','Erstdokumentation','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-19 12:28:26.875155');

INSERT INTO `med_db_modell`.`einnahmeweg` (`einnahmeweg_id`, `bezeichnung`) VALUES
('066fa166-e384-11f1-8f27-bfcfcfa0b3a1','Inhalativ'),
('066fa0aa-e384-11f1-8f27-bfcfcfa0b3a1','Intramuskulär'),
('066f9fd1-e384-11f1-8f27-bfcfcfa0b3a1','Intravenös'),
('066f9d53-e384-11f1-8f27-bfcfcfa0b3a1','Oral'),
('066fa1bc-e384-11f1-8f27-bfcfcfa0b3a1','Rektal'),
('066fa10a-e384-11f1-8f27-bfcfcfa0b3a1','Subkutan'),
('066fa268-e384-11f1-8f27-bfcfcfa0b3a1','Sublingual'),
('066fa216-e384-11f1-8f27-bfcfcfa0b3a1','Topisch');

INSERT INTO `med_db_modell`.`ekg` (`ekg_id`, `behandlungskontakt_id`, `untersucht_am`, `durchgefuehrt_von_user_id`, `kurve`, `dateiformat`, `beurteilung`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('948a62eb-e414-11f1-8f27-bfcfcfa0b3a1','33e94163-e388-11f1-8f27-bfcfcfa0b3a1','2026-11-18 08:15:00.000000','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1',_binary '	\n','BIN','Fiktiver EKG-Testdatensatz','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-19 12:27:26.696741',NULL,NULL);

INSERT INTO `med_db_modell`.`fachrichtung` (`fachrichtung_id`, `bezeichnung`) VALUES
('0678d9dc-e384-11f1-8f27-bfcfcfa0b3a1','Augenheilkunde'),
('0678daef-e384-11f1-8f27-bfcfcfa0b3a1','Chirurgie'),
('0678d859-e384-11f1-8f27-bfcfcfa0b3a1','Dermatologie'),
('0678d97d-e384-11f1-8f27-bfcfcfa0b3a1','Gynäkologie'),
('0678da3a-e384-11f1-8f27-bfcfcfa0b3a1','Hals-Nasen-Ohren-Heilkunde'),
('0678d475-e384-11f1-8f27-bfcfcfa0b3a1','Innere Medizin'),
('0678d705-e384-11f1-8f27-bfcfcfa0b3a1','Kardiologie'),
('0678d7f0-e384-11f1-8f27-bfcfcfa0b3a1','Neurologie'),
('0678d8b8-e384-11f1-8f27-bfcfcfa0b3a1','Orthopädie'),
('0678db44-e384-11f1-8f27-bfcfcfa0b3a1','Psychiatrie'),
('0678da97-e384-11f1-8f27-bfcfcfa0b3a1','Radiologie'),
('0678d919-e384-11f1-8f27-bfcfcfa0b3a1','Urologie');

INSERT INTO `med_db_modell`.`laboruntersuchungsart` (`laboruntersuchungsart_id`, `bezeichnung`, `beschreibung`) VALUES
('88fa6615-e383-11f1-8f27-bfcfcfa0b3a1','Hämoglobin',NULL),
('88fa6a10-e383-11f1-8f27-bfcfcfa0b3a1','CRP',NULL),
('88fa6c5e-e383-11f1-8f27-bfcfcfa0b3a1','Glukose',NULL),
('88fa6d02-e383-11f1-8f27-bfcfcfa0b3a1','Kreatinin',NULL),
('88fa6d9e-e383-11f1-8f27-bfcfcfa0b3a1','Leukozyten',NULL);

INSERT INTO `med_db_modell`.`masseinheit` (`masseinheit_id`, `bezeichnung`, `kuerzel`) VALUES
('88ef1cff-e383-11f1-8f27-bfcfcfa0b3a1','Pro Minute','/min'),
('88ef20cf-e383-11f1-8f27-bfcfcfa0b3a1','Grad Celsius','°C'),
('88ef21a8-e383-11f1-8f27-bfcfcfa0b3a1','Prozent','%'),
('88ef21fd-e383-11f1-8f27-bfcfcfa0b3a1','Millimeter Quecksilbersäule','mmHg'),
('88ef2247-e383-11f1-8f27-bfcfcfa0b3a1','Milligramm pro Deziliter','mg/dl'),
('88ef2298-e383-11f1-8f27-bfcfcfa0b3a1','Millimol pro Liter','mmol/l'),
('88ef22ef-e383-11f1-8f27-bfcfcfa0b3a1','Milligramm','mg'),
('88ef2340-e383-11f1-8f27-bfcfcfa0b3a1','Gramm','g'),
('88ef238f-e383-11f1-8f27-bfcfcfa0b3a1','Milliliter','ml'),
('88ef23db-e383-11f1-8f27-bfcfcfa0b3a1','Mikrogramm','µg'),
('88ef2424-e383-11f1-8f27-bfcfcfa0b3a1','Internationale Einheit','IE'),
('88ef246f-e383-11f1-8f27-bfcfcfa0b3a1','Einheiten pro Liter','U/l'),
('88ef24bc-e383-11f1-8f27-bfcfcfa0b3a1','Gramm pro Deziliter','g/dl'),
('88ef2505-e383-11f1-8f27-bfcfcfa0b3a1','Milligramm pro Liter','mg/l'),
('88ef254e-e383-11f1-8f27-bfcfcfa0b3a1','Stück','Stk.'),
('88ef2596-e383-11f1-8f27-bfcfcfa0b3a1','Tropfen','Tr.'),
('88ef25dc-e383-11f1-8f27-bfcfcfa0b3a1','Milliarden pro Liter','10^9/l');

INSERT INTO `med_db_modell`.`medikament` (`medikament_id`, `bezeichnung`, `wirkstoff`, `wirkstaerke`, `darreichungsform`) VALUES
('be4a9ac7-e413-11f1-8f27-bfcfcfa0b3a1','Ramipril','Ramipril','5 mg','Tablette');

INSERT INTO `med_db_modell`.`medizinische_massnahme` (`massnahme_id`, `behandlungskontakt_id`, `arzt_user_id`, `art`, `beschreibung`, `status`, `freigegeben_von_user_id`, `freigegeben_am`, `versendet_am`, `externes_system`, `externe_kennung`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('be4a24da-e413-11f1-8f27-bfcfcfa0b3a1','33e94163-e388-11f1-8f27-bfcfcfa0b3a1','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','Verordnung','Testverordnung','entwurf',NULL,NULL,NULL,NULL,NULL,'edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-19 12:21:27.327761',NULL,NULL),
('be4a4d7a-e413-11f1-8f27-bfcfcfa0b3a1','33e94163-e388-11f1-8f27-bfcfcfa0b3a1','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','Ueberweisung','Kardiologische Abklärung','entwurf',NULL,NULL,NULL,NULL,NULL,'edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-19 12:21:27.327761',NULL,NULL),
('be4a7676-e413-11f1-8f27-bfcfcfa0b3a1','33e94163-e388-11f1-8f27-bfcfcfa0b3a1','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','Laborauftrag','Externe Blutuntersuchung','versendet','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-19 12:26:09.000000','2026-11-19 12:26:09.000000','Testlabor',NULL,'edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-19 12:21:27.327761','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-19 12:26:09.972179');

INSERT INTO `med_db_modell`.`befundbericht` (`befund_id`, `patient_id`, `behandlungskontakt_id`, `massnahme_id`, `quelle`, `externe_kennung`, `externer_autor`, `befundzeit`, `eingangszeit`, `inhalt`, `pruefstatus`, `geprueft_von_user_id`, `pruefzeit`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('66b5069e-e414-11f1-8f27-bfcfcfa0b3a1','5a8ca2e4-e387-11f1-8f27-bfcfcfa0b3a1','33e94163-e388-11f1-8f27-bfcfcfa0b3a1','be4a7676-e413-11f1-8f27-bfcfcfa0b3a1','Externes Testlabor','LAB-TEST-001',NULL,'2026-11-19 12:26:09.000000','2026-11-19 12:26:09.000000','Fiktiver Laborbefund','offen',NULL,NULL,'edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-19 12:26:09.975127',NULL,NULL);

INSERT INTO `med_db_modell`.`laborauftrag` (`laborauftrag_id`, `massnahme_id`, `untersuchung`, `fragestellung`, `prioritaet`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('be538aa1-e413-11f1-8f27-bfcfcfa0b3a1','be4a7676-e413-11f1-8f27-bfcfcfa0b3a1','Blutuntersuchung','Kontrolle der Nierenfunktion','Routine','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-19 12:21:27.384824',NULL,NULL);

INSERT INTO `med_db_modell`.`laborwert` (`laborwert_id`, `befund_id`, `wert`, `referenzbereich`, `bewertung`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`, `laboruntersuchungsart_id`, `masseinheit_id`) VALUES
('66c43169-e414-11f1-8f27-bfcfcfa0b3a1','66b5069e-e414-11f1-8f27-bfcfcfa0b3a1','0.9',NULL,NULL,'edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-19 12:26:09.980127',NULL,NULL,'88fa6d02-e383-11f1-8f27-bfcfcfa0b3a1','88ef2247-e383-11f1-8f27-bfcfcfa0b3a1');

INSERT INTO `med_db_modell`.`patient_allergie` (`patient_allergie_id`, `patient_id`, `allergen_id`, `reaktion`, `schweregrad`, `status`, `gueltig_von`, `gueltig_bis`, `bemerkung`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('66c5da9e-e414-11f1-8f27-bfcfcfa0b3a1','5a8ca2e4-e387-11f1-8f27-bfcfcfa0b3a1','06798679-e384-11f1-8f27-bfcfcfa0b3a1','Hautausschlag','mittel','vermutet','2026-11-18',NULL,NULL,'edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-19 12:26:09.991453',NULL,NULL);

INSERT INTO `med_db_modell`.`ueberweisung` (`ueberweisung_id`, `massnahme_id`, `fragestellung`, `dringlichkeit`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`, `fachrichtung_id`) VALUES
('be52d9d0-e413-11f1-8f27-bfcfcfa0b3a1','be4a4d7a-e413-11f1-8f27-bfcfcfa0b3a1','Abklärung erhöhter Blutdruckwerte','Routine','edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-19 12:21:27.380547',NULL,NULL,'0678d705-e384-11f1-8f27-bfcfcfa0b3a1');

INSERT INTO `med_db_modell`.`verordnung` (`verordnung_id`, `massnahme_id`, `dosis`, `haeufigkeit`, `hinweise`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`, `medikament_id`, `einnahmeweg_id`, `dosiseinheit_id`, `einnahmebeginn`, `einnahmeende`, `ist_dauermedikation`, `absetzgrund`, `medikationsstatus`) VALUES
('be522e73-e413-11f1-8f27-bfcfcfa0b3a1','be4a24da-e413-11f1-8f27-bfcfcfa0b3a1',5.000,'1x täglich',NULL,'edafaca9-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-19 12:21:27.375932',NULL,NULL,'be4a9ac7-e413-11f1-8f27-bfcfcfa0b3a1','066f9d53-e384-11f1-8f27-bfcfcfa0b3a1','88ef22ef-e383-11f1-8f27-bfcfcfa0b3a1',NULL,NULL,0,NULL,'geplant');

INSERT INTO `med_db_modell`.`vitalwerte_messrunde` (`messrunde_id`, `behandlungskontakt_id`, `erhoben_am`, `erhoben_von_user_id`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`) VALUES
('cfd017ca-e389-11f1-8f27-bfcfcfa0b3a1','33e94163-e388-11f1-8f27-bfcfcfa0b3a1','2026-11-18 08:05:00.000000','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:54:06.175477',NULL,NULL);

INSERT INTO `med_db_modell`.`vitalwerttyp` (`vitalwerttyp_id`, `bezeichnung`, `masseinheit_id`) VALUES
('88f96298-e383-11f1-8f27-bfcfcfa0b3a1','Puls','88ef1cff-e383-11f1-8f27-bfcfcfa0b3a1'),
('88f96785-e383-11f1-8f27-bfcfcfa0b3a1','Atemfrequenz','88ef1cff-e383-11f1-8f27-bfcfcfa0b3a1'),
('88f969a8-e383-11f1-8f27-bfcfcfa0b3a1','Körpertemperatur','88ef20cf-e383-11f1-8f27-bfcfcfa0b3a1'),
('88f96b0b-e383-11f1-8f27-bfcfcfa0b3a1','Sauerstoffsättigung','88ef21a8-e383-11f1-8f27-bfcfcfa0b3a1'),
('88f96c36-e383-11f1-8f27-bfcfcfa0b3a1','Blutdruck systolisch','88ef21fd-e383-11f1-8f27-bfcfcfa0b3a1'),
('88f96d5a-e383-11f1-8f27-bfcfcfa0b3a1','Blutdruck diastolisch','88ef21fd-e383-11f1-8f27-bfcfcfa0b3a1'),
('88f96ee1-e383-11f1-8f27-bfcfcfa0b3a1','Blutzucker','88ef2247-e383-11f1-8f27-bfcfcfa0b3a1');

INSERT INTO `med_db_modell`.`vitalwert_beobachtung` (`einzelwert_id`, `messrunde_id`, `wert`, `messstatus`, `erhoben_am`, `erstellt_von_user_id`, `erstellt_am`, `aktualisiert_von_user_id`, `aktualisiert_am`, `vitalwerttyp_id`) VALUES
('cfd225ca-e389-11f1-8f27-bfcfcfa0b3a1','cfd017ca-e389-11f1-8f27-bfcfcfa0b3a1',16.000,'gemessen','2026-11-18 08:05:00.000000','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:54:06.186775',NULL,NULL,'88f96785-e383-11f1-8f27-bfcfcfa0b3a1'),
('cfd247e6-e389-11f1-8f27-bfcfcfa0b3a1','cfd017ca-e389-11f1-8f27-bfcfcfa0b3a1',95.000,'gemessen','2026-11-18 08:05:00.000000','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:54:06.186775',NULL,NULL,'88f96d5a-e383-11f1-8f27-bfcfcfa0b3a1'),
('cfd24a4a-e389-11f1-8f27-bfcfcfa0b3a1','cfd017ca-e389-11f1-8f27-bfcfcfa0b3a1',150.000,'gemessen','2026-11-18 08:05:00.000000','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:54:06.186775',NULL,NULL,'88f96c36-e383-11f1-8f27-bfcfcfa0b3a1'),
('cfd24b83-e389-11f1-8f27-bfcfcfa0b3a1','cfd017ca-e389-11f1-8f27-bfcfcfa0b3a1',105.000,'gemessen','2026-11-18 08:05:00.000000','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:54:06.186775',NULL,NULL,'88f96ee1-e383-11f1-8f27-bfcfcfa0b3a1'),
('cfd24cb5-e389-11f1-8f27-bfcfcfa0b3a1','cfd017ca-e389-11f1-8f27-bfcfcfa0b3a1',36.700,'gemessen','2026-11-18 08:05:00.000000','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:54:06.186775',NULL,NULL,'88f969a8-e383-11f1-8f27-bfcfcfa0b3a1'),
('cfd24dc7-e389-11f1-8f27-bfcfcfa0b3a1','cfd017ca-e389-11f1-8f27-bfcfcfa0b3a1',82.000,'gemessen','2026-11-18 08:05:00.000000','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:54:06.186775',NULL,NULL,'88f96298-e383-11f1-8f27-bfcfcfa0b3a1'),
('cfd24f43-e389-11f1-8f27-bfcfcfa0b3a1','cfd017ca-e389-11f1-8f27-bfcfcfa0b3a1',98.000,'gemessen','2026-11-18 08:05:00.000000','edafbea7-e386-11f1-8f27-bfcfcfa0b3a1','2026-11-18 19:54:06.186775',NULL,NULL,'88f96b0b-e383-11f1-8f27-bfcfcfa0b3a1');
