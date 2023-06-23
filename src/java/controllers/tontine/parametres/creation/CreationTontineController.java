/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine.parametres.creation;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Cotisation;
import entities.Rencontre;
import entities.Tontiner;
import java.io.Serializable;
import java.time.Instant;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import org.primefaces.PrimeFaces;
import utilitaire.Utilitaires;

/**
 *
 * @author Abdel Beininfo
 */
@ManagedBean(name = "creationTontineController")
@ViewScoped
public class CreationTontineController extends AbstractCreationTontineController implements Serializable {
    
    public CreationTontineController() {
    }
    
    @PostConstruct
    private void init() {
        cycletontine = SessionMBean.getCycletontine();
    }
    
    public void save() {
        try {
            if ("Create".equals(mode)) {
                
                if (cotisation.getMontant() < 1d) {
                    throw new Exception("Le montant saisi n'est pas valide... !");
                }
                ut.begin();
                
                saveCotisation();
                
                save_rencontrecotisation();
                
                ut.commit();
                
                cotisationFacadeLocal.edit(cotisation);
                
                Utilitaires.saveOperation("Création d'une nouvelle cotisation : " + cotisation.getNom() + " : montant : " + cotisation.getMontant(), SessionMBean.getUser1(), mouchardFacadeLocal);
                JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
                PrimeFaces.current().executeScript("PF('CotisationCreateDialog').hide()");
                
            } else {
                if (mode.equals("Edit")) {
                    
                    if (cotisation != null && cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                        
                        Update_rencontrecotisation();
                        
                        cotisationFacadeLocal.edit(cotisation);
                        
                        Utilitaires.saveOperation("Mise a jour des proprietes de la cotisation : " + cotisation.getNom(), SessionMBean.getUser1(), mouchardFacadeLocal);
                        JsfUtil.addSuccessMessage("Mise a jour des proprietes de la cotisation");
                        PrimeFaces.current().executeScript("PF('CotisationCreateDialog').hide()");
                    } else {
                        JsfUtil.addErrorMessage("Aucune selectionnée");
                    }
                    
                } else {
                    JsfUtil.addErrorMessage("Aucune selectionnée");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message " + e.getMessage());
        }
    }
    
    protected void saveCotisation() throws Exception {
        try {
            
            rencontre = rencontreFacadeLocal.find(rencontre.getIdrencontre());
            if (rencontre == null) {
                throw new Exception("vous n'avez pas choisi le premier jour");
            }
            
            cotisation.setIdcotisation(cotisationFacadeLocal.nextId());
            cotisation.setIdtontine(SessionMBean.getCycletontine().getIdtontine());
            cotisation.setRedevance(0d);
            cotisation.setDateEnregistrement(Date.from(Instant.now()));
            cotisation.setEstTermine(false);
            cotisation.setReliquat(0d);
            cotisation.setIdcycletontine(SessionMBean.getCycletontine());
            
            cotisationFacadeLocal.create(cotisation);
            Utilitaires.saveOperation("Enregistrement de la tontine : " + cotisation.getNom() + " Montant : " + cotisation.getMontant(), SessionMBean.getUser1(), mouchardFacadeLocal);
            JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
            
        } catch (Exception e) {
            throw e;
        }
    }
    
    public void delete() {
        try {
            if (cotisation != null) {
                ut.begin();
                
                if (a_une_programation()) {
                    throw new Exception("Une programmation hexiste déjà pour cette cotisation. Impossible de la supprimer");
                }
                
                List<Tontiner> _temp = tontinerFacadeLocal.findAllBy_cotisation(cotisation);
                
                for (Tontiner t : _temp) {
                    tontinerFacadeLocal.remove(t);
                }
                
                cotisationFacadeLocal.remove(cotisation);
                ut.commit();
                Utilitaires.saveOperation("Suppression de la tontine : " + cotisation.getNom() + " Montant : " + cotisation.getMontant(), SessionMBean.getUser1(), mouchardFacadeLocal);
                JsfUtil.addSuccessMessage("Suppression effectuée avec succès");
            } else {
                JsfUtil.addWarningMessage("Aucune ligne sélectionnée");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }
    
    public void save_rencontrecotisation() throws Exception {
        try {
            if (cotisation != null && cotisation.getIdcotisation() != null) {
                Tontiner _temp;
                for (Rencontre r : list_selected_recontres) {
                    _temp = new Tontiner();
                    _temp.setIdcotisation(cotisation);
                    _temp.setIdrencontre(r);
                    _temp.setEffectue(false);
                    _temp.setIdtontiner(tontinerFacadeLocal.nextId());
                    
                    tontinerFacadeLocal.create(_temp);
                }
                nbre = (tontinerFacadeLocal.findAllBy_cotisation(cotisation)).size();
                cotisation.setNbretours(nbre);
            }
        } catch (Exception e) {
            throw e;
        }
    }
    
    public void Update_rencontrecotisation() throws Exception {
        try {
            if (cotisation != null && cotisation.getIdcotisation() != null) {
                List<Tontiner> _temp = tontinerFacadeLocal.findAllBy_cotisation(cotisation);
                int index;
                for (Tontiner t : _temp) {
                    index = has_selected(t.getIdrencontre());
                    if (index != -1) {
                        list_selected_recontres.remove(index);
                    } else {
                        try {
                            tontinerFacadeLocal.remove(t);
                        } catch (Exception e) {
                            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
                        }
                    }
                }
                save_rencontrecotisation();
            }
        } catch (Exception e) {
            throw e;
        }
    }
    
    public int has_selected(Rencontre r) {
        for (int i = 0; i < list_selected_recontres.size(); i++) {
            if (list_selected_recontres.get(i).getIdrencontre().equals(r.getIdrencontre())) {
                return i;
            }
        }
        return -1;
    }
    
    public void print_bilan(Cotisation c) {
        try {
            cotisation = c;
            if (cotisation != null) {
                
                SUBREPORT_DIR = FacesContext.getCurrentInstance().getExternalContext().getRealPath(src + "sub/");
                jasper_src = src + "cotisation_final.jasper";
                file_name = "bilan_" + cotisation.getNom();
                
                params.clear();
                params.put("id_cotisation", cotisation.getIdcotisation());
                params.put("SUBREPORT_DIR", SUBREPORT_DIR);
                
                printer.print(jasper_src, params, file_name);
                
            } else {
                JsfUtil.addErrorMessage("Aucune cotisation ni rencontre choisi");
                cotisation = new Cotisation(0);
            }
        } catch (Exception e) {
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
            e.printStackTrace();
        }
    }

    /*
     public void save_rencontrecotisation() throws Exception{
     try {
     if (cotisation != null && cotisation.getIdcotisation() != null) {
     Rencontrecotisation _temp;
     for (Rencontre r : list_selected_recontres) {
     _temp = new Rencontrecotisation();
     _temp.setIdcotisation(cotisation);
     _temp.setRenIdrencontre(r);
     _temp.setIdrencontre(rencontrecotisationFacadeLocal.nextId());

     rencontrecotisationFacadeLocal.create(_temp);
     }

     }
     } catch (Exception e) {
     throw e;
     }
     }
     */
    /*
     public void Update_rencontrecotisation() throws Exception{
     try {
     if (cotisation != null && cotisation.getIdcotisation() != null) {
     List<Rencontrecotisation> _temp = rencontrecotisationFacadeLocal.findAllBy_Cotisation(cotisation);
     for (Rencontrecotisation r : _temp) {
     rencontrecotisationFacadeLocal.remove(r);
     }
     save_rencontrecotisation();
     }
     } catch (Exception e) {
     throw e;
     }
     } */
}
