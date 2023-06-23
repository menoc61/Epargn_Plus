/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Motifaide;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface MotifaideFacadeLocal {

    void create(Motifaide motifaide);

    void edit(Motifaide motifaide);

    void remove(Motifaide motifaide);

    Motifaide find(Object id);

    List<Motifaide> findAll();

    List<Motifaide> findRange(int[] range);

    int count();

    Integer nextId() throws Exception;

    Motifaide findByNom(String nom);

}
