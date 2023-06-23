/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Avalyse;
import entities.Emprunt;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author kenne
 */
@Local
public interface AvalyseFacadeLocal {

    void create(Avalyse avalyse);

    void edit(Avalyse avalyse);

    void remove(Avalyse avalyse);

    Avalyse find(Object id);

    List<Avalyse> findAll();

    List<Avalyse> findRange(int[] range);

    int count();

    Long nextId();

    List<Avalyse> findByEmprunt(Emprunt emprunt) throws Exception;

}
