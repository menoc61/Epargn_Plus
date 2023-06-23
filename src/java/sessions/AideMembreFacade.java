/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Aide;
import entities.AideMembre;
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
public class AideMembreFacade extends AbstractFacade<AideMembre> implements AideMembreFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AideMembreFacade() {
        super(AideMembre.class);
    }

    @Override
    public Long nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(a.id) FROM AideMembre a");
            List listObj = query.getResultList();
            if (!listObj.isEmpty()) {
                return ((Long) listObj.get(0)) + 1;
            } else {
                return 1L;
            }
        } catch (Exception e) {
            return 1L;
        }
    }

    @Override
    public List<AideMembre> findByAide(Aide aide) throws Exception {
        List<AideMembre> aides;
        Query query = em.createQuery("SELECT a FROM AideMembre a WHERE a.idaide.idaide=:aide ORDER BY a.idmembre.idmembre.nom , a.idmembre.idmembre.prenom");
        query.setParameter("aide", aide.getIdaide());
        aides = query.getResultList();
        return aides;
    }

}
