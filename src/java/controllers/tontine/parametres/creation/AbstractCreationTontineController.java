/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine.parametres.creation;

import controllers.tontine.SuperController;
import controllers.util.JsfUtil;
import entities.BeneficiaireTontine;
import entities.Cotisation;
import entities.Rencontre;
import entities.Tontiner;
import java.util.ArrayList;
import java.util.List;
import org.primefaces.PrimeFaces;

/**
 *
 * @author Louis Stark
 */
public abstract class AbstractCreationTontineController extends SuperController {

    protected Integer nbre = 0;

    protected List<Rencontre> list_selected_recontres = new ArrayList<>();

    @Override
    protected void define_modifier_supprimer_detail(Object o) {
        if (o != null && o instanceof Cotisation) {
            modifier = details = supprimer = ((Cotisation) o).getIdcotisation() != null;
        } else {
            modifier = details = supprimer = false;
        }
    }

    @Override
    protected void define_list_membrecycle() {
        try {
            list_membrecycle = membrecycleFacadeLocal.findByCycle(cycletontine);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void define_list_rencontres() {
        try {
            list_rencontres = rencontreFacadeLocal.findAll_rencontreOfcotisation();
        } catch (Exception e) {
        }
    }

    public List<Rencontre> selectableRencontres() {
        /*List<Rencontre> _result = new ArrayList<>();
         if (can_choose_rencontre()) {
         _result = rencontreFacadeLocal.findAll_rencontreOfcotisation_after_date(cotisation.getPremierjour().getDaterencontre());
         }
         return  _result;*/

        if (!list_rencontres.isEmpty()) {
            List<Rencontre> rencontres = new ArrayList<>();
            rencontres.addAll(list_rencontres);
            if(rencontre!=null){
                rencontres.remove(rencontre);
                return rencontres;
            }
        }
        return new ArrayList<>();

    }

    public boolean can_choose_rencontre() {
        try {
            rencontre = rencontreFacadeLocal.find(rencontre.getIdrencontre());
            if (rencontre != null) {
                cotisation.setPremierjour(rencontre);
                return true;
            } else {
                rencontre = new Rencontre(0);
            }
        } catch (Exception e) {
        }
        return false;
    }

    public void prepareCreate() {
        mode = "Create";

        cotisation = new Cotisation();
        cotisation.setMontant(0d);
        cotisation.setNbretours(0);
        cotisation.setPenaliteNonCotisationABouffe(0d);
        cotisation.setPenaliteNonCotisation(0d);
        cotisation.setInteretAssistanceCotisation(0d);
        nbre = 0;

        list_selected_recontres.clear();

        //PrimeFaces.current().executeScript("wiz.loadStep(wiz.cfg.step[0], true)");
        PrimeFaces.current().executeScript("PF('CotisationCreateDialog').show()");
    }

    public void prepareEdit() {
        try {
            if (cotisation != null) {
                mode = "Edit";

                if (cotisation.getPremierjour() != null) {
                    rencontre = cotisation.getPremierjour();
                } else {
                    rencontre = new Rencontre(0);
                }

                list_selected_recontres.clear();
                //List<Rencontrecotisation> _temp = rencontrecotisationFacadeLocal.findAllBy_Cotisation(cotisation);
                List<Tontiner> _temp = tontinerFacadeLocal.findAllBy_cotisation(cotisation);
                for (Tontiner t : _temp) {
                    list_selected_recontres.add(t.getIdrencontre());
                }
                nbre = list_selected_recontres.size();
                PrimeFaces.current().executeScript("PF('CotisationCreateDialog').show()");
            } else {
                JsfUtil.addErrorMessage("Aucune ligne sélectionné");
            }
        } catch (Exception e) {
            JsfUtil.addErrorMessage(e, "Message Error: " + e.getMessage());
        }
    }

    public void updateData() {
        if (cotisation != null) {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                list_mains = mainsFacadeLocal.findAll_by_Cotisation(cotisation);
            } else {
                list_mains.clear();
            }
        } else {
            list_mains.clear();
        }
    }

    public List<Rencontre> getList_selected_recontres() {
        return list_selected_recontres;
    }

    public void setList_selected_recontres(List<Rencontre> list_selected_recontres) {
        this.list_selected_recontres = list_selected_recontres;
    }

    public void determine_nbre_rencontre() {
        try {
            nbre = list_selected_recontres.size();
        } catch (Exception e) {
            nbre = 0;
            e.printStackTrace();
        }
    }

    public boolean a_une_programation() {
        if (cotisation != null && cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
            List<BeneficiaireTontine> _temp = beneficiaireTontineFacadeLocal.findBy_cotisation(cotisation);
            return !_temp.isEmpty();
        }
        return false;
    }

    public void setNbre(Integer nbre) {
        this.nbre = nbre;
    }

    public Integer getNbre() {
        return nbre;
    }

}
