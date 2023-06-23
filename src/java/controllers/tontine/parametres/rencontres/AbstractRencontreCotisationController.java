/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine.parametres.rencontres;

import controllers.tontine.SuperController;
import controllers.util.JsfUtil;
import entities.Rencontre;
import org.primefaces.PrimeFaces;

/**
 *
 * @author Louis Stark
 */
public abstract class AbstractRencontreCotisationController extends SuperController {

    private boolean renderedOF = false;

    @Override
    protected void define_modifier_supprimer_detail(Object o) {
        if (o != null && o instanceof Rencontre) {
            modifier = details = supprimer = ((Rencontre) o).getIdrencontre() != null;
        } else {
            modifier = details = supprimer = false;
        }
    }

    @Override
    protected void define_list_rencontres() {
        try {
            list_rencontres = rencontreFacadeLocal.findAll_rencontreOfcotisation();
        } catch (Exception e) {
        }
    }

    public void prepareCreate() {
        try {
            mode = "Create";
            
            rencontre = new Rencontre();
            rencontre.setOuvertureRencontre(false);
            rencontre.setFermetture(false);
            renderedOF = true;

            PrimeFaces.current().executeScript("PF('CreateDialog').show()");
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void prepareEdit() {
        try {
            mode = "Edit";
            renderedOF = false;

            PrimeFaces.current().executeScript("PF('CreateDialog').show()");
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

}
