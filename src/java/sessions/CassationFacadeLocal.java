/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cassation;
import entities.Cycletontine;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author kenne
 */
@Local
public interface CassationFacadeLocal {

    void create(Cassation cassation);

    void edit(Cassation cassation);

    void remove(Cassation cassation);

    Cassation find(Object id);

    List<Cassation> findAll();

    List<Cassation> findRange(int[] range);

    int count();

    Long nextId();

    List<Cassation> findByCycle(Cycletontine cycletontine) throws Exception;

}
