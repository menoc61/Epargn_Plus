/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Utilisateurtontine;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface UtilisateurtontineFacadeLocal {

    void create(Utilisateurtontine utilisateurtontine);

    void edit(Utilisateurtontine utilisateurtontine);

    void remove(Utilisateurtontine utilisateurtontine);

    Utilisateurtontine find(Object id);

    List<Utilisateurtontine> findAll();

    List<Utilisateurtontine> findRange(int[] range);

    int count();

    int nextId();

    List<Utilisateurtontine> findByUtilisateur(int utilisateur) throws Exception;

    List<Utilisateurtontine> findByUtilisateur(int utilisateur, int tontine) throws Exception;
    
    List<Utilisateurtontine> findByTontine(int tontine) throws Exception;

}
