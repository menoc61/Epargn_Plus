/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Frequencetontine;
import entities.Tranchecotisation;
import entities.Cycletontine;
import entities.Mouchard;
import entities.Devise;
import entities.Groupeutilisateur;
import entities.Utilisateur;
import entities.Modepaiement;
import entities.Pays;
import entities.Rubriquecaisse;
import entities.Sanction;
import entities.Tontine;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.model.file.UploadedFile;
import sessions.FrequencetontineFacadeLocal;
import sessions.TranchecotisationFacadeLocal;
import sessions.CycletontineFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.DeviseFacadeLocal;
import sessions.GroupeutilisateurFacadeLocal;
import sessions.UtilisateurFacadeLocal;
import sessions.ModepaiementFacadeLocal;
import sessions.PaysFacadeLocal;
import sessions.RubriquecaisseFacadeLocal;
import sessions.SanctionFacadeLocal;
import sessions.TontineFacadeLocal;
import utilitaire.Utilitaires;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class TontineController implements Serializable{

    /**
     * Creates a new instance of TontineController
     */
    @EJB
    private TontineFacadeLocal tontineFacadeLocal;

    private Tontine tontine;
    private Tontine selected;
    private List<Tontine> tontines = new ArrayList<>();

   @EJB
   private CycletontineFacadeLocal cycletontineFacadeLocal;
   private Cycletontine cycletontine;
   private List<Cycletontine> cycletontines = new ArrayList<>();
   
   @EJB
    private DeviseFacadeLocal deviseFacadeLocal;
    private Devise devise = new Devise();
    private List<Devise> devises = new ArrayList<>();
    
    @EJB
    private SanctionFacadeLocal sanctionFacadeLocal;
    private Sanction sanction = new Sanction();
    private List<Sanction> sanctions = new ArrayList<>();
    private List<Sanction> selectedsanctions = new ArrayList<>();
    
    @EJB
    private ModepaiementFacadeLocal modepaiementFacadeLocal;
    private Modepaiement modepaiement = new Modepaiement();
    private List<Modepaiement> modepaiements = new ArrayList<>();
    
    @EJB
    private RubriquecaisseFacadeLocal rubriquecaisseFacadeLocal;
    private Rubriquecaisse rubriquecaisse = new Rubriquecaisse();
    private List<Rubriquecaisse> rubriquecaisses = new ArrayList<>();
    private List<Rubriquecaisse> selectedrubriquecaisse = new ArrayList<>();

    @EJB
    private TranchecotisationFacadeLocal tranchecotisationFacadeLocal;
    private Tranchecotisation tranchecotisation = new Tranchecotisation();
    private List<Tranchecotisation> tranchecotisations = new ArrayList<>();
    private List<Tranchecotisation> selectedtranchecotisation = new ArrayList<>();

    @EJB
    private FrequencetontineFacadeLocal frequencetontineFacadeLocal;
    private Frequencetontine frequencetontine = new Frequencetontine();
    private List<Frequencetontine> frequencetontines = new ArrayList<>();

    @EJB
    private UtilisateurFacadeLocal utilisateurFacade;
    private Utilisateur utilisateur;
    private List<Utilisateur> utilisateurs = new ArrayList<>();
    
    @EJB
    private GroupeutilisateurFacadeLocal GroupeutilisateurFacadeLocal;
    private Groupeutilisateur groupeutilisateur;
    private List<Groupeutilisateur> groupeutilisateurs = new ArrayList<>();
    
    @EJB
    private PaysFacadeLocal paysFacadeLocal;
    private Pays pays;
    private List<Pays> payss = new ArrayList<>();
    
    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard;

    private boolean detail = true;

    private String mode = "";
    
    private String fichier_carte = null;
    private String photo = "";
    private Date date;
    UploadedFile file;
    private String repertoire = Utilitaires.path + "/" + Utilitaires.repertoireDefautVehicule;
    private String fichier = Utilitaires.nomFichierParDefautListeVehicule;
    private final String destination = Utilitaires.path + "/resources/images/";

    public TontineController() {

    }

    @PostConstruct
    private void init() {
        tontine = new Tontine();
        selected = new Tontine();
        mouchard = new Mouchard();
        tranchecotisation = new Tranchecotisation();
        frequencetontine = new Frequencetontine();
        cycletontine=new Cycletontine();
        devise=new Devise();       
        cycletontines = cycletontineFacadeLocal.findAll();
        
       
    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void prepareCreate() {
        mode = "Create";
        tontine = new Tontine();
    }

    public void prepareEdit() {
        mode = "Edit";
         try {
           
           frequencetontines =  frequencetontineFacadeLocal.findAll();
           devises = deviseFacadeLocal.findAll();
           modepaiements = modepaiementFacadeLocal.findAll();
             if (tontine != null) {
               
                 if (tontine.getIddevices() != null) {
                    devise = tontine.getIddevices();
                }
                if(tontine.getIdfreqtontine() != null){
                   frequencetontine = tontine.getIdfreqtontine();
                }

                if (tontine.getIdmdepaiement()!= null) {
                    modepaiement= tontine.getIdmdepaiement();
                }
                
               if (tontine.getIdtranchecotisation()!= null) {
                    tranchecotisation = tontine.getIdtranchecotisation();
                }
               
                if (tontine.getIdtsanction()!= null) {
                    sanction= tontine.getIdtsanction();
                }
                
                if (tontine.getIdrubriquecaisse()!= null) {
                    rubriquecaisse= tontine.getIdrubriquecaisse();
                }
                
        } 
         }catch (Exception e) {
            e.printStackTrace();
        }

  }


    public void save() {
        try {
           
            if ("Create".equals(mode)) {
                tontine.setIdtontine(tontineFacadeLocal.nextId());             
                tontine.setIdfreqtontine(frequencetontine);
                tontine.setIddevices(devise);
                tontine.setIdmdepaiement(modepaiement);
                tontineFacadeLocal.create(tontine); 
                
                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Enregistrement de la tontine  -> " + tontine.getNom());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                
                JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
            } else {
                if (tontine != null) {
                    Tontine f = tontineFacadeLocal.find(tontine.getIdtontine());
                    tontineFacadeLocal.edit(tontine);
                    mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                    mouchard.setAction("Modification de l'tontine ->  " + f.getNom()+ " -> " + tontine.getNom());
                    mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                    mouchard.setDateaction(new Date());
                    mouchardFacadeLocal.create(mouchard);
                    detail = true;
                    JsfUtil.addSuccessMessage("La tontine a été mis à jour");
                } else {
                    JsfUtil.addErrorMessage("Aucune selectionnée");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void delete() {
        try {
            if (tontine != null) {
                
                tontineFacadeLocal.remove(tontine);
                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Suppression de la tontine -> " + tontine.getNom());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Suppression effectuée avec succès");
               
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

   
    

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Tontine getTontine() {
        return tontine;
    }

    public void setTontine(Tontine tontine) {
        this.tontine = tontine;
    }

    public Tontine getSelected() {
        return selected;
    }

    public void setSelected(Tontine selected) {
        this.selected = selected;
    }

    public List<Tontine> getTontines() {
       tontines = tontineFacadeLocal.findAll();
        return tontines;
    }

    public void setTontines(List<Tontine> tontines) {
        this.tontines = tontines;
    }

    public Tranchecotisation getTranchecotisation() {
        return tranchecotisation;
    }

    public void setTranchecotisation(Tranchecotisation tranchecotisation) {
        this.tranchecotisation = tranchecotisation;
    }

    public List<Tranchecotisation> getTranchecotisations() {
        tranchecotisations= tranchecotisationFacadeLocal.findAll();
        return tranchecotisations;
    }

    public void setTranchecotisations(List<Tranchecotisation> tranchecotisations) {
        this.tranchecotisations = tranchecotisations;
    }

    public Cycletontine getCycletontine() {
        return cycletontine;
    }

    public void setCycletontine(Cycletontine cycletontine) {
        this.cycletontine = cycletontine;
    }

    public List<Cycletontine> getInstitions() {
        cycletontines = cycletontineFacadeLocal.findAll();
        return cycletontines;
    }

    public void setInstitions(List<Cycletontine> institions) {
        this.cycletontines = institions;
    }

    public Devise getDevise() {
        return devise;
    }

    public void setDevise(Devise devise) {
        this.devise = devise;
    }

    public List<Devise> getDevises() {
        devises = deviseFacadeLocal.findAll();
        return devises;
    }

    public void setDevises(List<Devise> devises) {
        this.devises = devises;
    }

    public Frequencetontine getFrequencetontine() {
        return frequencetontine;
    }

    public void setFrequencetontine(Frequencetontine frequencetontine) {
        this.frequencetontine = frequencetontine;
    }

    public List<Frequencetontine> getFrequencetontines() {
        frequencetontines = frequencetontineFacadeLocal.findAll();
        return frequencetontines;
    }

    public void setFrequencetontines(List<Frequencetontine> frequencetontines) {
        this.frequencetontines = frequencetontines;
    }

    public List<Cycletontine> getCycletontines() {
        return cycletontines;
    }

    public void setCycletontines(List<Cycletontine> cycletontines) {
        this.cycletontines = cycletontines;
    }

    public Sanction getSanction() {
        return sanction;
    }

    public void setSanction(Sanction sanction) {
        this.sanction = sanction;
    }

    public List<Sanction> getSanctions() {
        sanctions=sanctionFacadeLocal.findAll();
        return sanctions;
    }

    public void setSanctions(List<Sanction> sanctions) {
        this.sanctions = sanctions;
    }

    public Modepaiement getModepaiement() {
        return modepaiement;
    }

    public void setModepaiement(Modepaiement modepaiement) {
        this.modepaiement = modepaiement;
    }

    public List<Modepaiement> getModepaiements() {
        modepaiements= modepaiementFacadeLocal.findAll();
        return modepaiements;
    }

    public void setModepaiements(List<Modepaiement> modepaiements) {
        this.modepaiements = modepaiements;
    }

    public Rubriquecaisse getRubriquecaisse() {
        return rubriquecaisse;
    }

    public void setRubriquecaisse(Rubriquecaisse rubriquecaisse) {
        this.rubriquecaisse = rubriquecaisse;
    }

    public List<Rubriquecaisse> getRubriquecaisses() {
        rubriquecaisses = rubriquecaisseFacadeLocal.findAll();
        return rubriquecaisses;
    }

    public void setRubriquecaisses(List<Rubriquecaisse> rubriquecaisses) {
        this.rubriquecaisses = rubriquecaisses;
    }

    public List<Sanction> getSelectedsanctions() {
        selectedsanctions = sanctionFacadeLocal.findAll();
        return selectedsanctions;
    }

    public void setSelectedsanctions(List<Sanction> selectedsanctions) {
        this.selectedsanctions = selectedsanctions;
    }

    public List<Rubriquecaisse> getSelectedrubriquecaisse() {
        return selectedrubriquecaisse;
    }

    public void setSelectedrubriquecaisse(List<Rubriquecaisse> selectedrubriquecaisse) {
        this.selectedrubriquecaisse = selectedrubriquecaisse;
    }

    public List<Tranchecotisation> getSelectedtranchecotisation() {
        return selectedtranchecotisation;
    }

    public void setSelectedtranchecotisation(List<Tranchecotisation> selectedtranchecotisation) {
        this.selectedtranchecotisation = selectedtranchecotisation;
    }

   
    public Groupeutilisateur getGroupeutilisateur() {
        return groupeutilisateur;
    }

    public void setGroupeutilisateur(Groupeutilisateur groupeutilisateur) {
        this.groupeutilisateur = groupeutilisateur;
    }

    public List<Groupeutilisateur> getGroupeutilisateurs() {
        groupeutilisateurs = GroupeutilisateurFacadeLocal.findByEtat(true);
        return groupeutilisateurs;
    }

    public void setGroupeutilisateurs(List<Groupeutilisateur> groupeutilisateurs) {
        this.groupeutilisateurs = groupeutilisateurs;
    }

    public List<Utilisateur> getUtilisateurs() {
        utilisateurs = utilisateurFacade.findAll();
        return utilisateurs;
    }

    public void setUtilisateurs(List<Utilisateur> utilisateurs) {
        this.utilisateurs = utilisateurs;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public Pays getPays() {
        return pays;
    }

    public void setPays(Pays pays) {
        this.pays = pays;
    }

    public List<Pays> getPayss() {
        payss = paysFacadeLocal.findAll();
        return payss;
    }

    public void setPayss(List<Pays> payss) {
        this.payss = payss;
    }

    public String getFichier_carte() {
        return fichier_carte;
    }

    public void setFichier_carte(String fichier_carte) {
        this.fichier_carte = fichier_carte;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public UploadedFile getFile() {
        return file;
    }

    public void setFile(UploadedFile file) {
        this.file = file;
    }

    public String getRepertoire() {
        return repertoire;
    }

    public void setRepertoire(String repertoire) {
        this.repertoire = repertoire;
    }

    public String getFichier() {
        return fichier;
    }

    public void setFichier(String fichier) {
        this.fichier = fichier;
    }
}
