/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Groupeutilisateur;
import entities.Tontine;
import entities.Utilisateur;
import entities.Utilisateurtontine;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.transaction.UserTransaction;
import sessions.GroupeutilisateurFacadeLocal;
import sessions.TontineFacadeLocal;
import sessions.UtilisateurFacadeLocal;
import sessions.UtilisateurtontineFacadeLocal;

/**
 *
 * @author USER
 */
@ManagedBean
@ViewScoped
public class UtilisateurController implements Serializable{

    /**
     * Creates a new instance of UtilisateurController
     */
    @Resource
    UserTransaction ut;
    
    @EJB
    private UtilisateurFacadeLocal utilisateurFacadeLocal;
    private Utilisateur utilisateur = new Utilisateur();
    private List<Utilisateur> utilisateurs = new ArrayList<>();
    
    @EJB
    private TontineFacadeLocal tontineFacadeLocal;
    private Tontine tontine = new Tontine();
    private List<Tontine> tontines = new ArrayList<>();
    private List<Tontine> selectedTontines = new ArrayList<>();
    
    @EJB
    private GroupeutilisateurFacadeLocal groupeutilisateurFacadeLocal;
    private Groupeutilisateur groupeutilisateur = new Groupeutilisateur();
    private List<Groupeutilisateur> groupeutilisateurs = new ArrayList<>();
    
    @EJB
    private UtilisateurtontineFacadeLocal utilisateurtontineFacadeLocal;
    
    private String mode = "";
    
    private boolean detail = true;
    
    public UtilisateurController() {
        
    }
    
    @PostConstruct
    public void init() {
        tontines.clear();
        try {
            for (Utilisateurtontine u : SessionMBean.getTontine()) {
                tontines.add(u.getIdtontine());
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
    
    public void prepareCreate() {
        mode = "Create";
        utilisateur = new Utilisateur();
        groupeutilisateur = new Groupeutilisateur();
    }
    
    public void prepareEdit() {
        mode = "Edit";
        try {
            if (utilisateur != null) {
                if (utilisateur.getIdutilisateur() != null) {
                    groupeutilisateur = utilisateur.getIdgroupeutilisateur();
                    List<Utilisateurtontine> uts = utilisateurtontineFacadeLocal.findByUtilisateur(utilisateur.getIdutilisateur());
                    selectedTontines.clear();
                    for (Utilisateurtontine u : uts) {
                        selectedTontines.add(u.getIdtontine());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void prepareDelete() {
        
    }
    
    public void save() {
        try {
            if ("Create".equals(mode)) {
                
                utilisateur.setIdutilisateur(utilisateurFacadeLocal.nextId());
                utilisateur.setIdgroupeutilisateur(groupeutilisateur);
                
                ut.begin();
                utilisateurFacadeLocal.create(utilisateur);
                
                for (Tontine t : selectedTontines) {
                    Utilisateurtontine ut = new Utilisateurtontine();
                    ut.setIdutilisateurtontine(utilisateurtontineFacadeLocal.nextId());
                    ut.setIdtontine(t);
                    ut.setIdutilisateur(utilisateur);
                    utilisateurtontineFacadeLocal.create(ut);
                }
                
                ut.commit();
                JsfUtil.addSuccessMessage("Opération réussie");
            } else {
                if (utilisateur != null) {
                    groupeutilisateur = groupeutilisateurFacadeLocal.find(groupeutilisateur.getIdgroupe());
                    ut.begin();
                    utilisateur.setIdgroupeutilisateur(groupeutilisateur);
                    utilisateurFacadeLocal.edit(utilisateur);
                    for (Tontine t : selectedTontines) {
                        List<Utilisateurtontine> uts = utilisateurtontineFacadeLocal.findByUtilisateur(utilisateur.getIdutilisateur(), t.getIdtontine());
                        if (uts.equals(null) || uts.isEmpty()) {
                            Utilisateurtontine ut = new Utilisateurtontine();
                            ut.setIdutilisateurtontine(utilisateurtontineFacadeLocal.nextId());
                            ut.setIdtontine(t);
                            ut.setIdutilisateur(utilisateur);
                            utilisateurtontineFacadeLocal.create(ut);
                        }
                    }
                    ut.commit();
                    JsfUtil.addSuccessMessage("Opération réussie");
                } else {
                    JsfUtil.addErrorMessage("Aucune ligne sélectionée");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Exception Système");
        }
    }
    
    public void delete() {
        try {
            if (utilisateur != null) {
                ut.begin();
                for (Utilisateurtontine u : utilisateurtontineFacadeLocal.findByUtilisateur(utilisateur.getIdutilisateur())) {
                    utilisateurtontineFacadeLocal.remove(u);
                }
                utilisateurFacadeLocal.remove(utilisateur);
                ut.commit();
                JsfUtil.addSuccessMessage("Opération réussie");
            } else {
                JsfUtil.addErrorMessage("Sélectionner une ligne");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Exception System");
        }
    }
    
    public Utilisateur getUtilisateur() {
        return utilisateur;
    }
    
    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }
    
    public List<Utilisateur> getUtilisateurs() {
        try {
            utilisateurs = utilisateurFacadeLocal.findAll();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return utilisateurs;
    }
    
    public void setUtilisateurs(List<Utilisateur> utilisateurs) {
        this.utilisateurs = utilisateurs;
    }
    
    public Tontine getTontine() {
        return tontine;
    }
    
    public void setTontine(Tontine tontine) {
        this.tontine = tontine;
    }
    
    public List<Tontine> getTontines() {
        return tontines;
    }
    
    public void setTontines(List<Tontine> tontines) {
        this.tontines = tontines;
    }
    
    public Groupeutilisateur getGroupeutilisateur() {
        return groupeutilisateur;
    }
    
    public void setGroupeutilisateur(Groupeutilisateur groupeutilisateur) {
        this.groupeutilisateur = groupeutilisateur;
    }
    
    public List<Groupeutilisateur> getGroupeutilisateurs() {
        try {
            groupeutilisateurs = groupeutilisateurFacadeLocal.findAll();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return groupeutilisateurs;
    }
    
    public void setGroupeutilisateurs(List<Groupeutilisateur> groupeutilisateurs) {
        this.groupeutilisateurs = groupeutilisateurs;
    }
    
    public boolean isDetail() {
        return detail;
    }
    
    public void setDetail(boolean detail) {
        this.detail = detail;
    }
    
    public List<Tontine> getSelectedTontines() {
        return selectedTontines;
    }
    
    public void setSelectedTontines(List<Tontine> selectedTontines) {
        this.selectedTontines = selectedTontines;
    }
    
}
