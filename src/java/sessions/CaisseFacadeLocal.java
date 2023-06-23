/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Caisse;
import entities.Cycletontine;
import entities.Membrecycle;
import entities.Rencontre;
import entities.Rubriquecaisse;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface CaisseFacadeLocal {

    void create(Caisse caisse);

    void edit(Caisse caisse);

    void remove(Caisse caisse);

    Caisse find(Object id);

    List<Caisse> findAll();

    List<Caisse> findRange(int[] range);

    int count();

    public long nextId();

    public List<Caisse> find(Membrecycle membrecycle, Rubriquecaisse rubriquecaisse, Rencontre rencontre) throws Exception;

    public List<Caisse> find(Membrecycle membrecycle, Rencontre rencontre) throws Exception;

    public List<Caisse> find(Membrecycle membrecycle) throws Exception;

    public List<Caisse> findByCycletontine(int cycletontine);

    List<Caisse> findByRubriqueCycle(Rubriquecaisse rubriquecaisse, Cycletontine cycletontine) throws Exception;

    List<Caisse> findByRubriqueRencontre(Rubriquecaisse rubriquecaisse, Rencontre rencontre) throws Exception;

}
