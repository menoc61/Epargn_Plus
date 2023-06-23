/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cotisation;
import entities.InscriptionCotisation;
import entities.Membrecycle;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author USER
 */
@Stateless
public class InscriptionCotisationFacade extends AbstractFacade<InscriptionCotisation> implements InscriptionCotisationFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public InscriptionCotisationFacade() {
        super(InscriptionCotisation.class);
    }

    @Override
    public Long nextId() {
        Query query = em.createQuery("SELECT MAX(i.idinscription) FROM InscriptionCotisation i");
        try {
            return (Long) query.getResultList().get(0) + 1l;
        } catch (Exception e) {
        }
        return 1l;
    }

    @Override
    public List<InscriptionCotisation> findByCotisation(int idcotisation) throws Exception {
        Query query = em.createQuery("SELECT i FROM InscriptionCotisation i WHERE i.idcotisation.idcotisation = :idcotisation");
        query.setParameter("idcotisation", idcotisation);
        return query.getResultList();
    }

    @Override
    public List<InscriptionCotisation> findByCotisationMembre(int idcotisation, int idmembrecycle) throws Exception {
        Query query = em.createQuery("SELECT i FROM InscriptionCotisation i WHERE i.idcotisation.idcotisation=:idcotisation AND i.idmembre.idmembrecycle=:idmembre ").setParameter("idcotisation", idcotisation).setParameter("idmembre", idmembrecycle);
        return query.getResultList();
    }

    @Override
    public InscriptionCotisation findBy_cotisation_membrecycle(Cotisation c, Membrecycle m) {
        Query q = em.createQuery("SELECT i FROM InscriptionCotisation i WHERE i.idcotisation.idcotisation = :id_c AND i.idmembre.idmembrecycle = :id_m");
        try {
            q.setParameter("id_c", c.getIdcotisation());
            q.setParameter("id_m", m.getIdmembrecycle());
            return (InscriptionCotisation) q.getSingleResult();
        } catch (Exception e) {
        }
        return null;
    }

}
