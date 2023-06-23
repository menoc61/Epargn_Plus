/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.FichePresence;
import entities.Rencontre;
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
public class FichePresenceFacade extends AbstractFacade<FichePresence> implements FichePresenceFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public FichePresenceFacade() {
        super(FichePresence.class);
    }

    @Override
    public Long nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(f.id) FROM FichePresence f");
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
    public List<FichePresence> findByRencontre(Rencontre rencontre) throws Exception {
        List<FichePresence> fichePresences = null;
        Query query = em.createQuery("SELECT f FROM FichePresence f WHERE f.idrencontre.idrencontre=:rencontre ORDER BY f.idmembre.idmembre.code, f.idmembre.idmembre.nom , f.idmembre.idmembre.prenom");
        query.setParameter("rencontre", rencontre.getIdrencontre());
        fichePresences = query.getResultList();
        return fichePresences;
    }

    @Override
    public List<FichePresence> findByNonRegle(boolean regle) throws Exception {
        List<FichePresence> fichePresences = null;
        Query query = em.createQuery("SELECT f FROM FichePresence f WHERE f.regle=:regle AND f.montantPenalite!=0d ORDER BY f.idmembre.idmembre.code, f.idmembre.idmembre.nom , f.idmembre.idmembre.prenom");
        query.setParameter("regle", regle);
        fichePresences = query.getResultList();
        return fichePresences;
    }

    @Override
    public List<FichePresence> findByCycleNonRegle(int idcycle, boolean regle) throws Exception {
        List<FichePresence> fichePresences = null;
        Query query = em.createQuery("SELECT f FROM FichePresence f WHERE f.regle=:regle AND f.montantPenalite!=0d AND f.idmembre.idcycle.idcycle=:idcycle ORDER BY f.idmembre.idmembre.code, f.idmembre.idmembre.nom , f.idmembre.idmembre.prenom");
        query.setParameter("regle", regle).setParameter("idcycle", idcycle);
        fichePresences = query.getResultList();
        return fichePresences;
    }

}
