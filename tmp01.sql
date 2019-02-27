CREATE OR REPLACE VIEW sf_jbdb_faktury_statys_v AS
(SELECT oksp_id,regi_kod,inst_kod,jete_kod,nr_faktury_sck,
    nr_faktury,rofa_kod,ppg,ppg_osd,rodzaj_ppg,
    mc_sprz,nip,pkd,branza,rodzaj_gazu,
    tary_kod,zuzycie,zuzycie_szac_roczne,wartosc_a,wartosc_g,
    wartosc_odz,wartosc_moc,wartosc_ods,wartosc_odm,wartosc_dodat,
    wartosc_akc,wartosc_rab,t_data_mod,t_data_utw,t_etl_id_mod,
    t_etl_id_utw,t_firma_zrod,t_system_zrod, substr(oksp_id, 1, 4) || '-' || substr(oksp_id, 5, 2) AS miesiac
FROM sf_jbdb_faktury_statys);