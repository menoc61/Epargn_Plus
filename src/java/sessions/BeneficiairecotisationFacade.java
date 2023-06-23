/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Beneficiairecotisation;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Abdel Bein Info
 */
@Stateless
public class BeneficiairecotisationFacade extends AbstractFacade<Beneficiairecotisation> implements BeneficiairecotisationFacadeLocal {

    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public BeneficiairecotisationFacade() {
        super(Beneficiairecotisation.class);
    }

    @Override
    public int nextId() {
        Query q = em.createQuery("SELECT MAX(b.idbeneficiare) FROM Beneficiairecotisation b");
        try {
            return (Integer) q.getResultList().get(0) + 1;
        } catch (Exception ex) {
        }
        return 1;
    }

}
