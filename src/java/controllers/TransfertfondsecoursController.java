/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Cycletontine;
import entities.Membrecycle;
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
import sessions.CycletontineFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.MouchardFacadeLocal;

/**
 *
 * @author Abdel Beininfo
 */
@ManagedBean
@ViewScoped
public class TransfertfondsecoursController implements Serializable {

    /**
     * Creates a new instance of DepenseController
     */
    @Resource
    private UserTransaction ut;

    @EJB
    protected MembrecycleFacadeLocal membrecycleFacadeLocal;
    protected DualListModel<Membrecycle> membrecycles = new DualListModel<>();
    protected List<Membrecycle> membrecycles1 = new ArrayList<>();

    @EJB
    private CycletontineFacadeLocal cycletontineFacadeLocal;
    private Cycletontine cycletontine = new Cycletontine();
    private Cycletontine cycletontine1 = new Cycletontine();
    private List<Cycletontine> cycletontines = new ArrayList<>();
    private List<Cycletontine> cycletontines1 = new ArrayList<>();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;

    private boolean detail = true;
    private boolean showMembre = true;

    private String mode = "";

    public TransfertfondsecoursController() {

    }

    @PostConstruct
    private void init() {

    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void prepareCreate() {
        mode = "Create";
        showMembre = false;
        cycletontine = new Cycletontine();
        cycletontine1 = new Cycletontine();
        membrecycles = new DualListModel<>();
    }

    public void updateMembre() {
        try {
            membrecycles = new DualListModel<>();
            membrecycles.getSource().addAll(membrecycleFacadeLocal.findByCycle(cycletontine, true));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void save() {
        try {

            if ("Create".equals(mode)) {

                cycletontine = cycletontineFacadeLocal.find(cycletontine.getIdcycle());
                cycletontine1 = cycletontineFacadeLocal.find(cycletontine1.getIdcycle());

                ut.begin();

                if (!cycletontine.equals(cycletontine1)) {
                    List<Membrecycle> mbs = membrecycleFacadeLocal.findByCycle(cycletontine1);
                    if (!membrecycles.getTarget().isEmpty()) {
                        if (!mbs.isEmpty()) {
                            for (Membrecycle m : membrecycles.getTarget()) {
                                for (Membrecycle ms : mbs) {
                                    if (ms.getIdmembre().equals(m.getIdmembre())) {
                                        ms.setMontantSecours(m.getMontantSecours());
                                        ms.setResteMainLevee(m.getResteMainLevee());
                                        membrecycleFacadeLocal.edit(ms);
                                        utilitaire.Utilitaires.saveOperation("Transfert du fond secours du membre -> " + ms.getIdmembre().getNom() + " " + ms.getIdmembre().getPrenom() + " du cycle -> " + cycletontine.getNomfr() + " Au " + cycletontine1.getNomfr(), SessionMBean.getUser1(), mouchardFacadeLocal);
                                        break;
                                    }
                                }
                            }
                        } else {
                            JsfUtil.addErrorMessage("Le cycle de destination n'a aucun membre");
                            return;
                        }
                    } else {
                        JsfUtil.addErrorMessage("La liste de destination est vide");
                        return;
                    }
                } else {
                    JsfUtil.addErrorMessage("Les deux cycles sont identiques");
                    return;
                }
                cycletontine1.setTransfere(true);
                cycletontineFacadeLocal.edit(cycletontine1);

                ut.commit();
                JsfUtil.addSuccessMessage("Opération réussie");
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

    public List<Membrecycle> getMembrecycles1() {
        try {
            membrecycles1 = membrecycleFacadeLocal.findByCycle(SessionMBean.getCycletontine(), true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return membrecycles1;
    }

    public void setMembrecycles1(List<Membrecycle> membrecycles1) {
        this.membrecycles1 = membrecycles1;
    }

    public DualListModel<Membrecycle> getMembrecycles() {
        return membrecycles;
    }

    public void setMembrecycles(DualListModel<Membrecycle> membrecycles) {
        this.membrecycles = membrecycles;
    }

    public boolean isShowMembre() {
        return showMembre;
    }

    public void setShowMembre(boolean showMembre) {
        this.showMembre = showMembre;
    }

    public Cycletontine getCycletontine1() {
        return cycletontine1;
    }

    public void setCycletontine1(Cycletontine cycletontine1) {
        this.cycletontine1 = cycletontine1;
    }

    public List<Cycletontine> getCycletontines() {
        try {
            cycletontines = cycletontineFacadeLocal.findByTontine(SessionMBean.getCycletontine().getIdtontine());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cycletontines;
    }

    public void setCycletontines(List<Cycletontine> cycletontines) {
        this.cycletontines = cycletontines;
    }

    public List<Cycletontine> getCycletontines1() {
        try {
            cycletontines1 = cycletontineFacadeLocal.findByTontine(SessionMBean.getCycletontine().getIdtontine(), false);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cycletontines1;
    }

    public void setCycletontines1(List<Cycletontine> cycletontines1) {
        this.cycletontines1 = cycletontines1;
    }

}
