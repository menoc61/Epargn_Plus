/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine.programmation;

import controllers.tontine.SuperController;
import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.BeneficiaireTontine;
import entities.Cotisation;
import entities.Encherebenficiare;
import entities.InscriptionCotisation;
import entities.Mains;
import entities.Tontiner;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.primefaces.PrimeFaces;

/**
 *
 * @author Louis Stark
 */
public abstract class AbstractCotisationProgrammationController extends SuperController {

    protected List<BeneficiairesRencontre> list_beneficiaires = new ArrayList<>();

    @Override
    protected void define_modifier_supprimer_detail(Object o) {
        if (o != null) {
            if (o instanceof Cotisation) {
                modifier = supprimer = details = (((Cotisation) o).getIdcotisation() != null && ((Cotisation) o).getIdcotisation() != 0);
                return;
            }
        }
        modifier = supprimer = details = false;
    }

    @Override
    protected void define_list_cotisations() {
        try {
            list_cotisations = cotisationFacadeLocal.findBy_tontine(SessionMBean.getCycletontine().getIdtontine());
        } catch (Exception e) {
        }
    }

    @Override
    protected void define_list_inscriptionCotisation() {
        try {
            if (cotisation != null) {
                if (cotisation.getIdcotisation() != null) {
                    list_inscriptionCotisations = inscriptionCotisationFacadeLocal.findByCotisation(cotisation.getIdcotisation());
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(AbstractCotisationProgrammationController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void define_list_beneficairesTontine() {
        try {
            if (cotisation != null) {
                if (tontiner != null) {
                    if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0 && tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {
                        list_beneficiairesTontine = beneficiaireTontineFacadeLocal.findBy_tontiner(tontiner);
                    }
                }
            }
        } catch (Exception e) {
        }
    }

    public void prepareProgrammation() {
        mode = "Create";
        try {
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
            if (cotisation != null) {

                if (cotisation.getNbretours() > get_nbre_total_mains()) {
                    JsfUtil.addErrorMessage("Le nombre de mains est inférieur au nbre total de tours. Veuillez cooriger cela");
                } else {
                    PrimeFaces.current().executeScript("PF('ProgrammationDialog').show()");
                }

            } else {
                JsfUtil.addErrorMessage("Vous devez sélectionner une cotisation");
                cotisation = new Cotisation(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void prepareEncherir() {
        mode = "Encherir";
        try {
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
            if (cotisation != null) {

                if (cotisation.getNbretours() > get_nbre_total_mains()) {
                    JsfUtil.addErrorMessage("Le nombre de mains est inférieur au nbre total de tours. Veuillez cooriger cela");
                } else {
                    tontiner = find_nextTontiner();

                    if (tontiner == null) {
                        throw new Exception("Aucune rencontre défini pour cette cotisation");
                    }

                    inscriptionCotisation = new InscriptionCotisation(0l);
                    encherebenficiare = new Encherebenficiare();
                    main = new Mains(0);
                    PrimeFaces.current().executeScript("PF('EnchereDialog').show()");
                }

            } else {
                JsfUtil.addErrorMessage("Vous devez sélectionner une cotisation");
                cotisation = new Cotisation(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public boolean can_editEnchere() {
        try {
            if (encherebenficiare.getIdenchere() != null && encherebenficiare.getIdenchere() != 0) {
                return !encherebenficiare.getTermine();
            }
        } catch (Exception e) {
        }
        return false;
    }

    public void preparePogrammeMain() {
        mode = "Create";
        try {
            tontiner = tontinerFacadeLocal.find(tontiner.getIdtontiner());
            if (tontiner != null) {

                main = new Mains(0);
                list_mains = get_list_mains_non_programme();

                PrimeFaces.current().executeScript("PF('ProgrammeMainDialog').show()");
            } else {
                JsfUtil.addErrorMessage("Vous devez sélectionner une rencontre");
                tontiner = new Tontiner(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void updateData() {
        try {
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
            if (cotisation != null) {
                List<Tontiner> _tontiner = get_list_rencontre_programme();
                List<BeneficiaireTontine> _benefs;
                list_beneficiaires.clear();
                BeneficiairesRencontre b;
                for (Tontiner t : _tontiner) {
                    if (!rencontre_exist(t)) {
                        _benefs = beneficiaireTontineFacadeLocal.findBy_tontiner(t);
                        b = new BeneficiairesRencontre(t);
                        b.setListbenef(_benefs);
                        list_beneficiaires.add(b);
                    }
                }
            } else {
                cotisation = new Cotisation(0);
                list_beneficiaires.clear();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateData_ProgrammationDlg() {
        try {
            tontiner = tontinerFacadeLocal.find(tontiner.getIdtontiner());
            if (tontiner != null) {

            } else {
                tontiner = new Tontiner(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Tontiner find_nextTontiner() {
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                List<Tontiner> _temp = tontinerFacadeLocal.findAllBy_cotisation(cotisation);
                for (int i = 0; i < _temp.size(); i++) {
                    if (_temp.get(i).getEffectue() != true) {
                        return _temp.get(i);
                    }
                    if (i == (_temp.size() - 1)) {
                        return _temp.get(i);
                    }
                }
            }
        } catch (Exception e) {
        }
        return null;
    }

    public Double doit_bouffer(Mains m) {
        Double result = 0d;
        try {
            result += m.getMontantsouscrit() * calcul_nbre_tours_restant(m);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public Integer get_nbre_beneficiaire_programme(Tontiner t) {
        try {
            return (beneficiaireTontineFacadeLocal.findBy_tontiner(t)).size();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    /*
     public Integer get_nbre_beneficiaire_programme (Rencontre r) {
     try {
     if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
     return get_nbre_beneficiaire_programme(cotisation, r);
     }
     } catch (Exception e) {
     }
     return 0;
     }*/

    public Integer get_nbre_total_mains() {
        try {
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
            if (cotisation != null) {
                return (mainsFacadeLocal.findAll_by_Cotisation(cotisation)).size();
            } else {
                cotisation = new Cotisation(0);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public List<Tontiner> get_list_rencontre_programmable() {
        List<Tontiner> _temp = new ArrayList<>();
        try {
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
            if (cotisation != null) {
                _temp = tontinerFacadeLocal.findAllBy_cotisation(cotisation);
            } else {
                cotisation = new Cotisation(0);
            }
        } catch (Exception e) {
        }
        return _temp;
    }

    public List<Tontiner> get_list_rencontre_programme() {
        try {
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
            if (cotisation != null) {
                return tontinerFacadeLocal.findAllBy_cotisation(cotisation);
            } else {
                cotisation = new Cotisation(0);
            }
        } catch (Exception e) {
        }
        return new ArrayList<>();
    }

    
    public boolean can_add_beneficiaire(Tontiner t) {
        try {
            if (t.getEffectue()) {
                return false;
            }
            if ((calcul_relicat(t) / def_min_doit_bouffer(cotisation)) >= 1) {
                return true;
            }
        } catch (Exception e) {
        }
        return false;
    }

    public Double calcul_relicat(Tontiner t0) {
        Double relicat = 0d;
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                List<Tontiner> _temp = get_list_rencontre_programme();
                Double mnt_r = calcul_montant_cotise_par_rencontre(cotisation),
                        mnt_b, mnt_e = 0d;
                for (Tontiner t : _temp) {
                    if (t.getEffectue()) {
                        relicat = t.getRedevance();
                    } else {
                        mnt_b = calcul_montant_doit_bouffer_mains_rencontre(t);
                        relicat += (mnt_r - mnt_b);
                        //mnt_e = calcul_montant_total_encheres(t);
                        //System.out.println("Montant total encheres : " + mnt_e);
                        //relicat += mnt_e;
                    }
                    if (t.getIdrencontre().getDaterencontre().equals(t0.getIdrencontre().getDaterencontre())) {
                        break;
                    }
                }
            }
        } catch (Exception e) {
        }
        return relicat;
    }

    public double calcul_montant_total_encheres(Tontiner t) {
        Double result = 0d;
        try {
            List<Encherebenficiare> _tempE = encherebenficiareFacadeLocal.findBy_tontiner(t);
            for (Encherebenficiare e : _tempE) {
                result += e.getMontant();
            }
        } catch (Exception e) {
        }
        return result;
    }

    public Double calcul_montant_doit_bouffer_mains_rencontre(Tontiner t0) {
        Double result = 0d;
        Encherebenficiare eb;
        try {
            List<BeneficiaireTontine> _temp = beneficiaireTontineFacadeLocal.findBy_tontiner(t0);
            for (BeneficiaireTontine bt : _temp) {
                result += calcul_montant_doit_bouffer_main(bt.getIdmain());
                eb = enchereMain(bt);
                if (eb != null) {
                    result -= eb.getMontant();
                }
            }
        } catch (Exception e) {
        }
        return result;
    }

    public Encherebenficiare enchereMain(BeneficiaireTontine b) {
        Encherebenficiare eb = null;
        try {
            eb = encherebenficiareFacadeLocal.findBy_benficiaireTontine(b);
        } catch (Exception e) {
        }
        return eb;
    }

    public Mains est_deja_programme(Mains m) {
        try {
            if (m != null) {
                BeneficiaireTontine bt = beneficiaireTontineFacadeLocal.findBy_main(m);
                if (bt != null) {
                    return bt.getIdmain();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Mains a_deja_bouffe(Mains m) {
        try {
            if (m != null) {
                BeneficiaireTontine bt = beneficiaireTontineFacadeLocal.findBy_main(m);
                if (bt != null) {
                    return bt.getMontant() != null ? bt.getIdmain() : null;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Mains> get_list_mains_non_programme() {
        List<Mains> _result = new ArrayList<>();
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                List<Mains> _temp = mainsFacadeLocal.findAll_by_Cotisation(cotisation);
                for (Mains m : _temp) {
                    if (est_deja_programme(m) == null) {
                        _result.add(m);
                    }
                }
            }
        } catch (Exception e) {
        }
        return _result;
    }

    public List<Mains> get_list_mains_non_bouffe() {
        List<Mains> _result = new ArrayList<>();
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                List<Mains> _temp = mainsFacadeLocal.findAll_by_Cotisation(cotisation);
                Mains mm;
                for (Mains m : _temp) {
                    if (est_deja_programme(m) == null) {
                        _result.add(m);
                    } else {
                        if (a_deja_bouffe(m) == null) {
                            _result.add(m);
                        }
                    }
                }
            }
        } catch (Exception e) {
        }
        return _result;
    }

    public List<Mains> get_list_mains_non_programme_vaiceur() {
        List<Mains> _result = new ArrayList<>();
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                List<Mains> _temp = mainsFacadeLocal.findAll_by_Inscription(inscriptionCotisation);
                for (Mains m : _temp) {
                    if (est_deja_programme(m) == null) {
                        _result.add(m);
                    }
                }
            }
        } catch (Exception e) {
        }
        return _result;
    }

    public Double calcul_relicat() {
        try {
            tontiner = tontinerFacadeLocal.find(tontiner.getIdtontiner());
            if (tontiner != null) {
                return calcul_relicat(tontiner);
            } else {
                tontiner = new Tontiner(0);
            }
        } catch (Exception e) {
        }
        return 0d;
    }

    public Double calcul_montant_cotise_par_rencontre(Cotisation c0) {
        Double result = 0d;
        List<Mains> _temp = mainsFacadeLocal.findAll_by_Cotisation(c0);
        for (Mains m : _temp) {
            result += m.getMontantsouscrit();
        }
        return result;
    }

    public Double calcul_montant_doit_bouffer(Mains m0) {
        return m0.getMontantsouscrit() * calcul_nbre_tours_restant(m0);
    }

    public Double calcul_montant_enchere(BeneficiaireTontine bt) {
        try {
            Encherebenficiare e = encherebenficiareFacadeLocal.findBy_benficiaireTontine(bt);
            if (e != null) {
                return e.getMontant();
            }
        } catch (Exception e) {
        }
        return 0d;
    }

    public Double calcul_montant_doit_bouffer_all(Cotisation c) {
        return c.getMontant() * c.getNbretours();
    }

    public Double def_min_doit_bouffer(Cotisation c) {
        Double result = 0d;
        try {
            result = calcul_montant_doit_bouffer_all(c);
            List<Mains> _temp = get_list_mains_non_programme();
            if (!_temp.isEmpty()) {
                for (Mains _temp1 : _temp) {
                    if (doit_bouffer(_temp1) < result) {
                        result = doit_bouffer(_temp1);
                    }
                }
            }
        } catch (Exception e) {
        }
        return result;
    }

    public Double calcul_montant_doit_bouffer_main(Mains m) {
        try {
            return m.getMontantsouscrit() * (m.getIdinscription().getIdcotisation().getNbretours() - m.getNbretourspasse());
        } catch (Exception e) {
        }
        return 0d;
    }

    public List<BeneficiairesRencontre> getList_beneficiaires() {
        return list_beneficiaires;
    }

    public int calcul_nbre_tours_restant(Mains m) {
        if (cotisation != null && cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
            return cotisation.getNbretours() - m.getNbretourspasse();
        }
        return 0;
    }

    protected boolean rencontre_exist(Tontiner t) {
        for (BeneficiairesRencontre b : list_beneficiaires) {
            if (b.getT().getIdtontiner().equals(t.getIdtontiner())) {
                return true;
            }
        }
        return false;
    }

    public boolean can_enchere() {
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                return cotisation.getCanEnchered();
            }
        } catch (Exception e) {
        }
        return false;
    }

    /**
     * ****************************************************************************************
     * ************** SUB CLASS BeneficiaresRencontre
     * *********************************************************************************
     */
    public class BeneficiairesRencontre {

        protected Tontiner t;
        protected List<BeneficiaireTontine> _listbenef = new ArrayList<>();

        public BeneficiairesRencontre(Tontiner t) {
            this.t = t;
        }

        public Tontiner getT() {
            return t;
        }

        public void setT(Tontiner t) {
            this.t = t;
        }

        public List<BeneficiaireTontine> getListbenef() {
            return _listbenef;
        }

        public void setListbenef(List<BeneficiaireTontine> _listbenef) {
            this._listbenef = _listbenef;
        }

    }
}
