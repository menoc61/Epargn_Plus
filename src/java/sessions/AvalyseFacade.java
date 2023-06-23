/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Avalyse;
import entities.Emprunt;
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
public class AvalyseFacade extends AbstractFacade<Avalyse> implements AvalyseFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AvalyseFacade() {
        super(Avalyse.class);
    }

    @Override
    public Long nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(a.idavalyse) FROM Avalyse a");
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
    public List<Avalyse> findByEmprunt(Emprunt emprunt) throws Exception {
        List<Avalyse> avalyses = null;
        Query query = em.createQuery("SELECT a FROM Avalyse a WHERE a.idemprunt.idemprunt=:emprunt");
        query.setParameter("emprunt", emprunt.getIdemprunt());
        avalyses = query.getResultList();
        return avalyses;
    }

}
