/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Devise;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface DeviseFacadeLocal {

    void create(Devise devise);

    void edit(Devise devise);

    void remove(Devise devise);

    Devise find(Object id);

    List<Devise> findAll();

    List<Devise> findRange(int[] range);

    int count();

    int nextId();

}
