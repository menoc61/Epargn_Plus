/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cycletontine;
import entities.PayementSanction;
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
public class PayementSanctionFacade extends AbstractFacade<PayementSanction> implements PayementSanctionFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PayementSanctionFacade() {
        super(PayementSanction.class);
    }

    @Override
    public Long nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(p.id) FROM PayementSanction p");
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
    public List<PayementSanction> findByCycle(Cycletontine cycletontine) throws Exception {
        List<PayementSanction> payementSanctions = null;
        Query query = em.createQuery("SELECT p FROM PayementSanction p WHERE p.idrencontre.idcycle.idcycle=:cycle");
        query.setParameter("cycle", cycletontine.getIdcycle());
        payementSanctions = query.getResultList();
        return payementSanctions;
    }

}
