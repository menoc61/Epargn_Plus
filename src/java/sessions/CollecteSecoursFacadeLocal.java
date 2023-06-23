/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.CollecteSecours;
import entities.Cycletontine;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author kenne
 */
@Local
public interface CollecteSecoursFacadeLocal {

    void create(CollecteSecours collecteSecours);

    void edit(CollecteSecours collecteSecours);

    void remove(CollecteSecours collecteSecours);

    CollecteSecours find(Object id);

    List<CollecteSecours> findAll();

    List<CollecteSecours> findRange(int[] range);

    int count();

    Long nextId();

    List<CollecteSecours> findByCycle(Cycletontine cycletontine) throws Exception;

}
