/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Cassation;
import entities.CassationDetail;
import entities.Cycletontine;
import entities.Emprunt;
import entities.Epargne;
import entities.Membrecycle;
import entities.Remboursement;
import entities.Rencontre;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.CassationDetailFacadeLocal;
import sessions.CassationFacadeLocal;
import sessions.EmpruntFacadeLocal;
import sessions.EpargneFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.RemboursementFacadeLocal;
import sessions.RencontreFacadeLocal;
import utilitaire.Utilitaires;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class CloturesessionController implements Serializable {

    @EJB
    private CassationFacadeLocal cassationFacadeLocal;
    private List<Cassation> cassations = new ArrayList<>();

    private Cycletontine cycletontine = new Cycletontine();

    @EJB
    private MembrecycleFacadeLocal membrecycleFacadeLocal;
    private Membrecycle membrecycle = new Membrecycle();
    private List<Membrecycle> membrecycles = new ArrayList<>();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre = new Rencontre();
    private List<Rencontre> rencontres = new ArrayList<>();

    @EJB
    private CassationDetailFacadeLocal cassationDetailFacadeLocal;
    private CassationDetail cassationDetail = new CassationDetail();
    private List<CassationDetail> cassationDetails = new ArrayList<>();

    private Double totalInteretPaye = 0d;
    private Double totalEpargne = 0d;
    private Double totalEmprunt = 0d;
    private Double totalRembourse = 0d;
    private Double totalPoint = 0d;
    private Double totalPourcentage = 0d;
    private Double totalGain = 0d;
    private Double resteIntret = 0d;
    private Double resteCapital = 0d;

    @EJB
    private EmpruntFacadeLocal empruntFacadeLocal;

    @EJB
    private RemboursementFacadeLocal remboursementFacadeLocal;

    private Date dateFin = new Date();

    @EJB
    private EpargneFacadeLocal epargneFacadeLocal;

    private boolean detail = true;

    private boolean showInitButton = false;
    private boolean showCreateBtn = true;
    private boolean showInitBtn = true;
    private boolean showDeleteBtn = false;

    @PostConstruct
    private void init() {
        cycletontine = SessionMBean.getCycletontine();
        initCloture();
    }

    public void nothing() {

    }

    public void save() {

    }

    public void initCloture() {
        try {

            this.totalInteretPaye = 0d;
            this.totalEmprunt = 0d;
            this.totalGain = 0d;
            this.totalRembourse = 0d;
            this.totalPoint = 0d;
            this.totalPourcentage = 0d;
            this.totalEpargne = 0d;
            this.resteCapital = 0d;
            this.resteIntret = 0d;

            if (cycletontine != null) {
                List<CassationDetail> cassationDetails = cassationDetailFacadeLocal.findByCycle(cycletontine);
                List<Cassation> cassations = cassationFacadeLocal.findByCycle(cycletontine);
                if (cassations.isEmpty()) {
                    showInitBtn = false;
                    showDeleteBtn = true;
                } else {
                    this.cassations = cassations;
                    this.cassationDetails = cassationDetails;
                    showInitBtn = true;
                    showDeleteBtn = false;
                    if (!cassations.isEmpty()) {
                        dateFin = cassationDetails.get(0).getDateCalcul();
                    }

                    for (Cassation c : cassations) {
                        //montant interet payé
                        this.totalInteretPaye += c.getMontantInteret();
                        this.totalEmprunt += c.getMontantEmprunte();
                        this.totalGain += c.getMontantGain();
                        this.totalRembourse += c.getMontantRembourse();
                        this.totalPoint += c.getNombrePoint();
                        this.totalPourcentage += c.getPourcentageGain();
                        this.totalEpargne += c.getMontantEpargne();
                        this.resteCapital += c.getResteCapital();
                        this.resteIntret += c.getResteInteret();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void calculCloture() {
        try {

            this.totalInteretPaye = 0d;
            this.totalEmprunt = 0d;
            this.totalGain = 0d;
            this.totalRembourse = 0d;
            this.totalPoint = 0d;
            this.totalPourcentage = 0d;
            this.totalEpargne = 0d;
            this.resteCapital = 0d;
            this.resteIntret = 0d;

            if (cycletontine != null) {
                cassations.clear();
                cassationDetails.clear();
                List<Cassation> cassations = cassationFacadeLocal.findByCycle(cycletontine);
                if (cassations.isEmpty()) {

                    List<Membrecycle> membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine);
                    List<Emprunt> emprunts = empruntFacadeLocal.findByCycletontine(cycletontine.getIdcycle());
                    List<Remboursement> remboursements = remboursementFacadeLocal.findByCycle(cycletontine);
                    List<Epargne> epargnes = epargneFacadeLocal.findByCycle(cycletontine);

                    for (Membrecycle mc : membrecycles) {

                        Cassation c = new Cassation();

                        Double totalPoint = 0d;
                        Double totalCoefEpargne = 0d;
                        Double totalDuree = 0d;
                        Double resteCaptital = 0d;
                        Double resteInteret = 0d;

                        c.setId(cassationFacadeLocal.nextId());
                        c.setIdcycle(cycletontine);
                        c.setIdmembre(mc);
                        c.setMontantEpargne(0d);
                        c.setMontantGain(0d);
                        c.setNombrePoint(0d);

                        Double sommeEmprunt = 0d;
                        Double sommeRemboursement = 0d;
                        Double sommeInteret = 0d;
                        Double sommeEpargne = 0d;

                        for (Emprunt e : emprunts) {
                            if (mc.equals(e.getIdmembre())) {
                                sommeEmprunt += e.getMontantemp();
                                resteCaptital += e.getMontantRemboursable();

                                resteInteret += e.getCumulInteret();

                                //on va ajouteur une instruction ici
                                if (!e.getRembourse()) {
                                    if (Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur() <= 0) {
                                        resteInteret += 0;
                                    } else {
                                        if (e.getIdtypeinteret().getIdtypeinteret().equals(2)) {
                                            resteInteret += (e.getMontantRemboursable() * e.getTaux() * ((Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur()))) / 100;
                                        } else {
                                            resteInteret += (e.getMontantRemboursable() + e.getCumulInteret()) * Math.pow(1 + (e.getTaux() / 100), ((Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur())));
                                            resteInteret -= (e.getMontantRemboursable() + e.getCumulInteret());
                                        }
                                    }
                                }
                            }
                        }

                        for (Remboursement r : remboursements) {
                            if (mc.equals(r.getIdemprunt().getIdmembre())) {
                                if (r.getIdtyperemboursement().getId().equals(1)) {
                                    sommeRemboursement += r.getMontantRembourse();
                                } else {
                                    sommeInteret += r.getMontantRembourse();
                                }
                            }
                        }

                        this.totalInteretPaye += sommeInteret;

                        for (Epargne e : epargnes) {
                            if (mc.equals(e.getIdmembrecycle())) {

                                sommeEpargne += e.getMontant();
                                //on enregistre le detail de la cassation
                                cassationDetail = new CassationDetail();
                                cassationDetail.setId(cassationDetailFacadeLocal.nextId());
                                cassationDetail.setIdcycle(cycletontine);
                                cassationDetail.setIdmembre(mc);
                                cassationDetail.setDateEpargne(e.getIdrencontre().getDaterencontre());
                                cassationDetail.setDateCalcul(dateFin);
                                cassationDetail.setMontant(e.getMontant());

                                Integer duree = Utilitaires.duration(e.getDateepargne(), dateFin, cycletontine.getIdPasEmprunt().getIdpas());
                                totalDuree += duree;

                                Double coef = e.getMontant() / cycletontine.getUniteEmprunt();
                                totalCoefEpargne += coef;

                                Double point = duree * coef / cycletontine.getIdPasEmprunt().getValeur();
                                totalPoint += point;

                                cassationDetail.setDuree(duree.doubleValue());

                                cassationDetail.setNombrePoint(point);
                                cassationDetail.setCoefEpargne(e.getMontant() / cycletontine.getUniteEmprunt());
                                cassationDetailFacadeLocal.create(cassationDetail);

                                this.cassationDetails.add(cassationDetail);
                            }
                        }

                        c.setMontantInteret(sommeInteret);
                        c.setMontantRembourse(sommeRemboursement);
                        c.setMontantEpargne(sommeEpargne);
                        c.setMontantEmprunte(sommeEmprunt);

                        totalCoefEpargne = sommeEpargne / cycletontine.getUniteEmprunt();

                        c.setCoefEpargne(totalCoefEpargne);
                        c.setDuree(totalDuree);
                        c.setNombrePoint(totalPoint);
                        c.setPourcentageGain((totalPoint * 100) / (Double) calcul_totalpoint(membrecycles, emprunts, remboursements, epargnes).get("total_point"));
                        c.setMontantGain((c.getPourcentageGain() * (Double) calcul_totalpoint(membrecycles, emprunts, remboursements, epargnes).get("total_interet")) / 100);
                        c.setResteCapital(resteCaptital);
                        c.setResteInteret(resteInteret);

                        this.totalEmprunt += sommeEmprunt;
                        this.totalGain += c.getMontantGain();
                        this.totalRembourse += sommeRemboursement;
                        this.totalPoint += totalPoint;
                        this.totalPourcentage += c.getPourcentageGain();
                        this.totalEpargne += sommeEpargne;
                        this.resteCapital += c.getResteCapital();
                        this.resteIntret += c.getResteInteret();

                        this.cassations.add(c);

                        cassationFacadeLocal.create(c);
                    }

                    showInitBtn = true;
                    showDeleteBtn = false;
                } else {
                    this.cassations = cassations;
                    showInitBtn = true;
                    showDeleteBtn = false;
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete_calcul() {
        try {

            for (Cassation c : cassations) {
                cassationFacadeLocal.remove(c);
            }

            for (CassationDetail c : cassationDetails) {
                cassationDetailFacadeLocal.remove(c);
            }
            cassations.clear();
            cassationDetails.clear();

            showInitBtn = false;
            showDeleteBtn = true;

            JsfUtil.addSuccessMessage("Operation réussie");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Map calcul_totalpoint(List<Membrecycle> membrecycles, List<Emprunt> emprunts, List<Remboursement> remboursements, List<Epargne> epargnes) {
        Double total = 0d;
        Double sommeInt = 0d;
        Map result = new HashMap();
        try {

            if (cycletontine != null) {

                for (Membrecycle mc : membrecycles) {

                    Cassation c = new Cassation();

                    Double totalPoint = 0d;
                    Double totalCoefEpargne = 0d;
                    Double totalDuree = 0d;

                    c.setMontantEpargne(0d);
                    c.setMontantGain(0d);
                    c.setNombrePoint(0d);

                    Double sommeEmprunt = 0d;
                    Double sommeRemboursement = 0d;
                    Double sommeInteret = 0d;
                    Double sommeEpargne = 0d;

                    for (Emprunt e : emprunts) {
                        if (mc.equals(e.getIdmembre())) {
                            sommeEmprunt += e.getMontantemp();
                        }
                    }

                    for (Remboursement r : remboursements) {
                        if (mc.equals(r.getIdemprunt().getIdmembre())) {
                            if (r.getIdtyperemboursement().getId().equals(1)) {
                                sommeRemboursement += r.getMontantRembourse();
                            } else {
                                sommeInteret += r.getMontantRembourse();
                            }
                        }
                    }

                    sommeInt += sommeInteret;

                    for (Epargne e : epargnes) {
                        if (mc.equals(e.getIdmembrecycle())) {

                            sommeEpargne += e.getMontant();
                            cassationDetail.setMontant(e.getMontant());

                            Integer duree = Utilitaires.duration(e.getDateepargne(), dateFin, cycletontine.getIdPasEmprunt().getIdpas());
                            totalDuree += duree;

                            Double coef = e.getMontant() / cycletontine.getUniteEmprunt();
                            totalCoefEpargne += coef;

                            Double point = duree * coef / cycletontine.getIdPasEmprunt().getValeur();
                            totalPoint += point;
                        }
                    }
                    total += totalPoint;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        result.put("total_point", total);
        result.put("total_interet", sommeInt);
        return result;
    }

    public CloturesessionController() {

    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void prepareCreate() {

    }

    public void prepareRetrait() {

    }

    public void prepareEdit() {

    }

    public void filterGroupeMenu() {

    }

    public void filterPrivilegeRetrait() {

    }

    public void savePrivilege() {

    }

    public void retraitPrivilege() {

    }

    public void editPrivilege() {

    }

    public void deletePrivilege() {

    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Cycletontine getCycletontine() {
        return cycletontine;
    }

    public void setCycletontine(Cycletontine cycletontine) {
        this.cycletontine = cycletontine;
    }

    public Membrecycle getMembrecycle() {
        return membrecycle;
    }

    public void setMembrecycle(Membrecycle membrecycle) {
        this.membrecycle = membrecycle;
    }

    public List<Membrecycle> getMembrecycles() {
        try {
            membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return membrecycles;
    }

    public void setMembrecycles(List<Membrecycle> membrecycles) {
        this.membrecycles = membrecycles;
    }

    public Rencontre getRencontre() {
        return rencontre;
    }

    public void setRencontre(Rencontre rencontre) {
        this.rencontre = rencontre;
    }

    public List<Rencontre> getRencontres() {
        try {
            rencontres = rencontreFacadeLocal.findByCycleCotisation(cycletontine , false);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rencontres;
    }

    public void setRencontres(List<Rencontre> rencontres) {
        this.rencontres = rencontres;
    }

    public boolean isShowInitButton() {
        return showInitButton;
    }

    public void setShowInitButton(boolean showInitButton) {
        this.showInitButton = showInitButton;
    }

    public boolean isShowCreateBtn() {
        return showCreateBtn;
    }

    public void setShowCreateBtn(boolean showCreateBtn) {
        this.showCreateBtn = showCreateBtn;
    }

    public boolean isShowInitBtn() {
        return showInitBtn;
    }

    public void setShowInitBtn(boolean showInitBtn) {
        this.showInitBtn = showInitBtn;
    }

    public List<Cassation> getCassations() {
        return cassations;
    }

    public void setCassations(List<Cassation> cassations) {
        this.cassations = cassations;
    }

    public Date getDateFin() {
        return dateFin;
    }

    public void setDateFin(Date dateFin) {
        this.dateFin = dateFin;
    }

    public List<CassationDetail> getCassationDetails() {
        return cassationDetails;
    }

    public void setCassationDetails(List<CassationDetail> cassationDetails) {
        this.cassationDetails = cassationDetails;
    }

    public boolean isShowDeleteBtn() {
        return showDeleteBtn;
    }

    public void setShowDeleteBtn(boolean showDeleteBtn) {
        this.showDeleteBtn = showDeleteBtn;
    }

    public Double getTotalInteretPaye() {
        return totalInteretPaye;
    }

    public Double getTotalEpargne() {
        return totalEpargne;
    }

    public Double getTotalEmprunt() {
        return totalEmprunt;
    }

    public Double getTotalRembourse() {
        return totalRembourse;
    }

    public Double getTotalPoint() {
        return totalPoint;
    }

    public Double getTotalPourcentage() {
        return totalPourcentage;
    }

    public Double getTotalGain() {
        return totalGain;
    }

    public Double getResteIntret() {
        return resteIntret;
    }

    public Double getResteCapital() {
        return resteCapital;
    }

}
