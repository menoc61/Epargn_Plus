/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Aide;
import entities.Aide;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Abdel Bein Info
 */
@Stateless
public class AideFacade extends AbstractFacade<Aide> implements AideFacadeLocal {
    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AideFacade() {
        super(Aide.class);
    }
      @Override
    public int nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(i.idaide) FROM Aide i");
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
    public List<Aide> findByCycletontine(int cycletontine) {
        List<Aide> aides = null;
        try {
            Query query = em.createQuery("SELECT s FROM Aide s WHERE s.idcycle.idcycle=:cycletontine");
            query.setParameter("cycletontine", cycletontine);
            aides = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return aides;
    }
}
