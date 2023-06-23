/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Utilisateurtontine;
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
public class UtilisateurtontineFacade extends AbstractFacade<Utilisateurtontine> implements UtilisateurtontineFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UtilisateurtontineFacade() {
        super(Utilisateurtontine.class);
    }

    @Override
    public int nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(u.idutilisateurtontine) FROM Utilisateurtontine u");
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
    public List<Utilisateurtontine> findByUtilisateur(int utilisateur) throws Exception {
        Query query = em.createQuery("SELECT u FROM Utilisateurtontine u WHERE u.idutilisateur.idutilisateur=:utilisateur");
        return (List<Utilisateurtontine>) query.setParameter("utilisateur", utilisateur).getResultList();
    }

    @Override
    public List<Utilisateurtontine> findByUtilisateur(int utilisateur, int tontine) throws Exception {
        Query query = em.createQuery("SELECT u FROM Utilisateurtontine u WHERE u.idutilisateur.idutilisateur=:utilisateur AND u.idtontine.idtontine=:tontine");
        return (List<Utilisateurtontine>) query.setParameter("utilisateur", utilisateur).setParameter("tontine", tontine).getResultList();
    }

    @Override
    public List<Utilisateurtontine> findByTontine(int tontine) throws Exception {
        Query query = em.createQuery("SELECT u FROM Utilisateurtontine u WHERE u.idtontine.idtontine=:tontine");
        return (List<Utilisateurtontine>) query.setParameter("tontine", tontine).getResultList();
    }

}
