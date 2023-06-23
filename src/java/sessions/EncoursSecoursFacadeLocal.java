/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.EncoursSecours;
import entities.Rencontre;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author kenne
 */
@Local
public interface EncoursSecoursFacadeLocal {

    void create(EncoursSecours encoursSecours);

    void edit(EncoursSecours encoursSecours);

    void remove(EncoursSecours encoursSecours);

    EncoursSecours find(Object id);

    List<EncoursSecours> findAll();

    List<EncoursSecours> findRange(int[] range);

    int count();

    Long nextId();

    List<EncoursSecours> findByrencontre(Rencontre rencontre) throws Exception;

}
