/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cycletontine;
import entities.Rencontre;
import entities.Tontine;
import java.util.Date;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Abdel Bein Info
 */
@Local
public interface RencontreFacadeLocal {

    void create(Rencontre rencontre);

    void edit(Rencontre rencontre);

    void remove(Rencontre rencontre);

    Rencontre find(Object id);

    List<Rencontre> findAll();

    List<Rencontre> findAll_rencontreOfcotisation();

    List<Rencontre> findAll_rencontreOfcotisation_after_date(Date d);

    List<Rencontre> findRange(int[] range);

    int count();

    Integer nextId();

    Rencontre findByNom(String nomFr);

    Rencontre findBy_nomFr_date_cycle(String nom, Date date, Cycletontine c);

    Rencontre findBy_date_cycle(Date date, Cycletontine c);

    Rencontre findBy_date_tontine(Date date, Tontine t);

    List<Rencontre> findByCycle(Cycletontine cycletontine);

    List<Rencontre> findByTontine(Tontine tontine);

    List<Rencontre> findByCycle(Cycletontine cycletontine, Boolean ouverture);

    List<Rencontre> findByCycle(Cycletontine cycletontine, boolean ouverture, boolean fermetture);

    List<Rencontre> findByRencontreCotisation(Tontine tontine);

    List<Rencontre> findByCycleCotisation(Cycletontine cycletontine, boolean cotidation);

}
