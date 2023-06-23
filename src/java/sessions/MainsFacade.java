/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cotisation;
import entities.InscriptionCotisation;
import entities.Mains;
import entities.Membrecycle;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Louis Stark
 */
@Stateless
public class MainsFacade extends AbstractFacade<Mains> implements MainsFacadeLocal {
    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MainsFacade() {
        super(Mains.class);
    }
    
    @Override
    public int nextId() {
        Query q = em.createQuery("SELECT MAX(m.idmain) FROM Mains m");
        try {
            return (Integer) q.getResultList().get(0) + 1;
        } catch (Exception e) {
        }
        return 1;
    }

    @Override
    public List<Mains> findAll_by_Inscription(InscriptionCotisation i) {
        Query q = em.createQuery("SELECT m FROM Mains m WHERE m.idinscription.idinscription = :id_i");
        q.setParameter("id_i", i.getIdinscription());
        return q.getResultList();
    }
    
    @Override
    public List<Mains> findAll_by_Cotisation(Cotisation c) {
        Query q = em.createQuery("SELECT m FROM Mains m WHERE m.idinscription.idcotisation.idcotisation = :id_c");
        q.setParameter("id_c", c.getIdcotisation());
        return q.getResultList();
    }

    @Override
    public List<Mains> findAll_by_Cotisation_rangeBy_tirage(Cotisation c) {
        Query q = em.createQuery("SELECT m FROM Mains m WHERE m.idinscription.idcotisation.idcotisation = :id_c ORDER BY m.numeroordre ASC");
        q.setParameter("id_c", c.getIdcotisation());
        return q.getResultList();
    }

    @Override
    public List<Mains> findAll_by_Cotisation_membrecycle(Cotisation c, Membrecycle m) {
        Query q = em.createQuery("SELECT m FROM Mains m WHERE m.idinscription.idcotisation.idcotisation = :id_c AND m.idinscription.idmembre.idmembrecycle = :id_m");
        q.setParameter("id_c", c.getIdcotisation());
        q.setParameter("id_m", m.getIdmembrecycle());
        return q.getResultList();
    }
    
}
