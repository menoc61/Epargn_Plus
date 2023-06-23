/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Mois;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface MoisFacadeLocal {

    void create(Mois mois);

    void edit(Mois mois);

    void remove(Mois mois);

    Mois find(Object id);

    List<Mois> findAll();

    List<Mois> findRange(int[] range);

    int count();
    
    public List<Mois> findAllRange();
}
