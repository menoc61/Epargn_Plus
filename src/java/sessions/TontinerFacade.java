/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cotisation;
import entities.Mains;
import entities.Rencontre;
import entities.Tontiner;
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
public class TontinerFacade extends AbstractFacade<Tontiner> implements TontinerFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public TontinerFacade() {
        super(Tontiner.class);
    }

    @Override
    public int nextId() {
        Query q = em.createQuery("SELECT MAX(t.idtontiner) FROM Tontiner t");
        try {
            return (Integer) q.getResultList().get(0) + 1;
        } catch (Exception e) {
        }
        return 1;
    }

    @Override
    public List<Tontiner> findAllBy_cotisation(Cotisation c) {
        Query q = em.createQuery("SELECT t FROM Tontiner t WHERE t.idcotisation.idcotisation = :id_c ORDER BY t.idrencontre.daterencontre ASC");
        q.setParameter("id_c", c.getIdcotisation());
        return q.getResultList();
    }

    @Override
    public Tontiner findBy_cotisation_rencontre(Cotisation c, Rencontre r) {
        Query q = em.createQuery("SELECT t FROM Tontiner t WHERE t.idrencontre.idrencontre = :id_r AND t.idcotisation.idcotisation = :id_c");
        q.setParameter("id_r", r.getIdrencontre());
        q.setParameter("id_c", c.getIdcotisation());
        try {
            return (Tontiner) q.getSingleResult();
        } catch (Exception e) {
        }
        return null;
    }
}
