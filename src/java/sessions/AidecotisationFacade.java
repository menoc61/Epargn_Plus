/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Aidecotisation;
import entities.Cotisation;
import entities.CotisationTontine;
import entities.InscriptionCotisation;
import entities.Mains;
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
public class AidecotisationFacade extends AbstractFacade<Aidecotisation> implements AidecotisationFacadeLocal {
    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AidecotisationFacade() {
        super(Aidecotisation.class);
    }
    
    @Override
    public int nextId() {
        Query q = em.createQuery("SELECT MAX(a.idaidecotisation) FROM Aidecotisation a");
        try {
            return (Integer) q.getResultList().get(0) + 1;
        } catch (Exception e) {
        }
        return 1;
    }

    @Override
    public List<Aidecotisation> findAllBy_main(Mains m) {
        Query q = em.createQuery("SELECT a FROM Aidecotisation a WHERE a.idcotisationtontine.idmain.idmain = :id_m");
        q.setParameter("id_m", m.getIdmain());
        return q.getResultList();
    }

    @Override
    public List<Aidecotisation> findAllBy_tontiner_main(Tontiner t, Mains m) {
        Query q = em.createQuery("SELECT a FROM Aidecotisation a WHERE a.idcotisationtontine.idtontiner.idtontiner = :id_t AND a.idcotisationtontine.idmain.idmain = :id_m");
        q.setParameter("id_t", t.getIdtontiner());
        q.setParameter("id_m", m.getIdmain());
        return q.getResultList();
    }
    
    @Override
    public List<Aidecotisation> findAllBy_cotisationTontine(CotisationTontine c){
        Query q = em.createQuery("SELECT a FROM Aidecotisation a WHERE a.idcotisationtontine.idcotisationtontine = :id_c");
        q.setParameter("id_c", c.getIdcotisationtontine());
        return q.getResultList();
    }

    @Override
    public List<Aidecotisation> findAllBy_inscriptionCotisation(InscriptionCotisation i) {
        Query q = em.createQuery("SELECT a FROM Aidecotisation a WHERE a.idcotisationtontine.idmain.idinscription.idinscription = :id_i");
        q.setParameter("id_i", i.getIdinscription());
        return q.getResultList();
    }

    @Override
    public List<Aidecotisation> findAllBy_cotisation(Cotisation c) {
        Query q = em.createQuery("SELECT a FROM Aidecotisation a WHERE a.idcotisationtontine.idtontiner.idcotisation.idcotisation = :id_c ORDER BY a.idcotisationtontine.idmain");
        q.setParameter("id_c", c.getIdcotisation());
        return q.getResultList();
    }

    @Override
    public List<Aidecotisation> findAllBy_inscriptionCotisation_tontiner(InscriptionCotisation i, Tontiner t) {
        Query q = em.createQuery("SELECT a FROM Aidecotisation a WHERE a.idcotisationtontine.idmain.idinscription.idinscription = :id_i AND a.idcotisationtontine.idtontiner.idtontiner = :id_t ORDER BY a.idcotisationtontine.idmain");
        q.setParameter("id_i", i.getIdinscription());
        q.setParameter("id_t", t.getIdtontiner());
        return q.getResultList();
    }
    
    
    
}
