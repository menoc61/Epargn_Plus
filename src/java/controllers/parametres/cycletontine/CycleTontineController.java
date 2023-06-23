/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.parametres.cycletontine;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Rencontre;
import java.io.Serializable;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import utilitaire.Utilitaires;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class CycleTontineController extends AbstractCycletontineController implements Serializable {

    public CycleTontineController() {

    }

    @PostConstruct
    private void init() {

    }

    public void save() {
        try {
            /*
            if (tontine.getIdtontine() != null) {
                tontine = tontineFacadeLocal.find(tontine.getIdtontine());
                cycletontine.setIdtontine(tontine);
            }
            */
            if (pasEmprunt.getIdpas() != null) {
                pasEmprunt = pasEmpruntFacadeLocal.find(pasEmprunt.getIdpas());
                cycletontine.setIdPasEmprunt(pasEmprunt);
            }

            if ("Create".equals(mode)) {
                cycletontine.setIdcycle(cycletontineFacadeLocal.nextId());
                cycletontine.setTransfere(false);
                cycletontineFacadeLocal.create(cycletontine);

                //this.programmation_rencontres();

                Utilitaires.saveOperation("Enregistrement du cycle Tontine  -> " + cycletontine.getNomfr(), SessionMBean.getUser1(), mouchardFacadeLocal);
                JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
            } else {
                if (mode.equals("Edit")) {
                    if (cycletontine != null && cycletontine.getIdcycle() != null) {
                        cycletontineFacadeLocal.edit(cycletontine);

                        //this.programmation_rencontres();

                        Utilitaires.saveOperation("Modification du Cycle de Tontine ->  " + cycletontine.getNomfr() + " -> " + cycletontine.getNomfr(), SessionMBean.getUser1(), mouchardFacadeLocal);

                        JsfUtil.addSuccessMessage("Le Cycle Tontine a été mis à jour");
                    } else {
                        JsfUtil.addSuccessMessage("Aucun cycle choisi");
                    }

                } else {
                    JsfUtil.addErrorMessage("Aucune selectionnée");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Exception systeme : verifier le formulaire");
        }
    }

    public void delete() {
        try {

            if (cycletontine.getIdcycle() != null) {
                cycletontineFacadeLocal.remove(cycletontine);
                Utilitaires.saveOperation("Suppression du cycle " + cycletontine.getNomfr(), SessionMBean.getUser1(), mouchardFacadeLocal);
            } else {
                JsfUtil.addErrorMessage("Aucune ligne selectionnée");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Suppression impossible");
        }
    }
/*
    public void programmation_rencontres() throws Exception {
        try {
            cycletontine = cycletontineFacadeLocal.find(cycletontine.getIdcycle());
            if (cycletontine != null) {
                if (cycletontine.getIdfrequencerencontre() == null) {
                    return;
                }
                System.out.println("-- Programmation des rencontres");
                Date date_r = cycletontine.getPremierjour();
                System.out.println("Date cotisation : " + date_r);
                int intervale;
                Rencontre r, r1;

                if (cycletontine.getNbretours() == null) {
                    throw new Exception("le nombre de rencontre n'est pas fixé");
                }

                for (int i = 0; i < cycletontine.getNbretours(); i++) {

                    if (i == 0) {
                        intervale = 0;
                    } else {
                        intervale = cycletontine.getIdfrequencerencontre().getValeur();
                    }
                    date_r = Utilitaires.prochaine_date(date_r, intervale);

                    r = new Rencontre();
                    r.setDaterencontre(date_r);
                    r.setNomfr("Rencontre du - " + Utilitaires.date_jour(date_r, new Locale("FR", "fr")));
                    r.setNomen("Meeting of  - " + Utilitaires.date_jour(date_r, new Locale("EN", "en")));
                    r.setFermetture(false);
                    r.setIdcycle(cycletontine);

                    r1 = verifie_existance_rencontre(r);
                    if (r1 != null) {
                        r = r1;
                    } else {
                        r.setIdrencontre(rencontreFacadeLocal.nextId());
                        rencontreFacadeLocal.create(r);
                    }

                }
            }
        } catch (Exception e) {
            throw e;
        }
    }
*/
    protected Rencontre verifie_existance_rencontre(Rencontre r) {
        try {
            return rencontreFacadeLocal.findBy_date_cycle(r.getDaterencontre(), cycletontine);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
