/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Modepaiement;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface ModepaiementFacadeLocal {

    void create(Modepaiement modepaiement);

    void edit(Modepaiement modepaiement);

    void remove(Modepaiement modepaiement);

    Modepaiement find(Object id);

    List<Modepaiement> findAll();

    List<Modepaiement> findRange(int[] range);

    int count();
    
}
