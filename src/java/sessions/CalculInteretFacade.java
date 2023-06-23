/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.CalculInteret;
import entities.Rencontre;
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
public class CalculInteretFacade extends AbstractFacade<CalculInteret> implements CalculInteretFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CalculInteretFacade() {
        super(CalculInteret.class);
    }

    @Override
    public Long nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(c.id) FROM CalculInteret c");
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
    public List<CalculInteret> findByRencontre(Rencontre rencontre) throws Exception {
        List<CalculInteret> calculInterets = null;
        Query query = em.createQuery("SELECT c FROM CalculInteret c WHERE c.idrencontre.idrencontre=:rencontre");
        query.setParameter("rencontre", rencontre.getIdrencontre());
        calculInterets = query.getResultList();
        return calculInterets;
    }

}
