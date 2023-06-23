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
import entities.FichePresence;
import entities.Mouchard;
import entities.PayementSanction;
import entities.Rencontre;
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
import sessions.FichePresenceFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.PayementSanctionFacadeLocal;
import sessions.RencontreFacadeLocal;

/**
 *
 * @author Abdel Beininfo
 */
@ManagedBean
@ViewScoped
public class PayementsanctionController implements Serializable {

    @Resource
    UserTransaction ut;

    @EJB
    private PayementSanctionFacadeLocal payementSanctionFacadeLocal;
    private PayementSanction payementSanction = new PayementSanction();
    private List<PayementSanction> payementSanctions = new ArrayList<>();

    @EJB
    private FichePresenceFacadeLocal fichePresenceFacadeLocal;
    private FichePresence fichePresence = new FichePresence();
    private List<FichePresence> fichePresences = new ArrayList<>();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre = new Rencontre();
    private List<Rencontre> rencontres = new ArrayList<>();

    private Cycletontine cycletontine = new Cycletontine();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard = new Mouchard();

    @EJB
    private CaisseFacadeLocal caisseFacadeLocal;
    private Caisse caisse = new Caisse();

    private boolean detail = true;
    private boolean showValidateBtn = true;

    private String mode = "";
    private String messageAvalise = "";

    public PayementsanctionController() {

    }

    @PostConstruct
    private void init() {
        mouchard = new Mouchard();
        cycletontine = SessionMBean.getCycletontine();
        try {
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

    public void validateAvalise() {

    }

    public void updateAvalise() {

    }

    public void updateDate() {
        try {
            if (rencontre != null) {
                showValidateBtn = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateEmprunt() {
        try {

            fichePresence = fichePresenceFacadeLocal.find(fichePresence.getId());

            payementSanction = new PayementSanction();
            payementSanction.setMontant(fichePresence.getMontantPenalite());
            payementSanction.setObservation("-");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateOther() {

    }

    public void updateInteret() {

    }

    public void prepareAvalise() {
        messageAvalise = "";
    }

    public void prepareCreate() {
        mode = "Create";
        rencontre = new Rencontre();

        fichePresence = new FichePresence();
        payementSanction = new PayementSanction();
        payementSanction.setObservation("-");
        payementSanction.setMontant(0d);

        try {
            fichePresences = fichePresenceFacadeLocal.findByNonRegle(false);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void prepareEdit() {
        mode = "Edit";
        try {
            if (payementSanction != null) {
                rencontre = payementSanction.getIdrencontre();
                fichePresence = payementSanction.getIdpresence();

                fichePresences.clear();
                fichePresences.add(fichePresence);
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
                caisse.setLibelleoperation("Enregistrement du payement de sanction -> " + payementSanction.getMontant() + " du membre -> " + fichePresence.getIdmembre().getIdmembre().getNom() + " " + fichePresence.getIdmembre().getIdmembre().getPrenom());
                caisse.setIdmembrecycle(fichePresence.getIdmembre());
                caisse.setMontant(payementSanction.getMontant());
                caisse.setIdrencontre(rencontre);
                caisse.setIdrubriquecaisse(new Rubriquecaisse(5));
                caisseFacadeLocal.create(caisse);

                payementSanction.setId(payementSanctionFacadeLocal.nextId());
                payementSanction.setIdpresence(fichePresence);
                payementSanction.setIdrencontre(rencontre);
                payementSanction.setIdcaisse(caisse);
                payementSanctionFacadeLocal.create(payementSanction);

                fichePresence.setRegle(true);
                fichePresenceFacadeLocal.edit(fichePresence);

                ut.commit();

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Enregistrement du payement de la sanction du membre -> " + fichePresence.getIdmembre().getIdmembre().getNom() + " " + fichePresence.getIdmembre().getIdmembre().getPrenom() + " : " + payementSanction.getMontant());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");

            } else {
                if (payementSanction != null) {
                    ut.begin();
                    payementSanctionFacadeLocal.edit(payementSanction);
                    payementSanction.getIdcaisse().setMontant(payementSanction.getMontant());
                    caisseFacadeLocal.edit(payementSanction.getIdcaisse());
                    ut.commit();
                    JsfUtil.addSuccessMessage("Operation reussie");
                } else {
                    JsfUtil.addErrorMessage("Veuillez selectionner une ligne");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete() {
        try {
            if (payementSanction != null) {

                ut.begin();

                payementSanctionFacadeLocal.remove(payementSanction);
                payementSanction.getIdpresence().setRegle(false);
                fichePresenceFacadeLocal.edit(payementSanction.getIdpresence());

                caisseFacadeLocal.remove(payementSanction.getIdcaisse());
                ut.commit();

                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Annulation du payement de sanction -> " + payementSanction.getIdpresence().getIdmembre().getIdmembre().getNom() + " " + payementSanction.getIdpresence().getIdmembre().getIdmembre().getPrenom() + " ; Montant -> " + payementSanction.getMontant());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Cette opération a été annulée");

            } else {
                JsfUtil.addErrorMessage("Veuillez selectionner une ligne");
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

    public boolean isShowValidateBtn() {
        return showValidateBtn;
    }

    public void setShowValidateBtn(boolean showValidateBtn) {
        this.showValidateBtn = showValidateBtn;
    }

    public PayementSanction getPayementSanction() {
        return payementSanction;
    }

    public void setPayementSanction(PayementSanction payementSanction) {
        this.payementSanction = payementSanction;
    }

    public List<PayementSanction> getPayementSanctions() {
        try {
            payementSanctions = payementSanctionFacadeLocal.findByCycle(cycletontine);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return payementSanctions;
    }

    public void setPayementSanctions(List<PayementSanction> payementSanctions) {
        this.payementSanctions = payementSanctions;
    }

    public FichePresence getFichePresence() {
        return fichePresence;
    }

    public void setFichePresence(FichePresence fichePresence) {
        this.fichePresence = fichePresence;
    }

    public List<FichePresence> getFichePresences() {
        return fichePresences;
    }

    public void setFichePresences(List<FichePresence> fichePresences) {
        this.fichePresences = fichePresences;
    }

}
