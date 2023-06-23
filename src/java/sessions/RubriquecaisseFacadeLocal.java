/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Rubriquecaisse;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface RubriquecaisseFacadeLocal {

    void create(Rubriquecaisse rubriquecaisse);

    void edit(Rubriquecaisse rubriquecaisse);

    void remove(Rubriquecaisse rubriquecaisse);

    Rubriquecaisse find(Object id);

    List<Rubriquecaisse> findAll();

    List<Rubriquecaisse> findRange(int[] range);

    int count();

    Rubriquecaisse findByNom(String nom);

    Integer nextId() throws Exception;

    List<Rubriquecaisse> findAllRange();
    
    List<Rubriquecaisse> findAllRangeCode();

    List<Rubriquecaisse> findByEtataffiche(Boolean etat) throws Exception;
    
    List<Rubriquecaisse> findByEditable(Boolean etat) throws Exception;
    
    List<Rubriquecaisse> findByNaturecaisse(int naturecaisse) throws Exception;

}
