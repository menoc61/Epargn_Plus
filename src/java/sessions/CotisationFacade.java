/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cotisation;
import entities.Tontine;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Abdel Bein Info
 */
@Stateless
public class CotisationFacade extends AbstractFacade<Cotisation> implements CotisationFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CotisationFacade() {
        super(Cotisation.class);
    }

    @Override
    public int nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(i.idcotisation) FROM Cotisation i");
            List listObj = query.getResultList();
            if (!listObj.isEmpty()) {
                return ((Integer) listObj.get(0)) + 1;
            } else {
                return 1;
            }
        } catch (Exception e) {
            return 1;
        }
    }

    @Override
    public List<Cotisation> findBy_tontine(Tontine t) {
        List<Cotisation> cotisations = null;
        try {
            Query query = em.createQuery("SELECT c FROM Cotisation c WHERE c.idtontine.idtontine = :id_t ORDER BY c.dateEnregistrement");
            query.setParameter("id_t", t.getIdtontine());
            cotisations = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cotisations;
    }
/*
    @Override
    public List<Cotisation> findByRencontre(Rencontre rencontre) throws Exception {
        List<Cotisation> cotisations = null;
        Query query = em.createQuery("SELECT c FROM Cotisation c WHERE c.idrencotre.idrencontre=:rencontre");
        query.setParameter("rencontre", rencontre.getIdrencontre());
        cotisations = query.getResultList();
        return cotisations;
    }*/

}
