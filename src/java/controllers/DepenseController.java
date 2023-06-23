/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Depense;
import entities.Caisse;
import entities.Cycletontine;
import entities.Rencontre;
import entities.Mouchard;
import entities.Naturecaisse;
import entities.Rubriquecaisse;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.transaction.UserTransaction;
import sessions.DepenseFacadeLocal;
import sessions.CaisseFacadeLocal;
import sessions.CycletontineFacadeLocal;
import sessions.RencontreFacadeLocal;
import sessions.RubriquecaisseFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.NaturecaisseFacadeLocal;

/**
 *
 * @author Abdel Beininfo
 */
@ManagedBean
@ViewScoped
public class DepenseController implements Serializable {

    @Resource
    private UserTransaction ut;

    /**
     * Creates a new instance of DepenseController
     */
    @EJB
    private DepenseFacadeLocal depenseFacadeLocal;
    private Depense depense = new Depense();
    private List<Depense> depenses = new ArrayList<>();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre;
    private List<Rencontre> rencontres = new ArrayList<>();

    @EJB
    private CycletontineFacadeLocal cycletontineFacadeLocal;
    private Cycletontine cycletontine;

    @EJB
    private RubriquecaisseFacadeLocal rubriquecaisseFacadeLocal;
    private Rubriquecaisse rubriquecaisse;
    private List<Rubriquecaisse> rubriquecaisses = new ArrayList<>();

    @EJB
    private NaturecaisseFacadeLocal naturecaisseFacadeLocal;
    private Naturecaisse naturecaisse;
    private List<Naturecaisse> naturecaisses = new ArrayList<>();

    @EJB
    private CaisseFacadeLocal caisseFacadeLocal;
    private Caisse caisse = new Caisse();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard;

    private boolean detail = true;

    private String mode = "";

    public DepenseController() {

    }

    @PostConstruct
    private void init() {
        depense = new Depense();
        mouchard = new Mouchard();
        cycletontine = new Cycletontine();
        rencontre = new Rencontre();
        rubriquecaisse = new Rubriquecaisse();
        cycletontine = SessionMBean.getCycletontine();

        try {
            rencontres = rencontreFacadeLocal.findByCycle(cycletontine, true);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void prepareCreate() {
        mode = "Create";
        depense = new Depense();
        rencontre = new Rencontre();

    }

    public void prepareEdit() {
        mode = "Edit";
        try {
            if (depense != null) {
                if (depense.getIdrencontre() != null) {
                    rencontre = depense.getIdrencontre();
                }

                if (depense.getIdrubriquecaisse() != null) {
                    rubriquecaisse = depense.getIdrubriquecaisse();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void updateDate() {
        try {
            if (rencontre != null) {
                depense.setDate(rencontre.getDaterencontre());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void save() {
        try {

            if ("Create".equals(mode)) {

                ut.begin();

                caisse.setIdcaisse(caisseFacadeLocal.nextId());
                caisse.setDateoperation(rencontre.getDaterencontre());
                caisse.setIdcycle(cycletontine);
                caisse.setLibelleoperation("Enregistrement de la depense -> " + depense.getObservation());
                caisse.setMontant(depense.getMontant());
                caisse.setIdrencontre(rencontre);
                caisse.setIdrubriquecaisse(depense.getIdrubriquecaisse());
                caisseFacadeLocal.create(caisse);

                depense.setIddepense(depenseFacadeLocal.nextId());
                depense.setIdcycle(SessionMBean.getCycletontine());
                depense.setIdrencontre(rencontre);
                depense.setIdcaisse(caisse);
                depenseFacadeLocal.create(depense);

                ut.commit();

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Enregistrement de la dépense  -> " + depense.getObservation());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);

                JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
            } else {
                if (depense != null) {

                    ut.begin();

                    caisse = depense.getIdcaisse();
                    caisse.setIdrubriquecaisse(depense.getIdrubriquecaisse());
                    caisse.setMontant(caisse.getMontant());
                    caisse.setLibelleoperation(depense.getObservation());
                    caisseFacadeLocal.edit(caisse);

                    depenseFacadeLocal.edit(depense);

                    ut.commit();
                    JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");

                } else {
                    JsfUtil.addErrorMessage("Aucune selectionnée");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete() {
        try {
            if (depense != null) {

                ut.begin();
                depenseFacadeLocal.remove(depense);
                caisseFacadeLocal.remove(depense.getIdcaisse());
                ut.commit();

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Suppression de la dépense -> " + depense.getObservation());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Suppression effectuée avec succès");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Depense getDepense() {
        return depense;
    }

    public void setDepense(Depense depense) {
        this.depense = depense;
    }

    public List<Depense> getDepenses() {
        try {
            if (SessionMBean.getCycletontine() != null) {
                depenses = depenseFacadeLocal.findByCycletontine(SessionMBean.getCycletontine().getIdcycle());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return depenses;
    }

    public void setDepenses(List<Depense> depenses) {
        this.depenses = depenses;
    }

    public Cycletontine getCycletontine() {
        return cycletontine;
    }

    public void setCycletontine(Cycletontine cycletontine) {
        this.cycletontine = cycletontine;
    }

    public Rencontre getRencontre() {
        return rencontre;
    }

    public void setRencontre(Rencontre rencontre) {
        this.rencontre = rencontre;
    }

    public List<Rencontre> getRencontres() {
        return rencontres;
    }

    public void setRencontre(List<Rencontre> rencontres) {
        this.rencontres = rencontres;
    }

    public Rubriquecaisse getRubriquecaisse() {
        return rubriquecaisse;
    }

    public void setRubriquecaisse(Rubriquecaisse rubriquecaisse) {
        this.rubriquecaisse = rubriquecaisse;
    }

    public List<Rubriquecaisse> getRubriquecaisses() {
        try {
            rubriquecaisses = rubriquecaisseFacadeLocal.findByNaturecaisse(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rubriquecaisses;
    }

    public void setRubriquecaisses(List<Rubriquecaisse> rubriquecaisses) {
        this.rubriquecaisses = rubriquecaisses;
    }

    public Caisse getCaisse() {
        return caisse;
    }

    public void setCaisse(Caisse caisse) {
        this.caisse = caisse;
    }

    public Naturecaisse getNaturecaisse() {
        return naturecaisse;
    }

    public void setNaturecaisse(Naturecaisse naturecaisse) {
        this.naturecaisse = naturecaisse;
    }

    public List<Naturecaisse> getNaturecaisses() {
        return naturecaisses;
    }

    public void setNaturecaisses(List<Naturecaisse> naturecaisses) {
        this.naturecaisses = naturecaisses;
    }

}
