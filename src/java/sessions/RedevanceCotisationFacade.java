/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.RedevanceCotisation;
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
public class RedevanceCotisationFacade extends AbstractFacade<RedevanceCotisation> implements RedevanceCotisationFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public RedevanceCotisationFacade() {
        super(RedevanceCotisation.class);
    }

    @Override
    public List<RedevanceCotisation> findByCycleNotPayed(int idcycle) throws Exception {
        Query query = em.createQuery("SELECT r FROM RedevanceCotisation r WHERE r.idinscription.idcotisation.idcycle.idcycle=:idcycle AND r.reste>0d");
        query.setParameter("idcycle", idcycle);
        return (List<RedevanceCotisation>) query.getResultList();
    }

}
