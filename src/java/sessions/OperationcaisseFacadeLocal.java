/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Operationcaisse;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface OperationcaisseFacadeLocal {

    void create(Operationcaisse operationcaisse);

    void edit(Operationcaisse operationcaisse);

    void remove(Operationcaisse operationcaisse);

    Operationcaisse find(Object id);

    List<Operationcaisse> findAll();

    List<Operationcaisse> findRange(int[] range);

    int count();
    
}
