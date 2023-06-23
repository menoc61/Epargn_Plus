/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.CalculInteret;
import entities.Cassation;
import entities.CassationDetail;
import entities.CollecteSecours;
import entities.Cycletontine;
import entities.Emprunt;
import entities.EncoursEmprunt;
import entities.EncoursSecours;
import entities.Epargne;
import entities.FichePresence;
import entities.Membrecycle;
import entities.Mouchard;
import entities.RedevanceCotisation;
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
import sessions.CassationDetailFacadeLocal;
import sessions.CassationFacadeLocal;
import sessions.CollecteSecoursFacadeLocal;
import sessions.CycletontineFacadeLocal;
import sessions.EmpruntFacadeLocal;
import sessions.EncoursEmpruntFacadeLocal;
import sessions.EncoursSecoursFacadeLocal;
import sessions.EpargneFacadeLocal;
import sessions.FichePresenceFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.RedevanceCotisationFacadeLocal;
import sessions.RemboursementFacadeLocal;
import sessions.RencontreFacadeLocal;
import utilitaire.Utilitaires;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class FermettureRencontreController implements Serializable {

    @EJB
    private CycletontineFacadeLocal cycletontineFacadeLocal;
    private Cycletontine cycletontine = SessionMBean.getCycletontine();
    private List<Cycletontine> cycletontines = new ArrayList<>();

    @EJB
    private MembrecycleFacadeLocal membrecycleFacadeLocal;
    private Membrecycle membrecycle = new Membrecycle();
    private List<Membrecycle> membrecycles = new ArrayList<>();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre = new Rencontre();
    private List<Rencontre> rencontres = new ArrayList<>();
    private List<Rencontre> rencontres1 = new ArrayList<>();

    @EJB
    private CalculInteretFacadeLocal calculInteretFacadeLocal;
    private CalculInteret calculInteret = new CalculInteret();
    private List<CalculInteret> calculInterets = new ArrayList<>();

    @EJB
    private EncoursEmpruntFacadeLocal encoursEmpruntFacadeLocal;

    @EJB
    private EpargneFacadeLocal epargneFacadeLocal;

    @EJB
    protected CassationFacadeLocal cassationFacadeLocal;

    @EJB
    private CassationDetailFacadeLocal cassationDetailFacadeLocal;

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard = new Mouchard();

    @EJB
    private EmpruntFacadeLocal empruntFacadeLocal;

    @EJB
    private RedevanceCotisationFacadeLocal redevanceCotisationFacadeLocal;

    @EJB
    private FichePresenceFacadeLocal fichePresenceFacadeLocal;
    private Date date = new Date();

    @EJB
    private RemboursementFacadeLocal remboursementFacadeLocal;

    @EJB
    private CollecteSecoursFacadeLocal collecteSecoursFacadeLocal;

    @EJB
    private EncoursSecoursFacadeLocal encoursSecoursFacadeLocal;

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

    public void cloturer() {
        try {
            if (rencontre != null) {

                List<Emprunt> emprunts = empruntFacadeLocal.findByCycletontine(cycletontine.getIdcycle(), false);

                if (!emprunts.isEmpty()) {
                    calculInterets = calculInteretFacadeLocal.findByRencontre(rencontre);
                    if (calculInterets.isEmpty()) {
                        //JsfUtil.addWarningMessage("Veuillez calculer les interet à cette rencontre");
                        //return;
                    }
                }

                rencontre.setFermetture(true);
                rencontreFacadeLocal.edit(rencontre);
                membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine);

                //Début de la Situation des emprunts
                List<EncoursEmprunt> encoursEmprunts = encoursEmpruntFacadeLocal.findByrencontre(rencontre);
                if (!encoursEmprunts.isEmpty()) {
                    for (EncoursEmprunt e : encoursEmprunts) {
                        encoursEmpruntFacadeLocal.remove(e);
                    }
                }
                List<Remboursement> remboursements = remboursementFacadeLocal.findByCycle(cycletontine);
                Utilitaires.generateEmprunt(cycletontine, emprunts, remboursements, calculInterets, rencontre, encoursEmpruntFacadeLocal);
                // fin de la situation des emprunt

                //Début de la situation des secours
                List<CollecteSecours> collecteSecourses = collecteSecoursFacadeLocal.findByCycle(cycletontine);
                List<EncoursSecours> encoursSecourses = encoursSecoursFacadeLocal.findByrencontre(rencontre);
                if (!encoursSecourses.isEmpty()) {
                    for (EncoursSecours e : encoursSecourses) {
                        encoursSecoursFacadeLocal.remove(e);
                    }
                }
                Utilitaires.genererSecours(membrecycles, collecteSecourses, rencontre, cycletontine, encoursSecoursFacadeLocal);
                //fin de la situation des secours

                //Début de la cassation
                List<Epargne> epargnes = epargneFacadeLocal.findByCycle(cycletontine);
                List<Cassation> cassations = cassationFacadeLocal.findByCycle(cycletontine);
                List<CassationDetail> cassationDetails = cassationDetailFacadeLocal.findByCycle(cycletontine);

                if (!cassations.isEmpty()) {
                    delete_calcul(cassations, cassationDetails);
                }

                List<Emprunt> empruntCass = empruntFacadeLocal.findByCycletontine(cycletontine.getIdcycle());

                List<RedevanceCotisation> redevanceCotisations = redevanceCotisationFacadeLocal.findByCycleNotPayed(cycletontine.getIdcycle());
                List<FichePresence> fichePresences = fichePresenceFacadeLocal.findByCycleNonRegle(cycletontine.getIdcycle(), false);
                Utilitaires.cassation(cycletontine, cassations, empruntCass, membrecycles, remboursements, epargnes, cassationFacadeLocal, cassationDetailFacadeLocal, rencontre, redevanceCotisations, fichePresences);
                //Fin de la cassation

                JsfUtil.addSuccessMessage("Opération réussie");

            } else {
                JsfUtil.addErrorMessage("Aucune rencontre sélectionnée");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Echec de l'opération");
        }
    }

    public void delete_calcul(List<Cassation> cassations, List<CassationDetail> cassationDetails) {
        try {
            for (Cassation c : cassations) {
                cassationFacadeLocal.remove(c);
            }

            for (CassationDetail c : cassationDetails) {
                cassationDetailFacadeLocal.remove(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateData() {
        try {
            if (rencontre == null) {
                JsfUtil.addErrorMessage("Veuillez selectionner une rencontre");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public FermettureRencontreController() {

    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
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
            rencontres = rencontreFacadeLocal.findByCycle(cycletontine, true, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rencontres;
    }

    public void setRencontres(List<Rencontre> rencontres) {
        this.rencontres = rencontres;
    }

    public List<Rencontre> getRencontres1() {
        try {
            rencontres1 = rencontreFacadeLocal.findByCycle(cycletontine, true, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rencontres1;
    }

    public void setRencontres1(List<Rencontre> rencontres1) {
        this.rencontres1 = rencontres1;
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

    public CalculInteret getCalculInteret() {
        return calculInteret;
    }

    public void setCalculInteret(CalculInteret calculInteret) {
        this.calculInteret = calculInteret;
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

}
