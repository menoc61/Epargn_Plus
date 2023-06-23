/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.BeneficiaireTontine;
import entities.Encherebenficiare;
import entities.Tontiner;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Louis Stark
 */
@Local
public interface EncherebenficiareFacadeLocal {

    void create(Encherebenficiare encherebenficiare);

    void edit(Encherebenficiare encherebenficiare);

    void remove(Encherebenficiare encherebenficiare);

    Encherebenficiare find(Object id);
    
    Encherebenficiare findBy_benficiaireTontine(BeneficiaireTontine b);

    List<Encherebenficiare> findAll();
    
    List<Encherebenficiare> findBy_tontiner(Tontiner t);

    List<Encherebenficiare> findRange(int[] range);

    int count();
    
    int nextId();
    
    
    
}
