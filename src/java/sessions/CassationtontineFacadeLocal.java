/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cassationtontine;
import entities.InscriptionCotisation;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Louis Stark
 */
@Local
public interface CassationtontineFacadeLocal {

    void create(Cassationtontine cassationtontine);

    void edit(Cassationtontine cassationtontine);

    void remove(Cassationtontine cassationtontine);

    Cassationtontine find(Object id);

    List<Cassationtontine> findAll();
    
    List<Cassationtontine> findAllBy_inscriptionCotisation(InscriptionCotisation i);

    List<Cassationtontine> findRange(int[] range);

    int count();
    
    int nextId();
    
}
