/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import entities.CassationDetail;
import entities.Cycletontine;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author kenne
 */
@Local
public interface CassationDetailFacadeLocal {

    void create(CassationDetail cassationDetail);

    void edit(CassationDetail cassationDetail);

    void remove(CassationDetail cassationDetail);

    CassationDetail find(Object id);

    List<CassationDetail> findAll();

    List<CassationDetail> findRange(int[] range);

    int count();

    Long nextId();

    List<CassationDetail> findByCycle(Cycletontine cycletontine) throws Exception;

}
