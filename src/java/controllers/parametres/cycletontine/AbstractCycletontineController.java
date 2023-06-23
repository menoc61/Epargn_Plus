/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.parametres.cycletontine;

import controllers.tontine.SuperController;
import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Cycletontine;
import entities.Frequencecotisation;
import entities.PasEmprunt;
import entities.Tontine;
import entities.Utilisateurtontine;
import org.primefaces.PrimeFaces;

/**
 *
 * @author Louis Stark
 */
public abstract class AbstractCycletontineController extends SuperController {

    @Override
    protected void define_modifier_supprimer_detail(Object o) {
        if (o != null && o instanceof Cycletontine) {
            modifier = details = supprimer = ((Cycletontine) o).getIdcycle() != null;
            return;
        }
        modifier = details = supprimer = false;
    }

    @Override
    public void define_list_cyclestontine() {
        list_cyclestontine = cycletontineFacadeLocal.findAll();
    }

    @Override
    protected void define_list_pasEmprunt() {
        list_pasemprunt = pasEmpruntFacadeLocal.findAll();
    }

    @Override
    protected void define_list_tontines() {
        try {
            list_tontines.clear();
            for (Utilisateurtontine u : SessionMBean.getTontine()) {
                list_tontines.add(u.getIdtontine());
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message: " + e.getMessage());
        }
    }

    public void prepareEdit() {
        mode = "Edit";
        try {
            if (cycletontine != null) {
                pasEmprunt = cycletontine.getIdPasEmprunt();
                
                if (cycletontine.getIdtontine() != null) {
                    tontine = cycletontine.getIdtontine();
                } else {
                    tontine = new Tontine(0);
                }
            } else {
                pasEmprunt = new PasEmprunt();
            }
            PrimeFaces.current().executeScript("PF('CycleTontineCreateDialog').show()");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void prepareCreate() {
        mode = "Create";
        
        cycletontine = new Cycletontine();
        
        cycletontine.setMontantMinRetard(0d);
        cycletontine.setMontantAbsNonJust(0d);
        cycletontine.setFraisadhesion(0d);
        cycletontine.setUniteEmprunt(0d);
        cycletontine.setTauxInteretDefault(0d);
        cycletontine.setTauxavaliste(0d);
        cycletontine.setMontantSecours(0d);
        cycletontine.setProportionGain(0d);
        cycletontine.setMontantCotisation(0d);
        cycletontine.setNombremembre(0);

        frequencecotisation = new Frequencecotisation(0);
        PrimeFaces.current().executeScript("PF('CycleTontineCreateDialog').show()");
    }

}
