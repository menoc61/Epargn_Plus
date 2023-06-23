/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Mouchard;
import entities.Pays;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.MouchardFacadeLocal;
import sessions.PaysFacadeLocal;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class PaysController {

    /**
     * Creates a new instance of GroupeUtilisateurController
     */
    @EJB
    private PaysFacadeLocal paysFacadeLocal;
    private Pays pays;
    private List<Pays> listpays = new ArrayList<>();
    private Pays SelectedPays;

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard;

    private boolean detail = true;

    public PaysController() {

    }

    @PostConstruct
    private void init() {
        mouchard = new Mouchard();
        SelectedPays = new Pays();
        pays = new Pays();
    }

    public void prepareCreate() {
        pays = new Pays();
        SelectedPays = new Pays();
    }

    public void prepareEdit() {

    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void savePays() {
        try {
            Pays groupe = paysFacadeLocal.findByNom(pays.getNomFr());
            if (groupe == null) {
                pays.setIdpays(paysFacadeLocal.nextId());
                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Enregistrement du Pays : " + pays.getNomFr());
                mouchard.setDateaction(new Date());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());                
                mouchardFacadeLocal.create(mouchard);
                paysFacadeLocal.create(pays);
                JsfUtil.addSuccessMessage("Pays enregistré");
            } else {
                JsfUtil.addErrorMessage("Ce Nom de Pays existe déja");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void editPays() {
        if (SelectedPays.getIdpays() != null) {
            Pays gr = paysFacadeLocal.find(SelectedPays.getIdpays());
            paysFacadeLocal.edit(SelectedPays);
            this.getListpays();
            JsfUtil.addSuccessMessage("Opération Réussie");
        } else {
            JsfUtil.addErrorMessage("veuillez selectionnez un Pays");
        }
    }

    public void deleteGroupeUtilsateur() {
        if (SelectedPays.getIdpays()!= null) {
                    paysFacadeLocal.remove(SelectedPays);
                    JsfUtil.addSuccessMessage("Opération réussie");
                } 
            
         else {
            JsfUtil.addErrorMessage("veuillez selectionner un Pays");
        }

    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Pays getPays() {
        return pays;
    }

    public void setPays(Pays pays) {
        this.pays = pays;
    }

    public List<Pays> getListpays() {
       listpays=paysFacadeLocal.findAll();
        return listpays;
    }

    public void setListpays(List<Pays> listpays) {
        this.listpays = listpays;
    }

    public Pays getSelectedPays() {
        return SelectedPays;
    }

    public void setSelectedPays(Pays SelectedPays) {
        this.SelectedPays = SelectedPays;
    }

    public Mouchard getMouchard() {
        return mouchard;
    }

    public void setMouchard(Mouchard mouchard) {
        this.mouchard = mouchard;
    }


}
