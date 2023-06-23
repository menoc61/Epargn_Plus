/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.PasEmprunt;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author kenne
 */
@Local
public interface PasEmpruntFacadeLocal {

    void create(PasEmprunt pasEmprunt);

    void edit(PasEmprunt pasEmprunt);

    void remove(PasEmprunt pasEmprunt);

    PasEmprunt find(Object id);

    List<PasEmprunt> findAll();

    List<PasEmprunt> findRange(int[] range);

    int count();
    
}
