/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.EncoursEmprunt;
import entities.EncoursSecours;
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
public class EncoursSecoursFacade extends AbstractFacade<EncoursSecours> implements EncoursSecoursFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public EncoursSecoursFacade() {
        super(EncoursSecours.class);
    }

    @Override
    public Long nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(e.idEncoursSecours) FROM EncoursSecours e");
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
    public List<EncoursSecours> findByrencontre(Rencontre rencontre) throws Exception {
        List<EncoursSecours> encoursSecourses = null;
        Query query = em.createQuery("SELECT e FROM EncoursSecours e WHERE e.idrencontre.idrencontre=:rencontre ORDER BY e.idmembre.idmembre.code");
        query.setParameter("rencontre", rencontre.getIdrencontre());
        encoursSecourses = query.getResultList();
        return encoursSecourses;
    }

}
