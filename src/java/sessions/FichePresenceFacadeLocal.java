/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.FichePresence;
import entities.Rencontre;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author kenne
 */
@Local
public interface FichePresenceFacadeLocal {

    void create(FichePresence fichePresence);

    void edit(FichePresence fichePresence);

    void remove(FichePresence fichePresence);

    FichePresence find(Object id);

    List<FichePresence> findAll();

    List<FichePresence> findRange(int[] range);

    int count();

    Long nextId();

    List<FichePresence> findByRencontre(Rencontre rencontre) throws Exception;

    List<FichePresence> findByNonRegle(boolean regle) throws Exception;

    List<FichePresence> findByCycleNonRegle(int idcycle, boolean regle) throws Exception;

}
