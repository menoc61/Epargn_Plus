/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cycletontine;
import entities.Remboursement;
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
public class RemboursementFacade extends AbstractFacade<Remboursement> implements RemboursementFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public RemboursementFacade() {
        super(Remboursement.class);
    }

    @Override
    public Integer nextId() throws Exception {
        Query query = em.createQuery("SELECT MAX(r.idremboursement) FROM Remboursement r");
        Integer resultat = (Integer) query.getSingleResult();
        if (resultat == null) {
            return 1;
        } else {
            return resultat + 1;
        }
    }

    @Override
    public List<Remboursement> findByCycle(Cycletontine cycletontine) throws Exception {
        List<Remboursement> remboursements = null;
        Query query = em.createQuery("SELECT r FROM Remboursement r WHERE r.idrencontre.idcycle.idcycle=:idcycle ORDER BY r.daterembour DESC");
        query.setParameter("idcycle", cycletontine.getIdcycle());
        remboursements = query.getResultList();
        return remboursements;
    }

    @Override
    public List<Remboursement> findByEmprunt(Integer idemprunt) throws Exception {
        List<Remboursement> remboursements = null;
        Query query = em.createQuery("SELECT r FROM Remboursement r WHERE r.idemprunt.idemprunt=:idemprunt ORDER BY r.daterembour DESC");
        query.setParameter("idemprunt", idemprunt);
        remboursements = query.getResultList();
        return remboursements;
    }
}
