/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Caisse;
import entities.Epargne;
import entities.Cycletontine;
import entities.Membrecycle;
import entities.Rencontre;
import entities.Mouchard;
import entities.Rubriquecaisse;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.transaction.UserTransaction;
import sessions.CaisseFacadeLocal;
import sessions.EpargneFacadeLocal;
import sessions.CycletontineFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.RencontreFacadeLocal;
import sessions.MouchardFacadeLocal;

/**
 *
 * @author Abdel Beininfo
 */
@ManagedBean
@ViewScoped
public class EpargneController implements Serializable {

    /**
     * Creates a new instance of EpargneController
     */
    @Resource
    private UserTransaction ut;

    @EJB
    private EpargneFacadeLocal epargneFacadeLocal;
    private Epargne epargne = new Epargne();
    private List<Epargne> epargnes = new ArrayList<>();

    @EJB
    private MembrecycleFacadeLocal membrecycleFacadeLocal;
    private Membrecycle membrecycle = new Membrecycle();
    private List<Membrecycle> membrecycles = new ArrayList<>();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre = new Rencontre();
    private List<Rencontre> rencontres = new ArrayList<>();

    @EJB
    private CycletontineFacadeLocal cycletontineFacadeLocal;
    private Cycletontine cycletontine = SessionMBean.getCycletontine();
    private List<Cycletontine> cycletontines = new ArrayList<>();

    @EJB
    private CaisseFacadeLocal caisseFacadeLocal;
    private Caisse caisse = new Caisse();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard;

    private boolean detail = true;

    private String mode = "";

    public EpargneController() {

    }

    @PostConstruct
    private void init() {
        epargne = new Epargne();
        mouchard = new Mouchard();
        cycletontine = new Cycletontine();
        rencontre = new Rencontre();
        cycletontine = SessionMBean.getCycletontine();
        membrecycle = new Membrecycle();
        updateDate();

        try {
            rencontres = rencontreFacadeLocal.findByCycle(cycletontine, true,false);
            membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine);
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
        epargne = new Epargne();
        rencontre = new Rencontre();
        try {
            membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void prepareEdit() {
        mode = "Edit";
        try {
            cycletontines = cycletontineFacadeLocal.findAll();
            if (epargne != null) {
                if (epargne.getIdrencontre() != null) {
                    rencontre = epargne.getIdrencontre();
                }
                if (epargne.getIdmembrecycle() != null) {
                    membrecycle = epargne.getIdmembrecycle();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateDate() {
        try {
            if (rencontre != null) {
                epargne.setDateepargne(rencontre.getDaterencontre());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void save() {
        try {

            if ("Create".equals(mode)) {

                ut.begin();

                caisse = new Caisse();
                caisse.setIdcaisse(caisseFacadeLocal.nextId());
                caisse.setDateoperation(rencontre.getDaterencontre());
                caisse.setIdcycle(cycletontine);
                caisse.setLibelleoperation("Enregistrement de l'epargne  du membre " + epargne.getIdmembrecycle().getIdmembre().getNom());
                caisse.setIdmembrecycle(epargne.getIdmembrecycle());
                caisse.setMontant(epargne.getMontant());
                caisse.setIdrencontre(rencontre);
                caisse.setIdrubriquecaisse(new Rubriquecaisse(2));
                caisseFacadeLocal.create(caisse);

                epargne.setIdepargne(epargneFacadeLocal.nextId());
                epargne.setIdrencontre(rencontre);
                epargne.setIdcaisse(caisse);
                epargneFacadeLocal.create(epargne);

                membrecycle = epargne.getIdmembrecycle();

                membrecycle.setMontantavalise(membrecycle.getMontantavalise() + epargne.getMontant());
                membrecycleFacadeLocal.edit(membrecycle);

                ut.commit();

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Enregistrement de l'aide  -> " + epargne.getObservation());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);

                JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
            } else {
                if (epargne != null) {

                    ut.begin();
                    Epargne ep = epargneFacadeLocal.find(epargne.getIdepargne());
                    ep.getIdmembrecycle().setMontantavalise(ep.getIdmembrecycle().getMontantavalise() - ep.getMontant());

                    epargneFacadeLocal.edit(epargne);
                    epargne.getIdcaisse().setMontant(epargne.getMontant());
                    caisseFacadeLocal.edit(epargne.getIdcaisse());

                    ep.getIdmembrecycle().setMontantavalise(ep.getIdmembrecycle().getMontantavalise() + epargne.getMontant());
                    membrecycleFacadeLocal.edit(ep.getIdmembrecycle());

                    ut.commit();

                    JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
                } else {
                    JsfUtil.addErrorMessage("Aucune selectionnée");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete() {
        try {
            if (epargne != null) {

                ut.begin();

                membrecycle = epargne.getIdmembrecycle();
                epargneFacadeLocal.remove(epargne);
                caisseFacadeLocal.remove(epargne.getIdcaisse());
                membrecycle.setMontantavalise(membrecycle.getMontantavalise() - epargne.getMontant());
                membrecycleFacadeLocal.edit(membrecycle);

                ut.commit();

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Suppression de la epargne -> " + epargne.getObservation());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Suppression effectuée avec succès");
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

    public Epargne getEpargne() {
        return epargne;
    }

    public void setEpargne(Epargne epargne) {
        this.epargne = epargne;
    }

    public List<Epargne> getEpargnes() {
        try {
            if (SessionMBean.getCycletontine() != null) {
                epargnes = epargneFacadeLocal.findByCycletontine(SessionMBean.getCycletontine().getIdcycle());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return epargnes;
    }

    public void setEpargnes(List<Epargne> epargnes) {
        this.epargnes = epargnes;
    }

    public Cycletontine getCycletontine() {
        return cycletontine;
    }

    public void setCycletontine(Cycletontine cycletontine) {
        this.cycletontine = cycletontine;
    }

    public List<Cycletontine> getCycletontines() {
        cycletontines = cycletontineFacadeLocal.findAll();
        return cycletontines;
    }

    public void setCycletontines(List<Cycletontine> cycletontines) {
        this.cycletontines = cycletontines;
    }

    public Rencontre getRencontre() {
        return rencontre;
    }

    public void setRencontre(Rencontre rencontre) {
        this.rencontre = rencontre;
    }

    public List<Rencontre> getRencontres() {
        return rencontres;
    }

    public void setRencontre(List<Rencontre> rencontres) {
        this.rencontres = rencontres;
    }

    public Membrecycle getMembrecycle() {
        return membrecycle;
    }

    public void setMembrecycle(Membrecycle membrecycle) {
        this.membrecycle = membrecycle;
    }

    public List<Membrecycle> getMembrecycles() {
        return membrecycles;
    }

    public void setMembrecycles(List<Membrecycle> membrecycles) {
        this.membrecycles = membrecycles;
    }

    public Caisse getCaisse() {
        return caisse;
    }

    public void setCaisse(Caisse caisse) {
        this.caisse = caisse;
    }

}
