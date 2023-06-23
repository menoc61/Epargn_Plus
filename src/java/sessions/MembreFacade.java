/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Membre;
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
public class MembreFacade extends AbstractFacade<Membre> implements MembreFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MembreFacade() {
        super(Membre.class);
    }

    @Override
    public int nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(u.idmembre) FROM Membre u");
            return ((Integer) query.getResultList().get(0)) + 1;
        } catch (Exception e) {
            return 1;
        }
    }

    @Override
    public List<Membre> findAllRange() throws Exception {
        Query query = em.createQuery("SELECT m FROM Membre m ORDER BY m.code");
        return (List<Membre>) query.getResultList();
    }

    @Override
    public Membre findByNomPrenom(String nom, String prenom) {
        Membre membre = null;
        try {
            Query query = em.createQuery("SELECT u FROM Membre u WHERE UPPER(u.nom) = UPPER(:nom) AND UPPER(u.prenom)=UPPER(:prenom)");
            query.setParameter("nom", nom);
            query.setParameter("prenom", prenom);
            membre = (Membre) query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return membre;
    }

    @Override
    public List<Membre> findByCycletontine(int cycletontine) {
        List<Membre> membres = null;
        try {
            Query query = em.createQuery("SELECT s FROM Membre s WHERE s.idcycle.idcycle=:cycletontine");
            query.setParameter("cycletontine", cycletontine);
            membres = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return membres;
    }

}
