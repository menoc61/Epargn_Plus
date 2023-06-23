/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.BeneficiaireTontine;
import entities.Cotisation;
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
 * @author USER
 */
@Stateless
public class BeneficiaireTontineFacade extends AbstractFacade<BeneficiaireTontine> implements BeneficiaireTontineFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public BeneficiaireTontineFacade() {
        super(BeneficiaireTontine.class);
    }

    @Override
    public Long nextId() {
        Query query = em.createQuery("SELECT MAX(b.idbeneficiaire) FROM BeneficiaireTontine b");
        try {
            return (Long) query.getSingleResult() + 1;
        } catch (Exception e) {
        }
        return 1l;
    }

    @Override
    public List<BeneficiaireTontine> findByRencontre(int idrencontre) throws Exception {
        Query query = em.createQuery("SELECT b FROM BeneficiaireTontine b WHERE b.idtontiner.idrencontre.idrencontre=:rencontre ORDER BY b.idtontiner.idrencontre.daterencontre");
        query.setParameter("rencontre", idrencontre);
        return (List<BeneficiaireTontine>) query.getResultList();
    }

    @Override
    public List<BeneficiaireTontine> findByRencontreCotisation(int idrencontre, int idcotisation) throws Exception {
        Query query = em.createQuery("SELECT b FROM BeneficiaireTontine b WHERE b.idtontiner.idrencontre.idrencontre = :rencontre AND b.idmain.idinscription.idcotisation.idcotisation = :cotisation ORDER BY b.idtontiner.idrencontre.daterencontre");
        query.setParameter("rencontre", idrencontre).setParameter("cotisation", idcotisation);
        return (List<BeneficiaireTontine>) query.getResultList();
    }

    @Override
    public List<BeneficiaireTontine> findByRencontreInscription(int idrencontre, long idinscription) throws Exception {
        Query query = em.createQuery("SELECT b FROM BeneficiaireTontine b WHERE b.idtontiner.idrencontre.idrencontre=:rencontre AND b.idmain.idinscription.idinscription=:idinscription ORDER BY b.idtontiner.idrencontre.daterencontre");
        query.setParameter("rencontre", idrencontre).setParameter("idinscription", idinscription);
        return (List<BeneficiaireTontine>) query.getResultList();
    }

    @Override
    public int NextOrderNumber(int idcotisation) throws Exception {
        Query query = em.createQuery("SELECT MAX(b.numeroOrdre) FROM BeneficiaireTontine b WHERE b.idmain.idinscription.idcotisation.idcotisation=:cotisation");
        query.setParameter("cotisation", idcotisation);
        Integer resultat = (Integer) query.getSingleResult();
        if (resultat == null) {
            return 1;
        } else {
            return resultat + 1;
        }
    }

    @Override
    public List<BeneficiaireTontine> findBy_cotisation(Cotisation c) {
        Query q = em.createQuery("SELECT b FROM BeneficiaireTontine b WHERE b.idmain.idinscription.idcotisation.idcotisation = :id_c");
        q.setParameter("id_c", c.getIdcotisation());
        return q.getResultList();
    }

    @Override
    public BeneficiaireTontine findBy_main(Mains m) {
        Query q = em.createQuery("SELECT b FROM BeneficiaireTontine b WHERE b.idmain.idmain = :id_m");
        q.setParameter("id_m", m.getIdmain());
        try {
            return (BeneficiaireTontine) q.getSingleResult();
        } catch (Exception e) {
        }
        return null;
    }

    @Override
    public List<BeneficiaireTontine> findBy_tontiner(Tontiner t) {
        Query q = em.createQuery("SELECT b FROM BeneficiaireTontine b WHERE b.idtontiner.idtontiner = :id_t");
        q.setParameter("id_t", t.getIdtontiner());
        return q.getResultList();
    }

    @Override
    public List<BeneficiaireTontine> findBy_inscriptionCotisation(InscriptionCotisation i) {
        Query q = em.createQuery("SELECT b FROM BeneficiaireTontine b WHERE b.idmain.idinscription.idinscription = :id_i");
        try {
            q.setParameter("id_i", i.getIdinscription());
            return q.getResultList();
        } catch (Exception e) {
        }
        return new ArrayList<>();
    }

}
