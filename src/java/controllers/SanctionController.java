/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Sanction;
import entities.Mouchard;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.SanctionFacadeLocal;
import sessions.MouchardFacadeLocal;

/**
 *
 * @author
 */
@ManagedBean
@ViewScoped
public class SanctionController implements Serializable{

    /**
     * Creates a new instance of SanctionController
     */
    @EJB
    private SanctionFacadeLocal sanctionFacadeLocal;
    private Sanction sanction;
    private Sanction selected;
    private List<Sanction> sanctions = new ArrayList<>();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard;

    private boolean detail = true;

    public SanctionController() {
    }

    @PostConstruct
    private void init() {
        sanction = new Sanction();
        selected = new Sanction();
        mouchard = new Mouchard();
    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void prepareCreate() {
        sanction = new Sanction();
    }

    public void prepareEdit() {

    }

    public void save() {
        try {
            sanction.setIdtsanction(sanctionFacadeLocal.nextId());
            sanctionFacadeLocal.create(sanction);
            mouchard.setIdoperation(mouchardFacadeLocal.nextId());
            mouchard.setAction("Enregistrement du sanction -> " + sanction.getNomFr());
            mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
            mouchard.setDateaction(new Date());
            mouchardFacadeLocal.create(mouchard);
            JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
            this.getSanctions();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void edit() {

        try {
            if (selected.getIdtsanction() != null) {
                Sanction u = sanctionFacadeLocal.find(selected.getIdtsanction());
                sanctionFacadeLocal.edit(selected);
                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Modification du sanction -> " + u.getNomFr() + " par " + selected.getNomFr());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Le sanction a été mise à jour");
            } else {
                JsfUtil.addErrorMessage("Veuillez selectionner un sanction");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.getSanctions();
        }
    }

    public void delete() {

        try {
            if (selected != null) {
                if (selected.getTontineList().isEmpty()) {
                    sanctionFacadeLocal.remove(selected);
                    JsfUtil.addSuccessMessage("Suppression effectuée avec succès");

                } else {
                    JsfUtil.addErrorMessage("Ce sanction est lié a des Tontines et ne peut etre supprimé");
                }
            } else {
                JsfUtil.addErrorMessage("Aucune Sanction selectionnée !");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.getSanctions();
        }
    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Sanction getSanction() {
        return sanction;
    }

    public void setSanction(Sanction sanction) {
        this.sanction = sanction;
    }

    public Sanction getSelected() {
        return selected;
    }

    public void setSelected(Sanction selected) {
        this.selected = selected;
    }

    public List<Sanction> getSanctions() {
        sanctions = sanctionFacadeLocal.findAll();
        return sanctions;
    }

    public void setSanctions(List<Sanction> sanctions) {
        this.sanctions = sanctions;
    }

    public Mouchard getMouchard() {
        return mouchard;
    }

    public void setMouchard(Mouchard mouchard) {
        this.mouchard = mouchard;
    }

}
