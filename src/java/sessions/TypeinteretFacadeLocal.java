/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Typeinteret;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface TypeinteretFacadeLocal {

    void create(Typeinteret typeinteret);

    void edit(Typeinteret typeinteret);

    void remove(Typeinteret typeinteret);

    Typeinteret find(Object id);

    List<Typeinteret> findAll();

    List<Typeinteret> findRange(int[] range);

    int count();
    
}
