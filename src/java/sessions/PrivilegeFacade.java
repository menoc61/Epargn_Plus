/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Privilege;
import java.util.ArrayList;
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
public class PrivilegeFacade extends AbstractFacade<Privilege> implements PrivilegeFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PrivilegeFacade() {
        super(Privilege.class);
    }

    @Override
    public int nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(p.idprivilege) FROM Privilege p");
            Integer resultat = (int) query.getSingleResult();
            if (resultat.equals(null)) {
                return 1;
            } else {
                return resultat + 1;
            }
        } catch (Exception e) {
            return 1;
        }
    }

    //en mode retrait
    @Override
    public List<Privilege> findByGroupeUser(int groupeUser, Boolean etatMenu, Boolean etat) {
        List<Privilege> privileges = new ArrayList<>();
        try {
            Query query = em.createQuery("SELECT p FROM Privilege p WHERE p.idgroupe.idgroupe=:groupeUser AND p.idmenu.etat =:etatMenu AND p.etat=:etat");
            query.setParameter("groupeUser", groupeUser);
            query.setParameter("etatMenu", etatMenu);
            query.setParameter("etat", etat);
            privileges = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return privileges;
    }

    //en mode attribution
    @Override
    public List<Privilege> findByGroupeUser(int groupeUser, Boolean etatMenu) {
        List<Privilege> privileges = new ArrayList<>();
        try {
            Query query = em.createQuery("SELECT p FROM Privilege p WHERE p.idgroupe.idgroupe=:groupeUser AND p.idmenu.etat=:etatMenu");
            query.setParameter("groupeUser", groupeUser);
            query.setParameter("etatMenu", etatMenu);
            privileges = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return privileges;
    }

    @Override
    public Privilege findByUserMenu(int user, int menu) {
        Privilege privilege = null;
        try {
            Query query = em.createQuery("SELECT p FROM Privilege p WHERE p.idcompteUtilisateur.idcompte=:user AND p.idmenu.idmenu=:menu");
            query.setParameter("user", user);
            query.setParameter("menu", menu);
            if (!query.getResultList().isEmpty()) {
                privilege = (Privilege) query.getResultList().get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return privilege;
    }

    @Override
    public List<Privilege> findByUser(int utilisateur) throws Exception {
        Query query = em.createQuery("SELECT p FROM Privilege p WHERE p.idcompteUtilisateur.idcompte=:compte");
        return (List<Privilege>) query.setParameter("compte", utilisateur).getResultList();
    }
}
