/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cycletontine;
import entities.Remboursement;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface RemboursementFacadeLocal {

    void create(Remboursement remboursement);

    void edit(Remboursement remboursement);

    void remove(Remboursement remboursement);

    Remboursement find(Object id);

    List<Remboursement> findAll();

    List<Remboursement> findRange(int[] range);

    int count();

    Integer nextId() throws Exception;

    List<Remboursement> findByCycle(Cycletontine cycletontine) throws Exception;

    List<Remboursement> findByEmprunt(Integer idemprunt) throws Exception;

}
