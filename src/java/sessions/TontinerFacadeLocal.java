/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cotisation;
import entities.Rencontre;
import entities.Tontiner;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Louis Stark
 */
@Local
public interface TontinerFacadeLocal {

    void create(Tontiner tontiner);

    void edit(Tontiner tontiner);

    void remove(Tontiner tontiner);

    Tontiner find(Object id);
    
    Tontiner findBy_cotisation_rencontre(Cotisation c, Rencontre r);
    
    List<Tontiner> findAll();
    
    List<Tontiner> findAllBy_cotisation(Cotisation c);

    List<Tontiner> findRange(int[] range);

    int count();
    
    int nextId();
    
}
