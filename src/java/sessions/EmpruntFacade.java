/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Emprunt;
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
public class EmpruntFacade extends AbstractFacade<Emprunt> implements EmpruntFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public EmpruntFacade() {
        super(Emprunt.class);
    }

    @Override
    public int nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(i.idemprunt) FROM Emprunt i");
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
    public List<Emprunt> findByCycletontine(int cycletontine) {
        List<Emprunt> emprunts = null;
        try {
            Query query = em.createQuery("SELECT s FROM Emprunt s WHERE s.idmembre.idcycle.idcycle=:cycletontine ORDER BY s.dateemprunt DESC");
            query.setParameter("cycletontine", cycletontine);
            emprunts = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return emprunts;
    }

    @Override
    public List<Emprunt> findByCycletontine(int cycletontine, boolean rembourse) {
        List<Emprunt> emprunts = null;
        try {
            Query query = em.createQuery("SELECT s FROM Emprunt s WHERE s.idmembre.idcycle.idcycle=:cycletontine AND s.rembourse=:rembourse ORDER BY s.dateemprunt DESC");
            query.setParameter("cycletontine", cycletontine).setParameter("rembourse", rembourse);
            emprunts = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return emprunts;
    }

}
