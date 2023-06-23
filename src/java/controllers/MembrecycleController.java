/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Cycletontine;
import entities.Membre;
import entities.Membrecycle;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.model.DualListModel;
import sessions.CycletontineFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.MembreFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import utilitaire.Utilitaires;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class MembrecycleController implements Serializable{

    @EJB
    private MembrecycleFacadeLocal membrecycleFacadeLocal;
    private Membrecycle privilige;
    private List<Membrecycle> privileges = new ArrayList<>();
    private DualListModel<Membrecycle> privilegeDualList = new DualListModel<>();

    @EJB
    private MembreFacadeLocal membreFacadeLocal;
    private Membre membre;
    private List<Membre> membres = new ArrayList<>();

    

    @EJB
    private CycletontineFacadeLocal cycleFacadeLocal;
    private Cycletontine cycle;
    private List<Cycletontine> cycles = new ArrayList<>();
    private DualListModel<Cycletontine> dualList = new DualListModel<>();

    private boolean detail = true;

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;

    /**
     * Creates a new instance of PrivilegeCycleController
     */
    public MembrecycleController() {

    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void prepareCreate() {
        try {
            membre = new Membre();
            dualList.getSource().clear();
            dualList.getTarget().clear();
            privilige = new Membrecycle();
            cycles.clear();
            privilegeDualList.getSource().clear();
            privilegeDualList.getTarget().clear();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void prepareEdit() {
        
    }

    public void save() {
        try {
            if (membre != null) {
                if (!dualList.getTarget().isEmpty()) {
                    for (Cycletontine d : dualList.getTarget()) {
                        Membrecycle membrecycleTemp = membrecycleFacadeLocal.findByMembreCycle(membre.getIdmembre(), d.getIdcycle());
                        if (membrecycleTemp == null) {
                            privilige.setIdmembrecycle(membrecycleFacadeLocal.nextId());
                            privilige.setIdcycle(d);
                            privilige.setIdmembre(membre);
                            membrecycleFacadeLocal.create(privilige);
                            Utilitaires.saveOperation("Permission d'accès au cycle -> " + d.getNomfr()+ " A l'membre -> " + membre.getNom() + "" + membre.getPrenom(), SessionMBean.getUser1(), mouchardFacadeLocal);
                        }
                    }
                    JsfUtil.addSuccessMessage("Opération éffectuée avec succès !");
                } else {
                    JsfUtil.addErrorMessage("La liste des cycles est vide !");
                }
            } else {
                JsfUtil.addErrorMessage("Aucun membre selectionné !");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void edit() {
        
    }

    public void delete() {
        try {
            if (privilige != null) {
                membrecycleFacadeLocal.remove(privilige);
                JsfUtil.addSuccessMessage("Operation réussie !");
            } else {
                JsfUtil.addSuccessMessage("Aucune ligne selectionnée");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void filterMembreCycle() {
        try {
            dualList.getSource().clear();
            dualList.getTarget().clear();
            if (membre != null) {

                List<Membrecycle> privilegeTemps = membrecycleFacadeLocal.findByMembre(membre.getIdmembre());

                if (privilegeTemps.isEmpty()) {
                    dualList.setSource(cycleFacadeLocal.findAll());
                } else {
                    List<Cycletontine> cycleTempAll = cycleFacadeLocal.findAll();
                    List<Cycletontine> userCycles = new ArrayList<>();

                    for (Membrecycle u : privilegeTemps) {
                        userCycles.add(u.getIdcycle());
                    }

                    if (!cycleTempAll.isEmpty()) {
                        for (Cycletontine d : cycleTempAll) {
                            if (!userCycles.contains(d)) {
                                dualList.getSource().add(d);
                            }
                        }
                    }
                }
            } else {
                JsfUtil.addErrorMessage("Aucun membre selectionné");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void filterPrivilegeRetrait() {
        privilegeDualList.getSource().clear();
        privilegeDualList.getTarget().clear();
        if (membre != null) {
            privilegeDualList.setSource(membrecycleFacadeLocal.findByMembre(membre.getIdmembre()));
        }
    }

    public void retraitPrivilege() {
        for (Membrecycle p : privilegeDualList.getTarget()) {
            if (!privilegeDualList.getTarget().isEmpty()) {
                membrecycleFacadeLocal.remove(p);
                Utilitaires.saveOperation("Retrait du privilège -> " + p.getIdcycle().getNomfr()+ " A l'membre -> " + p.getIdmembre().getNom() + " " + p.getIdmembre().getPrenom(), SessionMBean.getUser1(), mouchardFacadeLocal);
            }
        }
        getPrivileges();
        JsfUtil.addSuccessMessage("Opération réussie");
    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Membrecycle getPrivilige() {
        return privilige;
    }

    public void setPrivilige(Membrecycle privilige) {
        this.privilige = privilige;
    }

    public List<Membrecycle> getPrivileges() {
        privileges = membrecycleFacadeLocal.findAll();
        return privileges;
    }

    public void setPrivileges(List<Membrecycle> privileges) {
        this.privileges = privileges;
    }

 
    public Cycletontine getCycle() {
        return cycle;
    }

    public void setCycle(Cycletontine cycle) {
        this.cycle = cycle;
    }

    public List<Cycletontine> getCycles() {
        return cycles;
    }

    public void setCycles(List<Cycletontine> cycles) {
        this.cycles = cycles;
    }

    public Membre getMembre() {
        return membre;
    }

    public void setMembre(Membre membre) {
        this.membre = membre;
    }

    public List<Membre> getMembres() {
        membres = membreFacadeLocal.findAll();
        return membres;
    }

    public void setMembres(List<Membre> membres) {
        this.membres = membres;
    }

    public DualListModel<Cycletontine> getDualList() {
        return dualList;
    }

    public void setDualList(DualListModel<Cycletontine> dualList) {
        this.dualList = dualList;
    }

    public DualListModel<Membrecycle> getPrivilegeDualList() {
        return privilegeDualList;
    }

    public void setPrivilegeDualList(DualListModel<Membrecycle> privilegeDualList) {
        this.privilegeDualList = privilegeDualList;
    }

}
