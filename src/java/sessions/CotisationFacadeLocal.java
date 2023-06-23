/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cotisation;
import entities.Tontine;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface CotisationFacadeLocal {

    void create(Cotisation cotisation);

    void edit(Cotisation cotisation);

    void remove(Cotisation cotisation);

    Cotisation find(Object id);

    List<Cotisation> findAll();

    List<Cotisation> findRange(int[] range);

    int count();

    int nextId();

    List<Cotisation> findBy_tontine(Tontine t);

    //List<Cotisation> findByRencontre(Rencontre rencontre) throws Exception;

}
