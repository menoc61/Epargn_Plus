/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Frequencetontine;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface FrequencetontineFacadeLocal {

    void create(Frequencetontine frequencetontine);

    void edit(Frequencetontine frequencetontine);

    void remove(Frequencetontine frequencetontine);

    Frequencetontine find(Object id);

    List<Frequencetontine> findAll();

    List<Frequencetontine> findRange(int[] range);

    int count();

    Integer nextId() throws Exception;

    Frequencetontine findByNom(String nom);

}
