/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Avalyse;
import entities.Caisse;
import entities.Emprunt;
import entities.Cycletontine;
import entities.Membrecycle;
import entities.Mois;
import entities.Mouchard;
import entities.Rencontre;
import entities.Rubriquecaisse;
import entities.Trancheemprunt;
import entities.Typeinteret;
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
import org.primefaces.PrimeFaces;
import sessions.AvalyseFacadeLocal;
import sessions.CaisseFacadeLocal;
import sessions.EmpruntFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.MoisFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.RencontreFacadeLocal;
import sessions.TrancheempruntFacadeLocal;
import sessions.TypeinteretFacadeLocal;

/**
 *
 * @author Abdel Beininfo
 */
@ManagedBean
@ViewScoped
public class EmpruntController implements Serializable {

    @Resource
    private UserTransaction ut;

    @EJB
    private AvalyseFacadeLocal avalyseFacadeLocal;
    private List<Avalyse> avalyses = new ArrayList<>();

    @EJB
    private EmpruntFacadeLocal empruntFacadeLocal;
    private Emprunt emprunt = new Emprunt();
    private Emprunt selected = new Emprunt();
    private List<Emprunt> emprunts = new ArrayList<>();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre = new Rencontre();
    private List<Rencontre> rencontres = new ArrayList<>();

    @EJB
    private MembrecycleFacadeLocal membrecycleFacadeLocal;
    private Membrecycle membrecycle = new Membrecycle();
    private List<Membrecycle> membrecycles = new ArrayList<>();
    private List<Membrecycle> selectedMembrecycles = new ArrayList<>();

    @EJB
    private MoisFacadeLocal moisFacadeLocal;
    private Mois mois = new Mois();
    private List<Mois> moiss = new ArrayList<>();

    private Cycletontine cycletontine = new Cycletontine();

    @EJB
    private TypeinteretFacadeLocal typeinteretFacadeLocal;
    private Typeinteret typeinteret = new Typeinteret();
    private List<Typeinteret> typeinterets = new ArrayList<>();

    @EJB
    private TrancheempruntFacadeLocal trancheempruntFacadeLocal;
    private Trancheemprunt trancheemprunt = new Trancheemprunt();
    private List<Trancheemprunt> trancheemprunts = new ArrayList<>();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard = new Mouchard();

    @EJB
    private CaisseFacadeLocal caisseFacadeLocal;
    private Caisse caisse = new Caisse();

    private boolean detail = true;

    private String mode = "";
    private String messageAvalise = "";
    private String color = "";

    public EmpruntController() {

    }

    @PostConstruct
    private void init() {
        emprunt = new Emprunt();
        selected = new Emprunt();
        mouchard = new Mouchard();
        cycletontine = new Cycletontine();
        mois = new Mois();
        typeinteret = new Typeinteret();
        cycletontine = SessionMBean.getCycletontine();

        try {
            rencontres = rencontreFacadeLocal.findByCycle(cycletontine, true, false);
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

    public void updateAvalise() {
        try {
            if (!selectedMembrecycles.isEmpty()) {

                if (emprunt.getMontantemp() != 0D && emprunt.getMontantemp() != null) {
                    if (cycletontine.getTauxavaliste() >= 1) {

                        Double somme = 0D;

                        for (Membrecycle m : selectedMembrecycles) {
                            somme += m.getMontantavalise();
                        }

                        if (somme >= ((emprunt.getMontantemp() * cycletontine.getTauxavaliste()) / 100)) {
                            messageAvalise = "Les acteurs peuvent avaliser ce pret ; " + somme + " >= " + ((emprunt.getMontantemp() * cycletontine.getTauxavaliste()) / 100);
                            color = "blue";
                        } else {
                            messageAvalise = "Les acteurs ne peuvent pas avaliser ce pret ; " + somme + " < " + ((emprunt.getMontantemp() * cycletontine.getTauxavaliste()) / 100);
                            color = "red";
                        }
                    } else {
                        messageAvalise = "Montant avalise non important car taux avalise 0%";
                        color = "blue";
                    }
                } else {
                    messageAvalise = "Veuillez saisir le montant de l'emprunt";
                    color = "blue";
                }
            } else {
                messageAvalise = "";
                color = "blue";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateDate() {
        try {
            if (rencontre != null) {
                emprunt.setDateemprunt(rencontre.getDaterencontre());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void prepareAvalise() {
        messageAvalise = "";
        color = "";
        if ("Create".equals(mode)) {
            selectedMembrecycles.clear();
        }
    }

    public void prepareCreate() {
        mode = "Create";
        emprunt = new Emprunt();

        emprunt.setTaux(cycletontine.getTauxInteretDefault());
        emprunt.setTauxInteret(cycletontine.getTauxInteretDefault());

        try {
            membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine , true);
            selectedMembrecycles.clear();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void prepareEdit() {
        mode = "Edit";
        try {
            if (emprunt != null) {

                emprunt = empruntFacadeLocal.find(emprunt.getIdemprunt());

                if (emprunt.getIdmembre() != null) {
                    membrecycle = emprunt.getIdmembre();
                }

                if (emprunt.getIdtypeinteret() != null) {
                    typeinteret = emprunt.getIdtypeinteret();
                }

                rencontre = emprunt.getIdrencontre();

                membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine);
                selectedMembrecycles.clear();

                for (Avalyse a : emprunt.getAvalyseList()) {
                    selectedMembrecycles.add(a.getMembreAvalyste());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void save() {
        try {

            if ("Create".equals(mode)) {

                if (cycletontine.getTauxavaliste() == 0) {

                } else {
                    if (!color.equals("blue")) {
                        JsfUtil.addErrorMessage("Veuillez selectionner les avalistes valables");
                        return;
                    }
                }

                ut.begin();

                caisse.setIdcaisse(caisseFacadeLocal.nextId());
                caisse.setDateoperation(rencontre.getDaterencontre());
                caisse.setIdcycle(cycletontine);
                caisse.setLibelleoperation("Enregistrement de l'emprunt -> " + emprunt.getMontantemp() + " du membre -> " + emprunt.getIdmembre().getIdmembre().getNom() + " " + emprunt.getIdmembre().getIdmembre().getNom());
                caisse.setIdmembrecycle(emprunt.getIdmembre());
                caisse.setMontant(emprunt.getMontantemp());
                caisse.setIdrencontre(rencontre);
                caisse.setIdrubriquecaisse(new Rubriquecaisse(7));
                caisseFacadeLocal.create(caisse);

                emprunt.setIdemprunt(empruntFacadeLocal.nextId());
                emprunt.setIdrencontre(rencontre);
                emprunt.setRembourse(false);
                emprunt.setMontantRemboursable(emprunt.getMontantemp());
                emprunt.setDateDernierRemboursementInt(emprunt.getDateemprunt());
                emprunt.setDateDernierRemboursement(emprunt.getDateemprunt());
                emprunt.setCumulInteret(0d);

                emprunt.setIdcaisse(caisse);
                empruntFacadeLocal.create(emprunt);

                Double montantAvalisable = (emprunt.getMontantemp() * cycletontine.getTauxavaliste()) / 100;
                Double reste = montantAvalisable;

                for (Membrecycle m : selectedMembrecycles) {

                    Avalyse avalyse = new Avalyse();
                    avalyse.setIdavalyse(avalyseFacadeLocal.nextId());
                    avalyse.setIdemprunt(emprunt);
                    avalyse.setMembreAvalyste(m);

                    Double r = m.getMontantavalise() - reste;

                    if (r <= 0) {

                        avalyse.setMontantAvalyse(m.getMontantavalise());
                        avalyseFacadeLocal.create(avalyse);

                        reste -= m.getMontantavalise();

                        m.setMontantavalise(0d);
                        membrecycleFacadeLocal.edit(m);

                    } else {
                        avalyse.setMontantAvalyse(reste);
                        avalyseFacadeLocal.create(avalyse);

                        m.setMontantavalise(m.getMontantavalise() - reste);
                        membrecycleFacadeLocal.edit(m);

                        reste = 0d;
                    }
                }

                ut.commit();

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Enregistrement de l'emprunt  -> " + emprunt.getMontantemp() + " du membre -> " + emprunt.getIdmembre().getIdmembre().getNom() + " " + emprunt.getIdmembre().getIdmembre().getPrenom());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);

                PrimeFaces.current().executeScript("PF('EmpruntCreateDialog').hide()");

                JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");

            } else {
                if (emprunt != null) {

                    //empruntFacadeLocal.edit(emprunt);
                    PrimeFaces.current().executeScript("PF('EmpruntCreateDialog').hide()");

                    JsfUtil.addSuccessMessage("Supprimer et reengistrer");

                } else {
                    PrimeFaces.current().executeScript("PF('EmpruntCreateDialog').hide()");
                    JsfUtil.addErrorMessage("Aucune selectionnée");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Echec execution : " + e);
        }
    }

    public void delete() {
        try {
            if (emprunt != null) {

                ut.begin();

                List<Avalyse> avalyses = avalyseFacadeLocal.findByEmprunt(emprunt);
                if (!avalyses.isEmpty()) {
                    for (Avalyse a : avalyses) {

                        Membrecycle mc = a.getMembreAvalyste();
                        mc.setMontantavalise(mc.getMontantavalise() + a.getMontantAvalyse());

                        membrecycleFacadeLocal.edit(mc);
                        avalyseFacadeLocal.remove(a);
                    }
                }

                empruntFacadeLocal.remove(emprunt);
                caisseFacadeLocal.remove(emprunt.getIdcaisse());

                ut.commit();

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Suppression de l'emprunt -> " + emprunt.getObservtaion());
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

    public Emprunt getEmprunt() {
        return emprunt;
    }

    public void setEmprunt(Emprunt emprunt) {
        this.emprunt = emprunt;
    }

    public Emprunt getSelected() {
        return selected;
    }

    public void setSelected(Emprunt selected) {
        this.selected = selected;
    }

    public List<Emprunt> getEmprunts() {
        try {
            if (SessionMBean.getCycletontine() != null) {
                emprunts = empruntFacadeLocal.findByCycletontine(SessionMBean.getCycletontine().getIdcycle());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return emprunts;
    }

    public void setEmprunts(List<Emprunt> emprunts) {
        this.emprunts = emprunts;
    }

    public Cycletontine getCycletontine() {
        return cycletontine;
    }

    public void setCycletontine(Cycletontine cycletontine) {
        this.cycletontine = cycletontine;
    }

    public Mois getMois() {
        return mois;
    }

    public void setMois(Mois mois) {
        this.mois = mois;
    }

    public List<Mois> getMoiss() {
        moiss = moisFacadeLocal.findAll();
        return moiss;
    }

    public void setMois(List<Mois> moiss) {
        this.moiss = moiss;
    }

    public Typeinteret getTypeinteret() {
        return typeinteret;
    }

    public void setTypeinteret(Typeinteret typeinteret) {
        this.typeinteret = typeinteret;
    }

    public List<Typeinteret> getTypeinterets() {
        typeinterets = typeinteretFacadeLocal.findAll();
        return typeinterets;
    }

    public void setTypeinterets(List<Typeinteret> typeinterets) {
        this.typeinterets = typeinterets;
    }

    public Trancheemprunt getTrancheemprunt() {
        return trancheemprunt;
    }

    public void setTrancheemprunt(Trancheemprunt trancheemprunt) {
        this.trancheemprunt = trancheemprunt;
    }

    public List<Trancheemprunt> getTrancheemprunts() {
        trancheemprunts = trancheempruntFacadeLocal.findAll();
        return trancheemprunts;
    }

    public void setTrancheemprunts(List<Trancheemprunt> trancheemprunts) {
        this.trancheemprunts = trancheemprunts;
    }

    public List<Membrecycle> getMembrecycles() {
        return membrecycles;
    }

    public void setMembrecycles(List<Membrecycle> membrecycles) {
        this.membrecycles = membrecycles;
    }

    public List<Membrecycle> getSelectedMembrecycles() {
        return selectedMembrecycles;
    }

    public void setSelectedMembrecycles(List<Membrecycle> selectedMembrecycles) {
        this.selectedMembrecycles = selectedMembrecycles;
    }

    public String getMessageAvalise() {
        return messageAvalise;
    }

    public void setMessageAvalise(String messageAvalise) {
        this.messageAvalise = messageAvalise;
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

    public Caisse getCaisse() {
        return caisse;
    }

    public void setCaisse(Caisse caisse) {
        this.caisse = caisse;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

}
