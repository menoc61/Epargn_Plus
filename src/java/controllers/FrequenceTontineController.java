/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Mouchard;
import entities.Frequencetontine;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.MouchardFacadeLocal;
import sessions.FrequencetontineFacadeLocal;

/**
 *
 * @author
 */
@ManagedBean
@ViewScoped
public class FrequenceTontineController implements Serializable{

    /**
     * Creates a new instance of GroupeUtilisateurController
     */
    @EJB
    private FrequencetontineFacadeLocal FrequencetontineFacadeLocal;
    private Frequencetontine Frequencetontine;
    private List<Frequencetontine> Frequencetontines = new ArrayList<>();
    private Frequencetontine SelectedFrequencetontine;

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard;

    private boolean detail = true;

    public FrequenceTontineController() {

    }

    @PostConstruct
    private void init() {
        mouchard = new Mouchard();
        SelectedFrequencetontine = new Frequencetontine();
        Frequencetontine = new Frequencetontine();
    }

    public void prepareCreate() {
        Frequencetontine = new Frequencetontine();
        SelectedFrequencetontine = new Frequencetontine();
    }

    public void prepareEdit() {

    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void save() {
        try {
            Frequencetontine tranchecotisation = FrequencetontineFacadeLocal.findByNom(Frequencetontine.getNomFr());
            if (tranchecotisation == null) {
                Frequencetontine.setIdfreqtontine(FrequencetontineFacadeLocal.nextId());
                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Enregistrement d'une Fréqunce : " + Frequencetontine.getNomFr());
                mouchard.setDateaction(new Date());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                FrequencetontineFacadeLocal.create(Frequencetontine);
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage(" Fréquence enregistré");
            } else {
                JsfUtil.addErrorMessage("Ce nom existe deja");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void edit() {
        if (SelectedFrequencetontine.getIdfreqtontine()!= null) {
            Frequencetontine gr = FrequencetontineFacadeLocal.find(SelectedFrequencetontine.getIdfreqtontine());
            FrequencetontineFacadeLocal.edit(SelectedFrequencetontine);
            mouchard.setAction("Modification d'une Fréquence: " + gr.getNomFr() + " -> " + " " + SelectedFrequencetontine.getNomFr());
            mouchard.setDateaction(new Date());
            mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
            //mouchardFacadeLocal.create(mouchard);
            JsfUtil.addSuccessMessage("Tranche Emprunt  mis à jour");
        } else {
            JsfUtil.addErrorMessage("veuillez selectionnez une Tranche Emprunt");
        }
    }

    public void delete() {
        if (SelectedFrequencetontine.getIdfreqtontine()!= null) {
            if (SelectedFrequencetontine.getTontineList().isEmpty()) {
                mouchard.setAction("Suppression Frequence" + SelectedFrequencetontine.getNomFr());
                mouchard.setDateaction(new Date());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                FrequencetontineFacadeLocal.remove(SelectedFrequencetontine);
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Opération réussie");
            } else {
                JsfUtil.addErrorMessage("Cet Fréquence est portée par une Tontine donc ne peut etre supprimé ");

            }
        } else {
            JsfUtil.addErrorMessage("veuillez selectionner une Fréquence");
        }

    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Frequencetontine getFrequencetontine() {
        return Frequencetontine;
    }

    public void setFrequencetontine(Frequencetontine Frequencetontine) {
        this.Frequencetontine = Frequencetontine;
    }

    public List<Frequencetontine> getFrequencetontines() {
        Frequencetontines = FrequencetontineFacadeLocal.findAll();
        return Frequencetontines;
    }

    public void setFrequencetontines(List<Frequencetontine> Frequencetontines) {
        this.Frequencetontines = Frequencetontines;
    }

    public Frequencetontine getSelectedFrequencetontine() {
        return SelectedFrequencetontine;
    }

    public void setSelectedFrequencetontine(Frequencetontine SelectedFrequencetontine) {
        this.SelectedFrequencetontine = SelectedFrequencetontine;
    }

}
