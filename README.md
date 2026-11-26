# Hausarztpraxis – Programming Lab 1

## Projekt

Relationale MySQL-Datenbank für eine Hausarztpraxis zur Verwaltung von Patienten, Terminen, Behandlungskontakten und medizinischen Informationen.

## Datenbankaufbau

- **USER** (`user_db_modell`): 6 Tabellen für Benutzer, Rollen und Berechtigungen
- **KIS** (`kis_db_modell`): 22 Tabellen für Patientenverwaltung, Termine und Abrechnung
- **MED** (`med_db_modell`): 22 Tabellen für medizinische Dokumentation

Insgesamt umfasst die Datenbank 50 Tabellen. Die Beziehungen werden mit Primär- und Fremdschlüsseln abgebildet.

## Dateien

- `USER DB.sql`, `KIS DB.sql`, `MED DB.sql`: Datenbankstruktur
- `Hausarztpraxis Gesamt.sql`: alternative gemeinsame Strukturdatei
- `Testdaten DB.sql`: fiktive Beispieldaten
- `SQL Abfragen neu.sql`: fünf SELECT-Abfragen
- `USER ER Modell.mwb`, `KIS ER Modell.mwb`, `MED ER Modell.mwb`: ER-Modelle
- `UML Hausarztpraxis.drawio`: UML-Domänenmodell
- `Fremdschluesseluebersicht aktuell.csv`: Fremdschlüsselübersicht
- `Lab1 Dokumentation Hausarztpraxis.docx`: Projektdokumentation
- `Arbeitsauftrag 1 Hausarztpraxis.docx` bis `Arbeitsauftrag 4 Hausarztpraxis.docx`: Arbeitsaufträge

## Ausführung

1. Eine Verbindung zum MySQL-Server in MySQL Workbench öffnen.
2. **Entweder** `Hausarztpraxis Gesamt.sql` **oder** die drei Einzeldateien in der Reihenfolge USER → KIS → MED ausführen.
3. `Testdaten DB.sql` einmal ausführen.
4. `SQL Abfragen neu.sql` öffnen und die fünf Abfragen ausführen.

## Überprüfung

Die drei Schemata wurden in MySQL Workbench erstellt, die Beispieldaten eingefügt und die fünf SELECT-Abfragen erfolgreich ausgeführt.
