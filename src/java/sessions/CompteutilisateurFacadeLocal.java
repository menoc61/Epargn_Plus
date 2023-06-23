/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Compteutilisateur;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface CompteutilisateurFacadeLocal {

    void create(Compteutilisateur compteutilisateur);

    void edit(Compteutilisateur compteutilisateur);

    void remove(Compteutilisateur compteutilisateur);

    Compteutilisateur find(Object id);

    List<Compteutilisateur> findAll();

    List<Compteutilisateur> findRange(int[] range);

    int count();

    int nextId();

    Compteutilisateur login(String login, String password);

    Compteutilisateur login(String login) throws Exception;

    List<Compteutilisateur> findAll(Boolean etat) throws Exception;

    Compteutilisateur findByUtilisateur(int utilisateur) throws Exception;

}
