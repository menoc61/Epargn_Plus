/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Typeinteret;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Abdel Bein Info
 */
@Stateless
public class TypeinteretFacade extends AbstractFacade<Typeinteret> implements TypeinteretFacadeLocal {
    @PersistenceContext(unitName = "Epargn_PlusPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public TypeinteretFacade() {
        super(Typeinteret.class);
    }
    
}
