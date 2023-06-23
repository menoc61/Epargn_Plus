/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cycletontine;
import entities.Epargne;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author kenne
 */
@Local
public interface EpargneFacadeLocal {

    void create(Epargne epargne);

    void edit(Epargne epargne);

    void remove(Epargne epargne);

    Epargne find(Object id);

    List<Epargne> findAll();

    List<Epargne> findRange(int[] range);

    int count();

    int nextId();

    List<Epargne> findByCycle(Cycletontine cycletontine) throws Exception;

    List<Epargne> findByCycletontine(int cycletontine);

}
