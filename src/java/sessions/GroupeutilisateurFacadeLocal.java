/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Groupeutilisateur;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface GroupeutilisateurFacadeLocal {

    void create(Groupeutilisateur groupeutilisateur);

    void edit(Groupeutilisateur groupeutilisateur);

    void remove(Groupeutilisateur groupeutilisateur);

    Groupeutilisateur find(Object id);

    List<Groupeutilisateur> findAll();

    List<Groupeutilisateur> findRange(int[] range);

    int count();
    
    public Integer nextVal() throws Exception;
    
    public Groupeutilisateur findByNom(String nom);
    
    public List<Groupeutilisateur> findByEtat(Boolean etat);
    
}
