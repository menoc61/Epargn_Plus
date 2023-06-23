/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Compteutilisateur;
import entities.Mouchard;
import entities.Utilisateur;
import entities.Utilisateurtontine;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import sessions.CompteutilisateurFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.UtilisateurtontineFacadeLocal;

import utilitaire.Utilitaires;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class CompteUtilisateurController implements Serializable {

    @EJB
    private CompteutilisateurFacadeLocal compteutilisateurFacadeLocal;
    private Compteutilisateur compteutilisateur = new Compteutilisateur();
    private List<Compteutilisateur> compteutilisateurs = new ArrayList<>();
    private String repeatPassword = "";

    private List<Compteutilisateur> compteutilisateurInactifs = new ArrayList<>();
    private List<Compteutilisateur> compteutilisateurActifs = new ArrayList<>();

    private Utilisateur utilisateur = new Utilisateur();
    private List<Utilisateur> utilisateurs = new ArrayList<>();

    @EJB
    private UtilisateurtontineFacadeLocal utilisateurtontineFacadeLocal;

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard;

    private boolean disableSelectUser = false;

    private boolean detail = true;

    private String mode = "";

    public CompteUtilisateurController() {

    }

    @PostConstruct
    private void init() {
        compteutilisateur = new Compteutilisateur();
        mouchard = new Mouchard();
    }

    public void prepareCreate() {
        filterUserWithoutAccount();
        utilisateur = new Utilisateur();
        compteutilisateur = new Compteutilisateur();
        mode = "Create";
        disableSelectUser = false;
    }

    public void prepareEdit() {
        try {
            utilisateurs.clear();
            if (compteutilisateur != null) {
                utilisateur = compteutilisateur.getIdutilisateur();
                utilisateurs.add(utilisateur);
            }
            disableSelectUser = true;
            mode = "Edit";
        } catch (Exception e) {
            e.printStackTrace();
            utilisateur = new Utilisateur();
        }
    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void filterUserWithoutAccount() {
        try {
            List<Utilisateurtontine> utAll = utilisateurtontineFacadeLocal.findByTontine(SessionMBean.getCycletontine().getIdtontine().getIdtontine());
            utilisateurs.clear();
            for (Utilisateurtontine ut : utAll) {
                if (compteutilisateurFacadeLocal.findByUtilisateur(ut.getIdutilisateur().getIdutilisateur()) == null) {
                    utilisateurs.add(ut.getIdutilisateur());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void saveCompte() {
        try {
            if ("Create".equals(mode)) {

                String password = org.apache.commons.codec.digest.DigestUtils.md5Hex(compteutilisateur.getPassword());
                Compteutilisateur compte = compteutilisateurFacadeLocal.login(compteutilisateur.getLogin());

                if (compte == null) {
                    compteutilisateur.setIdutilisateur(utilisateur);
                    compteutilisateur.setEtat(true);
                    compteutilisateur.setPassword(password);
                    if (compteutilisateur.getPassword().equals(org.apache.commons.codec.digest.DigestUtils.md5Hex(repeatPassword))) {
                        compteutilisateur.setIdcompte(compteutilisateurFacadeLocal.nextId());
                        compteutilisateurFacadeLocal.create(compteutilisateur);
                        compteutilisateur = new Compteutilisateur();
                        Utilitaires.saveOperation("Creation du compte membre " + compteutilisateur.getLogin() + " Pour l'utilisateur " + compteutilisateur.getIdutilisateur().getNom(), SessionMBean.getUser1(), mouchardFacadeLocal);
                        JsfUtil.addSuccessMessage("Compte crée avec succès");
                    } else {
                        JsfUtil.addErrorMessage("Les deux mot de passe sont differents !");
                    }
                    compteutilisateur = null;
                } else {
                    JsfUtil.addErrorMessage("un Utilisateur ayant ce login existe deja");
                }
            } else {
                compteutilisateur.setPassword(org.apache.commons.codec.digest.DigestUtils.md5Hex(compteutilisateur.getPassword()));
                compteutilisateurFacadeLocal.edit(compteutilisateur);

                Utilitaires.saveOperation("modification du compte " + compteutilisateur.getIdcompte(), SessionMBean.getUser1(), mouchardFacadeLocal);
                compteutilisateur = null;
                JsfUtil.addSuccessMessage("Compte membre mis à jour ");
            }
        } catch (Exception e) {
            e.getMessage();
            e.printStackTrace();
        }
    }

    public void editCompte() {
        try {
            if (compteutilisateur.getIdcompte() != null) {

                compteutilisateur.setPassword(org.apache.commons.codec.digest.DigestUtils.md5Hex(compteutilisateur.getPassword()));
                compteutilisateurFacadeLocal.edit(compteutilisateur);

                Utilitaires.saveOperation("modification du compte " + compteutilisateur.getIdcompte(), SessionMBean.getUser1(), mouchardFacadeLocal);
                compteutilisateur = null;
                JsfUtil.addSuccessMessage("Compte membre mis à jour ");
            } else {
                JsfUtil.addErrorMessage("veuillez selectionner un compte");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteCompte() {
        try {
            if (compteutilisateur.getIdcompte() != null) {
                compteutilisateurFacadeLocal.remove(compteutilisateur);
                Utilitaires.saveOperation("suppression du compte membre " + compteutilisateur.getLogin() + " " + compteutilisateur.getPassword(), SessionMBean.getUser1(), mouchardFacadeLocal);
                JsfUtil.addSuccessMessage("Operation réussie");
            } else {
                JsfUtil.addErrorMessage("veuillez selectionner un compte");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void changeStatus(Compteutilisateur compteutilisateur, String action) {
        if (("desactiver").equals(action)) {
            //desactiver
            compteutilisateur.setEtat(false);
            compteutilisateurFacadeLocal.edit(compteutilisateur);
            Utilitaires.saveOperation("Désactivation du compte membre" + compteutilisateur.getIdmembre().getNom() + " " + compteutilisateur.getIdmembre().getPrenom(), SessionMBean.getUser1(), mouchardFacadeLocal);
        } else {
            //activer
            compteutilisateur.setEtat(true);
            compteutilisateurFacadeLocal.edit(compteutilisateur);
            Utilitaires.saveOperation("Activation du compte membre :" + compteutilisateur.getIdmembre().getNom() + " " + compteutilisateur.getIdmembre().getPrenom(), SessionMBean.getUser1(), mouchardFacadeLocal);
        }
        System.err.println("apelé");
    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Compteutilisateur getCompteutilisateur() {
        return compteutilisateur;
    }

    public void setCompteutilisateur(Compteutilisateur compteutilisateur) {
        this.compteutilisateur = compteutilisateur;
    }

    public List<Compteutilisateur> getCompteutilisateurs() {
        compteutilisateurs = compteutilisateurFacadeLocal.findAll();
        return compteutilisateurs;
    }

    public void setCompteutilisateurs(List<Compteutilisateur> compteutilisateurs) {
        this.compteutilisateurs = compteutilisateurs;
    }

    public Mouchard getMouchard() {
        return mouchard;
    }

    public void setMouchard(Mouchard mouchard) {
        this.mouchard = mouchard;
    }

    public String getRepeatPassword() {
        return repeatPassword;
    }

    public void setRepeatPassword(String repeatPassword) {
        this.repeatPassword = repeatPassword;
    }

    public List<Compteutilisateur> getCompteutilisateurInactifs() {
        try {
            compteutilisateurInactifs = compteutilisateurFacadeLocal.findAll(!true);
        } catch (Exception ex) {
            System.err.println(ex);
        }
        return compteutilisateurInactifs;
    }

    public List<Compteutilisateur> getCompteutilisateurActifs() {
        try {
            compteutilisateurActifs = compteutilisateurFacadeLocal.findAll(true);
        } catch (Exception ex) {
            System.err.println(ex);
        }
        return compteutilisateurActifs;
    }

    public List<Utilisateur> getUtilisateurs() {
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

    public boolean isDisableSelectUser() {
        return disableSelectUser;
    }

    public void setDisableSelectUser(boolean disableSelectUser) {
        this.disableSelectUser = disableSelectUser;
    }

}
