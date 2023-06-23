/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Rubriquecaisse;
import entities.Caisse;
import entities.Cycletontine;
import entities.Membrecycle;
import entities.Rencontre;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.MouchardFacadeLocal;
import sessions.RubriquecaisseFacadeLocal;
import sessions.CaisseFacadeLocal;
import sessions.CycletontineFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.RencontreFacadeLocal;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class CaisseController implements Serializable {

    /**
     * Creates a new instance of RencontreController
     */
    @EJB
    private CaisseFacadeLocal caisseFacadeLocal;
    private Caisse caissee;
    private List<Caisse> caissees = new ArrayList<>();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre = new Rencontre();
    private List<Rencontre> rencontres = new ArrayList<>();

    @EJB
    private RubriquecaisseFacadeLocal rubriquecaisseFacadeLocal;
    private List<Rubriquecaisse> rubriquecaisses = new ArrayList<>();
    private List<Rubriquecaisse> rubriquecaisses1 = new ArrayList<>();

    @EJB
    private MembrecycleFacadeLocal membrecycleFacadeLocal;
    private Membrecycle membrecycle;
    private List<Membrecycle> membrecycles = new ArrayList<>();

    @EJB
    private CycletontineFacadeLocal cycletontineFacadeLocal;
    private Cycletontine cycletontine = SessionMBean.getCycletontine();
    private List<Cycletontine> cycletontines = new ArrayList<>();
    private Date date;

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Boolean detail = true;

    public CaisseController() {

    }

    @PostConstruct
    private void init() {
        rencontre = new Rencontre();
        caissee = new Caisse();

        try {
            caissees = caisseFacadeLocal.findByCycletontine(SessionMBean.getCycletontine().getIdcycle());
            membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine);
            rencontres = rencontreFacadeLocal.findByCycle(cycletontine, true);
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

    public void uptadeTable() {
        try {
            caissees.clear();
            if (rencontre.getIdrencontre() != null) {
                rencontre = rencontreFacadeLocal.find(rencontre.getIdrencontre());
                if (membrecycle != null) {
                    if (!this.getRubriquecaisses1().isEmpty()) {

                        if (caisseFacadeLocal.find(membrecycle, rencontre).isEmpty()) {
                            for (Rubriquecaisse p : this.getRubriquecaisses1()) {
                                Caisse caisse = new Caisse();
                                caisse.setIdrencontre(rencontre);
                                caisse.setDateoperation(date);
                                caisse.setIdrubriquecaisse(p);
                                caisse.setIdmembrecycle(membrecycle);
                                caisse.setMontant(0d);
                                caissees.add(caisse);
                            }
                        } else {
                            for (Rubriquecaisse p : this.getRubriquecaisses1()) {
                                List<Caisse> temp = caisseFacadeLocal.find(membrecycle, p, rencontre);
                                if (temp.isEmpty()) {
                                    Caisse caisse = new Caisse();
                                    caisse.setIdrencontre(rencontre);
                                    caisse.setDateoperation(date);
                                    caisse.setIdrubriquecaisse(p);
                                    caisse.setIdmembrecycle(membrecycle);
                                    caisse.setMontant(0d);
                                    caissees.add(caisse);
                                } else {
                                    caissees.add(temp.get(0));
                                }
                            }
                        }
                    } else {
                        System.err.println("aucune Rubrique");
                    }
                } else {
                    JsfUtil.addErrorMessage("Veuillez selectionnner une ligne");
                }

            } else {
                JsfUtil.addErrorMessage("Veillez selectionner une rencontre");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int sommeTableau(Rubriquecaisse r) {
        int resultcast = 0;
        try {
            if (rencontre != null) {
                List<Caisse> caisse1 = caisseFacadeLocal.findByRubriqueRencontre(r, rencontre);
                for (Caisse c : caisse1) {
                    resultcast += c.getMontant().intValue();

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultcast;
    }

    public Double findAll() {
        Double resultat = 0d;
        try {
            if (rencontre != null) {
                for (Rubriquecaisse r : this.getRubriquecaisses()) {
                    List<Caisse> caisses = caisseFacadeLocal.findByRubriqueRencontre(r, rencontre);
                    for (Caisse c : caisses) {
                        resultat += c.getMontant();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultat;
    }

    public void updateDate() {
        try {
            if (rencontre != null) {
                caissee.setDateoperation(rencontre.getDaterencontre());
                this.updateRubrique();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateRubrique() {
        try {
            if (rencontre != null) {
                this.rubriquecaisses.clear();
                List<Rubriquecaisse> rubriquecaisses = rubriquecaisseFacadeLocal.findAllRangeCode();
                for (Rubriquecaisse r : rubriquecaisses) {
                    List<Caisse> c = caisseFacadeLocal.findByRubriqueRencontre(r, rencontre);
                    if (!c.isEmpty()) {
                        Double montant = 0d;
                        for (Caisse temp : c) {
                            montant += temp.getMontant();
                        }

                        if (montant != 0) {
                            this.rubriquecaisses.add(r);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void save() {
        try {
            if (!caissees.isEmpty()) {
                for (Caisse r : caissees) {
                    if (r.getIdcaisse() == null) {
                        r.setIdcaisse(caisseFacadeLocal.nextId());
                        r.setIdcycle(SessionMBean.getCycletontine());
                        r.setDateoperation(new Date());
                        r.setIdrencontre(rencontre);
                        r.setLibelleoperation("Le Membre  " + r.getIdmembrecycle().getIdmembre().getNom() + " a effectué une opération dans la rubrique caisse " + r.getIdrubriquecaisse().getNomfr());

                        if (!r.getMontant().equals(0d) && !r.getMontant().equals(null)) {
                            caisseFacadeLocal.create(r);
                        }
                    } else {
                        caisseFacadeLocal.edit(r);
                    }
                }
                updateRubrique();
                JsfUtil.addSuccessMessage("Opération réussie");
            } else {
                JsfUtil.addErrorMessage("Le tableau est vide");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Double findCaisse(Membrecycle membrecycle, Rubriquecaisse rubriquecaisse) {
        Double resultat = 0d;
        try {
            if (rencontre.getIdrencontre() != null) {
                rencontre = rencontreFacadeLocal.find(rencontre.getIdrencontre());

                if (membrecycle != null) {
                    if (rubriquecaisse != null) {

                        List<Caisse> caissees = caisseFacadeLocal.find(membrecycle, rubriquecaisse, rencontre);
                        if (!caissees.isEmpty()) {
                            resultat = +caissees.get(0).getMontant();
                        } else {
                            resultat = 0d;
                        }
                    }
                }
                if (resultat == 0d) {
                    resultat = null;
                }
                return resultat;
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Double findBymembre(Membrecycle mc) {
        Double result = 0d;
        try {
            if (rencontre != null) {
                for (Rubriquecaisse r : this.getRubriquecaisses()) {
                    List<Caisse> caisses = caisseFacadeLocal.find(mc, r, rencontre);
                    for (Caisse c : caisses) {
                        result += c.getMontant();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public MouchardFacadeLocal getMouchardFacadeLocal() {
        return mouchardFacadeLocal;
    }

    public void setMouchardFacadeLocal(MouchardFacadeLocal mouchardFacadeLocal) {
        this.mouchardFacadeLocal = mouchardFacadeLocal;
    }

    public Boolean getDetail() {
        return detail;
    }

    public void setDetail(Boolean detail) {
        this.detail = detail;
    }

    public List<Rubriquecaisse> getRubriquecaisses() {
        return rubriquecaisses;
    }

    public void setRubriquecaisses(List<Rubriquecaisse> rubriquecaisses) {
        this.rubriquecaisses = rubriquecaisses;
    }

    public List<Caisse> getCaissees() {

        return caissees;
    }

    public void setCaissees(List<Caisse> caissees) {
        this.caissees = caissees;
    }

    public Caisse getCaissee() {
        return caissee;
    }

    public void setCaissee(Caisse caissee) {
        this.caissee = caissee;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Membrecycle getMembrecycle() {
        return membrecycle;
    }

    public void setMembrecycle(Membrecycle membrecycle) {
        this.membrecycle = membrecycle;
    }

    public List<Membrecycle> getMembrecycles() {
        try {
            if (SessionMBean.getCycletontine() != null) {
                membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return membrecycles;
    }

    public void setMembrecycles(List<Membrecycle> membrecycles) {
        this.membrecycles = membrecycles;
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

    public void setRencontres(List<Rencontre> rencontres) {
        this.rencontres = rencontres;
    }

    public List<Rubriquecaisse> getRubriquecaisses1() {
        try {
            rubriquecaisses1 = rubriquecaisseFacadeLocal.findByEditable(true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rubriquecaisses1;
    }

    public void setRubriquecaisses1(List<Rubriquecaisse> rubriquecaisses1) {
        this.rubriquecaisses1 = rubriquecaisses1;
    }

}
