/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.BeneficiaireTontine;
import entities.Encherebenficiare;
import entities.Tontiner;
import java.util.ArrayList;
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
public class EncherebenficiareFacade extends AbstractFacade<Encherebenficiare> implements EncherebenficiareFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public EncherebenficiareFacade() {
        super(Encherebenficiare.class);
    }

    @Override
    public Encherebenficiare findBy_benficiaireTontine(BeneficiaireTontine b) {
        Query q = em.createQuery("SELECT e FROM Encherebenficiare e WHERE e.idbeneficiaire.idbeneficiaire = :id_b");
        try {
            q.setParameter("id_b", b.getIdbeneficiaire());
            return (Encherebenficiare) q.getResultList().get(0);
        } catch (Exception e) {
        }
        return null;
    }

    @Override
    public int nextId() {
        Query q = em.createQuery("SELECT MAX(e.idenchere) FROM Encherebenficiare e");
        try {
            return (Integer) q.getResultList().get(0) + 1;
        } catch (Exception e) {
        }
        return 1;
    }

    @Override
    public List<Encherebenficiare> findBy_tontiner(Tontiner t) {
        Query q = em.createQuery("SELECT e FROM Encherebenficiare e WHERE e.idbeneficiaire.idtontiner.idtontiner = :id_t");
        try {
            q.setParameter("id_t", t.getIdtontiner());
            return q.getResultList();
        } catch (Exception e) {
        }
        return new ArrayList<>();
    }

}
