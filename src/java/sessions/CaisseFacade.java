/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Caisse;
import entities.Cycletontine;
import entities.Membrecycle;
import entities.Rencontre;
import entities.Rubriquecaisse;
import java.util.ArrayList;
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
public class CaisseFacade extends AbstractFacade<Caisse> implements CaisseFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CaisseFacade() {
        super(Caisse.class);
    }

    @Override
    public long nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(u.idcaisse) FROM Caisse u");
            List listObj = query.getResultList();
            if (!listObj.isEmpty()) {
                return ((Long) listObj.get(0)) + 1;
            } else {
                return 1l;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return 1;
        }
    }

    @Override
    public List<Caisse> find(Membrecycle membrecycle, Rubriquecaisse rubriquecaisse, Rencontre rencontre) throws Exception {
        List<Caisse> caissees = new ArrayList<>();
        Query query = em.createQuery("SELECT r FROM Caisse r WHERE r.idmembrecycle.idmembrecycle=:membrecycle AND r.idrubriquecaisse.idrubriquecaisse=:rubriquecaisse AND r.idrencontre.idrencontre=:rencontre");
        query.setParameter("membrecycle", membrecycle.getIdmembrecycle()).setParameter("rubriquecaisse", rubriquecaisse.getIdrubriquecaisse()).setParameter("rencontre", rencontre.getIdrencontre());
        if (!query.getResultList().isEmpty()) {
            caissees = query.getResultList();
        }
        return caissees;
    }

    @Override
    public List<Caisse> find(Membrecycle membrecycle, Rencontre rencontre) throws Exception {
        List<Caisse> caissees = new ArrayList<>();
        Query query = em.createQuery("SELECT r FROM Caisse r WHERE r.idmembrecycle.idmembrecycle=:membrecycle AND r.idrencontre.idrencontre=:rencontre");
        query.setParameter("membrecycle", membrecycle.getIdmembrecycle()).setParameter("rencontre", rencontre.getIdrencontre());
        if (!query.getResultList().isEmpty()) {
            caissees = query.getResultList();
        }
        return caissees;
    }

    @Override
    public List<Caisse> find(Membrecycle membrecycle) throws Exception {
        List<Caisse> caissees = new ArrayList<>();
        Query query = em.createQuery("SELECT r FROM Caisse r WHERE r.idmembrecycle.idmembrecycle=:membrecycle");
        query.setParameter("membrecycle", membrecycle.getIdmembrecycle());
        if (!query.getResultList().isEmpty()) {
            caissees = query.getResultList();
        }
        return caissees;
    }

    @Override
    public List<Caisse> findByRubriqueCycle(Rubriquecaisse rubriquecaisse, Cycletontine cycletontine) throws Exception {
        Query query = em.createQuery("SELECT c FROM Caisse c WHERE c.idrubriquecaisse.idrubriquecaisse=:rubrique AND c.idcycle.idcycle=:cycle ORDER BY c.idmembrecycle.idmembre.code");
        query.setParameter("rubrique", rubriquecaisse.getIdrubriquecaisse()).setParameter("cycle", cycletontine.getIdcycle());
        return query.getResultList();
    }

    @Override
    public List<Caisse> findByCycletontine(int cycletontine) {
        List<Caisse> caisses = null;
        try {
            Query query = em.createQuery("SELECT s FROM Caisse s WHERE s.idcycle.idcycle=:cycletontine");
            query.setParameter("cycletontine", cycletontine);
            caisses = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return caisses;
    }

    @Override
    public List<Caisse> findByRubriqueRencontre(Rubriquecaisse rubriquecaisse, Rencontre rencontre) throws Exception {
        Query query = em.createQuery("SELECT c FROM Caisse c WHERE c.idrubriquecaisse.idrubriquecaisse=:rubrique AND c.idrencontre.idrencontre=:rencontre");
        query.setParameter("rubrique", rubriquecaisse.getIdrubriquecaisse()).setParameter("rencontre", rencontre.getIdrencontre());
        return query.getResultList();
    }
}
