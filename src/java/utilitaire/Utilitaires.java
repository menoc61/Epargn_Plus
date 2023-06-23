/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilitaire;

import controllers.util.JsfUtil;
import entities.CalculInteret;
import entities.Cassation;
import entities.CassationDetail;
import entities.CollecteSecours;
import entities.Compteutilisateur;
import entities.Cycletontine;
import entities.Emprunt;
import entities.EncoursEmprunt;
import entities.EncoursSecours;
import entities.Epargne;
import entities.FichePresence;
import entities.Mouchard;
import entities.Membrecycle;
import entities.RedevanceCotisation;
import entities.Remboursement;
import entities.Rencontre;
import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.faces.context.FacesContext;
import javax.servlet.ServletContext;
import org.joda.time.DateTime;
import org.joda.time.Days;
import org.joda.time.Months;
import org.joda.time.Weeks;
import org.joda.time.Years;
import sessions.CassationDetailFacadeLocal;
import sessions.CassationFacadeLocal;
import sessions.EncoursEmpruntFacadeLocal;
import sessions.EncoursSecoursFacadeLocal;
import sessions.MouchardFacadeLocal;

/**
 *
 * @author kenne gervais
 */
public class Utilitaires {

    private static final ServletContext servletContext = (ServletContext) FacesContext.getCurrentInstance().getExternalContext().getContext();
    public static final String path = servletContext.getRealPath("");
    public static final String repertoireDefautVehicule = "Rapports/ListeVehicule";
    public static final String nomFichierParDefautListeVehicule = "Liste_des_vehicules.pdf";

    public static final String repertoireDefautRestitution = "Rapports/Restitution";
    public static final String nomFichierParDefautRestitution = "Liste_des_restitutions.pdf";

    public static final String repertoireDefautAttribution = "Rapports/Attribution";
    public static final String nomFichierParDefautAttribution = "Liste_des_attribution.pdf";

    public static final String repertoireDefautHistoriqueReforme = "Rapports/HistoriqueReforme";
    public static final String nomFichierParDefautHistoriqueReforme = "Historique_reforme.pdf";

    public static final String repertoireDefautFicheDetention = "Rapports/FicheDetention";
    public static final String nomFichierParDefautFicheDetention = "FicheDetention.pdf";

    public static final String repertoireDefautCycledevie = "Rapports/Cycledevie";
    public static final String nomFichierParDefautCycledevie = "Cycledevie.pdf";

    public static final String repertoireDefautAnalyseNorme = "Rapports/AnalyseNorme";
    public static final String nomFichierParDefautAnalyseNorme = "AnalyseNorme.pdf";

    public static final String userAvatar = "avatar1.png";
    public static final String carAvatar = "carAvatar.jpeg";

    public static String formaterStringMoney(Long valeur) {
        String chaine = Long.toString(valeur);
        if (chaine == null) {
            return null;
        }
        int taille = chaine.length(), j = taille;
        String result = "";
        int i = 0;
        while (i < taille) {
            result += chaine.charAt(i);
            i++;
            j--;
            if (j > 0 && j % 3 == 0) {
                result += ' ';
            }
        }

        return result;
    }

    public static String formaterStringMoney(Integer valeur) {
        String chaine = Integer.toString(valeur);
        if (chaine == null) {
            return null;
        }
        int taille = chaine.length(), j = taille;
        String result = "";
        int i = 0;
        while (i < taille) {
            result += chaine.charAt(i);
            i++;
            j--;
            if (j > 0 && j % 3 == 0) {
                result += ' ';
            }
        }

        return result;
    }

    public static String formaterStringMoney(String valeur) {
        String chaine = valeur;
        if (chaine == null) {
            return null;
        }
        int taille = chaine.length(), j = taille;
        String result = "";
        int i = 0;
        while (i < taille) {
            result += chaine.charAt(i);
            i++;
            j--;
            if (j > 0 && j % 3 == 0) {
                result += ' ';
            }
        }

        return result;
    }

    public static String formaterStringMoney(Double val) {
        String pEntiere = partieEntiere(val);
        String pDec = partieDecimale(val);
        String chaine = pEntiere;
        int taille = chaine.length(), j = taille;
        String result = "";
        int i = 0;
        while (i < taille) {
            result += chaine.charAt(i);
            i++;
            j--;
            if (j > 0 && j % 3 == 0) {
                result += ' ';
            }
        }
        if (pDec != null) {
            result = result + "." + pDec;
        }
        return result;
    }

    private static String partieDecimale(Double nombre) {
        return partieDecimale(nombre.toString());
    }

    private static String partieDecimale(String nombre) {
        String result = "";
        int taille = nombre.length();
        boolean copie = false;
        for (int i = 0; i < taille; i++) {
            if (copie) {
                result += nombre.charAt(i);
            } else if (nombre.charAt(i) == '.') {
                copie = true;
            }
        }
        if (result.equals("0")) {
            return null;
        }
        return result;
    }

    private static String partieEntiere(Double nombre) {
        Integer tmp = nombre.intValue();
        return tmp.toString();
    }

    public static String formatPrenomMaj(String prenom) {
        if (prenom.isEmpty()) {
            return " ";
        }
        char prenLettre = '0';
        String leReste;
        String lettre1;

        prenLettre = prenom.charAt(0);//recuperation de la premiere lettre

        leReste = prenom.substring(1, prenom.length());//recuperation du reste du nom sauf la premiere lettre

        lettre1 = String.valueOf(prenLettre);

        leReste = leReste.toLowerCase();//le reste ne minuscules

        return lettre1.toUpperCase() + leReste;
    }

    public static double arrondiNDecimales(double x, int n) {
        double pow = Math.pow(10, n);
        return (Math.floor(x * pow)) / pow;
    }

    public static Mouchard saveOperation(String action, Compteutilisateur compteutilisateur, MouchardFacadeLocal mouchardFacadeLocal) {
        Mouchard mouchard = new Mouchard();
        try {
            mouchard.setIdoperation(mouchardFacadeLocal.nextId());
            mouchard.setAction(action);
            mouchard.setDateaction(new Date());
            mouchard.setHeure(new Date());
            mouchard.setIdcompteUtilisateur(compteutilisateur);
            mouchardFacadeLocal.create(mouchard);
            return mouchard;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return mouchard;
        }
    }

    public static Integer duration(Date date1, Date date2, Integer type) {

        DateTime dateDebut = new DateTime("" + (date1.getYear() + 1900) + "-" + (date1.getMonth() + 1) + "-" + date1.getDate() + "");
        DateTime dateFin = new DateTime("" + (date2.getYear() + 1900) + "-" + (date2.getMonth() + 1) + "-" + date2.getDate() + "");

        if (type.equals(1)) {
            Integer ecart = (Integer) Days.daysBetween(dateDebut, dateFin).getDays();
            Integer nbjr = Days.daysBetween(dateDebut, dateFin).getDays();

            Double res = ecart.doubleValue() % 30;

            if (res == 27) {
                nbjr += 3;
            } else if (res == 28) {
                nbjr += 2;
            } else if (res == 29) {
                nbjr += 1;
            }
            return nbjr;

        } else if (type.equals(2)) {
            return Weeks.weeksBetween(dateDebut, dateFin).getWeeks();
        } else if (type.equals(3)) {
            return Months.monthsBetween(dateDebut, dateFin).getMonths();
        } else {
            return Years.yearsBetween(dateDebut, dateFin).getYears();
        }
    }

    public static void generateEmprunt(Cycletontine cycletontine, List<Emprunt> emprunts, List<Remboursement> remboursements, List<CalculInteret> calculInterets, Rencontre rencontre, EncoursEmpruntFacadeLocal encoursEmpruntFacadeLocal) {

        if (emprunts.isEmpty()) {
            JsfUtil.addWarningMessage("Aucun emprunt encours");
            //return;
        }

        if (!calculInterets.isEmpty()) {

            for (CalculInteret c : calculInterets) {

                Double cumul_interet = 0d;
                for (Emprunt e : emprunts) {
                    if (c.getIdmembre().equals(e.getIdmembre())) {
                        cumul_interet += e.getCumulInteret();
                    }
                }

                Double remboursement_interet = 0d;
                Double capital_rembourse = 0d;
                int count_r = 0;

                for (Remboursement r : remboursements) {
                    if (c.getIdmembre().equals(r.getIdemprunt().getIdmembre())) {
                        if (r.getIdrencontre().equals(rencontre)) {
                            if (r.getIdtyperemboursement().getId().equals(2)) {
                                remboursement_interet += r.getMontantRembourse();
                                count_r++;
                            } else {
                                capital_rembourse += r.getMontantRembourse();
                                count_r++;
                            }
                        }
                    }
                }

                EncoursEmprunt temp = new EncoursEmprunt();
                temp.setIdEncoursEmprunt(encoursEmpruntFacadeLocal.nextId());
                temp.setIdCalculInteret(c);
                temp.setSoldeCapital(c.getResteCapital());
                temp.setSoldeInteret(c.getMontantInteret());

                temp.setCapitalRembourse(capital_rembourse);
                temp.setInteretRembourse(remboursement_interet);
                temp.setTotal(capital_rembourse + remboursement_interet);

                encoursEmpruntFacadeLocal.create(temp);
            }

        } else {
            JsfUtil.addErrorMessage("Veuilez calculer les interets d'abord");
        }
    }

    public static void genererSecours(List<Membrecycle> membrecycles, List<CollecteSecours> collecteSecourses, Rencontre rencontre, Cycletontine cycletontine, EncoursSecoursFacadeLocal encoursSecoursFacadeLocal) {
        if (!membrecycles.isEmpty()) {

            for (Membrecycle mc : membrecycles) {

                EncoursSecours temp = new EncoursSecours();

                Double montant_cotise = 0d;
                for (CollecteSecours c : collecteSecourses) {
                    if (c.getIdmembre().equals(mc)) {
                        if (c.getIdrencontre().equals(rencontre)) {
                            montant_cotise += c.getMontant();
                        }
                    }
                }

                temp.setIdEncoursSecours(encoursSecoursFacadeLocal.nextId());
                temp.setIdrencontre(rencontre);
                temp.setIdmembre(mc);
                temp.setMontantCotise(montant_cotise);

                temp.setEncours(cycletontine.getMontantSecours() - mc.getMontantSecours() + montant_cotise);
                temp.setReste(cycletontine.getMontantSecours() - mc.getMontantSecours());

                if (temp.getReste() == 0d) {
                    temp.setObservation("100%");
                } else {
                    temp.setObservation("" + Utilitaires.arrondiNDecimales(((mc.getMontantSecours() * 100) / cycletontine.getMontantSecours()), 2) + "%");
                }
                encoursSecoursFacadeLocal.create(temp);
            }
            JsfUtil.addSuccessMessage("Opération réussie");
        } else {
            JsfUtil.addErrorMessage("Le systeme n'a aucun emprunt en cours ou le calcul d'interet n'est pas encore effectué");
        }
    }

    public static void cassation(Cycletontine cycletontine, List<Cassation> cassations,
            List<Emprunt> emprunts, List<Membrecycle> membrecycles,
            List<Remboursement> remboursements, List<Epargne> epargnes, CassationFacadeLocal cassationFacadeLocal,
            CassationDetailFacadeLocal cassationDetailFacadeLocal, Rencontre rencontre, List<RedevanceCotisation> redevanceCotisations,
            List<FichePresence> fichePresences) throws Exception {

        Double totalInteretRembourse = 0d;
        Double totalEmprunt = 0d;
        Double totalRemboursementCapital = 0d;
        Double totalPoint = 0d;
        Double totalPourcentage = 0d;
        Double totalEpargne = 0d;
        Double resteCapital = 0d;
        Double totalInteretGenere = 0d;

        cassations.clear();

        if (cycletontine != null) {

            if (cassations.isEmpty()) {

                for (Membrecycle mc : membrecycles) {

                    Cassation c = new Cassation();

                    Double sommePoint = 0d;
                    Double sommeCoefEpargne = 0d;
                    Double sommeDuree = 0d;
                    Double resteCaptital = 0d;
                    //Interet total generé par membre
                    Double sommeInteretGenere = 0d;

                    c.setId(cassationFacadeLocal.nextId());
                    c.setIdcycle(cycletontine);
                    c.setIdmembre(mc);
                    c.setMontantEpargne(0d);
                    c.setMontantGain(0d);
                    c.setNombrePoint(0d);

                    Double sommeEmprunt = 0d;
                    Double sommeRemboursementCapital = 0d;
                    Double sommeRemboursementInteret = 0d;
                    Double sommeEpargne = 0d;

                    for (Emprunt e : emprunts) {
                        if (mc.equals(e.getIdmembre())) {
                            sommeEmprunt += e.getMontantemp();
                            resteCaptital += e.getMontantRemboursable();

                            sommeInteretGenere += e.getCumulInteret();

                            //on va ajouteur une instruction ici
                            if (!e.getRembourse()) {
                                if (Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur() <= 0) {
                                    sommeInteretGenere += 0;
                                } else {
                                    if (e.getIdtypeinteret().getIdtypeinteret().equals(2)) {
                                        sommeInteretGenere += (e.getMontantRemboursable() * e.getTaux() * ((Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur()))) / 100;
                                    } else {
                                        sommeInteretGenere += (e.getMontantRemboursable() + e.getCumulInteret()) * Math.pow(1 + (e.getTaux() / 100), ((Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur())));
                                        sommeInteretGenere -= (e.getMontantRemboursable() + e.getCumulInteret());
                                    }
                                }
                            }
                        }
                    }

                    for (Remboursement r : remboursements) {
                        if (mc.equals(r.getIdemprunt().getIdmembre())) {
                            if (r.getIdtyperemboursement().getId().equals(1)) {
                                sommeRemboursementCapital += r.getMontantRembourse();
                            } else {
                                sommeRemboursementInteret += r.getMontantRembourse();
                                sommeInteretGenere += r.getMontantRembourse();
                            }
                        }
                    }

                    totalInteretRembourse += sommeRemboursementInteret;
                    totalInteretGenere += sommeInteretGenere;

                    for (Epargne e : epargnes) {
                        if (mc.equals(e.getIdmembrecycle())) {

                            sommeEpargne += e.getMontant();
                            //on enregistre le detail de la cassation
                            CassationDetail cassationDetail = new CassationDetail();
                            cassationDetail.setId(cassationDetailFacadeLocal.nextId());
                            cassationDetail.setIdcycle(cycletontine);
                            cassationDetail.setIdmembre(mc);
                            cassationDetail.setDateEpargne(e.getIdrencontre().getDaterencontre());
                            cassationDetail.setDateCalcul(rencontre.getDaterencontre());
                            cassationDetail.setMontant(e.getMontant());

                            Integer duree = Utilitaires.duration(e.getDateepargne(), rencontre.getDaterencontre(), cycletontine.getIdPasEmprunt().getIdpas());
                            sommeDuree += duree;

                            Double coef = e.getMontant() / cycletontine.getUniteEmprunt();
                            sommeCoefEpargne += coef;

                            Double point = duree * coef / cycletontine.getIdPasEmprunt().getValeur();
                            totalPoint += point;
                            sommePoint += point;

                            cassationDetail.setDuree(duree.doubleValue());

                            cassationDetail.setNombrePoint(Utilitaires.arrondiNDecimales(point, 2));
                            cassationDetail.setCoefEpargne(Utilitaires.arrondiNDecimales((e.getMontant() / cycletontine.getUniteEmprunt()), 2));
                            cassationDetailFacadeLocal.create(cassationDetail);
                        }
                    }

                    //Montant interet paye
                    c.setMontantInteret(sommeRemboursementInteret);

                    //*********************** Somme du capital remboursé pour les emprunts********************//
                    c.setMontantRembourse(sommeRemboursementCapital);

                    //************************************ somme des montants epargnés ***********************//
                    c.setMontantEpargne(sommeEpargne);

                    //************************************ sommes des montants empruntés *********************//
                    c.setMontantEmprunte(sommeEmprunt);

                    sommeCoefEpargne = sommeEpargne / cycletontine.getUniteEmprunt();

                    //*********************************** sommes des coefficient d'epargne *******************//
                    c.setCoefEpargne(sommeCoefEpargne);

                    //********************************** sommes des durées ***********************************//
                    c.setDuree(sommeDuree);

                    //*********************************** arroindi du nombre de point ************************//
                    c.setNombrePoint(Utilitaires.arrondiNDecimales(sommePoint, 1));

                    Double pourcentagegain = ((sommePoint * 100) / (Double) calcul_totalpoint(membrecycles, emprunts, remboursements, epargnes, cycletontine, rencontre).get("total_point"));

                    //********************************** pourcentage de gain du membre************************//
                    c.setPourcentageGain(pourcentagegain);
                    //c.setPourcentageGain(Utilitaires.arrondiNDecimales(pourcentagegain,3));

                    Double gain = ((c.getPourcentageGain() * (Double) calcul_totalpoint(membrecycles, emprunts, remboursements, epargnes, cycletontine, rencontre).get("total_interet")) / 100);

                    //****************************************** gain normal *********************************// 
                    c.setGainNormal(gain);

                    //******************** gain perçu et gain de la cotisation ***********************//
                    //Double gainProportionnel = (c.getMontantEpargne() / cycletontine.getProportionGain()) / 100;
                    Double gainProportionnel = (c.getMontantEpargne() * cycletontine.getProportionGain()) / 100;
                    if (gain <= gainProportionnel) {
                        c.setMontantGain(gain);
                        c.setGainTontine(0d);
                    } else {
                        c.setMontantGain(gainProportionnel);
                        c.setGainTontine(gain - gainProportionnel);
                    }

                    //********************** reste du capital des emprunts a reverser ***********************//
                    c.setResteCapital(resteCaptital);
                    c.setResteInteret(sommeInteretGenere);

                    //*********************** redevance cotisation ********************************//
                    Double redevanceCotisation = 0d;
                    for (RedevanceCotisation r : redevanceCotisations) {
                        if (r.getIdinscription().getIdmembre().equals(mc)) {
                            redevanceCotisation += r.getReste();
                        }
                    }

                    Double redevancePenalite = 0d;
                    for (FichePresence f : fichePresences) {
                        if (f.getIdmembre().equals(mc)) {
                            redevancePenalite = f.getMontantPenalite();
                        }
                    }

                    Double redevanceSecours = 0d;
                    if (mc.getMontantSecours() > 0) {
                        redevanceSecours = cycletontine.getMontantSecours() - mc.getMontantSecours();
                    } else {
                        redevanceSecours = cycletontine.getMontantSecours() + Math.abs(mc.getMontantSecours());
                    }

                    c.setRedevanceCotisation(redevanceCotisation);
                    c.setRedevanceAbsence(redevancePenalite);
                    c.setRedevanceSecours(redevanceSecours);
                    c.setRedevanceMainLaivee(Math.abs(mc.getResteMainLevee()));

                    Double total1 = (c.getMontantEpargne() + c.getMontantGain());
                    Double redevance = (c.getRedevanceAbsence() + c.getRedevanceCotisation() + c.getRedevanceSecours() + c.getRedevanceMainLaivee() + c.getResteCapital());
                    Double resteI = (c.getResteInteret() - c.getMontantInteret());
                    Double nap = ((total1) - redevance - resteI);

                    c.setNetAPercevoir(nap);

                    totalEmprunt += sommeEmprunt;
                    totalRemboursementCapital += sommeRemboursementCapital;
                    totalPoint += totalPoint;
                    totalPourcentage += c.getPourcentageGain();
                    totalEpargne += sommeEpargne;
                    resteCapital += c.getResteCapital();
                    totalInteretGenere += c.getResteInteret();

                    cassationFacadeLocal.create(c);
                }
            }
        }
    }

    public static Map calcul_totalpoint(List<Membrecycle> membrecycles, List<Emprunt> emprunts, List<Remboursement> remboursements, List<Epargne> epargnes, Cycletontine cycletontine, Rencontre rencontre) {
        Double totalPoint = 0d;
        Double totalIntPaye = 0d;
        Double totalInteretGenere = 0d;
        Map result = new HashMap();
        try {

            if (cycletontine != null) {

                for (Membrecycle mc : membrecycles) {

                    Double sommeCoefEpargne = 0d;
                    Double sommeDuree = 0d;

                    Double sommeEmprunt = 0d;
                    Double sommeRemboursementCapital = 0d;
                    Double sommeRemboursementInteret = 0d;
                    Double sommeEpargne = 0d;

                    for (Emprunt e : emprunts) {
                        if (mc.equals(e.getIdmembre())) {
                            sommeEmprunt += e.getMontantemp();

                            if (!e.getRembourse()) {
                                sommeRemboursementInteret += e.getCumulInteret();
                                totalInteretGenere += e.getCumulInteret();

                                if (Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur() <= 0) {
                                    sommeRemboursementInteret += 0;
                                } else {
                                    if (e.getIdtypeinteret().getIdtypeinteret().equals(2)) {
                                        Double interet = (e.getMontantRemboursable() * e.getTaux() * ((Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur()))) / 100;
                                        sommeRemboursementInteret += interet;
                                        totalInteretGenere += interet;
                                    } else {
                                        Double interet = (e.getMontantRemboursable() + e.getCumulInteret()) * Math.pow(1 + (e.getTaux() / 100), ((Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur())));
                                        interet -= (e.getMontantRemboursable() + e.getCumulInteret());
                                        //sommeRemboursementInteret += (e.getMontantRemboursable() + e.getCumulInteret()) * Math.pow(1 + (e.getTaux() / 100), ((Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur())));
                                        //sommeRemboursementInteret -= (e.getMontantRemboursable() + e.getCumulInteret());
                                        sommeRemboursementInteret += interet;
                                        totalInteretGenere += interet;
                                    }
                                }
                            }
                        }
                    }

                    for (Remboursement r : remboursements) {
                        if (mc.equals(r.getIdemprunt().getIdmembre())) {
                            if (r.getIdtyperemboursement().getId().equals(1)) {
                                sommeRemboursementCapital += r.getMontantRembourse();
                            } else {
                                sommeRemboursementInteret += r.getMontantRembourse();
                                totalInteretGenere += r.getMontantRembourse();
                            }
                        }
                    }

                    totalIntPaye += sommeRemboursementInteret;

                    for (Epargne e : epargnes) {
                        if (mc.equals(e.getIdmembrecycle())) {

                            sommeEpargne += e.getMontant();
                            Integer duree = Utilitaires.duration(e.getDateepargne(), rencontre.getDaterencontre(), cycletontine.getIdPasEmprunt().getIdpas());
                            sommeDuree += duree;

                            Double coef = e.getMontant() / cycletontine.getUniteEmprunt();
                            sommeCoefEpargne += coef;

                            Double point = (duree * coef / cycletontine.getIdPasEmprunt().getValeur());
                            totalPoint += point;
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        result.put("total_point", totalPoint);
        System.err.println("Total point : " + totalPoint);
        System.err.println("Total int generé : " + totalInteretGenere);
        System.err.println("Total int payé : " + totalIntPaye);
        result.put("total_interet", totalInteretGenere);
        return result;
    }

    public static Date prochaine_date(Date jour, int nbreJours) {
        Calendar c = Calendar.getInstance();
        c.setTime(jour);
        c.add(Calendar.DATE, nbreJours);
        return c.getTime();
    }

    public static String date_jour(Date d, Locale locale) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(d);
        DateFormat format = DateFormat.getDateInstance(DateFormat.FULL, locale);
        return format.format(calendar.getTime());
    }
}
