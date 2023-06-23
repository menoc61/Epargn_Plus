/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Recette;
import entities.Caisse;
import entities.Cycletontine;
import entities.Rencontre;
import entities.Mouchard;
import entities.Naturecaisse;
import entities.Rubriquecaisse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.transaction.UserTransaction;
import sessions.RecetteFacadeLocal;
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
public class RecetteController {

    @Resource
    private UserTransaction ut;

    /**
     * Creates a new instance of RecetteController
     */
    @EJB
    private RecetteFacadeLocal recetteFacadeLocal;
    private Recette recette;
    private Recette selected;
    private List<Recette> recettes = new ArrayList<>();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre;
    private List<Rencontre> rencontres = new ArrayList<>();

    @EJB
    private CycletontineFacadeLocal cycletontineFacadeLocal;
    private Cycletontine cycletontine;
    private List<Cycletontine> cycletontines = new ArrayList<>();

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

    public RecetteController() {

    }

    @PostConstruct
    private void init() {
        recette = new Recette();
        selected = new Recette();
        mouchard = new Mouchard();
        cycletontine = new Cycletontine();
        rencontre = new Rencontre();
        rubriquecaisse = new Rubriquecaisse();
        cycletontine = SessionMBean.getCycletontine();
        try {
            //rencontres = rencontreFacadeLocal.findByCycle(cycletontine, true, false);
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
        recette = new Recette();
        rencontre = new Rencontre();

    }

    public void prepareEdit() {
        mode = "Edit";
        try {
            cycletontines = cycletontineFacadeLocal.findAll();
            if (recette != null) {
                if (recette.getIdrencontre() != null) {
                    rencontre = recette.getIdrencontre();
                }

                if (recette.getIdrubrique() != null) {
                    rubriquecaisse = recette.getIdrubrique();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void updateDate() {
        try {
            if (rencontre != null) {
                recette.setDate(rencontre.getDaterencontre());
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
                caisse.setLibelleoperation("Enregistrement de la recette -> " + recette.getObservation());
                caisse.setMontant(recette.getMontant());
                caisse.setIdrencontre(rencontre);
                caisse.setIdrubriquecaisse(recette.getIdrubrique());
                caisseFacadeLocal.create(caisse);

                recette.setIdrecette(recetteFacadeLocal.nextId());
                recette.setIdcycle(SessionMBean.getCycletontine());
                recette.setIdrencontre(rencontre);
                recette.setIdcaisse(caisse);
                recetteFacadeLocal.create(recette);

                ut.commit();

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Enregistrement de la recette  -> " + recette.getObservation());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);

                JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");

            } else {
                if (recette != null) {

                    ut.begin();

                    caisse = recette.getIdcaisse();
                    caisse.setLibelleoperation(recette.getObservation());
                    caisse.setMontant(recette.getMontant());
                    caisse.setIdrubriquecaisse(recette.getIdrubrique());
                    caisseFacadeLocal.edit(caisse);
                    recetteFacadeLocal.edit(recette);

                    recetteFacadeLocal.edit(recette);

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
            if (recette != null) {

                ut.begin();

                recetteFacadeLocal.remove(recette);
                caisseFacadeLocal.remove(recette.getIdcaisse());

                ut.commit();

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Suppression de la recette -> " + recette.getObservation());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Suppression effectuée avec succès");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void filtreRecette() {

    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Recette getRecette() {
        return recette;
    }

    public void setRecette(Recette recette) {
        this.recette = recette;
    }

    public Recette getSelected() {
        return selected;
    }

    public void setSelected(Recette selected) {
        this.selected = selected;
    }

    public List<Recette> getRecettes() {
        try {
            if (SessionMBean.getCycletontine() != null) {
                recettes = recetteFacadeLocal.findByCycletontine(SessionMBean.getCycletontine().getIdcycle());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return recettes;
    }

    public void setRecettes(List<Recette> recettes) {
        this.recettes = recettes;
    }

    public Cycletontine getCycletontine() {
        return cycletontine;
    }

    public void setCycletontine(Cycletontine cycletontine) {
        this.cycletontine = cycletontine;
    }

    public List<Cycletontine> getCycletontines() {
        cycletontines = cycletontineFacadeLocal.findAll();
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
            rubriquecaisses = rubriquecaisseFacadeLocal.findByNaturecaisse(2);
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
