/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Pays;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Abdel Bein Info
 */
@Stateless
public class PaysFacade extends AbstractFacade<Pays> implements PaysFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PaysFacade() {
        super(Pays.class);
    }

    @Override
    public Integer nextId() throws Exception {
        Query query = em.createQuery("SELECT MAX(p.idpays) FROM Pays p");
        Integer resultat = (Integer) query.getSingleResult();
        if (resultat == null) {
            return 1;
        } else {
            return resultat + 1;
        }
    }

    @Override
    public Pays findByNom(String nomFr) {
        Pays pays = null;
        try {
            Query query = em.createNamedQuery("Pays.findByNomFr");
            query.setParameter("nomFr", nomFr);
            pays = (Pays) query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pays;
    }
}
