/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine.sanctions.aides;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Aidecotisation;
import entities.Caisse;
import entities.Rubriquecaisse;
import java.io.Serializable;
import java.util.Date;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import utilitaire.Utilitaires;

/**
 *
 * @author Louis Stark
 */
@ManagedBean(name = "aideCotisationController")
@ViewScoped
public class AideCotisationController extends AbstractAideCotisationController implements Serializable {

    /**
     * Creates a new instance of AideCotisationController
     */
    public AideCotisationController() {
    }

    public void rembourser() {
        try {

            // 1- on verifie que la dette est déjà remboursé
            if (deja_rembourse()) {
                JsfUtil.addSuccessMessage("Dettes déjà remboursé");
                return;
            } else {
                Double penalite_non_cotisation = calcul_penalite_non_cotisation();
                Boolean fin = false;
                for (Aidecotisation aa : list_aidescotisation_temp) {
                    aa.setInteret(calcul_interet_assistance(aa));
                }
                ut.begin();

                // 2- on initie la caisse
                caisse = new Caisse();
                caisse.setIdcycle(SessionMBean.getCycletontine());
                caisse.setIdmembrecycle(cotisationTontine.getIdmain().getIdinscription().getIdmembre());
                caisse.setIdrencontre(cotisationTontine.getIdtontiner().getIdrencontre());
                caisse.setIdtontiner(cotisationTontine.getIdtontiner());
                caisse.setDateoperation(new Date());

                // 3- on sauvegarde la penalite de non cotisation
                caisse.setIdrubriquecaisse(new Rubriquecaisse(19));
                caisse.setMontant(penalite_non_cotisation);
                caisse.setLibelleoperation("Payement de la Pénalité de non cotisation de la main " + cotisationTontine.getIdmain().getNom() + " pour le compte de tontine : " + cotisationTontine.getIdtontiner().getIdcotisation().getNom());

                caisse.setIdcaisse(caisseFacadeLocal.nextId());
                caisseFacadeLocal.create(caisse);

                // 4- on enregistre toutes les opérations de la caisse
                for (Aidecotisation a : list_aidescotisation_temp) {
                    // on reverse le remboursement dans la caisse avant de le faire sortir
                    // 2- on initie la caisse
                    caisse = new Caisse();
                    caisse.setIdcycle(SessionMBean.getCycletontine());
                    caisse.setIdmembrecycle(cotisationTontine.getIdmain().getIdinscription().getIdmembre());
                    caisse.setIdrencontre(cotisationTontine.getIdtontiner().getIdrencontre());
                    caisse.setIdtontiner(cotisationTontine.getIdtontiner());
                    caisse.setDateoperation(new Date());
                    caisse.setIdrubriquecaisse(new Rubriquecaisse(24));
                    caisse.setLibelleoperation("Remboursement de l'assistance de cotisation + Intérêt par la main " + cotisationTontine.getIdmain().getNom() + " pour le compte de tontine : " + cotisationTontine.getIdtontiner().getIdcotisation().getNom());

                    // cas de la caisse : pas d'intérêt
                    if (a.getIdmembrecycle() == null) {
                        caisse.setMontant(a.getMontant());
                    } else {
                        // dans le compte du membre
                        caisse.setMontant(a.getMontant() + a.getInteret());
                    }
                    caisse.setIdcaisse(caisseFacadeLocal.nextId());
                    caisseFacadeLocal.create(caisse);

                    // remboursement au memebre
                    if (a.getIdmembrecycle() != null) {
                        caisse = new Caisse();
                        caisse.setIdcycle(SessionMBean.getCycletontine());
                        caisse.setIdmembrecycle(cotisationTontine.getIdmain().getIdinscription().getIdmembre());
                        caisse.setIdrencontre(cotisationTontine.getIdtontiner().getIdrencontre());
                        caisse.setIdtontiner(cotisationTontine.getIdtontiner());
                        caisse.setDateoperation(new Date());
                        caisse.setIdmembrecycle(a.getIdmembrecycle());
                        caisse.setIdrubriquecaisse(new Rubriquecaisse(25));
                        caisse.setLibelleoperation("Payement du remboursement de l'assistance au membre" + a.getIdmembrecycle().getIdmembre().getNom() + " pour le compte de tontine : " + cotisationTontine.getIdtontiner().getIdcotisation().getNom());
                        caisse.setMontant(a.getMontant() + a.getInteret());
                        caisse.setIdcaisse(caisseFacadeLocal.nextId());

                        caisseFacadeLocal.create(caisse);
                    }

                }
                fin = true;
                ut.commit();

                if (fin) {
                    for (Aidecotisation a : list_aidescotisation_temp) {
                        a.setEtat(true);
                        aidecotisationFacadeLocal.edit(a);
                    }
                }

                JsfUtil.addSuccessMessage("Remboursement de l'assistance éffectué");
                Utilitaires.saveOperation("Remboursement de l'assistance par la main + " + cotisationTontine.getIdmain().getNom(), SessionMBean.getUser1(), mouchardFacadeLocal);

            }

        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public boolean deja_rembourse() {
        try {
            for (Aidecotisation a : list_aidescotisation_temp) {
                System.out.println("Etat :" + a.getEtat());
                if (a.getEtat() != null) {
                    if (a.getEtat() == true) {
                        continue;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public boolean deja_rembourse(Aidecotisation a) {
        try {
            if (a.getEtat() != null) {
                if (a.getEtat() == true) {
                } else {
                    return false;
                }
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        System.out.println("Etat :" + a.getEtat());
        return true;
    }

}
