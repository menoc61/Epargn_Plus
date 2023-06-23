/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cycletontine;
import entities.Tontine;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface CycletontineFacadeLocal {

    void create(Cycletontine cycletontine);

    void edit(Cycletontine cycletontine);

    void remove(Cycletontine cycletontine);

    Cycletontine find(Object id);

    List<Cycletontine> findAll();

    List<Cycletontine> findRange(int[] range);

    int count();

    public int nextId();

    List<Cycletontine> findByNom(String nom);

    List<Cycletontine> findByTontine(Tontine tontine) throws Exception;

    List<Cycletontine> findByTontine(Tontine tontine, boolean transfert) throws Exception;

}
