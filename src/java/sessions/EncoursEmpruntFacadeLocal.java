/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.EncoursEmprunt;
import entities.Rencontre;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author kenne
 */
@Local
public interface EncoursEmpruntFacadeLocal {

    void create(EncoursEmprunt encoursEmprunt);

    void edit(EncoursEmprunt encoursEmprunt);

    void remove(EncoursEmprunt encoursEmprunt);

    EncoursEmprunt find(Object id);

    List<EncoursEmprunt> findAll();

    List<EncoursEmprunt> findRange(int[] range);

    int count();

    Long nextId();

    List<EncoursEmprunt> findByrencontre(Rencontre rencontre) throws Exception;

}
