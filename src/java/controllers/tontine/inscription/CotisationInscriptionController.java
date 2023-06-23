/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine.inscription;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.InscriptionCotisation;
import entities.Mains;
import java.io.Serializable;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.PrimeFaces;
import utilitaire.Utilitaires;

/**
 *
 * @author Louis Stark
 */
@ManagedBean(name = "cotisationInscriptionController")
@ViewScoped
public class CotisationInscriptionController extends AbstractCotisationInscriptionController implements Serializable {

    /**
     * Creates a new instance of CotisationInscriptionController
     */
    public CotisationInscriptionController() {

    }

    public void save() {
        try {
            System.out.println("Sauvegare des données");
            if (mode.equals("Add_main")) {
                System.out.println("Ajour d'une main");
                membrecycle = membrecycleFacadeLocal.find(membrecycle.getIdmembrecycle());
                if (membrecycle != null) {

                    inscriptionCotisation = inscriptionCotisationFacadeLocal.findBy_cotisation_membrecycle(cotisation, membrecycle);

                    if (inscriptionCotisation == null) {
                        inscriptionCotisation = new InscriptionCotisation();
                        inscriptionCotisation.setEtat(false);
                        inscriptionCotisation.setIdcotisation(cotisation);
                        inscriptionCotisation.setIdmembre(membrecycle);
                        inscriptionCotisation.setIdinscription(inscriptionCotisationFacadeLocal.nextId());

                        inscriptionCotisationFacadeLocal.create(inscriptionCotisation);
                        Utilitaires.saveOperation("Inscription de " + inscriptionCotisation.getIdmembre().getIdmembre().getNom() + " à la tontine : " + cotisation.getNom(), SessionMBean.getUser1(), mouchardFacadeLocal);
                    }

                    main.setIdinscription(inscriptionCotisation);
                    main.setCodemain(def_code_main(main));
                    main.setEchec(false);
                    main.setIdmain(mainsFacadeLocal.nextId());

                    mainsFacadeLocal.create(main);
                    Utilitaires.saveOperation("Ajout d'une main pour le membre " + main.getIdinscription().getIdmembre().getIdmembre().getNom(), SessionMBean.getUser1(), mouchardFacadeLocal);

                    JsfUtil.addSuccessMessage("Ajout de la main éffectué");
                    PrimeFaces.current().executeScript("PF('AddMainDialog').hide()");
                    System.out.println("Succes");

                } else {
                    System.out.println("echec");
                    JsfUtil.addErrorMessage("Aucun membre ne correspond !");
                }
                System.out.println("Ajout de main terminé");
            }
        } catch (Exception e) {
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void delete() {
        try {
            if (main != null) {
                if (main.getIdmain() != null && main.getIdmain() != 0) {
                    if (a_deja_touche(main) != null) {
                         JsfUtil.addSuccessMessage("Cette main a déjà bouufée");
                    } else {
                        if (a_dej_cotise(main)) {
                             JsfUtil.addSuccessMessage("Cette main a déjà cotisée");
                        } else {
                            mainsFacadeLocal.remove(main);
                            Utilitaires.saveOperation("Suppression de la main du membre : " + main.getIdinscription().getIdmembre().getIdmembre().getNom(), SessionMBean.getUser1(), mouchardFacadeLocal);
                            JsfUtil.addSuccessMessage("Suppression de la main éffectué");
                        }
                    }
                    main = new Mains();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }
    
    public void delete (Mains m) {
        this.main = m;
        delete();
    }
}
