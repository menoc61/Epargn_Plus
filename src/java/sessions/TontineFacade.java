/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Tontine;
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
public class TontineFacade extends AbstractFacade<Tontine> implements TontineFacadeLocal {
    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public TontineFacade() {
        super(Tontine.class);
    }
     @Override
    public int nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(i.idtontine) FROM Tontine i");
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
    public List<Tontine> findByCycletontine(int cycletontine) {
        List<Tontine> tontines = null;
        try {
            Query query = em.createQuery("SELECT s FROM Tontine s WHERE s.idcycle.idcycle=:cycletontine");
            query.setParameter("cycletontine", cycletontine);
            tontines = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tontines;
    }
   /* @Override
    public List<Tontine> findByInstitution(Institution institution) throws Exception {
        List<Tontine> tontines = null;
        Query query = em.createQuery("SELECT a FROM Tontine a WHERE a.idactivite.idaction.idprogramme.idinstitution.idinstitution=:institution");
        query.setParameter("institution", institution.getIdinstitution());
        tontines = query.getResultList();
        return tontines;
    }*/
}
