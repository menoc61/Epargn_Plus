/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cassationtontine;
import entities.InscriptionCotisation;
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
public class CassationtontineFacade extends AbstractFacade<Cassationtontine> implements CassationtontineFacadeLocal {
    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CassationtontineFacade() {
        super(Cassationtontine.class);
    }

    @Override
    public List<Cassationtontine> findAllBy_inscriptionCotisation(InscriptionCotisation i) {
        Query q = em.createQuery("SELECT c FROM Cassationtontine c WHERE c.idmain.idinscription.idinscription = :id_i");
        try {
            q.setParameter("id_i", i.getIdinscription());
            return q.getResultList();
        } catch (Exception e) {
        }
        return new ArrayList<>();
    }

    @Override
    public int nextId() {
        Query q = em.createQuery("SELECT MAX(c.idcassation) FROM Cassationtontine c");
        try {
            return (Integer) q.getResultList().get(0) + 1;
        } catch (Exception e) {
        }
        return 1;
    }
    
}
