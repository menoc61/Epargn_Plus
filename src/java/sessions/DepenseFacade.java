/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Depense;
import entities.Depense;
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
public class DepenseFacade extends AbstractFacade<Depense> implements DepenseFacadeLocal {
    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public DepenseFacade() {
        super(Depense.class);
    }
     @Override
    public int nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(d.iddepense) FROM Depense d");
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
    public List<Depense> findByCycletontine(int cycletontine) {
        List<Depense> depenses = null;
        try {
            Query query = em.createQuery("SELECT s FROM Depense s WHERE s.idcycle.idcycle=:cycletontine");
            query.setParameter("cycletontine", cycletontine);
            depenses = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return depenses;
    }
}
