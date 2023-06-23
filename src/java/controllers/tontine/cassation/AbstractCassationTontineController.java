/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine.cassation;

import controllers.tontine.SuperController;
import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Cassationtontine;
import entities.Cotisation;
import entities.InscriptionCotisation;
import entities.Mains;
import entities.Tontiner;
import java.util.ArrayList;
import java.util.List;
import org.primefaces.PrimeFaces;

/**
 *
 * @author Louis Stark
 */
public abstract class AbstractCassationTontineController extends SuperController {

    protected List<BeneficiaireCassation> list_beneficiaireCassation = new ArrayList<>();

    @Override
    protected void define_modifier_supprimer_detail(Object o) {
        if (o != null && o instanceof Cotisation) {
            modifier = details = supprimer = ((Cotisation) o).getIdcotisation() != null;
        } else {
            modifier = details = supprimer = false;
        }
    }

    @Override
    protected void define_list_cotisations() {
        try {
            list_cotisations = cotisationFacadeLocal.findBy_tontine(SessionMBean.getCycletontine().getIdtontine());
        } catch (Exception e) {
        }
    }

    public void prepareTermineCotisation() {
        try {
            mode = "Termine";

            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                if (can_termine()) {

                    if (cotisation.getEstTermine() != true) {
                        PrimeFaces.current().executeScript("PF('CreerDialog').show()");
                    }

                } else {
                    JsfUtil.addErrorMessage("Impossible de terminer une cotisation dont les scéances sont en cours...!");
                }
            } else {
                JsfUtil.addErrorMessage("Vous devez selectionner une cotisation");
            }
        } catch (Exception e) {
        }
    }

    public void updateData() {
        try {
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
            if (cotisation != null) {
                list_inscriptionCotisations = inscriptionCotisationFacadeLocal.findByCotisation(cotisation.getIdcotisation());
                list_mains = mainsFacadeLocal.findAll_by_Cotisation(cotisation);
                
                update_listBenefs();
            } else {
                cotisation = new Cotisation(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update_listBenefs () {
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                list_beneficiaireCassation.clear();
                for (InscriptionCotisation ic : list_inscriptionCotisations) {
                    list_beneficiaireCassation.add(new BeneficiaireCassation(ic));
                }
            }
        } catch (Exception e) {
        }
    }
    
    public List<Mains> get_list_mains(InscriptionCotisation i) {
        try {
            return mainsFacadeLocal.findAll_by_Inscription(i);
        } catch (Exception e) {
        }
        return new ArrayList<>();
    }

    public Double calcul_gains_membre() {
        Double result = 0d;
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                List<Mains> _temp = mainsFacadeLocal.findAll_by_Cotisation(cotisation);
                result = cotisation.getReliquat() / _temp.size();
            } else {
                throw new Exception("Vous navez pas sélectionné de cotisation");
            }
        } catch (Exception e) {
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
        return result;
    }

    public boolean can_termine() {
        boolean result = true;
        if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
            List<Tontiner> _temp = tontinerFacadeLocal.findAllBy_cotisation(cotisation);
            for (Tontiner t : _temp) {
                if (t.getEffectue() != true) {
                    result = false;
                }
            }
        } else {
            result = false;
        }
        return result;
    }

    public Double calcul_total_main() {
        return 0d;
    }

    public Double calcul_total_gains() {
        Double result = 0d;
        for (BeneficiaireCassation bc : list_beneficiaireCassation) {
            result += bc.montantTotalBeneficie();
        }
        return result;
    }

    public List<BeneficiaireCassation> getList_beneficiaireCassation() {
        return list_beneficiaireCassation;
    }

    public class BeneficiaireCassation {

        protected InscriptionCotisation ic;
        protected List<Cassationtontine> list_ct = new ArrayList<>();

        public BeneficiaireCassation(InscriptionCotisation i) {
            this.ic = i;
            list_ct = cassationtontineFacadeLocal.findAllBy_inscriptionCotisation(i);
        }

        public double montantTotalBeneficie() {
            Double result = 0d;
            try {
                for (Cassationtontine ct : list_ct) {
                    result += ct.getMontant();
                }
            } catch (Exception e) {
            }
            return result;
        }

        public InscriptionCotisation getIc() {
            return ic;
        }

        public void setIc(InscriptionCotisation ic) {
            this.ic = ic;
        }

        public List<Cassationtontine> getList_ct() {
            return list_ct;
        }

        public void setList_ct(List<Cassationtontine> list_ct) {
            this.list_ct = list_ct;
        }
    }

}
