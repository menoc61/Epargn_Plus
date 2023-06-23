/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.EncoursEmprunt;
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
public class EncoursEmpruntFacade extends AbstractFacade<EncoursEmprunt> implements EncoursEmpruntFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public EncoursEmpruntFacade() {
        super(EncoursEmprunt.class);
    }

    @Override
    public Long nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(e.idEncoursEmprunt) FROM EncoursEmprunt e");
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
    public List<EncoursEmprunt> findByrencontre(Rencontre rencontre) throws Exception {
        List<EncoursEmprunt> encoursEmprunts = null;
        Query query = em.createQuery("SELECT e FROM EncoursEmprunt e WHERE e.idCalculInteret.idrencontre.idrencontre=:rencontre ORDER BY e.idCalculInteret.idmembre.idmembre.code");
        query.setParameter("rencontre", rencontre.getIdrencontre());
        encoursEmprunts = query.getResultList();
        return encoursEmprunts;
    }

}
