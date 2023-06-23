/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Frequencecotisation;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Louis Stark
 */
@Stateless
public class FrequencecotisationFacade extends AbstractFacade<Frequencecotisation> implements FrequencecotisationFacadeLocal {
    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public FrequencecotisationFacade() {
        super(Frequencecotisation.class);
    }
    
    @Override
    public int nextId() {
        Query q = em.createQuery("SELECT MAX(f.idfrequence) FROM Frequencecotisation f");
        try {
            return (Integer) q.getResultList().get(0) + 1;
        } catch (Exception e) {
        }
        return 1;
    }

    @Override
    public List<Frequencecotisation> findAllRange_by_name() {
        Query q = em.createQuery("SELECT f FROM Frequencecotisation f ORDER BY f.denomination");
        return q.getResultList();
    }
    
}
