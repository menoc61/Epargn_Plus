/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine.cassation;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Caisse;
import entities.Cassationtontine;
import entities.Mains;
import entities.Rubriquecaisse;
import java.io.Serializable;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.PrimeFaces;
import utilitaire.Utilitaires;

/**
 *
 * @author Abdel Beininfo
 */
@ManagedBean(name = "cassationTontineController")
@ViewScoped
public class CassationTontineController extends AbstractCassationTontineController implements Serializable {

    public CassationTontineController() {
    }

    @PostConstruct
    private void init() {
        cycletontine = SessionMBean.getCycletontine();
    }

    public void save() {
        try {
            if ("Termine".equals(mode)) {

                if (cotisation.getIdcotisation() == null || cotisation.getIdcotisation() == 0) {
                    throw new Exception("Vous devez selectionner une cotisation... !");
                }

                if (!can_termine()) {
                    throw new Exception("Impossible de terminer une cotisation dont les scéances sont en cours...!");
                }

                ut.begin();

                if (cotisation.getReliquat() > 0) {
                    for (Mains m : list_mains) {

                        caisse = new Caisse();
                        caisse.setIdmembrecycle(m.getIdinscription().getIdmembre());
                        caisse.setMontant(calcul_gains_membre());
                        caisse.setLibelleoperation("Cassation de la cotisation " + cotisation.getNom() + " - gains de " + caisse.getMontant() + " à la main " + m.getNom());
                        caisse.setIdrubriquecaisse(new Rubriquecaisse(27));
                        caisse.setIdcaisse(caisseFacadeLocal.nextId());

                        caisseFacadeLocal.create(caisse);

                        cassationtontine = new Cassationtontine();
                        cassationtontine.setIdmain(m);
                        cassationtontine.setIdcaisse(caisse);
                        cassationtontine.setIdcassation(cassationtontineFacadeLocal.nextId());
                        cassationtontine.setMontant(calcul_gains_membre());

                        cassationtontineFacadeLocal.create(cassationtontine);
                    }
                }

                cotisation.setEstTermine(true);
                cotisationFacadeLocal.edit(cotisation);

                ut.commit();

                Utilitaires.saveOperation("cotisation : " + cotisation.getNom() + " : montant : " + cotisation.getMontant() + " est terminé", SessionMBean.getUser1(), mouchardFacadeLocal);
                JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
                PrimeFaces.current().executeScript("PF('CreerDialog').hide()");

                update_listBenefs();
                
            } else {
                JsfUtil.addErrorMessage("Mode '" + mode + "' non pris encharge");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message " + e.getMessage());
        }
    }

}
