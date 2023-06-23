/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Compteutilisateur;

import entities.Menu;
import entities.Mouchard;
import entities.Privilege;
import entities.Membre;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;
import sessions.CompteutilisateurFacadeLocal;
import entities.Cycletontine;
import entities.Membrecycle;
import entities.Membretontine;
import entities.Tontine;
import entities.Utilisateurtontine;
import sessions.CycletontineFacadeLocal;
import sessions.MenuFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.PrivilegeFacadeLocal;
import sessions.MembreFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.MembretontineFacadeLocal;
import sessions.TontineFacadeLocal;
import sessions.UtilisateurtontineFacadeLocal;
import utilitaire.Utilitaires;

@ManagedBean
@SessionScoped
public class LoginController implements Serializable {

    @EJB
    private CycletontineFacadeLocal cycletontineFacadeLocal;
    private Cycletontine cycletontine = new Cycletontine();
    private List<Cycletontine> cycletontines = new ArrayList<>();

    @EJB
    private CompteutilisateurFacadeLocal compteutilisateurFacadeLocal;
    private Compteutilisateur compteutilisateur = new Compteutilisateur();

    @EJB
    private MembreFacadeLocal membreFacade;
    private Membre membre = new Membre();
    String sc = FacesContext.getCurrentInstance().getExternalContext().getRequestContextPath();

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard = new Mouchard();

    @EJB
    private PrivilegeFacadeLocal privilegeFacadeLocal;
    public static List<String> privilegeUser = new ArrayList<>();
    public static List<Integer> privilegeId = new ArrayList<>();
    public static List<String> privilegeTotal = new ArrayList<>();
    private static List<Privilege> privileges = new ArrayList<>();

    @EJB
    private MembrecycleFacadeLocal membrecycleFacadeLocal;
    private Membrecycle membrecycle = new Membrecycle();
    private List<Membrecycle> membrecycles = new ArrayList<>();

    @EJB
    private UtilisateurtontineFacadeLocal utilisateurtontineFacadeLocal;
    private List<Utilisateurtontine> utilisateurtontines = new ArrayList<>();

    private boolean viewSession = true;
    private Boolean connexion = false;
    private String session_init = "NO";

    @EJB
    private MenuFacadeLocal menuFacadeLocal;
    private static MenuFacadeLocal menuFacadeLocal1;
    private Menu menu;
    public static Menu menu1 = new Menu();

    @EJB
    protected MembretontineFacadeLocal membretontineFacadeLocal;

    @EJB
    private TontineFacadeLocal tontineFacadeLocal;
    private Tontine tontine = new Tontine();

    private String language = "fr";

    public LoginController() {

    }

    @PostConstruct
    private void init() {
        menu1 = new Menu();
        connexion = false;
    }

    public void updatePrivilege() {

    }

    public void updateCycle() {
        try {
            cycletontines = cycletontineFacadeLocal.findByTontine(tontine);
        } catch (Exception e) {
            e.printStackTrace();
            cycletontines.clear();
        }
    }

    public void validateUsernamePassword() {
        try {

            String password = org.apache.commons.codec.digest.DigestUtils.md5Hex(compteutilisateur.getPassword());
            Compteutilisateur usr = compteutilisateurFacadeLocal.login(compteutilisateur.getLogin(), password);

            if (usr != null) {
                compteutilisateur = usr;

                if (usr.getEtat()) {
                    HttpSession session = SessionMBean.getSession();
                    session.setAttribute("user", usr);

                    setPrivilegeAll();
                    fillUserPrivilege(usr);

                    session.setAttribute("allAccess", privilegeTotal);
                    session.setAttribute("accesses", privilegeId);
                    session.setAttribute("access", privilegeUser);

                    connexion = true;
                    session_init = "NO";

                    if (privilegeId.contains(1)) {
                        System.err.println(" admin");
                        List<Tontine> temp = tontineFacadeLocal.findAll();
                        utilisateurtontines.clear();
                        for (Tontine t : temp) {
                            Utilisateurtontine ut = new Utilisateurtontine();
                            ut.setIdtontine(t);
                            ut.setIdutilisateur(usr.getIdutilisateur());
                            utilisateurtontines.add(ut);
                        }
                    } else {
                        System.err.println("nom admin ");
                        utilisateurtontines = utilisateurtontineFacadeLocal.findByUtilisateur(usr.getIdutilisateur().getIdutilisateur());
                    }

                    session.setAttribute("user_tontine", utilisateurtontines);

                    Utilitaires.saveOperation("connexion ", usr, mouchardFacadeLocal);
                    if (session.getAttribute("last-page") != null) {
                        FacesContext.getCurrentInstance().getExternalContext().redirect((String) session.getAttribute("last-page"));
                    } else {
                        FacesContext.getCurrentInstance().getExternalContext().redirect(sc + "/acceuil.html");
                    }
                } else {
                    Utilitaires.saveOperation("tentative de connection avec un compte bloqué", usr, mouchardFacadeLocal);
                    JsfUtil.addErrorMessage("Votre compte est bloqué");
                }

            } else {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN, "Login et mot de passe incorrets", "Please enter correct username and Password"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Exception Système");
        }
    }

    public void hibbernate() {

    }

    public void setPrivilegeAll() {
        List<Menu> menus = menuFacadeLocal.findAll();
        for (Menu m : menus) {
            privilegeTotal.add(m.getRessource());
        }
    }

    public void fillUserPrivilege(Compteutilisateur compteutilisateur) {
        try {
            privileges = privilegeFacadeLocal.findByUser(compteutilisateur.getIdcompte());
            if (privileges.isEmpty()) {
                privilegeUser = new ArrayList<>();
            } else {
                privilegeUser.clear();
                privilegeId.clear();
                for (Privilege p : privileges) {
                    if (!privilegeUser.contains(p.getIdmenu().getRessource())) {
                        privilegeUser.add(p.getIdmenu().getRessource());
                    }
                    privilegeId.add(p.getIdmenu().getIdmenu());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //logout event, invalidate session
    public void logout() {
        try {
            HttpSession session = SessionMBean.getSession();
            Compteutilisateur usr = SessionMBean.getUser1();
            session.invalidate();

            connexion = false;
            session_init = "NO";

            String sc = FacesContext.getCurrentInstance().getExternalContext().getRequestContextPath();
            Utilitaires.saveOperation("Déconnexion", usr, mouchardFacadeLocal);
            FacesContext.getCurrentInstance().getExternalContext().redirect(sc + "/acceuil.html");
        } catch (IOException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void watcher() {
        try {
            if (SessionMBean.getUser1() == null) {
                String sc = FacesContext.getCurrentInstance().getExternalContext().getRequestContextPath();
                FacesContext.getCurrentInstance().getExternalContext().redirect(sc + "/login.html");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void findMenu(String ressource) {
        try {
            menu1 = menuFacadeLocal1.findByRessource(ressource);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void initSession() {
        try {
            if (cycletontine.getIdcycle() != null) {
                HttpSession session = SessionMBean.getSession();
                session.setAttribute("cycletontine", cycletontine);

                viewSession = false;
                session_init = "YES";
            } else {
                JsfUtil.addErrorMessage("Aucun cycletontine selectionné");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /*public List<Tontine> getUserTontine() {
        try {
            Compteutilisateur usr = (Compteutilisateur) SessionMBean.getSession().getAttribute("user");
            if (usr != null) {
                List<Tontine> result = new ArrayList<>();
                if (usr.getIdmembre() != null) {
                    Membre mbre = usr.getIdmembre();
                    List<Membretontine> mbres_tontine = membretontineFacadeLocal.findByMembre(mbre.getIdmembre());
                    for (Membretontine m : mbres_tontine) {
                        result.add(m.getIdtontine());
                    }
                    return result;
                } else {
                    result = tontineFacadeLocal.findAll();
                    return result;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }*/

    public String switchFr() {
        language = "fr";
        return null;
    }

    public String switchEn() {
        language = "en";
        return null;
    }

    public Membre getMembre() {
        return membre;
    }

    public void setMembre(Membre membre) {
        this.membre = membre;
    }

    public Compteutilisateur getCompteutilisateur() {
        return compteutilisateur;
    }

    public void setCompteutilisateur(Compteutilisateur compteutilisateur) {
        this.compteutilisateur = compteutilisateur;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public List<Membrecycle> getMembrecycles() {
        return membrecycles;
    }

    public void setMembrecycles(List<Membrecycle> membrecycles) {
        this.membrecycles = membrecycles;
    }

    public Membrecycle getMembrecycle() {
        return membrecycle;
    }

    public void setMembrecycle(Membrecycle membrecycle) {
        this.membrecycle = membrecycle;
    }

    public boolean isViewSession() {
        return viewSession;
    }

    public void setViewSession(boolean viewSession) {
        this.viewSession = viewSession;
    }

    public List<Utilisateurtontine> getUtilisateurtontines() {
        return utilisateurtontines;
    }

    public void setUtilisateurtontines(List<Utilisateurtontine> utilisateurtontines) {
        this.utilisateurtontines = utilisateurtontines;
    }

    public List<Cycletontine> getCycletontines() {
        return cycletontines;
    }

    public void setCycletontines(List<Cycletontine> cycletontines) {
        this.cycletontines = cycletontines;
    }

    public Tontine getTontine() {
        return tontine;
    }

    public void setTontine(Tontine tontine) {
        this.tontine = tontine;
    }

    public Cycletontine getCycletontine() {
        return cycletontine;
    }

    public void setCycletontine(Cycletontine cycletontine) {
        this.cycletontine = cycletontine;
    }

    public Boolean getConnexion() {
        return connexion;
    }

    public String getSession_init() {
        return session_init;
    }

}
