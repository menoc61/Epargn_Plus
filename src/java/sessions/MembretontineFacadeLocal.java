/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Membretontine;
import entities.Tontine;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author kenne
 */
@Local
public interface MembretontineFacadeLocal {

    void create(Membretontine membretontine);

    void edit(Membretontine membretontine);

    void remove(Membretontine membretontine);

    Membretontine find(Object id);

    List<Membretontine> findAll();

    public Integer nextId() throws Exception;

    List<Membretontine> findRange(int[] range);

    int count();

    List<Membretontine> findByTontine(Tontine tontine) throws Exception;

    List<Membretontine> findByMembre(int idmembre) throws Exception;

    List<Membretontine> findByMembreTontine(int idmembre, int idtontine) throws Exception;

}
