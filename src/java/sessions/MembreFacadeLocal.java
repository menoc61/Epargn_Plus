/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Membre;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface MembreFacadeLocal {

    void create(Membre membre);

    void edit(Membre membre);

    void remove(Membre membre);

    Membre find(Object id);

    List<Membre> findAll();

    List<Membre> findRange(int[] range);

    int count();

    int nextId();

    List<Membre> findAllRange() throws Exception;

    Membre findByNomPrenom(String nom, String prenom);

    List<Membre> findByCycletontine(int cycletontine);

}
