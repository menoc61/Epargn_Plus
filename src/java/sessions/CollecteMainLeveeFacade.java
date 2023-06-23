/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.CollecteMainLevee;
import entities.CollecteSecours;
import entities.Cycletontine;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author USER
 */
@Stateless
public class CollecteMainLeveeFacade extends AbstractFacade<CollecteMainLevee> implements CollecteMainLeveeFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CollecteMainLeveeFacade() {
        super(CollecteMainLevee.class);
    }

    @Override
    public Long nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(c.id) FROM CollecteMainLevee c");
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
    public List<CollecteMainLevee> findByCycle(Cycletontine cycletontine) throws Exception {
        List<CollecteMainLevee> collecteMainLevees = null;
        Query query = em.createQuery("SELECT c FROM CollecteMainLevee c WHERE c.idmembre.idcycle.idcycle=:cycle ORDER BY c.idrencontre.daterencontre DESC , c.idmembre.idmembre.code");
        query.setParameter("cycle", cycletontine.getIdcycle());
        collecteMainLevees = query.getResultList();
        return collecteMainLevees;
    }

}
