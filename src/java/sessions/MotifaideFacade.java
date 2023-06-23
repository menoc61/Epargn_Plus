/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Motifaide;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Abdel Bein Info
 */
@Stateless
public class MotifaideFacade extends AbstractFacade<Motifaide> implements MotifaideFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MotifaideFacade() {
        super(Motifaide.class);
    }

    @Override
    public Integer nextId() throws Exception {
        Query query = em.createQuery("SELECT MAX(m.idmotifaide) FROM Motifaide m");
        Integer resultat = (Integer) query.getSingleResult();
        if (resultat == null) {
            return 1;
        } else {
            return resultat + 1;
        }
    }

    @Override
    public Motifaide findByNom(String nom) {
        Motifaide motifaide = null;
        Query query;
        try {
            query = em.createNamedQuery("Motifaide.findByNomFr");
            query.setParameter("nomFr", nom);
            motifaide = (Motifaide) query.getSingleResult();
        } catch (Exception e) {
            e.getMessage();
            e.getCause();
        }
        return motifaide;
    }

}
