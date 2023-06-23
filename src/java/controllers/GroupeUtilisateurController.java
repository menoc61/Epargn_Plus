/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Groupeutilisateur;
import entities.Mouchard;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.GroupeutilisateurFacadeLocal;
import sessions.MouchardFacadeLocal;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class GroupeUtilisateurController implements Serializable {

    /**
     * Creates a new instance of GroupeUtilisateurController
     */
    @EJB
    private GroupeutilisateurFacadeLocal groupeutilisateurFacadeLocal;
    private Groupeutilisateur groupeutilisateur;
    private List<Groupeutilisateur> groupeutilisateurs = new ArrayList<>();
    private Groupeutilisateur SelectedGroupeutilisateur;

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard;

    private boolean detail = true;

    public GroupeUtilisateurController() {

    }

    @PostConstruct
    private void init() {
        mouchard = new Mouchard();
        SelectedGroupeutilisateur = new Groupeutilisateur();
        groupeutilisateur = new Groupeutilisateur();
        mouchard = new Mouchard();
    }

    public void prepareCreate() {
        groupeutilisateur = new Groupeutilisateur();
        SelectedGroupeutilisateur = new Groupeutilisateur();
    }

    public void prepareEdit() {

    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void saveGroupeUtilisateur() {
        try {
            groupeutilisateur.setIdgroupe(groupeutilisateurFacadeLocal.nextVal());
            groupeutilisateur.setEtat(true);
            groupeutilisateur.setDatecreation(new Date());
            groupeutilisateurFacadeLocal.create(groupeutilisateur);
            mouchard.setIdoperation(mouchardFacadeLocal.nextId());
            mouchard.setAction("Enregistrement du groupe utilisateur : " + groupeutilisateur.getNom());
            mouchard.setDateaction(new Date());
            mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());

            mouchardFacadeLocal.create(mouchard);
            JsfUtil.addSuccessMessage("Groupe utilisateur enregistré");
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Echec de l'operation");
        }
    }

    public void editGoupeUtilisateur() {
        try {

            if (SelectedGroupeutilisateur.getIdgroupe() != null) {
                Groupeutilisateur gr = groupeutilisateurFacadeLocal.find(SelectedGroupeutilisateur.getIdgroupe());
                groupeutilisateurFacadeLocal.edit(SelectedGroupeutilisateur);
                mouchard.setAction("Modification du groupe utilisateur : " + gr.getNom() + "->" + " " + SelectedGroupeutilisateur.getNom());
                mouchard.setDateaction(new Date());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Groupe utilisateur mis à jour");
            } else {
                JsfUtil.addErrorMessage("veuillez selectionnez un groupe");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Echec de l'operation");
        }
    }

    public void deleteGroupeUtilsateur() {
        try {
            if (SelectedGroupeutilisateur.getIdgroupe() != null) {

                if (SelectedGroupeutilisateur.getUtilisateurList().isEmpty()) {

                    mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                    mouchard.setAction("Suppression du groupe utilisateur " + SelectedGroupeutilisateur.getNom());
                    mouchard.setDateaction(new Date());
                    mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                    groupeutilisateurFacadeLocal.remove(SelectedGroupeutilisateur);
                    mouchardFacadeLocal.create(mouchard);
                    JsfUtil.addSuccessMessage("Opération réussie");
                } else {
                    JsfUtil.addErrorMessage("des utilisateur portent ce groupe");
                }

            } else {
                JsfUtil.addErrorMessage("veuillez selectionner un groupe");
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

    public Groupeutilisateur getGroupeutilisateur() {
        return groupeutilisateur;
    }

    public void setGroupeutilisateur(Groupeutilisateur groupeutilisateur) {
        this.groupeutilisateur = groupeutilisateur;
    }

    public List<Groupeutilisateur> getGroupeutilisateurs() {
        groupeutilisateurs = groupeutilisateurFacadeLocal.findAll();
        return groupeutilisateurs;
    }

    public void setGroupeutilisateurs(List<Groupeutilisateur> groupeutilisateurs) {
        this.groupeutilisateurs = groupeutilisateurs;
    }

    public Groupeutilisateur getSelectedGroupeutilisateur() {
        return SelectedGroupeutilisateur;
    }

    public void setSelectedGroupeutilisateur(Groupeutilisateur SelectedGroupeutilisateur) {
        this.SelectedGroupeutilisateur = SelectedGroupeutilisateur;
    }

}
