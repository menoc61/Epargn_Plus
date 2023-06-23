/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Naturecaisse;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author kenne
 */
@Local
public interface NaturecaisseFacadeLocal {

    void create(Naturecaisse naturecaisse);

    void edit(Naturecaisse naturecaisse);

    void remove(Naturecaisse naturecaisse);

    Naturecaisse find(Object id);

    List<Naturecaisse> findAll();

    List<Naturecaisse> findRange(int[] range);

    int count();
    
}
