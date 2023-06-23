/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Rubriquecaisse;
import entities.Naturecaisse;
import entities.Mouchard;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.RubriquecaisseFacadeLocal;
import sessions.NaturecaisseFacadeLocal;
import sessions.MouchardFacadeLocal;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class RubriquecaisseController {

    /**
     * Creates a new instance of RubriquecaisseController
     */
    @EJB
    private RubriquecaisseFacadeLocal rubriquecaisseFacadeLocal;
    private Rubriquecaisse rubriquecaisse;
    private Rubriquecaisse selected;
    private List<Rubriquecaisse> rubriquecaisses = new ArrayList<>();

    @EJB
    private NaturecaisseFacadeLocal naturecaisseFacadeLocal;
    private Naturecaisse naturecaisse;
    private List<Naturecaisse> naturecaisses = new ArrayList<>();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard;

    private boolean detail = true;

    public RubriquecaisseController() {

    }

    @PostConstruct
    private void init() {
        rubriquecaisse = new Rubriquecaisse();
        selected = new Rubriquecaisse();
        mouchard = new Mouchard();
        naturecaisse = new Naturecaisse();
    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void prepareCreate() {
         rubriquecaisse = new Rubriquecaisse();
        selected = new Rubriquecaisse();
    }

    

    public void prepareEdit() {
        try {
            if (selected != null) {
                if (rubriquecaisse.getIdnaturecaisse()!= null) {
                    naturecaisse = rubriquecaisse.getIdnaturecaisse();
                }
               
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void save() {
        try {
            Rubriquecaisse test = rubriquecaisseFacadeLocal.findByNom(rubriquecaisse.getNomfr());
            if (test == null) {
                rubriquecaisse.setIdrubriquecaisse(rubriquecaisseFacadeLocal.nextId());
                rubriquecaisseFacadeLocal.create(rubriquecaisse);
                mouchard.setAction("Enregistrement de l'rubriquecaisse -> " + rubriquecaisse.getNomfr());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                this.getRubriquecaisses();
                JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
            } else {
                JsfUtil.addSuccessMessage("Une région portant ce nom existe dejà");
                this.getRubriquecaisses();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void edit() {
        try {
            if (selected.getIdrubriquecaisse()!= null) {
                Rubriquecaisse r = rubriquecaisseFacadeLocal.find(selected.getIdrubriquecaisse());
                rubriquecaisseFacadeLocal.edit(selected);
                mouchard.setAction("Modification de l'rubriquecaisse ->  " + r.getNomfr()+ " -> " + selected.getNomfr());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);

                JsfUtil.addSuccessMessage("La region a été mise à jour");

            } else {
                JsfUtil.addErrorMessage("Veuillez selectionner une region");
            }
        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            this.getRubriquecaisses();
        }
    }

    public void delete() {
        try {
            if (selected.getIdrubriquecaisse()!= null) {

                rubriquecaisseFacadeLocal.remove(selected);
                mouchard.setAction("Suppression de la region : " + selected.getNomfr());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Suppression effectuée avec succès");

            } else {
                JsfUtil.addErrorMessage("Veuillez selectionner une region !");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.getNaturecaisses();
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

    public Rubriquecaisse getSelected() {
        return selected;
    }

    public void setSelected(Rubriquecaisse selected) {
        this.selected = selected;
    }

    public List<Rubriquecaisse> getRubriquecaisses() {
        rubriquecaisses = rubriquecaisseFacadeLocal.findAll();
        return rubriquecaisses;
    }

    public void setRubriquecaisses(List<Rubriquecaisse> rubriquecaisses) {
        this.rubriquecaisses = rubriquecaisses;
    }

    public Mouchard getMouchard() {
        return mouchard;
    }

    public void setMouchard(Mouchard mouchard) {
        this.mouchard = mouchard;
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
