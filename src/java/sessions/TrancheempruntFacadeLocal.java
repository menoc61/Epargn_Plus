/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Trancheemprunt;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface TrancheempruntFacadeLocal {

    void create(Trancheemprunt trancheemprunt);

    void edit(Trancheemprunt trancheemprunt);

    void remove(Trancheemprunt trancheemprunt);

    Trancheemprunt find(Object id);

    List<Trancheemprunt> findAll();

    List<Trancheemprunt> findRange(int[] range);

    int count();
    
}
