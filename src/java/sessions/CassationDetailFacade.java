/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.CassationDetail;
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
public class CassationDetailFacade extends AbstractFacade<CassationDetail> implements CassationDetailFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CassationDetailFacade() {
        super(CassationDetail.class);
    }

    @Override
    public Long nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(c.id) FROM CassationDetail c");
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
    public List<CassationDetail> findByCycle(Cycletontine cycletontine) throws Exception {
        List<CassationDetail> cassationDetails = null;
        Query query = em.createQuery("SELECT  c FROM CassationDetail c WHERE c.idcycle.idcycle=:idcycle ORDER BY c.idmembre.idmembre.nom , c.idmembre.idmembre.prenom");
        query.setParameter("idcycle", cycletontine.getIdcycle());
        cassationDetails = query.getResultList();
        return cassationDetails;
    }

}
