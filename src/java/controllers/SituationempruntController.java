/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.CalculInteret;
import entities.Cycletontine;
import entities.Emprunt;
import entities.EncoursEmprunt;
import entities.Mouchard;
import entities.Remboursement;
import entities.Rencontre;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.CalculInteretFacadeLocal;
import sessions.CycletontineFacadeLocal;
import sessions.EmpruntFacadeLocal;
import sessions.EncoursEmpruntFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.RemboursementFacadeLocal;
import sessions.RencontreFacadeLocal;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class SituationempruntController implements Serializable {

    @EJB
    private EncoursEmpruntFacadeLocal encoursEmpruntFacadeLocal;
    private List<EncoursEmprunt> encoursEmprunts = new ArrayList<>();

    @EJB
    private CycletontineFacadeLocal cycletontineFacadeLocal;
    private Cycletontine cycletontine = SessionMBean.getCycletontine();
    private List<Cycletontine> cycletontines = new ArrayList<>();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre = new Rencontre();
    private List<Rencontre> rencontres = new ArrayList<>();

    @EJB
    private CalculInteretFacadeLocal calculInteretFacadeLocal;
    private List<CalculInteret> calculInterets = new ArrayList<>();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard = new Mouchard();

    @EJB
    private EmpruntFacadeLocal empruntFacadeLocal;

    @EJB
    private RemboursementFacadeLocal remboursementFacadeLocal;

    private Date date = new Date();

    private boolean detail = true;

    private boolean showInitButton = false;
    private boolean showCreateBtn = true;
    private boolean showInitBtn = true;
    private boolean showReinitialise = true;
    private boolean showReinitialise1 = true;

    private boolean showJustifie = false;
    private boolean showHeure = false;
    private boolean showMontantPenalite = false;

    @PostConstruct
    private void init() {
        mouchard = new Mouchard();
        cycletontine = SessionMBean.getCycletontine();
    }

    public void nothing() {

    }

    public void updateData() {
        try {
            encoursEmprunts.clear();
            showInitButton = false;
            if (rencontre != null) {

                List<EncoursEmprunt> encoursEmprunts = encoursEmpruntFacadeLocal.findByrencontre(rencontre);
                if (!encoursEmprunts.isEmpty()) {
                    this.encoursEmprunts = encoursEmprunts;
                    showInitBtn = true;
                    showReinitialise1 = false;
                } else {
                    showInitBtn = false;
                    showReinitialise1 = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void generer() {
        try {

            if (rencontre != null) {

                List<Emprunt> emprunts = empruntFacadeLocal.findByCycletontine(cycletontine.getIdcycle(), false);
                List<Remboursement> remboursements = remboursementFacadeLocal.findByCycle(cycletontine);
                List<CalculInteret> calculInterets = calculInteretFacadeLocal.findByRencontre(rencontre);

                if (emprunts.isEmpty()) {
                    JsfUtil.addWarningMessage("Aucun emprunt encours");
                    return;
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
                        JsfUtil.addSuccessMessage("Opération réussie");
                    }
                    showReinitialise1 = false;
                    showInitBtn = true;
                    encoursEmprunts = encoursEmpruntFacadeLocal.findByrencontre(rencontre);
                } else {
                    JsfUtil.addErrorMessage("Veuilez calculer les interets d'abord");
                }
            } else {
                JsfUtil.addErrorMessage("Aucune rencontre sélectionnée");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addWarningMessage("Echec de l'opération");
        }
    }

    public void reinitializeInteret() {
        try {
            if (!encoursEmprunts.isEmpty()) {
                for (EncoursEmprunt e : encoursEmprunts) {
                    encoursEmpruntFacadeLocal.remove(e);
                }
            }
            encoursEmprunts.clear();
            showReinitialise1 = true;
            showInitBtn = false;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public SituationempruntController() {

    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void update() {

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

    public List<Cycletontine> getCycletontines() {
        return cycletontines;
    }

    public void setCycletontines(List<Cycletontine> cycletontines) {
        this.cycletontines = cycletontines;
    }

    public Rencontre getRencontre() {
        return rencontre;
    }

    public void setRencontre(Rencontre rencontre) {
        this.rencontre = rencontre;
    }

    public List<Rencontre> getRencontres() {
        try {
            rencontres = rencontreFacadeLocal.findByCycle(cycletontine, true);
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

    public List<CalculInteret> getCalculInterets() {
        return calculInterets;
    }

    public void setCalculInterets(List<CalculInteret> calculInterets) {
        this.calculInterets = calculInterets;
    }

    public boolean isShowInitBtn() {
        return showInitBtn;
    }

    public void setShowInitBtn(boolean showInitBtn) {
        this.showInitBtn = showInitBtn;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public boolean isShowReinitialise() {
        return showReinitialise;
    }

    public void setShowReinitialise(boolean showReinitialise) {
        this.showReinitialise = showReinitialise;
    }

    public boolean isShowReinitialise1() {
        return showReinitialise1;
    }

    public void setShowReinitialise1(boolean showReinitialise1) {
        this.showReinitialise1 = showReinitialise1;
    }

    public boolean isShowJustifie() {
        return showJustifie;
    }

    public void setShowJustifie(boolean showJustifie) {
        this.showJustifie = showJustifie;
    }

    public boolean isShowMontantPenalite() {
        return showMontantPenalite;
    }

    public void setShowMontantPenalite(boolean showMontantPenalite) {
        this.showMontantPenalite = showMontantPenalite;
    }

    public boolean isShowHeure() {
        return showHeure;
    }

    public void setShowHeure(boolean showHeure) {
        this.showHeure = showHeure;
    }

    public List<EncoursEmprunt> getEncoursEmprunts() {
        return encoursEmprunts;
    }

    public void setEncoursEmprunts(List<EncoursEmprunt> encoursEmprunts) {
        this.encoursEmprunts = encoursEmprunts;
    }

}
