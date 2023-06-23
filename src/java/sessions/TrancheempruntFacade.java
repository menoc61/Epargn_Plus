/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Trancheemprunt;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Abdel Bein Info
 */
@Stateless
public class TrancheempruntFacade extends AbstractFacade<Trancheemprunt> implements TrancheempruntFacadeLocal {
    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public TrancheempruntFacade() {
        super(Trancheemprunt.class);
    }
    
}
