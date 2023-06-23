/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Membretontine;
import entities.Tontine;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author kenne
 */
@Stateless
public class MembretontineFacade extends AbstractFacade<Membretontine> implements MembretontineFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MembretontineFacade() {
        super(Membretontine.class);
    }

    @Override
    public Integer nextId() throws Exception {
        Query query = em.createQuery("SELECT MAX(i.idmembretontine) FROM Membretontine i");
        Integer resultat = (Integer) query.getSingleResult();
        if (resultat == null) {
            return 1;
        } else {
            return resultat + 1;
        }
    }

    @Override
    public List<Membretontine> findByTontine(Tontine tontine) throws Exception {
        List<Membretontine> membretontines = null;
        Query query = em.createQuery("SELECT m FROM Membretontine m WHERE m.idtontine.idtontine=:tontine ORDER BY m.idmembre.code");
        query.setParameter("tontine", tontine.getIdtontine());
        membretontines = query.getResultList();
        return membretontines;
    }

    @Override
    public List<Membretontine> findByMembre(int idmembre) throws Exception {
        Query query = em.createQuery("SELECT m FROM Membretontine m WHERE m.idmembre.idmembre=:idmembre");
        return (List<Membretontine>) query.setParameter("idmembre", idmembre).getResultList();
    }

    @Override
    public List<Membretontine> findByMembreTontine(int idmembre, int idtontine) throws Exception {
        Query query = em.createQuery("SELECT m FROM Membretontine m WHERE m.idmembre.idmembre=:idmembre AND m.idtontine.idtontine=:idtontine");
        return (List<Membretontine>) query.setParameter("idmembre", idmembre).setParameter("idtontine", idtontine).getResultList();
    }

}
