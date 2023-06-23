/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Mois;
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
public class MoisFacade extends AbstractFacade<Mois> implements MoisFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MoisFacade() {
        super(Mois.class);
    }

    @Override
    public List<Mois> findAllRange() {
        List<Mois> moiss = null;
        Query query = em.createQuery("SELECT a FROM Mois a ORDER BY a.nomFr");
        moiss = query.getResultList();
        return moiss;
    }

}
