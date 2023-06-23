/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cotisation;
import entities.InscriptionCotisation;
import entities.Mains;
import entities.Membrecycle;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Louis Stark
 */
@Local
public interface MainsFacadeLocal {

    void create(Mains mains);

    void edit(Mains mains);

    void remove(Mains mains);

    Mains find(Object id);

    List<Mains> findAll();
    
    List<Mains> findAll_by_Inscription(InscriptionCotisation i);
    
    List<Mains> findAll_by_Cotisation(Cotisation c);
    
    List<Mains> findAll_by_Cotisation_membrecycle(Cotisation c, Membrecycle m);
    
    List<Mains> findAll_by_Cotisation_rangeBy_tirage(Cotisation c);

    List<Mains> findRange(int[] range);

    int count();
    
    int nextId();
    
    
}
