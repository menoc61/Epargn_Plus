/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.CollecteMainLevee;
import entities.Cycletontine;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface CollecteMainLeveeFacadeLocal {

    void create(CollecteMainLevee collecteMainLevee);

    void edit(CollecteMainLevee collecteMainLevee);

    void remove(CollecteMainLevee collecteMainLevee);

    CollecteMainLevee find(Object id);

    List<CollecteMainLevee> findAll();

    List<CollecteMainLevee> findRange(int[] range);

    int count();

    Long nextId();

    List<CollecteMainLevee> findByCycle(Cycletontine cycletontine) throws Exception;

}
