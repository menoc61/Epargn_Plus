/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine.programmation;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.BeneficiaireTontine;
import entities.Cotisation;
import entities.Encherebenficiare;
import entities.Mains;
import entities.Tontiner;
import java.io.Serializable;
import java.util.Objects;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.PrimeFaces;
import utilitaire.Utilitaires;

/**
 *
 * @author Louis Stark
 */
@ManagedBean(name = "cotisationProgrammationController")
@ViewScoped
public class CotisationProgrammationController extends AbstractCotisationProgrammationController implements Serializable {

    /**
     * Creates a new instance of CotisationProgrammationController
     */
    public CotisationProgrammationController() {
    }

    public void save() {
        try {
            if (mode.equals("Create")) {
                main = mainsFacadeLocal.find(main.getIdmain());
                cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
                tontiner = tontinerFacadeLocal.find(tontiner.getIdtontiner());
                if (!can_add_beneficiaire(tontiner)) {
                    JsfUtil.addErrorMessage("Vous avez atteint la limite de nombre des bénéficiaires pour cette rencontre");
                    return;
                }

                Tontiner temp;
                if (tontiner != null && main != null && cotisation != null) {

                    tontiner.setMontantbeneficie(calcul_montant_doit_bouffer(main));
                    tontiner.setMontantcotise(calcul_montant_cotise_par_rencontre(cotisation));
                    tontiner.setRedevance(calcul_relicat(tontiner));
                    tontiner.setMontantechec(0d);
                    tontiner.setEffectue(false);

                    tontinerFacadeLocal.edit(tontiner);

                    beneficiaireTontine = new BeneficiaireTontine();
                    beneficiaireTontine.setIdmain(main);
                    beneficiaireTontine.setIdtontiner(tontiner);
                    beneficiaireTontine.setIdbeneficiaire(beneficiaireTontineFacadeLocal.nextId());

                    beneficiaireTontineFacadeLocal.create(beneficiaireTontine);

                    Utilitaires.saveOperation("Programmation de la main " + main.getNom() + " effectué", SessionMBean.getUser1(), mouchardFacadeLocal);
                    JsfUtil.addSuccessMessage("Programmation de la main effectué !");
                    PrimeFaces.current().executeScript("PF('ProgrammeMainDialog').hide()");

                    updateData();

                } else {
                    JsfUtil.addErrorMessage("La rencontre et la main n'ont pas été sélectionnées !");
                }

            } else {
                if ("Encherir".equals(mode)) {
                    main = mainsFacadeLocal.find(main.getIdmain());
                    if (!can_add_beneficiaire(tontiner)) {
                        JsfUtil.addErrorMessage("Vous avez atteint la limite de nombre des bénéficiaires pour cette rencontre");
                        return;
                    }

                    if (main != null) {

                        if (calcul_relicat(tontiner) < calcul_montant_doit_bouffer(main)) {
                            throw new Exception("Le reliquat est insuffisant pour programmer cette main à cette période !");
                        }

                        Double mnt_min = (cotisation.getEnchereMin() * cotisation.getMontant()) / 100;
                        Double mnt_max = (cotisation.getEnchereMax() * cotisation.getMontant()) / 100;

                        System.err.println("encher min : " + mnt_min);
                        System.err.println("encher max : " + mnt_max);
                        System.err.println("montant enchere : " + encherebenficiare.getMontant());

                        if (encherebenficiare.getMontant() < mnt_min) {
                            throw new Exception("Montant de l'enchère trop bas !");
                        }

                        if (encherebenficiare.getMontant() > mnt_max) {
                            throw new Exception("Montant de l'enchère trop élévé !");
                        }

                        tontiner.setMontantbeneficie(calcul_montant_doit_bouffer(main));
                        tontiner.setMontantcotise(calcul_montant_cotise_par_rencontre(cotisation));
                        tontiner.setRedevance(calcul_relicat(tontiner));
                        tontiner.setMontantechec(0d);
                        tontiner.setEffectue(false);
                        tontinerFacadeLocal.edit(tontiner);

                        beneficiaireTontine = new BeneficiaireTontine();
                        beneficiaireTontine.setIdmain(main);
                        beneficiaireTontine.setIdtontiner(tontiner);
                        beneficiaireTontine.setIdbeneficiaire(beneficiaireTontineFacadeLocal.nextId());
                        beneficiaireTontineFacadeLocal.create(beneficiaireTontine);

                        encherebenficiare.setIdenchere(encherebenficiareFacadeLocal.nextId());
                        encherebenficiare.setIdbeneficiaire(beneficiaireTontine);
                        encherebenficiareFacadeLocal.create(encherebenficiare);

                        Utilitaires.saveOperation("Programmation de la main " + main.getNom() + " par les encheres effectué", SessionMBean.getUser1(), mouchardFacadeLocal);
                        JsfUtil.addSuccessMessage("Programmation de la main effectué !");
                        PrimeFaces.current().executeScript("PF('EnchereDialog').hide()");

                        updateData();

                    } else {
                        main = new Mains(0);
                        JsfUtil.addErrorMessage("La rencontre et la main n'ont pas été sélectionnées !");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void delete(BeneficiaireTontine b) {
        try {
            if (b != null) {
                encherebenficiare = encherebenficiareFacadeLocal.findBy_benficiaireTontine(b);
                if (encherebenficiare != null) {
                    encherebenficiareFacadeLocal.remove(encherebenficiare);
                }
                beneficiaireTontineFacadeLocal.remove(b);

                Utilitaires.saveOperation("Déprogrammation de la main " + main.getNom() + " effectué", SessionMBean.getUser1(), mouchardFacadeLocal);
                JsfUtil.addSuccessMessage("Déprogrammation de la main effectué !");

                updateData();

                encherebenficiare = new Encherebenficiare();
            } else {
                JsfUtil.addErrorMessage("Veuillez sélectionner le bénéficiaire à déprogrammer !");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void print_calendrier() {
        try {
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());

            if (cotisation != null) {

                jasper_src = src + "calendrier_tontine.jasper";

                //SUBREPORT_DIR = FacesContext.getCurrentInstance().getExternalContext().getRealPath(src + "sub/");
                params.clear();

                params.put("id_association", SessionMBean.getCycletontine().getIdtontine().getIdtontine());
                params.put("id_cotisation", cotisation.getIdcotisation());

                file_name = "calendrier " + cotisation.getNom();

                printer.print(jasper_src, params, file_name);

            } else {
                JsfUtil.addErrorMessage("Aucune tontine choisi !");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void deleteProgarmation() {
        try {
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
            if (cotisation != null) {
                list_tontiner = tontinerFacadeLocal.findAllBy_cotisation(cotisation);

                for (Tontiner t : list_tontiner) {
                    if (t.getEffectue() == null || Objects.equals(t.getEffectue(), Boolean.FALSE)) {
                        list_beneficiairesTontine = beneficiaireTontineFacadeLocal.findBy_tontiner(t);
                        for (BeneficiaireTontine b : list_beneficiairesTontine) {
                            encherebenficiare = encherebenficiareFacadeLocal.findBy_benficiaireTontine(b);
                            encherebenficiareFacadeLocal.remove(encherebenficiare);
                            beneficiaireTontineFacadeLocal.remove(b);
                        }
                        t.setMontantbeneficie(0d);
                        t.setMontantcotise(0d);
                        t.setMontantechec(0d);
                        t.setRedevance(0d);
                        t.setEffectue(false);

                        tontinerFacadeLocal.edit(t);
                    }
                }

                Utilitaires.saveOperation("Reinitialisation de la programmation de la cotisation  " + cotisation.getNom() + " effectué", SessionMBean.getUser1(), mouchardFacadeLocal);
                JsfUtil.addSuccessMessage("Reinitialisation de la programmation effectué !");

                list_tontiner.clear();
                updateData();

            } else {
                cotisation = new Cotisation(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public boolean can_save() {
        if (tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0 && main.getIdmain() != null && main.getIdmain() != 0) {
            return true;
        }
        return false;
    }

    public boolean can_add_beneficiare() {
        return can_add_beneficiaire(tontiner);
    }

}
