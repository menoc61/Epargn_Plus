/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Tranchecotisation;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface TranchecotisationFacadeLocal {

    void create(Tranchecotisation tranchecotisation);

    void edit(Tranchecotisation tranchecotisation);

    void remove(Tranchecotisation tranchecotisation);

    Tranchecotisation find(Object id);

    List<Tranchecotisation> findAll();

    List<Tranchecotisation> findRange(int[] range);

    int count();
    
}
