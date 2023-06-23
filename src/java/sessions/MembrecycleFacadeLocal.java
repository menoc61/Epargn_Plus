/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cycletontine;
import entities.Membre;
import entities.Membrecycle;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface MembrecycleFacadeLocal {

    void create(Membrecycle membrecycle);

    void edit(Membrecycle membrecycle);

    void remove(Membrecycle membrecycle);

    Membrecycle find(Object id);

    List<Membrecycle> findAll();

    List<Membrecycle> findRange(int[] range);

    int count();

    int nextId();

    Membrecycle findByMembreCycle(int membre, int cycle);

    List<Membrecycle> findByMembre(int membre);

    List<Membrecycle> findAllRange();

    List<Membrecycle> findByCycletontine(int cycletontine);

    List<Membrecycle> findByCycle(Cycletontine cycletontine) throws Exception;

    List<Membrecycle> findByCycle(Cycletontine cycletontine, Boolean etat) throws Exception;

    List<Membrecycle> findByMembreCycle(Membre membre, Cycletontine cycletontine) throws Exception;

    List<Membrecycle> findByCycleNonpaye(Cycletontine cycletontine, Boolean etat) throws Exception;

}
