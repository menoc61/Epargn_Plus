/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Mouchard;
import entities.Naturecaisse;
import entities.Rubriquecaisse;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.MouchardFacadeLocal;
import sessions.NaturecaisseFacadeLocal;
import sessions.RubriquecaisseFacadeLocal;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class Rubriquecaisse1Controller implements Serializable {

    /**
     * Creates a new instance of GroupeUtilisateurController
     */
    @EJB
    private RubriquecaisseFacadeLocal rubriquecaisseFacadeLocal;
    private Rubriquecaisse rubriquecaisse;
    private List<Rubriquecaisse> rubriquecaisses = new ArrayList<>();
    private Rubriquecaisse SelectedRubriquecaisse;

    @EJB
    private NaturecaisseFacadeLocal naturecaisseFacadeLocal;
    private Naturecaisse naturecaisse;
    private List<Naturecaisse> naturecaisses = new ArrayList<>();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard;

    private boolean detail = true;

    public Rubriquecaisse1Controller() {

    }

    @PostConstruct
    private void init() {
        mouchard = new Mouchard();
        SelectedRubriquecaisse = new Rubriquecaisse();
        rubriquecaisse = new Rubriquecaisse();
        naturecaisse = new Naturecaisse();
        naturecaisses = naturecaisseFacadeLocal.findAll();
    }

    public void prepareCreate() {
        rubriquecaisse = new Rubriquecaisse();
        rubriquecaisse.setAfficher(true);
        rubriquecaisse.setEditableEnCaisse(true);
        SelectedRubriquecaisse = new Rubriquecaisse();
    }

    public void prepareEdit() {
        try {
            if (SelectedRubriquecaisse != null) {
                System.err.println("non nul");
                try {
                    naturecaisse = SelectedRubriquecaisse.getIdnaturecaisse();
                    System.err.println("nature caisse : " + naturecaisse.getNomfr());
                } catch (Exception e) {
                    e.printStackTrace();
                    naturecaisse = new Naturecaisse();
                    System.err.println("null");
                }
            }
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

    public void save() {
        try {
            Rubriquecaisse groupe = rubriquecaisseFacadeLocal.findByNom(rubriquecaisse.getNomfr());
            if (groupe == null) {
                rubriquecaisse.setIdrubriquecaisse(rubriquecaisseFacadeLocal.nextId());
                rubriquecaisse.setIdnaturecaisse(naturecaisse);
                rubriquecaisse.setModifiable(true);
                rubriquecaisse.setAfficher(true);
                rubriquecaisse.setEditableEnCaisse(true);
                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Enregistrement de la Rubrique Caisse  : " + rubriquecaisse.getNomfr());
                mouchard.setDateaction(new Date());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                rubriquecaisseFacadeLocal.create(rubriquecaisse);
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage(" La Rubrique Caisse enregistré");
            } else {
                JsfUtil.addErrorMessage("Ce nom existe deja");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void edit() {
        if (SelectedRubriquecaisse.getIdrubriquecaisse() != null) {
            naturecaisse = naturecaisseFacadeLocal.find(naturecaisse.getIdnaturecaisse());
            SelectedRubriquecaisse.setIdnaturecaisse(naturecaisse);
            rubriquecaisseFacadeLocal.edit(SelectedRubriquecaisse);
            JsfUtil.addSuccessMessage("Operation réussie");
        } else {
            JsfUtil.addErrorMessage("veuillez selectionnez une Rubrique Caisse");
        }
    }

    public void delete() {
        try {
            if (SelectedRubriquecaisse != null) {

                rubriquecaisseFacadeLocal.remove(SelectedRubriquecaisse);
                JsfUtil.addSuccessMessage("Suppression effectuée avec succès");

            } else {
                JsfUtil.addErrorMessage("Aucune device selectionnée !");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.getRubriquecaisse();
        }
    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Rubriquecaisse getRubriquecaisse() {
        return rubriquecaisse;
    }

    public void setRubriquecaisse(Rubriquecaisse rubriquecaisse) {
        this.rubriquecaisse = rubriquecaisse;
    }

    public List<Rubriquecaisse> getRubriquecaisses() {
        rubriquecaisses = rubriquecaisseFacadeLocal.findAllRangeCode();
        return rubriquecaisses;
    }

    public void setRubriquecaisses(List<Rubriquecaisse> rubriquecaisses) {
        this.rubriquecaisses = rubriquecaisses;
    }

    public Rubriquecaisse getSelectedRubriquecaisse() {
        return SelectedRubriquecaisse;
    }

    public void setSelectedRubriquecaisse(Rubriquecaisse SelectedRubriquecaisse) {
        this.SelectedRubriquecaisse = SelectedRubriquecaisse;
    }

    public Naturecaisse getNaturecaisse() {
        return naturecaisse;
    }

    public void setNaturecaisse(Naturecaisse naturecaisse) {
        this.naturecaisse = naturecaisse;
    }

    public List<Naturecaisse> getNaturecaisses() {
        naturecaisses = naturecaisseFacadeLocal.findAll();
        return naturecaisses;
    }

    public void setNaturecaisses(List<Naturecaisse> naturecaisses) {
        this.naturecaisses = naturecaisses;
    }

}
