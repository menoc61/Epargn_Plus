/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Cycletontine;
import entities.Mouchard;
import entities.Membre;
import entities.Pays;
import entities.Tontine;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.event.FileUploadEvent;
import sessions.MouchardFacadeLocal;
import sessions.MembreFacadeLocal;
import sessions.PaysFacadeLocal;
import sessions.TontineFacadeLocal;
import utilitaire.Utilitaires;
import entities.Membretontine;
import entities.Utilisateurtontine;
import javax.annotation.Resource;
import javax.transaction.UserTransaction;
import org.primefaces.model.file.UploadedFile;
import sessions.MembretontineFacadeLocal;

@ManagedBean
@ViewScoped
public class MembreController implements Serializable {

    @Resource
    UserTransaction ut;

    @EJB
    private MembreFacadeLocal membreFacade;
    private Membre membre;
    private List<Membre> membres = new ArrayList<>();
    private Membre selectedUser = new Membre();

    @EJB
    private PaysFacadeLocal paysFacadeLocal;
    private Pays pays;
    private List<Pays> payss = new ArrayList<>();

    @EJB
    private TontineFacadeLocal tontineFacadeLocal;
    private List<Tontine> tontines = new ArrayList<>();
    private List<Tontine> selectedtontines = new ArrayList<>();

    @EJB
    private MembretontineFacadeLocal membretontineFacadeLocal;
    private List<Membretontine> membretontines = new ArrayList<>();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard = new Mouchard();

    private boolean detail = true;
    private String fichier_carte = null;
    private String mode = "";
    private String photo = "";
    private Date date;
    UploadedFile file;
    private String repertoire = Utilitaires.path + "/" + Utilitaires.repertoireDefautVehicule;
    private String fichier = Utilitaires.nomFichierParDefautListeVehicule;
    private final String destination = Utilitaires.path + "/resources/images/";

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    private String msg;

    public MembreController() {

    }

    @PostConstruct
    private void init() {
        mouchard = new Mouchard();
        membre = new Membre();
        selectedUser = new Membre();
        tontines.clear();
        try {
            for (Utilisateurtontine u : SessionMBean.getTontine()) {
                tontines.add(u.getIdtontine());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void prepareCreate() {
        membre = new Membre();
        mode = "Create";
    }

    public void prepareEdit() {
        try {
            if (membre.getIdmembre() != null) {
                mode = "Edit";
                List<Membretontine> mts = membretontineFacadeLocal.findByMembre(membre.getIdmembre());
                selectedtontines.clear();
                pays = membre.getIdpays();
                for (Membretontine m : mts) {
                    selectedtontines.add(m.getIdtontine());
                }
            } else {
                JsfUtil.addErrorMessage("Aucune ligne selectionée");
            }
        } catch (Exception e) {
            e.printStackTrace();
            selectedtontines.clear();
            JsfUtil.addErrorMessage("Exception system");
        }

    }

    public void prepareDelete() {

    }

    public void handleFileUpload(FileUploadEvent event) {
        this.file = event.getFile();
        System.out.println("Uploaded File Name Is :: " + file.getFileName() + " :: Uploaded File Size :: " + file.getSize());
        try {
            copyFile(event.getFile().getFileName(), event.getFile().getInputStream());
            photo = event.getFile().getFileName();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void copyFile(String fileName, InputStream in) {
        try {
            // write the inputStream to a FileOutputStream
            OutputStream output = new FileOutputStream(new File(destination + fileName));

            int read = 0;
            byte[] bytes = new byte[128];
            while ((read = in.read(bytes)) != -1) {
                output.write(bytes, 0, read);
            }

            in.close();
            output.flush();
            output.close();

            System.out.println("New file created!");
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void saveMembre() {
        try {
            if ("Create".equals(mode)) {

                ut.begin();

                membre.setIdmembre(membreFacade.nextId());
                membre.setPhoto(photo);
                membreFacade.create(membre);

                if (!selectedtontines.isEmpty()) {
                    for (Tontine i : selectedtontines) {
                        Membretontine membretontine = new Membretontine();
                        membretontine.setIdmembretontine(membretontineFacadeLocal.nextId());
                        membretontine.setIdtontine(i);
                        membretontine.setIdmembre(membre);
                        membretontineFacadeLocal.create(membretontine);
                        Utilitaires.saveOperation("Assignation de la tontine  -> " + i.getNom() + " ; Au Membre  -> " + membre.getNom(), SessionMBean.getUser1(), mouchardFacadeLocal);
                    }
                    Utilitaires.saveOperation("Enregistrement du membre " + membre.getNom() + " " + membre.getPrenom(), SessionMBean.getUser1(), mouchardFacadeLocal);
                }
                JsfUtil.addSuccessMessage("Opération reussie");

                ut.commit();
            } else {

                ut.begin();
                membreFacade.edit(membre);

                for (Tontine t : selectedtontines) {
                    List<Membretontine> mts = membretontineFacadeLocal.findByMembreTontine(membre.getIdmembre(), t.getIdtontine());
                    if (mts.size() == 0) {
                        Membretontine membretontine = new Membretontine();
                        membretontine.setIdmembretontine(membretontineFacadeLocal.nextId());
                        membretontine.setIdtontine(t);
                        membretontine.setIdmembre(membre);
                        membretontineFacadeLocal.create(membretontine);
                        Utilitaires.saveOperation("Assignation de la tontine  -> " + t.getNom() + " ; Au Membre  -> " + membre.getNom(), SessionMBean.getUser1(), mouchardFacadeLocal);
                    } else {
                        System.err.println("taille" + mts.size());
                        System.err.println("Not null");
                    }
                }

                ut.commit();
                JsfUtil.addSuccessMessage("Opération reussie");

            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Execption systeme , verifier vos données");
        }
    }

    public void editMembre() {
        try {
            if (selectedUser.getIdmembre() != null) {

                Membre usr = membreFacade.find(selectedUser.getIdmembre());
                membreFacade.edit(selectedUser);

                Utilitaires.saveOperation("Modification du membre:  " + usr.getNom() + " " + usr.getPrenom() + " -> " + selectedUser.getNom() + " " + selectedUser.getPrenom(), SessionMBean.getUser1(), mouchardFacadeLocal);
                JsfUtil.addSuccessMessage("Membre mis à jour");
                if (!selectedtontines.isEmpty()) {
                    for (Tontine i : selectedtontines) {
                        Membretontine membretontine = new Membretontine();
                        membretontine.setIdmembretontine(membretontineFacadeLocal.nextId());
                        membretontine.setIdtontine(i);
                        membretontine.setIdmembre(membre);
                        membretontineFacadeLocal.create(membretontine);
                    }
                } else {
                    //membretontineFacadeLocal.edit(membretontine);
                }
                JsfUtil.addSuccessMessage("Opération réussie");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteMembre() {
        if (selectedUser != null) {
            if (selectedUser.getCompteutilisateurList().isEmpty()) {
                if (selectedUser.getMembrecycleList().isEmpty()) {
                    if (selectedUser.getMembretontineList().isEmpty()) {
                        Cycletontine cycletontine = new Cycletontine(1);
                        membreFacade.remove(selectedUser);
                        mouchard.setAction("suppression du membre " + selectedUser.getNom() + " " + selectedUser.getPrenom());
                        mouchard.setDateaction(new Date());
                        mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                        mouchardFacadeLocal.create(mouchard);
                        JsfUtil.addSuccessMessage("operation réussie");

                    } else {
                        JsfUtil.addErrorMessage("ce Membre appartient a une tontine  et ne peut etre supprimé");
                    }
                } else {
                    JsfUtil.addErrorMessage("ce Membre appartient a un cycle  et ne peut etre supprimé");
                }

            } else {
                JsfUtil.addErrorMessage("ce Membre possede un compte  et ne peut etre supprimé");
            }

        } else {
            JsfUtil.addErrorMessage("veuillez selectionner un membre");
        }
    }

    public Mouchard getMouchard() {
        return mouchard;
    }

    public void setMouchard(Mouchard mouchard) {
        this.mouchard = mouchard;
    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Membre getMembre() {
        return membre;
    }

    public void setMembre(Membre membre) {
        this.membre = membre;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public List<Membre> getMembres() {
        try {
            membres = membreFacade.findAllRange();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return membres;
    }

    public void setMembres(List<Membre> membres) {
        this.membres = membres;
    }

    public Membre getSelectedUser() {
        return selectedUser;
    }

    public void setSelectedUser(Membre selectedUser) {
        this.selectedUser = selectedUser;
    }

    public List<Tontine> getSelectedtontines() {
        return selectedtontines;
    }

    public void setSelectedtontines(List<Tontine> selectedtontines) {
        this.selectedtontines = selectedtontines;
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

    public List<Tontine> getTontines() {
        return tontines;
    }

    public void setTontines(List<Tontine> tontines) {
        this.tontines = tontines;
    }

    public List<Tontine> getSelectedTontines() {
        return selectedtontines;
    }

    public void setSelectedTontines(List<Tontine> selectedtontines) {
        this.selectedtontines = selectedtontines;
    }

    public List<Membretontine> getMembretontines() {
        membretontines = membretontineFacadeLocal.findAll();
        return membretontines;
    }

    public void setMembretontines(List<Membretontine> membretontines) {
        this.membretontines = membretontines;
    }

}
