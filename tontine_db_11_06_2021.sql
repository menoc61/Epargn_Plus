--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

-- Started on 2021-06-11 16:40:26

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2815 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_with_oids = false;

--
-- TOC entry 181 (class 1259 OID 522425)
-- Name: aide; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE aide (
    idaide integer NOT NULL,
    idcycle integer,
    dateaide date,
    montantaide double precision,
    observation character varying(254),
    idmotifaide integer,
    idrencontre integer,
    idmembre integer,
    idbeneficiare integer,
    idcaisse integer,
    montant_maint_levee double precision DEFAULT 0
);


--
-- TOC entry 182 (class 1259 OID 522429)
-- Name: aide_membre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE aide_membre (
    id bigint NOT NULL,
    idmembre bigint,
    montant double precision,
    idaide bigint,
    montant_main_levee double precision DEFAULT 0
);


--
-- TOC entry 183 (class 1259 OID 522433)
-- Name: aidecotisation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE aidecotisation (
    idaidecotisation integer NOT NULL,
    idmembrecycle integer,
    idcotisationtontine integer NOT NULL,
    nomaide character varying(254),
    montant double precision,
    etat boolean DEFAULT false,
    interet double precision,
    idcaisse integer
);


--
-- TOC entry 184 (class 1259 OID 522437)
-- Name: amende; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE amende (
    idamende integer NOT NULL,
    idrencontre integer,
    idmembrecycle integer,
    dateamande date,
    montant double precision,
    observation text
);


--
-- TOC entry 185 (class 1259 OID 522443)
-- Name: avalyse; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE avalyse (
    idavalyse bigint NOT NULL,
    membre_avalyste bigint,
    montant_avalyse double precision,
    idemprunt bigint
);


--
-- TOC entry 186 (class 1259 OID 522446)
-- Name: beneficiaire_tontine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE beneficiaire_tontine (
    idbeneficiaire bigint NOT NULL,
    montant double precision,
    numero_ordre integer,
    idtontiner integer,
    reste double precision,
    idmain integer,
    idcaisse integer
);


--
-- TOC entry 187 (class 1259 OID 522449)
-- Name: beneficiairecotisation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE beneficiairecotisation (
    idbeneficiare integer NOT NULL,
    idmembre integer,
    idcycle integer,
    idmois integer,
    montantcotisation character varying(254),
    datecotisation date,
    observation character varying(254)
);


--
-- TOC entry 188 (class 1259 OID 522455)
-- Name: caisse; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE caisse (
    idcaisse bigint NOT NULL,
    idrubriquecaisse integer,
    idcycle integer,
    montant double precision,
    idmembrecycle integer,
    idrencontre integer,
    dateoperation date,
    libelleoperation character varying,
    idtontiner integer
);


--
-- TOC entry 189 (class 1259 OID 522461)
-- Name: calcul_interet; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE calcul_interet (
    id bigint NOT NULL,
    idmembre bigint,
    idrencontre integer,
    montant_initial_emprunt double precision,
    montant_interet double precision DEFAULT 0,
    reste_capital double precision DEFAULT 0
);


--
-- TOC entry 190 (class 1259 OID 522466)
-- Name: cassation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cassation (
    id bigint NOT NULL,
    idmembre bigint,
    montant_epargne double precision,
    nombre_point double precision,
    montant_gain double precision,
    idcycle integer,
    montant_rembourse double precision,
    montant_interet double precision,
    montant_emprunte double precision,
    duree double precision,
    coef_epargne double precision,
    pourcentage_gain double precision DEFAULT 0,
    reste_capital double precision,
    reste_interet double precision,
    redevance_cotisation double precision DEFAULT 0,
    redevance_main_laivee double precision DEFAULT 0,
    redevance_secours double precision DEFAULT 0,
    net_a_percevoir double precision DEFAULT 0,
    gain_normal double precision DEFAULT 0,
    gain_tontine double precision DEFAULT 0,
    redevance_absence double precision DEFAULT 0
);


--
-- TOC entry 191 (class 1259 OID 522477)
-- Name: cassation_detail; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cassation_detail (
    id bigint NOT NULL,
    idmembre bigint,
    idcycle integer,
    montant double precision,
    date_epargne date,
    date_calcul date,
    coef_epargne double precision,
    duree double precision,
    nombre_point double precision
);


--
-- TOC entry 192 (class 1259 OID 522480)
-- Name: cassationtontine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cassationtontine (
    idcassation integer NOT NULL,
    idcaisse bigint,
    idmain integer,
    montant double precision
);


--
-- TOC entry 193 (class 1259 OID 522483)
-- Name: collecte_main_levee; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE collecte_main_levee (
    id bigint NOT NULL,
    idmembre integer,
    idcaisse integer,
    montant double precision,
    idrencontre integer,
    observation text
);


--
-- TOC entry 194 (class 1259 OID 522489)
-- Name: collecte_secours; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE collecte_secours (
    id bigint NOT NULL,
    idmembre bigint,
    idcaisse bigint,
    montant double precision,
    idrencontre integer,
    observation character varying
);


--
-- TOC entry 195 (class 1259 OID 522495)
-- Name: compteutilisateur; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE compteutilisateur (
    idcompte integer NOT NULL,
    idmembre integer,
    login character varying(254),
    password character varying(254),
    etat boolean,
    idutilisateur integer
);


--
-- TOC entry 196 (class 1259 OID 522501)
-- Name: cotisation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cotisation (
    idcotisation integer NOT NULL,
    montant double precision,
    nom character varying,
    nbretours integer,
    redevance double precision,
    premierjour integer,
    penalite_non_cotisation double precision,
    penalite_non_cotisation_a_bouffe double precision,
    interet_assistance_cotisation double precision,
    can_enchered boolean DEFAULT false,
    enchere_min double precision,
    enchere_max double precision,
    idtontine integer,
    date_enregistrement date,
    est_termine boolean DEFAULT false,
    reliquat double precision
);


--
-- TOC entry 197 (class 1259 OID 522509)
-- Name: cotisation_tontine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cotisation_tontine (
    idcotisationtontine bigint NOT NULL,
    a_cotise double precision,
    idtontiner integer,
    reste double precision,
    doit_cotiser double precision,
    idmain integer,
    idcaisse integer
);


--
-- TOC entry 198 (class 1259 OID 522512)
-- Name: cycletontine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cycletontine (
    idcycle integer NOT NULL,
    nomfr character varying(254),
    nomen character varying(254),
    idtontine integer,
    nombremembre integer,
    fraisadhesion double precision,
    tauxavaliste double precision,
    taux_interet_default double precision DEFAULT 0,
    unite_emprunt double precision DEFAULT 0,
    id_pas_emprunt integer,
    montant_cotisation double precision,
    montant_min_retard double precision DEFAULT 0,
    montant_abs_non_just double precision DEFAULT 0,
    montant_secours double precision DEFAULT 0,
    transfere boolean DEFAULT false,
    proportion_gain double precision
);


--
-- TOC entry 199 (class 1259 OID 522524)
-- Name: depense; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE depense (
    iddepense integer NOT NULL,
    date date,
    montant double precision,
    idrencontre integer,
    idrubriquecaisse integer,
    observation text,
    idcycle integer,
    idcaisse integer
);


--
-- TOC entry 200 (class 1259 OID 522530)
-- Name: devise; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE devise (
    iddevices integer NOT NULL,
    nom_fr character varying(254),
    nom_en character varying
);


--
-- TOC entry 201 (class 1259 OID 522536)
-- Name: emprunt; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE emprunt (
    idemprunt integer NOT NULL,
    idtypeinteret integer,
    idmembre integer,
    montantemp double precision,
    dateemprunt date,
    observtaion character varying(254),
    taux double precision,
    idrencontre bigint,
    taux_interet double precision DEFAULT 0,
    rembourse boolean DEFAULT false,
    montant_remboursable double precision DEFAULT 0,
    date_dernier_remboursement date,
    cumul_interet double precision DEFAULT 0,
    date_dernier_remboursement_int date,
    idcaisse integer
);


--
-- TOC entry 202 (class 1259 OID 522543)
-- Name: encherebenficiare; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE encherebenficiare (
    idenchere integer NOT NULL,
    idcaisse bigint,
    idbeneficiaire bigint,
    montant double precision,
    termine boolean
);


--
-- TOC entry 203 (class 1259 OID 522546)
-- Name: encours_emprunt; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE encours_emprunt (
    id_encours_emprunt bigint NOT NULL,
    solde_capital double precision,
    solde_interet double precision,
    capital_rembourse double precision,
    interet_rembourse double precision,
    total double precision,
    id_calcul_interet bigint
);


--
-- TOC entry 204 (class 1259 OID 522549)
-- Name: encours_secours; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE encours_secours (
    id_encours_secours bigint NOT NULL,
    encours double precision,
    montant_cotise double precision,
    reste double precision,
    observation text,
    idmembre bigint,
    idrencontre integer
);


--
-- TOC entry 205 (class 1259 OID 522555)
-- Name: epargne; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE epargne (
    idepargne integer NOT NULL,
    idrencontre integer,
    dateepargne date,
    montant double precision,
    idmembrecycle integer,
    observation text,
    idcaisse integer
);


--
-- TOC entry 206 (class 1259 OID 522561)
-- Name: fiche_presence; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fiche_presence (
    id bigint NOT NULL,
    idmembre bigint,
    idrencontre bigint,
    date_rencontre date,
    present boolean DEFAULT false,
    heure_debut time without time zone,
    heure_fin time without time zone,
    retard integer,
    justifie boolean DEFAULT false,
    montant_penalite double precision DEFAULT 0,
    regle boolean DEFAULT false,
    motif character varying
);


--
-- TOC entry 207 (class 1259 OID 522571)
-- Name: frequencecotisation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE frequencecotisation (
    idfrequence integer NOT NULL,
    denomination character varying(254),
    valeur integer
);


--
-- TOC entry 208 (class 1259 OID 522574)
-- Name: frequencetontine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE frequencetontine (
    idfreqtontine integer NOT NULL,
    nom_fr character varying(254),
    nom_en character varying(254)
);


--
-- TOC entry 209 (class 1259 OID 522580)
-- Name: groupecaisse; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE groupecaisse (
    idgroupecaisse integer NOT NULL,
    nomfr character varying,
    nomen character varying
);


--
-- TOC entry 210 (class 1259 OID 522586)
-- Name: groupeutilisateur; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE groupeutilisateur (
    idgroupe integer NOT NULL,
    nom character varying(254),
    datecreation date,
    etat boolean
);


--
-- TOC entry 211 (class 1259 OID 522589)
-- Name: inscription_cotisation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE inscription_cotisation (
    idinscription bigint NOT NULL,
    idcotisation integer,
    idmembre integer,
    etat boolean DEFAULT false
);


--
-- TOC entry 212 (class 1259 OID 522593)
-- Name: mains; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mains (
    idmain integer NOT NULL,
    idinscription bigint,
    codemain character varying(254),
    nom character varying(254),
    nbretourspasse integer,
    numeroordre integer,
    montantsouscrit double precision,
    echec boolean DEFAULT false
);


--
-- TOC entry 213 (class 1259 OID 522600)
-- Name: membre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE membre (
    idmembre integer NOT NULL,
    nom character varying(254),
    prenom character varying(254),
    sexe character varying(254),
    contact character varying(254),
    email character varying(254),
    photo character varying(254),
    adresse character varying(254),
    idpays integer,
    numcni character varying,
    code character varying
);


--
-- TOC entry 214 (class 1259 OID 522606)
-- Name: membrecycle; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE membrecycle (
    idmembrecycle integer NOT NULL,
    idmembre integer,
    idcycle integer,
    montantavalise double precision,
    montant_secours double precision DEFAULT 0,
    reste_main_levee double precision DEFAULT 0,
    etat boolean DEFAULT true,
    fraisadhesion double precision DEFAULT 0,
    idcaisse integer
);


--
-- TOC entry 215 (class 1259 OID 522613)
-- Name: membretontine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE membretontine (
    idmembretontine integer NOT NULL,
    idmembre integer,
    idtontine integer,
    etat boolean DEFAULT true
);


--
-- TOC entry 216 (class 1259 OID 522617)
-- Name: menu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE menu (
    idmenu integer NOT NULL,
    libelle character varying(254),
    ressource character varying(254),
    etat boolean
);


--
-- TOC entry 217 (class 1259 OID 522623)
-- Name: modepaiement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE modepaiement (
    idmdepaiement integer NOT NULL,
    nom_fr character varying(254),
    nom_en character varying(254)
);


--
-- TOC entry 218 (class 1259 OID 522629)
-- Name: mois; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mois (
    idmois integer NOT NULL,
    nom_fr character varying(254),
    nom_en character varying(254)
);


--
-- TOC entry 219 (class 1259 OID 522635)
-- Name: motifaide; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE motifaide (
    idmotifaide integer NOT NULL,
    nomfr character varying(254),
    nomen character varying(254)
);


--
-- TOC entry 220 (class 1259 OID 522641)
-- Name: mouchard; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mouchard (
    idoperation integer NOT NULL,
    action character varying(254),
    dateaction date,
    heure date,
    idcompte_utilisateur integer
);


--
-- TOC entry 221 (class 1259 OID 522644)
-- Name: naturecaisse; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE naturecaisse (
    idnaturecaisse integer NOT NULL,
    nomfr character varying,
    nomen character varying
);


--
-- TOC entry 222 (class 1259 OID 522650)
-- Name: operationcaisse; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE operationcaisse (
    idoperationcaisse integer NOT NULL,
    idcycle integer,
    idmois integer,
    libelle character varying(254),
    montant numeric,
    date date
);


--
-- TOC entry 223 (class 1259 OID 522656)
-- Name: pas_emprunt; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pas_emprunt (
    idpas integer NOT NULL,
    nom character varying,
    valeur integer
);


--
-- TOC entry 224 (class 1259 OID 522662)
-- Name: payement_sanction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE payement_sanction (
    id bigint NOT NULL,
    idpresence bigint,
    idcaisse integer,
    montant double precision,
    observation character varying,
    idrencontre integer
);


--
-- TOC entry 225 (class 1259 OID 522668)
-- Name: pays; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pays (
    idpays integer NOT NULL,
    nom_fr character varying,
    nom_en character varying
);


--
-- TOC entry 226 (class 1259 OID 522674)
-- Name: privilege; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE privilege (
    idprivilege integer NOT NULL,
    idmenu integer NOT NULL,
    dateattribution date,
    etat boolean,
    idcompte_utilisateur integer
);


--
-- TOC entry 227 (class 1259 OID 522677)
-- Name: ration; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ration (
    idration integer NOT NULL,
    idrencontre integer,
    idmembrecycle integer,
    dateration date,
    montant double precision,
    observation text
);


--
-- TOC entry 228 (class 1259 OID 522683)
-- Name: recette; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE recette (
    idrecette integer NOT NULL,
    date date,
    observation text,
    idrencontre integer,
    idrubrique integer,
    montant double precision,
    idcycle integer,
    idcaisse integer
);


--
-- TOC entry 229 (class 1259 OID 522689)
-- Name: redevance_cotisation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE redevance_cotisation (
    id_redevance_cotisation bigint NOT NULL,
    idinscription bigint,
    idrencontre integer,
    montant_initial double precision,
    montant_verse double precision,
    reste double precision
);


--
-- TOC entry 230 (class 1259 OID 522692)
-- Name: remboursement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE remboursement (
    idremboursement integer NOT NULL,
    daterembour date,
    interet double precision,
    montanttotal double precision,
    idemprunt bigint,
    idrencontre integer,
    montant_rembourse double precision,
    observation text,
    idtyperemboursement integer,
    idcaisse integer,
    reste_capital_avant double precision DEFAULT 0,
    cumul_interet_avant double precision
);


--
-- TOC entry 231 (class 1259 OID 522699)
-- Name: rencontre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rencontre (
    idrencontre integer NOT NULL,
    nomfr character varying,
    daterencontre date,
    nomen character varying,
    idcycle integer,
    ouverture_rencontre boolean DEFAULT false,
    heuredebut time without time zone,
    heurefin time without time zone,
    fermetture boolean DEFAULT false,
    is_rencontre_cotisation boolean DEFAULT false,
    id_tontine integer
);


--
-- TOC entry 232 (class 1259 OID 522708)
-- Name: retard; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE retard (
    idretard integer NOT NULL,
    idrencontre integer,
    idmembrecycle integer,
    dateretard date,
    montant double precision,
    observation text
);


--
-- TOC entry 233 (class 1259 OID 522714)
-- Name: rubriquecaisse; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rubriquecaisse (
    idrubriquecaisse integer NOT NULL,
    nomfr character varying(254),
    nomen character varying(254),
    code character varying(254),
    modifiable boolean DEFAULT false,
    afficher boolean DEFAULT false,
    idnaturecaisse integer,
    editable_en_caisse boolean DEFAULT false
);


--
-- TOC entry 234 (class 1259 OID 522723)
-- Name: sanction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sanction (
    idtsanction integer NOT NULL,
    nom_en character varying(254),
    montant numeric,
    nom_fr character varying(254)
);


--
-- TOC entry 235 (class 1259 OID 522729)
-- Name: secours; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE secours (
    idsecours integer NOT NULL,
    idrencontre integer,
    idmembrecycle integer,
    date date,
    montant double precision,
    observation text
);


--
-- TOC entry 236 (class 1259 OID 522735)
-- Name: statutmembre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE statutmembre (
    idstatut integer NOT NULL,
    nom character varying
);


--
-- TOC entry 237 (class 1259 OID 522741)
-- Name: tontine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tontine (
    idtontine integer NOT NULL,
    idfreqtontine integer,
    idtsanction integer,
    idtranchecotisation integer,
    idmdepaiement integer,
    idrubriquecaisse integer,
    iddevices integer,
    nom character varying(254),
    slogan character varying(254),
    numerodetransfert character varying
);


--
-- TOC entry 238 (class 1259 OID 522747)
-- Name: tontiner; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tontiner (
    idtontiner integer NOT NULL,
    idrencontre integer,
    montantcotise double precision,
    montantbeneficie double precision,
    redevance double precision,
    montantechec double precision,
    idcotisation integer,
    effectue boolean DEFAULT false
);


--
-- TOC entry 239 (class 1259 OID 522751)
-- Name: tranchecotisation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tranchecotisation (
    idtranche integer NOT NULL,
    montant character varying(254)
);


--
-- TOC entry 240 (class 1259 OID 522754)
-- Name: trancheemprunt; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE trancheemprunt (
    idtranche integer NOT NULL,
    nom_fr character varying(254),
    tauxinteret numeric,
    nom_en character varying(254)
);


--
-- TOC entry 241 (class 1259 OID 522760)
-- Name: type_remboursement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE type_remboursement (
    id integer NOT NULL,
    nom character varying
);


--
-- TOC entry 242 (class 1259 OID 522766)
-- Name: typeinteret; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE typeinteret (
    idtypeinteret integer NOT NULL,
    nom_fr character varying(254),
    nom_en character varying(254)
);


--
-- TOC entry 243 (class 1259 OID 522772)
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE utilisateur (
    idutilisateur integer NOT NULL,
    nom character varying,
    prenom character varying,
    sexe character varying,
    idgroupeutilisateur integer
);


--
-- TOC entry 244 (class 1259 OID 522778)
-- Name: utilisateurtontine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE utilisateurtontine (
    idutilisateurtontine integer NOT NULL,
    idutilisateur integer,
    idtontine integer
);


--
-- TOC entry 2745 (class 0 OID 522425)
-- Dependencies: 181
-- Data for Name: aide; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO aide (idaide, idcycle, dateaide, montantaide, observation, idmotifaide, idrencontre, idmembre, idbeneficiare, idcaisse, montant_maint_levee) VALUES (1, 2, '2018-01-07', 250000, 'Assistance Mariage Mr Nzangue ', 3, 15, 16, NULL, 69, 250000);
INSERT INTO aide (idaide, idcycle, dateaide, montantaide, observation, idmotifaide, idrencontre, idmembre, idbeneficiare, idcaisse, montant_maint_levee) VALUES (2, 2, '2018-01-07', 250000, 'Assistance Mariage M. Ateba', 3, 15, 9, NULL, 70, 250000);
INSERT INTO aide (idaide, idcycle, dateaide, montantaide, observation, idmotifaide, idrencontre, idmembre, idbeneficiare, idcaisse, montant_maint_levee) VALUES (3, 2, '2018-04-07', 310000, 'Assistance déces maman de Mr Nzangue
Secours 250 000 FCFa
Deplacement equipe désignée : 60 000 FCFA', 2, 18, 16, NULL, 72, 0);
INSERT INTO aide (idaide, idcycle, dateaide, montantaide, observation, idmotifaide, idrencontre, idmembre, idbeneficiare, idcaisse, montant_maint_levee) VALUES (4, 2, '2018-05-07', 340000, 'Assistance déces Papa de M. Henock', 2, 19, 13, NULL, 81, 0);
INSERT INTO aide (idaide, idcycle, dateaide, montantaide, observation, idmotifaide, idrencontre, idmembre, idbeneficiare, idcaisse, montant_maint_levee) VALUES (5, 2, '2018-05-07', 0, '-', 1, 19, 15, NULL, 82, 30000);
INSERT INTO aide (idaide, idcycle, dateaide, montantaide, observation, idmotifaide, idrencontre, idmembre, idbeneficiare, idcaisse, montant_maint_levee) VALUES (6, 5, '2021-01-31', 30000, '-', 1, 38, 58, NULL, 272, 0);


--
-- TOC entry 2746 (class 0 OID 522429)
-- Dependencies: 182
-- Data for Name: aide_membre; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (1, 9, 31250, 1, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (2, 10, 31250, 1, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (3, 11, 31250, 1, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (4, 12, 31250, 1, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (5, 13, 31250, 1, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (6, 14, 31250, 1, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (7, 16, 31250, 1, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (8, 15, 31250, 1, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (9, 9, 31250, 2, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (10, 10, 31250, 2, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (11, 11, 31250, 2, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (12, 12, 31250, 2, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (13, 13, 31250, 2, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (14, 14, 31250, 2, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (15, 16, 31250, 2, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (16, 15, 31250, 2, 31250);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (17, 9, 38750, 3, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (18, 10, 38750, 3, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (19, 11, 38750, 3, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (20, 12, 38750, 3, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (21, 13, 38750, 3, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (22, 14, 38750, 3, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (23, 16, 38750, 3, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (24, 15, 38750, 3, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (25, 9, 42500, 4, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (26, 10, 42500, 4, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (27, 11, 42500, 4, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (28, 12, 42500, 4, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (29, 13, 42500, 4, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (30, 14, 42500, 4, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (31, 16, 42500, 4, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (32, 15, 42500, 4, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (33, 9, 0, 5, 3750);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (34, 10, 0, 5, 3750);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (35, 11, 0, 5, 3750);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (36, 12, 0, 5, 3750);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (37, 13, 0, 5, 3750);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (38, 14, 0, 5, 3750);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (39, 16, 0, 5, 3750);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (40, 15, 0, 5, 3750);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (41, 57, 7500, 6, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (42, 58, 7500, 6, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (43, 59, 7500, 6, 0);
INSERT INTO aide_membre (id, idmembre, montant, idaide, montant_main_levee) VALUES (44, 60, 7500, 6, 0);


--
-- TOC entry 2747 (class 0 OID 522433)
-- Dependencies: 183
-- Data for Name: aidecotisation; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO aidecotisation (idaidecotisation, idmembrecycle, idcotisationtontine, nomaide, montant, etat, interet, idcaisse) VALUES (1, NULL, 41, 'La Caisse', 5000, true, 0, 656);
INSERT INTO aidecotisation (idaidecotisation, idmembrecycle, idcotisationtontine, nomaide, montant, etat, interet, idcaisse) VALUES (3, 13, 71, 'MFOUAPONHenock', 10000, true, 0, NULL);
INSERT INTO aidecotisation (idaidecotisation, idmembrecycle, idcotisationtontine, nomaide, montant, etat, interet, idcaisse) VALUES (2, NULL, 62, 'La Caisse', 2000, true, 0, 740);


--
-- TOC entry 2748 (class 0 OID 522437)
-- Dependencies: 184
-- Data for Name: amende; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2749 (class 0 OID 522443)
-- Dependencies: 185
-- Data for Name: avalyse; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2750 (class 0 OID 522446)
-- Dependencies: 186
-- Data for Name: beneficiaire_tontine; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (22, 107000, NULL, 12, 0, 21, 692);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (23, 105500, NULL, 12, 0, 23, 694);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (24, 103000, NULL, 12, 0, 24, 696);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (25, 102000, NULL, 12, 0, 25, 698);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (26, 110000, NULL, 8, 0, 30, 714);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (27, 109500, NULL, 8, 0, 22, 716);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (28, 109000, NULL, 8, 0, 26, 718);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (29, 110000, NULL, 9, 0, 27, 734);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (30, 109500, NULL, 9, 0, 28, 736);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (31, 109000, NULL, 9, 0, 29, 738);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (32, 110000, NULL, 10, 0, 31, 754);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (1, 105000, NULL, 4, 0, 1, 529);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (2, 105000, NULL, 4, 0, 4, 530);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (3, 105000, NULL, 5, 0, 7, 549);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (4, 105000, NULL, 5, 0, 9, 550);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (5, 105000, NULL, 5, 0, 13, 551);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (20, 105000, NULL, 11, 0, 19, 566);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (21, 103500, NULL, 11, 0, 20, 568);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (6, 105000, NULL, 6, 0, 2, 589);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (7, 105000, NULL, 6, 0, 5, 590);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (10, 105000, NULL, 7, 0, 17, 610);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (8, 105000, NULL, 7, 0, 10, 611);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (9, 105000, NULL, 7, 0, 14, 612);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (11, 105000, NULL, 1, 0, 11, 632);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (12, 105000, NULL, 1, 0, 16, 633);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (13, 105000, NULL, 2, 0, 3, 653);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (14, 105000, NULL, 2, 0, 6, 654);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (15, 105000, NULL, 2, 0, 12, 655);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (17, 105000, NULL, 3, 0, 8, 675);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (18, 105000, NULL, 3, 0, 15, 676);
INSERT INTO beneficiaire_tontine (idbeneficiaire, montant, numero_ordre, idtontiner, reste, idmain, idcaisse) VALUES (19, 105000, NULL, 3, 0, 18, 677);


--
-- TOC entry 2751 (class 0 OID 522449)
-- Dependencies: 187
-- Data for Name: beneficiairecotisation; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2752 (class 0 OID 522455)
-- Dependencies: 188
-- Data for Name: caisse; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (1, 16, 2, 10000, 9, 15, '2019-03-06', 'Le Membre  ATEBA ASOMO a effectué une opération dans la rubrique caisse Frais d''annonce', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (2, 3, 2, 5000, 9, 15, '2019-03-06', 'Le Membre  ATEBA ASOMO a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (3, 3, 2, 5000, 10, 15, '2019-03-06', 'Le Membre  BESSALA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (4, 3, 2, 5000, 12, 15, '2019-03-06', 'Le Membre  MEBARA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (5, 3, 2, 5000, 13, 15, '2019-03-06', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (6, 3, 2, 5000, 14, 15, '2019-03-06', 'Le Membre  NDENDE a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (7, 3, 2, 5000, 16, 15, '2019-03-06', 'Le Membre  NZANGUE NEPOUDEM a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (8, 2, 2, 500000, 9, 15, '2018-01-07', 'Enregistrement de l''epargne  du membre ATEBA ASOMO', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (9, 1, 2, 31250, 9, 15, '2018-01-07', 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 31250.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (10, 1, 2, 32500, 10, 15, '2018-01-07', 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 32500.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (11, 1, 2, 20000, 13, 15, '2018-01-07', 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 20000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (12, 1, 2, 42500, 14, 15, '2018-01-07', 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 42500.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (13, 10, 2, 50000, NULL, 15, '2018-01-07', 'Enregistrement de la depense -> Frais de Collation Mois de Janvier 2008', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (14, 17, 2, 500, 9, 16, '2019-03-06', 'Le Membre  ATEBA ASOMO a effectué une opération dans la rubrique caisse Frais de Timbre', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (15, 3, 2, 5000, 9, 16, '2019-03-06', 'Le Membre  ATEBA ASOMO a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (16, 17, 2, 500, 10, 16, '2019-03-06', 'Le Membre  BESSALA a effectué une opération dans la rubrique caisse Frais de Timbre', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (17, 3, 2, 5000, 10, 16, '2019-03-06', 'Le Membre  BESSALA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (18, 3, 2, 5000, 12, 16, '2019-03-06', 'Le Membre  MEBARA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (19, 3, 2, 5000, 13, 16, '2019-03-06', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (20, 3, 2, 5000, 14, 16, '2019-03-06', 'Le Membre  NDENDE a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (21, 3, 2, 5000, 16, 16, '2019-03-06', 'Le Membre  NZANGUE NEPOUDEM a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (22, 1, 2, 10000, 9, 16, '2018-02-07', 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (23, 1, 2, 10000, 10, 16, '2018-02-07', 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (24, 1, 2, 30000, 12, 16, '2018-02-07', 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 30000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (25, 1, 2, 10000, 13, 16, '2018-02-07', 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (26, 1, 2, 10000, 14, 16, '2018-02-07', 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (27, 1, 2, 40000, 16, 16, '2018-02-07', 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 40000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (28, 2, 2, 300000, 9, 16, '2018-02-07', 'Enregistrement de l''epargne  du membre ATEBA ASOMO', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (29, 2, 2, 10000, 12, 16, '2018-02-07', 'Enregistrement de l''epargne  du membre MEBARA', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (30, 2, 2, 100000, 14, 16, '2018-02-07', 'Enregistrement de l''epargne  du membre NDENDE', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (31, 7, 2, 50000, 9, 16, '2018-02-07', 'Enregistrement de l''emprunt -> 50000.0 du membre -> ATEBA ASOMO ATEBA ASOMO', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (32, 7, 2, 300000, 10, 16, '2018-02-07', 'Enregistrement de l''emprunt -> 300000.0 du membre -> BESSALA BESSALA', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (89, 11, 2, 5000, 11, 19, '2018-05-07', 'Enregistrement du fond de la main levée du membre  -> ERIC Ebolo ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (90, 1, 2, 90000, 9, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 90000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (91, 1, 2, 90000, 10, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 90000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (92, 1, 2, 110000, 16, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 110000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (93, 1, 2, 110000, 13, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 110000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (94, 1, 2, 120000, 15, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> OLOUGOU Valère ; Montant -> 120000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (95, 1, 2, 110000, 14, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 110000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (96, 1, 2, 110000, 12, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 110000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (97, 1, 2, 140000, 11, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 140000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (98, 1, 2, 60000, 9, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 60000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (99, 1, 2, 50000, 10, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 50000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (100, 1, 2, 47500, 16, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 47500.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (101, 1, 2, 50000, 13, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 50000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (102, 1, 2, 37500, 15, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> OLOUGOU Valère ; Montant -> 37500.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (103, 1, 2, 40000, 14, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 40000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (104, 1, 2, 20000, 12, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 20000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (105, 14, 2, 3750, NULL, 20, '2018-06-07', 'Enregistrement de la depense -> Remboursement correctif Eric Sur Assistance BB Olougou Valer', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (106, 3, 2, 5000, 9, 20, '2019-03-07', 'Le Membre  ATEBA ASOMO a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (107, 3, 2, 10000, 10, 20, '2019-03-07', 'Le Membre  BESSALA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (108, 3, 2, 5000, 11, 20, '2019-03-07', 'Le Membre  ERIC a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (109, 3, 2, 5000, 12, 20, '2019-03-07', 'Le Membre  MEBARA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (110, 3, 2, 5000, 13, 20, '2019-03-07', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (33, 3, 2, 5000, 9, 17, '2019-03-06', 'Le Membre  ATEBA ASOMO a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (34, 3, 2, 5000, 10, 17, '2019-03-06', 'Le Membre  BESSALA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (35, 3, 2, 15000, 11, 17, '2019-03-06', 'Le Membre  ERIC a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (36, 3, 2, 5000, 12, 17, '2019-03-06', 'Le Membre  MEBARA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (37, 17, 2, 500, 13, 17, '2019-03-06', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Frais de Timbre', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (38, 3, 2, 5000, 13, 17, '2019-03-06', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (39, 3, 2, 5000, 14, 17, '2019-03-06', 'Le Membre  NDENDE a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (40, 17, 2, 500, 16, 17, '2019-03-06', 'Le Membre  NZANGUE NEPOUDEM a effectué une opération dans la rubrique caisse Frais de Timbre', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (41, 3, 2, 5000, 16, 17, '2019-03-06', 'Le Membre  NZANGUE NEPOUDEM a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (111, 3, 2, 10000, 14, 20, '2019-03-07', 'Le Membre  NDENDE a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (112, 3, 2, 5000, 16, 20, '2019-03-07', 'Le Membre  NZANGUE NEPOUDEM a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (113, 2, 2, 10000, 12, 20, '2018-06-07', 'Enregistrement de l''epargne  du membre MEBARA', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (114, 2, 2, 100000, 14, 20, '2018-06-07', 'Enregistrement de l''epargne  du membre NDENDE', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (115, 17, 2, 500, 9, 20, '2019-03-07', 'Le Membre  ATEBA ASOMO a effectué une opération dans la rubrique caisse Frais de Timbre', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (116, 7, 2, 100000, 9, 20, '2018-06-07', 'Enregistrement de l''emprunt -> 100000.0 du membre -> ATEBA ASOMO ATEBA ASOMO', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (117, 8, 2, 30000, 10, 20, '2018-06-07', 'Enregistrement du remboursement -> 30000.0 du membre -> BESSALA BESSALA', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (118, 1, 2, 10000, 9, 20, '2018-06-07', 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (119, 1, 2, 10000, 11, 20, '2018-06-07', 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (120, 1, 2, 5000, 12, 20, '2018-06-07', 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (121, 1, 2, 10000, 13, 20, '2018-06-07', 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (122, 1, 2, 20000, 14, 20, '2018-06-07', 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 20000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (123, 1, 2, 10000, 16, 20, '2018-06-07', 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (124, 3, 2, 5000, 9, 21, '2019-03-07', 'Le Membre  ATEBA ASOMO a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (125, 3, 2, 5000, 10, 21, '2019-03-07', 'Le Membre  BESSALA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (126, 3, 2, 5000, 11, 21, '2019-03-07', 'Le Membre  ERIC a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (127, 3, 2, 5000, 12, 21, '2019-03-07', 'Le Membre  MEBARA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (128, 3, 2, 5000, 13, 21, '2019-03-07', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (129, 3, 2, 5000, 16, 21, '2019-03-07', 'Le Membre  NZANGUE NEPOUDEM a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (130, 8, 2, 10000, 9, 21, '2018-07-07', 'Enregistrement du remboursement -> 10000.0 du membre -> ATEBA ASOMO ATEBA ASOMO', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (131, 1, 2, 10000, 11, 21, '2018-07-07', 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (132, 1, 2, 10000, 9, 21, '2018-07-07', 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (133, 1, 2, 10000, 13, 21, '2018-07-07', 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (134, 10, 2, 35000, NULL, 21, '2018-07-07', 'Enregistrement de la depense -> Frais Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (135, 3, 2, 5000, 9, 29, '2019-03-07', 'Le Membre  ATEBA ASOMO a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (136, 3, 2, 5000, 11, 29, '2019-03-07', 'Le Membre  ERIC a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (137, 3, 2, 5000, 12, 29, '2019-03-07', 'Le Membre  MEBARA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (138, 3, 2, 5000, 13, 29, '2019-03-07', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (139, 3, 2, 5000, 16, 29, '2019-03-07', 'Le Membre  NZANGUE NEPOUDEM a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (140, 8, 2, 10000, 9, 29, '2018-08-07', 'Enregistrement du remboursement -> 10000.0 du membre -> ATEBA ASOMO ATEBA ASOMO', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (141, 1, 2, 10000, 11, 29, '2018-08-07', 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (142, 1, 2, 10000, 12, 29, '2018-08-07', 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (143, 10, 2, 10000, NULL, 29, '2018-08-07', 'Enregistrement de la depense -> Frais de Collation Aout 2018', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (144, 3, 2, 5000, 9, 30, '2019-03-07', 'Le Membre  ATEBA ASOMO a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (145, 3, 2, 5000, 10, 30, '2019-03-07', 'Le Membre  BESSALA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (146, 3, 2, 5000, 11, 30, '2019-03-07', 'Le Membre  ERIC a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (147, 3, 2, 5000, 12, 30, '2019-03-07', 'Le Membre  MEBARA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (148, 3, 2, 5000, 13, 30, '2019-03-07', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (149, 3, 2, 15000, 14, 30, '2019-03-07', 'Le Membre  NDENDE a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (150, 3, 2, 5000, 16, 30, '2019-03-07', 'Le Membre  NZANGUE NEPOUDEM a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (42, 7, 2, 200000, 16, 17, '2018-03-07', 'Enregistrement de l''emprunt -> 200000.0 du membre -> NZANGUE NEPOUDEM NZANGUE NEPOUDEM', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (43, 2, 2, 200000, 9, 17, '2018-03-07', 'Enregistrement de l''epargne  du membre ATEBA ASOMO', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (44, 2, 2, 50000, 14, 17, '2018-03-07', 'Enregistrement de l''epargne  du membre NDENDE', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (45, 2, 2, 50000, 16, 17, '2018-03-07', 'Enregistrement de l''epargne  du membre NZANGUE NEPOUDEM', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (46, 8, 2, 5000, 9, 17, '2018-03-07', 'Enregistrement du remboursement -> 5000.0 du membre -> ATEBA ASOMO ATEBA ASOMO', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (47, 8, 2, 30000, 10, 17, '2018-03-07', 'Enregistrement du remboursement -> 30000.0 du membre -> BESSALA BESSALA', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (48, 1, 2, 10000, 9, 17, '2018-03-07', 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (49, 1, 2, 10000, 11, 17, '2018-03-07', 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (50, 1, 2, 5000, 12, 17, '2018-03-07', 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (51, 1, 2, 15000, 13, 17, '2018-03-07', 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 15000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (52, 1, 2, 20000, 14, 17, '2018-03-07', 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 20000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (53, 1, 2, 5000, 16, 17, '2018-03-07', 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (54, 10, 2, 50100, NULL, 16, '2018-02-07', 'Frais Collation Fevrier', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (55, 10, 2, 41000, NULL, 17, '2018-03-07', 'Enregistrement de la depense -> Frais de collation Mars', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (151, 2, 2, 5000, 12, 30, '2018-09-07', 'Enregistrement de l''epargne  du membre MEBARA', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (152, 2, 2, 25000, 14, 30, '2018-09-07', 'Enregistrement de l''epargne  du membre NDENDE', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (153, 8, 2, 10000, 9, 30, '2018-09-07', 'Enregistrement du remboursement -> 10000.0 du membre -> ATEBA ASOMO ATEBA ASOMO', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (154, 1, 2, 15000, 11, 30, '2018-09-07', 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 15000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (155, 1, 2, 10000, 12, 30, '2018-09-07', 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (156, 1, 2, 11250, 14, 30, '2018-09-07', 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 11250.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (157, 11, 2, 18750, 14, 30, '2018-09-07', 'Enregistrement du fond de la main levée du membre  -> NDENDE Caroline ; Montant -> 18750.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (158, 7, 2, 100000, 13, 31, '2018-10-07', 'Enregistrement de l''emprunt -> 100000.0 du membre -> MFOUAPON MFOUAPON', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (159, 3, 2, 5000, 9, 31, '2019-03-07', 'Le Membre  ATEBA ASOMO a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (160, 3, 2, 5000, 10, 31, '2019-03-07', 'Le Membre  BESSALA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (161, 3, 2, 5000, 11, 31, '2019-03-07', 'Le Membre  ERIC a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (162, 3, 2, 5000, 13, 31, '2019-03-07', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (163, 3, 2, 5000, 14, 31, '2019-03-07', 'Le Membre  NDENDE a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (164, 3, 2, 5000, 16, 31, '2019-03-07', 'Le Membre  NZANGUE NEPOUDEM a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (165, 2, 2, 35000, 14, 31, '2018-10-07', 'Enregistrement de l''epargne  du membre NDENDE', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (166, 17, 2, 500, 13, 31, '2019-03-07', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Frais de Timbre', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (167, 8, 2, 5000, 9, 31, '2018-10-07', 'Enregistrement du remboursement -> 5000.0 du membre -> ATEBA ASOMO ATEBA ASOMO', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (168, 8, 2, 50000, 10, 31, '2018-10-07', 'Enregistrement du remboursement -> 50000.0 du membre -> BESSALA BESSALA', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (169, 1, 2, 25000, 10, 31, '2018-10-07', 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 25000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (170, 1, 2, 10000, 11, 31, '2018-10-07', 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (171, 11, 2, 10000, 14, 31, '2018-10-07', 'Enregistrement du fond de la main levée du membre  -> NDENDE Caroline ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (172, 3, 2, 5000, 9, 32, '2019-03-07', 'Le Membre  ATEBA ASOMO a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (173, 3, 2, 5000, 10, 32, '2019-03-07', 'Le Membre  BESSALA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (174, 3, 2, 5000, 11, 32, '2019-03-07', 'Le Membre  ERIC a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (175, 3, 2, 10000, 12, 32, '2019-03-07', 'Le Membre  MEBARA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (176, 3, 2, 5000, 13, 32, '2019-03-07', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (177, 3, 2, 5000, 14, 32, '2019-03-07', 'Le Membre  NDENDE a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (178, 3, 2, 5000, 16, 32, '2019-03-07', 'Le Membre  NZANGUE NEPOUDEM a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (179, 2, 2, 65000, 14, 32, '2018-11-07', 'Enregistrement de l''epargne  du membre NDENDE', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (180, 16, 2, 7500, 13, 32, '2019-03-07', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Frais d''annonce', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (181, 8, 2, 10000, 9, 32, '2018-11-07', 'Enregistrement du remboursement -> 10000.0 du membre -> ATEBA ASOMO ATEBA ASOMO', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (182, 1, 2, 10000, 13, 32, '2018-11-07', 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (183, 1, 4, 5000, 40, 34, '2019-09-14', 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (184, 1, 4, 5000, 34, 34, '2019-09-14', 'Enregistrement du fond de caisse du membre  -> KOUCHEMOUN ALIMA ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (185, 1, 4, 5000, 33, 34, '2019-09-14', 'Enregistrement du fond de caisse du membre  -> KOUANOU Bakanké ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (186, 1, 4, 5000, 39, 34, '2019-09-14', 'Enregistrement du fond de caisse du membre  -> MFOSSI Rajel ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (187, 1, 4, 5000, 47, 34, '2019-09-14', 'Enregistrement du fond de caisse du membre  -> NJIBOKET Sani ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (188, 1, 4, 4000, 32, 34, '2019-09-14', 'Enregistrement du fond de caisse du membre  -> JUMEMI Gervais ; Montant -> 4000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (189, 1, 4, 1500, 28, 34, '2019-09-14', 'Enregistrement du fond de caisse du membre  -> EMALEU Duplex ; Montant -> 1500.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (190, 1, 4, 1000, 26, 34, '2019-09-14', 'Enregistrement du fond de caisse du membre  -> CHIFFANE - ; Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (191, 9, 4, 1000, 40, 34, '2019-09-16', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Frais d''inscription', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (192, 9, 4, 1000, 34, 34, '2019-09-16', 'Le Membre  KOUCHEMOUN a effectué une opération dans la rubrique caisse Frais d''inscription', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (56, 3, 2, 5000, 9, 18, '2019-03-07', 'Le Membre  ATEBA ASOMO a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (57, 3, 2, 5000, 10, 18, '2019-03-07', 'Le Membre  BESSALA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (58, 11, 2, 0, 10, 18, '2019-03-07', 'Le Membre  BESSALA a effectué une opération dans la rubrique caisse Main Levée', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (59, 3, 2, 5000, 11, 18, '2019-03-07', 'Le Membre  ERIC a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (60, 3, 2, 5000, 13, 18, '2019-03-07', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (61, 3, 2, 5000, 14, 18, '2019-03-07', 'Le Membre  NDENDE a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (62, 3, 2, 5000, 16, 18, '2019-03-07', 'Le Membre  NZANGUE NEPOUDEM a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (63, 2, 2, 140000, 9, 18, '2018-04-07', 'Enregistrement de l''epargne  du membre ATEBA ASOMO', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (64, 2, 2, 30000, 14, 18, '2018-04-07', 'Enregistrement de l''epargne  du membre NDENDE', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (65, 1, 2, 10000, 9, 18, '2018-04-07', 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (66, 1, 2, 10000, 11, 18, '2018-04-07', 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (67, 1, 2, 10000, 14, 18, '2018-04-07', 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (68, 1, 2, 10000, 16, 18, '2018-04-07', 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (69, 1, 2, 250000, 16, 15, '2018-01-07', 'Enregistrement de l''aide  du membre NZANGUE NEPOUDEM Augustin', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (70, 1, 2, 250000, 9, 15, '2018-01-07', 'Enregistrement de l''aide  du membre ATEBA ASOMO Fabien', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (193, 9, 4, 1000, 33, 34, '2019-09-16', 'Le Membre  KOUANOU a effectué une opération dans la rubrique caisse Frais d''inscription', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (194, 9, 4, 1000, 39, 34, '2019-09-16', 'Le Membre  MFOSSI a effectué une opération dans la rubrique caisse Frais d''inscription', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (195, 9, 4, 1000, 47, 34, '2019-09-16', 'Le Membre  NJIBOKET a effectué une opération dans la rubrique caisse Frais d''inscription', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (196, 9, 4, 1000, 28, 34, '2019-09-16', 'Le Membre  EMALEU a effectué une opération dans la rubrique caisse Frais d''inscription', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (197, 9, 4, 1000, 26, 34, '2019-09-16', 'Le Membre  CHIFFANE a effectué une opération dans la rubrique caisse Frais d''inscription', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (198, 9, 4, 1000, 50, 34, '2019-09-16', 'Le Membre  PANCHA a effectué une opération dans la rubrique caisse Frais d''inscription', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (199, 9, 4, 1000, 51, 34, '2019-09-16', 'Le Membre  PANCHUT a effectué une opération dans la rubrique caisse Frais d''inscription', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (200, 9, 4, 1000, 32, 34, '2019-09-16', 'Le Membre  JUMEMI a effectué une opération dans la rubrique caisse Frais d''inscription', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (201, 3, 4, 2000, 40, 34, '2019-09-16', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (71, 18, 2, 50000, NULL, 15, '2018-01-07', 'Enregistrement de la recette -> Reste des intérets à redistribuer', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (72, 1, 2, 310000, 16, 18, '2018-04-07', 'Enregistrement de l''aide  du membre NZANGUE NEPOUDEM Augustin', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (73, 3, 2, 5000, 9, 19, '2019-03-07', 'Le Membre  ATEBA ASOMO a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (74, 3, 2, 5000, 11, 19, '2019-03-07', 'Le Membre  ERIC a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (75, 3, 2, 10000, 12, 19, '2019-03-07', 'Le Membre  MEBARA a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (76, 3, 2, 5000, 13, 19, '2019-03-07', 'Le Membre  MFOUAPON a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (77, 3, 2, 5000, 16, 19, '2019-03-07', 'Le Membre  NZANGUE NEPOUDEM a effectué une opération dans la rubrique caisse Collation', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (78, 10, 2, 26000, NULL, 18, '2018-04-07', 'Enregistrement de la depense -> Frais de collation , Mois de Avril 2019', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (79, 1, 2, 10000, 9, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (80, 1, 2, 20000, 12, 19, '2018-05-07', 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 20000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (81, 1, 2, 340000, 13, 19, '2018-05-07', 'Enregistrement de l''aide  du membre MFOUAPON Henock', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (82, 1, 2, 0, 15, 19, '2018-05-07', 'Enregistrement de l''aide  du membre OLOUGOU Valère', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (83, 11, 2, 5000, 12, 19, '2018-05-07', 'Enregistrement du fond de la main levée du membre  -> MEBARA Marie Gisele ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (84, 11, 2, 5000, 16, 19, '2018-05-07', 'Enregistrement du fond de la main levée du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (85, 11, 2, 0, 15, 19, '2018-05-07', 'Enregistrement du fond de la main levée du membre  -> OLOUGOU Valère ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (86, 11, 2, 5000, 10, 19, '2018-05-07', 'Enregistrement du fond de la main levée du membre  -> BESSALA Protais ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (87, 11, 2, 5000, 9, 19, '2018-05-07', 'Enregistrement du fond de la main levée du membre  -> ATEBA ASOMO Fabien ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (88, 11, 2, 5000, 13, 19, '2018-05-07', 'Enregistrement du fond de la main levée du membre  -> MFOUAPON Henock ; Montant -> 5000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (204, 9, 4, 1000, 29, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> FOUDA Atangana Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (205, 9, 4, 1000, 44, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> NGOUGOURE Rachida Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (206, 9, 4, 1000, 53, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> TAPCHE NDOUNG Ali Junior Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (207, 9, 4, 1000, 54, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> TAPON Emmanuel Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (208, 9, 4, 1000, 36, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> MAH Armand Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (209, 9, 4, 1000, 48, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> NJIMOKE Tapche Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (210, 9, 4, 1000, 37, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> MATAPIT Abiba Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (211, 9, 4, 1000, 25, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> AWA Moustapha Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (212, 9, 4, 1000, 30, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> IBRAHIM - Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (213, 9, 4, 1000, 45, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> NGOUPAYOU Aminatou Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (214, 9, 4, 1000, 43, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> MOUNGNUTOU Mominou Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (215, 9, 4, 1000, 49, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> NJIMOKE Tigana Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (216, 9, 4, 1000, 41, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> MFOUAPON NGAPOUT Allassa Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (217, 9, 4, 1000, 46, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> NJANKOUO TAPON Souleman Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (218, 9, 4, 1000, 31, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> IYA Maimouna Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (219, 9, 4, 1000, 35, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> LIMI Ayouba Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (221, 9, 4, 1000, 42, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> MOUICHE  Fatima Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (222, 9, 4, 1000, 56, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> MFENDOUM NDAM Salif Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (202, 9, 4, 1000, 52, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> Salif Michael  Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (203, 9, 4, 1000, 27, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> Dr Mbouandi - Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (220, 9, 4, 1000, 38, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> MFORAIN Karim Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (224, 9, 5, 1500, 57, 36, '2020-01-01', 'Payement des frais d''inscription du membre -> NKOUCHEMOUN ALIMA Montant -> 1500.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (225, 9, 5, 1500, 58, 36, '2020-01-01', 'Payement des frais d''inscription du membre -> Salif Michael  Montant -> 1500.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (226, 9, 5, 1500, 59, 36, '2020-01-01', 'Payement des frais d''inscription du membre -> Dr Mbouandi - Montant -> 1500.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (227, 9, 5, 1500, 60, 36, '2020-01-01', 'Payement des frais d''inscription du membre -> PANCHA Mohamed Montant -> 1500.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (223, 9, 4, 0, 55, 34, '2019-09-16', 'Payement des frais d''inscription du membre -> BISSABEDE Frida Montant -> 1000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (228, 5, 4, 2000, 50, 34, '2019-09-14', 'Enregistrement du payement de sanction -> 2000.0 du membre -> PANCHA Mohamed', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (229, 5, 4, 2000, 29, 34, '2019-09-14', 'Enregistrement du payement de sanction -> 2000.0 du membre -> FOUDA Atangana', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (230, 20, 5, 0, NULL, NULL, NULL, 'Reliquat de la cotisation : NAL cotisation 25000', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (231, 21, 5, 5000, 58, 36, '2020-01-01', 'Aide de 5000.0 de la caisse au membre Salif pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (232, 21, 5, 5000, 59, 36, '2020-01-01', 'Aide de 5000.0 de la caisse au membre Dr Mbouandi pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (233, 22, 5, 25000, 57, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre NKOUCHEMOUN pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (234, 22, 5, 25000, 57, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre NKOUCHEMOUN pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (235, 22, 5, 25000, 57, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre NKOUCHEMOUN pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (236, 22, 5, 25000, 57, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre NKOUCHEMOUN pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (237, 22, 5, 25000, 57, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre NKOUCHEMOUN pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (238, 22, 5, 25000, 58, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre Salif pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (239, 22, 5, 25000, 58, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre Salif pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (240, 22, 5, 25000, 58, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre Salif pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (241, 22, 5, 25000, 60, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre PANCHA pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (242, 22, 5, 25000, 60, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre PANCHA pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (243, 22, 5, 25000, 60, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre PANCHA pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (244, 22, 5, 25000, 59, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre Dr Mbouandi pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (245, 22, 5, 25000, 59, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre Dr Mbouandi pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (246, 22, 5, 25000, 59, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre Dr Mbouandi pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (247, 22, 5, 25000, 59, 36, '2020-01-01', 'Cotisation de 25000.0 de la caisse au membre Dr Mbouandi pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (248, 23, 5, 300000, 57, 36, '2020-01-01', 'Bouffe de 300000.0 par la main NKOUCHEMOUN - 1 - 55311 pour la tontine : cotisation de 25 mille par mois', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (249, 21, 5, 7000, 60, 38, '2021-01-31', 'Aide de 7000.0 de la caisse au membre PANCHA pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (250, 22, 5, 12000, 57, 38, '2021-01-31', 'Cotisation de 12000.0 par la main NKOUCHEMOUN - 2 - 555931 pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (251, 22, 5, 12000, 57, 38, '2021-01-31', 'Cotisation de 12000.0 par la main NKOUCHEMOUN - 1 - 555930 pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (252, 22, 5, 12000, 57, 38, '2021-01-31', 'Cotisation de 12000.0 par la main NKOUCHEMOUN - 3 - 555932 pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (253, 22, 5, 12000, 58, 38, '2021-01-31', 'Cotisation de 12000.0 par la main Salif - 1 - 5551033 pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (254, 22, 5, 12000, 58, 38, '2021-01-31', 'Cotisation de 12000.0 par la main Salif - 2 - 5551034 pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (255, 22, 5, 12000, 58, 38, '2021-01-31', 'Cotisation de 12000.0 par la main Salif - 3 - 5551042 pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (256, 22, 5, 12000, 59, 38, '2021-01-31', 'Cotisation de 12000.0 par la main Dr Mbouandi - 1 - 5551135 pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (257, 22, 5, 12000, 59, 38, '2021-01-31', 'Cotisation de 12000.0 par la main Dr Mbouandi - 2 - 5551136 pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (258, 22, 5, 12000, 60, 38, '2021-01-31', 'Cotisation de 12000.0 par la main PANCHA - 1 - 5551237 pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (259, 22, 5, 12000, 60, 38, '2021-01-31', 'Cotisation de 12000.0 par la main PANCHA - 2 - 5551238 pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (260, 22, 5, 12000, 60, 38, '2021-01-31', 'Cotisation de 12000.0 par la main PANCHA - 4 - 5551240 pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (261, 22, 5, 12000, 60, 38, '2021-01-31', 'Cotisation de 12000.0 par la main PANCHA - 3 - 5551239 pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (262, 22, 5, 12000, 60, 38, '2021-01-31', 'Cotisation de 12000.0 par la main PANCHA - 5 - 5551241 pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (263, 23, 5, 144000, 57, 38, '2021-01-31', 'Bouffe de 144000.0 par la main NKOUCHEMOUN - 1 - 555930 pour la tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (264, 19, 5, 1200, 60, 38, '2021-02-19', 'Payement de la Pénalité de non cotisation de la main PANCHA - 5 pour le compte de tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (265, 24, 5, 5750, 60, 38, '2021-02-19', 'Remboursement de l''assistance de cotisation + Intérêt par la main PANCHA - 5 pour le compte de tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (266, 25, 5, 5750, 57, 38, '2021-02-19', 'Payement du remboursement de l''assistance au membreNKOUCHEMOUN pour le compte de tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (267, 24, 5, 7000, 60, 38, '2021-02-19', 'Remboursement de l''assistance de cotisation + Intérêt par la main PANCHA - 5 pour le compte de tontine : cotisation test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (268, 1, 5, 20000, 57, 37, '2020-12-01', 'Enregistrement du fond de caisse du membre  -> NKOUCHEMOUN ALIMA ; Montant -> 20000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (269, 1, 5, 15000, 58, 37, '2020-12-01', 'Enregistrement du fond de caisse du membre  -> Salif Michael  ; Montant -> 15000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (270, 1, 5, 15000, 59, 37, '2020-12-01', 'Enregistrement du fond de caisse du membre  -> Dr Mbouandi - ; Montant -> 15000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (271, 1, 5, 10000, 60, 37, '2020-12-01', 'Enregistrement du fond de caisse du membre  -> PANCHA Mohamed ; Montant -> 10000.0', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (272, 12, 5, 30000, 58, 38, '2021-01-31', 'Enregistrement de l''aide  du membre Salif Michael ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (273, 22, 2, 12000, 9, 52, '2021-03-06', 'Cotisation de 12000.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (274, 22, 2, 12000, 11, 52, '2021-03-06', 'Cotisation de 12000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (275, 22, 2, 12000, 10, 52, '2021-03-06', 'Cotisation de 12000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (276, 22, 2, 12000, 12, 52, '2021-03-06', 'Cotisation de 12000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (277, 22, 2, 12000, 14, 52, '2021-03-06', 'Cotisation de 12000.0 par la main NDENDE - 1 - 4261747 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (278, 23, 2, 52500, 9, 52, '2021-03-06', 'Bouffe de 52500.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (279, 26, 2, 7500, 9, 52, '2021-03-06', 'Paiement de l''enchere de 7500.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (280, 22, 2, 12000, 9, 53, '2021-03-13', 'Cotisation de 12000.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (281, 22, 2, 12000, 10, 53, '2021-03-13', 'Cotisation de 12000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (282, 22, 2, 12000, 11, 53, '2021-03-13', 'Cotisation de 12000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (283, 22, 2, 12000, 12, 53, '2021-03-13', 'Cotisation de 12000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (284, 22, 2, 12000, 14, 53, '2021-03-13', 'Cotisation de 12000.0 par la main NDENDE - 1 - 4261747 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (285, 23, 2, 52000, 10, 53, '2021-03-13', 'Bouffe de 52000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (286, 26, 2, 8000, 10, 53, '2021-03-13', 'Paiement de l''enchere de 8000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (287, 22, 2, 12000, 9, 54, '2021-03-20', 'Cotisation de 12000.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (288, 22, 2, 12000, 10, 54, '2021-03-20', 'Cotisation de 12000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (289, 22, 2, 12000, 11, 54, '2021-03-20', 'Cotisation de 12000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (290, 22, 2, 12000, 12, 54, '2021-03-20', 'Cotisation de 12000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (291, 22, 2, 12000, 14, 54, '2021-03-20', 'Cotisation de 12000.0 par la main NDENDE - 1 - 4261747 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (292, 23, 2, 40000, 11, 54, '2021-03-20', 'Bouffe de 40000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (293, 26, 2, 20000, 11, 54, '2021-03-20', 'Paiement de l''enchere de 20000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (294, 22, 2, 12000, 9, 55, '2021-03-27', 'Cotisation de 12000.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (295, 22, 2, 12000, 10, 55, '2021-03-27', 'Cotisation de 12000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (296, 22, 2, 12000, 11, 55, '2021-03-27', 'Cotisation de 12000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (297, 22, 2, 12000, 12, 55, '2021-03-27', 'Cotisation de 12000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (298, 22, 2, 12000, 14, 55, '2021-03-27', 'Cotisation de 12000.0 par la main NDENDE - 1 - 4261747 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (299, 22, 2, 12000, 13, 55, '2021-03-27', 'Cotisation de 12000.0 par la main MFOUAPON - 1 - 4261848 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (300, 22, 2, 12000, 13, 55, '2021-03-27', 'Cotisation de 12000.0 par la main MFOUAPON - 2 - 4261849 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (301, 23, 2, 21000, 13, 55, '2021-03-27', 'Bouffe de 21000.0 par la main MFOUAPON - 2 - 4261849 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (302, 26, 2, 3000, 13, 55, '2021-03-27', 'Paiement de l''enchere de 3000.0 par la main MFOUAPON - 2 - 4261849 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (303, 23, 2, 21000, 13, 55, '2021-03-27', 'Bouffe de 21000.0 par la main MFOUAPON - 1 - 4261848 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (304, 26, 2, 3000, 13, 55, '2021-03-27', 'Paiement de l''enchere de 3000.0 par la main MFOUAPON - 1 - 4261848 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (305, 23, 2, 58000, 12, 55, '2021-03-27', 'Bouffe de 58000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (306, 26, 2, 2000, 12, 55, '2021-03-27', 'Paiement de l''enchere de 2000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (307, 22, 2, 12000, 9, 55, '2021-03-27', 'Cotisation de 12000.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (308, 22, 2, 12000, 10, 55, '2021-03-27', 'Cotisation de 12000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (309, 22, 2, 12000, 11, 55, '2021-03-27', 'Cotisation de 12000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (310, 22, 2, 12000, 12, 55, '2021-03-27', 'Cotisation de 12000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (311, 22, 2, 12000, 14, 55, '2021-03-27', 'Cotisation de 12000.0 par la main NDENDE - 1 - 4261747 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (312, 22, 2, 12000, 13, 55, '2021-03-27', 'Cotisation de 12000.0 par la main MFOUAPON - 1 - 4261848 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (313, 22, 2, 12000, 13, 55, '2021-03-27', 'Cotisation de 12000.0 par la main MFOUAPON - 2 - 4261849 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (314, 23, 2, 21000, 13, 55, '2021-03-27', 'Bouffe de 21000.0 par la main MFOUAPON - 2 - 4261849 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (315, 26, 2, 3000, 13, 55, '2021-03-27', 'Paiement de l''enchere de 3000.0 par la main MFOUAPON - 2 - 4261849 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (316, 23, 2, 21000, 13, 55, '2021-03-27', 'Bouffe de 21000.0 par la main MFOUAPON - 1 - 4261848 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (317, 26, 2, 3000, 13, 55, '2021-03-27', 'Paiement de l''enchere de 3000.0 par la main MFOUAPON - 1 - 4261848 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (318, 23, 2, 58000, 12, 55, '2021-03-27', 'Bouffe de 58000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (319, 26, 2, 2000, 12, 55, '2021-03-27', 'Paiement de l''enchere de 2000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (320, 22, 2, 12000, 9, 52, '2021-03-06', 'Cotisation de 12000.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (321, 22, 2, 12000, 11, 52, '2021-03-06', 'Cotisation de 12000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (322, 22, 2, 12000, 10, 52, '2021-03-06', 'Cotisation de 12000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (323, 22, 2, 12000, 12, 52, '2021-03-06', 'Cotisation de 12000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (324, 22, 2, 12000, 14, 52, '2021-03-06', 'Cotisation de 12000.0 par la main NDENDE - 1 - 4261747 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (325, 23, 2, 52500, 9, 52, '2021-03-06', 'Bouffe de 52500.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (326, 26, 2, 7500, 9, 52, '2021-03-06', 'Paiement de l''enchere de 7500.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (327, 22, 2, 12000, 9, 53, '2021-03-13', 'Cotisation de 12000.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (328, 22, 2, 12000, 10, 53, '2021-03-13', 'Cotisation de 12000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (329, 22, 2, 12000, 11, 53, '2021-03-13', 'Cotisation de 12000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (330, 22, 2, 12000, 12, 53, '2021-03-13', 'Cotisation de 12000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (331, 22, 2, 12000, 14, 53, '2021-03-13', 'Cotisation de 12000.0 par la main NDENDE - 1 - 4261747 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (332, 23, 2, 52000, 10, 53, '2021-03-13', 'Bouffe de 52000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (333, 26, 2, 8000, 10, 53, '2021-03-13', 'Paiement de l''enchere de 8000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (334, 22, 2, 12000, 9, 54, '2021-03-20', 'Cotisation de 12000.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (335, 22, 2, 12000, 10, 54, '2021-03-20', 'Cotisation de 12000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (336, 22, 2, 12000, 11, 54, '2021-03-20', 'Cotisation de 12000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (337, 22, 2, 12000, 12, 54, '2021-03-20', 'Cotisation de 12000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (338, 22, 2, 12000, 14, 54, '2021-03-20', 'Cotisation de 12000.0 par la main NDENDE - 1 - 4261747 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (339, 23, 2, 40000, 11, 54, '2021-03-20', 'Bouffe de 40000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (340, 26, 2, 20000, 11, 54, '2021-03-20', 'Paiement de l''enchere de 20000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (341, 22, 2, 12000, 9, 54, '2021-03-20', 'Cotisation de 12000.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (342, 22, 2, 12000, 10, 54, '2021-03-20', 'Cotisation de 12000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (343, 22, 2, 12000, 11, 54, '2021-03-20', 'Cotisation de 12000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (344, 22, 2, 12000, 12, 54, '2021-03-20', 'Cotisation de 12000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (345, 22, 2, 12000, 14, 54, '2021-03-20', 'Cotisation de 12000.0 par la main NDENDE - 1 - 4261747 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (346, 23, 2, 40000, 11, 54, '2021-03-20', 'Bouffe de 40000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (347, 26, 2, 20000, 11, 54, '2021-03-20', 'Paiement de l''enchere de 20000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (348, 22, 2, 12000, 13, 55, '2021-03-27', 'Cotisation de 12000.0 par la main MFOUAPON - 1 - 4261848 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (349, 22, 2, 12000, 13, 55, '2021-03-27', 'Cotisation de 12000.0 par la main MFOUAPON - 2 - 4261849 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (350, 22, 2, 12000, 9, 55, '2021-03-27', 'Cotisation de 12000.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (351, 22, 2, 12000, 10, 55, '2021-03-27', 'Cotisation de 12000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (352, 22, 2, 12000, 11, 55, '2021-03-27', 'Cotisation de 12000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (353, 22, 2, 12000, 12, 55, '2021-03-27', 'Cotisation de 12000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (354, 22, 2, 12000, 14, 55, '2021-03-27', 'Cotisation de 12000.0 par la main NDENDE - 1 - 4261747 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (355, 23, 2, 58000, 12, 55, '2021-03-27', 'Bouffe de 58000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (356, 26, 2, 2000, 12, 55, '2021-03-27', 'Paiement de l''enchere de 2000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (357, 23, 2, 22000, 13, 55, '2021-03-27', 'Bouffe de 22000.0 par la main MFOUAPON - 1 - 4261848 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (358, 26, 2, 2000, 13, 55, '2021-03-27', 'Paiement de l''enchere de 2000.0 par la main MFOUAPON - 1 - 4261848 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (359, 23, 2, 22000, 13, 55, '2021-03-27', 'Bouffe de 22000.0 par la main MFOUAPON - 2 - 4261849 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (360, 26, 2, 2000, 13, 55, '2021-03-27', 'Paiement de l''enchere de 2000.0 par la main MFOUAPON - 2 - 4261849 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (361, 22, 2, 12000, 9, 56, '2021-04-02', 'Cotisation de 12000.0 par la main ATEBA ASOMO - 1 - 4261343 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (362, 22, 2, 12000, 10, 56, '2021-04-02', 'Cotisation de 12000.0 par la main BESSALA - 1 - 4261444 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (363, 22, 2, 12000, 11, 56, '2021-04-02', 'Cotisation de 12000.0 par la main ERIC - 1 - 4261545 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (364, 22, 2, 12000, 12, 56, '2021-04-02', 'Cotisation de 12000.0 par la main MEBARA - 1 - 4261646 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (365, 22, 2, 12000, 14, 56, '2021-04-02', 'Cotisation de 12000.0 par la main NDENDE - 1 - 4261747 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (366, 22, 2, 12000, 13, 56, '2021-04-02', 'Cotisation de 12000.0 par la main MFOUAPON - 1 - 4261848 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (367, 22, 2, 12000, 13, 56, '2021-04-02', 'Cotisation de 12000.0 par la main MFOUAPON - 2 - 4261849 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (368, 23, 2, 58200, 14, 56, '2021-04-02', 'Bouffe de 58200.0 par la main NDENDE - 1 - 4261747 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (369, 26, 2, 1800, 14, 56, '2021-04-02', 'Paiement de l''enchere de 1800.0 par la main NDENDE - 1 - 4261747 pour la tontine : test', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (370, 27, NULL, 6185.7142857142853, 9, NULL, NULL, 'Cassation de la cotisation test - gains de 6185.714285714285 à la main ATEBA ASOMO - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (371, 27, NULL, 6185.7142857142853, 10, NULL, NULL, 'Cassation de la cotisation test - gains de 6185.714285714285 à la main BESSALA - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (372, 27, NULL, 6185.7142857142853, 11, NULL, NULL, 'Cassation de la cotisation test - gains de 6185.714285714285 à la main ERIC - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (373, 27, NULL, 6185.7142857142853, 12, NULL, NULL, 'Cassation de la cotisation test - gains de 6185.714285714285 à la main MEBARA - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (374, 27, NULL, 6185.7142857142853, 14, NULL, NULL, 'Cassation de la cotisation test - gains de 6185.714285714285 à la main NDENDE - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (375, 27, NULL, 6185.7142857142853, 13, NULL, NULL, 'Cassation de la cotisation test - gains de 6185.714285714285 à la main MFOUAPON - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (376, 27, NULL, 6185.7142857142853, 13, NULL, NULL, 'Cassation de la cotisation test - gains de 6185.714285714285 à la main MFOUAPON - 2', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (377, 21, 2, 5000, 14, 53, '2021-03-13', 'Aide de 5000.0 de la caisse au membre NDENDE pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (378, 22, 2, 15000, 9, 53, '2021-03-13', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 1 - 4271950 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (379, 22, 2, 15000, 9, 53, '2021-03-13', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 2 - 4271951 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (380, 22, 2, 15000, 11, 53, '2021-03-13', 'Cotisation de 15000.0 par la main ERIC - 1 - 4272154 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (381, 22, 2, 15000, 11, 53, '2021-03-13', 'Cotisation de 15000.0 par la main ERIC - 2 - 4272155 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (382, 22, 2, 15000, 12, 53, '2021-03-13', 'Cotisation de 15000.0 par la main MEBARA - 1 - 4272256 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (383, 22, 2, 15000, 13, 53, '2021-03-13', 'Cotisation de 15000.0 par la main MFOUAPON - 1 - 4272357 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (384, 22, 2, 15000, 14, 53, '2021-03-13', 'Cotisation de 15000.0 par la main NDENDE - 1 - 4272458 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (385, 22, 2, 15000, 10, 53, '2021-03-13', 'Cotisation de 15000.0 par la main BESSALA - 1 - 4272052 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (386, 22, 2, 15000, 10, 53, '2021-03-13', 'Cotisation de 15000.0 par la main BESSALA - 2 - 4272053 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (387, 23, 2, 87000, 9, 53, '2021-03-13', 'Bouffe de 87000.0 par la main ATEBA ASOMO - 1 - 4271950 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (388, 26, 2, 3000, 9, 53, '2021-03-13', 'Paiement de l''enchere de 3000.0 par la main ATEBA ASOMO - 1 - 4271950 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (389, 21, 2, 5000, 14, 52, '2021-03-06', 'Aide de 5000.0 de la caisse au membre NDENDE pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (390, 22, 2, 15000, 9, 52, '2021-03-06', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 1 - 4282559 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (391, 22, 2, 15000, 9, 52, '2021-03-06', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 2 - 4282560 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (392, 22, 2, 15000, 10, 52, '2021-03-06', 'Cotisation de 15000.0 par la main BESSALA - 1 - 4282661 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (393, 22, 2, 15000, 11, 52, '2021-03-06', 'Cotisation de 15000.0 par la main ERIC - 1 - 4282762 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (394, 22, 2, 15000, 12, 52, '2021-03-06', 'Cotisation de 15000.0 par la main MEBARA - 1 - 4282863 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (395, 22, 2, 15000, 12, 52, '2021-03-06', 'Cotisation de 15000.0 par la main MEBARA - 2 - 4282864 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (396, 22, 2, 15000, 13, 52, '2021-03-06', 'Cotisation de 15000.0 par la main MFOUAPON - 1 - 4282965 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (397, 22, 2, 15000, 13, 52, '2021-03-06', 'Cotisation de 15000.0 par la main MFOUAPON - 2 - 4282966 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (398, 22, 2, 15000, 13, 52, '2021-03-06', 'Cotisation de 15000.0 par la main MFOUAPON - 3 - 4282967 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (399, 22, 2, 15000, 14, 52, '2021-03-06', 'Cotisation de 15000.0 par la main NDENDE - 1 - 4283068 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (400, 22, 2, 15000, 14, 52, '2021-03-06', 'Cotisation de 15000.0 par la main NDENDE - 2 - 4283069 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (401, 23, 2, 90000, 9, 52, '2021-03-06', 'Bouffe de 90000.0 par la main ATEBA ASOMO - 1 - 4282559 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (402, 21, 2, 5000, 14, 53, '2021-03-13', 'Aide de 5000.0 de la caisse au membre NDENDE pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (403, 22, 2, 15000, 9, 53, '2021-03-13', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 1 - 4282559 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (404, 22, 2, 15000, 9, 53, '2021-03-13', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 2 - 4282560 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (405, 22, 2, 15000, 10, 53, '2021-03-13', 'Cotisation de 15000.0 par la main BESSALA - 1 - 4282661 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (406, 22, 2, 15000, 11, 53, '2021-03-13', 'Cotisation de 15000.0 par la main ERIC - 1 - 4282762 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (407, 22, 2, 15000, 12, 53, '2021-03-13', 'Cotisation de 15000.0 par la main MEBARA - 1 - 4282863 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (408, 22, 2, 15000, 12, 53, '2021-03-13', 'Cotisation de 15000.0 par la main MEBARA - 2 - 4282864 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (409, 22, 2, 15000, 13, 53, '2021-03-13', 'Cotisation de 15000.0 par la main MFOUAPON - 1 - 4282965 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (410, 22, 2, 15000, 13, 53, '2021-03-13', 'Cotisation de 15000.0 par la main MFOUAPON - 2 - 4282966 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (411, 22, 2, 15000, 13, 53, '2021-03-13', 'Cotisation de 15000.0 par la main MFOUAPON - 3 - 4282967 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (412, 22, 2, 15000, 14, 53, '2021-03-13', 'Cotisation de 15000.0 par la main NDENDE - 1 - 4283068 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (413, 22, 2, 15000, 14, 53, '2021-03-13', 'Cotisation de 15000.0 par la main NDENDE - 2 - 4283069 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (414, 23, 2, 90000, 9, 53, '2021-03-13', 'Bouffe de 90000.0 par la main ATEBA ASOMO - 2 - 4282560 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (415, 23, 2, 90000, 10, 53, '2021-03-13', 'Bouffe de 90000.0 par la main BESSALA - 1 - 4282661 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (416, 21, 2, 5000, 14, 54, '2021-03-20', 'Aide de 5000.0 de la caisse au membre NDENDE pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (417, 21, 2, 5000, 14, 54, '2021-03-20', 'Aide de 5000.0 de la caisse au membre NDENDE pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (418, 22, 2, 15000, 9, 54, '2021-03-20', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 1 - 4271950 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (419, 22, 2, 15000, 9, 54, '2021-03-20', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 2 - 4271951 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (420, 22, 2, 15000, 10, 54, '2021-03-20', 'Cotisation de 15000.0 par la main BESSALA - 1 - 4272052 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (421, 22, 2, 15000, 10, 54, '2021-03-20', 'Cotisation de 15000.0 par la main BESSALA - 2 - 4272053 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (422, 22, 2, 15000, 11, 54, '2021-03-20', 'Cotisation de 15000.0 par la main ERIC - 1 - 4272154 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (423, 22, 2, 15000, 11, 54, '2021-03-20', 'Cotisation de 15000.0 par la main ERIC - 2 - 4272155 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (424, 22, 2, 15000, 12, 54, '2021-03-20', 'Cotisation de 15000.0 par la main MEBARA - 1 - 4272256 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (425, 22, 2, 15000, 13, 54, '2021-03-20', 'Cotisation de 15000.0 par la main MFOUAPON - 1 - 4272357 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (426, 22, 2, 15000, 14, 54, '2021-03-20', 'Cotisation de 15000.0 par la main NDENDE - 1 - 4272458 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (427, 23, 2, 87000, 9, 54, '2021-03-20', 'Bouffe de 87000.0 par la main ATEBA ASOMO - 2 - 4271951 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (428, 26, 2, 3000, 9, 54, '2021-03-20', 'Paiement de l''enchere de 3000.0 par la main ATEBA ASOMO - 2 - 4271951 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (429, 23, 2, 87000, 10, 54, '2021-03-20', 'Bouffe de 87000.0 par la main BESSALA - 1 - 4272052 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (430, 26, 2, 3000, 10, 54, '2021-03-20', 'Paiement de l''enchere de 3000.0 par la main BESSALA - 1 - 4272052 pour la tontine : test 2 ', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (431, 21, 2, 5000, 14, 54, '2021-03-20', 'Aide de 5000.0 de la caisse au membre NDENDE pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (432, 21, 2, 5000, 14, 54, '2021-03-20', 'Aide de 5000.0 de la caisse au membre NDENDE pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (433, 22, 2, 15000, 9, 54, '2021-03-20', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 1 - 4282559 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (434, 22, 2, 15000, 9, 54, '2021-03-20', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 2 - 4282560 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (435, 22, 2, 15000, 10, 54, '2021-03-20', 'Cotisation de 15000.0 par la main BESSALA - 1 - 4282661 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (436, 22, 2, 15000, 11, 54, '2021-03-20', 'Cotisation de 15000.0 par la main ERIC - 1 - 4282762 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (437, 22, 2, 15000, 12, 54, '2021-03-20', 'Cotisation de 15000.0 par la main MEBARA - 1 - 4282863 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (438, 22, 2, 15000, 12, 54, '2021-03-20', 'Cotisation de 15000.0 par la main MEBARA - 2 - 4282864 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (439, 22, 2, 15000, 13, 54, '2021-03-20', 'Cotisation de 15000.0 par la main MFOUAPON - 1 - 4282965 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (440, 22, 2, 15000, 13, 54, '2021-03-20', 'Cotisation de 15000.0 par la main MFOUAPON - 2 - 4282966 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (441, 22, 2, 15000, 13, 54, '2021-03-20', 'Cotisation de 15000.0 par la main MFOUAPON - 3 - 4282967 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (442, 22, 2, 15000, 14, 54, '2021-03-20', 'Cotisation de 15000.0 par la main NDENDE - 1 - 4283068 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (443, 22, 2, 15000, 14, 54, '2021-03-20', 'Cotisation de 15000.0 par la main NDENDE - 2 - 4283069 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (444, 23, 2, 90000, 11, 54, '2021-03-20', 'Bouffe de 90000.0 par la main ERIC - 1 - 4282762 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (445, 23, 2, 90000, 12, 54, '2021-03-20', 'Bouffe de 90000.0 par la main MEBARA - 1 - 4282863 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (446, 21, 2, 5000, 14, 56, '2021-04-02', 'Aide de 5000.0 de la caisse au membre NDENDE pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (447, 21, 2, 5000, 14, 56, '2021-04-02', 'Aide de 5000.0 de la caisse au membre NDENDE pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (448, 22, 2, 15000, 9, 56, '2021-04-02', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 1 - 4282559 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (449, 22, 2, 15000, 9, 56, '2021-04-02', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 2 - 4282560 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (450, 22, 2, 15000, 10, 56, '2021-04-02', 'Cotisation de 15000.0 par la main BESSALA - 1 - 4282661 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (451, 22, 2, 15000, 11, 56, '2021-04-02', 'Cotisation de 15000.0 par la main ERIC - 1 - 4282762 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (452, 22, 2, 15000, 12, 56, '2021-04-02', 'Cotisation de 15000.0 par la main MEBARA - 1 - 4282863 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (453, 22, 2, 15000, 12, 56, '2021-04-02', 'Cotisation de 15000.0 par la main MEBARA - 2 - 4282864 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (454, 22, 2, 15000, 13, 56, '2021-04-02', 'Cotisation de 15000.0 par la main MFOUAPON - 1 - 4282965 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (455, 22, 2, 15000, 13, 56, '2021-04-02', 'Cotisation de 15000.0 par la main MFOUAPON - 2 - 4282966 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (456, 22, 2, 15000, 13, 56, '2021-04-02', 'Cotisation de 15000.0 par la main MFOUAPON - 3 - 4282967 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (457, 22, 2, 15000, 14, 56, '2021-04-02', 'Cotisation de 15000.0 par la main NDENDE - 1 - 4283068 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (458, 22, 2, 15000, 14, 56, '2021-04-02', 'Cotisation de 15000.0 par la main NDENDE - 2 - 4283069 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (459, 23, 2, 90000, 12, 56, '2021-04-02', 'Bouffe de 90000.0 par la main MEBARA - 2 - 4282864 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (460, 23, 2, 90000, 13, 56, '2021-04-02', 'Bouffe de 90000.0 par la main MFOUAPON - 1 - 4282965 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (461, 21, 2, 5000, 14, 57, '2021-04-09', 'Aide de 5000.0 de la caisse au membre NDENDE pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (462, 21, 2, 5000, 14, 57, '2021-04-09', 'Aide de 5000.0 de la caisse au membre NDENDE pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (463, 22, 2, 15000, 9, 57, '2021-04-09', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 1 - 4282559 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (464, 22, 2, 15000, 9, 57, '2021-04-09', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 2 - 4282560 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (465, 22, 2, 15000, 10, 57, '2021-04-09', 'Cotisation de 15000.0 par la main BESSALA - 1 - 4282661 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (466, 22, 2, 15000, 11, 57, '2021-04-09', 'Cotisation de 15000.0 par la main ERIC - 1 - 4282762 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (467, 22, 2, 15000, 12, 57, '2021-04-09', 'Cotisation de 15000.0 par la main MEBARA - 1 - 4282863 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (468, 22, 2, 15000, 12, 57, '2021-04-09', 'Cotisation de 15000.0 par la main MEBARA - 2 - 4282864 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (469, 22, 2, 15000, 13, 57, '2021-04-09', 'Cotisation de 15000.0 par la main MFOUAPON - 1 - 4282965 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (470, 22, 2, 15000, 13, 57, '2021-04-09', 'Cotisation de 15000.0 par la main MFOUAPON - 2 - 4282966 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (471, 22, 2, 15000, 13, 57, '2021-04-09', 'Cotisation de 15000.0 par la main MFOUAPON - 3 - 4282967 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (472, 22, 2, 15000, 14, 57, '2021-04-09', 'Cotisation de 15000.0 par la main NDENDE - 1 - 4283068 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (473, 22, 2, 15000, 14, 57, '2021-04-09', 'Cotisation de 15000.0 par la main NDENDE - 2 - 4283069 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (474, 23, 2, 90000, 13, 57, '2021-04-09', 'Bouffe de 90000.0 par la main MFOUAPON - 2 - 4282966 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (475, 23, 2, 90000, 13, 57, '2021-04-09', 'Bouffe de 90000.0 par la main MFOUAPON - 3 - 4282967 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (476, 21, 2, 5000, 14, 58, '2021-04-10', 'Aide de 5000.0 de la caisse au membre NDENDE pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (477, 21, 2, 5000, 14, 58, '2021-04-10', 'Aide de 5000.0 de la caisse au membre NDENDE pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (478, 22, 2, 15000, 9, 58, '2021-04-10', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 1 - 4282559 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (479, 22, 2, 15000, 9, 58, '2021-04-10', 'Cotisation de 15000.0 par la main ATEBA ASOMO - 2 - 4282560 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (480, 22, 2, 15000, 10, 58, '2021-04-10', 'Cotisation de 15000.0 par la main BESSALA - 1 - 4282661 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (698, 23, 2, 102000, 14, 55, '2021-03-27', 'Bouffe de la main NDENDE - 1 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (481, 22, 2, 15000, 11, 58, '2021-04-10', 'Cotisation de 15000.0 par la main ERIC - 1 - 4282762 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (482, 22, 2, 15000, 12, 58, '2021-04-10', 'Cotisation de 15000.0 par la main MEBARA - 1 - 4282863 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (483, 22, 2, 15000, 12, 58, '2021-04-10', 'Cotisation de 15000.0 par la main MEBARA - 2 - 4282864 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (484, 22, 2, 15000, 13, 58, '2021-04-10', 'Cotisation de 15000.0 par la main MFOUAPON - 1 - 4282965 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (485, 22, 2, 15000, 13, 58, '2021-04-10', 'Cotisation de 15000.0 par la main MFOUAPON - 2 - 4282966 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (486, 22, 2, 15000, 13, 58, '2021-04-10', 'Cotisation de 15000.0 par la main MFOUAPON - 3 - 4282967 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (487, 22, 2, 15000, 14, 58, '2021-04-10', 'Cotisation de 15000.0 par la main NDENDE - 1 - 4283068 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (488, 22, 2, 15000, 14, 58, '2021-04-10', 'Cotisation de 15000.0 par la main NDENDE - 2 - 4283069 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (489, 23, 2, 90000, 14, 58, '2021-04-10', 'Bouffe de 90000.0 par la main NDENDE - 1 - 4283068 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (490, 23, 2, 90000, 14, 58, '2021-04-10', 'Bouffe de 90000.0 par la main NDENDE - 2 - 4283069 pour la tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (491, 19, 2, 750, 10, 53, '2021-03-23', 'Payement de la Pénalité de non cotisation de la main BESSALA - 1 pour le compte de tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (492, 24, 2, 3150, 10, 53, '2021-03-23', 'Remboursement de l''assistance de cotisation + Intérêt par la main BESSALA - 1 pour le compte de tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (493, 25, 2, 3150, 9, 53, '2021-03-23', 'Payement du remboursement de l''assistance au membreATEBA ASOMO pour le compte de tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (494, 19, 2, 750, 14, 52, '2021-03-23', 'Payement de la Pénalité de non cotisation de la main NDENDE - 2 pour le compte de tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (495, 24, 2, 5000, 14, 52, '2021-03-23', 'Remboursement de l''assistance de cotisation + Intérêt par la main NDENDE - 2 pour le compte de tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (496, 19, 2, 750, 14, 54, '2021-03-23', 'Payement de la Pénalité de non cotisation de la main NDENDE - 2 pour le compte de tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (497, 24, 2, 5000, 14, 54, '2021-03-23', 'Remboursement de l''assistance de cotisation + Intérêt par la main NDENDE - 2 pour le compte de tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (498, 24, 2, 5250, 14, 54, '2021-03-23', 'Remboursement de l''assistance de cotisation + Intérêt par la main NDENDE - 2 pour le compte de tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (499, 25, 2, 5250, 11, 54, '2021-03-23', 'Payement du remboursement de l''assistance au membreERIC pour le compte de tontine : cotisation sans enchere', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (500, 27, NULL, 0, 9, NULL, NULL, 'Cassation de la cotisation cotisation sans enchere - gains de 0.0 à la main ATEBA ASOMO - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (501, 27, NULL, 0, 9, NULL, NULL, 'Cassation de la cotisation cotisation sans enchere - gains de 0.0 à la main ATEBA ASOMO - 2', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (502, 27, NULL, 0, 10, NULL, NULL, 'Cassation de la cotisation cotisation sans enchere - gains de 0.0 à la main BESSALA - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (503, 27, NULL, 0, 11, NULL, NULL, 'Cassation de la cotisation cotisation sans enchere - gains de 0.0 à la main ERIC - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (504, 27, NULL, 0, 12, NULL, NULL, 'Cassation de la cotisation cotisation sans enchere - gains de 0.0 à la main MEBARA - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (505, 27, NULL, 0, 12, NULL, NULL, 'Cassation de la cotisation cotisation sans enchere - gains de 0.0 à la main MEBARA - 2', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (506, 27, NULL, 0, 13, NULL, NULL, 'Cassation de la cotisation cotisation sans enchere - gains de 0.0 à la main MFOUAPON - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (507, 27, NULL, 0, 13, NULL, NULL, 'Cassation de la cotisation cotisation sans enchere - gains de 0.0 à la main MFOUAPON - 2', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (508, 27, NULL, 0, 13, NULL, NULL, 'Cassation de la cotisation cotisation sans enchere - gains de 0.0 à la main MFOUAPON - 3', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (509, 27, NULL, 0, 14, NULL, NULL, 'Cassation de la cotisation cotisation sans enchere - gains de 0.0 à la main NDENDE - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (510, 27, NULL, 0, 14, NULL, NULL, 'Cassation de la cotisation cotisation sans enchere - gains de 0.0 à la main NDENDE - 2', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (511, 22, 2, 15000, 9, 52, '2021-03-06', 'Cotisation par la main ATEBA ASOMO - 1 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (512, 22, 2, 15000, 9, 52, '2021-03-06', 'Cotisation par la main ATEBA ASOMO - 2 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (513, 22, 2, 15000, 9, 52, '2021-03-06', 'Cotisation par la main ATEBA ASOMO - 3 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (514, 22, 2, 15000, 10, 52, '2021-03-06', 'Cotisation par la main BESSALA - 1 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (515, 22, 2, 15000, 10, 52, '2021-03-06', 'Cotisation par la main BESSALA - 2 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (516, 22, 2, 15000, 10, 52, '2021-03-06', 'Cotisation par la main BESSALA - 3 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (517, 22, 2, 15000, 11, 52, '2021-03-06', 'Cotisation par la main ERIC - 1 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (518, 22, 2, 15000, 11, 52, '2021-03-06', 'Cotisation par la main ERIC - 2 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (519, 22, 2, 15000, 12, 52, '2021-03-06', 'Cotisation par la main MEBARA - 1 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (520, 22, 2, 15000, 12, 52, '2021-03-06', 'Cotisation par la main MEBARA - 2 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (521, 22, 2, 15000, 12, 52, '2021-03-06', 'Cotisation par la main MEBARA - 3 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (522, 22, 2, 15000, 12, 52, '2021-03-06', 'Cotisation par la main MEBARA - 4 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (523, 22, 2, 15000, 13, 52, '2021-03-06', 'Cotisation par la main MFOUAPON - 1 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (524, 22, 2, 15000, 13, 52, '2021-03-06', 'Cotisation par la main MFOUAPON - 2 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (525, 22, 2, 15000, 13, 52, '2021-03-06', 'Cotisation par la main MFOUAPON - 3 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (526, 22, 2, 15000, 14, 52, '2021-03-06', 'Cotisation par la main NDENDE - 1 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (527, 22, 2, 15000, 16, 52, '2021-03-06', 'Cotisation par la main NZANGUE NEPOUDEM - 1 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (528, 22, 2, 15000, 15, 52, '2021-03-06', 'Cotisation par la main OLOUGOU - 1 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (529, 23, 2, 105000, 9, 52, '2021-03-06', 'Bouffe de la main ATEBA ASOMO - 1 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (530, 23, 2, 105000, 10, 52, '2021-03-06', 'Bouffe de la main BESSALA - 1 pour la tontine : cotisation sans enchere', 4);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (531, 22, 2, 15000, 9, 53, '2021-03-13', 'Cotisation par la main ATEBA ASOMO - 1 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (532, 22, 2, 15000, 9, 53, '2021-03-13', 'Cotisation par la main ATEBA ASOMO - 2 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (533, 22, 2, 15000, 9, 53, '2021-03-13', 'Cotisation par la main ATEBA ASOMO - 3 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (534, 22, 2, 15000, 10, 53, '2021-03-13', 'Cotisation par la main BESSALA - 1 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (535, 22, 2, 15000, 10, 53, '2021-03-13', 'Cotisation par la main BESSALA - 2 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (536, 22, 2, 15000, 10, 53, '2021-03-13', 'Cotisation par la main BESSALA - 3 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (537, 22, 2, 15000, 11, 53, '2021-03-13', 'Cotisation par la main ERIC - 1 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (538, 22, 2, 15000, 11, 53, '2021-03-13', 'Cotisation par la main ERIC - 2 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (539, 22, 2, 15000, 12, 53, '2021-03-13', 'Cotisation par la main MEBARA - 1 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (540, 22, 2, 15000, 12, 53, '2021-03-13', 'Cotisation par la main MEBARA - 2 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (541, 22, 2, 15000, 12, 53, '2021-03-13', 'Cotisation par la main MEBARA - 3 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (542, 22, 2, 15000, 12, 53, '2021-03-13', 'Cotisation par la main MEBARA - 4 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (543, 22, 2, 15000, 13, 53, '2021-03-13', 'Cotisation par la main MFOUAPON - 1 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (544, 22, 2, 15000, 13, 53, '2021-03-13', 'Cotisation par la main MFOUAPON - 2 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (545, 22, 2, 15000, 13, 53, '2021-03-13', 'Cotisation par la main MFOUAPON - 3 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (546, 22, 2, 15000, 14, 53, '2021-03-13', 'Cotisation par la main NDENDE - 1 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (547, 22, 2, 15000, 16, 53, '2021-03-13', 'Cotisation par la main NZANGUE NEPOUDEM - 1 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (548, 22, 2, 15000, 15, 53, '2021-03-13', 'Cotisation par la main OLOUGOU - 1 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (549, 23, 2, 105000, 11, 53, '2021-03-13', 'Bouffe de la main ERIC - 1 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (550, 23, 2, 105000, 12, 53, '2021-03-13', 'Bouffe de la main MEBARA - 1 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (551, 23, 2, 105000, 13, 53, '2021-03-13', 'Bouffe de la main MFOUAPON - 1 pour la tontine : cotisation sans enchere', 5);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (552, 21, 2, 2000, 14, 54, '2021-03-20', 'Aide de 2000.0 de la caisse au membre NDENDE pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (553, 22, 2, 25000, 9, 54, '2021-03-20', 'Cotisation par la main ATEBA ASOMO - 1 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (554, 22, 2, 25000, 10, 54, '2021-03-20', 'Cotisation par la main BESSALA - 1 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (555, 22, 2, 25000, 11, 54, '2021-03-20', 'Cotisation par la main ERIC - 1 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (556, 22, 2, 25000, 12, 54, '2021-03-20', 'Cotisation par la main MEBARA - 1 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (557, 22, 2, 25000, 13, 54, '2021-03-20', 'Cotisation par la main MFOUAPON - 1 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (558, 22, 2, 25000, 13, 54, '2021-03-20', 'Cotisation par la main MFOUAPON - 2 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (559, 22, 2, 25000, 14, 54, '2021-03-20', 'Cotisation par la main NDENDE - 1 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (560, 22, 2, 25000, 16, 54, '2021-03-20', 'Cotisation par la main NZANGUE NEPOUDEM - 1 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (561, 22, 2, 25000, 16, 54, '2021-03-20', 'Cotisation par la main NZANGUE NEPOUDEM - 2 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (562, 22, 2, 25000, 16, 54, '2021-03-20', 'Cotisation par la main NZANGUE NEPOUDEM - 3 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (563, 22, 2, 25000, 15, 54, '2021-03-20', 'Cotisation par la main OLOUGOU - 1 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (564, 22, 2, 25000, 15, 54, '2021-03-20', 'Cotisation par la main OLOUGOU - 2 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (565, 22, 2, 25000, 14, 54, '2021-03-20', 'Cotisation par la main NDENDE - 2 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (566, 23, 2, 105000, 9, 54, '2021-03-20', 'Bouffe de la main ATEBA ASOMO - 1 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (567, 26, 2, 20000, 9, 54, '2021-03-20', 'Paiement de l''enchere par la main ATEBA ASOMO - 1 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (568, 23, 2, 103500, 10, 54, '2021-03-20', 'Bouffe de la main BESSALA - 1 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (569, 26, 2, 21500, 10, 54, '2021-03-20', 'Paiement de l''enchere par la main BESSALA - 1 pour la tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (570, 21, 2, 5000, 10, 54, '2021-03-20', 'Aide de 5000.0 de la caisse au membre BESSALA pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (571, 22, 2, 15000, 9, 54, '2021-03-20', 'Cotisation par la main ATEBA ASOMO - 1 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (572, 22, 2, 15000, 9, 54, '2021-03-20', 'Cotisation par la main ATEBA ASOMO - 2 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (573, 22, 2, 15000, 9, 54, '2021-03-20', 'Cotisation par la main ATEBA ASOMO - 3 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (574, 22, 2, 15000, 10, 54, '2021-03-20', 'Cotisation par la main BESSALA - 1 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (575, 22, 2, 15000, 11, 54, '2021-03-20', 'Cotisation par la main ERIC - 1 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (576, 22, 2, 15000, 11, 54, '2021-03-20', 'Cotisation par la main ERIC - 2 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (577, 22, 2, 15000, 12, 54, '2021-03-20', 'Cotisation par la main MEBARA - 1 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (578, 22, 2, 15000, 12, 54, '2021-03-20', 'Cotisation par la main MEBARA - 2 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (579, 22, 2, 15000, 12, 54, '2021-03-20', 'Cotisation par la main MEBARA - 3 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (580, 22, 2, 15000, 12, 54, '2021-03-20', 'Cotisation par la main MEBARA - 4 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (581, 22, 2, 15000, 13, 54, '2021-03-20', 'Cotisation par la main MFOUAPON - 1 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (582, 22, 2, 15000, 13, 54, '2021-03-20', 'Cotisation par la main MFOUAPON - 2 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (583, 22, 2, 15000, 13, 54, '2021-03-20', 'Cotisation par la main MFOUAPON - 3 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (584, 22, 2, 15000, 14, 54, '2021-03-20', 'Cotisation par la main NDENDE - 1 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (585, 22, 2, 15000, 16, 54, '2021-03-20', 'Cotisation par la main NZANGUE NEPOUDEM - 1 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (586, 22, 2, 15000, 15, 54, '2021-03-20', 'Cotisation par la main OLOUGOU - 1 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (587, 22, 2, 15000, 10, 54, '2021-03-20', 'Cotisation par la main BESSALA - 2 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (588, 22, 2, 15000, 10, 54, '2021-03-20', 'Cotisation par la main BESSALA - 3 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (589, 23, 2, 105000, 9, 54, '2021-03-20', 'Bouffe de la main ATEBA ASOMO - 2 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (590, 23, 2, 105000, 10, 54, '2021-03-20', 'Bouffe de la main BESSALA - 2 pour la tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (591, 21, 2, 5000, 10, 55, '2021-03-27', 'Aide de 5000.0 de la caisse au membre BESSALA pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (592, 22, 2, 15000, 9, 55, '2021-03-27', 'Cotisation par la main ATEBA ASOMO - 1 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (593, 22, 2, 15000, 9, 55, '2021-03-27', 'Cotisation par la main ATEBA ASOMO - 2 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (594, 22, 2, 15000, 9, 55, '2021-03-27', 'Cotisation par la main ATEBA ASOMO - 3 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (595, 22, 2, 15000, 10, 55, '2021-03-27', 'Cotisation par la main BESSALA - 1 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (596, 22, 2, 15000, 10, 55, '2021-03-27', 'Cotisation par la main BESSALA - 2 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (597, 22, 2, 15000, 10, 55, '2021-03-27', 'Cotisation par la main BESSALA - 3 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (598, 22, 2, 15000, 11, 55, '2021-03-27', 'Cotisation par la main ERIC - 1 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (599, 22, 2, 15000, 11, 55, '2021-03-27', 'Cotisation par la main ERIC - 2 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (600, 22, 2, 15000, 12, 55, '2021-03-27', 'Cotisation par la main MEBARA - 1 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (601, 22, 2, 15000, 12, 55, '2021-03-27', 'Cotisation par la main MEBARA - 2 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (602, 22, 2, 15000, 12, 55, '2021-03-27', 'Cotisation par la main MEBARA - 3 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (603, 22, 2, 15000, 12, 55, '2021-03-27', 'Cotisation par la main MEBARA - 4 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (604, 22, 2, 15000, 13, 55, '2021-03-27', 'Cotisation par la main MFOUAPON - 1 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (605, 22, 2, 15000, 13, 55, '2021-03-27', 'Cotisation par la main MFOUAPON - 2 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (606, 22, 2, 15000, 13, 55, '2021-03-27', 'Cotisation par la main MFOUAPON - 3 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (607, 22, 2, 15000, 14, 55, '2021-03-27', 'Cotisation par la main NDENDE - 1 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (608, 22, 2, 15000, 16, 55, '2021-03-27', 'Cotisation par la main NZANGUE NEPOUDEM - 1 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (609, 22, 2, 15000, 15, 55, '2021-03-27', 'Cotisation par la main OLOUGOU - 1 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (610, 23, 2, 105000, 16, 55, '2021-03-27', 'Bouffe de la main NZANGUE NEPOUDEM - 1 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (611, 23, 2, 105000, 12, 55, '2021-03-27', 'Bouffe de la main MEBARA - 2 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (612, 23, 2, 105000, 13, 55, '2021-03-27', 'Bouffe de la main MFOUAPON - 2 pour la tontine : cotisation sans enchere', 7);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (613, 21, 2, 5000, 10, 56, '2021-04-02', 'Aide de 5000.0 de la caisse au membre BESSALA pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (614, 22, 2, 15000, 9, 56, '2021-04-02', 'Cotisation par la main ATEBA ASOMO - 1 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (615, 22, 2, 15000, 9, 56, '2021-04-02', 'Cotisation par la main ATEBA ASOMO - 2 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (616, 22, 2, 15000, 9, 56, '2021-04-02', 'Cotisation par la main ATEBA ASOMO - 3 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (617, 22, 2, 15000, 10, 56, '2021-04-02', 'Cotisation par la main BESSALA - 1 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (618, 22, 2, 15000, 10, 56, '2021-04-02', 'Cotisation par la main BESSALA - 2 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (619, 22, 2, 15000, 10, 56, '2021-04-02', 'Cotisation par la main BESSALA - 3 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (620, 22, 2, 15000, 11, 56, '2021-04-02', 'Cotisation par la main ERIC - 1 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (621, 22, 2, 15000, 11, 56, '2021-04-02', 'Cotisation par la main ERIC - 2 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (622, 22, 2, 15000, 12, 56, '2021-04-02', 'Cotisation par la main MEBARA - 1 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (623, 22, 2, 15000, 12, 56, '2021-04-02', 'Cotisation par la main MEBARA - 2 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (624, 22, 2, 15000, 12, 56, '2021-04-02', 'Cotisation par la main MEBARA - 3 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (625, 22, 2, 15000, 12, 56, '2021-04-02', 'Cotisation par la main MEBARA - 4 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (626, 22, 2, 15000, 13, 56, '2021-04-02', 'Cotisation par la main MFOUAPON - 1 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (627, 22, 2, 15000, 13, 56, '2021-04-02', 'Cotisation par la main MFOUAPON - 2 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (628, 22, 2, 15000, 13, 56, '2021-04-02', 'Cotisation par la main MFOUAPON - 3 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (629, 22, 2, 15000, 14, 56, '2021-04-02', 'Cotisation par la main NDENDE - 1 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (630, 22, 2, 15000, 16, 56, '2021-04-02', 'Cotisation par la main NZANGUE NEPOUDEM - 1 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (631, 22, 2, 15000, 15, 56, '2021-04-02', 'Cotisation par la main OLOUGOU - 1 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (632, 23, 2, 105000, 12, 56, '2021-04-02', 'Bouffe de la main MEBARA - 3 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (633, 23, 2, 105000, 14, 56, '2021-04-02', 'Bouffe de la main NDENDE - 1 pour la tontine : cotisation sans enchere', 1);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (634, 21, 2, 5000, 10, 57, '2021-04-09', 'Aide de 5000.0 de la caisse au membre BESSALA pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (635, 22, 2, 15000, 9, 57, '2021-04-09', 'Cotisation par la main ATEBA ASOMO - 1 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (636, 22, 2, 15000, 9, 57, '2021-04-09', 'Cotisation par la main ATEBA ASOMO - 2 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (637, 22, 2, 15000, 9, 57, '2021-04-09', 'Cotisation par la main ATEBA ASOMO - 3 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (638, 22, 2, 15000, 10, 57, '2021-04-09', 'Cotisation par la main BESSALA - 1 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (639, 22, 2, 15000, 10, 57, '2021-04-09', 'Cotisation par la main BESSALA - 2 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (640, 22, 2, 15000, 10, 57, '2021-04-09', 'Cotisation par la main BESSALA - 3 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (641, 22, 2, 15000, 11, 57, '2021-04-09', 'Cotisation par la main ERIC - 1 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (642, 22, 2, 15000, 11, 57, '2021-04-09', 'Cotisation par la main ERIC - 2 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (643, 22, 2, 15000, 12, 57, '2021-04-09', 'Cotisation par la main MEBARA - 1 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (644, 22, 2, 15000, 12, 57, '2021-04-09', 'Cotisation par la main MEBARA - 2 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (645, 22, 2, 15000, 12, 57, '2021-04-09', 'Cotisation par la main MEBARA - 3 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (646, 22, 2, 15000, 12, 57, '2021-04-09', 'Cotisation par la main MEBARA - 4 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (647, 22, 2, 15000, 13, 57, '2021-04-09', 'Cotisation par la main MFOUAPON - 1 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (648, 22, 2, 15000, 13, 57, '2021-04-09', 'Cotisation par la main MFOUAPON - 2 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (649, 22, 2, 15000, 13, 57, '2021-04-09', 'Cotisation par la main MFOUAPON - 3 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (650, 22, 2, 15000, 14, 57, '2021-04-09', 'Cotisation par la main NDENDE - 1 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (651, 22, 2, 15000, 16, 57, '2021-04-09', 'Cotisation par la main NZANGUE NEPOUDEM - 1 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (652, 22, 2, 15000, 15, 57, '2021-04-09', 'Cotisation par la main OLOUGOU - 1 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (653, 23, 2, 105000, 9, 57, '2021-04-09', 'Bouffe de la main ATEBA ASOMO - 3 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (654, 23, 2, 105000, 10, 57, '2021-04-09', 'Bouffe de la main BESSALA - 3 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (655, 23, 2, 105000, 12, 57, '2021-04-09', 'Bouffe de la main MEBARA - 4 pour la tontine : cotisation sans enchere', 2);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (656, 21, 2, 5000, 10, 58, '2021-04-10', 'Aide de 5000.0 de la caisse au membre BESSALA pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (657, 22, 2, 15000, 9, 58, '2021-04-10', 'Cotisation par la main ATEBA ASOMO - 1 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (658, 22, 2, 15000, 9, 58, '2021-04-10', 'Cotisation par la main ATEBA ASOMO - 2 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (659, 22, 2, 15000, 9, 58, '2021-04-10', 'Cotisation par la main ATEBA ASOMO - 3 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (660, 22, 2, 15000, 10, 58, '2021-04-10', 'Cotisation par la main BESSALA - 1 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (661, 22, 2, 15000, 10, 58, '2021-04-10', 'Cotisation par la main BESSALA - 2 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (662, 22, 2, 15000, 10, 58, '2021-04-10', 'Cotisation par la main BESSALA - 3 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (663, 22, 2, 15000, 11, 58, '2021-04-10', 'Cotisation par la main ERIC - 1 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (664, 22, 2, 15000, 11, 58, '2021-04-10', 'Cotisation par la main ERIC - 2 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (665, 22, 2, 15000, 12, 58, '2021-04-10', 'Cotisation par la main MEBARA - 1 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (666, 22, 2, 15000, 12, 58, '2021-04-10', 'Cotisation par la main MEBARA - 2 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (667, 22, 2, 15000, 12, 58, '2021-04-10', 'Cotisation par la main MEBARA - 3 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (668, 22, 2, 15000, 12, 58, '2021-04-10', 'Cotisation par la main MEBARA - 4 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (669, 22, 2, 15000, 13, 58, '2021-04-10', 'Cotisation par la main MFOUAPON - 1 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (670, 22, 2, 15000, 13, 58, '2021-04-10', 'Cotisation par la main MFOUAPON - 2 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (671, 22, 2, 15000, 13, 58, '2021-04-10', 'Cotisation par la main MFOUAPON - 3 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (672, 22, 2, 15000, 14, 58, '2021-04-10', 'Cotisation par la main NDENDE - 1 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (673, 22, 2, 15000, 16, 58, '2021-04-10', 'Cotisation par la main NZANGUE NEPOUDEM - 1 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (674, 22, 2, 15000, 15, 58, '2021-04-10', 'Cotisation par la main OLOUGOU - 1 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (675, 23, 2, 105000, 11, 58, '2021-04-10', 'Bouffe de la main ERIC - 2 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (676, 23, 2, 105000, 13, 58, '2021-04-10', 'Bouffe de la main MFOUAPON - 3 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (677, 23, 2, 105000, 15, 58, '2021-04-10', 'Bouffe de la main OLOUGOU - 1 pour la tontine : cotisation sans enchere', 3);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (678, 21, 2, 2000, 14, 55, '2021-03-27', 'Aide de 2000.0 de la caisse au membre NDENDE pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (679, 22, 2, 25000, 10, 55, '2021-03-27', 'Cotisation par la main BESSALA - 1 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (680, 22, 2, 25000, 11, 55, '2021-03-27', 'Cotisation par la main ERIC - 1 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (681, 22, 2, 25000, 13, 55, '2021-03-27', 'Cotisation par la main MFOUAPON - 1 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (682, 22, 2, 25000, 13, 55, '2021-03-27', 'Cotisation par la main MFOUAPON - 2 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (683, 22, 2, 25000, 14, 55, '2021-03-27', 'Cotisation par la main NDENDE - 1 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (684, 22, 2, 25000, 16, 55, '2021-03-27', 'Cotisation par la main NZANGUE NEPOUDEM - 2 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (685, 22, 2, 25000, 16, 55, '2021-03-27', 'Cotisation par la main NZANGUE NEPOUDEM - 3 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (686, 22, 2, 25000, 15, 55, '2021-03-27', 'Cotisation par la main OLOUGOU - 1 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (687, 22, 2, 25000, 15, 55, '2021-03-27', 'Cotisation par la main OLOUGOU - 2 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (688, 22, 2, 25000, 9, 55, '2021-03-27', 'Cotisation par la main ATEBA ASOMO - 1 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (689, 22, 2, 25000, 16, 55, '2021-03-27', 'Cotisation par la main NZANGUE NEPOUDEM - 1 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (690, 22, 2, 25000, 12, 55, '2021-03-27', 'Cotisation par la main MEBARA - 1 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (691, 22, 2, 25000, 14, 55, '2021-03-27', 'Cotisation par la main NDENDE - 2 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (692, 23, 2, 107000, 11, 55, '2021-03-27', 'Bouffe de la main ERIC - 1 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (693, 26, 2, 18000, 11, 55, '2021-03-27', 'Paiement de l''enchere par la main ERIC - 1 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (694, 23, 2, 105500, 13, 55, '2021-03-27', 'Bouffe de la main MFOUAPON - 1 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (695, 26, 2, 19500, 13, 55, '2021-03-27', 'Paiement de l''enchere par la main MFOUAPON - 1 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (696, 23, 2, 103000, 13, 55, '2021-03-27', 'Bouffe de la main MFOUAPON - 2 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (697, 26, 2, 22000, 13, 55, '2021-03-27', 'Paiement de l''enchere par la main MFOUAPON - 2 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (699, 26, 2, 23000, 14, 55, '2021-03-27', 'Paiement de l''enchere par la main NDENDE - 1 pour la tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (700, 21, 2, 2000, 14, 56, '2021-04-02', 'Aide de 2000.0 de la caisse au membre NDENDE pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (701, 22, 2, 25000, 10, 56, '2021-04-02', 'Cotisation par la main BESSALA - 1 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (702, 22, 2, 25000, 11, 56, '2021-04-02', 'Cotisation par la main ERIC - 1 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (703, 22, 2, 25000, 13, 56, '2021-04-02', 'Cotisation par la main MFOUAPON - 1 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (704, 22, 2, 25000, 13, 56, '2021-04-02', 'Cotisation par la main MFOUAPON - 2 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (705, 22, 2, 25000, 14, 56, '2021-04-02', 'Cotisation par la main NDENDE - 1 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (706, 22, 2, 25000, 14, 56, '2021-04-02', 'Cotisation par la main NDENDE - 2 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (707, 22, 2, 25000, 16, 56, '2021-04-02', 'Cotisation par la main NZANGUE NEPOUDEM - 1 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (708, 22, 2, 25000, 16, 56, '2021-04-02', 'Cotisation par la main NZANGUE NEPOUDEM - 2 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (709, 22, 2, 25000, 16, 56, '2021-04-02', 'Cotisation par la main NZANGUE NEPOUDEM - 3 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (710, 22, 2, 25000, 15, 56, '2021-04-02', 'Cotisation par la main OLOUGOU - 1 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (711, 22, 2, 25000, 15, 56, '2021-04-02', 'Cotisation par la main OLOUGOU - 2 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (712, 22, 2, 25000, 9, 56, '2021-04-02', 'Cotisation par la main ATEBA ASOMO - 1 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (713, 22, 2, 25000, 12, 56, '2021-04-02', 'Cotisation par la main MEBARA - 1 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (714, 23, 2, 110000, 15, 56, '2021-04-02', 'Bouffe de la main OLOUGOU - 1 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (715, 26, 2, 15000, 15, 56, '2021-04-02', 'Paiement de l''enchere par la main OLOUGOU - 1 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (716, 23, 2, 109500, 12, 56, '2021-04-02', 'Bouffe de la main MEBARA - 1 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (717, 26, 2, 15500, 12, 56, '2021-04-02', 'Paiement de l''enchere par la main MEBARA - 1 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (718, 23, 2, 109000, 14, 56, '2021-04-02', 'Bouffe de la main NDENDE - 2 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (719, 26, 2, 16000, 14, 56, '2021-04-02', 'Paiement de l''enchere par la main NDENDE - 2 pour la tontine : Cotisation', 8);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (720, 21, 2, 2000, 14, 57, '2021-04-09', 'Aide de 2000.0 de la caisse au membre NDENDE pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (721, 22, 2, 25000, 9, 57, '2021-04-09', 'Cotisation par la main ATEBA ASOMO - 1 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (722, 22, 2, 25000, 10, 57, '2021-04-09', 'Cotisation par la main BESSALA - 1 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (723, 22, 2, 25000, 11, 57, '2021-04-09', 'Cotisation par la main ERIC - 1 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (724, 22, 2, 25000, 13, 57, '2021-04-09', 'Cotisation par la main MFOUAPON - 1 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (725, 22, 2, 25000, 13, 57, '2021-04-09', 'Cotisation par la main MFOUAPON - 2 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (726, 22, 2, 25000, 14, 57, '2021-04-09', 'Cotisation par la main NDENDE - 1 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (727, 22, 2, 25000, 14, 57, '2021-04-09', 'Cotisation par la main NDENDE - 2 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (728, 22, 2, 25000, 16, 57, '2021-04-09', 'Cotisation par la main NZANGUE NEPOUDEM - 1 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (729, 22, 2, 25000, 16, 57, '2021-04-09', 'Cotisation par la main NZANGUE NEPOUDEM - 2 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (730, 22, 2, 25000, 16, 57, '2021-04-09', 'Cotisation par la main NZANGUE NEPOUDEM - 3 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (731, 22, 2, 25000, 15, 57, '2021-04-09', 'Cotisation par la main OLOUGOU - 1 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (732, 22, 2, 25000, 15, 57, '2021-04-09', 'Cotisation par la main OLOUGOU - 2 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (733, 22, 2, 25000, 12, 57, '2021-04-09', 'Cotisation par la main MEBARA - 1 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (734, 23, 2, 110000, 16, 57, '2021-04-09', 'Bouffe de la main NZANGUE NEPOUDEM - 1 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (735, 26, 2, 15000, 16, 57, '2021-04-09', 'Paiement de l''enchere par la main NZANGUE NEPOUDEM - 1 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (736, 23, 2, 109500, 16, 57, '2021-04-09', 'Bouffe de la main NZANGUE NEPOUDEM - 2 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (737, 26, 2, 15500, 16, 57, '2021-04-09', 'Paiement de l''enchere par la main NZANGUE NEPOUDEM - 2 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (738, 23, 2, 109000, 16, 57, '2021-04-09', 'Bouffe de la main NZANGUE NEPOUDEM - 3 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (739, 26, 2, 16000, 16, 57, '2021-04-09', 'Paiement de l''enchere par la main NZANGUE NEPOUDEM - 3 pour la tontine : Cotisation', 9);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (740, 21, 2, 2000, 14, 58, '2021-04-10', 'Aide de 2000.0 de la caisse au membre NDENDE pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (741, 22, 2, 25000, 9, 58, '2021-04-10', 'Cotisation par la main ATEBA ASOMO - 1 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (742, 22, 2, 25000, 10, 58, '2021-04-10', 'Cotisation par la main BESSALA - 1 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (743, 22, 2, 25000, 11, 58, '2021-04-10', 'Cotisation par la main ERIC - 1 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (744, 22, 2, 25000, 13, 58, '2021-04-10', 'Cotisation par la main MFOUAPON - 1 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (745, 22, 2, 25000, 13, 58, '2021-04-10', 'Cotisation par la main MFOUAPON - 2 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (746, 22, 2, 25000, 14, 58, '2021-04-10', 'Cotisation par la main NDENDE - 1 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (747, 22, 2, 25000, 14, 58, '2021-04-10', 'Cotisation par la main NDENDE - 2 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (748, 22, 2, 25000, 16, 58, '2021-04-10', 'Cotisation par la main NZANGUE NEPOUDEM - 1 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (749, 22, 2, 25000, 16, 58, '2021-04-10', 'Cotisation par la main NZANGUE NEPOUDEM - 2 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (750, 22, 2, 25000, 16, 58, '2021-04-10', 'Cotisation par la main NZANGUE NEPOUDEM - 3 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (751, 22, 2, 25000, 15, 58, '2021-04-10', 'Cotisation par la main OLOUGOU - 1 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (752, 22, 2, 25000, 15, 58, '2021-04-10', 'Cotisation par la main OLOUGOU - 2 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (753, 22, 2, 25000, 12, 58, '2021-04-10', 'Cotisation par la main MEBARA - 1 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (754, 23, 2, 110000, 15, 58, '2021-04-10', 'Bouffe de la main OLOUGOU - 2 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (755, 26, 2, 15000, 15, 58, '2021-04-10', 'Paiement de l''enchere par la main OLOUGOU - 2 pour la tontine : Cotisation', 10);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (756, 19, 2, 3000, 10, 54, '2021-03-25', 'Payement de la Pénalité de non cotisation de la main BESSALA - 2 pour le compte de tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (757, 24, 2, 5000, 10, 54, '2021-03-25', 'Remboursement de l''assistance de cotisation + Intérêt par la main BESSALA - 2 pour le compte de tontine : cotisation sans enchere', 6);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (758, 19, 2, 0, 12, 55, '2021-03-25', 'Payement de la Pénalité de non cotisation de la main MEBARA - 1 pour le compte de tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (759, 24, 2, 10000, 12, 55, '2021-03-25', 'Remboursement de l''assistance de cotisation + Intérêt par la main MEBARA - 1 pour le compte de tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (760, 25, 2, 10000, 13, 55, '2021-03-25', 'Payement du remboursement de l''assistance au membreMFOUAPON pour le compte de tontine : Cotisation', 12);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (761, 19, 2, 0, 14, 54, '2021-03-25', 'Payement de la Pénalité de non cotisation de la main NDENDE - 2 pour le compte de tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (762, 24, 2, 2000, 14, 54, '2021-03-25', 'Remboursement de l''assistance de cotisation + Intérêt par la main NDENDE - 2 pour le compte de tontine : Cotisation', 11);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (763, 27, NULL, 17846.153846153848, 9, NULL, NULL, 'Cassation de la cotisation Cotisation - gains de 17846.153846153848 à la main ATEBA ASOMO - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (764, 27, NULL, 17846.153846153848, 10, NULL, NULL, 'Cassation de la cotisation Cotisation - gains de 17846.153846153848 à la main BESSALA - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (765, 27, NULL, 17846.153846153848, 11, NULL, NULL, 'Cassation de la cotisation Cotisation - gains de 17846.153846153848 à la main ERIC - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (766, 27, NULL, 17846.153846153848, 12, NULL, NULL, 'Cassation de la cotisation Cotisation - gains de 17846.153846153848 à la main MEBARA - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (767, 27, NULL, 17846.153846153848, 13, NULL, NULL, 'Cassation de la cotisation Cotisation - gains de 17846.153846153848 à la main MFOUAPON - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (768, 27, NULL, 17846.153846153848, 13, NULL, NULL, 'Cassation de la cotisation Cotisation - gains de 17846.153846153848 à la main MFOUAPON - 2', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (769, 27, NULL, 17846.153846153848, 14, NULL, NULL, 'Cassation de la cotisation Cotisation - gains de 17846.153846153848 à la main NDENDE - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (770, 27, NULL, 17846.153846153848, 14, NULL, NULL, 'Cassation de la cotisation Cotisation - gains de 17846.153846153848 à la main NDENDE - 2', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (771, 27, NULL, 17846.153846153848, 16, NULL, NULL, 'Cassation de la cotisation Cotisation - gains de 17846.153846153848 à la main NZANGUE NEPOUDEM - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (772, 27, NULL, 17846.153846153848, 16, NULL, NULL, 'Cassation de la cotisation Cotisation - gains de 17846.153846153848 à la main NZANGUE NEPOUDEM - 2', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (773, 27, NULL, 17846.153846153848, 16, NULL, NULL, 'Cassation de la cotisation Cotisation - gains de 17846.153846153848 à la main NZANGUE NEPOUDEM - 3', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (774, 27, NULL, 17846.153846153848, 15, NULL, NULL, 'Cassation de la cotisation Cotisation - gains de 17846.153846153848 à la main OLOUGOU - 1', NULL);
INSERT INTO caisse (idcaisse, idrubriquecaisse, idcycle, montant, idmembrecycle, idrencontre, dateoperation, libelleoperation, idtontiner) VALUES (775, 27, NULL, 17846.153846153848, 15, NULL, NULL, 'Cassation de la cotisation Cotisation - gains de 17846.153846153848 à la main OLOUGOU - 2', NULL);


--
-- TOC entry 2753 (class 0 OID 522461)
-- Dependencies: 189
-- Data for Name: calcul_interet; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (1, 10, 17, 300000, 30000, 300000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (2, 9, 17, 50000, 5000, 50000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (3, 16, 18, 200000, 20000, 200000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (4, 9, 18, 50000, 5000, 50000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (5, 10, 18, 300000, 30000, 300000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (6, 16, 19, 200000, 40000, 200000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (7, 9, 19, 50000, 10000, 50000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (8, 10, 19, 300000, 60000, 300000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (9, 16, 20, 200000, 60000, 200000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (10, 9, 20, 50000, 15000, 50000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (11, 10, 20, 300000, 90000, 300000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (12, 9, 21, 150000, 30000, 150000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (13, 16, 21, 200000, 80000, 200000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (14, 10, 21, 300000, 90000, 300000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (15, 9, 29, 150000, 35000, 150000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (16, 16, 29, 200000, 100000, 200000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (17, 10, 29, 300000, 120000, 300000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (18, 9, 30, 150000, 40000, 150000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (19, 16, 30, 200000, 120000, 200000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (20, 10, 30, 300000, 150000, 300000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (21, 9, 31, 150000, 45000, 150000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (22, 16, 31, 200000, 140000, 200000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (23, 10, 31, 300000, 180000, 300000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (24, 13, 32, 100000, 10000, 100000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (25, 9, 32, 150000, 55000, 150000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (26, 16, 32, 200000, 160000, 200000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (27, 10, 32, 300000, 160000, 300000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (28, 13, 33, 100000, 20000, 100000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (29, 9, 33, 150000, 60000, 150000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (30, 16, 33, 200000, 180000, 200000);
INSERT INTO calcul_interet (id, idmembre, idrencontre, montant_initial_emprunt, montant_interet, reste_capital) VALUES (31, 10, 33, 300000, 190000, 300000);


--
-- TOC entry 2754 (class 0 OID 522466)
-- Dependencies: 190
-- Data for Name: cassation; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cassation (id, idmembre, montant_epargne, nombre_point, montant_gain, idcycle, montant_rembourse, montant_interet, montant_emprunte, duree, coef_epargne, pourcentage_gain, reste_capital, reste_interet, redevance_cotisation, redevance_main_laivee, redevance_secours, net_a_percevoir, gain_normal, gain_tontine, redevance_absence) VALUES (1, 9, 1140000, 38, 285000, 2, 0, 50000, 150000, 38, 114, 78.514953592299747, 150000, 110000, 0, 61250, 22500, 1131250, 478941.21691302845, 193941.21691302845, 0);
INSERT INTO cassation (id, idmembre, montant_epargne, nombre_point, montant_gain, idcycle, montant_rembourse, montant_interet, montant_emprunte, duree, coef_epargne, pourcentage_gain, reste_capital, reste_interet, redevance_cotisation, redevance_main_laivee, redevance_secours, net_a_percevoir, gain_normal, gain_tontine, redevance_absence) VALUES (2, 10, 0, 0, 0, 2, 0, 110000, 300000, 0, 0, 0, 300000, 300000, 0, 61250, 56250, -607500, 0, 0, 0);
INSERT INTO cassation (id, idmembre, montant_epargne, nombre_point, montant_gain, idcycle, montant_rembourse, montant_interet, montant_emprunte, duree, coef_epargne, pourcentage_gain, reste_capital, reste_interet, redevance_cotisation, redevance_main_laivee, redevance_secours, net_a_percevoir, gain_normal, gain_tontine, redevance_absence) VALUES (3, 11, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 61250, 48750, -110000, 0, 0, 0);
INSERT INTO cassation (id, idmembre, montant_epargne, nombre_point, montant_gain, idcycle, montant_rembourse, montant_interet, montant_emprunte, duree, coef_epargne, pourcentage_gain, reste_capital, reste_interet, redevance_cotisation, redevance_main_laivee, redevance_secours, net_a_percevoir, gain_normal, gain_tontine, redevance_absence) VALUES (4, 12, 25000, 0.5, 6250, 2, 0, 0, 0, 19, 2.5, 1.2031625988312133, 0, 0, 0, 61250, 53750, -83750, 7339.2918528704022, 1089.2918528704022, 0);
INSERT INTO cassation (id, idmembre, montant_epargne, nombre_point, montant_gain, idcycle, montant_rembourse, montant_interet, montant_emprunte, duree, coef_epargne, pourcentage_gain, reste_capital, reste_interet, redevance_cotisation, redevance_main_laivee, redevance_secours, net_a_percevoir, gain_normal, gain_tontine, redevance_absence) VALUES (5, 13, 0, 0, 0, 2, 0, 0, 100000, 0, 0, 0, 100000, 20000, 0, 61250, 28750, -210000, 0, 0, 0);
INSERT INTO cassation (id, idmembre, montant_epargne, nombre_point, montant_gain, idcycle, montant_rembourse, montant_interet, montant_emprunte, duree, coef_epargne, pourcentage_gain, reste_capital, reste_interet, redevance_cotisation, redevance_main_laivee, redevance_secours, net_a_percevoir, gain_normal, gain_tontine, redevance_absence) VALUES (6, 14, 405000, 8.3000000000000007, 101250, 2, 0, 0, 0, 39, 40.5, 17.188037126160193, 0, 0, 0, 37500, 0, 468750, 104847.02646957718, 3597.0264695771766, 0);
INSERT INTO cassation (id, idmembre, montant_epargne, nombre_point, montant_gain, idcycle, montant_rembourse, montant_interet, montant_emprunte, duree, coef_epargne, pourcentage_gain, reste_capital, reste_interet, redevance_cotisation, redevance_main_laivee, redevance_secours, net_a_percevoir, gain_normal, gain_tontine, redevance_absence) VALUES (7, 16, 50000, 1.5, 12500, 2, 0, 0, 200000, 9, 5, 3.0938466827088345, 200000, 180000, 0, 61250, 41250, -420000, 18872.464764523891, 6372.4647645238911, 0);
INSERT INTO cassation (id, idmembre, montant_epargne, nombre_point, montant_gain, idcycle, montant_rembourse, montant_interet, montant_emprunte, duree, coef_epargne, pourcentage_gain, reste_capital, reste_interet, redevance_cotisation, redevance_main_laivee, redevance_secours, net_a_percevoir, gain_normal, gain_tontine, redevance_absence) VALUES (8, 15, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66250, 106250, -172500, 0, 0, 0);
INSERT INTO cassation (id, idmembre, montant_epargne, nombre_point, montant_gain, idcycle, montant_rembourse, montant_interet, montant_emprunte, duree, coef_epargne, pourcentage_gain, reste_capital, reste_interet, redevance_cotisation, redevance_main_laivee, redevance_secours, net_a_percevoir, gain_normal, gain_tontine, redevance_absence) VALUES (9, 57, 0, 0, 0, 5, 0, 0, 0, 0, 0, 'NaN', 0, 0, 0, 0, 20000, -20000, 'NaN', 'NaN', 0);
INSERT INTO cassation (id, idmembre, montant_epargne, nombre_point, montant_gain, idcycle, montant_rembourse, montant_interet, montant_emprunte, duree, coef_epargne, pourcentage_gain, reste_capital, reste_interet, redevance_cotisation, redevance_main_laivee, redevance_secours, net_a_percevoir, gain_normal, gain_tontine, redevance_absence) VALUES (10, 58, 0, 0, 0, 5, 0, 0, 0, 0, 0, 'NaN', 0, 0, 0, 0, 20000, -20000, 'NaN', 'NaN', 0);
INSERT INTO cassation (id, idmembre, montant_epargne, nombre_point, montant_gain, idcycle, montant_rembourse, montant_interet, montant_emprunte, duree, coef_epargne, pourcentage_gain, reste_capital, reste_interet, redevance_cotisation, redevance_main_laivee, redevance_secours, net_a_percevoir, gain_normal, gain_tontine, redevance_absence) VALUES (11, 59, 0, 0, 0, 5, 0, 0, 0, 0, 0, 'NaN', 0, 0, 0, 0, 20000, -20000, 'NaN', 'NaN', 0);
INSERT INTO cassation (id, idmembre, montant_epargne, nombre_point, montant_gain, idcycle, montant_rembourse, montant_interet, montant_emprunte, duree, coef_epargne, pourcentage_gain, reste_capital, reste_interet, redevance_cotisation, redevance_main_laivee, redevance_secours, net_a_percevoir, gain_normal, gain_tontine, redevance_absence) VALUES (12, 60, 0, 0, 0, 5, 0, 0, 0, 0, 0, 'NaN', 0, 0, 0, 0, 20000, -20000, 'NaN', 'NaN', 0);


--
-- TOC entry 2755 (class 0 OID 522477)
-- Dependencies: 191
-- Data for Name: cassation_detail; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (1, 9, 2, 140000, '2018-04-07', '2018-12-07', 14, 8, 3.73);
INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (2, 9, 2, 200000, '2018-03-07', '2018-12-07', 20, 9, 6);
INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (3, 9, 2, 300000, '2018-02-07', '2018-12-07', 30, 10, 10);
INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (4, 9, 2, 500000, '2018-01-07', '2018-12-07', 50, 11, 18.329999999999998);
INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (5, 12, 2, 5000, '2018-09-07', '2018-12-07', 0.5, 3, 0.050000000000000003);
INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (6, 12, 2, 10000, '2018-06-07', '2018-12-07', 1, 6, 0.20000000000000001);
INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (7, 12, 2, 10000, '2018-02-07', '2018-12-07', 1, 10, 0.33000000000000002);
INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (8, 14, 2, 65000, '2018-11-07', '2018-12-07', 6.5, 1, 0.20999999999999999);
INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (9, 14, 2, 35000, '2018-10-07', '2018-12-07', 3.5, 2, 0.23000000000000001);
INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (10, 14, 2, 25000, '2018-09-07', '2018-12-07', 2.5, 3, 0.25);
INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (11, 14, 2, 100000, '2018-06-07', '2018-12-07', 10, 6, 2);
INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (12, 14, 2, 30000, '2018-04-07', '2018-12-07', 3, 8, 0.80000000000000004);
INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (13, 14, 2, 50000, '2018-03-07', '2018-12-07', 5, 9, 1.5);
INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (14, 14, 2, 100000, '2018-02-07', '2018-12-07', 10, 10, 3.3300000000000001);
INSERT INTO cassation_detail (id, idmembre, idcycle, montant, date_epargne, date_calcul, coef_epargne, duree, nombre_point) VALUES (15, 16, 2, 50000, '2018-03-07', '2018-12-07', 5, 9, 1.5);


--
-- TOC entry 2756 (class 0 OID 522480)
-- Dependencies: 192
-- Data for Name: cassationtontine; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cassationtontine (idcassation, idcaisse, idmain, montant) VALUES (1, 763, 19, 17846.153846153848);
INSERT INTO cassationtontine (idcassation, idcaisse, idmain, montant) VALUES (2, 764, 20, 17846.153846153848);
INSERT INTO cassationtontine (idcassation, idcaisse, idmain, montant) VALUES (3, 765, 21, 17846.153846153848);
INSERT INTO cassationtontine (idcassation, idcaisse, idmain, montant) VALUES (4, 766, 22, 17846.153846153848);
INSERT INTO cassationtontine (idcassation, idcaisse, idmain, montant) VALUES (5, 767, 23, 17846.153846153848);
INSERT INTO cassationtontine (idcassation, idcaisse, idmain, montant) VALUES (6, 768, 24, 17846.153846153848);
INSERT INTO cassationtontine (idcassation, idcaisse, idmain, montant) VALUES (7, 769, 25, 17846.153846153848);
INSERT INTO cassationtontine (idcassation, idcaisse, idmain, montant) VALUES (8, 770, 26, 17846.153846153848);
INSERT INTO cassationtontine (idcassation, idcaisse, idmain, montant) VALUES (9, 771, 27, 17846.153846153848);
INSERT INTO cassationtontine (idcassation, idcaisse, idmain, montant) VALUES (10, 772, 28, 17846.153846153848);
INSERT INTO cassationtontine (idcassation, idcaisse, idmain, montant) VALUES (11, 773, 29, 17846.153846153848);
INSERT INTO cassationtontine (idcassation, idcaisse, idmain, montant) VALUES (12, 774, 30, 17846.153846153848);
INSERT INTO cassationtontine (idcassation, idcaisse, idmain, montant) VALUES (13, 775, 31, 17846.153846153848);


--
-- TOC entry 2757 (class 0 OID 522483)
-- Dependencies: 193
-- Data for Name: collecte_main_levee; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO collecte_main_levee (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (1, 12, 83, 5000, 19, 'Main levée Voir BB O.Valer (Rappel 2016)');
INSERT INTO collecte_main_levee (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (2, 16, 84, 5000, 19, 'Main levée Voir BB O.Valer (Rappel 2016)');
INSERT INTO collecte_main_levee (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (3, 15, 85, 0, 19, 'Main levée Voir BB O.Valer (Rappel 2016)');
INSERT INTO collecte_main_levee (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (4, 10, 86, 5000, 19, 'Main levée Voir BB O.Valer (Rappel 2016)');
INSERT INTO collecte_main_levee (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (5, 9, 87, 5000, 19, 'Main levée Voir BB O.Valer (Rappel 2016)');
INSERT INTO collecte_main_levee (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (6, 13, 88, 5000, 19, 'Main levée Voir BB O.Valer (Rappel 2016)');
INSERT INTO collecte_main_levee (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (7, 11, 89, 5000, 19, 'Correctif-Main levée Voir BB O.Valer (Rappel 2016)');
INSERT INTO collecte_main_levee (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (8, 14, 157, 18750, 30, 'Recuperation dans secours pour main levée');
INSERT INTO collecte_main_levee (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (9, 14, 171, 10000, 31, '');


--
-- TOC entry 2758 (class 0 OID 522489)
-- Dependencies: 194
-- Data for Name: collecte_secours; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (1, 9, 9, 31250, 15, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (2, 10, 10, 32500, 15, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (3, 13, 11, 20000, 15, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (4, 14, 12, 42500, 15, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (5, 9, 22, 10000, 16, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (6, 10, 23, 10000, 16, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (7, 12, 24, 30000, 16, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (8, 13, 25, 10000, 16, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (9, 14, 26, 10000, 16, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (10, 16, 27, 40000, 16, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (11, 9, 48, 10000, 17, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (12, 11, 49, 10000, 17, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (13, 12, 50, 5000, 17, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (14, 13, 51, 15000, 17, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (15, 14, 52, 20000, 17, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (16, 16, 53, 5000, 17, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (17, 9, 65, 10000, 18, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (18, 11, 66, 10000, 18, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (19, 14, 67, 10000, 18, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (20, 16, 68, 10000, 18, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (21, 9, 79, 10000, 19, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (22, 12, 80, 20000, 19, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (23, 9, 90, 90000, 19, 'Recap Secours 2016');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (24, 10, 91, 90000, 19, 'Recap Secours 20116');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (25, 16, 92, 110000, 19, 'Recap Secours 20116');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (26, 13, 93, 110000, 19, 'Recap Secours 20116');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (27, 15, 94, 120000, 19, 'Recap Secours 20116');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (28, 14, 95, 110000, 19, 'Recap Secours 20116');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (29, 12, 96, 110000, 19, 'Recap Secours 20116');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (30, 11, 97, 140000, 19, 'Recap Secours 2017');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (31, 9, 98, 60000, 19, 'Recap Secours 2017');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (32, 10, 99, 50000, 19, 'Recap Secours 2017');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (33, 16, 100, 47500, 19, 'Recap Secours 2017');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (34, 13, 101, 50000, 19, 'Recap Secours 2017');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (35, 15, 102, 37500, 19, 'Recap Secours 2017');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (36, 14, 103, 40000, 19, 'Recap Secours 2017');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (37, 12, 104, 20000, 19, 'Recap Secours 2017');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (38, 9, 118, 10000, 20, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (39, 11, 119, 10000, 20, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (40, 12, 120, 5000, 20, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (41, 13, 121, 10000, 20, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (42, 14, 122, 20000, 20, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (43, 16, 123, 10000, 20, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (44, 11, 131, 10000, 21, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (45, 9, 132, 10000, 21, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (46, 13, 133, 10000, 21, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (47, 11, 141, 10000, 29, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (48, 12, 142, 10000, 29, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (49, 11, 154, 15000, 30, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (50, 12, 155, 10000, 30, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (51, 14, 156, 11250, 30, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (52, 10, 169, 25000, 31, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (53, 11, 170, 10000, 31, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (54, 13, 182, 10000, 32, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (55, 40, 183, 5000, 34, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (56, 34, 184, 5000, 34, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (57, 33, 185, 5000, 34, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (58, 39, 186, 5000, 34, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (59, 47, 187, 5000, 34, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (60, 32, 188, 4000, 34, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (61, 28, 189, 1500, 34, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (62, 26, 190, 1000, 34, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (63, 57, 268, 20000, 37, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (64, 58, 269, 15000, 37, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (65, 59, 270, 15000, 37, '');
INSERT INTO collecte_secours (id, idmembre, idcaisse, montant, idrencontre, observation) VALUES (66, 60, 271, 10000, 37, '');


--
-- TOC entry 2759 (class 0 OID 522495)
-- Dependencies: 195
-- Data for Name: compteutilisateur; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO compteutilisateur (idcompte, idmembre, login, password, etat, idutilisateur) VALUES (3, 17, 'admin', '21232f297a57a5a743894a0e4a801fc3', true, 17);


--
-- TOC entry 2760 (class 0 OID 522501)
-- Dependencies: 196
-- Data for Name: cotisation; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cotisation (idcotisation, montant, nom, nbretours, redevance, premierjour, penalite_non_cotisation, penalite_non_cotisation_a_bouffe, interet_assistance_cotisation, can_enchered, enchere_min, enchere_max, idtontine, date_enregistrement, est_termine, reliquat) VALUES (1, 15000, 'cotisation sans enchere', 7, NULL, 52, 10, 20, 10, false, NULL, NULL, 4, '2021-03-24', true, 0);
INSERT INTO cotisation (idcotisation, montant, nom, nbretours, redevance, premierjour, penalite_non_cotisation, penalite_non_cotisation_a_bouffe, interet_assistance_cotisation, can_enchered, enchere_min, enchere_max, idtontine, date_enregistrement, est_termine, reliquat) VALUES (2, 25000, 'Cotisation', 5, NULL, 54, 0, 0, 0, true, 50, 200, 4, '2021-03-24', true, 232000);


--
-- TOC entry 2761 (class 0 OID 522509)
-- Dependencies: 197
-- Data for Name: cotisation_tontine; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (1, 15000, 4, 0, 15000, 1, 511);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (2, 15000, 4, 0, 15000, 2, 512);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (3, 15000, 4, 0, 15000, 3, 513);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (4, 15000, 4, 0, 15000, 4, 514);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (5, 15000, 4, 0, 15000, 5, 515);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (6, 15000, 4, 0, 15000, 6, 516);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (7, 15000, 4, 0, 15000, 7, 517);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (8, 15000, 4, 0, 15000, 8, 518);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (9, 15000, 4, 0, 15000, 9, 519);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (10, 15000, 4, 0, 15000, 10, 520);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (11, 15000, 4, 0, 15000, 11, 521);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (12, 15000, 4, 0, 15000, 12, 522);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (13, 15000, 4, 0, 15000, 13, 523);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (14, 15000, 4, 0, 15000, 14, 524);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (15, 15000, 4, 0, 15000, 15, 525);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (16, 15000, 4, 0, 15000, 16, 526);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (17, 15000, 4, 0, 15000, 17, 527);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (18, 15000, 4, 0, 15000, 18, 528);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (19, 15000, 5, 0, 15000, 1, 531);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (20, 15000, 5, 0, 15000, 2, 532);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (21, 15000, 5, 0, 15000, 3, 533);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (22, 15000, 5, 0, 15000, 4, 534);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (23, 15000, 5, 0, 15000, 5, 535);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (24, 15000, 5, 0, 15000, 6, 536);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (25, 15000, 5, 0, 15000, 7, 537);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (26, 15000, 5, 0, 15000, 8, 538);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (27, 15000, 5, 0, 15000, 9, 539);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (28, 15000, 5, 0, 15000, 10, 540);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (29, 15000, 5, 0, 15000, 11, 541);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (30, 15000, 5, 0, 15000, 12, 542);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (31, 15000, 5, 0, 15000, 13, 543);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (32, 15000, 5, 0, 15000, 14, 544);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (33, 15000, 5, 0, 15000, 15, 545);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (34, 15000, 5, 0, 15000, 16, 546);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (35, 15000, 5, 0, 15000, 17, 547);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (36, 15000, 5, 0, 15000, 18, 548);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (40, 15000, 6, 0, 15000, 4, 574);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (55, 25000, 11, 0, 25000, 19, 553);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (56, 25000, 11, 0, 25000, 20, 554);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (57, 25000, 11, 0, 25000, 21, 555);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (58, 25000, 11, 0, 25000, 22, 556);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (59, 25000, 11, 0, 25000, 23, 557);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (60, 25000, 11, 0, 25000, 24, 558);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (61, 25000, 11, 0, 25000, 25, 559);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (63, 25000, 11, 0, 25000, 27, 560);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (64, 25000, 11, 0, 25000, 28, 561);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (65, 25000, 11, 0, 25000, 29, 562);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (66, 25000, 11, 0, 25000, 30, 563);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (67, 25000, 11, 0, 25000, 31, 564);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (62, 23000, 11, 2000, 25000, 26, 565);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (37, 15000, 6, 0, 15000, 1, 571);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (38, 15000, 6, 0, 15000, 2, 572);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (39, 15000, 6, 0, 15000, 3, 573);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (43, 15000, 6, 0, 15000, 7, 575);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (44, 15000, 6, 0, 15000, 8, 576);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (45, 15000, 6, 0, 15000, 9, 577);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (46, 15000, 6, 0, 15000, 10, 578);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (47, 15000, 6, 0, 15000, 11, 579);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (48, 15000, 6, 0, 15000, 12, 580);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (49, 15000, 6, 0, 15000, 13, 581);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (50, 15000, 6, 0, 15000, 14, 582);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (51, 15000, 6, 0, 15000, 15, 583);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (52, 15000, 6, 0, 15000, 16, 584);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (53, 15000, 6, 0, 15000, 17, 585);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (54, 15000, 6, 0, 15000, 18, 586);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (41, 10000, 6, 5000, 15000, 5, 587);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (42, 15000, 6, -5000, 15000, 6, 588);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (69, 25000, 12, 0, 25000, 20, 679);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (70, 25000, 12, 0, 25000, 21, 680);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (72, 25000, 12, 0, 25000, 23, 681);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (73, 25000, 12, 0, 25000, 24, 682);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (74, 25000, 12, 0, 25000, 25, 683);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (76, 25000, 12, 0, 25000, 28, 684);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (77, 25000, 12, 0, 25000, 29, 685);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (78, 25000, 12, 0, 25000, 30, 686);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (79, 25000, 12, 0, 25000, 31, 687);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (68, 25000, 12, 0, 25000, 19, 688);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (75, 25000, 12, 0, 25000, 27, 689);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (71, 15000, 12, 10000, 25000, 22, 690);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (80, 15000, 7, 0, 15000, 1, 592);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (81, 15000, 7, 0, 15000, 2, 593);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (82, 15000, 7, 0, 15000, 3, 594);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (83, 15000, 7, 0, 15000, 4, 595);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (84, 15000, 7, 0, 15000, 5, 596);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (85, 15000, 7, 0, 15000, 6, 597);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (86, 15000, 7, 0, 15000, 7, 598);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (87, 15000, 7, 0, 15000, 8, 599);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (88, 15000, 7, 0, 15000, 9, 600);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (89, 15000, 7, 0, 15000, 10, 601);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (90, 15000, 7, 0, 15000, 11, 602);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (91, 15000, 7, 0, 15000, 12, 603);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (92, 15000, 7, 0, 15000, 13, 604);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (93, 15000, 7, 0, 15000, 14, 605);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (94, 15000, 7, 0, 15000, 15, 606);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (95, 15000, 7, 0, 15000, 16, 607);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (96, 15000, 7, 0, 15000, 17, 608);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (97, 15000, 7, 0, 15000, 18, 609);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (98, 15000, 1, 0, 15000, 1, 614);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (99, 15000, 1, 0, 15000, 2, 615);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (100, 15000, 1, 0, 15000, 3, 616);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (101, 15000, 1, 0, 15000, 4, 617);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (102, 15000, 1, 0, 15000, 5, 618);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (103, 15000, 1, 0, 15000, 6, 619);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (104, 15000, 1, 0, 15000, 7, 620);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (105, 15000, 1, 0, 15000, 8, 621);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (106, 15000, 1, 0, 15000, 9, 622);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (107, 15000, 1, 0, 15000, 10, 623);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (108, 15000, 1, 0, 15000, 11, 624);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (109, 15000, 1, 0, 15000, 12, 625);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (110, 15000, 1, 0, 15000, 13, 626);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (111, 15000, 1, 0, 15000, 14, 627);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (112, 15000, 1, 0, 15000, 15, 628);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (113, 15000, 1, 0, 15000, 16, 629);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (114, 15000, 1, 0, 15000, 17, 630);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (115, 15000, 1, 0, 15000, 18, 631);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (116, 15000, 2, 0, 15000, 1, 635);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (117, 15000, 2, 0, 15000, 2, 636);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (118, 15000, 2, 0, 15000, 3, 637);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (119, 15000, 2, 0, 15000, 4, 638);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (120, 15000, 2, 0, 15000, 5, 639);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (121, 15000, 2, 0, 15000, 6, 640);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (122, 15000, 2, 0, 15000, 7, 641);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (123, 15000, 2, 0, 15000, 8, 642);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (124, 15000, 2, 0, 15000, 9, 643);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (125, 15000, 2, 0, 15000, 10, 644);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (126, 15000, 2, 0, 15000, 11, 645);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (127, 15000, 2, 0, 15000, 12, 646);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (128, 15000, 2, 0, 15000, 13, 647);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (129, 15000, 2, 0, 15000, 14, 648);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (130, 15000, 2, 0, 15000, 15, 649);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (131, 15000, 2, 0, 15000, 16, 650);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (132, 15000, 2, 0, 15000, 17, 651);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (133, 15000, 2, 0, 15000, 18, 652);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (134, 15000, 3, 0, 15000, 1, 657);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (135, 15000, 3, 0, 15000, 2, 658);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (136, 15000, 3, 0, 15000, 3, 659);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (137, 15000, 3, 0, 15000, 4, 660);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (138, 15000, 3, 0, 15000, 5, 661);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (139, 15000, 3, 0, 15000, 6, 662);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (140, 15000, 3, 0, 15000, 7, 663);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (141, 15000, 3, 0, 15000, 8, 664);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (142, 15000, 3, 0, 15000, 9, 665);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (143, 15000, 3, 0, 15000, 10, 666);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (144, 15000, 3, 0, 15000, 11, 667);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (145, 15000, 3, 0, 15000, 12, 668);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (146, 15000, 3, 0, 15000, 13, 669);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (147, 15000, 3, 0, 15000, 14, 670);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (148, 15000, 3, 0, 15000, 15, 671);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (149, 15000, 3, 0, 15000, 16, 672);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (150, 15000, 3, 0, 15000, 17, 673);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (151, 15000, 3, 0, 15000, 18, 674);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (152, 25000, 12, 0, 25000, 26, 691);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (154, 25000, 8, 0, 25000, 20, 701);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (165, 25000, 9, 0, 25000, 19, 721);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (166, 25000, 9, 0, 25000, 20, 722);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (167, 25000, 9, 0, 25000, 21, 723);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (168, 25000, 9, -10000, 25000, 23, 724);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (169, 25000, 9, 0, 25000, 24, 725);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (170, 25000, 9, 0, 25000, 25, 726);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (171, 25000, 9, 0, 25000, 26, 727);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (172, 25000, 9, 0, 25000, 27, 728);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (173, 25000, 9, 0, 25000, 28, 729);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (155, 25000, 8, 0, 25000, 21, 702);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (156, 25000, 8, -10000, 25000, 23, 703);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (157, 25000, 8, 0, 25000, 24, 704);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (158, 25000, 8, 0, 25000, 25, 705);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (159, 25000, 8, 0, 25000, 26, 706);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (160, 25000, 8, 0, 25000, 27, 707);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (161, 25000, 8, 0, 25000, 28, 708);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (162, 25000, 8, 0, 25000, 29, 709);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (163, 25000, 8, 0, 25000, 30, 710);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (164, 25000, 8, 0, 25000, 31, 711);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (153, 25000, 8, 0, 25000, 19, 712);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (189, 25000, 8, 0, 25000, 22, 713);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (174, 25000, 9, 0, 25000, 29, 730);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (175, 25000, 9, 0, 25000, 30, 731);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (176, 25000, 9, 0, 25000, 31, 732);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (190, 25000, 9, 0, 25000, 22, 733);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (177, 25000, 10, 0, 25000, 19, 741);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (178, 25000, 10, 0, 25000, 20, 742);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (179, 25000, 10, 0, 25000, 21, 743);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (180, 25000, 10, -10000, 25000, 23, 744);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (181, 25000, 10, 0, 25000, 24, 745);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (182, 25000, 10, 0, 25000, 25, 746);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (183, 25000, 10, 0, 25000, 26, 747);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (184, 25000, 10, 0, 25000, 27, 748);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (185, 25000, 10, 0, 25000, 28, 749);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (186, 25000, 10, 0, 25000, 29, 750);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (187, 25000, 10, 0, 25000, 30, 751);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (188, 25000, 10, 0, 25000, 31, 752);
INSERT INTO cotisation_tontine (idcotisationtontine, a_cotise, idtontiner, reste, doit_cotiser, idmain, idcaisse) VALUES (191, 25000, 10, 0, 25000, 22, 753);


--
-- TOC entry 2762 (class 0 OID 522512)
-- Dependencies: 198
-- Data for Name: cycletontine; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cycletontine (idcycle, nomfr, nomen, idtontine, nombremembre, fraisadhesion, tauxavaliste, taux_interet_default, unite_emprunt, id_pas_emprunt, montant_cotisation, montant_min_retard, montant_abs_non_just, montant_secours, transfere, proportion_gain) VALUES (0, '-', '-', 4, 5, NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, false, 25);
INSERT INTO cycletontine (idcycle, nomfr, nomen, idtontine, nombremembre, fraisadhesion, tauxavaliste, taux_interet_default, unite_emprunt, id_pas_emprunt, montant_cotisation, montant_min_retard, montant_abs_non_just, montant_secours, transfere, proportion_gain) VALUES (1, 'SEPT 2017', 'SEPT 2017', 4, 1, 2000, 0, 10, 1000, 3, 10000, 10, 2000, 0, false, 25);
INSERT INTO cycletontine (idcycle, nomfr, nomen, idtontine, nombremembre, fraisadhesion, tauxavaliste, taux_interet_default, unite_emprunt, id_pas_emprunt, montant_cotisation, montant_min_retard, montant_abs_non_just, montant_secours, transfere, proportion_gain) VALUES (2, 'SEPT 2018', 'SEPT 2018', 4, 1, 2000, 0, 10, 10000, 3, 10000, 25, 1000, 120000, false, 25);
INSERT INTO cycletontine (idcycle, nomfr, nomen, idtontine, nombremembre, fraisadhesion, tauxavaliste, taux_interet_default, unite_emprunt, id_pas_emprunt, montant_cotisation, montant_min_retard, montant_abs_non_just, montant_secours, transfere, proportion_gain) VALUES (3, 'SEPT 2016', 'SEPT 2016', 4, 1, 2000, 0, 10, 10000, 3, NULL, 50, 1000, 120000, false, 25);
INSERT INTO cycletontine (idcycle, nomfr, nomen, idtontine, nombremembre, fraisadhesion, tauxavaliste, taux_interet_default, unite_emprunt, id_pas_emprunt, montant_cotisation, montant_min_retard, montant_abs_non_just, montant_secours, transfere, proportion_gain) VALUES (6, 'NAL 2021', 'NAL 2021', 5, 0, 0, 10, 10, 10000, 3, 0, 10, 500, 100000, false, 25);
INSERT INTO cycletontine (idcycle, nomfr, nomen, idtontine, nombremembre, fraisadhesion, tauxavaliste, taux_interet_default, unite_emprunt, id_pas_emprunt, montant_cotisation, montant_min_retard, montant_abs_non_just, montant_secours, transfere, proportion_gain) VALUES (5, 'NAL 2020', 'NAL 2020', 5, NULL, 1500, 0, 5, 5000, 3, NULL, 10, 1000, 20000, false, 25);
INSERT INTO cycletontine (idcycle, nomfr, nomen, idtontine, nombremembre, fraisadhesion, tauxavaliste, taux_interet_default, unite_emprunt, id_pas_emprunt, montant_cotisation, montant_min_retard, montant_abs_non_just, montant_secours, transfere, proportion_gain) VALUES (4, 'NAL 2019', 'NAL 2019', 5, NULL, 1000, 0, 10, 10000, 3, NULL, 5, 2000, 20000, false, 25);


--
-- TOC entry 2763 (class 0 OID 522524)
-- Dependencies: 199
-- Data for Name: depense; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO depense (iddepense, date, montant, idrencontre, idrubriquecaisse, observation, idcycle, idcaisse) VALUES (1, '2018-01-07', 50000, 15, 10, 'Frais de Collation Mois de Janvier 2008', 2, 13);
INSERT INTO depense (iddepense, date, montant, idrencontre, idrubriquecaisse, observation, idcycle, idcaisse) VALUES (2, '2018-02-07', 50100, 16, 10, 'Frais Collation Fevrier', 2, 54);
INSERT INTO depense (iddepense, date, montant, idrencontre, idrubriquecaisse, observation, idcycle, idcaisse) VALUES (3, '2018-03-07', 41000, 17, 10, 'Frais de collation Mars', 2, 55);
INSERT INTO depense (iddepense, date, montant, idrencontre, idrubriquecaisse, observation, idcycle, idcaisse) VALUES (4, '2018-04-07', 26000, 18, 10, 'Frais de collation , Mois de Avril 2019', 2, 78);
INSERT INTO depense (iddepense, date, montant, idrencontre, idrubriquecaisse, observation, idcycle, idcaisse) VALUES (5, '2018-06-07', 3750, 20, 14, 'Remboursement correctif Eric Sur Assistance BB Olougou Valer', 2, 105);
INSERT INTO depense (iddepense, date, montant, idrencontre, idrubriquecaisse, observation, idcycle, idcaisse) VALUES (6, '2018-07-07', 35000, 21, 10, 'Frais Collation', 2, 134);
INSERT INTO depense (iddepense, date, montant, idrencontre, idrubriquecaisse, observation, idcycle, idcaisse) VALUES (7, '2018-08-07', 10000, 29, 10, 'Frais de Collation Aout 2018', 2, 143);


--
-- TOC entry 2764 (class 0 OID 522530)
-- Dependencies: 200
-- Data for Name: devise; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO devise (iddevices, nom_fr, nom_en) VALUES (1, 'Fcfa', 'Fcfa');
INSERT INTO devise (iddevices, nom_fr, nom_en) VALUES (2, 'Euro', 'Euro');


--
-- TOC entry 2765 (class 0 OID 522536)
-- Dependencies: 201
-- Data for Name: emprunt; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO emprunt (idemprunt, idtypeinteret, idmembre, montantemp, dateemprunt, observtaion, taux, idrencontre, taux_interet, rembourse, montant_remboursable, date_dernier_remboursement, cumul_interet, date_dernier_remboursement_int, idcaisse) VALUES (3, 2, 16, 200000, '2018-03-07', '', 10, 17, 10, false, 200000, '2018-03-07', 0, '2018-03-07', 42);
INSERT INTO emprunt (idemprunt, idtypeinteret, idmembre, montantemp, dateemprunt, observtaion, taux, idrencontre, taux_interet, rembourse, montant_remboursable, date_dernier_remboursement, cumul_interet, date_dernier_remboursement_int, idcaisse) VALUES (1, 2, 9, 50000, '2018-02-07', '', 10, 16, 10, false, 50000, '2018-03-07', 0, '2018-03-07', 31);
INSERT INTO emprunt (idemprunt, idtypeinteret, idmembre, montantemp, dateemprunt, observtaion, taux, idrencontre, taux_interet, rembourse, montant_remboursable, date_dernier_remboursement, cumul_interet, date_dernier_remboursement_int, idcaisse) VALUES (5, 2, 13, 100000, '2018-10-07', '', 10, 31, 10, false, 100000, '2018-10-07', 0, '2018-10-07', 158);
INSERT INTO emprunt (idemprunt, idtypeinteret, idmembre, montantemp, dateemprunt, observtaion, taux, idrencontre, taux_interet, rembourse, montant_remboursable, date_dernier_remboursement, cumul_interet, date_dernier_remboursement_int, idcaisse) VALUES (2, 2, 10, 300000, '2018-02-07', '', 10, 16, 10, false, 300000, '2018-10-07', 130000, '2018-10-07', 32);
INSERT INTO emprunt (idemprunt, idtypeinteret, idmembre, montantemp, dateemprunt, observtaion, taux, idrencontre, taux_interet, rembourse, montant_remboursable, date_dernier_remboursement, cumul_interet, date_dernier_remboursement_int, idcaisse) VALUES (4, 2, 9, 100000, '2018-06-07', '', 10, 20, 10, false, 100000, '2018-11-07', 5000, '2018-11-07', 116);


--
-- TOC entry 2766 (class 0 OID 522543)
-- Dependencies: 202
-- Data for Name: encherebenficiare; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO encherebenficiare (idenchere, idcaisse, idbeneficiaire, montant, termine) VALUES (1, 567, 20, 20000, true);
INSERT INTO encherebenficiare (idenchere, idcaisse, idbeneficiaire, montant, termine) VALUES (2, 569, 21, 21500, true);
INSERT INTO encherebenficiare (idenchere, idcaisse, idbeneficiaire, montant, termine) VALUES (3, 693, 22, 18000, true);
INSERT INTO encherebenficiare (idenchere, idcaisse, idbeneficiaire, montant, termine) VALUES (4, 695, 23, 19500, true);
INSERT INTO encherebenficiare (idenchere, idcaisse, idbeneficiaire, montant, termine) VALUES (5, 697, 24, 22000, true);
INSERT INTO encherebenficiare (idenchere, idcaisse, idbeneficiaire, montant, termine) VALUES (6, 699, 25, 23000, true);
INSERT INTO encherebenficiare (idenchere, idcaisse, idbeneficiaire, montant, termine) VALUES (7, 715, 26, 15000, true);
INSERT INTO encherebenficiare (idenchere, idcaisse, idbeneficiaire, montant, termine) VALUES (8, 717, 27, 15500, true);
INSERT INTO encherebenficiare (idenchere, idcaisse, idbeneficiaire, montant, termine) VALUES (9, 719, 28, 16000, true);
INSERT INTO encherebenficiare (idenchere, idcaisse, idbeneficiaire, montant, termine) VALUES (10, 735, 29, 15000, true);
INSERT INTO encherebenficiare (idenchere, idcaisse, idbeneficiaire, montant, termine) VALUES (11, 737, 30, 15500, true);
INSERT INTO encherebenficiare (idenchere, idcaisse, idbeneficiaire, montant, termine) VALUES (12, 739, 31, 16000, true);
INSERT INTO encherebenficiare (idenchere, idcaisse, idbeneficiaire, montant, termine) VALUES (13, 755, 32, 15000, true);


--
-- TOC entry 2767 (class 0 OID 522546)
-- Dependencies: 203
-- Data for Name: encours_emprunt; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (1, 300000, 30000, 0, 30000, 30000, 1);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (2, 50000, 5000, 0, 5000, 5000, 2);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (3, 200000, 20000, 0, 0, 0, 3);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (4, 50000, 5000, 0, 0, 0, 4);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (5, 300000, 30000, 0, 0, 0, 5);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (6, 200000, 40000, 0, 0, 0, 6);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (7, 50000, 10000, 0, 0, 0, 7);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (8, 300000, 60000, 0, 0, 0, 8);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (9, 200000, 60000, 0, 0, 0, 9);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (10, 50000, 15000, 0, 0, 0, 10);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (11, 300000, 90000, 0, 30000, 30000, 11);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (12, 150000, 30000, 0, 10000, 10000, 12);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (13, 200000, 80000, 0, 0, 0, 13);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (14, 300000, 90000, 0, 0, 0, 14);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (15, 150000, 35000, 0, 10000, 10000, 15);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (16, 200000, 100000, 0, 0, 0, 16);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (17, 300000, 120000, 0, 0, 0, 17);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (18, 150000, 40000, 0, 10000, 10000, 18);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (19, 200000, 120000, 0, 0, 0, 19);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (20, 300000, 150000, 0, 0, 0, 20);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (21, 150000, 45000, 0, 5000, 5000, 21);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (22, 200000, 140000, 0, 0, 0, 22);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (23, 300000, 180000, 0, 50000, 50000, 23);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (24, 100000, 10000, 0, 0, 0, 24);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (25, 150000, 55000, 0, 10000, 10000, 25);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (26, 200000, 160000, 0, 0, 0, 26);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (27, 300000, 160000, 0, 0, 0, 27);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (28, 100000, 20000, 0, 0, 0, 28);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (29, 150000, 60000, 0, 0, 0, 29);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (30, 200000, 180000, 0, 0, 0, 30);
INSERT INTO encours_emprunt (id_encours_emprunt, solde_capital, solde_interet, capital_rembourse, interet_rembourse, total, id_calcul_interet) VALUES (31, 300000, 190000, 0, 0, 0, 31);


--
-- TOC entry 2768 (class 0 OID 522549)
-- Dependencies: 204
-- Data for Name: encours_secours; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (1, 88750, 10000, 78750, '34.37%', 9, 16);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (2, 87500, 10000, 77500, '35.41%', 10, 16);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (3, 120000, 0, 120000, '0.0%', 11, 16);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (4, 120000, 30000, 90000, '25.0%', 12, 16);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (5, 100000, 10000, 90000, '25.0%', 13, 16);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (6, 77500, 10000, 67500, '43.75%', 14, 16);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (7, 120000, 40000, 80000, '33.33%', 16, 16);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (8, 120000, 0, 120000, '0.0%', 15, 16);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (9, 78750, 10000, 68750, '42.7%', 9, 17);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (10, 77500, 0, 77500, '35.41%', 10, 17);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (11, 120000, 10000, 110000, '8.33%', 11, 17);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (12, 90000, 5000, 85000, '29.16%', 12, 17);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (13, 90000, 15000, 75000, '37.5%', 13, 17);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (14, 67500, 20000, 47500, '60.41%', 14, 17);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (15, 80000, 5000, 75000, '37.5%', 16, 17);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (16, 120000, 0, 120000, '0.0%', 15, 17);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (17, 170000, 10000, 160000, '-33.34%', 9, 18);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (18, 178750, 0, 178750, '-48.96%', 10, 18);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (19, 211250, 10000, 201250, '-67.71%', 11, 18);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (20, 186250, 0, 186250, '-55.21%', 12, 18);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (21, 176250, 0, 176250, '-46.88%', 13, 18);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (22, 148750, 10000, 138750, '-15.63%', 14, 18);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (23, 176250, 10000, 166250, '-38.55%', 16, 18);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (24, 221250, 0, 221250, '-84.38%', 15, 18);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (25, 202500, 160000, 42500, '64.58%', 9, 19);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (26, 221250, 140000, 81250, '32.29%', 10, 19);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (27, 243750, 140000, 103750, '13.54%', 11, 19);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (28, 228750, 150000, 78750, '34.37%', 12, 19);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (29, 218750, 160000, 58750, '51.04%', 13, 19);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (30, 181250, 150000, 31250, '73.95%', 14, 19);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (31, 208750, 157500, 51250, '57.29%', 16, 19);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (32, 263750, 157500, 106250, '11.45%', 15, 19);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (33, 42500, 10000, 32500, '72.91%', 9, 20);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (34, 81250, 0, 81250, '32.29%', 10, 20);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (35, 103750, 10000, 93750, '21.87%', 11, 20);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (36, 78750, 5000, 73750, '38.54%', 12, 20);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (37, 58750, 10000, 48750, '59.37%', 13, 20);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (38, 31250, 20000, 11250, '90.62%', 14, 20);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (39, 51250, 10000, 41250, '65.62%', 16, 20);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (40, 106250, 0, 106250, '11.45%', 15, 20);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (41, 32500, 10000, 22500, '81.25%', 9, 21);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (42, 81250, 0, 81250, '32.29%', 10, 21);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (43, 93750, 10000, 83750, '30.2%', 11, 21);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (44, 73750, 0, 73750, '38.54%', 12, 21);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (45, 48750, 10000, 38750, '67.7%', 13, 21);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (46, 11250, 0, 11250, '90.62%', 14, 21);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (47, 41250, 0, 41250, '65.62%', 16, 21);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (48, 106250, 0, 106250, '11.45%', 15, 21);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (49, 22500, 0, 22500, '81.25%', 9, 29);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (50, 81250, 0, 81250, '32.29%', 10, 29);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (51, 83750, 10000, 73750, '38.54%', 11, 29);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (52, 73750, 10000, 63750, '46.87%', 12, 29);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (53, 38750, 0, 38750, '67.7%', 13, 29);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (54, 11250, 0, 11250, '90.62%', 14, 29);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (55, 41250, 0, 41250, '65.62%', 16, 29);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (56, 106250, 0, 106250, '11.45%', 15, 29);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (57, 22500, 0, 22500, '81.25%', 9, 30);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (58, 81250, 0, 81250, '32.29%', 10, 30);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (59, 73750, 15000, 58750, '51.04%', 11, 30);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (60, 63750, 10000, 53750, '55.2%', 12, 30);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (61, 38750, 0, 38750, '67.7%', 13, 30);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (62, 11250, 11250, 0, '100%', 14, 30);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (63, 41250, 0, 41250, '65.62%', 16, 30);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (64, 106250, 0, 106250, '11.45%', 15, 30);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (65, 22500, 0, 22500, '81.25%', 9, 31);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (66, 81250, 25000, 56250, '53.12%', 10, 31);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (67, 58750, 10000, 48750, '59.37%', 11, 31);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (68, 53750, 0, 53750, '55.2%', 12, 31);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (69, 38750, 0, 38750, '67.7%', 13, 31);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (70, 0, 0, 0, '100%', 14, 31);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (71, 41250, 0, 41250, '65.62%', 16, 31);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (72, 106250, 0, 106250, '11.45%', 15, 31);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (73, 22500, 0, 22500, '81.25%', 9, 32);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (74, 56250, 0, 56250, '53.12%', 10, 32);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (75, 48750, 0, 48750, '59.37%', 11, 32);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (76, 53750, 0, 53750, '55.2%', 12, 32);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (77, 38750, 10000, 28750, '76.04%', 13, 32);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (78, 0, 0, 0, '100%', 14, 32);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (79, 41250, 0, 41250, '65.62%', 16, 32);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (80, 106250, 0, 106250, '11.45%', 15, 32);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (81, 22500, 0, 22500, '81.25%', 9, 33);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (82, 56250, 0, 56250, '53.12%', 10, 33);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (83, 48750, 0, 48750, '59.37%', 11, 33);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (84, 53750, 0, 53750, '55.2%', 12, 33);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (85, 28750, 0, 28750, '76.04%', 13, 33);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (86, 0, 0, 0, '100%', 14, 33);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (87, 41250, 0, 41250, '65.62%', 16, 33);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (88, 106250, 0, 106250, '11.45%', 15, 33);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (89, 20000, 5000, 15000, 'Fond cotisé à 25.0%', 34, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (90, 20000, 0, 20000, 'Fond cotisé à 0.0%', 52, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (91, 20000, 0, 20000, 'Fond cotisé à 0.0%', 27, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (92, 20000, 0, 20000, 'Fond cotisé à 0.0%', 50, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (93, 20000, 0, 20000, 'Fond cotisé à 0.0%', 29, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (94, 20000, 0, 20000, 'Fond cotisé à 0.0%', 44, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (95, 20000, 0, 20000, 'Fond cotisé à 0.0%', 51, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (96, 20000, 0, 20000, 'Fond cotisé à 0.0%', 53, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (97, 20000, 1500, 18500, 'Fond cotisé à 7.5%', 28, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (98, 20000, 0, 20000, 'Fond cotisé à 0.0%', 54, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (99, 20000, 5000, 15000, 'Fond cotisé à 25.0%', 47, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (100, 20000, 0, 20000, 'Fond cotisé à 0.0%', 36, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (101, 20000, 5000, 15000, 'Fond cotisé à 25.0%', 39, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (102, 20000, 5000, 15000, 'Fond cotisé à 25.0%', 33, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (103, 20000, 5000, 15000, 'Fond cotisé à 25.0%', 40, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (104, 20000, 0, 20000, 'Fond cotisé à 0.0%', 48, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (105, 20000, 0, 20000, 'Fond cotisé à 0.0%', 37, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (106, 20000, 0, 20000, 'Fond cotisé à 0.0%', 25, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (107, 20000, 4000, 16000, 'Fond cotisé à 20.0%', 32, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (108, 20000, 0, 20000, 'Fond cotisé à 0.0%', 30, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (109, 20000, 0, 20000, 'Fond cotisé à 0.0%', 45, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (110, 20000, 0, 20000, 'Fond cotisé à 0.0%', 43, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (111, 20000, 0, 20000, 'Fond cotisé à 0.0%', 49, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (112, 20000, 0, 20000, 'Fond cotisé à 0.0%', 41, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (113, 20000, 0, 20000, 'Fond cotisé à 0.0%', 46, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (114, 20000, 1000, 19000, 'Fond cotisé à 5.0%', 26, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (115, 20000, 0, 20000, 'Fond cotisé à 0.0%', 31, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (116, 20000, 0, 20000, 'Fond cotisé à 0.0%', 35, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (117, 20000, 0, 20000, 'Fond cotisé à 0.0%', 38, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (118, 20000, 0, 20000, 'Fond cotisé à 0.0%', 42, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (119, 20000, 0, 20000, 'Fond cotisé à 0.0%', 56, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (120, 20000, 0, 20000, 'Fond cotisé à 0.0%', 55, 34);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (121, 20000, 0, 20000, 'Fond cotisé à 0.0%', 57, 37);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (122, 20000, 0, 20000, 'Fond cotisé à 0.0%', 58, 37);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (123, 20000, 0, 20000, 'Fond cotisé à 0.0%', 59, 37);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (124, 20000, 0, 20000, 'Fond cotisé à 0.0%', 60, 37);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (125, 20000, 0, 20000, '0.0%', 57, 38);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (126, 20000, 0, 20000, '0.0%', 58, 38);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (127, 20000, 0, 20000, '0.0%', 59, 38);
INSERT INTO encours_secours (id_encours_secours, encours, montant_cotise, reste, observation, idmembre, idrencontre) VALUES (128, 20000, 0, 20000, '0.0%', 60, 38);


--
-- TOC entry 2769 (class 0 OID 522555)
-- Dependencies: 205
-- Data for Name: epargne; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (1, 15, '2018-01-07', 500000, 9, 'Epargne direte 250 000
Reversement de l''appui financier du secours à l''eparge : 250 000', 8);
INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (2, 16, '2018-02-07', 300000, 9, '', 28);
INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (3, 16, '2018-02-07', 10000, 12, '', 29);
INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (4, 16, '2018-02-07', 100000, 14, '', 30);
INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (5, 17, '2018-03-07', 200000, 9, '', 43);
INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (6, 17, '2018-03-07', 50000, 14, '', 44);
INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (7, 17, '2018-03-07', 50000, 16, '', 45);
INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (8, 18, '2018-04-07', 140000, 9, '', 63);
INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (9, 18, '2018-04-07', 30000, 14, '', 64);
INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (10, 20, '2018-06-07', 10000, 12, '', 113);
INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (11, 20, '2018-06-07', 100000, 14, '-', 114);
INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (12, 30, '2018-09-07', 5000, 12, '', 151);
INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (13, 30, '2018-09-07', 25000, 14, '', 152);
INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (14, 31, '2018-10-07', 35000, 14, '', 165);
INSERT INTO epargne (idepargne, idrencontre, dateepargne, montant, idmembrecycle, observation, idcaisse) VALUES (15, 32, '2018-11-07', 65000, 14, '', 179);


--
-- TOC entry 2770 (class 0 OID 522561)
-- Dependencies: 206
-- Data for Name: fiche_presence; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (1, 9, 15, '2018-01-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (2, 10, 15, '2018-01-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (4, 12, 15, '2018-01-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (5, 13, 15, '2018-01-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (6, 14, 15, '2018-01-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (7, 16, 15, '2018-01-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (3, 11, 15, '2018-01-07', false, '17:00:00', '19:00:00', 0, true, NULL, NULL, 'Non Encore inscrit');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (8, 15, 15, '2018-01-07', false, '17:00:00', '19:00:00', 0, true, NULL, NULL, 'Ne fait plus partie de l''association');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (49, 9, 21, '2018-07-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (50, 10, 21, '2018-07-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (9, 9, 16, '2018-02-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (10, 10, 16, '2018-02-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (11, 11, 16, '2018-02-07', false, '17:00:00', '19:00:00', 0, true, 0, true, 'Non encore inscrit');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (12, 12, 16, '2018-02-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (13, 13, 16, '2018-02-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (14, 14, 16, '2018-02-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (15, 16, 16, '2018-02-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (16, 15, 16, '2018-02-07', false, '17:00:00', '19:00:00', 0, true, 0, true, 'Démissionnaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (17, 9, 17, '2018-03-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (18, 10, 17, '2018-03-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (19, 11, 17, '2018-03-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (20, 12, 17, '2018-03-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (21, 13, 17, '2018-03-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (22, 14, 17, '2018-03-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (23, 16, 17, '2018-03-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (24, 15, 17, '2018-03-07', false, '17:00:00', '19:00:00', 0, true, NULL, NULL, 'Démissionaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (25, 9, 18, '2018-04-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (26, 10, 18, '2018-04-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (27, 11, 18, '2018-04-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (29, 13, 18, '2018-04-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (30, 14, 18, '2018-04-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (31, 16, 18, '2018-04-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (28, 12, 18, '2018-04-07', false, '17:00:00', '19:00:00', 0, true, NULL, NULL, 'Permissionnaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (32, 15, 18, '2018-04-07', false, '17:00:00', '19:00:00', 0, true, NULL, NULL, 'démissionnaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (33, 9, 19, '2018-05-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (35, 11, 19, '2018-05-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (36, 12, 19, '2018-05-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (37, 13, 19, '2018-05-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (39, 16, 19, '2018-05-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (34, 10, 19, '2018-05-07', false, '17:00:00', '19:00:00', 0, true, NULL, NULL, 'Permissionnaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (40, 15, 19, '2018-05-07', false, '17:00:00', '19:00:00', 0, true, NULL, NULL, 'Demissionaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (38, 14, 19, '2018-05-07', false, '17:00:00', '19:00:00', 0, true, NULL, NULL, 'Permissionnaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (51, 11, 21, '2018-07-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (41, 9, 20, '2018-06-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (42, 10, 20, '2018-06-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (43, 11, 20, '2018-06-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (44, 12, 20, '2018-06-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (45, 13, 20, '2018-06-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (46, 14, 20, '2018-06-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (47, 16, 20, '2018-06-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (48, 15, 20, '2018-06-07', false, '17:00:00', '19:00:00', 0, true, 0, true, 'Démissionnaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (52, 12, 21, '2018-07-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (53, 13, 21, '2018-07-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (55, 16, 21, '2018-07-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (54, 14, 21, '2018-07-07', false, '17:00:00', '19:00:00', 0, true, NULL, NULL, 'Permissionnaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (56, 15, 21, '2018-07-07', false, '17:00:00', '19:00:00', 0, true, NULL, NULL, 'Démissionnaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (61, 13, 29, '2018-08-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (69, 13, 30, '2018-09-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (70, 14, 30, '2018-09-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (57, 9, 29, '2018-08-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (58, 10, 29, '2018-08-07', false, '17:00:00', '19:00:00', 0, true, 0, true, 'Permissionaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (59, 11, 29, '2018-08-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (60, 12, 29, '2018-08-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (62, 14, 29, '2018-08-07', false, '17:00:00', '19:00:00', 0, true, 0, true, 'Permissionaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (63, 16, 29, '2018-08-07', true, '17:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (64, 15, 29, '2018-08-07', false, '17:00:00', '19:00:00', 0, true, 0, true, 'Démissionaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (65, 9, 30, '2018-09-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (66, 10, 30, '2018-09-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (67, 11, 30, '2018-09-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (68, 12, 30, '2018-09-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (71, 16, 30, '2018-09-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (72, 15, 30, '2018-09-07', false, '17:00:00', '19:00:00', 0, true, NULL, NULL, 'Demissionnaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (73, 9, 31, '2018-10-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (74, 10, 31, '2018-10-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (75, 11, 31, '2018-10-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (77, 13, 31, '2018-10-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (78, 14, 31, '2018-10-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (79, 16, 31, '2018-10-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (80, 15, 31, '2018-10-07', false, '17:00:00', '19:00:00', 0, true, NULL, NULL, 'Demissionnaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (76, 12, 31, '2018-10-07', false, '17:00:00', '19:00:00', 0, true, NULL, NULL, 'Permissionnaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (81, 9, 32, '2018-11-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (82, 10, 32, '2018-11-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (83, 11, 32, '2018-11-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (84, 12, 32, '2018-11-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (85, 13, 32, '2018-11-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (86, 14, 32, '2018-11-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (87, 16, 32, '2018-11-07', true, '17:00:00', '19:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (88, 15, 32, '2018-11-07', false, '17:00:00', '19:00:00', 0, true, NULL, NULL, 'Demissionnaire');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (90, 52, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, true, 0, true, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (91, 27, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, true, 0, true, 'Hospitalisation');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (94, 44, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (95, 51, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (96, 53, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (97, 28, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, 'En Ligne
Absence justifiée
');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (98, 54, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (100, 36, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (99, 47, 34, '2019-09-14', true, '16:22:00', '19:00:00', 22, false, 110, false, '-');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (101, 39, 34, '2019-09-14', true, '16:13:00', '19:00:00', 13, false, 65, false, '-');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (103, 40, 34, '2019-09-14', true, '16:00:00', '19:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (104, 48, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (105, 37, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (106, 25, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (107, 32, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, true, 0, true, 'En ligne
Absence justifiée');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (108, 30, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (109, 45, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (110, 43, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (111, 49, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (112, 41, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (113, 46, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (114, 26, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (115, 31, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, true, 0, true, 'Présence en ligne');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (116, 35, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (117, 38, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (118, 42, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, false, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (102, 33, 34, '2019-09-14', true, '16:00:00', '19:00:00', 0, true, 0, true, '-');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (89, 34, 34, '2019-09-14', true, '16:20:00', '19:00:00', 20, false, 100, false, '-');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (92, 50, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, true, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (93, 29, 34, '2019-09-14', false, '16:00:00', '19:00:00', 0, false, 2000, true, '');
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (119, 57, 37, '2020-12-01', true, '08:00:00', '08:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (120, 58, 37, '2020-12-01', true, '08:00:00', '08:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (121, 59, 37, '2020-12-01', true, '08:00:00', '08:00:00', 0, true, 0, true, NULL);
INSERT INTO fiche_presence (id, idmembre, idrencontre, date_rencontre, present, heure_debut, heure_fin, retard, justifie, montant_penalite, regle, motif) VALUES (122, 60, 37, '2020-12-01', true, '08:00:00', '08:00:00', 0, true, 0, true, NULL);


--
-- TOC entry 2771 (class 0 OID 522571)
-- Dependencies: 207
-- Data for Name: frequencecotisation; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO frequencecotisation (idfrequence, denomination, valeur) VALUES (1, 'par semaine', 7);
INSERT INTO frequencecotisation (idfrequence, denomination, valeur) VALUES (2, 'apres 2 semaines', 14);
INSERT INTO frequencecotisation (idfrequence, denomination, valeur) VALUES (3, 'après 3 semaines', 21);
INSERT INTO frequencecotisation (idfrequence, denomination, valeur) VALUES (4, 'Après 1 mois', 28);


--
-- TOC entry 2772 (class 0 OID 522574)
-- Dependencies: 208
-- Data for Name: frequencetontine; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO frequencetontine (idfreqtontine, nom_fr, nom_en) VALUES (1, 'Apres Deux Mois', 'After Two Months');
INSERT INTO frequencetontine (idfreqtontine, nom_fr, nom_en) VALUES (2, 'Mensuelle', 'Monthly');


--
-- TOC entry 2773 (class 0 OID 522580)
-- Dependencies: 209
-- Data for Name: groupecaisse; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2774 (class 0 OID 522586)
-- Dependencies: 210
-- Data for Name: groupeutilisateur; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO groupeutilisateur (idgroupe, nom, datecreation, etat) VALUES (2, 'Utilisateur', '2017-12-28', true);
INSERT INTO groupeutilisateur (idgroupe, nom, datecreation, etat) VALUES (1, 'Administrateur', '2017-12-12', true);


--
-- TOC entry 2775 (class 0 OID 522589)
-- Dependencies: 211
-- Data for Name: inscription_cotisation; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (1, 1, 9, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (2, 1, 10, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (3, 1, 11, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (4, 1, 12, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (5, 1, 13, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (6, 1, 14, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (7, 1, 16, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (8, 1, 15, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (9, 2, 9, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (10, 2, 10, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (11, 2, 11, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (12, 2, 12, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (13, 2, 13, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (14, 2, 14, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (15, 2, 16, false);
INSERT INTO inscription_cotisation (idinscription, idcotisation, idmembre, etat) VALUES (16, 2, 15, false);


--
-- TOC entry 2776 (class 0 OID 522593)
-- Dependencies: 212
-- Data for Name: mains; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (1, 1, '42111', 'ATEBA ASOMO - 1', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (2, 1, '42112', 'ATEBA ASOMO - 2', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (3, 1, '42113', 'ATEBA ASOMO - 3', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (4, 2, '42124', 'BESSALA - 1', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (5, 2, '42125', 'BESSALA - 2', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (6, 2, '42126', 'BESSALA - 3', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (7, 3, '42137', 'ERIC - 1', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (8, 3, '42138', 'ERIC - 2', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (9, 4, '42149', 'MEBARA - 1', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (10, 4, '421410', 'MEBARA - 2', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (11, 4, '421411', 'MEBARA - 3', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (12, 4, '421412', 'MEBARA - 4', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (13, 5, '421513', 'MFOUAPON - 1', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (14, 5, '421514', 'MFOUAPON - 2', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (15, 5, '421515', 'MFOUAPON - 3', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (16, 6, '421616', 'NDENDE - 1', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (17, 7, '421717', 'NZANGUE NEPOUDEM - 1', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (18, 8, '421818', 'OLOUGOU - 1', 0, NULL, 15000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (19, 9, '422919', 'ATEBA ASOMO - 1', 0, NULL, 25000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (20, 10, '4221020', 'BESSALA - 1', 0, NULL, 25000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (21, 11, '4221121', 'ERIC - 1', 0, NULL, 25000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (22, 12, '4221222', 'MEBARA - 1', 0, NULL, 25000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (23, 13, '4221323', 'MFOUAPON - 1', 0, NULL, 25000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (24, 13, '4221324', 'MFOUAPON - 2', 0, NULL, 25000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (25, 14, '4221425', 'NDENDE - 1', 0, NULL, 25000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (26, 14, '4221426', 'NDENDE - 2', 0, NULL, 25000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (27, 15, '4221527', 'NZANGUE NEPOUDEM - 1', 0, NULL, 25000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (28, 15, '4221528', 'NZANGUE NEPOUDEM - 2', 0, NULL, 25000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (29, 15, '4221529', 'NZANGUE NEPOUDEM - 3', 0, NULL, 25000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (30, 16, '4221630', 'OLOUGOU - 1', 0, NULL, 25000, NULL);
INSERT INTO mains (idmain, idinscription, codemain, nom, nbretourspasse, numeroordre, montantsouscrit, echec) VALUES (31, 16, '4221631', 'OLOUGOU - 2', 0, NULL, 25000, NULL);


--
-- TOC entry 2777 (class 0 OID 522600)
-- Dependencies: 213
-- Data for Name: membre; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (25, 'NKOUCHEMOUN', 'ALIMA', 'Feminin', '', '', '', 'Yaoundé', 1, '', 'M-01');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (22, 'NDENDE', 'Caroline', 'Feminin', '', '', '', '', 1, '', 'S06');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (19, 'ATEBA ASOMO', 'Fabien', 'Masculin', '', '', '', '', 1, '', 'S01');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (20, 'BESSALA', 'Protais', 'Masculin', '', '', '', '', 1, '', 'S02');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (18, 'ERIC', 'Ebolo', 'Masculin', '', 'gerbole2000@yahoo.fr', '', '', 1, '------', 'S03');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (23, 'MEBARA', 'Marie Gisele', 'Feminin', '', '', '', '', 1, '', 'S04');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (17, 'MFOUAPON', 'Henock', 'Masculin', '', 'henockmfouapon@yahoo.fr', '', '', 1, '104176315', 'S05');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (24, 'NZANGUE NEPOUDEM', 'Augustin', 'Masculin', '', '', '', '', 1, '', 'S07');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (21, 'OLOUGOU', 'Valère', 'Masculin', '', '', '', '', 1, '', 'S08');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (0, '-', '-', '-', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (26, 'Salif', 'Michael ', 'Masculin', '', '', '', 'Douala', 1, '', 'M-02');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (27, 'Dr Mbouandi', '-', 'Masculin', '', '', '', 'Douala', 1, '', 'M-03');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (28, 'PANCHA', 'Mohamed', 'Masculin', '', '', '', 'Douala', 1, '', 'M-04');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (29, 'FOUDA', 'Atangana', 'Masculin', '', '', '', 'Douala', 1, '', 'M-05');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (30, 'NGOUGOURE', 'Rachida', 'Feminin', '', '', '', 'Douala', 1, '', 'M-06');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (31, 'PANCHUT', 'Fatima', 'Feminin', '', '', '', 'Melong', 1, '', 'M-07');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (33, 'EMALEU', 'Duplex', 'Masculin', '', '', '', 'Douala', 1, '', 'M-09');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (34, 'TAPON', 'Emmanuel', 'Masculin', '', '', '', 'Yaoundé', 1, '', 'M-10');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (35, 'NJIBOKET', 'Sani', 'Masculin', '', '', '', 'Yaoundé', 1, '', 'M-11');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (36, 'MAH', 'Armand', 'Masculin', '', '', '', 'Yaoundé', 1, '', 'M-12');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (37, 'MFOSSI', 'Rajel', 'Masculin', '', '', '', 'Yaoundé', 1, '', 'M-13');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (38, 'KOUANOU', 'Bakanké', 'Masculin', '', '', '', 'Yaoundé', 1, '', 'M-14');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (39, 'MFOUAPON', 'Henock', 'Masculin', '655256488', '', '', 'Yaoundé', 1, '', 'M-15');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (40, 'NJIMOKE', 'Tapche', 'Masculin', '', '', '', 'Yaoundé', 1, '', 'M-16');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (43, 'JUMEMI', 'Gervais', 'Masculin', '', '', '', 'Ebolowa', 1, '', 'M-19');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (44, 'IBRAHIM', '-', 'Masculin', '', '', '', 'Foumban', 1, '', 'M-20');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (45, 'NGOUPAYOU', 'Aminatou', 'Feminin', 'Foumban', '', '', '', 1, '', 'M-21');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (46, 'MOUNGNUTOU', 'Mominou', 'Masculin', '', '', '', 'Foumban', 1, '', 'M-22');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (47, 'NJIMOKE', 'Tigana', 'Masculin', '', '', '', 'Allemegne', 1, '', 'M-23');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (50, 'CHIFFANE', '-', 'Masculin', '', '', '', 'Douala', 1, '', 'M-26');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (51, 'IYA', 'Maimouna', 'Feminin', 'Ngaoundéré', '', '', '', 1, '', 'M-27');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (52, 'LIMI', 'Ayouba', 'Masculin', '', '', '', 'Douala', 1, '', 'M-28');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (53, 'MFORAIN', 'Karim', 'Masculin', '', '', '', 'Bertoua', 1, '', 'M-29');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (54, 'MOUICHE ', 'Fatima', 'Feminin', '', '', '', 'Foumban', 1, '', 'M-30');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (41, 'MATAPIT', 'Abiba', 'Feminin', '', '', '', 'Allemagne', 2, '', 'M-17');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (42, 'AWA', 'Moustapha', 'Feminin', '', '', '', 'USA', 4, '', 'M-18');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (48, 'MFOUAPON NGAPOUT', 'Allassa', 'Masculin', '', '', '', 'Allemagne', 2, '', 'M-24');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (49, 'NJANKOUO TAPON', 'Souleman', 'Masculin', '', '', '', 'Italie', 3, '', 'M-25');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (56, 'BISSABEDE', 'Frida', 'Feminin', '', '', '', 'Yaoundé', 1, '', 'M-32');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (55, 'MFENDOUM NDAM', 'Salif', 'Masculin', '', '', '', 'Yaoundé', 1, '', 'M-31');
INSERT INTO membre (idmembre, nom, prenom, sexe, contact, email, photo, adresse, idpays, numcni, code) VALUES (32, 'TAPCHE NDOUNG', 'Ali Junior', 'Masculin', '', '', '', 'Douala', 1, '', 'M-08');


--
-- TOC entry 2778 (class 0 OID 522606)
-- Dependencies: 214
-- Data for Name: membrecycle; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (17, 19, 3, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (18, 20, 3, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (20, 23, 3, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (22, 22, 3, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (23, 24, 3, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (24, 21, 3, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (1, 17, 1, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (2, 19, 1, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (4, 18, 1, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (3, 20, 1, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (5, 23, 1, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (6, 22, 1, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (7, 21, 1, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (8, 24, 1, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (15, 21, 2, 0, 13750, 66250, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (16, 24, 2, 50000, 78750, 61250, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (9, 19, 2, 640000, 97500, 61250, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (12, 23, 2, 25000, 66250, 61250, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (19, 18, 3, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (21, 17, 3, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (10, 20, 2, 0, 63750, 61250, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (11, 18, 2, 0, 71250, 61250, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (14, 22, 2, 405000, 120000, 37500, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (13, 17, 2, 0, 91250, 61250, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (27, 27, 4, 0, 0, 0, true, 1000, 203);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (50, 28, 4, 0, 0, 0, true, 1000, 198);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (42, 54, 4, 0, 0, 0, true, 1000, 221);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (56, 55, 4, 0, 0, 0, true, 1000, 222);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (55, 56, 4, 0, 0, 0, true, 0, 223);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (61, 25, 6, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (62, 26, 6, 0, 0, 0, true, 0, NULL);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (34, 25, 4, 0, 5000, 0, true, 1000, 192);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (52, 26, 4, 0, 0, 0, true, 1000, 202);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (29, 29, 4, 0, 0, 0, true, 1000, 204);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (44, 30, 4, 0, 0, 0, true, 1000, 205);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (51, 31, 4, 0, 0, 0, true, 1000, 199);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (53, 32, 4, 0, 0, 0, true, 1000, 206);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (28, 33, 4, 0, 1500, 0, true, 1000, 196);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (54, 34, 4, 0, 0, 0, true, 1000, 207);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (47, 35, 4, 0, 5000, 0, true, 1000, 195);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (36, 36, 4, 0, 0, 0, true, 1000, 208);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (39, 37, 4, 0, 5000, 0, true, 1000, 194);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (33, 38, 4, 0, 5000, 0, true, 1000, 193);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (40, 39, 4, 0, 5000, 0, true, 1000, 191);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (48, 40, 4, 0, 0, 0, true, 1000, 209);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (37, 41, 4, 0, 0, 0, true, 1000, 210);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (25, 42, 4, 0, 0, 0, true, 1000, 211);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (32, 43, 4, 0, 4000, 0, true, 1000, 200);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (30, 44, 4, 0, 0, 0, true, 1000, 212);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (45, 45, 4, 0, 0, 0, true, 1000, 213);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (43, 46, 4, 0, 0, 0, true, 1000, 214);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (49, 47, 4, 0, 0, 0, true, 1000, 215);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (41, 48, 4, 0, 0, 0, true, 1000, 216);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (46, 49, 4, 0, 0, 0, true, 1000, 217);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (26, 50, 4, 0, 1000, 0, true, 1000, 197);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (31, 51, 4, 0, 0, 0, true, 1000, 218);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (35, 52, 4, 0, 0, 0, true, 1000, 219);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (38, 53, 4, 0, 0, 0, true, 1000, 220);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (57, 25, 5, 0, 12500, 0, true, 1500, 224);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (58, 26, 5, 0, 7500, 0, true, 1500, 225);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (59, 27, 5, 0, 7500, 0, true, 1500, 226);
INSERT INTO membrecycle (idmembrecycle, idmembre, idcycle, montantavalise, montant_secours, reste_main_levee, etat, fraisadhesion, idcaisse) VALUES (60, 28, 5, 0, 2500, 0, true, 1500, 227);


--
-- TOC entry 2779 (class 0 OID 522613)
-- Dependencies: 215
-- Data for Name: membretontine; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (1, 17, 4, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (2, 18, 4, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (3, 19, 4, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (4, 20, 4, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (5, 21, 4, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (6, 22, 4, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (7, 23, 4, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (8, 24, 4, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (9, 25, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (10, 26, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (11, 27, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (12, 28, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (13, 29, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (14, 30, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (15, 31, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (16, 32, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (17, 33, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (18, 34, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (19, 35, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (20, 36, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (21, 37, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (22, 38, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (23, 39, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (24, 40, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (25, 41, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (26, 42, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (27, 43, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (28, 44, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (29, 45, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (30, 46, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (31, 47, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (32, 48, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (33, 49, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (34, 50, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (35, 51, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (36, 52, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (37, 53, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (38, 54, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (39, 55, 5, true);
INSERT INTO membretontine (idmembretontine, idmembre, idtontine, etat) VALUES (40, 56, 5, true);


--
-- TOC entry 2780 (class 0 OID 522617)
-- Dependencies: 216
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (1, 'SUPER - ADMINISTRATEUR', '-', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (2, 'GERER LES GROUPES D''UTILISATEUR', '/Epargn_Plus/securite/groupeutilisateur/List.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (3, 'GERER LES UTILISATEURS', '/Epargn_Plus/securite/utilisateur/List.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (4, 'GERER LES COMPTES UTILISATEUR', '/Epargn_Plus/securite/compteutilisateur/List.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (5, 'ATTRIBUTION / RETRAIT DES PRIVILEGES', '/Epargn_Plus/securite/privilege/List.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (6, 'ACTIVER LES COMPTES UTILISATEUR', '/Epargn_Plus/securite/activercompte/activercompte.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (7, 'DESACTIVER LES COMPTES UTILISATEUR', '/Epargn_Plus/securite/desactivercompte/desactivercompte.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (8, 'VISUALISER LA TRACE D''AUDIT', '/Epargn_Plus/securite/mouchard/List.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (9, 'ENREGISTRER LES PAYS', '/Epargn_Plus/parametrage/pays/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (10, 'PARAMETRER LES RUBRIQUES DE CAISSE', '/Epargn_Plus/parametrage/rubrique_caisse/rubrique_caisse.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (11, 'PARAMETRER LES CYCLES DE LA TONTINE', '/Epargn_Plus/parametrage/cycletontine/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (12, 'PARAMETRER LES CYCLES DE LA TONTINE', '/Epargn_Plus/parametrage/frequencetontine/List.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (13, 'PARAMETRER LES MOTIFS D''AIDE', '/Epargn_Plus/parametrage/motifaide/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (14, 'ENREGISTER LES TONTINES', '/Epargn_Plus/parametrage/tontine/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (15, 'PARAMETRER LES DEVISES DE PAIEMENT', '/Epargn_Plus/parametrage/device/List.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (16, 'GESTION DES MEMBRES', '/Epargn_Plus/operation/membre/List.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (17, 'INSCRIRE LES MEMBRES DANS UN CYCLE', '/Epargn_Plus/operation/membre-par-cycle/List.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (18, 'GERER LES EMPRUNTS', '/Epargn_Plus/operation/emprunt/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (19, 'GERER LES REMBOURSEMENTS', '/Epargn_Plus/operation/remboursement/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (20, 'IMPRIMER LA SITUATION DES EMPRUNT', '/Epargn_Plus/operation/encours_emprunt/List.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (21, 'ENREGISTRER LES RENCONTRES', '/Epargn_Plus/operation/rencontre/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (22, 'Ouverture de rencontre - Calcul d''interet', '/Epargn_Plus/operation/ouverture-calculinteret/List.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (23, 'Ouverture de rencontre - Pointer la presence', '/Epargn_Plus/operation/ouverture-fichepresence/List.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (24, 'GERER LES DEPENSES (RUBRIQUE AUTRE)', '/Epargn_Plus/operation/depense/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (25, 'GERER LES RECETTES (RUBRIQUE AUTRE)', '/Epargn_Plus/operation/recette/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (26, 'GERER LES OPERATIONS DE CAISSE (RUBRIQUE AUTRE)', '/Epargn_Plus/operation/caisse/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (27, 'GERER LES EPARGNES', '/Epargn_Plus/operation/epargne/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (28, 'GERER LES PENALITES DE RETARD', '/Epargn_Plus/operation/payement-sanction/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (29, 'CLOTURER UNE RENCONTRE', '/Epargn_Plus/operation/fermetture-rencontre/List.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (30, 'IMPRIMER LA SITUATION FINANCIERE / MEMBRE', '/Epargn_Plus/operation/situation_financiere_membre/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (31, 'IMPRIMER LA SITUATION FINANCIERE / RENCONTRE', '/Epargn_Plus/operation/situation_financiere_rencontre/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (32, 'IMPRIMER LA SITUATION DµFINANCIERE / CYCLE', '/Epargn_Plus/operation/situation_financiere_cycle/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (33, 'IMPRIMER L''ETAT DE CLOTURE DU CYCLE', '/Epargn_Plus/operation/cloture-session/List.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (34, 'GESTION DE LA COLLECTE PAR MAIN LEVEE', '/Epargn_Plus/operation/collecte_main_levee/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (35, 'GESTION DE LA COLLECTE DU FOND SECOURS', '/Epargn_Plus/operation/collecte_secours/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (36, 'TRANSFERT DU FOND SECOURS D''UN CYCLE A UN AUTRE', '/Epargn_Plus/operation/transfert_fond_secours/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (37, 'GESTION DE L''ASSISTANCE', '/Epargn_Plus/operation/aide/index.html', true);
INSERT INTO menu (idmenu, libelle, ressource, etat) VALUES (39, 'SITUATION DES FOND SECOURS', '/Epargn_Plus/operation/encours_secours/List.html', true);


--
-- TOC entry 2781 (class 0 OID 522623)
-- Dependencies: 217
-- Data for Name: modepaiement; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO modepaiement (idmdepaiement, nom_fr, nom_en) VALUES (1, 'Virement', 'Transaction');
INSERT INTO modepaiement (idmdepaiement, nom_fr, nom_en) VALUES (2, 'Cash', 'Cash');


--
-- TOC entry 2782 (class 0 OID 522629)
-- Dependencies: 218
-- Data for Name: mois; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO mois (idmois, nom_fr, nom_en) VALUES (1, 'Mai', 'May');
INSERT INTO mois (idmois, nom_fr, nom_en) VALUES (2, 'Janvier', 'January');


--
-- TOC entry 2783 (class 0 OID 522635)
-- Dependencies: 219
-- Data for Name: motifaide; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO motifaide (idmotifaide, nomfr, nomen) VALUES (1, 'Naissance', 'Birth');
INSERT INTO motifaide (idmotifaide, nomfr, nomen) VALUES (2, 'Décés', 'Die');
INSERT INTO motifaide (idmotifaide, nomfr, nomen) VALUES (3, 'Assistance Mariage', 'Assistance Mariage');


--
-- TOC entry 2784 (class 0 OID 522641)
-- Dependencies: 220
-- Data for Name: mouchard; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1, 'Déconnexion', '2018-07-05', '2018-07-05', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2, 'Déconnexion', '2018-07-05', '2018-07-05', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (3, 'Modification du Cycle de Tontine ->  SEPT 2018 -> SEPT 2018', '2018-07-05', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (4, 'Déconnexion', '2018-07-05', '2018-07-05', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (5, 'Enregistrement de l''aide  -> -', '2018-07-05', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (6, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 20000.0', '2018-07-05', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (7, 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 32500.0', '2018-07-05', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (8, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 31250.0', '2018-07-05', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (9, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 42500.0', '2018-07-05', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (10, 'Déconnexion', '2018-07-06', '2018-07-06', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (11, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (12, 'Enregistrement du fond de caisse du membre  -> ZANGUE NEPOUDEM Augustin ; Montant -> 40000.0', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (13, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 30000.0', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (14, 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 10000.0', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (15, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (16, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 10000.0', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (17, 'Enregistrement de l''aide  -> ', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (18, 'Enregistrement de l''aide  -> -', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (19, 'Enregistrement de l''aide  -> ', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (20, 'Enregistrement de l''emprunt  -> 50000.0 du membre -> ATEBA ASOMO Fabien', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (21, 'Enregistrement de l''emprunt  -> 300000.0 du membre -> BESSALA Protais', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (22, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (23, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (24, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 5000.0', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (25, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 15000.0', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (26, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 20000.0', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (27, 'Enregistrement du fond de caisse du membre  -> ZANGUE NEPOUDEM Augustin ; Montant -> 5000.0', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (28, 'Enregistrement de l''aide  -> ', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (29, 'Enregistrement de l''aide  -> ', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (30, 'Enregistrement de l''aide  -> ', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (31, 'Enregistrement de l''emprunt  -> 200000.0 du membre -> ZANGUE NEPOUDEM Augustin', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (32, 'Enregistrement du remboursement du membre -> ATEBA ASOMO Fabien : 0.0', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (33, 'Enregistrement du remboursement du membre -> BESSALA Protais : 0.0', '2018-07-06', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (34, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (35, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (36, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (37, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (38, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (39, 'Enregistrement de l''aide  -> ', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (40, 'Enregistrement de l''aide  -> ', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (41, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (42, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 20000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (43, 'Modification de l''tontine ->  SEPT -> SEPT', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (44, 'Enregistrement du cycle Tontine  -> SEPT 2016', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (45, 'Déconnexion', '2018-07-07', '2018-07-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (46, 'Modification du Cycle de Tontine ->  SEPT 2016 -> SEPT 2016', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (47, 'Déconnexion', '2018-07-07', '2018-07-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (48, 'Déconnexion', '2018-07-07', '2018-07-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (49, 'Déconnexion', '2018-07-07', '2018-07-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (50, 'Déconnexion', '2018-07-07', '2018-07-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (51, 'Déconnexion', '2018-07-07', '2018-07-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (52, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (53, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (54, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 5000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (55, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (56, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 20000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (57, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (58, 'Enregistrement de l''aide  -> ', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (59, 'Enregistrement de l''aide  -> ', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (60, 'Modification du Cycle de Tontine ->  SEPT 2018 -> SEPT 2018', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (61, 'Déconnexion', '2018-07-07', '2018-07-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (62, 'Modification du Cycle de Tontine ->  SEPT 2018 -> SEPT 2018', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (63, 'Déconnexion', '2018-07-07', '2018-07-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (64, 'Enregistrement de l''emprunt  -> 100000.0 du membre -> ATEBA ASOMO Fabien', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (65, 'Enregistrement du remboursement du membre -> BESSALA Protais : 0.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (66, 'Suppression des frais de secours du membre -> ATEBA ASOMO Fabien Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (67, 'Suppression des frais de secours du membre -> ERIC Ebolo Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (68, 'Suppression des frais de secours du membre -> MEBARA Marie Gisele Montant -> 5000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (69, 'Suppression des frais de secours du membre -> MFOUAPON Henock Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (70, 'Suppression des frais de secours du membre -> NDENDE Caroline Montant -> 20000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (71, 'Suppression des frais de secours du membre -> NZANGUE NEPOUDEM Augustin Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (72, 'Suppression des frais de secours du membre -> ATEBA ASOMO Fabien Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (73, 'Suppression des frais de secours du membre -> MEBARA Marie Gisele Montant -> 20000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (74, 'Suppression des frais de secours du membre -> ATEBA ASOMO Fabien Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (75, 'Suppression des frais de secours du membre -> ERIC Ebolo Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (76, 'Suppression des frais de secours du membre -> MFOUAPON Henock Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (77, 'Suppression des frais de secours du membre -> NDENDE Caroline Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (78, 'Suppression des frais de secours du membre -> NZANGUE NEPOUDEM Augustin Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (79, 'Suppression des frais de secours du membre -> ATEBA ASOMO Fabien Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (80, 'Suppression des frais de secours du membre -> ERIC Ebolo Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (81, 'Suppression des frais de secours du membre -> MEBARA Marie Gisele Montant -> 5000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (82, 'Suppression des frais de secours du membre -> MFOUAPON Henock Montant -> 15000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (83, 'Suppression des frais de secours du membre -> NDENDE Caroline Montant -> 20000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (84, 'Suppression des frais de secours du membre -> NZANGUE NEPOUDEM Augustin Montant -> 5000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (85, 'Suppression des frais de secours du membre -> ATEBA ASOMO Fabien Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (86, 'Suppression des frais de secours du membre -> BESSALA Protais Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (87, 'Suppression des frais de secours du membre -> MEBARA Marie Gisele Montant -> 30000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (88, 'Suppression des frais de secours du membre -> NDENDE Caroline Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (89, 'Suppression des frais de secours du membre -> MFOUAPON Henock Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (90, 'Suppression des frais de secours du membre -> NZANGUE NEPOUDEM Augustin Montant -> 40000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (91, 'Suppression des frais de secours du membre -> ATEBA ASOMO Fabien Montant -> 31250.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (92, 'Suppression des frais de secours du membre -> BESSALA Protais Montant -> 32500.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (93, 'Suppression des frais de secours du membre -> MFOUAPON Henock Montant -> 20000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (94, 'Suppression des frais de secours du membre -> NDENDE Caroline Montant -> 42500.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (95, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 31250.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (96, 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 32500.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (97, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 20000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (98, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 42500.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (99, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (100, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 40000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (101, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 30000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (102, 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (103, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (104, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (105, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (106, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (107, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 5000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (108, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 15000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (109, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 20000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (110, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 5000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (111, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (112, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (113, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (114, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (115, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (116, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (117, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 20000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (118, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (119, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (120, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 5000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (121, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (122, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 20000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (123, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 10000.0', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (124, 'Enregistrement de l''aide  -> ', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (125, 'Enregistrement de l''aide  -> ', '2018-07-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (126, 'Suppression des frais de secours du membre -> MEBARA Marie Gisele Montant -> 5000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (127, 'Suppression des frais de secours du membre -> ATEBA ASOMO Fabien Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (128, 'Suppression des frais de secours du membre -> MFOUAPON Henock Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (129, 'Suppression des frais de secours du membre -> ERIC Ebolo Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (130, 'Suppression des frais de secours du membre -> NDENDE Caroline Montant -> 20000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (131, 'Suppression des frais de secours du membre -> NZANGUE NEPOUDEM Augustin Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (132, 'Suppression des frais de secours du membre -> ATEBA ASOMO Fabien Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (133, 'Suppression des frais de secours du membre -> MEBARA Marie Gisele Montant -> 20000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (134, 'Suppression des frais de secours du membre -> ATEBA ASOMO Fabien Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (135, 'Suppression des frais de secours du membre -> ERIC Ebolo Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (136, 'Suppression des frais de secours du membre -> MFOUAPON Henock Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (137, 'Suppression des frais de secours du membre -> NDENDE Caroline Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (138, 'Suppression des frais de secours du membre -> NZANGUE NEPOUDEM Augustin Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (139, 'Suppression des frais de secours du membre -> ATEBA ASOMO Fabien Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (140, 'Suppression des frais de secours du membre -> ERIC Ebolo Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (141, 'Suppression des frais de secours du membre -> MEBARA Marie Gisele Montant -> 5000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (142, 'Suppression des frais de secours du membre -> MFOUAPON Henock Montant -> 15000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (143, 'Suppression des frais de secours du membre -> NDENDE Caroline Montant -> 20000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (144, 'Suppression des frais de secours du membre -> NZANGUE NEPOUDEM Augustin Montant -> 5000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (145, 'Suppression des frais de secours du membre -> ATEBA ASOMO Fabien Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (221, 'Déconnexion', '2018-09-07', '2018-09-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (146, 'Suppression des frais de secours du membre -> BESSALA Protais Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (147, 'Suppression des frais de secours du membre -> MEBARA Marie Gisele Montant -> 30000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (148, 'Suppression des frais de secours du membre -> MFOUAPON Henock Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (149, 'Suppression des frais de secours du membre -> NDENDE Caroline Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (150, 'Suppression des frais de secours du membre -> NZANGUE NEPOUDEM Augustin Montant -> 40000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (151, 'Suppression des frais de secours du membre -> ATEBA ASOMO Fabien Montant -> 31250.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (152, 'Suppression des frais de secours du membre -> BESSALA Protais Montant -> 32500.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (153, 'Suppression des frais de secours du membre -> MFOUAPON Henock Montant -> 20000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (154, 'Suppression des frais de secours du membre -> NDENDE Caroline Montant -> 42500.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (155, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 31250.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (156, 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 32500.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (157, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 20000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (158, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 42500.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (159, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (160, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 40000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (161, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 30000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (162, 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (163, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (164, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (165, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (166, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (167, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 5000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (168, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 15000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (169, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 20000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (170, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 5000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (171, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (172, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (173, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (174, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (175, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (176, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (177, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 20000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (178, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (179, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (180, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 5000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (181, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (182, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 20000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (183, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (184, 'Déconnexion', '2018-07-09', '2018-07-09', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (185, 'Déconnexion', '2018-07-09', '2018-07-09', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (186, 'Déconnexion', '2018-07-09', '2018-07-09', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (187, 'Enregistrement du Rencontre : Rencontre du 07 juin 2016', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (188, 'Enregistrement du Rencontre : Rencontre du 07 juillet 2016', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (189, 'Enregistrement du Rencontre : Rencontre du 07 Août 2016', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (190, 'Enregistrement du Rencontre : Rencontre du 07 Septembre 2016', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (191, 'Enregistrement du Rencontre : Rencontre du 07 Octobre 2016', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (192, 'Enregistrement du Rencontre : Rencontre du 07 Novembre 2016', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (193, 'Enregistrement du Rencontre : Rencontre du 07 Decembre 2016', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (194, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (195, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (196, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (197, 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (198, 'Enregistrement du fond de caisse du membre  -> OLOUGOU Valère ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (199, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (200, 'Déconnexion', '2018-07-09', '2018-07-09', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (201, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (202, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (203, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (204, 'Enregistrement du remboursement du membre -> ATEBA ASOMO Fabien : 0.0', '2018-07-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (205, 'Enregistrement du Rencontre : Rencontre du 07 Août 2018', '2018-08-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (206, 'Déconnexion', '2018-08-07', '2018-08-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (207, 'Déconnexion', '2018-08-07', '2018-08-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (208, 'Déconnexion', '2018-08-07', '2018-08-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (209, 'Déconnexion', '2018-08-07', '2018-08-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (210, 'Déconnexion', '2018-08-07', '2018-08-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (211, 'Déconnexion', '2018-08-07', '2018-08-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (212, 'Déconnexion', '2018-08-07', '2018-08-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (213, 'Déconnexion', '2018-08-07', '2018-08-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (214, 'Déconnexion', '2018-09-07', '2018-09-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (215, 'Enregistrement de la dépense  -> Frais de collation Mois de Mai 2018', '2018-09-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (216, 'Déconnexion', '2018-09-07', '2018-09-07', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (217, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2018-09-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (218, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 10000.0', '2018-09-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (219, 'Enregistrement du remboursement du membre -> ATEBA ASOMO Fabien : 0.0', '2018-09-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (220, 'Enregistrement du Rencontre : Rencontre du 07 septembre 2018', '2018-09-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (222, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2018-09-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (223, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2018-09-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (224, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 5000.0', '2018-09-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (225, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2018-09-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (226, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 20000.0', '2018-09-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (227, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 10000.0', '2018-09-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (228, 'Enregistrement de l''aide  -> ', '2018-09-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (229, 'Enregistrement de l''aide  -> ', '2018-09-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (230, 'Enregistrement du remboursement du membre -> ATEBA ASOMO Fabien : 0.0', '2018-09-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (231, 'Enregistrement du Rencontre : Rencontre du 07 Octobre 2018', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (232, 'Enregistrement du Rencontre : Rencontre du 07 Novembre 2018', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (233, 'Déconnexion', '2018-11-09', '2018-11-09', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (234, 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 25000.0', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (235, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (236, 'Enregistrement de l''aide  -> OM', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (237, 'Enregistrement de l''emprunt  -> 100000.0 du membre -> MFOUAPON Henock', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (238, 'Déconnexion', '2018-11-09', '2018-11-09', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (239, 'Suppression de l''emprunt -> ', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (240, 'Enregistrement de l''emprunt  -> 100000.0 du membre -> NZANGUE NEPOUDEM Augustin', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (241, 'Déconnexion', '2018-11-09', '2018-11-09', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (242, 'Suppression de l''emprunt -> ', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (243, 'Enregistrement de l''emprunt  -> 100000.0 du membre -> MFOUAPON Henock', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (244, 'Déconnexion', '2018-11-09', '2018-11-09', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (245, 'Suppression de l''emprunt -> ', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (246, 'Enregistrement de l''emprunt  -> 100000.0 du membre -> MFOUAPON Henock', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (247, 'Enregistrement du remboursement du membre -> ATEBA ASOMO Fabien : 0.0', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (248, 'Enregistrement du remboursement du membre -> BESSALA Protais : 50000.0', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (249, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (250, 'Enregistrement de l''aide  -> ', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (251, 'Enregistrement du remboursement du membre -> ATEBA ASOMO Fabien : 0.0', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (252, 'Enregistrement du remboursement du membre -> ATEBA ASOMO Fabien : 0.0', '2018-11-09', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (253, 'Déconnexion', '2018-11-09', '2018-11-09', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (254, 'Déconnexion', '2019-01-22', '2019-01-22', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (255, 'Enregistrement de l''aide  -> ', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (256, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (257, 'Suppression des frais de secours du membre -> MFOUAPON Henock Montant -> 10000.0', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (258, 'Déconnexion', '2019-01-22', '2019-01-22', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (259, 'Enregistrement de la Rubrique Caisse  : Frais d''annonce', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (260, 'Enregistrement de la Rubrique Caisse  : Frais de Timbre', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (261, 'Enregistrement de la recette  -> Annonce naissance BB Henock', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (262, 'Déconnexion', '2019-01-22', '2019-01-22', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (263, 'Suppression de la recette -> Annonce naissance BB Henock', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (264, 'Enregistrement de la recette  -> Annonce Naissance BB Henock', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (265, 'Suppression de la recette -> Annonce Naissance BB Henock', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (266, 'Suppression de la epargne -> ', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (267, 'Suppression de la epargne -> ', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (268, 'Suppression de la epargne -> ', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (269, 'Suppression des frais de secours du membre -> ATEBA ASOMO Fabien Montant -> 10000.0', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (270, 'Suppression des frais de secours du membre -> MFOUAPON Henock Montant -> 10000.0', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (271, 'Suppression des frais de secours du membre -> NZANGUE NEPOUDEM Augustin Montant -> 10000.0', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (272, 'Enregistrement de l''aide du membre -> NZANGUE NEPOUDEM Augustin', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (273, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 10000.0', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (274, 'Enregistrement de la dépense  -> ', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (275, 'Enregistrement de la Rubrique Caisse  : Assistance Mariage', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (276, 'Enregistrement du motifaide -> Assistance Mariage', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (277, 'Enregistrement de l''aide du membre -> ATEBA ASOMO Fabien', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (278, 'Enregistrement de la dépense  -> Frais Collation de Fevrier', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (279, 'Enregistrement de la dépense  -> Frais Collation de Mars', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (280, 'Enregistrement de la dépense  -> Frais Collation d''avril', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (281, 'Enregistrement de la dépense  -> Frais Collation de Juillet', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (282, 'Enregistrement de la dépense  -> Frais Collation de Novembre', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (283, 'Enregistrement du Rencontre : Rencontre du 07 Decembre 2018', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (284, 'Déconnexion', '2019-01-22', '2019-01-22', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (285, 'Déconnexion', '2019-01-22', '2019-01-22', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (286, 'Enregistrement du remboursement du membre -> BESSALA Protais : 0.0', '2019-01-22', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (287, 'Annulation du remboursement -> BESSALA Protais ; Montant -> 50000.0', '2019-02-04', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (288, 'Enregistrement du remboursement du membre -> BESSALA Protais : 50000.0', '2019-02-04', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (289, 'Enregistrement du remboursement du membre -> MFOUAPON Henock : 0.0', '2019-02-04', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (290, 'Annulation du remboursement -> MFOUAPON Henock ; Montant -> 0.0', '2019-02-04', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (291, 'Enregistrement du remboursement du membre -> MFOUAPON Henock : 0.0', '2019-02-04', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (292, 'Suppression de l''aide au  membre -> ATEBA ASOMO Fabien', '2019-02-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (293, 'Enregistrement de l''aide du membre -> ATEBA ASOMO Fabien', '2019-02-07', NULL, NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (294, 'Déconnexion', '2019-02-25', '2019-02-25', NULL);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (295, 'connexion ', '2019-03-06', '2019-03-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (296, 'Enregistrement de l''emprunt  -> 300000.0 du membre -> BESSALA Protais', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (297, 'Enregistrement de l''emprunt  -> 200000.0 du membre -> NZANGUE NEPOUDEM Augustin', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (298, 'Enregistrement de l''aide  -> ', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (299, 'Enregistrement de l''aide  -> ', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (300, 'Enregistrement de l''aide  -> ', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (301, 'Enregistrement du remboursement du membre -> ATEBA ASOMO Fabien : 5000.0', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (302, 'Enregistrement du remboursement du membre -> BESSALA Protais : 30000.0', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (303, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (304, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (305, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 5000.0', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (673, 'connexion ', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (306, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 15000.0', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (307, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 20000.0', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (308, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 5000.0', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (309, 'Enregistrement de la dépense  -> ', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (310, 'Enregistrement de la dépense  -> Frais de collation Mars', '2019-03-06', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (311, 'connexion ', '2019-03-06', '2019-03-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (312, 'connexion ', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (313, 'connexion ', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (314, 'Enregistrement de l''aide  -> ', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (315, 'Enregistrement de l''aide  -> ', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (316, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (317, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (318, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (319, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (320, 'Enregistrement de l''aide du membre -> NZANGUE NEPOUDEM Augustin', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (321, 'Enregistrement de l''aide du membre -> ATEBA ASOMO Fabien', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (322, 'connexion ', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (323, 'Enregistrement de la recette  -> Reste des intérets à redistribuer', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (324, 'Enregistrement de l''aide du membre -> NZANGUE NEPOUDEM Augustin', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (325, 'connexion ', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (326, 'Enregistrement de la dépense  -> Frais de collation , Mois de Avril 2019', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (327, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (328, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 20000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (329, 'Enregistrement de l''aide du membre -> MFOUAPON Henock', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (330, 'Enregistrement de l''aide du membre -> OLOUGOU Valère', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (331, 'Enregistrement de la main lévée du membre  -> MEBARA Marie Gisele ; Montant -> 5000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (332, 'Enregistrement de la main lévée du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 5000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (333, 'Enregistrement de la main lévée du membre  -> OLOUGOU Valère ; Montant -> 5000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (334, 'Enregistrement de la main lévée du membre  -> BESSALA Protais ; Montant -> 5000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (335, 'Enregistrement de la main lévée du membre  -> ATEBA ASOMO Fabien ; Montant -> 5000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (336, 'Enregistrement de la main lévée du membre  -> MFOUAPON Henock ; Montant -> 5000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (337, 'Enregistrement de la main lévée du membre  -> ERIC Ebolo ; Montant -> -5000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (338, 'Suppression des frais de main lévée du membre -> ERIC Ebolo Montant -> -5000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (339, 'Enregistrement de la main lévée du membre  -> ERIC Ebolo ; Montant -> 5000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (340, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 90000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (341, 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 90000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (342, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 110000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (343, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 110000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (344, 'Enregistrement du fond de caisse du membre  -> OLOUGOU Valère ; Montant -> 120000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (345, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 110000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (346, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 110000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (347, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 140000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (348, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 60000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (349, 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 50000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (350, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 47500.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (351, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 50000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (352, 'Enregistrement du fond de caisse du membre  -> OLOUGOU Valère ; Montant -> 37500.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (353, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 40000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (354, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 20000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (355, 'Enregistrement de la dépense  -> Remboursement correctif Eric Sur Assistance BB Olougou Valer', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (356, 'Déconnexion', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (357, 'connexion ', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (358, 'Enregistrement de l''aide  -> ', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (359, 'Enregistrement de l''aide  -> -', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (360, 'Enregistrement de l''emprunt  -> 100000.0 du membre -> ATEBA ASOMO Fabien', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (361, 'Enregistrement du remboursement du membre -> BESSALA Protais : 30000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (362, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (363, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (364, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 5000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (365, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (366, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 20000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (367, 'Enregistrement du fond de caisse du membre  -> NZANGUE NEPOUDEM Augustin ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (368, 'Déconnexion', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (369, 'connexion ', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (370, 'Enregistrement du remboursement du membre -> ATEBA ASOMO Fabien : 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (371, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (372, 'Enregistrement du fond de caisse du membre  -> ATEBA ASOMO Fabien ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (373, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (374, 'Enregistrement de la dépense  -> Frais Collation', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (375, 'Déconnexion', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (376, 'connexion ', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (377, 'Enregistrement du remboursement du membre -> ATEBA ASOMO Fabien : 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (378, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (379, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (380, 'Enregistrement de la dépense  -> Frais de Collation Aout 2018', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (381, 'Déconnexion', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (382, 'connexion ', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (383, 'Enregistrement de l''aide  -> ', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (384, 'Enregistrement de l''aide  -> ', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (385, 'Enregistrement du remboursement du membre -> ATEBA ASOMO Fabien : 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (386, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 15000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (387, 'Enregistrement du fond de caisse du membre  -> MEBARA Marie Gisele ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (388, 'Enregistrement du fond de caisse du membre  -> NDENDE Caroline ; Montant -> 11250.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (389, 'Enregistrement de la main lévée du membre  -> NDENDE Caroline ; Montant -> 18750.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (390, 'Déconnexion', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (391, 'connexion ', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (392, 'Enregistrement de l''emprunt  -> 100000.0 du membre -> MFOUAPON Henock', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (393, 'Enregistrement de l''aide  -> ', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (394, 'Enregistrement du remboursement du membre -> ATEBA ASOMO Fabien : 5000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (395, 'Enregistrement du remboursement du membre -> BESSALA Protais : 50000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (396, 'Enregistrement du fond de caisse du membre  -> BESSALA Protais ; Montant -> 25000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (397, 'Enregistrement du fond de caisse du membre  -> ERIC Ebolo ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (398, 'Enregistrement de la main lévée du membre  -> NDENDE Caroline ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (399, 'Déconnexion', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (400, 'connexion ', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (401, 'Enregistrement de l''aide  -> ', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (402, 'Enregistrement du remboursement du membre -> ATEBA ASOMO Fabien : 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (403, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 10000.0', '2019-03-07', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (404, 'Déconnexion', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (405, 'connexion ', '2019-03-07', '2019-03-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (406, 'connexion ', '2019-03-19', '2019-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (407, 'connexion ', '2019-03-19', '2019-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (408, 'connexion ', '2019-03-19', '2019-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (409, 'connexion ', '2019-03-19', '2019-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (410, 'connexion ', '2019-03-19', '2019-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (411, 'connexion ', '2019-03-19', '2019-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (412, 'connexion ', '2019-03-20', '2019-03-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (413, 'connexion ', '2019-03-25', '2019-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (414, 'connexion ', '2019-03-27', '2019-03-27', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (415, 'connexion ', '2019-05-06', '2019-05-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (416, 'connexion ', '2019-05-07', '2019-05-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (417, 'connexion ', '2019-05-07', '2019-05-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (418, 'connexion ', '2019-05-09', '2019-05-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (419, 'connexion ', '2019-05-20', '2019-05-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (420, 'connexion ', '2019-06-17', '2019-06-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (421, 'connexion ', '2019-06-30', '2019-06-30', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (422, 'connexion ', '2019-09-13', '2019-09-13', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (423, 'Enregistrement de la tontine  -> Nos Années Lycée', '2019-09-13', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (424, 'Déconnexion', '2019-09-13', '2019-09-13', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (425, 'connexion ', '2019-09-13', '2019-09-13', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (426, 'connexion ', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (427, 'Modification de l''tontine ->  Nos Années Lycée -> Nos Années Lycée (NAL)', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (428, 'Modification de l''tontine ->  Nos Années Lycée (NAL) -> Nos Années Lycée (NAL)', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (429, 'Enregistrement d''une Fréqunce : Mensuelle', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (430, 'Enregistrement du cycle Tontine  -> NAL 2019', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (431, 'Déconnexion', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (432, 'connexion ', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (433, 'Enregistrement du Rencontre : Rencontre du 14 Septembre 2019', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (434, 'Enregistrement du Rencontre : Rencontre du 12 Octobre 2019', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (435, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> KOUCHEMOUN', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (436, 'Enregistrement du membre KOUCHEMOUN ALIMA', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (437, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> Salif', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (438, 'Enregistrement du membre Salif Michael ', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (439, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> Dr Mbouandi', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (440, 'Enregistrement du membre Dr Mbouandi -', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (441, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> PANCHA', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (442, 'Enregistrement du membre PANCHA Mohamed', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (443, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> FOUDA', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (444, 'Enregistrement du membre FOUDA Atangana', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (445, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> NGOUGOURE', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (446, 'Enregistrement du membre NGOUGOURE Rachida', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (447, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> PANCHUT', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (448, 'Enregistrement du membre PANCHUT Fatima', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (449, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> TAPCHE', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (450, 'Enregistrement du membre TAPCHE Ali', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (451, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> EMALEU', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (452, 'Enregistrement du membre EMALEU Duplex', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (453, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> TAPON', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (454, 'Enregistrement du membre TAPON Emmanuel', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (455, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> NJIBOKET', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (456, 'Enregistrement du membre NJIBOKET Sani', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (457, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> MAH', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (458, 'Enregistrement du membre MAH Armand', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (459, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> MFOSSI', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (460, 'Enregistrement du membre MFOSSI Rajel', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (461, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> KOUANOU', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (462, 'Enregistrement du membre KOUANOU Bakanké', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (463, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> MFOUAPON', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (464, 'Enregistrement du membre MFOUAPON Henock', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (465, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> NJIMOKE', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (466, 'Enregistrement du membre NJIMOKE Tapche', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (774, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (775, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (467, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> MATAPIT', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (468, 'Enregistrement du membre MATAPIT Abiba', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (469, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> AWA', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (470, 'Enregistrement du membre AWA Moustapha', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (471, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> JUMEMI', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (472, 'Enregistrement du membre JUMEMI Gervais', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (473, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> IBRAHIM', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (474, 'Enregistrement du membre IBRAHIM -', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (475, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> NGOUPAYOU', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (476, 'Enregistrement du membre NGOUPAYOU Aminatou', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (477, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> MOUNGNUTOU', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (478, 'Enregistrement du membre MOUNGNUTOU Mominou', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (479, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> NJIMOKE', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (480, 'Enregistrement du membre NJIMOKE Tigana', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (481, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> MFOUAPON NGAPOUT', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (482, 'Enregistrement du membre MFOUAPON NGAPOUT Allassa', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (483, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> NJANKOUO TAPON', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (484, 'Enregistrement du membre NJANKOUO TAPON Souleman', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (485, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> CHIFFANE', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (486, 'Enregistrement du membre CHIFFANE -', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (487, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> IYA', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (488, 'Enregistrement du membre IYA Maimouna', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (489, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> LIMI', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (490, 'Enregistrement du membre LIMI Ayouba', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (491, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> MFORAIN', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (492, 'Enregistrement du membre MFORAIN Karim', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (493, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> MOUICHE ', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (494, 'Enregistrement du membre MOUICHE  Fatima', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (495, 'Enregistrement du Pays : Allemagne', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (496, 'Enregistrement du Pays : Italie', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (497, 'Enregistrement du Pays : USA', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (498, 'connexion ', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (499, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> Salif (Denilson)', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (500, 'Enregistrement du membre Salif (Denilson) -', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (501, 'Assignation de la tontine  -> Nos Années Lycée (NAL) ; Au Membre  -> BISSABEDE', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (502, 'Enregistrement du membre BISSABEDE Frida', '2019-09-16', '2019-09-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (503, 'Enregistrement du fond de caisse du membre  -> MFOUAPON Henock ; Montant -> 5000.0', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (504, 'Enregistrement du fond de caisse du membre  -> KOUCHEMOUN ALIMA ; Montant -> 5000.0', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (505, 'Enregistrement du fond de caisse du membre  -> KOUANOU Bakanké ; Montant -> 5000.0', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (506, 'Enregistrement du fond de caisse du membre  -> MFOSSI Rajel ; Montant -> 5000.0', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (507, 'Enregistrement du fond de caisse du membre  -> NJIBOKET Sani ; Montant -> 5000.0', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (508, 'Enregistrement du fond de caisse du membre  -> JUMEMI Gervais ; Montant -> 4000.0', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (509, 'Enregistrement du fond de caisse du membre  -> EMALEU Duplex ; Montant -> 1500.0', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (510, 'Enregistrement du fond de caisse du membre  -> CHIFFANE - ; Montant -> 1000.0', '2019-09-16', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (511, 'connexion ', '2019-09-18', '2019-09-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (512, 'Déconnexion', '2019-09-18', '2019-09-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (513, 'connexion ', '2019-09-18', '2019-09-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (514, 'connexion ', '2019-09-18', '2019-09-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (515, 'connexion ', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (516, 'connexion ', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (517, 'connexion ', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (518, 'connexion ', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (519, 'connexion ', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (520, 'connexion ', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (521, 'connexion ', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (522, 'connexion ', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (523, 'connexion ', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (524, 'Déconnexion', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (525, 'connexion ', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (526, 'Déconnexion', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (527, 'connexion ', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (528, 'connexion ', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (529, 'Déconnexion', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (530, 'connexion ', '2019-09-19', '2019-09-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (531, 'connexion ', '2019-09-24', '2019-09-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (532, 'connexion ', '2019-09-24', '2019-09-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (533, 'connexion ', '2019-09-24', '2019-09-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (534, 'connexion ', '2019-09-24', '2019-09-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (535, 'connexion ', '2019-09-24', '2019-09-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (536, 'connexion ', '2019-09-25', '2019-09-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (537, 'connexion ', '2019-09-25', '2019-09-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (538, 'connexion ', '2019-09-25', '2019-09-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (539, 'connexion ', '2019-09-25', '2019-09-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (540, 'connexion ', '2019-09-25', '2019-09-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (541, 'connexion ', '2019-09-25', '2019-09-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (542, 'connexion ', '2019-09-25', '2019-09-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (543, 'connexion ', '2019-09-25', '2019-09-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (544, 'Enregistrement du cycle Tontine  -> NAL 2020', '2019-09-25', '2019-09-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (545, 'Déconnexion', '2019-09-25', '2019-09-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (546, 'connexion ', '2019-09-25', '2019-09-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (547, 'Enregistrement du Rencontre : Rencontre du 1er janvier 2020', '2019-09-25', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (548, 'connexion ', '2019-09-25', '2019-09-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (549, 'connexion ', '2019-09-26', '2019-09-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (550, 'Enregistrement du payement de la sanction du membre -> NKOUCHEMOUN ALIMA : 100.0', '2019-09-26', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (551, 'Annulation du payement de sanction -> NKOUCHEMOUN ALIMA ; Montant -> 100.0', '2019-09-26', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (552, 'Enregistrement du payement de la sanction du membre -> NKOUCHEMOUN ALIMA : 100.0', '2019-09-26', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (553, 'Annulation du payement de sanction -> NKOUCHEMOUN ALIMA ; Montant -> 100.0', '2019-09-26', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (554, 'Enregistrement du payement de la sanction du membre -> NKOUCHEMOUN ALIMA : 100.0', '2019-09-26', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (555, 'Annulation du payement de sanction -> NKOUCHEMOUN ALIMA ; Montant -> 100.0', '2019-09-26', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (556, 'Enregistrement du payement de la sanction du membre -> NKOUCHEMOUN ALIMA : 100.0', '2019-09-26', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (557, 'connexion ', '2019-09-26', '2019-09-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (558, 'connexion ', '2019-09-26', '2019-09-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (559, 'Annulation du payement de sanction -> NKOUCHEMOUN ALIMA ; Montant -> 100.0', '2019-09-26', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (560, 'connexion ', '2019-09-27', '2019-09-27', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (561, 'connexion ', '2019-09-27', '2019-09-27', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (562, 'connexion ', '2019-10-14', '2019-10-14', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (563, 'Enregistrement du payement de la sanction du membre -> PANCHA Mohamed : 2000.0', '2019-10-14', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (564, 'Annulation du payement de sanction -> PANCHA Mohamed ; Montant -> 2000.0', '2019-10-14', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (565, 'connexion ', '2019-10-14', '2019-10-14', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (566, 'Enregistrement du payement de la sanction du membre -> PANCHA Mohamed : 2000.0', '2019-10-14', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (567, 'Enregistrement du payement de la sanction du membre -> FOUDA Atangana : 2000.0', '2019-10-14', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (568, 'connexion ', '2019-10-22', '2019-10-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (569, 'connexion ', '2019-10-23', '2019-10-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (570, 'connexion ', '2019-10-24', '2019-10-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (571, 'connexion ', '2019-10-24', '2019-10-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (572, 'connexion ', '2019-10-24', '2019-10-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (573, 'connexion ', '2019-10-24', '2019-10-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (574, 'Déconnexion', '2019-10-24', '2019-10-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (575, 'connexion ', '2019-10-24', '2019-10-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (576, 'Déconnexion', '2019-10-24', '2019-10-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (577, 'connexion ', '2019-10-24', '2019-10-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (578, 'Déconnexion', '2019-10-24', '2019-10-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (579, 'connexion ', '2019-10-24', '2019-10-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (580, 'connexion ', '2019-10-25', '2019-10-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (581, 'connexion ', '2019-11-01', '2019-11-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (582, 'Déconnexion', '2019-11-01', '2019-11-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (583, 'connexion ', '2020-04-20', '2020-04-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (584, 'connexion ', '2020-04-20', '2020-04-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (585, 'Enregistrement du cycle Tontine  -> NAL 2021', '2020-04-20', '2020-04-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (586, 'Déconnexion', '2020-04-20', '2020-04-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (587, 'connexion ', '2020-04-20', '2020-04-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (588, 'connexion ', '2020-04-20', '2020-04-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (589, 'connexion ', '2020-04-20', '2020-04-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (590, 'Déconnexion', '2020-04-20', '2020-04-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (591, 'connexion ', '2020-11-17', '2020-11-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (592, 'Enregistrement de la tontine : Tontine 10000 Montant : 10000.0', '2020-11-17', '2020-11-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (593, 'Déconnexion', '2020-11-17', '2020-11-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (594, 'connexion ', '2020-11-17', '2020-11-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (595, 'Enregistrement de la tontine : Tontine de 10000 Montant : 10000.0', '2020-11-17', '2020-11-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (596, 'Enregistrement du Rencontre : Rencontre du 1 er décembre', '2020-11-17', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (597, 'connexion ', '2020-12-09', '2020-12-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (598, 'Déconnexion', '2020-12-09', '2020-12-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (599, 'connexion ', '2020-12-09', '2020-12-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (600, 'Enregistrement de la tontine : Tontine de 5000 Montant : 5000.0', '2020-12-09', '2020-12-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (601, 'connexion ', '2020-12-10', '2020-12-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (602, 'connexion ', '2020-12-10', '2020-12-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (603, 'connexion ', '2020-12-11', '2020-12-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (604, 'connexion ', '2020-12-14', '2020-12-14', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (605, 'connexion ', '2020-12-14', '2020-12-14', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (606, 'connexion ', '2020-12-14', '2020-12-14', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (607, 'connexion ', '2020-12-14', '2020-12-14', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (608, 'connexion ', '2020-12-14', '2020-12-14', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (609, 'connexion ', '2020-12-15', '2020-12-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (610, 'connexion ', '2020-12-15', '2020-12-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (611, 'connexion ', '2020-12-15', '2020-12-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (612, 'connexion ', '2020-12-15', '2020-12-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (613, 'connexion ', '2020-12-15', '2020-12-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (614, 'connexion ', '2020-12-16', '2020-12-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (615, 'connexion ', '2020-12-16', '2020-12-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (616, 'Enregistrement de la tontine : cotisation 15000 Montant : 15000.0', '2020-12-16', '2020-12-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (617, 'connexion ', '2020-12-17', '2020-12-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (618, 'connexion ', '2020-12-17', '2020-12-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (619, 'connexion ', '2020-12-17', '2020-12-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (620, 'connexion ', '2020-12-17', '2020-12-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (621, 'connexion ', '2020-12-17', '2020-12-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (622, 'connexion ', '2020-12-17', '2020-12-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (623, 'connexion ', '2020-12-17', '2020-12-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (624, 'connexion ', '2020-12-18', '2020-12-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (625, 'connexion ', '2020-12-18', '2020-12-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (626, 'connexion ', '2020-12-18', '2020-12-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (627, 'connexion ', '2020-12-18', '2020-12-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (628, 'connexion ', '2020-12-18', '2020-12-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (629, 'Enregistrement de la tontine : Cotisation 6000 Montant : 6000.0', '2020-12-18', '2020-12-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (630, 'Suppression de la tontine : Cotisation 6000 Montant : 6000.0', '2020-12-18', '2020-12-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (631, 'connexion ', '2020-12-18', '2020-12-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (632, 'connexion ', '2020-12-18', '2020-12-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (633, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (634, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (635, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (636, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (637, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (638, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (639, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (640, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (641, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (642, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (643, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (644, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (645, 'Enregistrement de la tontine : Cotisation de 6000 Montant : 6000.0', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (646, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (647, 'Enregistrement de la tontine : Cotisation 6000 Montant : 6000.0', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (648, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (649, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (650, 'Enregistrement de la tontine : Cotisation 6000 Montant : 6000.0', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (651, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (652, 'Enregistrement de la tontine : Cotisation Montant : 6000.0', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (653, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (654, 'Enregistrement de la tontine : Cotisation Montant : 6000.0', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (655, 'Création d''une nouvelle tontine : Cotisation : montant : 6000.0', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (656, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (657, 'Enregistrement de la tontine : Cotisation 6mil Montant : 6000.0', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (658, 'Création d''une nouvelle tontine : Cotisation 6mil : montant : 6000.0', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (659, 'connexion ', '2020-12-21', '2020-12-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (660, 'connexion ', '2020-12-22', '2020-12-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (661, 'Enregistrement du tirage de la cotisation Cotisation de 6mil', '2020-12-22', '2020-12-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (662, 'connexion ', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (663, 'Enregistrement du tirage de la cotisation null', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (664, 'connexion ', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (665, 'Enregistrement du tirage de la cotisation null', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (666, 'connexion ', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (667, 'Enregistrement du tirage de la cotisation null', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (668, 'connexion ', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (669, 'Enregistrement du tirage de la cotisation null', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (670, 'connexion ', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (671, 'Enregistrement du tirage de la cotisation Cotisation de 6mil', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (672, 'connexion ', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (674, 'Enregistrement du tirage de la cotisation Cotisation de 6mil', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (675, 'Enregistrement du tirage de la cotisation Cotisation de 6mil', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (676, 'Enregistrement du tirage de la cotisation Cotisation de 6mil', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (677, 'Enregistrement du tirage de la cotisation Cotisation de 6mil', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (678, 'Enregistrement du tirage de la cotisation Cotisation de 6mil', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (679, 'connexion ', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (680, 'Enregistrement du tirage de la cotisation Cotisation de 6mil', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (681, 'Enregistrement du tirage de la cotisation Cotisation de 6mil', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (682, 'Enregistrement du tirage de la cotisation Cotisation de 6mil', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (683, 'Enregistrement du tirage de la cotisation Cotisation de 6mil', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (684, 'connexion ', '2020-12-23', '2020-12-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (685, 'connexion ', '2020-12-28', '2020-12-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (686, 'connexion ', '2020-12-28', '2020-12-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (687, 'connexion ', '2020-12-28', '2020-12-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (688, 'connexion ', '2020-12-28', '2020-12-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (689, 'connexion ', '2020-12-28', '2020-12-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (690, 'connexion ', '2020-12-28', '2020-12-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (691, 'connexion ', '2020-12-28', '2020-12-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (692, 'connexion ', '2020-12-28', '2020-12-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (693, 'Enregistrement de la tontine : Cotisation 5mil Montant : 5000.0', '2020-12-28', '2020-12-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (694, 'Création d''une nouvelle tontine : Cotisation 5mil : montant : 5000.0', '2020-12-28', '2020-12-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (695, 'Enregistrement du tirage de la cotisation Cotisation de 6mil', '2020-12-28', '2020-12-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (696, 'connexion ', '2020-12-28', '2020-12-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (697, 'Enregistrement du tirage de la cotisation Cotisation de 5mil', '2020-12-28', '2020-12-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (698, 'Enregistrement du tirage de la cotisation Cotisation de 5mil', '2020-12-28', '2020-12-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (699, 'connexion ', '2020-12-29', '2020-12-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (700, 'connexion ', '2020-12-29', '2020-12-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (701, 'connexion ', '2020-12-30', '2020-12-30', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (702, 'connexion ', '2020-12-30', '2020-12-30', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (703, 'connexion ', '2020-12-30', '2020-12-30', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (704, 'connexion ', '2020-12-30', '2020-12-30', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (705, 'Modification du Cycle de Tontine ->  NAL 2020 -> NAL 2020', '2020-12-30', '2020-12-30', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (706, 'connexion ', '2020-12-30', '2020-12-30', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (707, 'connexion ', '2020-12-30', '2020-12-30', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (708, 'connexion ', '2021-01-04', '2021-01-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (709, 'connexion ', '2021-01-04', '2021-01-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (710, 'Enregistrement du cycle Tontine  -> NAL 2021 bis', '2021-01-04', '2021-01-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (711, 'Enregistrement du Rencontre : Rencontre du 31 janvier 2021', '2021-01-04', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (712, 'Enregistrement de la tontine : Tontine de 25000 Montant : 25000.0', '2021-01-04', '2021-01-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (713, 'Création d''une nouvelle tontine : Tontine de 25000 : montant : 25000.0', '2021-01-04', '2021-01-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (714, 'connexion ', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (715, 'connexion ', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (716, 'Suppression du cycle NAL 2021 bis', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (717, 'Modification du Cycle de Tontine ->  NAL 2020 -> NAL 2020', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (718, 'connexion ', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (719, 'Modification du Cycle de Tontine ->  NAL 2020 -> NAL 2020', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (720, 'connexion ', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (721, 'Modification du Cycle de Tontine ->  NAL 2020 -> NAL 2020', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (722, 'connexion ', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (723, 'Modification du Cycle de Tontine ->  NAL 2020 -> NAL 2020', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (724, 'connexion ', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (725, 'Modification du Cycle de Tontine ->  NAL 2020 -> NAL 2020', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (726, 'connexion ', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (727, 'connexion ', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (728, 'Enregistrement de la tontine : Cotisation 25mil Montant : 25.0', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (729, 'Création d''une nouvelle tontine : Cotisation 25mil : montant : 25.0', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (730, 'connexion ', '2021-01-05', '2021-01-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (731, 'connexion ', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (732, 'connexion ', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (733, 'connexion ', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (734, 'connexion ', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (735, 'connexion ', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (736, 'connexion ', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (737, 'connexion ', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (738, 'connexion ', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (739, 'connexion ', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (740, 'Inscription de NKOUCHEMOUN à la tontin : Tontine de 25000', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (741, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (742, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (743, 'connexion ', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (744, 'Inscription de Dr Mbouandi à la tontin : Tontine de 25000', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (745, 'Ajout d''une main pour le membre Dr Mbouandi', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (746, 'connexion ', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (747, 'Inscription de Salif à la tontin : Tontine de 25000', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (748, 'Ajout d''une main pour le membre Salif', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (749, 'Ajout d''une main pour le membre Dr Mbouandi', '2021-01-06', '2021-01-06', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (750, 'connexion ', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (751, 'Inscription de PANCHA à la tontin : Tontine de 25000', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (752, 'Ajout d''une main pour le membre PANCHA', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (753, 'connexion ', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (754, 'Suppression de la main du membre : PANCHA', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (755, 'Suppression de la main du membre : NKOUCHEMOUN', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (756, 'Suppression de la main du membre : NKOUCHEMOUN', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (757, 'Suppression de la main du membre : Salif', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (758, 'Suppression de la main du membre : Dr Mbouandi', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (759, 'Suppression de la main du membre : Dr Mbouandi', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (760, 'Ajout d''une main pour le membre Dr Mbouandi', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (761, 'Ajout d''une main pour le membre Dr Mbouandi', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (762, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (763, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (764, 'Ajout d''une main pour le membre Salif', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (765, 'Ajout d''une main pour le membre Salif', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (766, 'Ajout d''une main pour le membre PANCHA', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (767, 'Ajout d''une main pour le membre PANCHA', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (768, 'Ajout d''une main pour le membre PANCHA', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (769, 'connexion ', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (770, 'Ajout d''une main pour le membre Dr Mbouandi', '2021-01-07', '2021-01-07', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (771, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (772, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (773, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (776, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (777, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (778, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (779, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (780, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (781, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (782, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (783, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (784, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (785, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (786, 'connexion ', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (787, 'Programmation de la main NKOUCHEMOUN - 1 effectué', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (788, 'Programmation de la main NKOUCHEMOUN - 2 effectué', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (789, 'Programmation de la main Dr Mbouandi - 1 effectué', '2021-01-08', '2021-01-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (790, 'connexion ', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (791, 'Programmation de la main PANCHA - 1 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (792, 'Programmation de la main Dr Mbouandi - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (793, 'connexion ', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (794, 'connexion ', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (795, 'Programmation de la main Salif - 1 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (796, 'Programmation de la main PANCHA - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (797, 'Programmation de la main Dr Mbouandi - 3 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (798, 'Programmation de la main Salif - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (799, 'Programmation de la main PANCHA - 3 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (800, 'connexion ', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (801, 'connexion ', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (802, 'connexion ', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (803, 'Déprogrammation de la main null effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (804, 'Déprogrammation de la main null effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (805, 'Programmation de la main Salif - 1 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (806, 'Déprogrammation de la main Salif - 1 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (807, 'Déprogrammation de la main Salif - 1 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (808, 'Programmation de la main PANCHA - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (809, 'Programmation de la main NKOUCHEMOUN - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (810, 'connexion ', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (811, 'Programmation de la main Dr Mbouandi - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (812, 'Déprogrammation de la main null effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (813, 'connexion ', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (814, 'Déprogrammation de la main null effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (815, 'Programmation de la main NKOUCHEMOUN - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (816, 'Programmation de la main PANCHA - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (817, 'Déprogrammation de la main PANCHA - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (818, 'Déprogrammation de la main PANCHA - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (819, 'Programmation de la main Salif - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (820, 'Déprogrammation de la main Salif - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (821, 'Déprogrammation de la main Salif - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (822, 'Programmation de la main PANCHA - 1 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (823, 'Programmation de la main Salif - 1 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (824, 'Déprogrammation de la main Salif - 1 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (825, 'Déprogrammation de la main null effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (826, 'Programmation de la main PANCHA - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (827, 'Programmation de la main Salif - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (828, 'Programmation de la main Dr Mbouandi - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (829, 'Déprogrammation de la main Dr Mbouandi - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (830, 'Déprogrammation de la main null effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (831, 'Programmation de la main Dr Mbouandi - 3 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (832, 'Programmation de la main Salif - 2 effectué', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (833, 'connexion ', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (834, 'connexion ', '2021-01-09', '2021-01-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (835, 'connexion ', '2021-01-10', '2021-01-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (836, 'connexion ', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (837, 'connexion ', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (838, 'connexion ', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (839, 'connexion ', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (840, 'connexion ', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (841, 'connexion ', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (842, 'connexion ', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (843, 'connexion ', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (844, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 1 effectué', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (845, 'Suppression de la cotisation de la main null effectué', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (846, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 1 effectué', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (847, 'Suppression de la cotisation de la main NKOUCHEMOUN - 1 effectué', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (848, 'connexion ', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (849, 'connexion ', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (850, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 1 effectué', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (851, 'connexion ', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (852, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 2 effectué', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (853, 'Enregistrement de la cotisation de la main Dr Mbouandi - 1 effectué', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (854, 'Enregistrement de la cotisation de la main Dr Mbouandi - 2 effectué', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (855, 'Enregistrement de la cotisation de la main Dr Mbouandi - 3 effectué', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (856, 'Enregistrement de la cotisation de la main Salif - 1 effectué', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (857, 'Enregistrement de la cotisation de la main Salif - 2 effectué', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (858, 'Enregistrement de la cotisation de la main PANCHA - 1 effectué', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (859, 'Enregistrement de la cotisation de la main PANCHA - 2 effectué', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (860, 'Enregistrement de la cotisation de la main PANCHA - 3 effectué', '2021-01-11', '2021-01-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (861, 'connexion ', '2021-01-13', '2021-01-13', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (862, 'connexion ', '2021-01-13', '2021-01-13', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (863, 'connexion ', '2021-01-13', '2021-01-13', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (864, 'Séance terminé Rencontre du 31 janvier 2021', '2021-01-13', '2021-01-13', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (865, 'Suppression de la cotisation de la main null effectué', '2021-01-13', '2021-01-13', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (866, 'connexion ', '2021-01-13', '2021-01-13', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (867, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 2 effectué', '2021-01-13', '2021-01-13', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (868, 'connexion ', '2021-01-13', '2021-01-13', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (869, 'connexion ', '2021-01-14', '2021-01-14', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (870, 'connexion ', '2021-01-15', '2021-01-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (871, 'connexion ', '2021-01-15', '2021-01-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (872, 'connexion ', '2021-01-17', '2021-01-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (873, 'Enregistrement de la cotisation de la main Dr Mbouandi - 1 effectué', '2021-01-17', '2021-01-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (874, 'Suppression de la cotisation de la main Dr Mbouandi - 1 effectué', '2021-01-17', '2021-01-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (875, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 2 effectué', '2021-01-17', '2021-01-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (876, 'connexion ', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (877, 'connexion ', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (878, 'connexion ', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (879, 'connexion ', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (880, 'connexion ', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (881, 'Suppression de la cotisation de la main null effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (882, 'Suppression de la cotisation de la main null effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (883, 'Suppression de la cotisation de la main null effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (884, 'Suppression de la cotisation de la main null effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (885, 'Suppression de la cotisation de la main null effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (886, 'Suppression de la cotisation de la main null effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (887, 'Suppression de la cotisation de la main null effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (888, 'Suppression de la cotisation de la main null effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (889, 'Suppression de la cotisation de la main null effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (890, 'Suppression de la cotisation de la main null effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (891, 'Suppression de la cotisation de la main null effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (892, 'Enregistrement de la tontine : cotisation de 25 mil par mois Montant : 25000.0', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (893, 'Création d''une nouvelle tontine : cotisation de 25 mil par mois : montant : 25000.0', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (894, 'Suppression de la tontine : cotisation de 25 mil par mois Montant : 25000.0', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (895, 'Enregistrement de la tontine : cotisation de 25 mille par mois Montant : 25000.0', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (896, 'Création d''une nouvelle tontine : cotisation de 25 mille par mois : montant : 25000.0', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (897, 'Inscription de NKOUCHEMOUN à la tontin : cotisation de 25 mille par mois', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (898, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (899, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (900, 'Inscription de Salif à la tontin : cotisation de 25 mille par mois', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (901, 'Ajout d''une main pour le membre Salif', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (902, 'Ajout d''une main pour le membre Salif', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (903, 'Inscription de PANCHA à la tontin : cotisation de 25 mille par mois', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (904, 'Ajout d''une main pour le membre PANCHA', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (905, 'Ajout d''une main pour le membre PANCHA', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (906, 'Inscription de Dr Mbouandi à la tontin : cotisation de 25 mille par mois', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (907, 'Ajout d''une main pour le membre Dr Mbouandi', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (908, 'Ajout d''une main pour le membre Dr Mbouandi', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (909, 'Ajout d''une main pour le membre Dr Mbouandi', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (910, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (911, 'Ajout d''une main pour le membre Salif', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (912, 'Ajout d''une main pour le membre PANCHA', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (913, 'Programmation de la main NKOUCHEMOUN - 1 effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (914, 'Programmation de la main Salif - 1 effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (915, 'Programmation de la main PANCHA - 1 effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (916, 'Programmation de la main Dr Mbouandi - 1 effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (917, 'Programmation de la main NKOUCHEMOUN - 2 effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (918, 'Programmation de la main Salif - 2 effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (919, 'Programmation de la main PANCHA - 2 effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (920, 'Programmation de la main Dr Mbouandi - 2 effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (921, 'Programmation de la main NKOUCHEMOUN - 3 effectué', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (922, 'connexion ', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (923, 'connexion ', '2021-01-18', '2021-01-18', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (924, 'Enregistrement du Pays : France', '2021-01-18', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (925, 'connexion ', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (926, 'Déprogrammation de la main null effectué', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (927, 'connexion ', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (928, 'Reinitialisation de la programmation de la cotisation  cotisation de 25 mille par mois effectué', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (929, 'connexion ', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (930, 'connexion ', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (931, 'connexion ', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (932, 'Programmation de la main NKOUCHEMOUN - 1 effectué', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (933, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 1 effectué', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (934, 'connexion ', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (935, 'Suppression de la cotisation de la main null effectué', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (936, 'Suppression de la cotisation de la main null effectué', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (937, 'Enregistrement de la cotisation de la main Salif - 1 effectué', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (938, 'connexion ', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (939, 'Suppression de la cotisation de la main null effectué', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (940, 'Enregistrement de la cotisation de la main Salif - 1 effectué', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (941, 'connexion ', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (942, 'Suppression de la cotisation de la main null effectué', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (943, 'Suppression de la cotisation de la main null effectué', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (944, 'Suppression de la cotisation de la main null effectué', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (945, 'Enregistrement de la cotisation de la main Salif - 1 effectué', '2021-01-19', '2021-01-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (946, 'connexion ', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (947, 'Suppression de la cotisation de la main null effectué', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (948, 'Enregistrement de la cotisation de la main Salif - 1 effectué', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (949, 'connexion ', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (950, 'Suppression de la cotisation de la main null effectué', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (951, 'Enregistrement de la cotisation de la main Salif - 1 effectué', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (952, 'connexion ', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (953, 'Suppression de la cotisation de la main null effectué', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (954, 'connexion ', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (955, 'Enregistrement de la cotisation de la main Salif - 1 effectué', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (956, 'connexion ', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (957, 'connexion ', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (958, 'connexion ', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (959, 'connexion ', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (960, 'connexion ', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (961, 'connexion ', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (962, 'Enregistrement de la cotisation de la main Salif - 2 effectué', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1051, 'Programmation de la main Dr Mbouandi - 2 effectué', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (963, 'Enregistrement de la cotisation de la main Salif - 3 effectué', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (964, 'connexion ', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (965, 'Enregistrement de la cotisation de la main PANCHA - 1 effectué', '2021-01-20', '2021-01-20', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (966, 'connexion ', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (967, 'connexion ', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (968, 'connexion ', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (969, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (970, 'Programmation de la main NKOUCHEMOUN - 3 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (971, 'Programmation de la main Salif - 1 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (972, 'Programmation de la main PANCHA - 1 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (973, 'Programmation de la main Dr Mbouandi - 1 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (974, 'Programmation de la main PANCHA - 2 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (975, 'Programmation de la main Salif - 2 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (976, 'Programmation de la main NKOUCHEMOUN - 4 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (977, 'Programmation de la main Dr Mbouandi - 2 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (978, 'Programmation de la main Salif - 3 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (979, 'Programmation de la main Dr Mbouandi - 3 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (980, 'Programmation de la main NKOUCHEMOUN - 2 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (981, 'Programmation de la main PANCHA - 3 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (982, 'Ajout d''une main pour le membre Dr Mbouandi', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (983, 'Programmation de la main Dr Mbouandi - 4 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (984, 'Déprogrammation de la main Dr Mbouandi - 4 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (985, 'Programmation de la main Dr Mbouandi - 4 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (986, 'Déprogrammation de la main Dr Mbouandi - 4 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (987, 'Programmation de la main NKOUCHEMOUN - 4 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (988, 'Déprogrammation de la main NKOUCHEMOUN - 4 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (989, 'Déprogrammation de la main NKOUCHEMOUN - 4 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (990, 'Programmation de la main Dr Mbouandi - 4 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (991, 'Déprogrammation de la main Dr Mbouandi - 4 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (992, 'Programmation de la main Dr Mbouandi - 4 effectué', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (993, 'connexion ', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (994, 'Enregistrement de la tontine : test Montant : 35000.0', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (995, 'Création d''une nouvelle tontine : test : montant : 35000.0', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (996, 'Suppression de la tontine : test Montant : 35000.0', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (997, 'connexion ', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (998, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-01-21', '2021-01-21', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (999, 'connexion ', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1000, 'Séance terminé Rencontre du 1er janvier 2020', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1001, 'connexion ', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1002, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 2 effectué', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1003, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 4 effectué', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1004, 'Enregistrement de la cotisation de la main PANCHA - 2 effectué', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1005, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 5 effectué', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1006, 'Enregistrement de la cotisation de la main Dr Mbouandi - 2 effectué', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1007, 'Enregistrement de la cotisation de la main PANCHA - 3 effectué', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1008, 'Enregistrement de la cotisation de la main Dr Mbouandi - 3 effectué', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1009, 'Enregistrement de la cotisation de la main Dr Mbouandi - 1 effectué', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1010, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 3 effectué', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1011, 'Enregistrement de la cotisation de la main Dr Mbouandi - 4 effectué', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1012, 'Séance terminé Rencontre du 1er janvier 2020', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1013, 'connexion ', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1014, 'connexion ', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1015, 'connexion ', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1016, 'Séance terminé Rencontre du 1er janvier 2020', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1017, 'connexion ', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1018, 'Séance terminé Rencontre du 1er janvier 2020', '2021-01-22', '2021-01-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1019, 'connexion ', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1020, 'connexion ', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1021, 'connexion ', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1022, 'Enregistrement de la tontine : NAL cotisation 25000 Montant : 25000.0', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1023, 'Création d''une nouvelle tontine : NAL cotisation 25000 : montant : 25000.0', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1024, 'Inscription de NKOUCHEMOUN à la tontin : NAL cotisation 25000', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1025, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1026, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1027, 'Inscription de Salif à la tontin : NAL cotisation 25000', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1028, 'Ajout d''une main pour le membre Salif', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1029, 'Ajout d''une main pour le membre Salif', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1030, 'Inscription de Dr Mbouandi à la tontin : NAL cotisation 25000', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1031, 'Ajout d''une main pour le membre Dr Mbouandi', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1032, 'Inscription de PANCHA à la tontin : NAL cotisation 25000', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1033, 'Ajout d''une main pour le membre PANCHA', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1034, 'Ajout d''une main pour le membre Dr Mbouandi', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1035, 'Ajout d''une main pour le membre Dr Mbouandi', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1036, 'Ajout d''une main pour le membre Salif', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1037, 'Ajout d''une main pour le membre PANCHA', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1038, 'Ajout d''une main pour le membre PANCHA', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1039, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1040, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1041, 'Ajout d''une main pour le membre Salif', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1042, 'Programmation de la main NKOUCHEMOUN - 2 effectué', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1043, 'Programmation de la main NKOUCHEMOUN - 3 effectué', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1044, 'Programmation de la main NKOUCHEMOUN - 4 effectué', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1045, 'Programmation de la main NKOUCHEMOUN - 1 effectué', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1046, 'Programmation de la main Salif - 1 effectué', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1047, 'Programmation de la main Salif - 2 effectué', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1048, 'Programmation de la main Salif - 4 effectué', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1049, 'Programmation de la main Salif - 3 effectué', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1050, 'Programmation de la main Dr Mbouandi - 1 effectué', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1052, 'Programmation de la main Dr Mbouandi - 3 effectué', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1053, 'Programmation de la main PANCHA - 1 effectué', '2021-01-25', '2021-01-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1054, 'Enregistrement du Rencontre : Rencontre du - dimanche 8 décembre', '2021-01-25', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1055, 'connexion ', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1056, 'Enregistrement du Rencontre : Rencontre du - dimanche 5 décembre 2021', '2021-01-26', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1057, 'Programmation de la main PANCHA - 2 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1058, 'Déprogrammation de la main null effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1059, 'Programmation de la main NKOUCHEMOUN - 1 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1060, 'connexion ', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1061, 'Programmation de la main NKOUCHEMOUN - 1 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1062, 'connexion ', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1063, 'Programmation de la main NKOUCHEMOUN - 1 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1064, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 1 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1065, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 2 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1066, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 3 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1067, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 4 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1068, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 5 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1069, 'Enregistrement de la cotisation de la main Salif - 1 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1070, 'Enregistrement de la cotisation de la main Salif - 2 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1071, 'Enregistrement de la cotisation de la main Salif - 3 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1072, 'Enregistrement de la cotisation de la main PANCHA - 1 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1073, 'Enregistrement de la cotisation de la main PANCHA - 2 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1074, 'Enregistrement de la cotisation de la main PANCHA - 3 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1075, 'Enregistrement de la cotisation de la main Dr Mbouandi - 1 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1076, 'Enregistrement de la cotisation de la main Dr Mbouandi - 2 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1077, 'Enregistrement de la cotisation de la main Dr Mbouandi - 3 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1078, 'Enregistrement de la cotisation de la main Dr Mbouandi - 4 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1079, 'Séance terminé Rencontre du 1er janvier 2020', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1080, 'connexion ', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1081, 'connexion ', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1082, 'Programmation de la main NKOUCHEMOUN - 2 effectué', '2021-01-26', '2021-01-26', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1083, 'connexion ', '2021-01-28', '2021-01-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1084, 'connexion ', '2021-01-28', '2021-01-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1085, 'Modification du Cycle de Tontine ->  NAL 2020 -> NAL 2020', '2021-01-28', '2021-01-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1086, 'connexion ', '2021-01-28', '2021-01-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1087, 'Modification du Cycle de Tontine ->  NAL 2020 -> NAL 2020', '2021-01-28', '2021-01-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1088, 'connexion ', '2021-01-28', '2021-01-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1089, 'Modification du Cycle de Tontine ->  NAL 2020 -> NAL 2020', '2021-01-28', '2021-01-28', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1090, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1091, 'Modification du Cycle de Tontine ->  NAL 2020 -> NAL 2020', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1092, 'Modification du Cycle de Tontine ->  NAL 2020 -> NAL 2020', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1093, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1094, 'Modification du Cycle de Tontine ->  NAL 2020 -> NAL 2020', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1095, 'Déconnexion', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1096, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1097, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1098, 'Modification du Cycle de Tontine ->  NAL 2020 -> NAL 2020', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1099, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1100, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1101, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1102, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1103, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1104, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1105, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1106, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1107, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1108, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1109, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1110, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1111, 'connexion ', '2021-01-29', '2021-01-29', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1112, 'connexion ', '2021-02-01', '2021-02-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1113, 'connexion ', '2021-02-01', '2021-02-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1114, 'connexion ', '2021-02-01', '2021-02-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1115, 'connexion ', '2021-02-01', '2021-02-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1116, 'connexion ', '2021-02-01', '2021-02-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1117, 'Suppression de la cotisation de la main null effectué', '2021-02-01', '2021-02-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1118, 'connexion ', '2021-02-01', '2021-02-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1119, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1120, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1121, 'Déconnexion', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1122, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1123, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1124, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1125, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1126, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1127, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1128, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1129, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1130, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1131, 'Remboursement de l''assistance par la main + Salif - 3', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1132, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1133, 'Déconnexion', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1134, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1135, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1136, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1137, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1138, 'connexion ', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1139, 'Remboursement de l''assistance par la main + Salif - 3', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1140, 'Remboursement de l''assistance par la main + PANCHA - 3', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1141, 'Déconnexion', '2021-02-02', '2021-02-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1142, 'connexion ', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1143, 'connexion ', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1144, 'Modification du Cycle de Tontine ->  NAL 2020 -> NAL 2020', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1145, 'Enregistrement du cycle Tontine  -> nal 2022', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1146, 'Suppression du cycle nal 2022', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1147, 'Création d''une nouvelle cotisation : cotisation test : montant : 12000.0', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1148, 'connexion ', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1149, 'connexion ', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1150, 'Enregistrement de la tontine : cotisation test Montant : 12000.0', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1151, 'Création d''une nouvelle cotisation : cotisation test : montant : 12000.0', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1152, 'Suppression de la tontine : cotisation test Montant : 12000.0', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1153, 'Enregistrement de la tontine : cotisation test Montant : 12000.0', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1154, 'Création d''une nouvelle cotisation : cotisation test : montant : 12000.0', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1155, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1156, 'connexion ', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1157, 'Modification du Cycle de Tontine ->  NAL 2019 -> NAL 2019', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1158, 'Déconnexion', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1159, 'connexion ', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1160, 'connexion ', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1161, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1162, 'Inscription de NKOUCHEMOUN à la tontin : cotisation test', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1163, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1164, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1165, 'Ajout d''une main pour le membre NKOUCHEMOUN', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1166, 'Inscription de Salif à la tontin : cotisation test', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1167, 'Ajout d''une main pour le membre Salif', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1168, 'Ajout d''une main pour le membre Salif', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1169, 'Inscription de Dr Mbouandi à la tontin : cotisation test', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1170, 'Ajout d''une main pour le membre Dr Mbouandi', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1171, 'Ajout d''une main pour le membre Dr Mbouandi', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1172, 'Inscription de PANCHA à la tontin : cotisation test', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1173, 'Ajout d''une main pour le membre PANCHA', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1174, 'Ajout d''une main pour le membre PANCHA', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1175, 'Ajout d''une main pour le membre PANCHA', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1176, 'Ajout d''une main pour le membre PANCHA', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1177, 'Ajout d''une main pour le membre PANCHA', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1178, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1179, 'connexion ', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1180, 'connexion ', '2021-02-15', '2021-02-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1181, 'connexion ', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1182, 'Mise a jour des proprietes de la cotisation : NAL cotisation 25000', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1183, 'Déconnexion', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1184, 'connexion ', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1185, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1186, 'connexion ', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1187, 'Programmation de la main NKOUCHEMOUN - 1 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1188, 'connexion ', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1189, 'Programmation de la main NKOUCHEMOUN - 2 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1190, 'Déprogrammation de la main NKOUCHEMOUN - 2 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1191, 'Programmation de la main Salif - 1 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1192, 'Programmation de la main Dr Mbouandi - 1 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1193, 'Programmation de la main PANCHA - 2 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1194, 'Programmation de la main NKOUCHEMOUN - 3 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1195, 'Programmation de la main PANCHA - 1 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1196, 'Programmation de la main PANCHA - 3 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1197, 'Programmation de la main Salif - 2 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1198, 'Programmation de la main PANCHA - 4 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1199, 'Programmation de la main Dr Mbouandi - 2 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1200, 'Programmation de la main NKOUCHEMOUN - 2 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1201, 'Programmation de la main PANCHA - 5 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1202, 'connexion ', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1203, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1204, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1205, 'connexion ', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1206, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1207, 'Reinitialisation de la programmation de la cotisation  cotisation test effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1208, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1209, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1210, 'Programmation de la main NKOUCHEMOUN - 1 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1211, 'connexion ', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1212, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1213, 'Reinitialisation de la programmation de la cotisation  cotisation test effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1214, 'Programmation de la main PANCHA - 3 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1215, 'connexion ', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1216, 'Ajout d''une main pour le membre Salif', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1217, 'connexion ', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1218, 'connexion ', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1219, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 1 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1220, 'connexion ', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1221, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 2 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1222, 'Suppression de la cotisation de la main NKOUCHEMOUN - 2 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1223, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 1 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1224, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 1 effectué', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1225, 'Mise a jour des proprietes de la cotisation : cotisation de 25 mille par mois', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1226, 'connexion ', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1227, 'connexion ', '2021-02-16', '2021-02-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1228, 'connexion ', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1229, 'Reinitialisation de la programmation de la cotisation  cotisation test effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1230, 'connexion ', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1231, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 1 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1232, 'Suppression de la cotisation de la main NKOUCHEMOUN - 1 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1233, 'Programmation de la main NKOUCHEMOUN - 1 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1234, 'Enregistrement de la cotisation de la main NKOUCHEMOUN - 3 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1235, 'Enregistrement de la cotisation de la main Salif - 1 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1236, 'Enregistrement de la cotisation de la main Salif - 2 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1237, 'Enregistrement de la cotisation de la main Salif - 3 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1238, 'Enregistrement de la cotisation de la main Dr Mbouandi - 1 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1239, 'Enregistrement de la cotisation de la main Dr Mbouandi - 2 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1240, 'Enregistrement de la cotisation de la main PANCHA - 1 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1241, 'Enregistrement de la cotisation de la main PANCHA - 2 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1242, 'Enregistrement de la cotisation de la main PANCHA - 4 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1243, 'Enregistrement de la cotisation de la main PANCHA - 3 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1244, 'Enregistrement de la cotisation de la main PANCHA - 5 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1245, 'Séance terminé (Rencontre du 31 janvier 2021)', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1246, 'connexion ', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1247, 'connexion ', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1248, 'Programmation de la main Salif - 2 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1249, 'Programmation de la main Salif - 1 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1250, 'Programmation de la main Dr Mbouandi - 1 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1251, 'Programmation de la main PANCHA - 1 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1252, 'Programmation de la main NKOUCHEMOUN - 2 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1253, 'Programmation de la main PANCHA - 2 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1254, 'Déprogrammation de la main PANCHA - 2 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1255, 'connexion ', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1256, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1257, 'Programmation de la main PANCHA - 4 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1258, 'Programmation de la main Salif - 3 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1259, 'Programmation de la main PANCHA - 3 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1260, 'Programmation de la main NKOUCHEMOUN - 3 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1261, 'Programmation de la main Dr Mbouandi - 2 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1262, 'Programmation de la main PANCHA - 5 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1263, 'Programmation de la main Salif - 1 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1264, 'Déprogrammation de la main Salif - 1 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1265, 'Déprogrammation de la main null effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1266, 'Programmation de la main Dr Mbouandi - 2 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1267, 'Programmation de la main Salif - 1 effectué', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1268, 'connexion ', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1269, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1270, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1271, 'connexion ', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1272, 'connexion ', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1273, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1274, 'connexion ', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1275, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1276, 'connexion ', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1277, 'Enregistrement de la tontine : cotisation test 2 Montant : 0.0', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1278, 'Création d''une nouvelle cotisation : cotisation test 2 : montant : 0.0', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1279, 'connexion ', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1280, 'connexion ', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1281, 'Suppression de la tontine : cotisation test 2 Montant : 0.0', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1282, 'connexion ', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1283, 'Remboursement de l''assistance par la main + PANCHA - 5', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1284, 'Mise a jour des proprietes de la cotisation : cotisation test', '2021-02-19', '2021-02-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1285, 'connexion ', '2021-02-22', '2021-02-22', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1286, 'Enregistrement du fond de caisse du membre  -> NKOUCHEMOUN ALIMA ; Montant -> 20000.0', '2021-02-22', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1287, 'Enregistrement du fond de caisse du membre  -> Salif Michael  ; Montant -> 15000.0', '2021-02-22', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1288, 'Enregistrement du fond de caisse du membre  -> Dr Mbouandi - ; Montant -> 150000.0', '2021-02-22', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1289, 'Suppression des frais de secours du membre -> Dr Mbouandi - Montant -> 150000.0', '2021-02-22', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1290, 'Enregistrement du fond de caisse du membre  -> Dr Mbouandi - ; Montant -> 15000.0', '2021-02-22', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1291, 'Enregistrement du fond de caisse du membre  -> PANCHA Mohamed ; Montant -> 10000.0', '2021-02-22', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1292, 'Enregistrement de l''aide du membre -> Salif Michael ', '2021-02-22', NULL, 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1293, 'connexion ', '2021-03-01', '2021-03-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1294, 'connexion ', '2021-03-01', '2021-03-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1295, 'Enregistrement de la tontine : Test Montant : 6000.0', '2021-03-01', '2021-03-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1296, 'Création d''une nouvelle cotisation : Test : montant : 6000.0', '2021-03-01', '2021-03-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1297, 'Mise a jour des proprietes de la cotisation : Test', '2021-03-01', '2021-03-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1298, 'connexion ', '2021-03-01', '2021-03-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1299, 'connexion ', '2021-03-01', '2021-03-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1300, 'connexion ', '2021-03-01', '2021-03-01', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1301, 'connexion ', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1302, 'connexion ', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1303, 'Enregistrement du Rencontre : Rencontre du 6 Mars 2021', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1304, 'Déconnexion', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1305, 'connexion ', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1306, 'connexion ', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1307, 'connexion ', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1308, 'connexion ', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1309, 'Mise a jour des proprietes de la cotisation : Test', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1310, 'connexion ', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1311, 'connexion ', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1312, 'Mise a jour des proprietes de la cotisation : Test', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1313, 'Mise a jour des proprietes de la cotisation : Test', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1314, 'Inscription de ATEBA ASOMO à la tontin : Test', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1315, 'Ajout d''une main pour le membre ATEBA ASOMO', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1316, 'Ajout d''une main pour le membre ATEBA ASOMO', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1317, 'Ajout d''une main pour le membre ATEBA ASOMO', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1318, 'Inscription de ERIC à la tontin : Test', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1319, 'Ajout d''une main pour le membre ERIC', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1320, 'Ajout d''une main pour le membre ERIC', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1321, 'Ajout d''une main pour le membre ERIC', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1322, 'Inscription de MFOUAPON à la tontin : Test', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1323, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1324, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1325, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1326, 'Programmation de la main ATEBA ASOMO - 1 effectué', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1327, 'Programmation de la main ATEBA ASOMO - 3 effectué', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1328, 'Programmation de la main ERIC - 1 effectué', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1329, 'Programmation de la main ERIC - 3 effectué', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1330, 'Programmation de la main ERIC - 2 effectué', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1331, 'Programmation de la main MFOUAPON - 1 effectué', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1332, 'Programmation de la main ATEBA ASOMO - 2 effectué', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1333, 'Programmation de la main MFOUAPON - 2 effectué', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1334, 'Programmation de la main MFOUAPON - 3 effectué', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1335, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1336, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1337, 'connexion ', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1338, 'Reinitialisation de la programmation de la cotisation  Test effectué', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1339, 'connexion ', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1340, 'connexion ', '2021-03-02', '2021-03-02', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1341, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1342, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1343, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1344, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1345, 'Déconnexion', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1346, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1347, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1348, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1349, 'Programmation de la main ATEBA ASOMO - 1 effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1350, 'Programmation de la main ATEBA ASOMO - 2 effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1351, 'Programmation de la main ATEBA ASOMO - 3 effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1352, 'Programmation de la main ERIC - 1 effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1353, 'Programmation de la main ERIC - 2 effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1354, 'Programmation de la main ERIC - 3 effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1355, 'Programmation de la main MFOUAPON - 1 effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1356, 'Programmation de la main MFOUAPON - 2 effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1357, 'Programmation de la main MFOUAPON - 3 effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1358, 'Enregistrement du Rencontre : Rencontre du 13 Mars 2021', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1359, 'Mise a jour des proprietes de la cotisation : Test', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1360, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1361, 'Déprogrammation de la main null effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1362, 'Déprogrammation de la main null effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1363, 'Déprogrammation de la main null effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1364, 'Déprogrammation de la main null effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1365, 'Déprogrammation de la main null effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1366, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1367, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1368, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1369, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1370, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1371, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1372, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1373, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1374, 'connexion ', '2021-03-03', '2021-03-03', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1375, 'connexion ', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1376, 'connexion ', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1377, 'connexion ', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1378, 'connexion ', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1379, 'connexion ', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1380, 'connexion ', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1381, 'connexion ', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1382, 'connexion ', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1383, 'connexion ', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1384, 'connexion ', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1385, 'Enregistrement de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1386, 'Enregistrement de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1387, 'Enregistrement de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1388, 'Enregistrement de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1389, 'Enregistrement de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1390, 'Enregistrement de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1391, 'Enregistrement de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1392, 'Enregistrement de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1393, 'Enregistrement de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1394, 'Suppression de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1395, 'connexion ', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1396, 'Suppression de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1397, 'Suppression de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1398, 'Suppression de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1399, 'Suppression de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1400, 'Suppression de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1401, 'Suppression de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1402, 'Suppression de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1403, 'Suppression de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1404, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1405, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1406, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1407, 'Suppression de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1408, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1409, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1410, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1411, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1412, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1413, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1414, 'connexion ', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1415, 'Suppression de la cotisation de la main null effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1416, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1417, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1418, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1419, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1420, 'Enregistrement de la cotisation de la main ERIC - 2 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1421, 'Enregistrement de la cotisation de la main ERIC - 3 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1422, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1423, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1424, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1425, 'Séance terminé (Rencontre du 6 Mars 2021)', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1426, 'connexion ', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1427, 'connexion ', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1428, 'Programmation de la main ATEBA ASOMO - 1 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1429, 'Programmation de la main ERIC - 1 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1430, 'Programmation de la main MFOUAPON - 1 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1431, 'Programmation de la main ATEBA ASOMO - 3 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1432, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1433, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1434, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1435, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1436, 'Enregistrement de la cotisation de la main ERIC - 2 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1437, 'Enregistrement de la cotisation de la main ERIC - 3 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1438, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1439, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1440, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-04', '2021-03-04', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1441, 'connexion ', '2021-03-05', '2021-03-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1442, 'Séance terminé (Rencontre du 6 Mars 2021)', '2021-03-05', '2021-03-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1443, 'connexion ', '2021-03-05', '2021-03-05', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1444, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1445, 'Déprogrammation de la main null effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1446, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1447, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1448, 'Programmation de la main ATEBA ASOMO - 1 par les encheres effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1449, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1450, 'Programmation de la main ERIC - 1 par les encheres effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1451, 'Programmation de la main MFOUAPON - 1 par les encheres effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1452, 'Programmation de la main MFOUAPON - 2 par les encheres effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1453, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1454, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1455, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1456, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1457, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1458, 'Enregistrement de la cotisation de la main ERIC - 2 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1459, 'Enregistrement de la cotisation de la main ERIC - 3 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1460, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1461, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1462, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1463, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1464, 'Séance terminé (Rencontre du 6 Mars 2021)', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1465, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1466, 'Mise a jour des proprietes de la cotisation : Test', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1467, 'Déconnexion', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1468, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1469, 'Suppression de la main du membre : ATEBA ASOMO', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1470, 'Suppression de la main du membre : ATEBA ASOMO', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1471, 'Suppression de la main du membre : ATEBA ASOMO', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1472, 'Suppression de la tontine : Test Montant : 6000.0', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1473, 'Enregistrement de la tontine : test Montant : 12000.0', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1474, 'Création d''une nouvelle cotisation : test : montant : 12000.0', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1475, 'Mise a jour des proprietes de la cotisation : test', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1476, 'Inscription de ATEBA ASOMO à la tontin : test', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1477, 'Ajout d''une main pour le membre ATEBA ASOMO', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1478, 'Inscription de BESSALA à la tontin : test', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1479, 'Ajout d''une main pour le membre BESSALA', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1480, 'Inscription de ERIC à la tontin : test', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1481, 'Ajout d''une main pour le membre ERIC', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1482, 'Inscription de MEBARA à la tontin : test', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1483, 'Ajout d''une main pour le membre MEBARA', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1484, 'Inscription de NDENDE à la tontin : test', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1485, 'Ajout d''une main pour le membre NDENDE', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1486, 'Enregistrement du Rencontre : Rencontre du 20 Mars 2021', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1487, 'Enregistrement du Rencontre : Rencontre du 27 Mars 2021', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1488, 'Enregistrement du Rencontre : Rencontre du 02 Avril 2021', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1489, 'Enregistrement du Rencontre : Rencontre du 09 Avril 2021', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1490, 'Mise a jour des proprietes de la cotisation : test', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1491, 'Programmation de la main ATEBA ASOMO - 1 par les encheres effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1492, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1493, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1494, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1495, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1496, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1497, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1498, 'Séance terminé (Rencontre du 6 Mars 2021)', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1499, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1500, 'Programmation de la main ATEBA ASOMO - 1 par les encheres effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1501, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1502, 'Déprogrammation de la main null effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1503, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1504, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1505, 'Programmation de la main ATEBA ASOMO - 1 par les encheres effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1506, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1507, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1508, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1509, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1510, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1511, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1512, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1513, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1514, 'Séance terminé (Rencontre du 6 Mars 2021)', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1515, 'Programmation de la main BESSALA - 1 par les encheres effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1516, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1517, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1518, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1519, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1520, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1521, 'Séance terminé (Rencontre du 13 Mars 2021)', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1522, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1523, 'connexion ', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1524, 'Programmation de la main ATEBA ASOMO - 1 par les encheres effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1525, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1526, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1527, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1528, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1529, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1530, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1531, 'Séance terminé (Rencontre du 6 Mars 2021)', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1532, 'Programmation de la main BESSALA - 1 par les encheres effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1533, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1534, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1535, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1536, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1537, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1538, 'Séance terminé (Rencontre du 13 Mars 2021)', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1539, 'Programmation de la main ERIC - 1 par les encheres effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1540, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1541, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1542, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1543, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1544, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1545, 'Séance terminé (Rencontre du 20 Mars 2021)', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1546, 'Inscription de MFOUAPON à la tontin : test', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1547, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-08', '2021-03-08', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1548, 'connexion ', '2021-03-09', '2021-03-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1549, 'connexion ', '2021-03-09', '2021-03-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1550, 'connexion ', '2021-03-09', '2021-03-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1551, 'connexion ', '2021-03-09', '2021-03-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1552, 'connexion ', '2021-03-09', '2021-03-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1553, 'connexion ', '2021-03-09', '2021-03-09', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1554, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1555, 'Programmation de la main MFOUAPON - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1556, 'Programmation de la main NDENDE - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1557, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1558, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1559, 'Déprogrammation de la main null effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1560, 'Déprogrammation de la main null effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1561, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1562, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1563, 'Programmation de la main MEBARA - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1564, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1565, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1566, 'Programmation de la main MFOUAPON - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1567, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1568, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1569, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1570, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1571, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1572, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1573, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1574, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1575, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1576, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1577, 'Séance terminé (Rencontre du 27 Mars 2021)', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1578, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1579, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1580, 'Programmation de la main NDENDE - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1581, 'Programmation de la main MFOUAPON - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1582, 'Déprogrammation de la main null effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1583, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1584, 'Déprogrammation de la main null effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1585, 'Programmation de la main MEBARA - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1586, 'Programmation de la main MFOUAPON - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1587, 'Déprogrammation de la main MFOUAPON - 1 effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1588, 'Déprogrammation de la main null effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1589, 'Programmation de la main MEBARA - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1590, 'Programmation de la main MFOUAPON - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1591, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1592, 'Déprogrammation de la main null effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1593, 'Déprogrammation de la main null effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1594, 'Programmation de la main MEBARA - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1595, 'Programmation de la main MFOUAPON - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1596, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1597, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1598, 'Programmation de la main MFOUAPON - 2 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1599, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1600, 'Déprogrammation de la main null effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1601, 'Déprogrammation de la main null effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1602, 'Déprogrammation de la main null effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1603, 'Programmation de la main MEBARA - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1604, 'Programmation de la main MFOUAPON - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1605, 'Programmation de la main MFOUAPON - 2 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1606, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1607, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1608, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1609, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1610, 'connexion ', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1611, 'Déprogrammation de la main null effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1612, 'Programmation de la main MEBARA - 1 par les encheres effectué', '2021-03-10', '2021-03-10', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1613, 'connexion ', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1614, 'connexion ', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1615, 'connexion ', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1616, 'Déconnexion', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1617, 'connexion ', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1618, 'Enregistrement du Rencontre : Rencontre du 10 Avril 2021', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1619, 'Enregistrement de la tontine : test 2  Montant : 15000.0', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1620, 'Création d''une nouvelle cotisation : test 2  : montant : 15000.0', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1621, 'Déprogrammation de la main null effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1622, 'Programmation de la main NDENDE - 1 par les encheres effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1623, 'Déprogrammation de la main NDENDE - 1 effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1624, 'Déprogrammation de la main NDENDE - 1 effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1625, 'Déprogrammation de la main NDENDE - 1 effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1626, 'Programmation de la main MEBARA - 1 par les encheres effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1627, 'Programmation de la main MFOUAPON - 1 par les encheres effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1628, 'Programmation de la main MFOUAPON - 2 par les encheres effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1629, 'Déprogrammation de la main MFOUAPON - 2 effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1630, 'Programmation de la main MFOUAPON - 2 par les encheres effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1631, 'connexion ', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1632, 'Déprogrammation de la main null effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1633, 'Programmation de la main MFOUAPON - 1 par les encheres effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1634, 'connexion ', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1635, 'connexion ', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1636, 'connexion ', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1637, 'Déprogrammation de la main null effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1638, 'Programmation de la main MEBARA - 1 par les encheres effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1639, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1640, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1641, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1642, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1643, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1644, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1645, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1646, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1647, 'Séance terminé (Rencontre du 27 Mars 2021)', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1648, 'connexion ', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1649, 'connexion ', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1650, 'connexion ', '2021-03-11', '2021-03-11', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1651, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1652, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1653, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1654, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1655, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1656, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1657, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1658, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1659, 'Séance terminé (Rencontre du 27 Mars 2021)', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1660, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1661, 'Déprogrammation de la main null effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1662, 'Déprogrammation de la main null effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1663, 'Suppression de la cotisation de la main null effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1664, 'Suppression de la cotisation de la main null effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1665, 'Suppression de la main du membre : MFOUAPON', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1666, 'Suppression de la main du membre : MFOUAPON', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1667, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1668, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1669, 'Séance terminé (Rencontre du 6 Mars 2021)', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1670, 'Séance terminé (Rencontre du 13 Mars 2021)', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1671, 'Séance terminé (Rencontre du 20 Mars 2021)', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1672, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1673, 'Séance terminé (Rencontre du 20 Mars 2021)', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1674, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1675, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1676, 'Programmation de la main MFOUAPON - 1 par les encheres effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1677, 'Programmation de la main MFOUAPON - 2 par les encheres effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1678, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1679, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1680, 'Séance terminé (Rencontre du 27 Mars 2021)', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1681, 'Programmation de la main NDENDE - 1 par les encheres effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1682, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1683, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1684, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1685, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1686, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1687, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1688, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1689, 'Séance terminé (Rencontre du 02 Avril 2021)', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1690, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1691, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1692, 'cotisation : test : montant : 12000.0 est terminé', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1693, 'connexion ', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1694, 'cotisation : test : montant : 12000.0 est terminé', '2021-03-15', '2021-03-15', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1695, 'connexion ', '2021-03-16', '2021-03-16', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1696, 'connexion ', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1697, 'connexion ', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1698, 'Enregistrement de la tontine : cotisation sans enchere Montant : 15000.0', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1699, 'Création d''une nouvelle cotisation : cotisation sans enchere : montant : 15000.0', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1700, 'Inscription de ATEBA ASOMO à la tontin : test 2 ', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1701, 'Ajout d''une main pour le membre ATEBA ASOMO', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1702, 'Ajout d''une main pour le membre ATEBA ASOMO', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1703, 'Inscription de BESSALA à la tontin : test 2 ', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1704, 'Ajout d''une main pour le membre BESSALA', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1705, 'Ajout d''une main pour le membre BESSALA', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1706, 'Inscription de ERIC à la tontin : test 2 ', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1707, 'Ajout d''une main pour le membre ERIC', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1708, 'Ajout d''une main pour le membre ERIC', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1709, 'Inscription de MEBARA à la tontin : test 2 ', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1710, 'Ajout d''une main pour le membre MEBARA', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1711, 'Inscription de MFOUAPON à la tontin : test 2 ', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1712, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1713, 'Inscription de NDENDE à la tontin : test 2 ', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1714, 'Ajout d''une main pour le membre NDENDE', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1715, 'Inscription de ATEBA ASOMO à la tontin : cotisation sans enchere', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1716, 'Ajout d''une main pour le membre ATEBA ASOMO', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1717, 'Ajout d''une main pour le membre ATEBA ASOMO', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1718, 'Inscription de BESSALA à la tontin : cotisation sans enchere', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1719, 'Ajout d''une main pour le membre BESSALA', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1720, 'Inscription de ERIC à la tontin : cotisation sans enchere', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1721, 'Ajout d''une main pour le membre ERIC', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1722, 'Inscription de MEBARA à la tontin : cotisation sans enchere', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1723, 'Ajout d''une main pour le membre MEBARA', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1724, 'Ajout d''une main pour le membre MEBARA', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1725, 'Inscription de MFOUAPON à la tontin : cotisation sans enchere', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1726, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1727, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1728, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1729, 'Inscription de NDENDE à la tontin : cotisation sans enchere', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1730, 'Ajout d''une main pour le membre NDENDE', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1731, 'Ajout d''une main pour le membre NDENDE', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1732, 'Programmation de la main ATEBA ASOMO - 1 par les encheres effectué', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1733, 'Programmation de la main ATEBA ASOMO - 1 effectué', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1734, 'Programmation de la main ATEBA ASOMO - 2 effectué', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1735, 'Programmation de la main BESSALA - 1 effectué', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1736, 'Programmation de la main ERIC - 1 effectué', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1737, 'Programmation de la main MEBARA - 1 effectué', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1738, 'Programmation de la main MEBARA - 2 effectué', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1739, 'Programmation de la main MFOUAPON - 1 effectué', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1740, 'Programmation de la main MFOUAPON - 2 effectué', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1741, 'Programmation de la main MFOUAPON - 3 effectué', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1742, 'Programmation de la main NDENDE - 1 effectué', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1743, 'Programmation de la main NDENDE - 2 effectué', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1744, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1745, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-17', '2021-03-17', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1746, 'connexion ', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1747, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1748, 'Enregistrement de la cotisation de la main ERIC - 2 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1749, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1750, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1751, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1752, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1753, 'Enregistrement de la cotisation de la main BESSALA - 2 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1754, 'Séance terminé (Rencontre du 13 Mars 2021)', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1755, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1756, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1757, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1758, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1759, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1760, 'Enregistrement de la cotisation de la main MEBARA - 2 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1761, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1762, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1763, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1764, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1765, 'Enregistrement de la cotisation de la main NDENDE - 2 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1766, 'Séance terminé (Rencontre du 6 Mars 2021)', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1767, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1768, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1769, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1770, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1771, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1772, 'Enregistrement de la cotisation de la main MEBARA - 2 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1773, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1774, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1775, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1776, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1777, 'Enregistrement de la cotisation de la main NDENDE - 2 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1778, 'Séance terminé (Rencontre du 13 Mars 2021)', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1779, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1780, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1781, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1782, 'connexion ', '2021-03-19', '2021-03-19', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1783, 'connexion ', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1784, 'connexion ', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1785, 'connexion ', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1786, 'connexion ', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1787, 'connexion ', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1788, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1789, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1790, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1791, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1792, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1793, 'Enregistrement de la cotisation de la main MEBARA - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1794, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1795, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1796, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1797, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1798, 'Enregistrement de la cotisation de la main NDENDE - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1799, 'Programmation de la main ATEBA ASOMO - 2 par les encheres effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1800, 'Programmation de la main BESSALA - 1 par les encheres effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1801, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1802, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1803, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1804, 'Enregistrement de la cotisation de la main BESSALA - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1805, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1806, 'Enregistrement de la cotisation de la main ERIC - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1807, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1808, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1809, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1810, 'connexion ', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1811, 'Séance terminé (Rencontre du 20 Mars 2021)', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1812, 'Séance terminé (Rencontre du 20 Mars 2021)', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1813, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1814, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1815, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1816, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1817, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1818, 'Enregistrement de la cotisation de la main MEBARA - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1819, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1820, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1821, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1822, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1823, 'Enregistrement de la cotisation de la main NDENDE - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1824, 'Séance terminé (Rencontre du 02 Avril 2021)', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1825, 'connexion ', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1826, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1827, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1828, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1829, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1830, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1831, 'Enregistrement de la cotisation de la main MEBARA - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1832, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1833, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1834, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1835, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1836, 'Enregistrement de la cotisation de la main NDENDE - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1837, 'Séance terminé (Rencontre du 09 Avril 2021)', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1838, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1839, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1840, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1841, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1842, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1843, 'Enregistrement de la cotisation de la main MEBARA - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1844, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1845, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1846, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1847, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1848, 'Enregistrement de la cotisation de la main NDENDE - 2 effectué', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1849, 'Séance terminé (Rencontre du 10 Avril 2021)', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1850, 'Remboursement de l''assistance par la main + BESSALA - 1', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1851, 'Remboursement de l''assistance par la main + NDENDE - 2', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1852, 'Remboursement de l''assistance par la main + NDENDE - 2', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1853, 'cotisation : cotisation sans enchere : montant : 15000.0 est terminé', '2021-03-23', '2021-03-23', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1854, 'connexion ', '2021-03-24', '2021-03-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1855, 'connexion ', '2021-03-24', '2021-03-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1856, 'Enregistrement de la tontine : cotisation sans enchere Montant : 15000.0', '2021-03-24', '2021-03-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1857, 'Création d''une nouvelle cotisation : cotisation sans enchere : montant : 15000.0', '2021-03-24', '2021-03-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1858, 'Enregistrement de la tontine : Cotisation Montant : 25000.0', '2021-03-24', '2021-03-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1859, 'Création d''une nouvelle cotisation : Cotisation : montant : 25000.0', '2021-03-24', '2021-03-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1860, 'Inscription de ATEBA ASOMO à la tontin : cotisation sans enchere', '2021-03-24', '2021-03-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1861, 'Ajout d''une main pour le membre ATEBA ASOMO', '2021-03-24', '2021-03-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1862, 'Ajout d''une main pour le membre ATEBA ASOMO', '2021-03-24', '2021-03-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1863, 'Ajout d''une main pour le membre ATEBA ASOMO', '2021-03-24', '2021-03-24', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1864, 'connexion ', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1865, 'Inscription de BESSALA à la tontin : cotisation sans enchere', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1866, 'Ajout d''une main pour le membre BESSALA', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1867, 'Ajout d''une main pour le membre BESSALA', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1868, 'Ajout d''une main pour le membre BESSALA', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1869, 'Inscription de ERIC à la tontin : cotisation sans enchere', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1870, 'Ajout d''une main pour le membre ERIC', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1871, 'Ajout d''une main pour le membre ERIC', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1872, 'Inscription de MEBARA à la tontin : cotisation sans enchere', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1873, 'Ajout d''une main pour le membre MEBARA', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1874, 'Ajout d''une main pour le membre MEBARA', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1875, 'Ajout d''une main pour le membre MEBARA', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1876, 'Ajout d''une main pour le membre MEBARA', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1877, 'Inscription de MFOUAPON à la tontin : cotisation sans enchere', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1878, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1879, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1880, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1881, 'Inscription de NDENDE à la tontin : cotisation sans enchere', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1882, 'Ajout d''une main pour le membre NDENDE', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1883, 'Inscription de NZANGUE NEPOUDEM à la tontin : cotisation sans enchere', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1884, 'Ajout d''une main pour le membre NZANGUE NEPOUDEM', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1885, 'Inscription de OLOUGOU à la tontin : cotisation sans enchere', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1886, 'Ajout d''une main pour le membre OLOUGOU', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1887, 'Inscription de ATEBA ASOMO à la tontin : Cotisation', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1888, 'Ajout d''une main pour le membre ATEBA ASOMO', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1889, 'Inscription de BESSALA à la tontin : Cotisation', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1890, 'Ajout d''une main pour le membre BESSALA', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1891, 'Inscription de ERIC à la tontin : Cotisation', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1892, 'Ajout d''une main pour le membre ERIC', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1893, 'Inscription de MEBARA à la tontin : Cotisation', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1894, 'Ajout d''une main pour le membre MEBARA', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1895, 'Inscription de MFOUAPON à la tontin : Cotisation', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1896, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1897, 'Ajout d''une main pour le membre MFOUAPON', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1898, 'Inscription de NDENDE à la tontin : Cotisation', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1899, 'Ajout d''une main pour le membre NDENDE', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1900, 'Ajout d''une main pour le membre NDENDE', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1901, 'Inscription de NZANGUE NEPOUDEM à la tontin : Cotisation', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1902, 'Ajout d''une main pour le membre NZANGUE NEPOUDEM', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1903, 'Ajout d''une main pour le membre NZANGUE NEPOUDEM', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1904, 'Ajout d''une main pour le membre NZANGUE NEPOUDEM', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1905, 'Inscription de OLOUGOU à la tontin : Cotisation', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1906, 'Ajout d''une main pour le membre OLOUGOU', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1907, 'Ajout d''une main pour le membre OLOUGOU', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1908, 'Programmation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1909, 'Programmation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1910, 'Programmation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1911, 'Programmation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1912, 'Programmation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1913, 'Programmation de la main ATEBA ASOMO - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1914, 'Programmation de la main BESSALA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1915, 'Programmation de la main MEBARA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1916, 'Programmation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1917, 'Programmation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1918, 'Programmation de la main MEBARA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1919, 'Programmation de la main MFOUAPON - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1920, 'Déprogrammation de la main MFOUAPON - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1921, 'Programmation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1922, 'Programmation de la main ATEBA ASOMO - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1923, 'Programmation de la main BESSALA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1924, 'Programmation de la main MEBARA - 4 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1925, 'Programmation de la main ERIC - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1926, 'Programmation de la main ERIC - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1927, 'Déprogrammation de la main null effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1928, 'Programmation de la main MFOUAPON - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1929, 'Programmation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1930, 'Programmation de la main ATEBA ASOMO - 1 par les encheres effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1931, 'Programmation de la main BESSALA - 1 par les encheres effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1932, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1933, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1934, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1935, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1936, 'Enregistrement de la cotisation de la main BESSALA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1937, 'Enregistrement de la cotisation de la main BESSALA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1938, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1939, 'Enregistrement de la cotisation de la main ERIC - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1940, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1941, 'Enregistrement de la cotisation de la main MEBARA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1942, 'Enregistrement de la cotisation de la main MEBARA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1943, 'Enregistrement de la cotisation de la main MEBARA - 4 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1944, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1945, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1946, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1947, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1948, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1949, 'Enregistrement de la cotisation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1950, 'Séance terminé (Rencontre du 6 Mars 2021)', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1951, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1952, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1953, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1954, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1955, 'Enregistrement de la cotisation de la main BESSALA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1956, 'Enregistrement de la cotisation de la main BESSALA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1957, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1958, 'Enregistrement de la cotisation de la main ERIC - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1959, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1960, 'Enregistrement de la cotisation de la main MEBARA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1961, 'Enregistrement de la cotisation de la main MEBARA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1962, 'Enregistrement de la cotisation de la main MEBARA - 4 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1963, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1964, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1965, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1966, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1967, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1968, 'Enregistrement de la cotisation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1969, 'Séance terminé (Rencontre du 13 Mars 2021)', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1970, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1971, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1972, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1973, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1974, 'Enregistrement de la cotisation de la main BESSALA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1975, 'Enregistrement de la cotisation de la main BESSALA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1976, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1977, 'Enregistrement de la cotisation de la main ERIC - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1978, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1979, 'Enregistrement de la cotisation de la main MEBARA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1980, 'Enregistrement de la cotisation de la main MEBARA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1981, 'Enregistrement de la cotisation de la main MEBARA - 4 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1982, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1983, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1984, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1985, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1986, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1987, 'Enregistrement de la cotisation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1988, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1989, 'Enregistrement de la cotisation de la main BESSALA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1990, 'Enregistrement de la cotisation de la main BESSALA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1991, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1992, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1993, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1994, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1995, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1996, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1997, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1998, 'Enregistrement de la cotisation de la main NDENDE - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (1999, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2000, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2001, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2002, 'Enregistrement de la cotisation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2003, 'Enregistrement de la cotisation de la main OLOUGOU - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2004, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2005, 'Enregistrement de la cotisation de la main NDENDE - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2006, 'Séance terminé (Rencontre du 20 Mars 2021)', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2007, 'Séance terminé (Rencontre du 20 Mars 2021)', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2008, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2009, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2010, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2011, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2012, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2013, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2014, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2015, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2016, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2017, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2018, 'Enregistrement de la cotisation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2019, 'Enregistrement de la cotisation de la main OLOUGOU - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2020, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2021, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2022, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2023, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2024, 'Enregistrement de la cotisation de la main BESSALA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2025, 'Enregistrement de la cotisation de la main BESSALA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2026, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2027, 'Enregistrement de la cotisation de la main ERIC - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2028, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2029, 'Enregistrement de la cotisation de la main MEBARA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2030, 'Enregistrement de la cotisation de la main MEBARA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2031, 'Enregistrement de la cotisation de la main MEBARA - 4 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2032, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2033, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2034, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2035, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2036, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2037, 'Enregistrement de la cotisation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2038, 'Séance terminé (Rencontre du 27 Mars 2021)', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2039, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2040, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2041, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2042, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2043, 'Enregistrement de la cotisation de la main BESSALA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2044, 'Enregistrement de la cotisation de la main BESSALA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2045, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2046, 'Enregistrement de la cotisation de la main ERIC - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2047, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2048, 'Enregistrement de la cotisation de la main MEBARA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2049, 'Enregistrement de la cotisation de la main MEBARA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2050, 'Enregistrement de la cotisation de la main MEBARA - 4 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2051, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2052, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2053, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2054, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2055, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2056, 'Enregistrement de la cotisation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2057, 'Séance terminé (Rencontre du 02 Avril 2021)', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2058, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2059, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2060, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2061, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2062, 'Enregistrement de la cotisation de la main BESSALA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2063, 'Enregistrement de la cotisation de la main BESSALA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2064, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2065, 'Enregistrement de la cotisation de la main ERIC - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2066, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2067, 'Enregistrement de la cotisation de la main MEBARA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2068, 'Enregistrement de la cotisation de la main MEBARA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2069, 'Enregistrement de la cotisation de la main MEBARA - 4 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2070, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2071, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2072, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2073, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2074, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2075, 'Enregistrement de la cotisation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2076, 'Séance terminé (Rencontre du 09 Avril 2021)', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2077, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2078, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2079, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2080, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2081, 'Enregistrement de la cotisation de la main BESSALA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2082, 'Enregistrement de la cotisation de la main BESSALA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2083, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2084, 'Enregistrement de la cotisation de la main ERIC - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2085, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2086, 'Enregistrement de la cotisation de la main MEBARA - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2087, 'Enregistrement de la cotisation de la main MEBARA - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2088, 'Enregistrement de la cotisation de la main MEBARA - 4 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2089, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2090, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2091, 'Enregistrement de la cotisation de la main MFOUAPON - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2092, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2093, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2094, 'Enregistrement de la cotisation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2095, 'Séance terminé (Rencontre du 10 Avril 2021)', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2096, 'Programmation de la main ERIC - 1 par les encheres effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2097, 'Programmation de la main MFOUAPON - 1 par les encheres effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2098, 'Programmation de la main MFOUAPON - 2 par les encheres effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2099, 'Programmation de la main NDENDE - 1 par les encheres effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2100, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2101, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2102, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2103, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2104, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2105, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2106, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2107, 'Enregistrement de la cotisation de la main NDENDE - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2108, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2109, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2110, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2111, 'Enregistrement de la cotisation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2112, 'Enregistrement de la cotisation de la main OLOUGOU - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2113, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2114, 'Séance terminé (Rencontre du 27 Mars 2021)', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2115, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2116, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2117, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2118, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2119, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2120, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2121, 'Enregistrement de la cotisation de la main NDENDE - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2122, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2123, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2124, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2125, 'Enregistrement de la cotisation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2126, 'Enregistrement de la cotisation de la main OLOUGOU - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2127, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2128, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2129, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2130, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2131, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2132, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2133, 'Enregistrement de la cotisation de la main NDENDE - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2134, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2135, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2136, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2137, 'Enregistrement de la cotisation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2138, 'Enregistrement de la cotisation de la main OLOUGOU - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2139, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2140, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2141, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2142, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2143, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2144, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2145, 'Enregistrement de la cotisation de la main NDENDE - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2146, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2147, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2148, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2149, 'Enregistrement de la cotisation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2150, 'Enregistrement de la cotisation de la main OLOUGOU - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2151, 'Programmation de la main OLOUGOU - 1 par les encheres effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2152, 'Programmation de la main MEBARA - 1 par les encheres effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2153, 'Programmation de la main NDENDE - 2 par les encheres effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2154, 'Enregistrement de la cotisation de la main ATEBA ASOMO - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2155, 'Enregistrement de la cotisation de la main BESSALA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2156, 'Enregistrement de la cotisation de la main ERIC - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2157, 'Enregistrement de la cotisation de la main MFOUAPON - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2158, 'Enregistrement de la cotisation de la main MFOUAPON - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2159, 'Enregistrement de la cotisation de la main NDENDE - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2160, 'Enregistrement de la cotisation de la main NDENDE - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2161, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2162, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2163, 'Enregistrement de la cotisation de la main NZANGUE NEPOUDEM - 3 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2164, 'Enregistrement de la cotisation de la main OLOUGOU - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2165, 'Enregistrement de la cotisation de la main OLOUGOU - 2 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2166, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2167, 'Séance terminé (Rencontre du 02 Avril 2021)', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2168, 'Programmation de la main NZANGUE NEPOUDEM - 1 par les encheres effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2169, 'Programmation de la main NZANGUE NEPOUDEM - 2 par les encheres effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2170, 'Programmation de la main NZANGUE NEPOUDEM - 3 par les encheres effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2171, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2172, 'Séance terminé (Rencontre du 09 Avril 2021)', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2173, 'Programmation de la main OLOUGOU - 2 par les encheres effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2174, 'Enregistrement de la cotisation de la main MEBARA - 1 effectué', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2175, 'Séance terminé (Rencontre du 10 Avril 2021)', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2176, 'Remboursement de l''assistance par la main + BESSALA - 2', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2177, 'Remboursement de l''assistance par la main + MEBARA - 1', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2178, 'Remboursement de l''assistance par la main + NDENDE - 2', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2179, 'cotisation : cotisation sans enchere : montant : 15000.0 est terminé', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2180, 'cotisation : Cotisation : montant : 25000.0 est terminé', '2021-03-25', '2021-03-25', 3);
INSERT INTO mouchard (idoperation, action, dateaction, heure, idcompte_utilisateur) VALUES (2181, 'connexion ', '2021-06-11', '2021-06-11', 3);


--
-- TOC entry 2785 (class 0 OID 522644)
-- Dependencies: 221
-- Data for Name: naturecaisse; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO naturecaisse (idnaturecaisse, nomfr, nomen) VALUES (1, 'Depense', NULL);
INSERT INTO naturecaisse (idnaturecaisse, nomfr, nomen) VALUES (2, 'Recette', NULL);


--
-- TOC entry 2786 (class 0 OID 522650)
-- Dependencies: 222
-- Data for Name: operationcaisse; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2787 (class 0 OID 522656)
-- Dependencies: 223
-- Data for Name: pas_emprunt; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO pas_emprunt (idpas, nom, valeur) VALUES (1, 'JOURNALIER', 1);
INSERT INTO pas_emprunt (idpas, nom, valeur) VALUES (2, 'HEBDOMADAIRE', 7);
INSERT INTO pas_emprunt (idpas, nom, valeur) VALUES (4, 'ANNUEL', 365);
INSERT INTO pas_emprunt (idpas, nom, valeur) VALUES (3, 'MENSUEL', 30);


--
-- TOC entry 2788 (class 0 OID 522662)
-- Dependencies: 224
-- Data for Name: payement_sanction; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO payement_sanction (id, idpresence, idcaisse, montant, observation, idrencontre) VALUES (1, 92, 228, 2000, '-', 34);
INSERT INTO payement_sanction (id, idpresence, idcaisse, montant, observation, idrencontre) VALUES (2, 93, 229, 2000, '-', 34);


--
-- TOC entry 2789 (class 0 OID 522668)
-- Dependencies: 225
-- Data for Name: pays; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO pays (idpays, nom_fr, nom_en) VALUES (1, 'Cameroun', 'Cameroon');
INSERT INTO pays (idpays, nom_fr, nom_en) VALUES (2, 'Allemagne', 'Allemagne');
INSERT INTO pays (idpays, nom_fr, nom_en) VALUES (3, 'Italie', 'Italie');
INSERT INTO pays (idpays, nom_fr, nom_en) VALUES (4, 'USA', 'USA');
INSERT INTO pays (idpays, nom_fr, nom_en) VALUES (5, 'France', 'France');


--
-- TOC entry 2790 (class 0 OID 522674)
-- Dependencies: 226
-- Data for Name: privilege; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO privilege (idprivilege, idmenu, dateattribution, etat, idcompte_utilisateur) VALUES (1, 1, NULL, true, 3);


--
-- TOC entry 2791 (class 0 OID 522677)
-- Dependencies: 227
-- Data for Name: ration; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2792 (class 0 OID 522683)
-- Dependencies: 228
-- Data for Name: recette; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO recette (idrecette, date, observation, idrencontre, idrubrique, montant, idcycle, idcaisse) VALUES (1, '2018-01-07', 'Reste des intérets à redistribuer', 15, 18, 50000, 2, 71);


--
-- TOC entry 2793 (class 0 OID 522689)
-- Dependencies: 229
-- Data for Name: redevance_cotisation; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2794 (class 0 OID 522692)
-- Dependencies: 230
-- Data for Name: remboursement; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO remboursement (idremboursement, daterembour, interet, montanttotal, idemprunt, idrencontre, montant_rembourse, observation, idtyperemboursement, idcaisse, reste_capital_avant, cumul_interet_avant) VALUES (1, '2018-03-07', 0, 5000, 1, 17, 5000, '-', 2, 46, 50000, 0);
INSERT INTO remboursement (idremboursement, daterembour, interet, montanttotal, idemprunt, idrencontre, montant_rembourse, observation, idtyperemboursement, idcaisse, reste_capital_avant, cumul_interet_avant) VALUES (2, '2018-03-07', 0, 30000, 2, 17, 30000, '-', 2, 47, 300000, 0);
INSERT INTO remboursement (idremboursement, daterembour, interet, montanttotal, idemprunt, idrencontre, montant_rembourse, observation, idtyperemboursement, idcaisse, reste_capital_avant, cumul_interet_avant) VALUES (3, '2018-06-07', 0, 30000, 2, 20, 30000, '-', 2, 117, 300000, 0);
INSERT INTO remboursement (idremboursement, daterembour, interet, montanttotal, idemprunt, idrencontre, montant_rembourse, observation, idtyperemboursement, idcaisse, reste_capital_avant, cumul_interet_avant) VALUES (4, '2018-07-07', 0, 10000, 4, 21, 10000, '-', 2, 130, 100000, 0);
INSERT INTO remboursement (idremboursement, daterembour, interet, montanttotal, idemprunt, idrencontre, montant_rembourse, observation, idtyperemboursement, idcaisse, reste_capital_avant, cumul_interet_avant) VALUES (5, '2018-08-07', 0, 10000, 4, 29, 10000, '-', 2, 140, 100000, 0);
INSERT INTO remboursement (idremboursement, daterembour, interet, montanttotal, idemprunt, idrencontre, montant_rembourse, observation, idtyperemboursement, idcaisse, reste_capital_avant, cumul_interet_avant) VALUES (6, '2018-09-07', 0, 10000, 4, 30, 10000, '-', 2, 153, 100000, 0);
INSERT INTO remboursement (idremboursement, daterembour, interet, montanttotal, idemprunt, idrencontre, montant_rembourse, observation, idtyperemboursement, idcaisse, reste_capital_avant, cumul_interet_avant) VALUES (7, '2018-10-07', 0, 5000, 4, 31, 5000, '-', 2, 167, 100000, 0);
INSERT INTO remboursement (idremboursement, daterembour, interet, montanttotal, idemprunt, idrencontre, montant_rembourse, observation, idtyperemboursement, idcaisse, reste_capital_avant, cumul_interet_avant) VALUES (8, '2018-10-07', 0, 50000, 2, 31, 50000, '-', 2, 168, 300000, 60000);
INSERT INTO remboursement (idremboursement, daterembour, interet, montanttotal, idemprunt, idrencontre, montant_rembourse, observation, idtyperemboursement, idcaisse, reste_capital_avant, cumul_interet_avant) VALUES (9, '2018-11-07', 0, 10000, 4, 32, 10000, '-', 2, 181, 100000, 5000);


--
-- TOC entry 2795 (class 0 OID 522699)
-- Dependencies: 231
-- Data for Name: rencontre; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (14, 'Rencontre du 07 Decembre 2017', '2017-12-07', 'Rencontre du 07 Decembre 2017', 1, false, '17:00:00', '19:30:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (20, '06-Rencontre du 07 Juin 2018', '2018-06-07', '06-Rencontre du 07 Juin 2018', 2, true, '17:00:00', '19:00:00', true, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (31, '*10-Rencontre du 07 Octobre 2018', '2018-10-07', '*10-Rencontre du 07 Octobre 2018', 2, true, '17:00:00', '19:00:00', true, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (32, '-11-Rencontre du 07 Novembre 2018', '2018-11-07', '-11-Rencontre du 07 Novembre 2018', 2, true, '17:00:00', '19:00:00', true, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (15, '01-Rencontre du 07 Janvier 2018', '2018-01-07', '01-Rencontre du 07 Janvier 2018', 2, true, '17:00:00', '19:00:00', true, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (22, 'Rencontre du 07 juin 2016', '2016-06-07', 'Rencontre du 07 juin 2016', 3, true, '17:00:00', '19:00:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (23, 'Rencontre du 07 juillet 2016', '2016-07-07', 'Rencontre du 07 juillet 2016', 3, true, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (33, '-12-Rencontre du 07 Decembre 2018', '2018-12-07', '-12-Rencontre du 07 Decembre 2018', 2, true, '17:00:00', '19:00:00', true, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (27, 'Rencontre du 07 Novembre 2016', '2016-11-07', 'Rencontre du 07 Novembre 2016', 3, false, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (28, 'Rencontre du 07 Decembre 2016', '2016-12-07', 'Rencontre du 07 Decembre 2016', 3, false, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (2, 'rencontre du 7 fevrier', '2017-02-07', 'rencontre du 7 fevrier', 1, false, '17:30:00', '19:30:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (26, 'Rencontre du 07 Octobre 2016', '2016-10-07', 'Rencontre du 07 Octobre 2016', 3, false, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (3, 'rencontre du 7 Mars', '2017-03-07', 'rencontre du 7 Mars', 1, false, '17:00:00', '20:00:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (6, 'Rencontre du 07 Avril', '2017-04-07', 'Meeting April 07', 1, false, '17:00:00', '18:00:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (7, 'Rencontre du 07 Mai 2017', '2017-05-07', 'Rencontre du 07 Mai 2017', 1, false, '17:00:00', '19:30:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (8, 'Rencontre du 07 Juin 2017', '2017-06-07', 'Rencontre du 07 Juin 2017', 1, false, '17:00:00', '19:33:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (9, 'Rencontre du 07 Juillet 2017', '2017-07-07', 'Rencontre du 07 Juillet 2017', 1, false, '17:00:00', '19:30:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (10, 'Rencontre du 07 Aout 2017', '2017-08-07', 'Rencontre du 07 Aout 2017', 1, false, '17:00:00', '19:30:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (11, 'Rencontre du 07 Septembre 2017', '2017-09-07', 'Rencontre du 07 Septembre 2017', 1, false, '17:00:00', '19:30:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (12, 'Rencontre du 07 Octobre 2017', '2017-10-07', 'Rencontre du 07 Octobre 2017', 1, false, '17:00:00', '19:30:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (24, 'Rencontre du 07 Août 2016', '2016-08-07', 'Rencontre du 07 Août 2016', 3, false, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (13, 'Rencontre du 07 Novembre 2017', '2017-11-07', 'Rencontre du 07 Novembre 2017', 1, false, '17:00:00', '19:20:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (25, 'Rencontre du 07 Septembre 2016', '2016-09-07', 'Rencontre du 07 Septembre 2016', 3, false, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (1, 'rencontre du 7 Janvier', '2017-01-07', 'rencontre du 7 Janvier', 1, true, '17:00:00', '15:30:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (16, '02-Rencontre du 07 Fevrier 2018', '2018-02-07', '02-Rencontre du 07 Fevrier 2018', 2, true, '17:00:00', '19:00:00', true, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (17, '03-Rencontre du 07 Mars 2018', '2018-03-07', '03-Rencontre du 07 Mars 2018', 2, true, '17:00:00', '19:00:00', true, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (18, '04-Rencontre du 07 Avril 2018', '2018-04-07', '04-Rencontre du 07 Avril 2018', 2, true, '17:00:00', '19:00:00', true, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (19, '05-Rencontre du 07 Mai 2018', '2018-05-07', '05-Rencontre du 07 Mai 2018', 2, true, '17:00:00', '19:00:00', true, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (21, '07-Rencontre de Juillet 2018', '2018-07-07', '07-Rencontre de Juillet 2018', 2, true, '17:00:00', '19:00:00', true, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (29, '08-Rencontre du 07 Août 2018', '2018-08-07', '08-Rencontre du 07 Août 2018', 2, true, '17:00:00', '19:00:00', true, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (30, '09-Rencontre du 07 septembre 2018', '2018-09-07', '09-Rencontre du 07 septembre 2018', 2, true, '17:00:00', '19:00:00', true, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (35, 'Rencontre du 12 Octobre 2019', '2019-10-12', 'Meeting of October 12, 2019', 4, false, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (34, 'Rencontre du 14 Septembre 2019', '2019-09-14', 'Meeting of  September, 14 2019', 4, true, '16:00:00', '19:00:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (36, 'Rencontre du 1er janvier 2020', '2020-01-01', 'Rencontre du 1er janvier 2020', 5, false, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (37, 'Rencontre du 1 er décembre', '2020-12-01', 'Meeting of 1st december', 5, true, '08:00:00', '08:00:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (39, 'Rencontre du - dimanche 3 janvier 2021', '2021-01-03', 'Meeting of  - Sunday, January 3, 2021', 5, NULL, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (40, 'Rencontre du - dimanche 28 février 2021', '2021-02-28', 'Meeting of  - Sunday, February 28, 2021', 5, NULL, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (41, 'Rencontre du - dimanche 28 mars 2021', '2021-03-28', 'Meeting of  - Sunday, March 28, 2021', 5, NULL, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (42, 'Rencontre du - dimanche 25 avril 2021', '2021-04-25', 'Meeting of  - Sunday, April 25, 2021', 5, NULL, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (43, 'Rencontre du - dimanche 23 mai 2021', '2021-05-23', 'Meeting of  - Sunday, May 23, 2021', 5, NULL, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (44, 'Rencontre du - dimanche 20 juin 2021', '2021-06-20', 'Meeting of  - Sunday, June 20, 2021', 5, NULL, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (45, 'Rencontre du - dimanche 18 juillet 2021', '2021-07-18', 'Meeting of  - Sunday, July 18, 2021', 5, NULL, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (46, 'Rencontre du - dimanche 15 août 2021', '2021-08-15', 'Meeting of  - Sunday, August 15, 2021', 5, NULL, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (47, 'Rencontre du - dimanche 12 septembre 2021', '2021-09-12', 'Meeting of  - Sunday, September 12, 2021', 5, NULL, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (48, 'Rencontre du - dimanche 10 octobre 2021', '2021-10-10', 'Meeting of  - Sunday, October 10, 2021', 5, NULL, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (49, 'Rencontre du - dimanche 7 novembre 2021', '2021-11-07', 'Meeting of  - Sunday, November 7, 2021', 5, NULL, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (50, 'Rencontre du - dimanche 8 décembre', '2021-01-08', '', 5, false, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (51, 'Rencontre du - dimanche 5 décembre 2021', '2021-12-05', 'Meeting of - Sunday, December 5, 2021', 5, false, NULL, NULL, false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (56, 'Rencontre du 02 Avril 2021', '2021-04-02', '', NULL, false, NULL, NULL, false, true, 4);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (57, 'Rencontre du 09 Avril 2021', '2021-04-09', '', NULL, false, NULL, NULL, false, true, 4);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (58, 'Rencontre du 10 Avril 2021', '2021-04-10', '', NULL, false, NULL, NULL, false, true, 4);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (38, 'Rencontre du 31 janvier 2021', '2021-01-31', 'Rencontre du 31 janvier 2021', 5, true, NULL, '18:31:00', false, false, NULL);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (52, 'Rencontre du 6 Mars 2021', '2021-03-06', '', NULL, false, NULL, NULL, false, true, 4);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (53, 'Rencontre du 13 Mars 2021', '2021-03-13', '', NULL, false, NULL, NULL, false, true, 4);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (54, 'Rencontre du 20 Mars 2021', '2021-03-20', '', NULL, false, NULL, NULL, false, true, 4);
INSERT INTO rencontre (idrencontre, nomfr, daterencontre, nomen, idcycle, ouverture_rencontre, heuredebut, heurefin, fermetture, is_rencontre_cotisation, id_tontine) VALUES (55, 'Rencontre du 27 Mars 2021', '2021-03-27', '', NULL, false, NULL, NULL, false, true, 4);


--
-- TOC entry 2796 (class 0 OID 522708)
-- Dependencies: 232
-- Data for Name: retard; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2797 (class 0 OID 522714)
-- Dependencies: 233
-- Data for Name: rubriquecaisse; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (14, 'Décaissement spécial', 'Décaissement spécial', 'D-04', false, true, 1, false);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (7, 'Emprunt', 'Emprunt', 'D-02', false, true, 1, false);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (10, 'Frais de Collation', 'Frais de Collation', 'D-01', false, true, 1, false);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (12, 'Assistance à un membre sur secours', 'Assistance à un membre sur secours', 'D-03', false, true, 1, false);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (13, 'Assistance à un membre sur main levée', 'Assistance à un membre sur main levée', 'D-05', false, true, 1, false);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (15, 'Frais de transport pour assistance à un membre', 'Frais de transport pour assistance à un membre', 'D-06', false, true, 1, false);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (2, 'Epargne', 'Epargne', 'R-02', false, true, 2, false);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (3, 'Collation', 'Collation', 'R-03', true, true, 2, true);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (5, 'Amende', 'Amende', 'R-06', false, true, 2, false);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (9, 'Frais d''inscription', 'Frais d''inscription', 'R-07', true, true, 2, true);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (4, 'Retard', 'Retard', 'R-08', false, true, 2, false);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (11, 'Main Levée', 'Main Levée', 'R-09', false, true, 2, true);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (6, 'Cotisation', 'Cotisation', 'R-10', false, true, 2, false);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (1, 'Secours', 'Secours', 'R-01', false, true, 2, false);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (8, 'Remboursement Emprunt', 'Remboursement Emprunt', 'R-05', false, true, 2, false);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (16, 'Frais d''annonce', 'Frais d''annonce', 'R--', true, true, 2, true);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (17, 'Frais de Timbre', 'Frais de Timbre', 'R--', true, true, 2, true);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (18, 'Autres Recettes', 'Autres Recettes', 'R--', true, true, 2, true);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (20, 'Réliquat', NULL, 'R-20', false, false, 2, false);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (22, 'Cotisation', NULL, 'R-22', false, true, 2, true);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (23, 'Décaissement de la bouffe', NULL, 'D-23', false, true, 1, true);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (19, 'Pénalité de non cotisation', NULL, 'R-19', false, true, 2, true);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (21, 'Assistance cotisation', NULL, 'D-21', false, true, 1, true);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (24, 'Remboursement assistance', NULL, 'R-24', false, true, 2, true);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (25, 'Décaissement assistances ', NULL, 'D-25', false, true, 1, true);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (26, 'Paiement enchere', NULL, 'R-26', false, true, 2, true);
INSERT INTO rubriquecaisse (idrubriquecaisse, nomfr, nomen, code, modifiable, afficher, idnaturecaisse, editable_en_caisse) VALUES (27, 'cassation tontine', NULL, 'D-27', false, true, 1, true);


--
-- TOC entry 2798 (class 0 OID 522723)
-- Dependencies: 234
-- Data for Name: sanction; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2799 (class 0 OID 522729)
-- Dependencies: 235
-- Data for Name: secours; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2800 (class 0 OID 522735)
-- Dependencies: 236
-- Data for Name: statutmembre; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2801 (class 0 OID 522741)
-- Dependencies: 237
-- Data for Name: tontine; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tontine (idtontine, idfreqtontine, idtsanction, idtranchecotisation, idmdepaiement, idrubriquecaisse, iddevices, nom, slogan, numerodetransfert) VALUES (4, 1, NULL, NULL, 1, NULL, 1, 'SEPT', 'Solidarité-entreAide pour tous', '695627635');
INSERT INTO tontine (idtontine, idfreqtontine, idtsanction, idtranchecotisation, idmdepaiement, idrubriquecaisse, iddevices, nom, slogan, numerodetransfert) VALUES (5, 1, NULL, NULL, 2, NULL, 1, 'Nos Années Lycée (NAL)', 'Amitié - Solidarité - Progres', '694767218');


--
-- TOC entry 2802 (class 0 OID 522747)
-- Dependencies: 238
-- Data for Name: tontiner; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tontiner (idtontiner, idrencontre, montantcotise, montantbeneficie, redevance, montantechec, idcotisation, effectue) VALUES (4, 52, 270000, 105000, 60000, 0, 1, true);
INSERT INTO tontiner (idtontiner, idrencontre, montantcotise, montantbeneficie, redevance, montantechec, idcotisation, effectue) VALUES (5, 53, 270000, 105000, 15000, 0, 1, true);
INSERT INTO tontiner (idtontiner, idrencontre, montantcotise, montantbeneficie, redevance, montantechec, idcotisation, effectue) VALUES (11, 54, 323000, 125000, 116500, 2000, 2, true);
INSERT INTO tontiner (idtontiner, idrencontre, montantcotise, montantbeneficie, redevance, montantechec, idcotisation, effectue) VALUES (6, 54, 265000, 105000, 75000, 5000, 1, true);
INSERT INTO tontiner (idtontiner, idrencontre, montantcotise, montantbeneficie, redevance, montantechec, idcotisation, effectue) VALUES (7, 55, 270000, 105000, 30000, 0, 1, true);
INSERT INTO tontiner (idtontiner, idrencontre, montantcotise, montantbeneficie, redevance, montantechec, idcotisation, effectue) VALUES (1, 56, 270000, 105000, 90000, 0, 1, true);
INSERT INTO tontiner (idtontiner, idrencontre, montantcotise, montantbeneficie, redevance, montantechec, idcotisation, effectue) VALUES (2, 57, 270000, 105000, 45000, 0, 1, true);
INSERT INTO tontiner (idtontiner, idrencontre, montantcotise, montantbeneficie, redevance, montantechec, idcotisation, effectue) VALUES (3, 58, 270000, 105000, 0, 0, 1, true);
INSERT INTO tontiner (idtontiner, idrencontre, montantcotise, montantbeneficie, redevance, montantechec, idcotisation, effectue) VALUES (12, 55, 315000, 125000, 24000, 10000, 2, true);
INSERT INTO tontiner (idtontiner, idrencontre, montantcotise, montantbeneficie, redevance, montantechec, idcotisation, effectue) VALUES (8, 56, 325000, 125000, 20500, 0, 2, true);
INSERT INTO tontiner (idtontiner, idrencontre, montantcotise, montantbeneficie, redevance, montantechec, idcotisation, effectue) VALUES (9, 57, 325000, 125000, 17000, 0, 2, true);
INSERT INTO tontiner (idtontiner, idrencontre, montantcotise, montantbeneficie, redevance, montantechec, idcotisation, effectue) VALUES (10, 58, 325000, 125000, 232000, 0, 2, true);


--
-- TOC entry 2803 (class 0 OID 522751)
-- Dependencies: 239
-- Data for Name: tranchecotisation; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tranchecotisation (idtranche, montant) VALUES (1, '50000');


--
-- TOC entry 2804 (class 0 OID 522754)
-- Dependencies: 240
-- Data for Name: trancheemprunt; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO trancheemprunt (idtranche, nom_fr, tauxinteret, nom_en) VALUES (1, '500-10000', 5, '500-10000');
INSERT INTO trancheemprunt (idtranche, nom_fr, tauxinteret, nom_en) VALUES (2, '10001-100000', 15, '10001-100000');


--
-- TOC entry 2805 (class 0 OID 522760)
-- Dependencies: 241
-- Data for Name: type_remboursement; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO type_remboursement (id, nom) VALUES (1, 'Capital');
INSERT INTO type_remboursement (id, nom) VALUES (2, 'Interet');


--
-- TOC entry 2806 (class 0 OID 522766)
-- Dependencies: 242
-- Data for Name: typeinteret; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO typeinteret (idtypeinteret, nom_fr, nom_en) VALUES (2, 'Interét Simple', 'Intérét Simple');
INSERT INTO typeinteret (idtypeinteret, nom_fr, nom_en) VALUES (1, 'Intéret Composé', 'Intéret Composé');


--
-- TOC entry 2807 (class 0 OID 522772)
-- Dependencies: 243
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO utilisateur (idutilisateur, nom, prenom, sexe, idgroupeutilisateur) VALUES (17, 'Henock', '-', 'Masculin', 1);


--
-- TOC entry 2808 (class 0 OID 522778)
-- Dependencies: 244
-- Data for Name: utilisateurtontine; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO utilisateurtontine (idutilisateurtontine, idutilisateur, idtontine) VALUES (1, 17, 4);


--
-- TOC entry 2468 (class 2606 OID 522785)
-- Name: fk_redevance_tontine; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY redevance_cotisation
    ADD CONSTRAINT fk_redevance_tontine PRIMARY KEY (id_redevance_cotisation);


--
-- TOC entry 2318 (class 2606 OID 522787)
-- Name: pk_aide; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aide
    ADD CONSTRAINT pk_aide PRIMARY KEY (idaide);


--
-- TOC entry 2321 (class 2606 OID 522789)
-- Name: pk_aide_membre; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aide_membre
    ADD CONSTRAINT pk_aide_membre PRIMARY KEY (id);


--
-- TOC entry 2326 (class 2606 OID 522791)
-- Name: pk_aidecotisation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aidecotisation
    ADD CONSTRAINT pk_aidecotisation PRIMARY KEY (idaidecotisation);


--
-- TOC entry 2328 (class 2606 OID 522793)
-- Name: pk_amende; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY amende
    ADD CONSTRAINT pk_amende PRIMARY KEY (idamende);


--
-- TOC entry 2331 (class 2606 OID 522795)
-- Name: pk_avalyse; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY avalyse
    ADD CONSTRAINT pk_avalyse PRIMARY KEY (idavalyse);


--
-- TOC entry 2334 (class 2606 OID 522797)
-- Name: pk_beneficiaire_cotisation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY beneficiaire_tontine
    ADD CONSTRAINT pk_beneficiaire_cotisation PRIMARY KEY (idbeneficiaire);


--
-- TOC entry 2340 (class 2606 OID 522799)
-- Name: pk_beneficiairecotisation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY beneficiairecotisation
    ADD CONSTRAINT pk_beneficiairecotisation PRIMARY KEY (idbeneficiare);


--
-- TOC entry 2345 (class 2606 OID 522801)
-- Name: pk_caisse; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY caisse
    ADD CONSTRAINT pk_caisse PRIMARY KEY (idcaisse);


--
-- TOC entry 2347 (class 2606 OID 522803)
-- Name: pk_calcul_interet; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY calcul_interet
    ADD CONSTRAINT pk_calcul_interet PRIMARY KEY (id);


--
-- TOC entry 2349 (class 2606 OID 522805)
-- Name: pk_cassation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cassation
    ADD CONSTRAINT pk_cassation PRIMARY KEY (id);


--
-- TOC entry 2351 (class 2606 OID 522807)
-- Name: pk_cassation_detaillee; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cassation_detail
    ADD CONSTRAINT pk_cassation_detaillee PRIMARY KEY (id);


--
-- TOC entry 2356 (class 2606 OID 522809)
-- Name: pk_cassationtontine; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cassationtontine
    ADD CONSTRAINT pk_cassationtontine PRIMARY KEY (idcassation);


--
-- TOC entry 2361 (class 2606 OID 522811)
-- Name: pk_collecte_main_levee; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY collecte_main_levee
    ADD CONSTRAINT pk_collecte_main_levee PRIMARY KEY (id);


--
-- TOC entry 2363 (class 2606 OID 522813)
-- Name: pk_collecte_secours; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY collecte_secours
    ADD CONSTRAINT pk_collecte_secours PRIMARY KEY (id);


--
-- TOC entry 2367 (class 2606 OID 522815)
-- Name: pk_compteutilisateur; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compteutilisateur
    ADD CONSTRAINT pk_compteutilisateur PRIMARY KEY (idcompte);


--
-- TOC entry 2369 (class 2606 OID 522817)
-- Name: pk_cotisation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cotisation
    ADD CONSTRAINT pk_cotisation PRIMARY KEY (idcotisation);


--
-- TOC entry 2376 (class 2606 OID 522819)
-- Name: pk_cycletontine; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cycletontine
    ADD CONSTRAINT pk_cycletontine PRIMARY KEY (idcycle);


--
-- TOC entry 2378 (class 2606 OID 522821)
-- Name: pk_depense; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY depense
    ADD CONSTRAINT pk_depense PRIMARY KEY (iddepense);


--
-- TOC entry 2381 (class 2606 OID 522823)
-- Name: pk_devices; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY devise
    ADD CONSTRAINT pk_devices PRIMARY KEY (iddevices);


--
-- TOC entry 2388 (class 2606 OID 522825)
-- Name: pk_emprunt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY emprunt
    ADD CONSTRAINT pk_emprunt PRIMARY KEY (idemprunt);


--
-- TOC entry 2393 (class 2606 OID 522827)
-- Name: pk_encherebenficiare; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY encherebenficiare
    ADD CONSTRAINT pk_encherebenficiare PRIMARY KEY (idenchere);


--
-- TOC entry 2398 (class 2606 OID 522829)
-- Name: pk_encours_aide; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY encours_secours
    ADD CONSTRAINT pk_encours_aide PRIMARY KEY (id_encours_secours);


--
-- TOC entry 2396 (class 2606 OID 522831)
-- Name: pk_encours_emprunt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY encours_emprunt
    ADD CONSTRAINT pk_encours_emprunt PRIMARY KEY (id_encours_emprunt);


--
-- TOC entry 2401 (class 2606 OID 522833)
-- Name: pk_epargne; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY epargne
    ADD CONSTRAINT pk_epargne PRIMARY KEY (idepargne);


--
-- TOC entry 2403 (class 2606 OID 522835)
-- Name: pk_ficherencontre; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fiche_presence
    ADD CONSTRAINT pk_ficherencontre PRIMARY KEY (id);


--
-- TOC entry 2372 (class 2606 OID 522837)
-- Name: pk_frais_cotisation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cotisation_tontine
    ADD CONSTRAINT pk_frais_cotisation PRIMARY KEY (idcotisationtontine);


--
-- TOC entry 2406 (class 2606 OID 522839)
-- Name: pk_frequencecotisation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY frequencecotisation
    ADD CONSTRAINT pk_frequencecotisation PRIMARY KEY (idfrequence);


--
-- TOC entry 2409 (class 2606 OID 522841)
-- Name: pk_frequencetontine; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY frequencetontine
    ADD CONSTRAINT pk_frequencetontine PRIMARY KEY (idfreqtontine);


--
-- TOC entry 2411 (class 2606 OID 522843)
-- Name: pk_groupecaisse; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groupecaisse
    ADD CONSTRAINT pk_groupecaisse PRIMARY KEY (idgroupecaisse);


--
-- TOC entry 2414 (class 2606 OID 522845)
-- Name: pk_groupeutilisateur; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groupeutilisateur
    ADD CONSTRAINT pk_groupeutilisateur PRIMARY KEY (idgroupe);


--
-- TOC entry 2417 (class 2606 OID 522847)
-- Name: pk_inscription_cotisation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inscription_cotisation
    ADD CONSTRAINT pk_inscription_cotisation PRIMARY KEY (idinscription);


--
-- TOC entry 2421 (class 2606 OID 522849)
-- Name: pk_mains; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mains
    ADD CONSTRAINT pk_mains PRIMARY KEY (idmain);


--
-- TOC entry 2424 (class 2606 OID 522851)
-- Name: pk_membre; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY membre
    ADD CONSTRAINT pk_membre PRIMARY KEY (idmembre);


--
-- TOC entry 2427 (class 2606 OID 522853)
-- Name: pk_membrecycle; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY membrecycle
    ADD CONSTRAINT pk_membrecycle PRIMARY KEY (idmembrecycle);


--
-- TOC entry 2429 (class 2606 OID 522855)
-- Name: pk_membretontine; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY membretontine
    ADD CONSTRAINT pk_membretontine PRIMARY KEY (idmembretontine);


--
-- TOC entry 2432 (class 2606 OID 522857)
-- Name: pk_menu; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT pk_menu PRIMARY KEY (idmenu);


--
-- TOC entry 2435 (class 2606 OID 522859)
-- Name: pk_modepaiement; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY modepaiement
    ADD CONSTRAINT pk_modepaiement PRIMARY KEY (idmdepaiement);


--
-- TOC entry 2438 (class 2606 OID 522861)
-- Name: pk_mois; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mois
    ADD CONSTRAINT pk_mois PRIMARY KEY (idmois);


--
-- TOC entry 2440 (class 2606 OID 522863)
-- Name: pk_motifaide; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY motifaide
    ADD CONSTRAINT pk_motifaide PRIMARY KEY (idmotifaide);


--
-- TOC entry 2443 (class 2606 OID 522865)
-- Name: pk_mouchard; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mouchard
    ADD CONSTRAINT pk_mouchard PRIMARY KEY (idoperation);


--
-- TOC entry 2445 (class 2606 OID 522867)
-- Name: pk_naturecaisse; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY naturecaisse
    ADD CONSTRAINT pk_naturecaisse PRIMARY KEY (idnaturecaisse);


--
-- TOC entry 2450 (class 2606 OID 522869)
-- Name: pk_operationcaisse; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY operationcaisse
    ADD CONSTRAINT pk_operationcaisse PRIMARY KEY (idoperationcaisse);


--
-- TOC entry 2452 (class 2606 OID 522871)
-- Name: pk_pas_emprunt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pas_emprunt
    ADD CONSTRAINT pk_pas_emprunt PRIMARY KEY (idpas);


--
-- TOC entry 2456 (class 2606 OID 522873)
-- Name: pk_payement _sanction; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payement_sanction
    ADD CONSTRAINT "pk_payement _sanction" PRIMARY KEY (id);


--
-- TOC entry 2458 (class 2606 OID 522875)
-- Name: pk_pays; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pays
    ADD CONSTRAINT pk_pays PRIMARY KEY (idpays);


--
-- TOC entry 2461 (class 2606 OID 522877)
-- Name: pk_privilege; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY privilege
    ADD CONSTRAINT pk_privilege PRIMARY KEY (idprivilege);


--
-- TOC entry 2464 (class 2606 OID 522879)
-- Name: pk_ration; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ration
    ADD CONSTRAINT pk_ration PRIMARY KEY (idration);


--
-- TOC entry 2466 (class 2606 OID 522881)
-- Name: pk_recette; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY recette
    ADD CONSTRAINT pk_recette PRIMARY KEY (idrecette);


--
-- TOC entry 2474 (class 2606 OID 522883)
-- Name: pk_remboursement; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY remboursement
    ADD CONSTRAINT pk_remboursement PRIMARY KEY (idremboursement);


--
-- TOC entry 2477 (class 2606 OID 522885)
-- Name: pk_rencontre; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rencontre
    ADD CONSTRAINT pk_rencontre PRIMARY KEY (idrencontre);


--
-- TOC entry 2479 (class 2606 OID 522887)
-- Name: pk_retard; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY retard
    ADD CONSTRAINT pk_retard PRIMARY KEY (idretard);


--
-- TOC entry 2482 (class 2606 OID 522889)
-- Name: pk_rubriquecaisse; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rubriquecaisse
    ADD CONSTRAINT pk_rubriquecaisse PRIMARY KEY (idrubriquecaisse);


--
-- TOC entry 2485 (class 2606 OID 522891)
-- Name: pk_sanction; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sanction
    ADD CONSTRAINT pk_sanction PRIMARY KEY (idtsanction);


--
-- TOC entry 2488 (class 2606 OID 522893)
-- Name: pk_secours; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY secours
    ADD CONSTRAINT pk_secours PRIMARY KEY (idsecours);


--
-- TOC entry 2490 (class 2606 OID 522895)
-- Name: pk_statut; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY statutmembre
    ADD CONSTRAINT pk_statut PRIMARY KEY (idstatut);


--
-- TOC entry 2498 (class 2606 OID 522897)
-- Name: pk_tontine; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tontine
    ADD CONSTRAINT pk_tontine PRIMARY KEY (idtontine);


--
-- TOC entry 2504 (class 2606 OID 522899)
-- Name: pk_tranchecotisation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tranchecotisation
    ADD CONSTRAINT pk_tranchecotisation PRIMARY KEY (idtranche);


--
-- TOC entry 2506 (class 2606 OID 522901)
-- Name: pk_trancheemprunt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY trancheemprunt
    ADD CONSTRAINT pk_trancheemprunt PRIMARY KEY (idtranche);


--
-- TOC entry 2511 (class 2606 OID 522903)
-- Name: pk_typeinteret; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY typeinteret
    ADD CONSTRAINT pk_typeinteret PRIMARY KEY (idtypeinteret);


--
-- TOC entry 2509 (class 2606 OID 522905)
-- Name: pk_typeremboursement; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY type_remboursement
    ADD CONSTRAINT pk_typeremboursement PRIMARY KEY (id);


--
-- TOC entry 2514 (class 2606 OID 522907)
-- Name: pk_utilisateur; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY utilisateur
    ADD CONSTRAINT pk_utilisateur PRIMARY KEY (idutilisateur);


--
-- TOC entry 2516 (class 2606 OID 522909)
-- Name: pk_utilisateurtontine; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY utilisateurtontine
    ADD CONSTRAINT pk_utilisateurtontine PRIMARY KEY (idutilisateurtontine);


--
-- TOC entry 2501 (class 2606 OID 522911)
-- Name: tontiner_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tontiner
    ADD CONSTRAINT tontiner_pkey PRIMARY KEY (idtontiner);


--
-- TOC entry 2315 (class 1259 OID 522912)
-- Name: aide_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX aide_pk ON aide USING btree (idaide);


--
-- TOC entry 2322 (class 1259 OID 522913)
-- Name: aidecotisation_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX aidecotisation_pk ON aidecotisation USING btree (idaidecotisation);


--
-- TOC entry 2418 (class 1259 OID 522914)
-- Name: association113_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association113_fk ON mains USING btree (idinscription);


--
-- TOC entry 2491 (class 1259 OID 522915)
-- Name: association13_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association13_fk ON tontine USING btree (idtranchecotisation);


--
-- TOC entry 2492 (class 1259 OID 522916)
-- Name: association14_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association14_fk ON tontine USING btree (idrubriquecaisse);


--
-- TOC entry 2323 (class 1259 OID 522917)
-- Name: association16_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association16_fk ON aidecotisation USING btree (idmembrecycle);


--
-- TOC entry 2324 (class 1259 OID 522918)
-- Name: association170_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association170_fk ON aidecotisation USING btree (idcotisationtontine);


--
-- TOC entry 2341 (class 1259 OID 522919)
-- Name: association17_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association17_fk ON caisse USING btree (idrubriquecaisse);


--
-- TOC entry 2382 (class 1259 OID 522920)
-- Name: association19_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association19_fk ON emprunt USING btree (idmembre);


--
-- TOC entry 2352 (class 1259 OID 522921)
-- Name: association20_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association20_fk ON cassationtontine USING btree (idmain);


--
-- TOC entry 2353 (class 1259 OID 522922)
-- Name: association21_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association21_fk ON cassationtontine USING btree (idcaisse);


--
-- TOC entry 2342 (class 1259 OID 522923)
-- Name: association28_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association28_fk ON caisse USING btree (idcycle);


--
-- TOC entry 2459 (class 1259 OID 522924)
-- Name: association30_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association30_fk ON privilege USING btree (idmenu);


--
-- TOC entry 2316 (class 1259 OID 522925)
-- Name: association31_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association31_fk ON aide USING btree (idcycle);


--
-- TOC entry 2335 (class 1259 OID 522926)
-- Name: association34_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association34_fk ON beneficiairecotisation USING btree (idcycle);


--
-- TOC entry 2336 (class 1259 OID 522927)
-- Name: association35_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association35_fk ON beneficiairecotisation USING btree (idmois);


--
-- TOC entry 2337 (class 1259 OID 522928)
-- Name: association36_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association36_fk ON beneficiairecotisation USING btree (idmembre);


--
-- TOC entry 2383 (class 1259 OID 522929)
-- Name: association39_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association39_fk ON emprunt USING btree (idtypeinteret);


--
-- TOC entry 2446 (class 1259 OID 522930)
-- Name: association40_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association40_fk ON operationcaisse USING btree (idcycle);


--
-- TOC entry 2447 (class 1259 OID 522931)
-- Name: association41_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association41_fk ON operationcaisse USING btree (idmois);


--
-- TOC entry 2364 (class 1259 OID 522932)
-- Name: association5_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association5_fk ON compteutilisateur USING btree (idmembre);


--
-- TOC entry 2389 (class 1259 OID 522933)
-- Name: association63_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association63_fk ON encherebenficiare USING btree (idbeneficiaire);


--
-- TOC entry 2390 (class 1259 OID 522934)
-- Name: association64_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association64_fk ON encherebenficiare USING btree (idcaisse);


--
-- TOC entry 2493 (class 1259 OID 522935)
-- Name: association6_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association6_fk ON tontine USING btree (idfreqtontine);


--
-- TOC entry 2494 (class 1259 OID 522936)
-- Name: association7_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association7_fk ON tontine USING btree (idtsanction);


--
-- TOC entry 2495 (class 1259 OID 522937)
-- Name: association8_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association8_fk ON tontine USING btree (idmdepaiement);


--
-- TOC entry 2496 (class 1259 OID 522938)
-- Name: association9_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association9_fk ON tontine USING btree (iddevices);


--
-- TOC entry 2338 (class 1259 OID 522939)
-- Name: beneficiairecotisation_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX beneficiairecotisation_pk ON beneficiairecotisation USING btree (idbeneficiare);


--
-- TOC entry 2343 (class 1259 OID 522940)
-- Name: caisse_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX caisse_pk ON caisse USING btree (idcaisse);


--
-- TOC entry 2354 (class 1259 OID 522941)
-- Name: cassationtontine_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX cassationtontine_pk ON cassationtontine USING btree (idcassation);


--
-- TOC entry 2365 (class 1259 OID 522942)
-- Name: compteutilisateur_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX compteutilisateur_pk ON compteutilisateur USING btree (idcompte);


--
-- TOC entry 2373 (class 1259 OID 522943)
-- Name: cycletontine_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX cycletontine_pk ON cycletontine USING btree (idcycle);


--
-- TOC entry 2379 (class 1259 OID 522944)
-- Name: devices_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX devices_pk ON devise USING btree (iddevices);


--
-- TOC entry 2384 (class 1259 OID 522945)
-- Name: emprunt_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX emprunt_pk ON emprunt USING btree (idemprunt);


--
-- TOC entry 2391 (class 1259 OID 522946)
-- Name: encherebenficiare_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX encherebenficiare_pk ON encherebenficiare USING btree (idenchere);


--
-- TOC entry 2319 (class 1259 OID 522947)
-- Name: fki_aide_membre_aide; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_aide_membre_aide ON aide_membre USING btree (idaide);


--
-- TOC entry 2385 (class 1259 OID 522948)
-- Name: fki_caisse_emprunt; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_caisse_emprunt ON emprunt USING btree (idcaisse);


--
-- TOC entry 2399 (class 1259 OID 522949)
-- Name: fki_caisse_epargne; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_caisse_epargne ON epargne USING btree (idcaisse);


--
-- TOC entry 2357 (class 1259 OID 522950)
-- Name: fki_caisse_main_levee; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_caisse_main_levee ON collecte_main_levee USING btree (idcaisse);


--
-- TOC entry 2425 (class 1259 OID 522951)
-- Name: fki_caisse_membrecycle; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_caisse_membrecycle ON membrecycle USING btree (idcaisse);


--
-- TOC entry 2453 (class 1259 OID 522952)
-- Name: fki_caisse_payementsanction; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_caisse_payementsanction ON payement_sanction USING btree (idcaisse);


--
-- TOC entry 2469 (class 1259 OID 522953)
-- Name: fki_caisse_remboursement; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_caisse_remboursement ON remboursement USING btree (idcaisse);


--
-- TOC entry 2415 (class 1259 OID 522954)
-- Name: fki_cotisation_inscription_cotisation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_cotisation_inscription_cotisation ON inscription_cotisation USING btree (idcotisation);


--
-- TOC entry 2470 (class 1259 OID 522955)
-- Name: fki_emprunt_remboursement; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_emprunt_remboursement ON remboursement USING btree (idemprunt);


--
-- TOC entry 2332 (class 1259 OID 522956)
-- Name: fki_fk_tontiner_beneficiairetontine; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_fk_tontiner_beneficiairetontine ON beneficiaire_tontine USING btree (idtontiner);


--
-- TOC entry 2370 (class 1259 OID 522957)
-- Name: fki_fk_tontiner_fraiscotisation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_fk_tontiner_fraiscotisation ON cotisation_tontine USING btree (idtontiner);


--
-- TOC entry 2394 (class 1259 OID 522958)
-- Name: fki_idcalcul_interet_encours_interet; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_idcalcul_interet_encours_interet ON encours_emprunt USING btree (id_calcul_interet);


--
-- TOC entry 2358 (class 1259 OID 522959)
-- Name: fki_membre_cycle_main_levee; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_membre_cycle_main_levee ON collecte_main_levee USING btree (idmembre);


--
-- TOC entry 2329 (class 1259 OID 522960)
-- Name: fki_membreavalise_avalise; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_membreavalise_avalise ON avalyse USING btree (membre_avalyste);


--
-- TOC entry 2480 (class 1259 OID 522961)
-- Name: fki_naturecaisse_rubriquecaisse; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_naturecaisse_rubriquecaisse ON rubriquecaisse USING btree (idnaturecaisse);


--
-- TOC entry 2374 (class 1259 OID 522962)
-- Name: fki_pasemprunt_cycle; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_pasemprunt_cycle ON cycletontine USING btree (id_pas_emprunt);


--
-- TOC entry 2386 (class 1259 OID 522963)
-- Name: fki_rencontre_emprunt; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_rencontre_emprunt ON emprunt USING btree (idrencontre);


--
-- TOC entry 2359 (class 1259 OID 522964)
-- Name: fki_rencontre_main_levee; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_rencontre_main_levee ON collecte_main_levee USING btree (idrencontre);


--
-- TOC entry 2454 (class 1259 OID 522965)
-- Name: fki_rencontre_payement_sanction; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_rencontre_payement_sanction ON payement_sanction USING btree (idrencontre);


--
-- TOC entry 2471 (class 1259 OID 522966)
-- Name: fki_rencontre_remboursement; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_rencontre_remboursement ON remboursement USING btree (idrencontre);


--
-- TOC entry 2472 (class 1259 OID 522967)
-- Name: fki_typeremboursement_remboursement; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_typeremboursement_remboursement ON remboursement USING btree (idtyperemboursement);


--
-- TOC entry 2404 (class 1259 OID 522968)
-- Name: frequencecotisation_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX frequencecotisation_pk ON frequencecotisation USING btree (idfrequence);


--
-- TOC entry 2407 (class 1259 OID 522969)
-- Name: frequencetontine_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX frequencetontine_pk ON frequencetontine USING btree (idfreqtontine);


--
-- TOC entry 2412 (class 1259 OID 522970)
-- Name: groupeutilisateur_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX groupeutilisateur_pk ON groupeutilisateur USING btree (idgroupe);


--
-- TOC entry 2502 (class 1259 OID 522971)
-- Name: lotcotisation_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX lotcotisation_pk ON tranchecotisation USING btree (idtranche);


--
-- TOC entry 2419 (class 1259 OID 522972)
-- Name: mains_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX mains_pk ON mains USING btree (idmain);


--
-- TOC entry 2422 (class 1259 OID 522973)
-- Name: membre_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX membre_pk ON membre USING btree (idmembre);


--
-- TOC entry 2430 (class 1259 OID 522974)
-- Name: menu_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX menu_pk ON menu USING btree (idmenu);


--
-- TOC entry 2433 (class 1259 OID 522975)
-- Name: modepaiement_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX modepaiement_pk ON modepaiement USING btree (idmdepaiement);


--
-- TOC entry 2436 (class 1259 OID 522976)
-- Name: mois_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX mois_pk ON mois USING btree (idmois);


--
-- TOC entry 2441 (class 1259 OID 522977)
-- Name: mouchard_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX mouchard_pk ON mouchard USING btree (idoperation);


--
-- TOC entry 2448 (class 1259 OID 522978)
-- Name: operationcaisse_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX operationcaisse_pk ON operationcaisse USING btree (idoperationcaisse);


--
-- TOC entry 2462 (class 1259 OID 522979)
-- Name: privilege_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX privilege_pk ON privilege USING btree (idprivilege);


--
-- TOC entry 2475 (class 1259 OID 522980)
-- Name: remboursement_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX remboursement_pk ON remboursement USING btree (idremboursement);


--
-- TOC entry 2483 (class 1259 OID 522981)
-- Name: rubriquecaisse_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX rubriquecaisse_pk ON rubriquecaisse USING btree (idrubriquecaisse);


--
-- TOC entry 2486 (class 1259 OID 522982)
-- Name: sanction_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX sanction_pk ON sanction USING btree (idtsanction);


--
-- TOC entry 2499 (class 1259 OID 522983)
-- Name: tontine_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX tontine_pk ON tontine USING btree (idtontine);


--
-- TOC entry 2507 (class 1259 OID 522984)
-- Name: trancheemprunt_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX trancheemprunt_pk ON trancheemprunt USING btree (idtranche);


--
-- TOC entry 2512 (class 1259 OID 522985)
-- Name: typeinteret_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX typeinteret_pk ON typeinteret USING btree (idtypeinteret);


--
-- TOC entry 2626 (class 2606 OID 522986)
-- Name: TONTINER_ASSOC_COTISATION; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tontiner
    ADD CONSTRAINT "TONTINER_ASSOC_COTISATION" FOREIGN KEY (idcotisation) REFERENCES cotisation(idcotisation) NOT VALID;


--
-- TOC entry 2627 (class 2606 OID 522991)
-- Name: TONTINER_RENCONTRE; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tontiner
    ADD CONSTRAINT "TONTINER_RENCONTRE" FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre) NOT VALID;


--
-- TOC entry 2517 (class 2606 OID 522996)
-- Name: fk_aide_associati_cycleton; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aide
    ADD CONSTRAINT fk_aide_associati_cycleton FOREIGN KEY (idcycle) REFERENCES cycletontine(idcycle) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2518 (class 2606 OID 523001)
-- Name: fk_aide_beneficiaire; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aide
    ADD CONSTRAINT fk_aide_beneficiaire FOREIGN KEY (idbeneficiare) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2523 (class 2606 OID 523006)
-- Name: fk_aide_membre_aide; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aide_membre
    ADD CONSTRAINT fk_aide_membre_aide FOREIGN KEY (idaide) REFERENCES aide(idaide);


--
-- TOC entry 2519 (class 2606 OID 523011)
-- Name: fk_aide_membrecycle; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aide
    ADD CONSTRAINT fk_aide_membrecycle FOREIGN KEY (idmembre) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2520 (class 2606 OID 523016)
-- Name: fk_aide_motifaide; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aide
    ADD CONSTRAINT fk_aide_motifaide FOREIGN KEY (idmotifaide) REFERENCES motifaide(idmotifaide);


--
-- TOC entry 2521 (class 2606 OID 523021)
-- Name: fk_aide_rencontre; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aide
    ADD CONSTRAINT fk_aide_rencontre FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2525 (class 2606 OID 523026)
-- Name: fk_aidecoti_associati_cotisati; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aidecotisation
    ADD CONSTRAINT fk_aidecoti_associati_cotisati FOREIGN KEY (idcotisationtontine) REFERENCES cotisation_tontine(idcotisationtontine) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2526 (class 2606 OID 523031)
-- Name: fk_aidecoti_associati_membrecy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aidecotisation
    ADD CONSTRAINT fk_aidecoti_associati_membrecy FOREIGN KEY (idmembrecycle) REFERENCES membrecycle(idmembrecycle) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2527 (class 2606 OID 523036)
-- Name: fk_aidecotisation_caisse; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aidecotisation
    ADD CONSTRAINT fk_aidecotisation_caisse FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse) NOT VALID;


--
-- TOC entry 2528 (class 2606 OID 523041)
-- Name: fk_amende_membrecycle; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY amende
    ADD CONSTRAINT fk_amende_membrecycle FOREIGN KEY (idmembrecycle) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2529 (class 2606 OID 523046)
-- Name: fk_amende_rencontre; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY amende
    ADD CONSTRAINT fk_amende_rencontre FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2535 (class 2606 OID 523051)
-- Name: fk_benefici_associati_cycleton; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY beneficiairecotisation
    ADD CONSTRAINT fk_benefici_associati_cycleton FOREIGN KEY (idcycle) REFERENCES cycletontine(idcycle) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2532 (class 2606 OID 523056)
-- Name: fk_benefici_associati_mains; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY beneficiaire_tontine
    ADD CONSTRAINT fk_benefici_associati_mains FOREIGN KEY (idmain) REFERENCES mains(idmain) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2536 (class 2606 OID 523061)
-- Name: fk_benefici_associati_membre; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY beneficiairecotisation
    ADD CONSTRAINT fk_benefici_associati_membre FOREIGN KEY (idmembre) REFERENCES membre(idmembre) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2537 (class 2606 OID 523066)
-- Name: fk_benefici_associati_mois; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY beneficiairecotisation
    ADD CONSTRAINT fk_benefici_associati_mois FOREIGN KEY (idmois) REFERENCES mois(idmois) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2522 (class 2606 OID 523071)
-- Name: fk_caisse_aide; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aide
    ADD CONSTRAINT fk_caisse_aide FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse);


--
-- TOC entry 2538 (class 2606 OID 523076)
-- Name: fk_caisse_assoc_tontiner; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY caisse
    ADD CONSTRAINT fk_caisse_assoc_tontiner FOREIGN KEY (idtontiner) REFERENCES tontiner(idtontiner) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2539 (class 2606 OID 523081)
-- Name: fk_caisse_associati_cycleton; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY caisse
    ADD CONSTRAINT fk_caisse_associati_cycleton FOREIGN KEY (idcycle) REFERENCES cycletontine(idcycle) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2540 (class 2606 OID 523086)
-- Name: fk_caisse_associati_rubrique; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY caisse
    ADD CONSTRAINT fk_caisse_associati_rubrique FOREIGN KEY (idrubriquecaisse) REFERENCES rubriquecaisse(idrubriquecaisse) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2554 (class 2606 OID 523091)
-- Name: fk_caisse_collectesecours; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY collecte_secours
    ADD CONSTRAINT fk_caisse_collectesecours FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse) ON DELETE CASCADE;


--
-- TOC entry 2570 (class 2606 OID 523096)
-- Name: fk_caisse_emprunt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY emprunt
    ADD CONSTRAINT fk_caisse_emprunt FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse) ON DELETE CASCADE;


--
-- TOC entry 2579 (class 2606 OID 523101)
-- Name: fk_caisse_epargne; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY epargne
    ADD CONSTRAINT fk_caisse_epargne FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse) ON DELETE CASCADE;


--
-- TOC entry 2551 (class 2606 OID 523106)
-- Name: fk_caisse_main_levee; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY collecte_main_levee
    ADD CONSTRAINT fk_caisse_main_levee FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse);


--
-- TOC entry 2541 (class 2606 OID 523111)
-- Name: fk_caisse_membrecycle; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY caisse
    ADD CONSTRAINT fk_caisse_membrecycle FOREIGN KEY (idmembrecycle) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2588 (class 2606 OID 523116)
-- Name: fk_caisse_membrecycle; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY membrecycle
    ADD CONSTRAINT fk_caisse_membrecycle FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse) ON DELETE SET NULL;


--
-- TOC entry 2596 (class 2606 OID 523121)
-- Name: fk_caisse_payementsanction; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payement_sanction
    ADD CONSTRAINT fk_caisse_payementsanction FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse) ON DELETE CASCADE;


--
-- TOC entry 2609 (class 2606 OID 523126)
-- Name: fk_caisse_remboursement; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY remboursement
    ADD CONSTRAINT fk_caisse_remboursement FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse) ON DELETE CASCADE;


--
-- TOC entry 2549 (class 2606 OID 523131)
-- Name: fk_cassatio_associati_caisse; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cassationtontine
    ADD CONSTRAINT fk_cassatio_associati_caisse FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2550 (class 2606 OID 523136)
-- Name: fk_cassatio_associati_mains; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cassationtontine
    ADD CONSTRAINT fk_cassatio_associati_mains FOREIGN KEY (idmain) REFERENCES mains(idmain) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2557 (class 2606 OID 523141)
-- Name: fk_compte_membre; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compteutilisateur
    ADD CONSTRAINT fk_compte_membre FOREIGN KEY (idmembre) REFERENCES membre(idmembre);


--
-- TOC entry 2584 (class 2606 OID 523146)
-- Name: fk_cotisation_inscription_cotisation; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inscription_cotisation
    ADD CONSTRAINT fk_cotisation_inscription_cotisation FOREIGN KEY (idcotisation) REFERENCES cotisation(idcotisation);


--
-- TOC entry 2559 (class 2606 OID 523151)
-- Name: fk_cotisation_tontine; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cotisation
    ADD CONSTRAINT fk_cotisation_tontine FOREIGN KEY (idtontine) REFERENCES tontine(idtontine) NOT VALID;


--
-- TOC entry 2561 (class 2606 OID 523156)
-- Name: fk_cotisationtontine_caisse; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cotisation_tontine
    ADD CONSTRAINT fk_cotisationtontine_caisse FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse) NOT VALID;


--
-- TOC entry 2545 (class 2606 OID 523161)
-- Name: fk_cycle_cassation; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cassation
    ADD CONSTRAINT fk_cycle_cassation FOREIGN KEY (idcycle) REFERENCES cycletontine(idcycle);


--
-- TOC entry 2547 (class 2606 OID 523166)
-- Name: fk_cycle_cassation_detaillee; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cassation_detail
    ADD CONSTRAINT fk_cycle_cassation_detaillee FOREIGN KEY (idcycle) REFERENCES cycletontine(idcycle);


--
-- TOC entry 2564 (class 2606 OID 523171)
-- Name: fk_cycle_tontine; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cycletontine
    ADD CONSTRAINT fk_cycle_tontine FOREIGN KEY (idtontine) REFERENCES tontine(idtontine);


--
-- TOC entry 2566 (class 2606 OID 523176)
-- Name: fk_depense_cycle; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY depense
    ADD CONSTRAINT fk_depense_cycle FOREIGN KEY (idcycle) REFERENCES cycletontine(idcycle);


--
-- TOC entry 2567 (class 2606 OID 523181)
-- Name: fk_depense_idcaisse; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY depense
    ADD CONSTRAINT fk_depense_idcaisse FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse);


--
-- TOC entry 2568 (class 2606 OID 523186)
-- Name: fk_depense_rencontre; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY depense
    ADD CONSTRAINT fk_depense_rencontre FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2569 (class 2606 OID 523191)
-- Name: fk_depense_rubrique; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY depense
    ADD CONSTRAINT fk_depense_rubrique FOREIGN KEY (idrubriquecaisse) REFERENCES rubriquecaisse(idrubriquecaisse);


--
-- TOC entry 2571 (class 2606 OID 523196)
-- Name: fk_emprunt_associati_typeinte; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY emprunt
    ADD CONSTRAINT fk_emprunt_associati_typeinte FOREIGN KEY (idtypeinteret) REFERENCES typeinteret(idtypeinteret) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2530 (class 2606 OID 523201)
-- Name: fk_emprunt_avalyse; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY avalyse
    ADD CONSTRAINT fk_emprunt_avalyse FOREIGN KEY (idemprunt) REFERENCES emprunt(idemprunt);


--
-- TOC entry 2610 (class 2606 OID 523206)
-- Name: fk_emprunt_remboursement; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY remboursement
    ADD CONSTRAINT fk_emprunt_remboursement FOREIGN KEY (idemprunt) REFERENCES emprunt(idemprunt) ON DELETE CASCADE;


--
-- TOC entry 2574 (class 2606 OID 523211)
-- Name: fk_enchereb_associati_benefici; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY encherebenficiare
    ADD CONSTRAINT fk_enchereb_associati_benefici FOREIGN KEY (idbeneficiaire) REFERENCES beneficiaire_tontine(idbeneficiaire) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2575 (class 2606 OID 523216)
-- Name: fk_enchereb_associati_caisse; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY encherebenficiare
    ADD CONSTRAINT fk_enchereb_associati_caisse FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2580 (class 2606 OID 523221)
-- Name: fk_epargne_membrecycle; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY epargne
    ADD CONSTRAINT fk_epargne_membrecycle FOREIGN KEY (idmembrecycle) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2581 (class 2606 OID 523226)
-- Name: fk_epargne_rencontre; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY epargne
    ADD CONSTRAINT fk_epargne_rencontre FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2597 (class 2606 OID 523231)
-- Name: fk_fichepresence_payement_sanction; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payement_sanction
    ADD CONSTRAINT fk_fichepresence_payement_sanction FOREIGN KEY (idpresence) REFERENCES fiche_presence(id);


--
-- TOC entry 2562 (class 2606 OID 523236)
-- Name: fk_fraiscot_associati_mains; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cotisation_tontine
    ADD CONSTRAINT fk_fraiscot_associati_mains FOREIGN KEY (idmain) REFERENCES mains(idmain) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2576 (class 2606 OID 523241)
-- Name: fk_idcalcul_interet_encours_interet; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY encours_emprunt
    ADD CONSTRAINT fk_idcalcul_interet_encours_interet FOREIGN KEY (id_calcul_interet) REFERENCES calcul_interet(id);


--
-- TOC entry 2607 (class 2606 OID 523246)
-- Name: fk_inscription_redevance_tontine; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY redevance_cotisation
    ADD CONSTRAINT fk_inscription_redevance_tontine FOREIGN KEY (idinscription) REFERENCES inscription_cotisation(idinscription);


--
-- TOC entry 2586 (class 2606 OID 523251)
-- Name: fk_mains_associati_inscript; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mains
    ADD CONSTRAINT fk_mains_associati_inscript FOREIGN KEY (idinscription) REFERENCES inscription_cotisation(idinscription) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2524 (class 2606 OID 523256)
-- Name: fk_membre_aide_membre; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aide_membre
    ADD CONSTRAINT fk_membre_aide_membre FOREIGN KEY (idmembre) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2546 (class 2606 OID 523261)
-- Name: fk_membre_cassation; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cassation
    ADD CONSTRAINT fk_membre_cassation FOREIGN KEY (idmembre) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2548 (class 2606 OID 523266)
-- Name: fk_membre_cassation_detaillee; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cassation_detail
    ADD CONSTRAINT fk_membre_cassation_detaillee FOREIGN KEY (idmembre) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2555 (class 2606 OID 523271)
-- Name: fk_membre_collectesecours; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY collecte_secours
    ADD CONSTRAINT fk_membre_collectesecours FOREIGN KEY (idmembre) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2543 (class 2606 OID 523276)
-- Name: fk_membre_cycle_calcul_taux_interet; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY calcul_interet
    ADD CONSTRAINT fk_membre_cycle_calcul_taux_interet FOREIGN KEY (idmembre) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2552 (class 2606 OID 523281)
-- Name: fk_membre_cycle_main_levee; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY collecte_main_levee
    ADD CONSTRAINT fk_membre_cycle_main_levee FOREIGN KEY (idmembre) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2587 (class 2606 OID 523286)
-- Name: fk_membre_pays; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY membre
    ADD CONSTRAINT fk_membre_pays FOREIGN KEY (idpays) REFERENCES pays(idpays);


--
-- TOC entry 2585 (class 2606 OID 523291)
-- Name: fk_membrec_inscription; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inscription_cotisation
    ADD CONSTRAINT fk_membrec_inscription FOREIGN KEY (idmembre) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2531 (class 2606 OID 523296)
-- Name: fk_membrecycle_avalyse; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY avalyse
    ADD CONSTRAINT fk_membrecycle_avalyse FOREIGN KEY (membre_avalyste) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2589 (class 2606 OID 523301)
-- Name: fk_membrecycle_cycle; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY membrecycle
    ADD CONSTRAINT fk_membrecycle_cycle FOREIGN KEY (idcycle) REFERENCES cycletontine(idcycle);


--
-- TOC entry 2572 (class 2606 OID 523306)
-- Name: fk_membrecycle_emprunt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY emprunt
    ADD CONSTRAINT fk_membrecycle_emprunt FOREIGN KEY (idmembre) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2577 (class 2606 OID 523311)
-- Name: fk_membrecycle_encours_secours; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY encours_secours
    ADD CONSTRAINT fk_membrecycle_encours_secours FOREIGN KEY (idmembre) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2582 (class 2606 OID 523316)
-- Name: fk_membrecycle_fichepresence; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fiche_presence
    ADD CONSTRAINT fk_membrecycle_fichepresence FOREIGN KEY (idmembre) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2590 (class 2606 OID 523321)
-- Name: fk_membrecycle_membre; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY membrecycle
    ADD CONSTRAINT fk_membrecycle_membre FOREIGN KEY (idmembre) REFERENCES membre(idmembre);


--
-- TOC entry 2591 (class 2606 OID 523326)
-- Name: fk_membretontine_membre; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY membretontine
    ADD CONSTRAINT fk_membretontine_membre FOREIGN KEY (idmembre) REFERENCES membre(idmembre);


--
-- TOC entry 2592 (class 2606 OID 523331)
-- Name: fk_membretontine_tontine; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY membretontine
    ADD CONSTRAINT fk_membretontine_tontine FOREIGN KEY (idtontine) REFERENCES tontine(idtontine);


--
-- TOC entry 2593 (class 2606 OID 523336)
-- Name: fk_mouchard_idcompte_utilisateur; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mouchard
    ADD CONSTRAINT fk_mouchard_idcompte_utilisateur FOREIGN KEY (idcompte_utilisateur) REFERENCES compteutilisateur(idcompte);


--
-- TOC entry 2617 (class 2606 OID 523341)
-- Name: fk_naturecaisse_rubriquecaisse; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rubriquecaisse
    ADD CONSTRAINT fk_naturecaisse_rubriquecaisse FOREIGN KEY (idnaturecaisse) REFERENCES naturecaisse(idnaturecaisse);


--
-- TOC entry 2594 (class 2606 OID 523346)
-- Name: fk_operatio_associati_cycleton; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY operationcaisse
    ADD CONSTRAINT fk_operatio_associati_cycleton FOREIGN KEY (idcycle) REFERENCES cycletontine(idcycle) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2595 (class 2606 OID 523351)
-- Name: fk_operatio_associati_mois; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY operationcaisse
    ADD CONSTRAINT fk_operatio_associati_mois FOREIGN KEY (idmois) REFERENCES mois(idmois) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2565 (class 2606 OID 523356)
-- Name: fk_pasemprunt_cycle; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cycletontine
    ADD CONSTRAINT fk_pasemprunt_cycle FOREIGN KEY (id_pas_emprunt) REFERENCES pas_emprunt(idpas);


--
-- TOC entry 2560 (class 2606 OID 523361)
-- Name: fk_premiere_rencontre; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cotisation
    ADD CONSTRAINT fk_premiere_rencontre FOREIGN KEY (premierjour) REFERENCES rencontre(idrencontre) NOT VALID;


--
-- TOC entry 2599 (class 2606 OID 523366)
-- Name: fk_privileg_associati_menu; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY privilege
    ADD CONSTRAINT fk_privileg_associati_menu FOREIGN KEY (idmenu) REFERENCES menu(idmenu) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2600 (class 2606 OID 523371)
-- Name: fk_privilege_idcompte_utilisateur; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY privilege
    ADD CONSTRAINT fk_privilege_idcompte_utilisateur FOREIGN KEY (idcompte_utilisateur) REFERENCES compteutilisateur(idcompte);


--
-- TOC entry 2601 (class 2606 OID 523376)
-- Name: fk_ration_membrecycle; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ration
    ADD CONSTRAINT fk_ration_membrecycle FOREIGN KEY (idmembrecycle) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2602 (class 2606 OID 523381)
-- Name: fk_ration_rencontre; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ration
    ADD CONSTRAINT fk_ration_rencontre FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2603 (class 2606 OID 523386)
-- Name: fk_recette_cycle; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY recette
    ADD CONSTRAINT fk_recette_cycle FOREIGN KEY (idcycle) REFERENCES cycletontine(idcycle);


--
-- TOC entry 2604 (class 2606 OID 523391)
-- Name: fk_recette_idcaisse; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY recette
    ADD CONSTRAINT fk_recette_idcaisse FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse);


--
-- TOC entry 2542 (class 2606 OID 523396)
-- Name: fk_rencontre_caisse; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY caisse
    ADD CONSTRAINT fk_rencontre_caisse FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2544 (class 2606 OID 523401)
-- Name: fk_rencontre_calcult_interet; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY calcul_interet
    ADD CONSTRAINT fk_rencontre_calcult_interet FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2556 (class 2606 OID 523406)
-- Name: fk_rencontre_collectesecours; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY collecte_secours
    ADD CONSTRAINT fk_rencontre_collectesecours FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2613 (class 2606 OID 523411)
-- Name: fk_rencontre_cycle; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rencontre
    ADD CONSTRAINT fk_rencontre_cycle FOREIGN KEY (idcycle) REFERENCES cycletontine(idcycle);


--
-- TOC entry 2573 (class 2606 OID 523416)
-- Name: fk_rencontre_emprunt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY emprunt
    ADD CONSTRAINT fk_rencontre_emprunt FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2578 (class 2606 OID 523421)
-- Name: fk_rencontre_encours_secours; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY encours_secours
    ADD CONSTRAINT fk_rencontre_encours_secours FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2583 (class 2606 OID 523426)
-- Name: fk_rencontre_fichepresence; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fiche_presence
    ADD CONSTRAINT fk_rencontre_fichepresence FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2553 (class 2606 OID 523431)
-- Name: fk_rencontre_main_levee; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY collecte_main_levee
    ADD CONSTRAINT fk_rencontre_main_levee FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2598 (class 2606 OID 523436)
-- Name: fk_rencontre_payement_sanction; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payement_sanction
    ADD CONSTRAINT fk_rencontre_payement_sanction FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2605 (class 2606 OID 523441)
-- Name: fk_rencontre_recette; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY recette
    ADD CONSTRAINT fk_rencontre_recette FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2608 (class 2606 OID 523446)
-- Name: fk_rencontre_redevance_tontine; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY redevance_cotisation
    ADD CONSTRAINT fk_rencontre_redevance_tontine FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2611 (class 2606 OID 523451)
-- Name: fk_rencontre_remboursement; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY remboursement
    ADD CONSTRAINT fk_rencontre_remboursement FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2614 (class 2606 OID 523456)
-- Name: fk_rencontre_tontine; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rencontre
    ADD CONSTRAINT fk_rencontre_tontine FOREIGN KEY (id_tontine) REFERENCES tontine(idtontine);


--
-- TOC entry 2615 (class 2606 OID 523461)
-- Name: fk_retard_membrecycle; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY retard
    ADD CONSTRAINT fk_retard_membrecycle FOREIGN KEY (idmembrecycle) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2616 (class 2606 OID 523466)
-- Name: fk_retard_rencontre; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY retard
    ADD CONSTRAINT fk_retard_rencontre FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2606 (class 2606 OID 523471)
-- Name: fk_rubrique_recette; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY recette
    ADD CONSTRAINT fk_rubrique_recette FOREIGN KEY (idrubrique) REFERENCES rubriquecaisse(idrubriquecaisse);


--
-- TOC entry 2618 (class 2606 OID 523476)
-- Name: fk_secours_membrecycle; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY secours
    ADD CONSTRAINT fk_secours_membrecycle FOREIGN KEY (idmembrecycle) REFERENCES membrecycle(idmembrecycle);


--
-- TOC entry 2619 (class 2606 OID 523481)
-- Name: fk_secours_rencontre; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY secours
    ADD CONSTRAINT fk_secours_rencontre FOREIGN KEY (idrencontre) REFERENCES rencontre(idrencontre);


--
-- TOC entry 2620 (class 2606 OID 523486)
-- Name: fk_tontine_associati_devices; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tontine
    ADD CONSTRAINT fk_tontine_associati_devices FOREIGN KEY (iddevices) REFERENCES devise(iddevices) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2621 (class 2606 OID 523491)
-- Name: fk_tontine_associati_frequenc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tontine
    ADD CONSTRAINT fk_tontine_associati_frequenc FOREIGN KEY (idfreqtontine) REFERENCES frequencetontine(idfreqtontine) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2622 (class 2606 OID 523496)
-- Name: fk_tontine_associati_modepaie; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tontine
    ADD CONSTRAINT fk_tontine_associati_modepaie FOREIGN KEY (idmdepaiement) REFERENCES modepaiement(idmdepaiement) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2623 (class 2606 OID 523501)
-- Name: fk_tontine_associati_sanction; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tontine
    ADD CONSTRAINT fk_tontine_associati_sanction FOREIGN KEY (idtsanction) REFERENCES sanction(idtsanction) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2624 (class 2606 OID 523506)
-- Name: fk_tontine_cotisation; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tontine
    ADD CONSTRAINT fk_tontine_cotisation FOREIGN KEY (idtranchecotisation) REFERENCES tranchecotisation(idtranche);


--
-- TOC entry 2625 (class 2606 OID 523511)
-- Name: fk_tontine_rubriquecaisse; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tontine
    ADD CONSTRAINT fk_tontine_rubriquecaisse FOREIGN KEY (idrubriquecaisse) REFERENCES rubriquecaisse(idrubriquecaisse);


--
-- TOC entry 2533 (class 2606 OID 523516)
-- Name: fk_tontiner_beneficiairetontine; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY beneficiaire_tontine
    ADD CONSTRAINT fk_tontiner_beneficiairetontine FOREIGN KEY (idtontiner) REFERENCES tontiner(idtontiner) NOT VALID;


--
-- TOC entry 2534 (class 2606 OID 523521)
-- Name: fk_tontiner_bouffe_caisse; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY beneficiaire_tontine
    ADD CONSTRAINT fk_tontiner_bouffe_caisse FOREIGN KEY (idcaisse) REFERENCES caisse(idcaisse) NOT VALID;


--
-- TOC entry 2563 (class 2606 OID 523526)
-- Name: fk_tontiner_fraiscotisation; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cotisation_tontine
    ADD CONSTRAINT fk_tontiner_fraiscotisation FOREIGN KEY (idtontiner) REFERENCES tontiner(idtontiner) NOT VALID;


--
-- TOC entry 2612 (class 2606 OID 523531)
-- Name: fk_typeremboursement_remboursement; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY remboursement
    ADD CONSTRAINT fk_typeremboursement_remboursement FOREIGN KEY (idtyperemboursement) REFERENCES type_remboursement(id);


--
-- TOC entry 2558 (class 2606 OID 523536)
-- Name: fk_utilisateur_compte_utilisateur; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compteutilisateur
    ADD CONSTRAINT fk_utilisateur_compte_utilisateur FOREIGN KEY (idutilisateur) REFERENCES utilisateur(idutilisateur);


--
-- TOC entry 2628 (class 2606 OID 523541)
-- Name: fk_utilisateur_groupeuser; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY utilisateur
    ADD CONSTRAINT fk_utilisateur_groupeuser FOREIGN KEY (idgroupeutilisateur) REFERENCES groupeutilisateur(idgroupe);


--
-- TOC entry 2629 (class 2606 OID 523546)
-- Name: fk_utilisateurtontine_tontine; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY utilisateurtontine
    ADD CONSTRAINT fk_utilisateurtontine_tontine FOREIGN KEY (idtontine) REFERENCES tontine(idtontine);


--
-- TOC entry 2630 (class 2606 OID 523551)
-- Name: fk_utilisateurtontine_utilisateur; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY utilisateurtontine
    ADD CONSTRAINT fk_utilisateurtontine_utilisateur FOREIGN KEY (idutilisateur) REFERENCES utilisateur(idutilisateur);


-- Completed on 2021-06-11 16:40:28

--
-- PostgreSQL database dump complete
--

