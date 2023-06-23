/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Emprunt;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface EmpruntFacadeLocal {

    void create(Emprunt emprunt);

    void edit(Emprunt emprunt);

    void remove(Emprunt emprunt);

    Emprunt find(Object id);

    List<Emprunt> findAll();

    List<Emprunt> findRange(int[] range);

    int count();

    public int nextId();

    List<Emprunt> findByCycletontine(int cycletontine);

    List<Emprunt> findByCycletontine(int cycletontine, boolean rembourse);
    
}
