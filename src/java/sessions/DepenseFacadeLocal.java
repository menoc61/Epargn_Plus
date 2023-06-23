/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Depense;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface DepenseFacadeLocal {

    void create(Depense depense);

    void edit(Depense depense);

    void remove(Depense depense);

    Depense find(Object id);

    List<Depense> findAll();

    List<Depense> findRange(int[] range);

    int count();
    
    public int nextId();
    
    public List<Depense> findByCycletontine(int cycletontine);
    
}
