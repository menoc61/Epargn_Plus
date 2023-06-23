/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Frequencetontine;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Abdel Bein Info
 */
@Stateless
public class FrequencetontineFacade extends AbstractFacade<Frequencetontine> implements FrequencetontineFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public FrequencetontineFacade() {
        super(Frequencetontine.class);
    }

    @Override
    public Integer nextId() throws Exception {

        Query query = em.createQuery("SELECT MAX(f.idfreqtontine) FROM Frequencetontine f");
        Integer resultat = (Integer) query.getSingleResult();
        if (resultat == null) {
            return 1;
        } else {
            return resultat + 1;
        }
    }

    @Override
    public Frequencetontine findByNom(String nom) {
        Frequencetontine frequencetontine = null;
        Query query;
        try {
            query = em.createNamedQuery("Frequencetontine.findByNomFr");
            query.setParameter("nomFr", nom);
            frequencetontine = (Frequencetontine) query.getSingleResult();
        } catch (Exception e) {
            e.getMessage();
            e.getCause();
        }
        return frequencetontine;
    }

}
