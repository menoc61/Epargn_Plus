/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Cotisation;
import entities.Cycletontine;
import entities.InscriptionCotisation;
import entities.Membrecycle;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.transaction.UserTransaction;
import org.primefaces.PrimeFaces;
import org.primefaces.model.DualListModel;
import sessions.CotisationFacadeLocal;
import sessions.CycletontineFacadeLocal;
import sessions.InscriptionCotisationFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.MouchardFacadeLocal;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class InscriptionTontineController implements Serializable {

    @Resource
    private UserTransaction ut;

    @EJB
    private InscriptionCotisationFacadeLocal inscriptionCotisationFacadeLocal;
    private InscriptionCotisation inscriptionCotisation = new InscriptionCotisation();
    private List<InscriptionCotisation> inscriptionCotisations = new ArrayList<>();

    @EJB
    private CotisationFacadeLocal cotisationFacadeLocal;
    private Cotisation cotisation = new Cotisation();
    private List<Cotisation> cotisations = new ArrayList<>();

    @EJB
    private CycletontineFacadeLocal cycletontineFacadeLocal;
    private Cycletontine cycletontine = new Cycletontine();
    private List<Cycletontine> cycletontines = new ArrayList<>();

    @EJB
    private MembrecycleFacadeLocal membrecycleFacadeLocal;
    private List<Membrecycle> membrecycles = new ArrayList<>();
    private DualListModel<Membrecycle> membreDualList = new DualListModel<>();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;

    private boolean detail = true;

    @PostConstruct
    private void init() {
        cycletontine = SessionMBean.getCycletontine();
    }

    public void save() {
        try {
            ut.begin();
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
            if (!membreDualList.getTarget().isEmpty()) {
                for (Membrecycle m : membreDualList.getTarget()) {
                    List<InscriptionCotisation> ics = inscriptionCotisationFacadeLocal.findByCotisationMembre(cotisation.getIdcotisation(), m.getIdmembrecycle());
                    if (ics.isEmpty() || ics == null) {
                        InscriptionCotisation i = new InscriptionCotisation();
                        i.setIdinscription(inscriptionCotisationFacadeLocal.nextId());
                        i.setIdcotisation(cotisation);
                        i.setIdmembre(m);
                        i.setEtat(false);
                        inscriptionCotisationFacadeLocal.create(i);
                    }
                }
            }

            ut.commit();

            if (!membreDualList.getSource().isEmpty()) {
                for (Membrecycle m : membreDualList.getSource()) {
                    List<InscriptionCotisation> ics = inscriptionCotisationFacadeLocal.findByCotisationMembre(cotisation.getIdcotisation(), m.getIdmembrecycle());
                    if (!ics.isEmpty()) {
                        try {
                            inscriptionCotisationFacadeLocal.remove(ics.get(0));
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
            
            PrimeFaces.current().executeScript("PF('TontineInscCreateDialog').hide()");
            JsfUtil.addSuccessMessage("Opération réussie");

        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Exception système , verifiez le formulaire");
        }
    }

    public void edit() {
        try {
            if (inscriptionCotisation != null) {
                ut.begin();
                inscriptionCotisationFacadeLocal.edit(inscriptionCotisation);
                ut.commit();
                JsfUtil.addSuccessMessage("Opération réussie");
            } else {
                JsfUtil.addErrorMessage("Aucune ligne selectionée");
            }
        } catch (Exception e) {
            e.printStackTrace();

        }
    }

    public void delete(InscriptionCotisation i) {
        try {
            inscriptionCotisation = i;
            if (inscriptionCotisation != null) {
                ut.begin();
                inscriptionCotisationFacadeLocal.remove(inscriptionCotisation);
                ut.commit();
                JsfUtil.addSuccessMessage("Opération réussie");
            } else {
                JsfUtil.addErrorMessage("Aucune ligne sélectionnée");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Impossible de supprimes à causes des dépendances");
        }
    }

    public Integer calcul_nbreTotalarticipants(Cotisation c) {
        try {
            int som = 0;
            for (InscriptionCotisation i : inscriptionCotisationFacadeLocal.findByCotisation(c.getIdcotisation())) {
                som += 0;
            }
            return som;
        } catch (Exception ex) {
            Logger.getLogger(InscriptionTontineController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public InscriptionTontineController() {

    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void prepareCreate() {
        cycletontine = SessionMBean.getCycletontine();
        cotisation = new Cotisation();
        membreDualList = new DualListModel<>();
    }

    public void prepareDefNbreParticipation() {

        cotisation = new Cotisation(0);
        inscriptionCotisations.clear();

        PrimeFaces.current().executeScript("PF('TontineInscEditDialog').show()");
    }

    public void cancelDefNbreParticipant() {
        inscriptionCotisations.clear();

        PrimeFaces.current().executeScript("PF('TontineInscEditDialog').hide()");
    }

    public void defNbreParticipation() {
        for (InscriptionCotisation i : inscriptionCotisations) {
            inscriptionCotisationFacadeLocal.edit(i);
        }
        PrimeFaces.current().executeScript("PF('TontineInscEditDialog').hide()");
        JsfUtil.addSuccessMessage("Opération éffectuée...!");
    }

    public void updateData() {
        try {
            if (cotisation != null) {
                if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {

                    inscriptionCotisations = inscriptionCotisationFacadeLocal.findByCotisation(cotisation.getIdcotisation());

                } else {
                    inscriptionCotisations.clear();
                }
            } else {
                inscriptionCotisations.clear();
            }
        } catch (Exception ex) {
            Logger.getLogger(InscriptionTontineController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void update() {
        membreDualList = new DualListModel<>();
        try {
            if (cotisation.getIdcotisation() != null) {

                List<Membrecycle> mcs = membrecycleFacadeLocal.findByCycle(cycletontine, true);
                for (Membrecycle m : mcs) {
                    List<InscriptionCotisation> ics = inscriptionCotisationFacadeLocal.findByCotisationMembre(cotisation.getIdcotisation(), m.getIdmembrecycle());
                    if (ics.isEmpty()) {
                        membreDualList.getSource().add(m);
                    } else {
                        membreDualList.getTarget().add(m);
                    }
                }
            } else {
                System.err.println("cotisation nulle");
            }
        } catch (Exception e) {
            e.printStackTrace();
            membreDualList = new DualListModel<>();
        }
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

    public DualListModel<Membrecycle> getMembreDualList() {
        return membreDualList;
    }

    public void setMembreDualList(DualListModel<Membrecycle> membreDualList) {
        this.membreDualList = membreDualList;
    }

    public List<InscriptionCotisation> getInscriptionCotisations() {
        return inscriptionCotisations;
    }

    public void setInscriptionCotisations(List<InscriptionCotisation> inscriptionCotisations) {
        this.inscriptionCotisations = inscriptionCotisations;
    }

    public Cotisation getCotisation() {
        return cotisation;
    }

    public void setCotisation(Cotisation cotisation) {
        this.cotisation = cotisation;
    }

    public List<Cotisation> getCotisations() {
        try {
            cotisations = cotisationFacadeLocal.findBy_tontine(SessionMBean.getCycletontine().getIdtontine());
            int i = 0;
            for (Cotisation c : cotisations) {
                cotisations.get(i).setInscriptionCotisationList(inscriptionCotisationFacadeLocal.findByCotisation(c.getIdcotisation()));
                i++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cotisations;
    }

    public void setCotisations(List<Cotisation> cotisations) {
        this.cotisations = cotisations;
    }

    public InscriptionCotisation getInscriptionCotisation() {
        return inscriptionCotisation;
    }

    public void setInscriptionCotisation(InscriptionCotisation inscriptionCotisation) {
        this.inscriptionCotisation = inscriptionCotisation;
    }

}
