/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cycletontine;
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
public class CycletontineFacade extends AbstractFacade<Cycletontine> implements CycletontineFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CycletontineFacade() {
        super(Cycletontine.class);
    }

    @Override
    public int nextId() {
        try {
            Query query = em.createQuery("SELECT MAX(d.idcycle) FROM Cycletontine d");
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
    public List<Cycletontine> findByNom(String nom) {
        List<Cycletontine> cycletontines = null;
        try {
            Query query = em.createQuery("SELECT d FROM Cycletontine d WHERE d.nomfr=:nom");
            query.setParameter("nom", nom);
            cycletontines = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cycletontines;
    }

    @Override
    public List<Cycletontine> findByTontine(Tontine tontine) throws Exception {
        List<Cycletontine> cycletontines = null;
        Query query = em.createQuery("SELECT c FROM Cycletontine c WHERE c.idtontine.idtontine=:tontine ORDER BY c.nomfr");
        query.setParameter("tontine", tontine.getIdtontine());
        cycletontines = query.getResultList();
        return cycletontines;
    }

    @Override
    public List<Cycletontine> findByTontine(Tontine tontine, boolean transfert) throws Exception {
        List<Cycletontine> cycletontines = null;
        Query query = em.createQuery("SELECT c FROM Cycletontine c WHERE c.idtontine.idtontine=:tontine AND c.transfere=:transfert");
        query.setParameter("tontine", tontine.getIdtontine()).setParameter("transfert", transfert);
        cycletontines = query.getResultList();
        return cycletontines;
    }
}
