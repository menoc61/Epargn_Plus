/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cassation;
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
public class CassationFacade extends AbstractFacade<Cassation> implements CassationFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CassationFacade() {
        super(Cassation.class);
    }

    @Override
    public Long nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(c.id) FROM Cassation c");
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
    public List<Cassation> findByCycle(Cycletontine cycletontine) throws Exception {
        List<Cassation> cassations = null;
        Query query = em.createQuery("SELECT  c FROM Cassation c WHERE c.idcycle.idcycle=:idcycle ORDER BY c.idmembre.idmembre.nom , c.idmembre.idmembre.prenom");
        query.setParameter("idcycle", cycletontine.getIdcycle());
        cassations = query.getResultList();
        return cassations;
    }

}
