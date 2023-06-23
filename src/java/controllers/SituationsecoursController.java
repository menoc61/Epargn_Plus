/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.CollecteSecours;
import entities.Cycletontine;
import entities.EncoursSecours;
import entities.Membrecycle;
import entities.Mouchard;
import entities.Rencontre;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.CollecteSecoursFacadeLocal;
import sessions.CycletontineFacadeLocal;
import sessions.EmpruntFacadeLocal;
import sessions.EncoursSecoursFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.RemboursementFacadeLocal;
import sessions.RencontreFacadeLocal;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class SituationsecoursController implements Serializable {

    @EJB
    private EncoursSecoursFacadeLocal encoursSecoursFacadeLocal;
    private List<EncoursSecours> encoursSecourses = new ArrayList<>();

    @EJB
    private MembrecycleFacadeLocal membrecycleFacadeLocal;
    private List<Membrecycle> membrecycles = new ArrayList<>();

    @EJB
    private CycletontineFacadeLocal cycletontineFacadeLocal;
    private Cycletontine cycletontine = new Cycletontine();
    private List<Cycletontine> cycletontines = new ArrayList<>();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre = new Rencontre();
    private List<Rencontre> rencontres = new ArrayList<>();

    @EJB
    protected CollecteSecoursFacadeLocal collecteSecoursFacadeLocal;
    protected List<CollecteSecours> collecteSecourses = new ArrayList<>();

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
            encoursSecourses.clear();
            showInitButton = false;
            if (rencontre != null) {
                List<EncoursSecours> encoursSecourses = encoursSecoursFacadeLocal.findByrencontre(rencontre);

                if (!encoursSecourses.isEmpty()) {
                    this.encoursSecourses = encoursSecourses;
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

                collecteSecourses = collecteSecoursFacadeLocal.findByCycle(cycletontine);
                membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine);
                List<EncoursSecours> encoursSecourses = encoursSecoursFacadeLocal.findByrencontre(rencontre);

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
                        
                        System.err.println("Reste du membre : "+ ( cycletontine.getMontantSecours() - mc.getMontantSecours()) );
                        
                        temp.setEncours(cycletontine.getMontantSecours() - mc.getMontantSecours() + montant_cotise);
                        temp.setReste(cycletontine.getMontantSecours() - mc.getMontantSecours());
                        
                        if(temp.getReste()==0d){
                            temp.setObservation("Fond complet");
                        }else{
                            temp.setObservation("Fond cotisé à "+((mc.getMontantSecours() *100) / cycletontine.getMontantSecours())+"%");
                        }
                        encoursSecoursFacadeLocal.create(temp);
                    }
                    JsfUtil.addSuccessMessage("Opération réussie");
                    showReinitialise1 = false;
                    showInitBtn = true;
                    this.encoursSecourses = encoursSecoursFacadeLocal.findByrencontre(rencontre);
                } else {
                    JsfUtil.addErrorMessage("Le systeme n'a aucun emprunt en cours ou le calcul d'interet n'est pas encore effectué");
                }
            } else {
                JsfUtil.addErrorMessage("Aucune rencontre sélectionnée");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void reinitialize() {
        try {
            if (!encoursSecourses.isEmpty()) {
                for (EncoursSecours e : encoursSecourses) {
                    encoursSecoursFacadeLocal.remove(e);
                }
            }
            JsfUtil.addSuccessMessage("Opération réussie");
            encoursSecourses.clear();
            showReinitialise1 = true;
            showInitBtn = false;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public SituationsecoursController() {

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

    public List<EncoursSecours> getEncoursSecourses() {
        return encoursSecourses;
    }

    public void setEncoursSecourses(List<EncoursSecours> encoursSecourses) {
        this.encoursSecourses = encoursSecourses;
    }

    public List<Membrecycle> getMembrecycles() {
        return membrecycles;
    }

    public void setMembrecycles(List<Membrecycle> membrecycles) {
        this.membrecycles = membrecycles;
    }

}
