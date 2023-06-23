/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Motifaide;
import entities.Mouchard;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.MotifaideFacadeLocal;
import sessions.MouchardFacadeLocal;

/**
 *
 * @author
 */
@ManagedBean
@ViewScoped
public class MotifaideController implements Serializable{

    /**
     * Creates a new instance of MotifaideController
     */
    @EJB
    private MotifaideFacadeLocal motifaideFacadeLocal;
    private Motifaide motifaide;
    private Motifaide selected;
    private List<Motifaide> motifaides = new ArrayList<>();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard;

    private boolean detail = true;

    public MotifaideController() {
    }

    @PostConstruct
    private void init() {
        motifaide = new Motifaide();
        selected = new Motifaide();
        mouchard = new Mouchard();
    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void prepareCreate() {
        motifaide = new Motifaide();
    }

    public void prepareEdit() {

    }

    public void save() {
        try {
            motifaide.setIdmotifaide(motifaideFacadeLocal.nextId());
            motifaideFacadeLocal.create(motifaide);
            mouchard.setIdoperation(mouchardFacadeLocal.nextId());
            mouchard.setAction("Enregistrement du motifaide -> " + motifaide.getNomfr());
            mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
            mouchard.setDateaction(new Date());
            mouchardFacadeLocal.create(mouchard);
            JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
            this.getMotifaides();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void edit() {

        try {
            if (selected.getIdmotifaide() != null) {
                Motifaide u = motifaideFacadeLocal.find(selected.getIdmotifaide());
                motifaideFacadeLocal.edit(selected);
                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Modification du motifaide -> " + u.getNomfr() + " par " + selected.getNomfr());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Le motifaide a été mise à jour");
            } else {
                JsfUtil.addErrorMessage("Veuillez selectionner un motifaide");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.getMotifaides();
        }
    }

    public void delete() {

        try {
            if (selected != null) {
                if (selected.getAideList().isEmpty()) {
                    motifaideFacadeLocal.remove(selected);
                    JsfUtil.addSuccessMessage("Suppression effectuée avec succès");

                } else {
                    JsfUtil.addErrorMessage("Ce motifaide est lié a des Aides et ne peut etre supprimé");
                }
            } else {
                JsfUtil.addErrorMessage("Aucune device selectionnée !");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.getMotifaides();
        }
    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Motifaide getMotifaide() {
        return motifaide;
    }

    public void setMotifaide(Motifaide motifaide) {
        this.motifaide = motifaide;
    }

    public Motifaide getSelected() {
        return selected;
    }

    public void setSelected(Motifaide selected) {
        this.selected = selected;
    }

    public List<Motifaide> getMotifaides() {
        motifaides = motifaideFacadeLocal.findAll();
        return motifaides;
    }

    public void setMotifaides(List<Motifaide> motifaides) {
        this.motifaides = motifaides;
    }

    public Mouchard getMouchard() {
        return mouchard;
    }

    public void setMouchard(Mouchard mouchard) {
        this.mouchard = mouchard;
    }

}
