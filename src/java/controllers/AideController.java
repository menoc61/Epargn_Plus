/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Aide;
import entities.AideMembre;
import entities.Caisse;
import entities.Cycletontine;
import entities.Membrecycle;
import entities.Rencontre;
import entities.Motifaide;
import entities.Mouchard;
import entities.Rubriquecaisse;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.AideFacadeLocal;
import sessions.AideMembreFacadeLocal;
import sessions.CaisseFacadeLocal;
import sessions.CycletontineFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.RencontreFacadeLocal;
import sessions.MotifaideFacadeLocal;
import sessions.MouchardFacadeLocal;

/**
 *
 * @author Abdel Beininfo
 */
@ManagedBean
@ViewScoped
public class AideController implements Serializable {

    /**
     * Creates a new instance of AideController
     */
    @EJB
    private AideFacadeLocal aideFacadeLocal;
    private Aide aide = new Aide();
    private Aide selected = new Aide();
    private List<Aide> aides = new ArrayList<>();

    @EJB
    private AideMembreFacadeLocal aideMembreFacadeLocal;
    private List<AideMembre> aideMembres = new ArrayList<>();

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
    private Cycletontine cycletontine = new Cycletontine();
    private List<Cycletontine> cycletontines = new ArrayList<>();

    @EJB
    private MotifaideFacadeLocal motifaideFacadeLocal;
    private Motifaide motifaide = new Motifaide();
    private List<Motifaide> motifaides = new ArrayList<>();

    @EJB
    private CaisseFacadeLocal caisseFacadeLocal;
    private Caisse caisse = new Caisse();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard = new Mouchard();

    private boolean detail = true;

    private String mode = "";

    public AideController() {

    }

    @PostConstruct
    private void init() {
        aide = new Aide();
        selected = new Aide();
        mouchard = new Mouchard();
        cycletontine = SessionMBean.getCycletontine();
        rencontre = new Rencontre();
        motifaide = new Motifaide();
        cycletontine = SessionMBean.getCycletontine();
        membrecycle = new Membrecycle();

        try {
            aides = aideFacadeLocal.findByCycletontine(SessionMBean.getCycletontine().getIdcycle());
            membrecycles = membrecycleFacadeLocal.findByCycle(SessionMBean.getCycletontine());
            rencontres = rencontreFacadeLocal.findByCycle(SessionMBean.getCycletontine(), true);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updatePartage() {
        try {
            Double part = null;
            try {
                part = aide.getMontantaide() / membrecycles.size();
            } catch (Exception e) {
                part = 0d;
            }

            Double part1 = null;
            try {
                part1 = aide.getMontantMaintLevee() / membrecycles.size();
            } catch (Exception e) {
                part1 = 0d;
            }

            for (int i = 0; i < membrecycles.size(); i++) {
                aideMembres.get(i).setMontant(part);
                aideMembres.get(i).setMontantMainLevee(part1);
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
        aide = new Aide();
        aide.setMontantaide(0d);
        aide.setMontantMaintLevee(0d);
        rencontre = new Rencontre();
        cycletontine = SessionMBean.getCycletontine();
        mouchard = new Mouchard();
        aide.setObservation("-");
        try {
            aideMembres.clear();

            List<Membrecycle> ms = membrecycleFacadeLocal.findByCycle(cycletontine , true);
            membrecycles = ms;
            for (Membrecycle m : ms) {
                AideMembre a = new AideMembre();
                a.setMontant(0d);
                a.setMontantMainLevee(0d);
                a.setIdmembre(m);
                aideMembres.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void prepareEdit() {
        mode = "Edit";
        try {
            if (aide != null) {

                if (aide.getIdrencontre() != null) {
                    rencontre = aide.getIdrencontre();
                }

                if (aide.getIdmotifaide() != null) {
                    motifaide = aide.getIdmotifaide();
                }
                aideMembres = aideMembreFacadeLocal.findByAide(aide);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateDate() {
        try {
            if (rencontre != null) {
                aide.setDateaide(rencontre.getDaterencontre());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void save() {
        try {

            if ("Create".equals(mode)) {

                if (!aideMembres.isEmpty()) {

                    caisse.setIdcaisse(caisseFacadeLocal.nextId());
                    caisse.setDateoperation(rencontre.getDaterencontre());
                    caisse.setIdcycle(cycletontine);
                    caisse.setLibelleoperation("Enregistrement de l'aide  du membre " + aide.getIdmembre().getIdmembre().getNom() + " " + aide.getIdmembre().getIdmembre().getPrenom());
                    caisse.setIdmembrecycle(aide.getIdmembre());
                    caisse.setMontant(aide.getMontantaide());
                    caisse.setIdrencontre(rencontre);
                    caisse.setIdrubriquecaisse(new Rubriquecaisse(12));
                    caisseFacadeLocal.create(caisse);

                    aide.setIdaide(aideFacadeLocal.nextId());
                    aide.setIdcycle(SessionMBean.getCycletontine());
                    aide.setIdrencontre(rencontre);
                    aide.setIdcaisse(caisse);
                    aideFacadeLocal.create(aide);

                    for (AideMembre a : aideMembres) {
                        a.setId(aideMembreFacadeLocal.nextId());
                        a.setIdaide(aide);
                        aideMembreFacadeLocal.create(a);
                        Membrecycle m = a.getIdmembre();
                        m.setMontantSecours(m.getMontantSecours() - a.getMontant());
                        m.setResteMainLevee(m.getResteMainLevee() + a.getMontantMainLevee());
                        membrecycleFacadeLocal.edit(m);
                    }

                    mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                    mouchard.setAction("Enregistrement de l'aide du membre -> " + aide.getIdmembre().getIdmembre().getNom() + " " + aide.getIdmembre().getIdmembre().getPrenom());
                    mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                    mouchard.setDateaction(new Date());
                    mouchardFacadeLocal.create(mouchard);

                    JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
                } else {
                    JsfUtil.addErrorMessage("Le tableau de membre participant est vide");
                }
            } else {
                if (aide != null) {

                    Aide aid = aideFacadeLocal.find(aide.getIdaide());

                    aide.setIdrencontre(rencontre);
                    aideFacadeLocal.edit(aide);
                    aide.getIdcaisse().setMontant(aide.getMontantaide());
                    caisseFacadeLocal.edit(aide.getIdcaisse());

                    aideMembres = aideMembreFacadeLocal.findByAide(aide);

                    Double partage1 = null;
                    try {
                        partage1 = aid.getMontantaide() / aideMembres.size();
                    } catch (Exception e) {
                        partage1 = 0d;
                    }

                    if (aid.getMontantaide() != aide.getMontantaide()) {
                        Double partage2 = aide.getMontantaide() / aideMembres.size();

                        for (AideMembre a : aideMembres) {

                            a.setMontant(partage2);
                            aideMembreFacadeLocal.edit(a);

                            Membrecycle m = a.getIdmembre();
                            m.setMontantSecours((m.getMontantSecours() + partage1) - partage2);
                            membrecycleFacadeLocal.edit(m);
                        }
                    }

                    Double partage3 = null;
                    try {
                        partage3 = aid.getMontantMaintLevee() / aideMembres.size();
                    } catch (Exception e) {
                        partage3 = 0d;
                    }

                    if (aid.getMontantMaintLevee() != aide.getMontantMaintLevee()) {
                        Double partage2 = aide.getMontantMaintLevee() / aideMembres.size();

                        for (AideMembre a : aideMembres) {
                            a.setMontantMainLevee(partage2);
                            aideMembreFacadeLocal.edit(a);

                            Membrecycle m = a.getIdmembre();
                            m.setResteMainLevee((m.getResteMainLevee() - partage3) + partage2);
                            membrecycleFacadeLocal.edit(m);
                        }
                    }

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
            if (aide != null) {

                aideMembres = aideMembreFacadeLocal.findByAide(aide);
                for (AideMembre a : aideMembres) {
                    a.getIdmembre().setMontantSecours(a.getIdmembre().getMontantSecours() + (aide.getMontantaide() / aideMembres.size()));
                    a.getIdmembre().setResteMainLevee(a.getIdmembre().getResteMainLevee() - (aide.getMontantMaintLevee() / aideMembres.size()));
                    membrecycleFacadeLocal.edit(a.getIdmembre());
                    aideMembreFacadeLocal.remove(a);
                }

                aideFacadeLocal.remove(aide);
                caisseFacadeLocal.remove(aide.getIdcaisse());

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Suppression de l'aide au  membre -> " + aide.getIdmembre().getIdmembre().getNom() + " " + aide.getIdmembre().getIdmembre().getPrenom());
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

    public Aide getAide() {
        return aide;
    }

    public void setAide(Aide aide) {
        this.aide = aide;
    }

    public Aide getSelected() {
        return selected;
    }

    public void setSelected(Aide selected) {
        this.selected = selected;
    }

    public List<Aide> getAides() {
        try {
            if (SessionMBean.getCycletontine() != null) {
                aides = aideFacadeLocal.findByCycletontine(SessionMBean.getCycletontine().getIdcycle());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return aides;
    }

    public void setAides(List<Aide> aides) {
        this.aides = aides;
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

    public Motifaide getMotifaide() {
        return motifaide;
    }

    public void setMotifaide(Motifaide motifaide) {
        this.motifaide = motifaide;
    }

    public List<Motifaide> getMotifaides() {
        motifaides = motifaideFacadeLocal.findAll();
        return motifaides;
    }

    public void setMotifaides(List<Motifaide> motifaides) {
        this.motifaides = motifaides;
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

    public List<AideMembre> getAideMembres() {
        return aideMembres;
    }

    public void setAideMembres(List<AideMembre> aideMembres) {
        this.aideMembres = aideMembres;
    }
}
