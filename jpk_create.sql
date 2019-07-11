create or replace view sf_jbdb_pp_aktywne_v as
select
MCRK, REGI_KOD, INST_KOD, JETE_KOD, LOPP_ID,
KOD_PP_OSD, UMOW_ID, STUM_DATA_OD, STUM_DATA_DO, STUM_DATA_OD_NEXT,
WARO_DATA_OD, WARO_DATA_DO, WARO_DATA_OD_NEXT, TYTA_KOD, TYTA_KOD_S,
ROGA_KOD, WAGA_PP, DATA_WYKONANIA, ADRE_ID, POCZTA,
RTRIM(KOPO_KOD) as KOPO_KOD, MIEJ_NAZWA, ULIC_NAZWA, NR_NIERUCHOMOSCI, NR_LOKALU,
TERYT, SUBSTR(OKRES, 1, 4) || '-' || SUBSTR(OKRES, 5, 2) as OKRES, INSERT_ID, INSERT_TIMESTAMP, UPDATE_ID,
UPDATE_TIMESTAMP, ETL_DATE_TO,
CAST ('JBDB' as Varchar2 (30)) T_SYSTEM_ZRODLOWY,
CAST ('JBDB' as Varchar2 (30)) T_SYSTEM_ZROD_POSREDNI,
CAST ('PGNIG' as Varchar2 (30)) T_FIRMA_ZROD
from BI_SRC_JBDB_E.BI_PP_AKTYWNE;


--drop table F_JPK_FAKTURY_VAT

create table F_JPK_FAKTURY_VAT
(
  W_JPK_FAKTURY_VAT      NUMBER not null,
  oksp_id                NUMBER not null,
  W_GEN_OKRES$SPRAWOZDAWCZY            NUMBER,
  ref                    VARCHAR2(24) not null,
  inst_kod               VARCHAR2(16) not null,
  W_WSP_INSTALACJA       NUMBER,
  rodo_kod               VARCHAR2(8) not null,
  W_CRD_RODZAJ_DOKUMENTU NUMBER,
  tykl_kod               VARCHAR2(1),
  pobi_kod               VARCHAR2(30) not null,
  W_WSP_KONTRAHENT       NUMBER,
  nazwa_kontrahenta      VARCHAR2(400),
  nip                    VARCHAR2(16),
  adres_kontrahenta      VARCHAR2(256),
  nr_dokumentu           VARCHAR2(50) not null,
  nr_dokumentu_fakt      VARCHAR2(50) not null,
  data_wystawienia       DATE not null,
  W_GEN_OKRES$WYSTAWIENIA NUMBER,
  data_sprzedazy         DATE,
  W_GEN_OKRES$SPRZEDAZY NUMBER,
  data_podatku_vat       DATE,
  W_GEN_OKRES$VAT        NUMBER,
  typ_dok_ksieg          VARCHAR2(2),
  W_SCK_TYP_DOK_KSIEG    NUMBER,
  wb                     NUMBER(16,2),
  kopo_kod               VARCHAR2(16),
  W_SCK_KODY_PODATKOW    NUMBER,
  stva_kod               VARCHAR2(4),
  W_SCK_STAWKA_VAT       NUMBER,
  wn                     NUMBER(16,2),
  vat                    NUMBER(16,2),
  insert_id              NUMBER,
  insert_timestamp       DATE,
  update_id              NUMBER,
  update_timestamp       DATE,
  etl_date_to            DATE,
  t_system_zrodlowy      VARCHAR2(30),
  t_system_zrod_posredni VARCHAR2(30),
  t_firma_zrod           VARCHAR2(30)
)

create sequence W_JPK_FAKTURY_VAT_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 100;

create sequence W_SCK_TYP_DOK_KSIEG_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 100;

create sequence W_SCK_KODY_PODATKOW_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 100;


insert into F_JPK_FAKTURY_VAT (
    W_JPK_FAKTURY_VAT,
    oksp_id,
    W_GEN_OKRES$SPRAWOZDAWCZY,
    ref,
    inst_kod,
    w_wsp_instalacja,
    rodo_kod,
    W_CRD_RODZAJ_DOKUMENTU,
    tykl_kod,
    pobi_kod,
    W_WSP_KONTRAHENT,
    nazwa_kontrahenta,
    nip,
    adres_kontrahenta,
    nr_dokumentu,
    nr_dokumentu_fakt,
    data_wystawienia,
    W_GEN_OKRES$WYSTAWIENIA,
    data_sprzedazy,
    W_GEN_OKRES$SPRZEDAZY,
    data_podatku_vat,
    W_GEN_OKRES$VAT,
    typ_dok_ksieg,
    W_SCK_TYP_DOK_KSIEG,
    wb,
    kopo_kod,
    W_SCK_KODY_PODATKOW,
    stva_kod,
    W_SCK_STAWKA_VAT,
    wn,
    vat,
    insert_id,
    insert_timestamp,
    update_id,
    update_timestamp,
    etl_date_to,
    t_system_zrodlowy,
    t_system_zrod_posredni,
    t_firma_zrod
)
(
    SELECT 
        W_JPK_FAKTURY_VAT_SEQ.nextval,
        f.oksp_id,
        osprawozdawczy.W_GEN_OKRES,
        f.ref,
        f.inst_kod,
        wi.w_wsp_instalacja,
        f.rodo_kod,
        wr.W_CRD_RODZAJ_DOKUMENTU,
        f.tykl_kod,
        f.pobi_kod,
        wk.W_WSP_KONTRAHENT,
        f.nazwa_kontrahenta,
        f.nip,
        f.adres_kontrahenta,
        f.nr_dokumentu,
        f.nr_dokumentu_fakt,
        f.data_wystawienia,
        owystawienia.W_GEN_OKRES,
        f.data_sprzedazy,
        osprzedazy.W_GEN_OKRES,
        f.data_podatku_vat,
        ovat.W_GEN_OKRES,
        f.typ_dok_ksieg,
        wd.W_SCK_TYP_DOK_KSIEG,
        f.wb,
        f.kopo_kod,
        wp.W_SCK_KODY_PODATKOW,
        f.stva_kod,
        wv.W_SCK_STAWKA_VAT,
        f.wn,
        f.vat,
        f.insert_id,
        f.insert_timestamp,
        f.update_id,
        f.update_timestamp,
        f.etl_date_to,
        f.t_system_zrodlowy,
        f.t_system_zrod_posredni,
        f.t_firma_zrod
from bi_stg.sf_jpk_faktury_vat f, 
    W_CRD_RODZAJ_DOKUMENTU wr,
    W_WSP_INSTALACJA wi,
    W_WSP_KONTRAHENT wk,
    W_SCK_STAWKA_VAT wv,
    W_SCK_TYP_DOK_KSIEG wd,
    W_SCK_KODY_PODATKOW wp,
    W_GEN_OKRES osprawozdawczy,
    W_GEN_OKRES owystawienia,
    W_GEN_OKRES osprzedazy,
    W_GEN_OKRES ovat
where wr.rodzaj_dokumentu_klucz(+) = f.rodo_kod
and wi.instalacja_kod = f.inst_kod
and wk.kontr_klucz(+) = f.pobi_kod
and wk.kontr_wsp_instalacja_klucz(+) = f.inst_kod
and wv.stawka_vat_kod = f.stva_kod
and wd.kod = f.kopo_kod
and wp.kod = f.typ_dok_ksieg
and osprawozdawczy.W_GEN_OKRES = f.oksp_id
and owystawienia.W_GEN_OKRES = to_number(to_char(f.data_wystawienia, 'YYYYMM'))
and osprzedazy.W_GEN_OKRES = to_number(to_char(f.data_sprzedazy, 'YYYYMM'))
and ovat.W_GEN_OKRES = to_number(to_char(f.data_podatku_vat, 'YYYYMM'))
)

create or replace view f_sprzedaz_wiersz_i as (
SELECT
f.oksp_id,
f.ref,
f.inst_kod,
f.w_wsp_instalacja,
'PSOD' as JEDN_GOSP,
--W_JPK_FAKTURY_VAT_SEQ.nextval as lp_sprzedazy,
f.W_WSP_KONTRAHENT,
f.nazwa_kontrahenta,
f.adres_kontrahenta,
f.nr_dokumentu as dowod_sprzedazy,
f.data_wystawienia,
f.data_sprzedazy,
SUM(CASE WHEN f.stva_kod in ('ZW') THEN f.wn - f.vat ELSE 0 END) AS K_10,
0 as K_11,
0 as K_12,
SUM(CASE WHEN f.stva_kod in (0) THEN f.wn - f.vat ELSE 0 END) AS K_13,
0 as K_14,
SUM(CASE WHEN f.stva_kod in (5) THEN f.wn - f.vat ELSE 0 END) AS K_15,
SUM(CASE WHEN f.stva_kod in (5) THEN f.vat ELSE 0 END) AS K_16,
SUM(CASE WHEN f.stva_kod in (4, 7, 8) THEN f.wn - f.vat ELSE 0 END) AS K_17,
SUM(CASE WHEN f.stva_kod in (4, 7, 8) THEN f.vat ELSE 0 END) AS K_18,
SUM(CASE WHEN f.stva_kod in (22, 23) THEN f.wn - f.vat ELSE 0 END) AS K_19,
SUM(CASE WHEN f.stva_kod in (22, 23) THEN f.vat ELSE 0 END) AS K_20,
0 as K_21,
0 as K_22,
0 as K_23,
0 as K_24,
0 as K_25,
0 as K_26,
0 as K_27,
0 as K_28,
0 as K_29,
0 as K_30,
0 as K_31,
0 as K_32,
0 as K_33,
0 as K_34,
0 as K_35,
0 as K_36,
0 as K_37,
0 as K_38,
0 as K_39,
W_GEN_OKRES$SPRAWOZDAWCZY,
W_GEN_OKRES$WYSTAWIENIA,
W_GEN_OKRES$SPRZEDAZY,
W_GEN_OKRES$VAT,
W_CRD_RODZAJ_DOKUMENTU,
W_SCK_TYP_DOK_KSIEG,
W_SCK_KODY_PODATKOW,
W_SCK_STAWKA_VAT
FROM bi_dm.f_jpk_faktury_vat f
group by f.oksp_id, f.ref, f.W_WSP_KONTRAHENT,
f.nazwa_kontrahenta,
f.adres_kontrahenta,
f.nr_dokumentu,
f.data_wystawienia,
f.data_sprzedazy,
f.inst_kod,
f.w_wsp_instalacja,
W_GEN_OKRES$SPRAWOZDAWCZY,
W_GEN_OKRES$WYSTAWIENIA,
W_GEN_OKRES$SPRZEDAZY,
W_GEN_OKRES$VAT,
W_CRD_RODZAJ_DOKUMENTU,
W_SCK_TYP_DOK_KSIEG,
W_SCK_KODY_PODATKOW,
W_SCK_STAWKA_VAT)

drop table f_sprzedaz_wiersz
create table f_sprzedaz_wiersz (
    OKSP_ID           NUMBER,                                  
REF               VARCHAR2(24),                            
JEDN_GOSP         CHAR(4),                     
lp_sprzedazy number not null,    
W_WSP_KONTRAHENT  NUMBER ,                         
NAZWA_KONTRAHENTA VARCHAR2(400),                       
ADRES_KONTRAHENTA VARCHAR2(256),                         
DOWOD_SPRZEDAZY   VARCHAR2(50),                          
DATA_WYSTAWIENIA  DATE,                           
DATA_SPRZEDAZY    DATE   ,                         
K_10              NUMBER ,                         
K_11              NUMBER ,                         
K_12              NUMBER ,                         
K_13              NUMBER ,                         
K_14              NUMBER ,                         
K_15              NUMBER ,                         
K_16              NUMBER ,                         
K_17              NUMBER ,                         
K_18              NUMBER ,                         
K_19              NUMBER ,                         
K_20              NUMBER ,                         
K_21              NUMBER ,                         
K_22              NUMBER ,                         
K_23              NUMBER ,                         
K_24              NUMBER ,                         
K_25              NUMBER ,                         
K_26              NUMBER ,                         
K_27              NUMBER ,                         
K_28              NUMBER ,                         
K_29              NUMBER ,                         
K_30              NUMBER ,                         
K_31              NUMBER ,                         
K_32              NUMBER ,                         
K_33              NUMBER ,                         
K_34              NUMBER ,                         
K_35              NUMBER ,                         
K_36              NUMBER ,                         
K_37              NUMBER ,                         
K_38              NUMBER ,                         
K_39              NUMBER,
W_GEN_OKRES$SPRAWOZDAWCZY NUMBER,                       
W_GEN_OKRES$WYSTAWIENIA   NUMBER,
W_GEN_OKRES$SPRZEDAZY     NUMBER,
W_GEN_OKRES$VAT           NUMBER,
W_CRD_RODZAJ_DOKUMENTU    NUMBER,
W_SCK_TYP_DOK_KSIEG       NUMBER,
W_SCK_KODY_PODATKOW       NUMBER,
W_SCK_STAWKA_VAT          NUMBER,
W_WSP_INSTALACJA          NUMBER
)


insert into f_sprzedaz_wiersz (
SELECT
f.oksp_id,
f.ref,
f.JEDN_GOSP,
w_Sprzedaz_Wiersz_Seq.nextval as lp_sprzedazy,
f.W_WSP_KONTRAHENT,
f.nazwa_kontrahenta,
f.adres_kontrahenta,
f.dowod_sprzedazy,
f.data_wystawienia,
f.data_sprzedazy,
f.K_10,
f.K_11,
f.K_12,
f.K_13,
f.K_14,
f.K_15,
f.K_16,
f.K_17,
f.K_18,
f.K_19,
f.K_20,
f.K_21,
f.K_22,
f.K_23,
f.K_24,
f.K_25,
f.K_26,
f.K_27,
f.K_28,
f.K_29,
f.K_30,
f.K_31,
f.K_32,
f.K_33,
f.K_34,
f.K_35,
f.K_36,
f.K_37,
f.K_38,
f.K_39,
W_GEN_OKRES$SPRAWOZDAWCZY,                       
W_GEN_OKRES$WYSTAWIENIA,
W_GEN_OKRES$SPRZEDAZY,
W_GEN_OKRES$VAT,
W_CRD_RODZAJ_DOKUMENTU,
W_SCK_TYP_DOK_KSIEG,
W_SCK_KODY_PODATKOW,
W_SCK_STAWKA_VAT,
W_WSP_INSTALACJA
FROM f_sprzedaz_wiersz_i f
)

•	INST_KOD

W_WSP_INSTALACJA

W_SCK_TYP_DOK_KSIEG
W_SCK_KODY_PODATKOW


Stawka 	Opis	Wiersze
5	5%	K_15/K_16
ZW	Zwolniony	K_10
7	7%	K_17/K_18
0	0%	K_13
8	8%	K_17/K_18
23	23%	K_19/K_20
