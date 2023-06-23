/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Sanction;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Abdel Bein Info
 */
@Stateless
public class SanctionFacade extends AbstractFacade<Sanction> implements SanctionFacadeLocal {
    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public SanctionFacade() {
        super(Sanction.class);
    }
    
    @Override
    public Integer nextId() throws Exception {
         
        Query query = em.createQuery("SELECT MAX(s.idtsanction) FROM Sanction s");
        Integer resultat = (Integer) query.getSingleResult();
        if (resultat==null) {
            return 1;
        } else {
            return  resultat + 1;
        }
    }
      @Override
    public Sanction findByNom(String nom) {
         Sanction sanction  = null;
        Query query;
        try {
            query = em.createNamedQuery("Sanction.findByNomFr");
            query.setParameter("nomFr", nom);
          sanction = (Sanction) query.getSingleResult();
        } catch (Exception e) {
            e.getMessage();
            e.getCause();
        }
        return sanction;
    }
    
}
