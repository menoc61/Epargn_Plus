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
import entities.CalculInteret;
import entities.Emprunt;
import entities.Cycletontine;
import entities.Membrecycle;
import entities.Mouchard;
import entities.Remboursement;
import entities.Rencontre;
import entities.Rubriquecaisse;
import entities.TypeRemboursement;
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
import sessions.AvalyseFacadeLocal;
import sessions.CaisseFacadeLocal;
import sessions.CalculInteretFacadeLocal;
import sessions.EmpruntFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.RemboursementFacadeLocal;
import sessions.RencontreFacadeLocal;
import sessions.TypeRemboursementFacadeLocal;
import utilitaire.Utilitaires;

/**
 *
 * @author Abdel Beininfo
 */
@ManagedBean
@ViewScoped
public class RemboursementController implements Serializable {

    @Resource
    UserTransaction ut;

    @EJB
    private RemboursementFacadeLocal remboursementFacadeLocal;
    private Remboursement remboursement = new Remboursement();
    private List<Remboursement> remboursements = new ArrayList<>();

    @EJB
    private EmpruntFacadeLocal empruntFacadeLocal;
    private Emprunt emprunt = new Emprunt();
    private List<Emprunt> emprunts = new ArrayList<>();
    private List<Emprunt> emprunts1 = new ArrayList<>();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre = new Rencontre();
    private List<Rencontre> rencontres = new ArrayList<>();

    @EJB
    private MembrecycleFacadeLocal membrecycleFacadeLocal;
    private Membrecycle membrecycle = new Membrecycle();
    private List<Membrecycle> membrecycles = new ArrayList<>();

    @EJB
    private TypeRemboursementFacadeLocal typeRemboursementFacadeLocal;
    private TypeRemboursement typeRemboursement = new TypeRemboursement();
    private List<TypeRemboursement> typeRemboursements = new ArrayList<>();

    @EJB
    private CalculInteretFacadeLocal calculInteretFacadeLocal;

    private Cycletontine cycletontine = new Cycletontine();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard = new Mouchard();

    @EJB
    private AvalyseFacadeLocal avalyseFacadeLocal;

    @EJB
    private CaisseFacadeLocal caisseFacadeLocal;
    private Caisse caisse = new Caisse();

    private boolean detail = true;
    private boolean showValidateBtn = true;

    private String mode = "";
    private String messageAvalise = "";

    public RemboursementController() {

    }

    @PostConstruct
    private void init() {
        emprunt = new Emprunt();
        mouchard = new Mouchard();
        cycletontine = SessionMBean.getCycletontine();
        try {
            //rencontres = rencontreFacadeLocal.findByCycle(cycletontine, true);
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

    public void validateAvalise() {

    }

    public void updateAvalise() {

    }

    public void updateDate() {
        try {
            if (rencontre != null) {

                showValidateBtn = true;
                remboursement = new Remboursement();
                remboursement.setDaterembour(rencontre.getDaterencontre());
                emprunt = new Emprunt();

                List<CalculInteret> calculInterets = calculInteretFacadeLocal.findByRencontre(rencontre);
                if (calculInterets != null) {
                    showValidateBtn = false;
                } else {
                    JsfUtil.addErrorMessage("Interet non calculé");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateEmprunt() {
        try {
            emprunt = new Emprunt();
            remboursement = new Remboursement();
            remboursement.setInteret(0d);
            remboursement.setMontantRembourse(0d);
            remboursement.setMontanttotal(0d);
            remboursement.setDaterembour(rencontre.getDaterencontre());
            remboursement.setObservation("-");
            emprunts1.clear();
            if (membrecycle != null) {
                for (Emprunt e : emprunts) {
                    if (e.getIdmembre().equals(membrecycle)) {
                        if (!emprunts1.contains(e)) {
                            emprunts1.add(e);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateOther() {
        remboursement.setMontantRembourse(0d);
        remboursement.setInteret(0d);
        remboursement.setMontanttotal(0d);

        if (emprunt != null) {

            emprunt = empruntFacadeLocal.find(emprunt.getIdemprunt());

            remboursement.setCumulInteretAvant(emprunt.getCumulInteret());
            remboursement.setResteCapitalAvant(emprunt.getMontantRemboursable());

            if (!emprunt.getDateDernierRemboursement().equals(rencontre.getDaterencontre()) && rencontre.getDaterencontre().after(emprunt.getDateDernierRemboursement())) {
                int duree = Utilitaires.duration(emprunt.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur();
                if (emprunt.getIdtypeinteret().getIdtypeinteret().equals(2)) {
                    emprunt.setCumulInteret(emprunt.getCumulInteret() + ((emprunt.getMontantRemboursable() * emprunt.getTaux() * duree) / 100));
                } else {
                    emprunt.setCumulInteret(emprunt.getCumulInteret() + (emprunt.getMontantRemboursable() * Math.pow(1 + (emprunt.getTaux() / 100), duree)));
                    emprunt.setCumulInteret(emprunt.getCumulInteret() - emprunt.getMontantRemboursable());
                }
            }
        } else {
            emprunt = new Emprunt();
            JsfUtil.addErrorMessage("Veuillez selectionner un emprunt");
        }
    }

    public void prepareAvalise() {
        messageAvalise = "";
    }

    public void prepareCreate() {
        mode = "Create";
        emprunt = new Emprunt();
        rencontre = new Rencontre();
        remboursement = new Remboursement();
        remboursement.setObservation("-");
        remboursement.setInteret(0d);
        remboursement.setMontantRembourse(0d);
        membrecycles.clear();
        typeRemboursement = new TypeRemboursement();
        membrecycle = new Membrecycle();
        try {
            emprunts = empruntFacadeLocal.findByCycletontine(cycletontine.getIdcycle(), !true);
            for (Emprunt e : emprunts) {
                if (!membrecycles.contains(e.getIdmembre())) {
                    membrecycles.add(e.getIdmembre());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void prepareEdit() {
        mode = "Edit";
        try {
            if (emprunt != null) {

                if (emprunt.getIdmembre() != null) {
                    membrecycle = emprunt.getIdmembre();
                }

                rencontre = emprunt.getIdrencontre();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void save() {
        try {

            if ("Create".equals(mode)) {
                ut.begin();

                caisse.setIdcaisse(caisseFacadeLocal.nextId());
                caisse.setDateoperation(rencontre.getDaterencontre());
                caisse.setIdcycle(cycletontine);
                caisse.setLibelleoperation("Enregistrement du remboursement -> " + remboursement.getMontantRembourse() + " du membre -> " + emprunt.getIdmembre().getIdmembre().getNom() + " " + emprunt.getIdmembre().getIdmembre().getNom());
                caisse.setIdmembrecycle(membrecycle);
                caisse.setMontant(remboursement.getMontantRembourse());
                caisse.setIdrencontre(rencontre);
                caisse.setIdrubriquecaisse(new Rubriquecaisse(8));
                caisseFacadeLocal.create(caisse);

                Emprunt empTemp = empruntFacadeLocal.find(emprunt.getIdemprunt());

                remboursement.setIdremboursement(remboursementFacadeLocal.nextId());
                remboursement.setIdemprunt(emprunt);
                remboursement.setIdrencontre(rencontre);
                remboursement.setIdtyperemboursement(typeRemboursement);

                if (!emprunt.getDateDernierRemboursement().equals(rencontre.getDaterencontre()) && rencontre.getDaterencontre().after(emprunt.getDateDernierRemboursement())) {
                    //quand la date a un ecart
                    int duree = Utilitaires.duration(emprunt.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur();
                    if (emprunt.getIdtypeinteret().getIdtypeinteret().equals(2)) {
                        emprunt.setCumulInteret(emprunt.getCumulInteret() + (((emprunt.getMontantRemboursable()) * emprunt.getTaux() * duree) / 100));
                    } else {
                        emprunt.setCumulInteret(emprunt.getCumulInteret() + (emprunt.getMontantRemboursable() * Math.pow(1 + (emprunt.getTaux() / 100), duree)));
                        emprunt.setCumulInteret(emprunt.getCumulInteret() - emprunt.getMontantRemboursable());
                    }
                    System.err.println("on est a la meme date");
                }

                if (typeRemboursement.getId().equals(1)) {

                    // remboursement de capital
                    if (remboursement.getMontantRembourse() > emprunt.getMontantRemboursable()) {
                        JsfUtil.addErrorMessage("Veuillez verifiez le montant saisi , il est superieur au capital à rembourser");
                        return;
                    }

                    remboursement.setMontanttotal(remboursement.getMontantRembourse());
                    remboursement.setInteret(0d);

                    if ((emprunt.getMontantRemboursable() - remboursement.getMontantRembourse()) <= 0) {
                        if (emprunt.getCumulInteret() <= 0) {
                            emprunt.setRembourse(true);
                        }
                        emprunt.setMontantRemboursable(0d);
                        for (Avalyse a : emprunt.getAvalyseList()) {
                            a.getMembreAvalyste().setMontantavalise(a.getMembreAvalyste().getMontantavalise() + a.getMontantAvalyse());
                            membrecycleFacadeLocal.edit(a.getMembreAvalyste());
                        }
                    } else {
                        emprunt.setRembourse(false);
                        emprunt.setMontantRemboursable(emprunt.getMontantRemboursable() - remboursement.getMontantRembourse());
                    }
                    emprunt.setDateDernierRemboursement(rencontre.getDaterencontre());
                } else {
                    // remboursement d'interet
                    if (remboursement.getMontantRembourse() > emprunt.getCumulInteret()) {
                        JsfUtil.addErrorMessage("Veuillez verifiez le montant saisi , il est supérieur au cumul d'interet à rembourser");
                        return;
                    }

                    emprunt.setCumulInteret(emprunt.getCumulInteret() - remboursement.getMontantRembourse());
                    emprunt.setDateDernierRemboursementInt(rencontre.getDaterencontre());
                    remboursement.setMontanttotal(remboursement.getMontantRembourse());
                    if (emprunt.getCumulInteret() <= 0 && emprunt.getMontantRemboursable() <= 0) {
                        emprunt.setRembourse(true);
                    } else {
                        emprunt.setRembourse(false);
                    }
                    empruntFacadeLocal.edit(emprunt);
                }

                remboursement.setIdcaisse(caisse);
                remboursementFacadeLocal.create(remboursement);

                emprunt.setDateDernierRemboursement(remboursement.getDaterembour());
                empruntFacadeLocal.edit(emprunt);

                ut.commit();

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Enregistrement du remboursement du membre -> " + emprunt.getIdmembre().getIdmembre().getNom() + " " + emprunt.getIdmembre().getIdmembre().getPrenom() + " : " + remboursement.getMontanttotal());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Transaction annulée");
        }
    }

    public void delete() {
        try {
            if (remboursement != null) {

                ut.begin();
                remboursementFacadeLocal.remove(remboursement);

                for (Avalyse a : avalyseFacadeLocal.findByEmprunt(remboursement.getIdemprunt())) {
                    a.getMembreAvalyste().setMontantavalise(a.getMembreAvalyste().getMontantavalise() - a.getMontantAvalyse());
                    membrecycleFacadeLocal.edit(a.getMembreAvalyste());
                }

                remboursement.getIdemprunt().setRembourse(false);

                if (remboursement.getIdtyperemboursement().getId().equals(1)) {
                    //remboursement capital
                    remboursement.getIdemprunt().setMontantRemboursable(remboursement.getIdemprunt().getMontantRemboursable() + remboursement.getMontantRembourse());
                } else {
                    //remboursement interet
                    remboursement.getIdemprunt().setCumulInteret(remboursement.getIdemprunt().getCumulInteret() - remboursement.getMontantRembourse());
                }

                caisseFacadeLocal.remove(remboursement.getIdcaisse());

                //on gère la date de derniere remboursement
                List<Remboursement> rTemp = remboursementFacadeLocal.findByEmprunt(remboursement.getIdemprunt().getIdemprunt());
                if (rTemp.equals(null) || rTemp.isEmpty()) {
                    remboursement.getIdemprunt().setDateDernierRemboursement(remboursement.getIdemprunt().getDateemprunt());
                    remboursement.getIdemprunt().setCumulInteret(0d);
                    remboursement.getIdemprunt().setMontantRemboursable(remboursement.getIdemprunt().getMontantemp());
                } else {
                    remboursement.getIdemprunt().setDateDernierRemboursement(rTemp.get(0).getDaterembour());
                    if (remboursement.getIdtyperemboursement().getId().equals(1)) {

                        //quand la date a un ecart
                        int duree = Utilitaires.duration(remboursement.getIdemprunt().getDateDernierRemboursement(), remboursement.getDaterembour(), 1) / cycletontine.getIdPasEmprunt().getValeur();
                        if (remboursement.getIdemprunt().getIdtypeinteret().getIdtypeinteret().equals(2)) {
                            remboursement.getIdemprunt().setCumulInteret(remboursement.getCumulInteretAvant());
                            remboursement.getIdemprunt().setMontantRemboursable(remboursement.getResteCapitalAvant());
                            //remboursement.getIdemprunt().setCumulInteret((((remboursement.getIdemprunt().getMontantRemboursable()) * remboursement.getIdemprunt().getTaux() * duree) / 100));
                        } else {
                            //remboursement.getIdemprunt().setCumulInteret(remboursement.getIdemprunt().getCumulInteret() + (remboursement.getIdemprunt().getMontantRemboursable() * Math.pow(1 + (remboursement.getIdemprunt().getTaux() / 100), duree)));
                            //remboursement.getIdemprunt().setCumulInteret(remboursement.getIdemprunt().getCumulInteret() - remboursement.getIdemprunt().getMontantRemboursable());
                            remboursement.getIdemprunt().setCumulInteret(remboursement.getCumulInteretAvant());
                            remboursement.getIdemprunt().setMontantRemboursable(remboursement.getResteCapitalAvant());
                        }
                    }
                }
                System.err.println("date dernier remboursement : " + remboursement.getIdemprunt().getDateDernierRemboursement());
                empruntFacadeLocal.edit(remboursement.getIdemprunt());
                ut.commit();

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Annulation du remboursement -> " + remboursement.getIdemprunt().getIdmembre().getIdmembre().getNom() + " " + remboursement.getIdemprunt().getIdmembre().getIdmembre().getPrenom() + " ; Montant -> " + remboursement.getMontantRembourse());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Ce remboursement a été annulé");

            } else {
                JsfUtil.addErrorMessage("Veuillez selectionner une ligne");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Transaction annulée");
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

    public List<Membrecycle> getMembrecycles() {
        return membrecycles;
    }

    public void setMembrecycles(List<Membrecycle> membrecycles) {
        this.membrecycles = membrecycles;
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

    public Remboursement getRemboursement() {
        return remboursement;
    }

    public void setRemboursement(Remboursement remboursement) {
        this.remboursement = remboursement;
    }

    public List<Remboursement> getRemboursements() {
        try {
            remboursements = remboursementFacadeLocal.findByCycle(cycletontine);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return remboursements;
    }

    public void setRemboursements(List<Remboursement> remboursements) {
        this.remboursements = remboursements;
    }

    public List<Emprunt> getEmprunts1() {
        return emprunts1;
    }

    public void setEmprunts1(List<Emprunt> emprunts1) {
        this.emprunts1 = emprunts1;
    }

    public Membrecycle getMembrecycle() {
        return membrecycle;
    }

    public void setMembrecycle(Membrecycle membrecycle) {
        this.membrecycle = membrecycle;
    }

    public Caisse getCaisse() {
        return caisse;
    }

    public void setCaisse(Caisse caisse) {
        this.caisse = caisse;
    }

    public TypeRemboursement getTypeRemboursement() {
        return typeRemboursement;
    }

    public void setTypeRemboursement(TypeRemboursement typeRemboursement) {
        this.typeRemboursement = typeRemboursement;
    }

    public List<TypeRemboursement> getTypeRemboursements() {
        typeRemboursements = typeRemboursementFacadeLocal.findAll();
        return typeRemboursements;
    }

    public void setTypeRemboursements(List<TypeRemboursement> typeRemboursements) {
        this.typeRemboursements = typeRemboursements;
    }

    public boolean isShowValidateBtn() {
        return showValidateBtn;
    }

    public void setShowValidateBtn(boolean showValidateBtn) {
        this.showValidateBtn = showValidateBtn;
    }

}
