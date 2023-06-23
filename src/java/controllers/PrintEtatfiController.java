/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Membrecycle;
import entities.Rencontre;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.MembrecycleFacadeLocal;
import sessions.RencontreFacadeLocal;
import utilitaire.Printer;

/**
 *
 * @author kenne
 */
@ManagedBean
@ViewScoped
public class PrintEtatfiController implements Serializable{

    /**
     * Creates a new instance of PlanoperationnelController
     */
    private Printer printer = new Printer();

    @EJB
    private MembrecycleFacadeLocal membrecycleFacadeLocal;
    private Membrecycle membrecycle = new Membrecycle();
    private List<Membrecycle> membrecycles = new ArrayList<>();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre = new Rencontre();
    private List<Rencontre> rencontres = new ArrayList<>();

    public PrintEtatfiController() {

    }

    @PostConstruct
    private void init() {
        printer = new Printer();
        membrecycle = new Membrecycle();

    }

    public void print() {
        try {

            if (membrecycle.getIdmembrecycle() != null) {
                Map parameter = new HashMap();
                parameter.put("cycle", membrecycle.getIdmembrecycle());

                printer.print("/reports/rapporttontine/couverturerapporttontine.jasper", parameter);
                System.err.println("Impressin réussie");
            } else {
                JsfUtil.addWarningMessage("Veuillez selectionner un Membre");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void printSituationRecette_DepenseMembre() {
        try {
            Map parameter = new HashMap();
            parameter.put("rencontre", rencontre.getIdrencontre());
            printer.print("/reports/rapporttontine/situationrecette_depense.jasper", parameter);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void printSituationCassation() {
        try {
            Map parameter = new HashMap();
            parameter.put("idcycle", SessionMBean.getCycletontine().getIdcycle());
            printer.print("/reports/cassation/cloture_cycle.jasper", parameter);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void printRecette_Depense() {
        try {
            Map parameter = new HashMap();
            parameter.put("cycle", SessionMBean.getCycletontine().getIdcycle());
            printer.print("/reports/rapporttontine/situation_recette_depense_rencontre.jasper", parameter);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Printer getPrinter() {
        return printer;
    }

    public void setPrinter(Printer printer) {
        this.printer = printer;
    }

    public Membrecycle getMembrecycle() {
        return membrecycle;
    }

    public void setMembrecycle(Membrecycle membrecycle) {
        this.membrecycle = membrecycle;
    }

    public List<Membrecycle> getMembrecycles() {
        try {
            membrecycles = membrecycleFacadeLocal.findByCycle(SessionMBean.getCycletontine());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return membrecycles;
    }

    public void setMembrecycles(List<Membrecycle> membrecycles) {
        this.membrecycles = membrecycles;
    }

    public Rencontre getRencontre() {
        return rencontre;
    }

    public void setRencontre(Rencontre rencontre) {
        this.rencontre = rencontre;
    }

    public List<Rencontre> getRencontres() {
        try {
            rencontres = rencontreFacadeLocal.findByCycleCotisation(SessionMBean.getCycletontine() , false);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rencontres;
    }

    public void setRencontres(List<Rencontre> rencontres) {
        this.rencontres = rencontres;
    }

}
