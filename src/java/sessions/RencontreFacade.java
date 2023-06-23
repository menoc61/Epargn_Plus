/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cycletontine;
import entities.Rencontre;
import entities.Tontine;
import java.util.ArrayList;
import java.util.Date;
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
public class RencontreFacade extends AbstractFacade<Rencontre> implements RencontreFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public RencontreFacade() {
        super(Rencontre.class);
    }

    @Override
    public Integer nextId() {
        Query query = em.createQuery("SELECT MAX(p.idrencontre) FROM Rencontre p");
        try {
            return (Integer) query.getSingleResult() + 1;
        } catch (Exception e) {
        }
        return 1;
    }

    @Override
    public Rencontre findByNom(String nomFr) {
        Rencontre rencontre = null;
        try {
            Query query = em.createNamedQuery("Rencontre.findByNomfr");
            query.setParameter("nomfr", nomFr);
            rencontre = (Rencontre) query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rencontre;
    }

    @Override
    public List<Rencontre> findByTontine(Tontine tontine) {
        Query query = em.createQuery("SELECT r FROM Rencontre r WHERE r.idTontine.idtontine=:idTontine ORDER BY r.daterencontre");
        query.setParameter("idTontine", tontine.getIdtontine());
        return query.getResultList();
    }

    @Override
    public List<Rencontre> findByCycle(Cycletontine cycletontine, Boolean ouverture) {
        Query query = em.createQuery("SELECT r FROM Rencontre r WHERE r.idcycle.idcycle=:idcycle AND r.ouvertureRencontre=:ouverte ORDER BY r.daterencontre");
        query.setParameter("idcycle", cycletontine.getIdcycle()).setParameter("ouverte", ouverture);
        return query.getResultList();
    }

    @Override
    public List<Rencontre> findByCycle(Cycletontine cycletontine, boolean ouverture, boolean fermetture) {
        Query query = em.createQuery("SELECT r FROM Rencontre r WHERE r.idcycle.idcycle=:idcycle AND r.ouvertureRencontre=:ouverte AND r.fermetture=:fermetture  ORDER BY r.daterencontre");
        query.setParameter("idcycle", cycletontine.getIdcycle()).setParameter("ouverte", ouverture).setParameter("fermetture", fermetture);
        return query.getResultList();
    }

    @Override
    public Rencontre findBy_nomFr_date_cycle(String nom, Date date, Cycletontine c) {
        Query q = em.createQuery("SELECT r FROM Rencontre r WHERE r.nomfr = :nom AND r.daterencontre = :date_r AND r.idcycle.idcycle = :id_c");
        q.setParameter("nom", nom);
        q.setParameter("date_r", date);
        q.setParameter("id_c", c.getIdcycle());
        try {
            return (Rencontre) q.getSingleResult();
        } catch (Exception e) {
        }
        return null;
    }

    @Override
    public Rencontre findBy_date_cycle(Date date, Cycletontine c) {
        Query q = em.createQuery("SELECT r FROM Rencontre r WHERE r.daterencontre = :date_r AND r.idcycle.idcycle = :id_c");
        q.setParameter("date_r", date);
        q.setParameter("id_c", c.getIdcycle());
        try {
            return (Rencontre) q.getSingleResult();
        } catch (Exception e) {
        }
        return null;
    }

    @Override
    public List<Rencontre> findAll_rencontreOfcotisation() {
        Query q = em.createQuery("SELECT r FROM Rencontre r WHERE r.isRencontreCotisation IS NOT NULL AND r.isRencontreCotisation = true");
        return q.getResultList();
    }

    @Override
    public Rencontre findBy_date_tontine(Date date, Tontine t) {
        Query q = em.createQuery("SELECT r FROM Rencontre r WHERE r.daterencontre = :date AND (r.idcycle.idtontine.idtontine = :id_t OR r.idTontine.idtontine = :id_t)");
        try {
            return (Rencontre) q.getResultList().get(0);
        } catch (Exception e) {
        }
        return null;
    }

    @Override
    public List<Rencontre> findAll_rencontreOfcotisation_after_date(Date d) {
        Query q = em.createQuery("SELECT r FROM Rencontre r WHERE r.isRencontreCotisation IS NOT NULL AND r.isRencontreCotisation = true AND r.daterencontre >= :date");
        try {
            q.setParameter("date", d);
            return q.getResultList();
        } catch (Exception e) {
        }
        return new ArrayList<>();
    }

    @Override
    public List<Rencontre> findByCycle(Cycletontine cycletontine) {
        Query query = em.createQuery("SELECT r FROM Rencontre r WHERE r.idcycle.idcycle=:idcycle AND r.ouvertureRencontre=:ouverte ORDER BY r.daterencontre");
        query.setParameter("idcycle", cycletontine.getIdcycle());
        return query.getResultList();
    }
    
    @Override
    public List<Rencontre> findByRencontreCotisation(Tontine tontine) {
        Query query = em.createQuery("SELECT r FROM Rencontre r WHERE r.idcycle.idtontine.idtontine=:idTontine AND r.isRencontreCotisation=true ORDER BY r.daterencontre");
        query.setParameter("idTontine", tontine.getIdtontine());
        return query.getResultList();
    }
    
    @Override
    public List<Rencontre> findByCycleCotisation(Cycletontine cycletontine , boolean rencontre) {
        Query query = em.createQuery("SELECT r FROM Rencontre r WHERE r.idcycle.idcycle=:idcycle AND r.isRencontreCotisation=:r  ORDER BY r.daterencontre");
        query.setParameter("idcycle", cycletontine.getIdcycle()).setParameter("r", rencontre);
        return query.getResultList();
    }

}
