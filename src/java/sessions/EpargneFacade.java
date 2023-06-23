/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cycletontine;
import entities.Epargne;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author kenne
 */
@Stateless
public class EpargneFacade extends AbstractFacade<Epargne> implements EpargneFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public EpargneFacade() {
        super(Epargne.class);
    }

    @Override
    public List<Epargne> findByCycle(Cycletontine cycletontine) throws Exception {
        List<Epargne> epargnes = null;
        Query query = em.createQuery("SELECT e FROM Epargne e WHERE e.idmembrecycle.idcycle.idcycle=:cycle");
        query.setParameter("cycle", cycletontine.getIdcycle());
        epargnes = query.getResultList();
        return epargnes;
    }
    
    @Override
    public int nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(i.idepargne) FROM Epargne i");
            List listObj = query.getResultList();
            if (!listObj.isEmpty()) {
                return ((Integer) listObj.get(0)) + 1;
            } else {
                return 1;
            }
        } catch (Exception e) {
            return 1;
        }
    }
    
    @Override
    public List<Epargne> findByCycletontine(int cycletontine) {
        List<Epargne> epargnes = null;
        try {
            Query query = em.createQuery("SELECT s FROM Epargne s WHERE s.idmembrecycle.idcycle.idcycle=:cycletontine");
            query.setParameter("cycletontine", cycletontine);
            epargnes = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return epargnes;
    }
    
    

}
