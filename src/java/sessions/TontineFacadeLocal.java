/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Tontine;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface TontineFacadeLocal {

    void create(Tontine tontine);

    void edit(Tontine tontine);

    void remove(Tontine tontine);

    Tontine find(Object id);

    List<Tontine> findAll();

    List<Tontine> findRange(int[] range);

    int count();
    
    public int nextId();
    
    public List<Tontine> findByCycletontine(int cycletontine);
    
}
