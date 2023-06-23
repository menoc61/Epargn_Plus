/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Compteutilisateur;
import entities.Menu;
import entities.Mouchard;
import entities.Privilege;
import entities.Utilisateurtontine;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.model.DualListModel;
import sessions.CompteutilisateurFacadeLocal;
import sessions.MenuFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.PrivilegeFacadeLocal;
import sessions.UtilisateurtontineFacadeLocal;
import utilitaire.Utilitaires;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class PrivilegeController implements Serializable {

    /**
     * Creates a new instance of PrivilegeController
     */
    @EJB
    private PrivilegeFacadeLocal privilegeFacadeLocal;
    List<Privilege> privileges = new ArrayList<>();
    private DualListModel<Privilege> privilegeDualList = new DualListModel<>();

    @EJB
    private CompteutilisateurFacadeLocal compteutilisateurFacadeLocal;
    private Compteutilisateur compteutilisateur = new Compteutilisateur();
    private List<Compteutilisateur> compteutilisateurs = new ArrayList<>();

    @EJB
    private MenuFacadeLocal menuFacadeLocal;
    private DualListModel<Menu> menuDualList = new DualListModel<>();

    @EJB
    private UtilisateurtontineFacadeLocal utilisateurtontineFacadeLocal;

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard;

    private boolean detail = true;

    @PostConstruct
    private void init() {
        
        menuDualList = new DualListModel<>();
        try {
            try {
                List<Utilisateurtontine> utAll = utilisateurtontineFacadeLocal.findByTontine(SessionMBean.getCycletontine().getIdtontine().getIdtontine());
                compteutilisateurs.clear();
                for (Utilisateurtontine ut : utAll) {
                    Compteutilisateur cTemp = compteutilisateurFacadeLocal.findByUtilisateur(ut.getIdutilisateur().getIdutilisateur());
                    if (cTemp != null) {
                        compteutilisateurs.add(cTemp);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public PrivilegeController() {

    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void prepareCreate() {
        mouchard = new Mouchard();
        compteutilisateur = new Compteutilisateur();
    }


    public void prepareEdit() {

    }

    public void handleUserChange() {
        menuDualList.getSource().clear();
        menuDualList.getTarget().clear();
        try {
            if (compteutilisateur.getIdcompte() != null) {
                compteutilisateur = compteutilisateurFacadeLocal.find(compteutilisateur.getIdcompte());

                List<Privilege> privilegeTemp = privilegeFacadeLocal.findByUser(compteutilisateur.getIdcompte());
                if (privilegeTemp.isEmpty()) {
                    menuDualList.setSource(menuFacadeLocal.findAll());
                } else {

                    List<Menu> menusTarget = new ArrayList<>();

                    for (Privilege p : privilegeTemp) {
                        menusTarget.add(p.getIdmenu());
                    }

                    menuDualList.getTarget().addAll(menusTarget);
                    menuDualList.getSource().addAll(menuFacadeLocal.findAll());
                    menuDualList.getSource().removeAll(menusTarget);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void save() {
        try {
            if (compteutilisateur.getIdcompte() != null) {
                compteutilisateur = compteutilisateurFacadeLocal.find(compteutilisateur.getIdcompte());

                for (Menu m : menuDualList.getSource()) {
                    Privilege p = privilegeFacadeLocal.findByUserMenu(compteutilisateur.getIdcompte(), m.getIdmenu());
                    if (p != null) {
                        privilegeFacadeLocal.remove(p);
                        Utilitaires.saveOperation("RETRAIT DU PRIVILEGE -> " + m.getLibelle() + " à l'utilisateur -> " + compteutilisateur.getIdutilisateur().getNom() + " " + compteutilisateur.getIdutilisateur().getPrenom(), SessionMBean.getUser1(), mouchardFacadeLocal);
                    }
                }

                Boolean flag = false;
                for (Menu m : menuDualList.getTarget()) {

                    if (flag == false) {

                        if (m.getIdmenu() == 1) {
                            flag = true;
                            Privilege p = privilegeFacadeLocal.findByUserMenu(compteutilisateur.getIdcompte(), 1);
                            if (p == null) {
                                p = new Privilege();
                                p.setIdprivilege(privilegeFacadeLocal.nextId());
                                p.setIdmenu(m);
                                p.setEtat(true);
                                p.setDateattribution(new Date());
                                p.setIdcompteUtilisateur(compteutilisateur);
                                privilegeFacadeLocal.create(p);

                                Utilitaires.saveOperation("ATTRIBUTION DU PRIVILEGE : SUPER ADMINISTRATEUR à l'utilisateur -> " + compteutilisateur.getIdutilisateur().getNom() + " " + compteutilisateur.getIdutilisateur().getPrenom(), SessionMBean.getUser1(), mouchardFacadeLocal);

                                break;
                            } else {
                                JsfUtil.addSuccessMessage("Vous disposez dejà du privilège SUPER ADMINISTRATEUR");
                                break;
                            }
                        } else {
                            Privilege p = privilegeFacadeLocal.findByUserMenu(compteutilisateur.getIdcompte(), m.getIdmenu());
                            if (p == null) {
                                p = new Privilege();
                                p.setIdprivilege(privilegeFacadeLocal.nextId());
                                p.setIdmenu(m);
                                p.setIdcompteUtilisateur(compteutilisateur);
                                p.setEtat(true);
                                p.setDateattribution(new Date());
                                privilegeFacadeLocal.create(p);
                                Utilitaires.saveOperation("ATTRIBUTION DU PRIVILEGE -> " + m.getLibelle() + " à l'utilisateur -> " + compteutilisateur.getIdutilisateur().getNom() + " " + compteutilisateur.getIdutilisateur().getPrenom(), SessionMBean.getUser1(), mouchardFacadeLocal);
                            }
                        }
                    }
                }

                JsfUtil.addSuccessMessage("Opération réussie");

            } else {
                JsfUtil.addErrorMessage("Aucun utilisateur selectionné");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Echec");
        }
    }

    public void viewAccess(Compteutilisateur compteutilisateur) {
        try {
            this.compteutilisateur = compteutilisateur;
            privileges = privilegeFacadeLocal.findByUser(compteutilisateur.getIdcompte());
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Echec");
        }
    }

    public void filterPrivilegeRetrait() {
        privilegeDualList.getSource().clear();
    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public List<Privilege> getPrivileges() {
        return privileges;
    }

    public void setPrivileges(List<Privilege> privileges) {
        this.privileges = privileges;
    }

    public DualListModel<Menu> getMenuDualList() {
        return menuDualList;
    }

    public void setMenuDualList(DualListModel<Menu> menuDualList) {
        this.menuDualList = menuDualList;
    }

    public DualListModel<Privilege> getPrivilegeDualList() {
        return privilegeDualList;
    }

    public void setPrivilegeDualList(DualListModel<Privilege> privilegeDualList) {
        this.privilegeDualList = privilegeDualList;
    }

    public Compteutilisateur getCompteutilisateur() {
        return compteutilisateur;
    }

    public void setCompteutilisateur(Compteutilisateur compteutilisateur) {
        this.compteutilisateur = compteutilisateur;
    }

    public List<Compteutilisateur> getCompteutilisateurs() {
        return compteutilisateurs;
    }

    public void setCompteutilisateurs(List<Compteutilisateur> compteutilisateurs) {
        this.compteutilisateurs = compteutilisateurs;
    }

}
