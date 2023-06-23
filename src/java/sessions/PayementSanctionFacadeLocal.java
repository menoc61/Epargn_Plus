/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.Cycletontine;
import entities.PayementSanction;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author kenne
 */
@Local
public interface PayementSanctionFacadeLocal {

    void create(PayementSanction payementSanction);

    void edit(PayementSanction payementSanction);

    void remove(PayementSanction payementSanction);

    PayementSanction find(Object id);

    List<PayementSanction> findAll();

    List<PayementSanction> findRange(int[] range);

    int count();

    Long nextId();

    List<PayementSanction> findByCycle(Cycletontine cycletontine) throws Exception;
}
