/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.util;

import entities.Compteutilisateur;
import entities.Cycletontine;
import entities.Membre;
import entities.Utilisateurtontine;
import java.util.ArrayList;
import java.util.List;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SessionMBean {

    public static HttpSession getSession() {
        return (HttpSession) FacesContext.getCurrentInstance()
                .getExternalContext().getSession(false);
    }

    public static HttpServletRequest getRequest() {
        return (HttpServletRequest) FacesContext.getCurrentInstance()
                .getExternalContext().getRequest();
    }

    public static String getUserId() {
        HttpSession session = getSession();
        if (session != null) {
            return (String) session.getAttribute("membreid");
        } else {
            return null;
        }
    }

    public static Cycletontine getCycletontine() {
        HttpSession session = getSession();
        if (session != null) {
            return (Cycletontine) session.getAttribute("cycletontine");
        } else {
            return null;
        }
    }

    public static Membre getUser() {
        HttpSession session = getSession();
        if (session != null) {
            return (Membre) session.getAttribute("membre");
        } else {
            return null;
        }
    }

    public static Compteutilisateur getUser1() {
        HttpSession session = getSession();
        if (session != null) {
            return (Compteutilisateur) session.getAttribute("user");
        } else {
            return null;
        }
    }

    public static List<Utilisateurtontine> getTontine() {
        HttpSession session = getSession();
        if (session != null) {
            return (List<Utilisateurtontine>) session.getAttribute("user_tontine");
        } else {
            return new ArrayList<>();
        }
    }

    public static List<Integer> getAccess() {
        HttpSession session = getSession();
        if (session != null) {
            return (List<Integer>) session.getAttribute("accesses");
        } else {
            return null;
        }
    }

}
