/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.CalculInteret;
import entities.Rencontre;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author kenne
 */
@Local
public interface CalculInteretFacadeLocal {

    void create(CalculInteret calculInteret);

    void edit(CalculInteret calculInteret);

    void remove(CalculInteret calculInteret);

    CalculInteret find(Object id);

    List<CalculInteret> findAll();

    List<CalculInteret> findRange(int[] range);

    int count();

    Long nextId();

    List<CalculInteret> findByRencontre(Rencontre rencontre) throws Exception;

}
