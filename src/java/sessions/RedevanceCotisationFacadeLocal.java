/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.RedevanceCotisation;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface RedevanceCotisationFacadeLocal {

    void create(RedevanceCotisation redevanceCotisation);

    void edit(RedevanceCotisation redevanceCotisation);

    void remove(RedevanceCotisation redevanceCotisation);

    RedevanceCotisation find(Object id);

    List<RedevanceCotisation> findAll();

    List<RedevanceCotisation> findRange(int[] range);

    int count();

    List<RedevanceCotisation> findByCycleNotPayed(int idcycle) throws Exception;

}
