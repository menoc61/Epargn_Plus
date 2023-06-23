/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Tranchecotisation;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Abdel Bein Info
 */
@Stateless
public class TranchecotisationFacade extends AbstractFacade<Tranchecotisation> implements TranchecotisationFacadeLocal {
    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public TranchecotisationFacade() {
        super(Tranchecotisation.class);
    }
    
}
