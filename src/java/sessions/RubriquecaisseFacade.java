/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Rubriquecaisse;
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
public class RubriquecaisseFacade extends AbstractFacade<Rubriquecaisse> implements RubriquecaisseFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public RubriquecaisseFacade() {
        super(Rubriquecaisse.class);
    }

    @Override
    public Rubriquecaisse findByNom(String nom) {
        Rubriquecaisse rubriquecaisse = null;
        Query query;
        try {
            query = em.createNamedQuery("Rubriquecaisse.findByNomFr");
            query.setParameter("nomFr", nom);
            rubriquecaisse = (Rubriquecaisse) query.getSingleResult();
        } catch (Exception e) {
            e.getMessage();
            e.getCause();
        }
        return rubriquecaisse;
    }

    @Override
    public Integer nextId() throws Exception {

        Query query = em.createQuery("SELECT MAX(r.idrubriquecaisse) FROM Rubriquecaisse r");
        Integer resultat = (Integer) query.getSingleResult();
        if (resultat == null) {
            return 1;
        } else {
            return resultat + 1;
        }
    }

    @Override
    public List<Rubriquecaisse> findAllRange() {
        List<Rubriquecaisse> rubriquecaisses = null;
        Query query = em.createQuery("SELECT a FROM Rubriquecaisse a ORDER BY a.code , a.nomfr");
        rubriquecaisses = query.getResultList();
        return rubriquecaisses;
    }

    @Override
    public List<Rubriquecaisse> findAllRangeCode() {
        List<Rubriquecaisse> rubriquecaisses = null;
        Query query = em.createQuery("SELECT a FROM Rubriquecaisse a ORDER BY a.code , a.nomfr");
        rubriquecaisses = query.getResultList();
        return rubriquecaisses;
    }

    @Override
    public List<Rubriquecaisse> findByEtataffiche(Boolean etat) throws Exception {
        List<Rubriquecaisse> rubriquecaisses = null;
        Query query = em.createQuery("SELECT a FROM Rubriquecaisse a WHERE a.afficher=:etat ORDER BY a.code , a.nomfr");
        query.setParameter("etat", etat);
        rubriquecaisses = query.getResultList();
        return rubriquecaisses;
    }

    @Override
    public List<Rubriquecaisse> findByEditable(Boolean etat) throws Exception {
        List<Rubriquecaisse> rubriquecaisses = null;
        Query query = em.createQuery("SELECT a FROM Rubriquecaisse a WHERE a.editableEnCaisse=:etat ORDER BY a.code , a.nomfr");
        query.setParameter("etat", etat);
        rubriquecaisses = query.getResultList();
        return rubriquecaisses;
    }

    @Override
    public List<Rubriquecaisse> findByNaturecaisse(int naturecaisse) throws Exception {
        List<Rubriquecaisse> rubriquecaisses = null;
        Query query = em.createQuery("SELECT r FROM Rubriquecaisse r WHERE r.idnaturecaisse.idnaturecaisse=:naturecaisse ORDER BY r.code , r.nomfr");
        query.setParameter("naturecaisse", naturecaisse);
        rubriquecaisses = query.getResultList();
        return rubriquecaisses;
    }
}
