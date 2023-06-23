/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cotisation;
import entities.InscriptionCotisation;
import entities.Membrecycle;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface InscriptionCotisationFacadeLocal {

    void create(InscriptionCotisation inscriptionCotisation);

    void edit(InscriptionCotisation inscriptionCotisation);

    void remove(InscriptionCotisation inscriptionCotisation);

    InscriptionCotisation find(Object id);
    
    InscriptionCotisation findBy_cotisation_membrecycle(Cotisation c, Membrecycle m);

    List<InscriptionCotisation> findAll();

    List<InscriptionCotisation> findRange(int[] range);

    int count();

    Long nextId();

    List<InscriptionCotisation> findByCotisation(int idcotisation) throws Exception;

    List<InscriptionCotisation> findByCotisationMembre(int idcotisation, int idmembrecycle) throws Exception;

}
