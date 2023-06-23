/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Frequencecotisation;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Louis Stark
 */
@Local
public interface FrequencecotisationFacadeLocal {

    void create(Frequencecotisation frequencecotisation);

    void edit(Frequencecotisation frequencecotisation);

    void remove(Frequencecotisation frequencecotisation);

    Frequencecotisation find(Object id);

    List<Frequencecotisation> findAll();
    
    List<Frequencecotisation> findAllRange_by_name();

    List<Frequencecotisation> findRange(int[] range);

    int count();
    
    int nextId();
    
}
