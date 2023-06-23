/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
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
import sessions.MouchardFacadeLocal;
import sessions.RencontreFacadeLocal;
import utilitaire.Utilitaires;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class RencontreController implements Serializable {

    /**
     * Creates a new instance of GroupeUtilisateurController
     */
    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre = new Rencontre();
    private List<Rencontre> listrencontre = new ArrayList<>();
    private Rencontre SelectedRencontre = new Rencontre();
    
    private boolean renderedOF = false;
    
    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard;
    
    private boolean detail = true;
    
    public RencontreController() {
        
    }
    
    @PostConstruct
    private void init() {
        mouchard = new Mouchard();
        SelectedRencontre = new Rencontre();
        rencontre = new Rencontre();
    }
    
    public void prepareCreate() {
        rencontre = new Rencontre();
        SelectedRencontre = new Rencontre();
        rencontre.setOuvertureRencontre(false);
        rencontre.setFermetture(false);
        renderedOF = true;
    }
    
    public void prepareEdit() {
        renderedOF = false;
    }
    
    public void activeButton() {
        detail = false;
    }
    
    public void deactiveButton() {
        detail = true;
    }
    
    public void saveRencontre() {
        try {
            rencontre.setIdrencontre(rencontreFacadeLocal.nextId());
            rencontre.setIdcycle(SessionMBean.getCycletontine());
            rencontre.setIdTontine(SessionMBean.getCycletontine().getIdtontine());
            rencontre.setOuvertureRencontre(false);
            rencontre.setFermetture(false);
            rencontre.setIsRencontreCotisation(false);
            rencontreFacadeLocal.create(rencontre);
            Utilitaires.saveOperation("Enregistrement du Rencontre : " + rencontre.getNomfr(), SessionMBean.getUser1(), mouchardFacadeLocal);
            JsfUtil.addSuccessMessage("Rencontre enregistré");
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Exception systeme : controllez le formulaire");
        }
    }
    
    public void editRencontre() {
        try {
            if (SelectedRencontre.getIdrencontre() != null) {
                rencontre.setIdcycle(SessionMBean.getCycletontine());
                rencontreFacadeLocal.edit(SelectedRencontre);
                this.getListrencontre();
                JsfUtil.addSuccessMessage("Opération Réussie");
            } else {
                JsfUtil.addErrorMessage("veuillez selectionnez un Rencontre");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Exception systeme : controllez le formulaire");
        }
    }
    
    public void delete() {
        try {
            if (SelectedRencontre.getIdrencontre() != null) {
                rencontreFacadeLocal.remove(SelectedRencontre);
                JsfUtil.addSuccessMessage("Opération réussie");
            } else {
                JsfUtil.addErrorMessage("veuillez selectionner un Rencontre");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Echec de l'operation");
        }
    }
    
    public boolean isDetail() {
        return detail;
    }
    
    public void setDetail(boolean detail) {
        this.detail = detail;
    }
    
    public Rencontre getRencontre() {
        return rencontre;
    }
    
    public void setRencontre(Rencontre rencontre) {
        this.rencontre = rencontre;
    }
    
    public List<Rencontre> getListrencontre() {
        listrencontre = rencontreFacadeLocal.findByCycleCotisation(SessionMBean.getCycletontine(), false);
        return listrencontre;
    }
    
    public void setListrencontre(List<Rencontre> listrencontre) {
        this.listrencontre = listrencontre;
    }
    
    public Rencontre getSelectedRencontre() {
        return SelectedRencontre;
    }
    
    public void setSelectedRencontre(Rencontre SelectedRencontre) {
        this.SelectedRencontre = SelectedRencontre;
    }
    
    public Mouchard getMouchard() {
        return mouchard;
    }
    
    public void setMouchard(Mouchard mouchard) {
        this.mouchard = mouchard;
    }
    
    public boolean isRenderedOF() {
        return renderedOF;
    }
    
    public void setRenderedOF(boolean renderedOF) {
        this.renderedOF = renderedOF;
    }
    
}
