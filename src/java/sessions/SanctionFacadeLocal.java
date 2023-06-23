/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Sanction;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface SanctionFacadeLocal {

    void create(Sanction sanction);

    void edit(Sanction sanction);

    void remove(Sanction sanction);

    Sanction find(Object id);

    List<Sanction> findAll();

    List<Sanction> findRange(int[] range);

    int count();

    Integer nextId() throws Exception;

    Sanction findByNom(String nom);

}
