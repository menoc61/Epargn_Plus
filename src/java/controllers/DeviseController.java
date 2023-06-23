/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Devise;
import entities.Mouchard;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.DeviseFacadeLocal;
import sessions.MouchardFacadeLocal;

/**
 *
 * @author
 */
@ManagedBean
@ViewScoped
public class DeviseController implements Serializable{

    /**
     * Creates a new instance of DeviseController
     */
    @EJB
    private DeviseFacadeLocal deviseFacadeLocal;
    private Devise devise;
    private Devise selected;
    private List<Devise> devises = new ArrayList<>();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard;

    private boolean detail = true;

    public DeviseController() {
    }

    @PostConstruct
    private void init() {
        devise = new Devise();
        selected = new Devise();
        mouchard = new Mouchard();
    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void prepareCreate() {
        devise = new Devise();
    }

    public void prepareEdit() {

    }

    public void save() {
        try {

            devise.setIddevices(deviseFacadeLocal.nextId());
            deviseFacadeLocal.create(devise);
            mouchard.setIdoperation(mouchardFacadeLocal.nextId());
            mouchard.setAction("Enregistrement du devise -> " + devise.getNomFr());
            mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
            mouchard.setDateaction(new Date());
            mouchardFacadeLocal.create(mouchard);
            JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
            this.getDevises();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void edit() {

        try {
            if (selected.getIddevices() != null) {
                Devise u = deviseFacadeLocal.find(selected.getIddevices());
                deviseFacadeLocal.edit(selected);
                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Modification du devise -> " + u.getNomFr() + " par " + selected.getNomFr());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Le devise a été mise à jour");
            } else {
                JsfUtil.addErrorMessage("Veuillez selectionner un devise");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.getDevises();
        }
    }

    public void delete() {

        try {
            if (selected != null) {
                if (selected.getTontineList().isEmpty()) {
                    deviseFacadeLocal.remove(selected);
                    JsfUtil.addSuccessMessage("Suppression effectuée avec succès");

                } else {
                    JsfUtil.addErrorMessage("Ce devise est lié a des Tontines et ne peut etre supprimé");
                }
            } else {
                JsfUtil.addErrorMessage("Aucune device selectionnée !");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.getDevises();
        }
    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Devise getDevise() {
        return devise;
    }

    public void setDevise(Devise devise) {
        this.devise = devise;
    }

    public Devise getSelected() {
        return selected;
    }

    public void setSelected(Devise selected) {
        this.selected = selected;
    }

    public List<Devise> getDevises() {
        devises = deviseFacadeLocal.findAll();
        return devises;
    }

    public void setDevises(List<Devise> devises) {
        this.devises = devises;
    }

    public Mouchard getMouchard() {
        return mouchard;
    }

    public void setMouchard(Mouchard mouchard) {
        this.mouchard = mouchard;
    }

}
