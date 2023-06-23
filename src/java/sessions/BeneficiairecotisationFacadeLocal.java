/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Beneficiairecotisation;
import entities.Cotisation;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface BeneficiairecotisationFacadeLocal {

    void create(Beneficiairecotisation beneficiairecotisation);

    void edit(Beneficiairecotisation beneficiairecotisation);

    void remove(Beneficiairecotisation beneficiairecotisation);

    Beneficiairecotisation find(Object id);

    List<Beneficiairecotisation> findAll();

    List<Beneficiairecotisation> findRange(int[] range);

    int count();
    
    int nextId();
    
}
