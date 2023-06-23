/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.CollecteSecours;
import entities.Cycletontine;
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
public class CollecteSecoursFacade extends AbstractFacade<CollecteSecours> implements CollecteSecoursFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CollecteSecoursFacade() {
        super(CollecteSecours.class);
    }

    @Override
    public Long nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(c.id) FROM CollecteSecours c");
            List listObj = query.getResultList();
            if (!listObj.isEmpty()) {
                return ((Long) listObj.get(0)) + 1;
            } else {
                return 1L;
            }
        } catch (Exception e) {
            return 1L;
        }
    }

    @Override
    public List<CollecteSecours> findByCycle(Cycletontine cycletontine) throws Exception {
        List<CollecteSecours> collecteSecourses = null;
        Query query = em.createQuery("SELECT c FROM CollecteSecours c WHERE c.idmembre.idcycle.idcycle=:cycle ORDER BY c.idrencontre.daterencontre DESC , c.idmembre.idmembre.code");
        query.setParameter("cycle", cycletontine.getIdcycle());
        collecteSecourses = query.getResultList();
        return collecteSecourses;
    }

}
