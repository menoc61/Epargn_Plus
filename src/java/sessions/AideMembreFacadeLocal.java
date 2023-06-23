/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Aide;
import entities.AideMembre;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author kenne
 */
@Local
public interface AideMembreFacadeLocal {

    void create(AideMembre aideMembre);

    void edit(AideMembre aideMembre);

    void remove(AideMembre aideMembre);

    AideMembre find(Object id);

    List<AideMembre> findAll();

    List<AideMembre> findRange(int[] range);

    int count();

    Long nextId();

    List<AideMembre> findByAide(Aide aide) throws Exception;

}
