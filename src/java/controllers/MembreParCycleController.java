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
import entities.Rencontre;
import entities.Rubriquecaisse;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import sessions.RencontreFacadeLocal;
import utilitaire.Printer;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class MembreParCycleController implements Serializable {

    public MembreParCycleController() {

    }

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
    private DualListModel<Membretontine> membreDualList = new DualListModel<>();

    @EJB
    private CaisseFacadeLocal caisseFacadeLocal;
    private Rubriquecaisse rubriquecaisse = new Rubriquecaisse(9);

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard = new Mouchard();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;

    private boolean detail = true;

    @PostConstruct
    private void init() {
        mouchard = new Mouchard();
        cycletontine = SessionMBean.getCycletontine();
    }

    public void save() {
        try {
            ut.begin();
            if (!membreDualList.getTarget().isEmpty()) {
                List<Rencontre> rencontres = rencontreFacadeLocal.findByCycleCotisation(cycletontine , false);
                for (Membretontine m : membreDualList.getTarget()) {
                    List<Membrecycle> membrecycles = membrecycleFacadeLocal.findByMembreCycle(m.getIdmembre(), cycletontine);
                    if (membrecycles.isEmpty()) {

                        Membrecycle mc = new Membrecycle();
                        mc.setIdmembrecycle(membrecycleFacadeLocal.nextId());
                        mc.setIdmembre(m.getIdmembre());
                        mc.setIdcycle(cycletontine);
                        mc.setMontantavalise(0d);
                        mc.setMontantSecours(0d);
                        mc.setResteMainLevee(0d);
                        mc.setEtat(true);
                        mc.setFraisadhesion(0d);
                        membrecycleFacadeLocal.create(mc);

                        if (!rencontres.isEmpty()) {
                            Caisse c = new Caisse();
                            c.setIdcaisse(caisseFacadeLocal.nextId());
                            c.setIdcycle(cycletontine);
                            c.setIdmembrecycle(mc);
                            c.setMontant(cycletontine.getFraisadhesion());
                            c.setIdrubriquecaisse(rubriquecaisse);
                            mc.setFraisadhesion(cycletontine.getFraisadhesion());
                            c.setIdrencontre(rencontres.get(0));
                            c.setDateoperation(rencontres.get(0).getDaterencontre());
                            c.setLibelleoperation("Payement des frais d'inscription du membre -> " + mc.getIdmembre().getNom() + " " + mc.getIdmembre().getPrenom() + " Montant -> " + cycletontine.getFraisadhesion());
                            caisseFacadeLocal.create(c);

                            mc.setIdcaisse(c);
                            membrecycleFacadeLocal.edit(mc);
                        }
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
            JsfUtil.addErrorMessage("Exception système , verifiez le formulaire");
        }
    }

    public void edit() {
        try {
            if (membrecycle != null) {
                ut.begin();
                membrecycle.getIdcaisse().setMontant(membrecycle.getFraisadhesion());
                caisseFacadeLocal.edit(membrecycle.getIdcaisse());
                membrecycleFacadeLocal.edit(membrecycle);

                ut.commit();
                JsfUtil.addSuccessMessage("Opération réussie");
            } else {
                JsfUtil.addErrorMessage("Aucune ligne selectionée");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addFatalErrorMessage("Exception survénue");
        }
    }

    public void delete() {
        try {
            if (membrecycle != null) {
                ut.begin();
                membrecycleFacadeLocal.remove(membrecycle);
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

    public void updateFraisInscription() {
        try {
            List<Membrecycle> list = membrecycleFacadeLocal.findByCycle(cycletontine, true);
            List<Membrecycle> list_non_inscrit = new ArrayList<>();

            for (Membrecycle mc : list) {
                try {
                    if (mc.getIdcaisse() == null) {
                        list_non_inscrit.add(mc);
                    }
                } catch (Exception e) {
                    list_non_inscrit.add(mc);
                }
            }

            if (!list_non_inscrit.isEmpty()) {
                List<Rencontre> rencontres = rencontreFacadeLocal.findByCycleCotisation(cycletontine , false);
                List<Caisse> caisses = caisseFacadeLocal.findByRubriqueCycle(rubriquecaisse, cycletontine);
                for (Membrecycle mc : list_non_inscrit) {
                    Caisse c = chercherCaisse(mc, caisses);
                    if (c != null) {
                        mc.setIdcaisse(c);
                        mc.setFraisadhesion(c.getMontant());
                        membrecycleFacadeLocal.edit(mc);
                    } else {
                        c = new Caisse();
                        c.setIdcaisse(caisseFacadeLocal.nextId());
                        c.setIdcycle(cycletontine);
                        c.setIdmembrecycle(mc);
                        c.setMontant(0d);
                        c.setIdrubriquecaisse(rubriquecaisse);
                        c.setIdrencontre(rencontres.get(0));
                        c.setDateoperation(rencontres.get(0).getDaterencontre());
                        c.setLibelleoperation("Payement des frais d'inscription du membre -> " + mc.getIdmembre().getNom() + " " + mc.getIdmembre().getPrenom() + " Montant -> " + c.getMontant());
                        caisseFacadeLocal.edit(c);

                        mc.setIdcaisse(c);
                        mc.setFraisadhesion(0d);
                        membrecycleFacadeLocal.edit(mc);
                    }
                }
            }
            JsfUtil.addSuccessMessage("Opération réussie");
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addFatalErrorMessage("Exception survenue");
        }
    }

    private Caisse chercherCaisse(Membrecycle mc, List<Caisse> caisses) {
        for (Caisse c : caisses) {
            if (mc.equals(c.getIdmembrecycle())) {
                return c;
            }
        }
        return null;
    }

    public void printListInscription() {
        try {
            Printer p = new Printer();
            Map map = new HashMap();
            map.put("idcycle", cycletontine.getIdcycle());
            p.print("/reports/rapporttontine/liste_adherents.jasper", map);
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

}
