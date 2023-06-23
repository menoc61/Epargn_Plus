/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.CotisationTontine;
import entities.InscriptionCotisation;
import entities.Mains;
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
public class CotisationTontineFacade extends AbstractFacade<CotisationTontine> implements CotisationTontineFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CotisationTontineFacade() {
        super(CotisationTontine.class);
    }

    @Override
    public Long nextId() throws Exception {

        Query query = em.createQuery("SELECT MAX(c.idcotisationtontine) FROM CotisationTontine c");
        Long resultat = (Long) query.getSingleResult();
        if (resultat == null) {
            return 1L;
        } else {
            return resultat + 1L;
        }
    }

    @Override
    public List<CotisationTontine> findByRencontre(int idrencontre) throws Exception {
        Query query = em.createQuery("SELECT c FROM CotisationTontine c WHERE c.idtontiner.idrencontre.idrencontre =:rencontre ORDER BY c.idmain.numeroordre");
        query.setParameter("rencontre", idrencontre);
        return query.getResultList();
    }

    @Override
    public List<CotisationTontine> findByRencontreCotisation(int idrencontre, int idcotisation) throws Exception {
        Query query = em.createQuery("SELECT c FROM CotisationTontine c WHERE c.idtontiner.idrencontre.idrencontre =:rencontre AND  c.idtontiner.idcotisation.idcotisation = :cotisation ORDER BY c.idmain.numeroordre");
        query.setParameter("rencontre", idrencontre).setParameter("cotisation", idcotisation);
        return query.getResultList();
    }

    @Override
    public List<CotisationTontine> findByCotisation(int idcotisation) throws Exception {
        Query query = em.createQuery("SELECT c FROM CotisationTontine c WHERE c.idmain.idinscription.idcotisation.idcotisation = :cotisation ORDER BY c.idtontiner.idrencontre.daterencontre DESC , c.idmain.numeroordre");
        query.setParameter("cotisation", idcotisation);
        return query.getResultList();
    }

    @Override
    public List<CotisationTontine> findBy_main(Mains m) {
        Query q = em.createQuery("SELECT c FROM CotisationTontine c WHERE c.idmain.idmain = :id_m");
        q.setParameter("id_m", m.getIdmain());
        return q.getResultList();
    }

    @Override
    public List<CotisationTontine> findBy_tontiner(Tontiner t) {
        Query q = em.createQuery("SELECT c FROM CotisationTontine c WHERE c.idtontiner.idtontiner = :id_t");
        q.setParameter("id_t", t.getIdtontiner());
        return q.getResultList();
    }

    @Override
    public List<CotisationTontine> findBy_inscriptionCotisation(InscriptionCotisation i) {
        Query q = em.createQuery("SELECT c FROM CotisationTontine c WHERE c.idmain.idinscription.idinscription = :id_i");
        q.setParameter("id_i", i.getIdinscription());
        return q.getResultList();
    }

    @Override
    public List<CotisationTontine> findBy_inscriptionCotisation_tontiner(InscriptionCotisation i, Tontiner t) {
        Query q = em.createQuery("SELECT c FROM CotisationTontine c WHERE c.idmain.idinscription.idinscription = :id_i AND c.idtontiner.idtontiner = :id_t");
        try {
            q.setParameter("id_i", i.getIdinscription());
            q.setParameter("id_t", t.getIdtontiner());
            return q.getResultList();
        } catch (Exception e) {
        }
        return new ArrayList<>();
    }

    @Override
    public CotisationTontine findBy_main_tontiner(Mains m, Tontiner t) {
        Query q = em.createQuery("SELECT c FROM CotisationTontine c WHERE c.idmain.idmain = :id_m AND c.idtontiner.idtontiner = :id_t");
        try {
            q.setParameter("id_m", m.getIdmain());
            q.setParameter("id_t", t.getIdtontiner());
            return (CotisationTontine) q.getResultList().get(0);
        } catch (Exception e) {
        }
        return null;
    }

}
