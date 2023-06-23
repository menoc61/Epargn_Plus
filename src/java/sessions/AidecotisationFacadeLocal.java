/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Aidecotisation;
import entities.Cotisation;
import entities.CotisationTontine;
import entities.InscriptionCotisation;
import entities.Mains;
import entities.Tontiner;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Louis Stark
 */
@Local
public interface AidecotisationFacadeLocal {

    void create(Aidecotisation aidecotisation);

    void edit(Aidecotisation aidecotisation);

    void remove(Aidecotisation aidecotisation);

    Aidecotisation find(Object id);

    List<Aidecotisation> findAll();
    
    List<Aidecotisation> findAllBy_cotisation(Cotisation c);
    
    List<Aidecotisation> findAllBy_main(Mains m);
    
    List<Aidecotisation> findAllBy_tontiner_main(Tontiner t, Mains m);
    
    List<Aidecotisation> findAllBy_cotisationTontine(CotisationTontine c);
    
    List<Aidecotisation> findAllBy_inscriptionCotisation(InscriptionCotisation i);
    
    List<Aidecotisation> findAllBy_inscriptionCotisation_tontiner(InscriptionCotisation i, Tontiner t);

    List<Aidecotisation> findRange(int[] range);

    int count();
    
    int nextId();
    
}
