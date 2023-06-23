/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine.parametres.rencontres;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Rencontre;
import java.io.Serializable;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.PrimeFaces;
import utilitaire.Utilitaires;

/**
 *
 * @author Louis Stark
 */
@ManagedBean(name = "rencontreCotisationController")
@ViewScoped
public class RencontreCotisationController extends AbstractRencontreCotisationController implements Serializable{

    /**
     * Creates a new instance of RencontreCotisationController
     */
    public RencontreCotisationController() {
    }

    public void save() {
        try {
            if ("Create".equals(mode)) {

                Rencontre temp = rencontreFacadeLocal.findBy_date_tontine(rencontre.getDaterencontre(), SessionMBean.getCycletontine().getIdtontine());
                if (temp == null) {
                    rencontre.setIdrencontre(rencontreFacadeLocal.nextId());
                    rencontre.setIdcycle(SessionMBean.getCycletontine());
                    rencontre.setIsRencontreCotisation(true);
                    rencontre.setOuvertureRencontre(false);
                    rencontre.setFermetture(false);
                    rencontre.setIdTontine(SessionMBean.getCycletontine().getIdtontine());
                    rencontreFacadeLocal.create(rencontre);
                } else {
                    temp.setIdTontine(SessionMBean.getCycletontine().getIdtontine());
                    temp.setIsRencontreCotisation(true);
                    rencontreFacadeLocal.edit(temp);
                }
                Utilitaires.saveOperation("Enregistrement du Rencontre : " + rencontre.getNomfr(), SessionMBean.getUser1(), mouchardFacadeLocal);
                JsfUtil.addSuccessMessage("Rencontre enregistré");       
                PrimeFaces.current().executeScript("PF('CreateDialog').hide()");
            } else {
                if ("Edit".equals(mode)) {
                    if (rencontre.getIdrencontre() != null && rencontre.getIdrencontre() != 0) {
                        rencontreFacadeLocal.edit(rencontre);

                        Utilitaires.saveOperation("Enregistrement des modifications sur la Rencontre : " + rencontre.getNomfr(), SessionMBean.getUser1(), mouchardFacadeLocal);
                        JsfUtil.addSuccessMessage("Modifications enregistrées");
                        
                        PrimeFaces.current().executeScript("PF('CreateDialog').hide()");
                    }
                } else {
                    JsfUtil.addErrorMessage("Mode non disponible");
                }
            }

        } catch (Exception e) {
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void delete() {
        try {
            if (rencontre.getIdrencontre() != null) {
                rencontreFacadeLocal.remove(rencontre);
                JsfUtil.addSuccessMessage("Opération réussie");
            } else {
                JsfUtil.addErrorMessage("veuillez selectionner un Rencontre");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }
    
}
