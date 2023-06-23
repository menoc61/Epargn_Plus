/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cycletontine;
import entities.Membre;
import entities.Membrecycle;
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
public class MembrecycleFacade extends AbstractFacade<Membrecycle> implements MembrecycleFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MembrecycleFacade() {
        super(Membrecycle.class);
    }

    @Override
    public int nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(u.idmembrecycle) FROM Membrecycle u");
            return (Integer) query.getResultList().get(0) + 1;
        } catch (Exception e) {
            return 1;
        }
    }

    @Override
    public Membrecycle findByMembreCycle(int membre, int cycle) {
        Membrecycle membrecycle = null;
        try {
            Query query = em.createQuery("SELECT u FROM Membrecycle u WHERE u.idmembre.idmembre=:membre AND u.idcycle.idcycle=:cycle");
            query.setParameter(membre, membre).setParameter("", cycle);
            membrecycle = (Membrecycle) query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return membrecycle;
    }

    @Override
    public List<Membrecycle> findByMembre(int membre) {
        Query query = em.createQuery("SELECT u FROM Membrecycle u WHERE u.idmembre.idmembre =:membre");
        query.setParameter("membre", membre);
        return query.getResultList();
    }

    @Override
    public List<Membrecycle> findAllRange() {
        Query query = em.createQuery("SELECT a FROM Membrecycle a ORDER BY a.idcycle.nomfr");
        return query.getResultList();
    }

    @Override
    public List<Membrecycle> findByCycle(Cycletontine cycletontine) throws Exception {
        Query query = em.createQuery("SELECT m FROM Membrecycle m WHERE m.idcycle.idcycle=:idcycle ORDER BY m.idmembre.code, m.idmembre.nom , m.idmembre.prenom");
        query.setParameter("idcycle", cycletontine.getIdcycle());
        return query.getResultList();
    }

    @Override
    public List<Membrecycle> findByCycle(Cycletontine cycletontine, Boolean etat) throws Exception {
        Query query = em.createQuery("SELECT m FROM Membrecycle m WHERE m.idcycle.idcycle=:idcycle AND m.etat=:etat ORDER BY m.idmembre.code");
        query.setParameter("idcycle", cycletontine.getIdcycle()).setParameter("etat", etat);
        return query.getResultList();
    }

    @Override
    public List<Membrecycle> findByCycletontine(int cycletontine) {
        List<Membrecycle> membrecycles = null;
        try {
            Query query = em.createQuery("SELECT s FROM Membrecycle s WHERE s.idcycle.idcycle=:cycletontine");
            query.setParameter("cycletontine", cycletontine);
            membrecycles = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return membrecycles;
    }

    @Override
    public List<Membrecycle> findByMembreCycle(Membre membre, Cycletontine cycletontine) throws Exception {
        Query query = em.createQuery("SELECT m FROM Membrecycle m WHERE m.idcycle.idcycle=:idcycle AND m.idmembre.idmembre=:idmembre ORDER BY m.idmembre.nom , m.idmembre.prenom");
        query.setParameter("idcycle", cycletontine.getIdcycle()).setParameter("idmembre", membre.getIdmembre());
        return query.getResultList();
    }

    @Override
    public List<Membrecycle> findByCycleNonpaye(Cycletontine cycletontine, Boolean etat) throws Exception {
        Query query = em.createQuery("SELECT m FROM Membrecycle m WHERE m.idcycle.idcycle=:idcycle AND m.etat=:etat AND m.idcaisse.idcaisse IS NULL ORDER BY m.idmembre.code");
        query.setParameter("idcycle", cycletontine.getIdcycle()).setParameter("etat", etat);
        return query.getResultList();
    }

}
