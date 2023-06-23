/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Recette;
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
public class RecetteFacade extends AbstractFacade<Recette> implements RecetteFacadeLocal {
    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public RecetteFacade() {
        super(Recette.class);
    }
     @Override
    public int nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(d.idrecette) FROM Recette d");
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
    public List<Recette> findByCycletontine(int cycletontine) {
        List<Recette> recettes = null;
        try {
            Query query = em.createQuery("SELECT s FROM Recette s WHERE s.idcycle.idcycle=:cycletontine");
            query.setParameter("cycletontine", cycletontine);
            recettes = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return recettes;
    }
}
