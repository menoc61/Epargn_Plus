/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Caisse;
import entities.CollecteSecours;
import entities.Cycletontine;
import entities.Membrecycle;
import entities.Rencontre;
import entities.Mouchard;
import entities.Rubriquecaisse;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.transaction.UserTransaction;
import sessions.CaisseFacadeLocal;
import sessions.CollecteSecoursFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.RencontreFacadeLocal;
import sessions.MouchardFacadeLocal;
import utilitaire.Printer;

/**
 *
 * @author Abdel Beininfo
 */
@ManagedBean
@ViewScoped
public class CollectesecoursController implements Serializable {

    /**
     * Creates a new instance of DepenseController
     */
    @Resource
    private UserTransaction ut;

    @EJB
    protected CollecteSecoursFacadeLocal collecteSecoursFacadeLocal;
    protected CollecteSecours collecteSecours = new CollecteSecours();
    protected List<CollecteSecours> collecteSecourses = new ArrayList<>();

    @EJB
    protected MembrecycleFacadeLocal membrecycleFacadeLocal;
    protected Membrecycle membrecycle = new Membrecycle();
    protected List<Membrecycle> membrecycles = new ArrayList<>();
    protected List<Membrecycle> membrecycles1 = new ArrayList<>();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre = new Rencontre();
    private List<Rencontre> rencontres = new ArrayList<>();

    private Cycletontine cycletontine = SessionMBean.getCycletontine();

    private Rubriquecaisse rubriquecaisse = new Rubriquecaisse();

    @EJB
    private CaisseFacadeLocal caisseFacadeLocal;
    private Caisse caisse = new Caisse();

    private Double reste = 0D;

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard = new Mouchard();

    private boolean detail = true;
    private boolean showMembre = true;

    private String mode = "";

    public CollectesecoursController() {

    }

    @PostConstruct
    private void init() {
        mouchard = new Mouchard();
        cycletontine = SessionMBean.getCycletontine();
        rencontre = new Rencontre();
        rubriquecaisse = new Rubriquecaisse(1);
        cycletontine = SessionMBean.getCycletontine();
    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void prepareCreate() {
        mode = "Create";
        rencontre = new Rencontre();
        membrecycle = new Membrecycle();
        collecteSecours = new CollecteSecours();
        caisse = new Caisse();
        mouchard = new Mouchard();
        reste = 0d;
        showMembre = false;
        try {
            this.membrecycles.clear();
            List<Membrecycle> membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine , true);
            for (Membrecycle m : membrecycles) {
                if (m.getMontantSecours() < cycletontine.getMontantSecours()) {
                    this.membrecycles.add(m);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void prepareEdit() {
        mode = "Edit";
        try {
            showMembre = true;
            if (collecteSecours != null) {
                rencontre = collecteSecours.getIdrencontre();
                membrecycle = collecteSecours.getIdmembre();

                this.membrecycles.clear();
                List<Membrecycle> membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine);
                for (Membrecycle m : membrecycles) {
                    if (m.getMontantSecours() < cycletontine.getMontantSecours()) {
                        this.membrecycles.add(m);
                    }
                }

                if (!this.membrecycles.contains(membrecycle)) {
                    this.membrecycles.add(membrecycle);
                }

                reste = cycletontine.getMontantSecours() - membrecycle.getMontantSecours();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateDate() {

    }

    public void updateReste() {
        try {
            reste = cycletontine.getMontantSecours() - membrecycle.getMontantSecours();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void save() {
        try {

            if ("Create".equals(mode)) {

                ut.begin();

                caisse.setIdcaisse(caisseFacadeLocal.nextId());
                caisse.setMontant(collecteSecours.getMontant());
                caisse.setIdmembrecycle(membrecycle);
                caisse.setLibelleoperation("Enregistrement du fond de caisse du membre  -> " + membrecycle.getIdmembre().getNom() + " " + membrecycle.getIdmembre().getPrenom() + " ; Montant -> " + collecteSecours.getMontant());
                caisse.setIdrencontre(rencontre);
                caisse.setIdrubriquecaisse(new Rubriquecaisse(1));
                caisse.setIdcycle(cycletontine);
                caisse.setDateoperation(rencontre.getDaterencontre());
                caisseFacadeLocal.create(caisse);

                collecteSecours.setId(collecteSecoursFacadeLocal.nextId());
                collecteSecours.setIdcaisse(caisse);
                collecteSecours.setIdmembre(membrecycle);
                collecteSecours.setIdrencontre(rencontre);
                collecteSecoursFacadeLocal.create(collecteSecours);

                membrecycle.setMontantSecours(membrecycle.getMontantSecours() + collecteSecours.getMontant());
                membrecycleFacadeLocal.edit(membrecycle);

                ut.commit();

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Enregistrement du fond de caisse du membre  -> " + membrecycle.getIdmembre().getNom() + " " + membrecycle.getIdmembre().getPrenom() + " ; Montant -> " + collecteSecours.getMontant());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
            } else {
                if (collecteSecours != null) {

                    ut.begin();

                    membrecycle = collecteSecours.getIdmembre();

                    CollecteSecours c = collecteSecoursFacadeLocal.find(collecteSecours.getId());
                    collecteSecours.setIdrencontre(rencontre);
                    if (c.getMontant() != collecteSecours.getMontant()) {

                        membrecycle.setMontantSecours(membrecycle.getMontantSecours() - c.getMontant());

                        collecteSecoursFacadeLocal.edit(collecteSecours);

                        caisse = collecteSecours.getIdcaisse();
                        caisse.setMontant(collecteSecours.getMontant());
                        caisseFacadeLocal.edit(caisse);

                        membrecycle.setMontantSecours(membrecycle.getMontantSecours() + collecteSecours.getMontant());
                        membrecycleFacadeLocal.edit(membrecycle);
                    } else {
                        collecteSecoursFacadeLocal.edit(collecteSecours);

                        caisse = collecteSecours.getIdcaisse();
                        caisse.setMontant(collecteSecours.getMontant());
                        caisseFacadeLocal.edit(caisse);
                    }
                    ut.commit();

                    JsfUtil.addSuccessMessage("Operation réussie");
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
            if (collecteSecours != null) {

                ut.begin();
                collecteSecoursFacadeLocal.remove(collecteSecours);
                collecteSecours.getIdmembre().setMontantSecours(collecteSecours.getIdmembre().getMontantSecours() - collecteSecours.getMontant());
                membrecycleFacadeLocal.edit(collecteSecours.getIdmembre());
                caisseFacadeLocal.remove(collecteSecours.getIdcaisse());
                ut.commit();

                membrecycle = collecteSecours.getIdmembre();

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Suppression des frais de secours du membre -> " + membrecycle.getIdmembre().getNom() + " " + membrecycle.getIdmembre().getPrenom() + " Montant -> " + collecteSecours.getMontant());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Suppression effectuée avec succès");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void printSituation() {
        try {
            Printer p = new Printer();
            Map map = new HashMap();
            map.put("idcycle", cycletontine.getIdcycle());
            p.print("/reports/rapporttontine/etat_fond_secours.jasper", map);
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

    public Rencontre getRencontre() {
        return rencontre;
    }

    public void setRencontre(Rencontre rencontre) {
        this.rencontre = rencontre;
    }

    public List<Rencontre> getRencontres() {
        try {
            rencontres = rencontreFacadeLocal.findByCycle(cycletontine, true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rencontres;
    }

    public void setRencontre(List<Rencontre> rencontres) {
        this.rencontres = rencontres;
    }

    public Rubriquecaisse getRubriquecaisse() {
        return rubriquecaisse;
    }

    public void setRubriquecaisse(Rubriquecaisse rubriquecaisse) {
        this.rubriquecaisse = rubriquecaisse;
    }

    public Caisse getCaisse() {
        return caisse;
    }

    public void setCaisse(Caisse caisse) {
        this.caisse = caisse;
    }

    public CollecteSecours getCollecteSecours() {
        return collecteSecours;
    }

    public void setCollecteSecours(CollecteSecours collecteSecours) {
        this.collecteSecours = collecteSecours;
    }

    public List<CollecteSecours> getCollecteSecourses() {
        try {
            collecteSecourses = collecteSecoursFacadeLocal.findByCycle(cycletontine);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return collecteSecourses;
    }

    public void setCollecteSecourses(List<CollecteSecours> collecteSecourses) {
        this.collecteSecourses = collecteSecourses;
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

    public Double getReste() {
        return reste;
    }

    public void setReste(Double reste) {
        this.reste = reste;
    }

    public boolean isShowMembre() {
        return showMembre;
    }

    public void setShowMembre(boolean showMembre) {
        this.showMembre = showMembre;
    }

    public List<Membrecycle> getMembrecycles1() {
        try {
            membrecycles1 = membrecycleFacadeLocal.findByCycle(SessionMBean.getCycletontine());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return membrecycles1;
    }
}
