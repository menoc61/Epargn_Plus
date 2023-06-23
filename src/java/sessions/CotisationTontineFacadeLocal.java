/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

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
public interface CotisationTontineFacadeLocal {

    void create(CotisationTontine cotisationTontine);

    void edit(CotisationTontine cotisationTontine);

    void remove(CotisationTontine cotisationTontine);

    CotisationTontine find(Object id);

    List<CotisationTontine> findAll();

    List<CotisationTontine> findRange(int[] range);
    
    List<CotisationTontine> findByRencontre(int idrencontre) throws Exception;

    List<CotisationTontine> findByRencontreCotisation(int idrencontre, int idcotisation) throws Exception;

    List<CotisationTontine> findByCotisation(int idcotisation) throws Exception;
    
    List<CotisationTontine> findBy_main (Mains m);
    
    List<CotisationTontine> findBy_tontiner (Tontiner t);
    
    List<CotisationTontine> findBy_inscriptionCotisation(InscriptionCotisation i);
    
    List<CotisationTontine> findBy_inscriptionCotisation_tontiner(InscriptionCotisation i, Tontiner t);
    
    CotisationTontine findBy_main_tontiner (Mains m, Tontiner t);

    int count();
    
    Long nextId() throws Exception;

    
    
}
