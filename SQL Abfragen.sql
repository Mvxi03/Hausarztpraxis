
-- 1. Patienten und Behandlungshistorie
-- Zeigt alle Patienten sowie ihre Behandlungskontakte mit Besuchsgrund, Termin und behandelndem Arzt. Auch Patienten ohne bisherigen Behandlungskontakt werden angezeigt.
SELECT
    p.vorname,
    p.nachname,
    p.ist_aktiv,
    k.art AS kontaktart,
    k.besuchsgrund,
    k.beginn AS kontaktbeginn,
    k.status AS kontaktstatus,
    t.beginn AS terminbeginn,
    t.status AS terminstatus,
    u.anzeigename AS behandelnder_arzt
FROM kis_db_modell.patient p
LEFT JOIN kis_db_modell.behandlungskontakt k
    ON p.patient_id = k.patient_id
LEFT JOIN kis_db_modell.termin t
    ON k.termin_id = t.termin_id
LEFT JOIN user_db_modell.app_user u
    ON k.arzt_user_id = u.user_id
ORDER BY p.nachname, p.vorname, k.beginn DESC;

-- 2. Vitalwerte mit Einheiten und Herkunft
-- Zeigt die dokumentierten Vitalwerte der Patienten mit Messwert, Einheit und Zeitpunkt. Zusätzlich wird angezeigt, welcher Benutzer die Messrunde durchgeführt hat.
SELECT
    p.vorname,
    p.nachname,
    vt.bezeichnung AS vitalwert,
    vb.wert,
    me.kuerzel AS einheit,
    vb.messstatus,
    vb.erhoben_am,
    u.anzeigename AS erhoben_von
FROM med_db_modell.vitalwert_beobachtung vb
JOIN med_db_modell.vitalwerttyp vt
    ON vb.vitalwerttyp_id = vt.vitalwerttyp_id
JOIN med_db_modell.masseinheit me
    ON vt.masseinheit_id = me.masseinheit_id
JOIN med_db_modell.vitalwerte_messrunde m
    ON vb.messrunde_id = m.messrunde_id
JOIN kis_db_modell.behandlungskontakt k
    ON m.behandlungskontakt_id = k.behandlungskontakt_id
JOIN kis_db_modell.patient p
    ON k.patient_id = p.patient_id
JOIN user_db_modell.app_user u
    ON m.erhoben_von_user_id = u.user_id
ORDER BY p.nachname, p.vorname, m.erhoben_am DESC, vt.bezeichnung;

-- 3. Medizinische Maßnahmen und Bearbeitungsstatus
-- Zeigt medizinische Maßnahmen wie Verordnungen oder Überweisungen mit ihrem aktuellen Status und dem zuständigen Arzt.
SELECT
    p.vorname,
    p.nachname,
    m.art,
    m.beschreibung,
    m.status,
    u.anzeigename AS behandelnder_arzt
FROM med_db_modell.medizinische_massnahme m
JOIN kis_db_modell.behandlungskontakt k
    ON m.behandlungskontakt_id = k.behandlungskontakt_id
JOIN kis_db_modell.patient p
    ON k.patient_id = p.patient_id
JOIN user_db_modell.app_user u
    ON m.arzt_user_id = u.user_id
ORDER BY p.nachname, p.vorname, m.art;

-- 4. Externe Laborbefunde und Laborwerte
-- Zeigt externe Laborbefunde und Laborwerte mit Patient, Untersuchung, Ergebnis, Einheit und Prüfstatus.
SELECT
    p.vorname,
    p.nachname,
    b.quelle,
    b.externe_kennung,
    m.art AS massnahme,
    l.untersuchung,
    lu.bezeichnung AS laborparameter,
    lw.wert,
    me.kuerzel AS einheit,
    b.pruefstatus
FROM med_db_modell.befundbericht b
JOIN kis_db_modell.patient p
    ON b.patient_id = p.patient_id
JOIN med_db_modell.medizinische_massnahme m
    ON b.massnahme_id = m.massnahme_id
JOIN med_db_modell.laborauftrag l
    ON m.massnahme_id = l.massnahme_id
JOIN med_db_modell.laborwert lw
    ON b.befund_id = lw.befund_id
JOIN med_db_modell.laboruntersuchungsart lu
    ON lw.laboruntersuchungsart_id = lu.laboruntersuchungsart_id
LEFT JOIN med_db_modell.masseinheit me
    ON lw.masseinheit_id = me.masseinheit_id
ORDER BY p.nachname, p.vorname, b.eingangszeit DESC, lu.bezeichnung;

-- 5. Benutzer, Rollen und Berechtigungen
-- Zeigt, welche Rollen und Berechtigungen den Benutzern der Hausarztpraxis zugeordnet sind.
SELECT
    u.benutzername,
    u.anzeigename,
    r.code AS rolle,
    b.code AS berechtigung
FROM user_db_modell.app_user u
JOIN user_db_modell.benutzer_rolle br
    ON u.user_id = br.user_id
JOIN user_db_modell.rolle r
    ON br.rolle_id = r.rolle_id
JOIN user_db_modell.rolle_berechtigung rb
    ON r.rolle_id = rb.rolle_id
JOIN user_db_modell.berechtigung b
    ON rb.berechtigung_id = b.berechtigung_id
ORDER BY u.benutzername, b.code;
