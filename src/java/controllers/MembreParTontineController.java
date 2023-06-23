/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Caisse;
import entities.Cycletontine;
import entities.Membrecycle;
import entities.Membretontine;
import entities.Mouchard;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.transaction.UserTransaction;
import org.primefaces.model.DualListModel;
import sessions.CaisseFacadeLocal;
import sessions.CycletontineFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.MembretontineFacadeLocal;
import sessions.MouchardFacadeLocal;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class MembreParTontineController implements Serializable {

    @Resource
    private UserTransaction ut;

    @EJB
    private CycletontineFacadeLocal cycletontineFacadeLocal;
    private Cycletontine cycletontine = new Cycletontine();
    private List<Cycletontine> cycletontines = new ArrayList<>();

    @EJB
    private MembrecycleFacadeLocal membrecycleFacadeLocal;
    private Membrecycle membrecycle = new Membrecycle();
    private List<Membrecycle> membrecycles = new ArrayList<>();

    @EJB
    private MembretontineFacadeLocal membretontineFacadeLocal;
    private Membretontine membretontine = new Membretontine();
    private List<Membretontine> membretontines = new ArrayList<>();
    private DualListModel<Membretontine> membreDualList = new DualListModel<>();

    private CaisseFacadeLocal caisseFacadeLocal;
    private Caisse caisse = new Caisse();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard = new Mouchard();

    private boolean detail = true;

    @PostConstruct
    private void init() {
        mouchard = new Mouchard();
        cycletontine = SessionMBean.getCycletontine();
    }

    public void nothing() {

    }

    public void save() {
        try {

            ut.begin();
            if (!membreDualList.getTarget().isEmpty()) {
                for (Membretontine m : membreDualList.getTarget()) {
                    List<Membrecycle> membrecycles = membrecycleFacadeLocal.findByMembreCycle(m.getIdmembre(), cycletontine);
                    if (membrecycles.isEmpty()) {
                        Membrecycle mc = new Membrecycle();
                        mc.setIdmembrecycle(membrecycleFacadeLocal.nextId());
                        mc.setIdmembre(m.getIdmembre());
                        mc.setIdcycle(cycletontine);
                        mc.setMontantavalise(0d);
                        mc.setMontantSecours(0d);
                        membrecycleFacadeLocal.create(mc);
                    }
                }
            }

            if (!membreDualList.getSource().isEmpty()) {
                for (Membretontine m : membreDualList.getSource()) {
                    List<Membrecycle> membrecycles = membrecycleFacadeLocal.findByMembreCycle(m.getIdmembre(), cycletontine);
                    if (!membrecycles.isEmpty()) {
                        membrecycleFacadeLocal.remove(membrecycles.get(0));
                    }
                }
            }
            ut.commit();
            JsfUtil.addSuccessMessage("Opération réussie");

        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Exceptio système , verifiez le formulaire");
        }
    }

    public void edit() {
        try {
            if (membretontine != null) {
                ut.begin();
                membretontineFacadeLocal.edit(membretontine);
                ut.commit();
                JsfUtil.addSuccessMessage("Opération réussie");
            } else {
                JsfUtil.addErrorMessage("Aucune ligne selectionée");
            }
        } catch (Exception e) {
            e.printStackTrace();         
        }
    }

    public void delete() {
        try {
            if (membretontine != null) {
                ut.begin();
                membretontineFacadeLocal.remove(membretontine);
                ut.commit();
                JsfUtil.addSuccessMessage("Opération réussie");
            } else {
                JsfUtil.addErrorMessage("Aucune ligne sélectionnée");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Impossible de supprimes à causes des dépendances");
        }
    }

    public MembreParTontineController() {

    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void prepareCreate() {
        cycletontine = SessionMBean.getCycletontine();
        membreDualList = new DualListModel<>();
        try {
            cycletontines = cycletontineFacadeLocal.findByTontine(cycletontine.getIdtontine());

            List<Membretontine> membretontines = membretontineFacadeLocal.findByTontine(cycletontine.getIdtontine());

            for (Membretontine m : membretontines) {
                List<Membrecycle> ms = membrecycleFacadeLocal.findByMembreCycle(m.getIdmembre(), cycletontine);
                if (ms.isEmpty()) {
                    membreDualList.getSource().add(m);
                } else {
                    membreDualList.getTarget().add(m);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void prepareEdit() {
        try {
            if (membretontine != null) {

            }
        } catch (Exception e) {
        }
    }

    public void update() {
        membreDualList = new DualListModel<>();
        try {
            cycletontines = cycletontineFacadeLocal.findByTontine(cycletontine.getIdtontine());

            List<Membretontine> membretontines = membretontineFacadeLocal.findByTontine(cycletontine.getIdtontine());

            for (Membretontine m : membretontines) {
                List<Membrecycle> ms = membrecycleFacadeLocal.findByMembreCycle(m.getIdmembre(), cycletontine);
                if (ms.isEmpty()) {
                    membreDualList.getSource().add(m);
                } else {
                    membreDualList.getTarget().add(m);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Cycletontine getCycletontine() {
        return cycletontine;
    }

    public void setCycletontine(Cycletontine cycletontine) {
        this.cycletontine = cycletontine;
    }

    public List<Cycletontine> getCycletontines() {
        return cycletontines;
    }

    public void setCycletontines(List<Cycletontine> cycletontines) {
        this.cycletontines = cycletontines;
    }

    public Membrecycle getMembrecycle() {
        return membrecycle;
    }

    public void setMembrecycle(Membrecycle membrecycle) {
        this.membrecycle = membrecycle;
    }

    public List<Membrecycle> getMembrecycles() {
        try {
            membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return membrecycles;
    }

    public void setMembrecycles(List<Membrecycle> membrecycles) {
        this.membrecycles = membrecycles;
    }

    public DualListModel<Membretontine> getMembreDualList() {
        return membreDualList;
    }

    public void setMembreDualList(DualListModel<Membretontine> membreDualList) {
        this.membreDualList = membreDualList;
    }

    public List<Membretontine> getMembretontines() {
        try {
            membretontines = membretontineFacadeLocal.findByTontine(SessionMBean.getCycletontine().getIdtontine());
        } catch (Exception e) {
        }
        return membretontines;
    }

    public void setMembretontines(List<Membretontine> membretontines) {
        this.membretontines = membretontines;
    }

    public Membretontine getMembretontine() {
        return membretontine;
    }

    public void setMembretontine(Membretontine membretontine) {
        this.membretontine = membretontine;
    }

}
