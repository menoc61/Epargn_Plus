/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.BeneficiaireTontine;
import entities.Cotisation;
import entities.InscriptionCotisation;
import entities.Mains;
import entities.Tontiner;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author USER
 */
@Local
public interface BeneficiaireTontineFacadeLocal {

    void create(BeneficiaireTontine beneficiaireTontine);

    void edit(BeneficiaireTontine beneficiaireTontine);

    void remove(BeneficiaireTontine beneficiaireTontine);

    BeneficiaireTontine find(Object id);
    
    BeneficiaireTontine findBy_main(Mains m);
    
    List<BeneficiaireTontine> findBy_inscriptionCotisation(InscriptionCotisation i);
    
    List<BeneficiaireTontine> findAll();

    List<BeneficiaireTontine> findRange(int[] range);

    int count();

    Long nextId();

    List<BeneficiaireTontine> findByRencontre(int idrencontre) throws Exception;
    
    List<BeneficiaireTontine> findBy_cotisation(Cotisation c);

    List<BeneficiaireTontine> findByRencontreCotisation(int idrencontre, int idcotisation) throws Exception;

    List<BeneficiaireTontine> findByRencontreInscription(int idrencontre, long idinscription) throws Exception;

    List<BeneficiaireTontine> findBy_tontiner(Tontiner t);

    int NextOrderNumber(int idcotisation) throws Exception;

}
