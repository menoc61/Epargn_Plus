/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Aide;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface AideFacadeLocal {

    void create(Aide aide);

    void edit(Aide aide);

    void remove(Aide aide);

    Aide find(Object id);

    List<Aide> findAll();

    List<Aide> findRange(int[] range);

    int count();
    
    public int nextId();
    
    public List<Aide> findByCycletontine(int cycletontine);
}
