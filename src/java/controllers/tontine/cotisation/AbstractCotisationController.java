/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine.cotisation;

import controllers.tontine.SuperController;
import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Aidecotisation;
import entities.BeneficiaireTontine;
import entities.Cotisation;
import entities.CotisationTontine;
import entities.Encherebenficiare;
import entities.InscriptionCotisation;
import entities.Mains;
import entities.Rencontre;
import entities.Tontiner;
import java.util.ArrayList;
import java.util.List;
import org.primefaces.PrimeFaces;

/**
 *
 * @author Louis Stark
 */
public abstract class AbstractCotisationController extends SuperController {

    protected List<BeneficiairesRencontre> list_beneficiaires = new ArrayList<>();

    protected List<CotisationTontine> list_cotisationMembre = new ArrayList<>();

    protected List<Aidecotisation> list_aides_local = new ArrayList<>();

    protected boolean visible = false;

    public List<BeneficiairesRencontre> getList_beneficiaires() {
        return list_beneficiaires;
    }

    @Override
    protected void define_modifier_supprimer_detail(Object o) {
        if (o != null && o instanceof Cotisation) {
            modifier = supprimer = details = (((Cotisation) o).getIdcotisation() != null && ((Cotisation) o).getIdcotisation() != 0);
            return;
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
    protected void define_list_cotisationTontine() {
        try {
            if (mode.equals("Etat")) {
                if (main != null) {
                    if (main.getIdmain() != null && main.getIdmain() != 0) {
                        list_cotisationTontine = cotisationTontineFacadeLocal.findBy_main(main);
                    }
                }
            } else {
                if (cotisation != null && rencontre != null) {
                    if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0 && tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {

                        list_cotisationTontine = cotisationTontineFacadeLocal.findByRencontreCotisation(tontiner.getIdrencontre().getIdrencontre(), cotisation.getIdcotisation());

                    } else {
                        list_cotisationTontine.clear();
                    }
                } else {
                    list_cotisationTontine.clear();
                }
            }
        } catch (Exception e) {
        }
    }

    @Override
    protected void define_list_membrecycle() {
        try {
            list_membrecycle = membrecycleFacadeLocal.findByCycle(SessionMBean.getCycletontine());
        } catch (Exception e) {
        }
    }

    @Override
    protected void define_list_mains() {
        try {
            if (mode.equals("Etat")) {
                inscriptionCotisation = inscriptionCotisationFacadeLocal.find(inscriptionCotisation.getIdinscription());
                if (inscriptionCotisation != null) {
                    list_mains = mainsFacadeLocal.findAll_by_Inscription(inscriptionCotisation);
                } else {
                    list_mains.clear();
                    inscriptionCotisation = new InscriptionCotisation(0l);
                }
            }
        } catch (Exception e) {
        }
    }

    @Override
    protected void define_list_inscriptionCotisation() {
        try {
            if (mode.equals("Etat") || "Cotiser".equals(mode)) {
                if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                    list_inscriptionCotisations = inscriptionCotisationFacadeLocal.findByCotisation(cotisation.getIdcotisation());
                } else {
                    list_inscriptionCotisations.clear();
                }
            }
        } catch (Exception e) {
        }
    }

    public void prepareCotisation() {
        mode = "Cotiser";
        try {

            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {

                if (erreur_programmation()) {
                    throw new Exception("Il existe des erreurs dans la programmation! Veuillez d'abord les résoudres");
                }

                if (tontiner.getIdtontiner() == null || tontiner.getIdtontiner() == 0) {
                    throw new Exception("Vous devez sélectionner une rencontre !!!");
                }

                inscriptionCotisation = new InscriptionCotisation(0l);
                list_cotisationMembre.clear();
                list_aides_local.clear();

                PrimeFaces.current().executeScript("PF('CotiserDialog').show()");

            } else {
                JsfUtil.addErrorMessage("Vous n'avez pas choisi de cotisation !");
            }

        } catch (Exception e) {
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void prepareDetailsMain(CotisationTontine c) {
        try {
            if (tontiner != null) {
                cotisationTontine = c;

                //list_aidescotisation = aidecotisationFacadeLocal.findAllBy_main(main);
                PrimeFaces.current().executeScript("PF('CotiserMainDialog').show()");
            } else {
                JsfUtil.addErrorMessage("Vous devez sélectionner une rencontre");
                rencontre = new Rencontre(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void prepareEditCotiserMain() {
        mode = "Edit";
        try {
            cotisationTontine = cotisationTontineFacadeLocal.find(cotisationTontine.getIdcotisationtontine());
            if (cotisationTontine != null) {
                rencontre = cotisationTontine.getIdtontiner().getIdrencontre();

                main = cotisationTontine.getIdmain();
                list_mains.clear();
                list_mains.add(main);

                list_aidescotisation = aidecotisationFacadeLocal.findAllBy_main(main);

                PrimeFaces.current().executeScript("PF('CotiserMainDialog').show()");
            } else {
                JsfUtil.addErrorMessage("Vous devez sélectionner une rencontre");
                rencontre = new Rencontre(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void prepareAddAide() {
        if (cotisationTontine != null && cotisationTontine.getIdmain() != null && cotisationTontine.getIdmain().getIdmain() != 0) {
            if (calcul_reste_a_cotiser() != null && calcul_reste_a_cotiser() > 0) {
                aidecotisation = new Aidecotisation(0);

                PrimeFaces.current().executeScript("PF('AideCotisationDialog').show()");
            } else {
                JsfUtil.addErrorMessage("Cette main n'as pas besoin d'aide");
            }
        } else {
            JsfUtil.addErrorMessage("Aucune main sélectionné");
        }
    }

    public void prepareEtat() {
        try {
            mode = "Etat";
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
            if (cotisation != null) {

                PrimeFaces.current().executeScript("PF('EtatDialog').show()");
            } else {
                JsfUtil.addErrorMessage("Vous n'avez pas choisi de cotisation !");
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
            updateVisible();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateData_cotiserDlg() {
        try {
            tontiner = tontinerFacadeLocal.find(tontiner.getIdtontiner());
            if (tontiner != null) {
                list_beneficiairesTontine = beneficiaireTontineFacadeLocal.findBy_tontiner(tontiner);

                list_cotisationTontine = cotisationTontineFacadeLocal.findBy_tontiner(tontiner);
            } else {
                tontiner = new Tontiner(0);
            }
            updateVisible();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void updateVisible() {
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                visible = false;
            }
            if (tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {
                visible = true;
            }
        } catch (Exception e) {
        }
    }

    public void updateDate_cotiserMain() {
        try {
            main = mainsFacadeLocal.find(main.getIdmain());
            if (main != null) {
                cotisationTontine.setDoitCotiser(main.getMontantsouscrit());
                cotisationTontine.setACotise(main.getMontantsouscrit());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update_mains_membre() {
        try {
            inscriptionCotisation = inscriptionCotisationFacadeLocal.find(inscriptionCotisation.getIdinscription());
            if (inscriptionCotisation != null) {
                list_aides_local.clear();
                list_cotisationMembre.clear();
                List<Mains> _temp = mainsFacadeLocal.findAll_by_Inscription(inscriptionCotisation);
                CotisationTontine temp;
                for (Mains m : _temp) {
                    temp = cotisationTontineFacadeLocal.findBy_main_tontiner(m, tontiner);
                    if (temp == null) {
                        temp = new CotisationTontine();
                        temp.setIdmain(m);
                        temp.setIdtontiner(tontiner);
                        temp.setACotise(m.getMontantsouscrit());
                        temp.setDoitCotiser(m.getMontantsouscrit());
                        temp.setReste(0d);
                    }

                    list_cotisationMembre.add(temp);
                }

                list_aides_local = aidecotisationFacadeLocal.findAllBy_inscriptionCotisation_tontiner(inscriptionCotisation, tontiner);

            } else {
                inscriptionCotisation = new InscriptionCotisation(0l);
            }
        } catch (Exception e) {
        }
    }
    
    public List<Tontiner> get_list_rencontre_programme() {
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                return tontinerFacadeLocal.findAllBy_cotisation(cotisation);

            }
        } catch (Exception e) {
        }
        return new ArrayList<>();
    }

    protected boolean rencontre_exist(Tontiner t) {
        for (BeneficiairesRencontre b : list_beneficiaires) {
            if (b.getT().getIdtontiner().equals(t.getIdtontiner())) {
                return true;
            }
        }
        return false;
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

    public Integer get_nbre_total_mains() {
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                return (mainsFacadeLocal.findAll_by_Cotisation(cotisation)).size();
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public Integer calcul_nbre_beneficiaire(Tontiner t) {
        Integer result = 0;
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                result = (beneficiaireTontineFacadeLocal.findBy_tontiner(t)).size();
            }
        } catch (Exception e) {
        }
        return result;
    }

    public Integer calcul_nbre_beneficiaire() {
        try {
            if (tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {
                return calcul_nbre_beneficiaire(tontiner);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public Double calcul_relicat(Tontiner t0) {
        Double relicat = 0d;
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                List<Tontiner> _temp = get_list_rencontre_programme();
                Double mnt_r,
                        mnt_b, mnt_e;
                for (Tontiner t : _temp) {
                    if (t.getEffectue()) {
                        relicat = t.getRedevance();
                    } else {
                        mnt_r = calcul_montant_cotise_rencontre(t);
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
    /*   
     public Double calcul_relicat(Tontiner t0) {
     Double relicat = 0d;
     try {
     if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
     List<Tontiner> _temp = get_list_rencontre_programme();
     Double mnt_r, mnt_c;
     List<Encherebenficiare> _tempE;
     for (Tontiner t : _temp) {
     mnt_r = calcul_montant_cotise_rencontre(t);
     mnt_c = calcul_montant_doit_bouffer_mains_rencontre(t);
     relicat += (mnt_r - mnt_c);
     _tempE = encherebenficiareFacadeLocal.findBy_tontiner(t);
     for (Encherebenficiare e : _tempE) {
     relicat += e.getMontant();
     }
     if (t.getIdrencontre().getDaterencontre().equals(t0.getIdrencontre().getDaterencontre())) {
     break;
     }
     }

     }
     } catch (Exception e) {
     }
     return relicat;
     } */

    public Double calcul_relicat() {
        try {
            if (tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {
                return calcul_relicat(tontiner);
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

    public Double calcul_montant_cotise_rencontre(Tontiner t0) {
        Double result = 0d;
        List<CotisationTontine> _temp = cotisationTontineFacadeLocal.findBy_tontiner(t0);
        for (CotisationTontine c : _temp) {
            result += c.getDoitCotiser();
        }
        return result;
    }

    public Double calcul_montant_a_bouffer_main(BeneficiaireTontine b0) {
        if (b0.getIdtontiner().getEffectue()) {
            return b0.getMontant();
        }
        return 0d;
    }

    public double calcul_total_enchere() {
        Double result = 0d;
        try {
            if (tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {
                List<Encherebenficiare> _temp = encherebenficiareFacadeLocal.findBy_tontiner(tontiner);
                for (Encherebenficiare e : _temp) {
                    result += e.getMontant();
                }
            }
        } catch (Exception e) {
        }
        return result;
    }

    public Double calcul_montant_doit_bouffer_main(Mains m0) {
        return m0.getMontantsouscrit() * calcul_nbre_tours_restant(m0);
    }

    public Double calcul_montant_doit_bouffer_all(Cotisation c) {
        return c.getMontant() * c.getNbretours();
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

    public int calcul_nbre_tours_restant(Mains m) {
        if (cotisation != null && cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
            return cotisation.getNbretours() - m.getNbretourspasse();
        }
        return 0;
    }

    public List<Mains> get_list_mains_non_cotise() {
        List<Mains> _result = new ArrayList<>();
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                List<Mains> _temp = mainsFacadeLocal.findAll_by_Cotisation(cotisation);
                for (Mains m : _temp) {
                    if (a_deja_cotise(m) == null) {
                        _result.add(m);
                    }
                }
            }
        } catch (Exception e) {
        }
        return _result;
    }

    public boolean verifie_all_mains_ont_cotise(Cotisation c) {
        if (c != null && c.getIdcotisation() != null) {
            List<Mains> _temp = mainsFacadeLocal.findAll_by_Cotisation(c);
            for (Mains m : _temp) {
                if (a_deja_cotise(m) == null) {
                    return false;
                }
            }
        }
        return true;
    }

    public Mains a_deja_cotise(Mains m) {
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0 && tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {
                List<CotisationTontine> _temp = cotisationTontineFacadeLocal.findByRencontreCotisation(tontiner.getIdrencontre().getIdrencontre(), cotisation.getIdcotisation());
                for (CotisationTontine c : _temp) {
                    if (c.getIdmain().getIdmain().equals(m.getIdmain())) {
                        return c.getIdmain();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Boolean tontiner_is_termine() {
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0 && tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {
                return tontiner.getEffectue();
            }
        } catch (Exception e) {
        }
        return false;
    }

    public Double calcul_montant_total_cotise() {
        try {
            main = mainsFacadeLocal.find(main.getIdmain());
            if (main != null) {
                Double mtn = cotisationTontine.getACotise();
                for (Aidecotisation a : list_aidescotisation) {
                    mtn += a.getMontant();
                }
                return mtn;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Double calcul_reste_a_cotiser() {
        try {
            if (cotisationTontine != null) {
                Double mtn = cotisationTontine.getACotise();
                for (Aidecotisation a : list_aidescotisation) {
                    mtn += a.getMontant();
                }
                return cotisationTontine.getDoitCotiser() - mtn;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Double calcul_montant_cotise_a_la_rencontre_par_membre(Tontiner t) {
        Double montant = 0d;
        try {
            if (cotisation != null && cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                if (tontiner != null && tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {
                    List<CotisationTontine> _temp = cotisationTontineFacadeLocal.findByRencontreCotisation(t.getIdrencontre().getIdrencontre(), cotisation.getIdcotisation());
                    for (CotisationTontine ct : _temp) {
                        montant += ct.getACotise();
                    }
                }
            }
        } catch (Exception e) {
        }
        return montant;
    }

    public Double calcul_montant_cotise_a_la_rencontre(Tontiner t) {
        Double montant = 0d;
        try {
            if (cotisation != null && cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                if (tontiner != null && tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {
                    List<CotisationTontine> _temp = cotisationTontineFacadeLocal.findByRencontreCotisation(t.getIdrencontre().getIdrencontre(), cotisation.getIdcotisation());
                    for (CotisationTontine ct : _temp) {
                        montant += ct.getDoitCotiser();
                    }
                }
            }
        } catch (Exception e) {
        }
        return montant;
    }

    public Double calcul_montant_doit_cotise_a_la_rencontre() {
        Double montant = 0d;
        try {
            if (cotisation != null && cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                montant += cotisation.getMontant() * get_nbre_total_mains();
            }
        } catch (Exception e) {
        }
        return montant;
    }

    public Double calcul_montant_total_aide(Mains m) {
        Double result = 0d;
        try {
            List<Aidecotisation> _temp = aidecotisationFacadeLocal.findAllBy_main(m);
            for (int i = 0; i < _temp.size(); i++) {
                result += _temp.get(i).getMontant();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public Double calcul_montant_aide(Mains m) {
        Double result = 0d;
        try {
            if (tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {
                List<Aidecotisation> _temp = aidecotisationFacadeLocal.findAllBy_tontiner_main(tontiner, m);
                for (int i = 0; i < _temp.size(); i++) {
                    result += _temp.get(i).getMontant();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public Double calcul_montant_aide_local(Mains m) {
        Double result = 0d;
        try {
            for (int i = 0; i < list_aides_local.size(); i++) {
                if (list_aides_local.get(i).getIdcotisationtontine().getIdmain().getIdmain().equals(m.getIdmain())) {
                    result += list_aides_local.get(i).getMontant();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public Integer calcul_nbre_beneficiaire_potentiel(Tontiner t) {
        Integer result = 0;
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                List<Tontiner> _temp = tontinerFacadeLocal.findAllBy_cotisation(cotisation);
                for (int i = 0; i < _temp.size(); i++) {
                    if (_temp.get(i).getIdrencontre().getDaterencontre().equals(t.getIdrencontre().getDaterencontre())) {
                        if (i == 0) {
                            result = (int) (calcul_montant_cotise_par_rencontre(cotisation) / calcul_montant_doit_bouffer_all(cotisation));
                        } else {
                            if (_temp.get(i).getEffectue()) {
                                result = get_nbre_beneficiaire_programme(_temp.get(i));
                            } else {
                                result = (int) ((calcul_relicat(_temp.get(i - 1)) + calcul_montant_cotise_par_rencontre(cotisation)) / def_min_doit_bouffer(cotisation));
                            }
                        }
                        break;
                    }
                }
            } else {
                cotisation = new Cotisation(0);
            }
        } catch (Exception e) {
        }
        return result <= get_list_mains_non_programme().size() ? result : get_list_mains_non_programme().size();
    }

    public Double def_min_doit_bouffer(Cotisation c) {
        Double result = 0d;
        try {
            result = c.getMontant();
            List<Mains> _temp = get_list_mains_non_programme();
            if (!_temp.isEmpty()) {
                for (Mains _temp1 : _temp) {
                    if (_temp1.getMontantsouscrit() < result) {
                        result = _temp1.getMontantsouscrit();
                    }
                }
            }
        } catch (Exception e) {
        }
        return result;
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

    public boolean erreur_programmation() {
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                List<Tontiner> _temp = tontinerFacadeLocal.findAllBy_cotisation(cotisation);
                double total_sortie = 0, total_entree = 0;
                for (Tontiner t : _temp) {
                    total_entree = calcul_total_entree(t);
                    total_sortie = calcul_total_sortie(t);
                    if (total_entree < total_sortie) {
                        return true;
                    }
                }
            }
        } catch (Exception e) {
        }
        return false;
    }

    public double calcul_total_sortie(Tontiner t) {
        Double result = 0d;
        try {
            List<BeneficiaireTontine> _temp = beneficiaireTontineFacadeLocal.findBy_tontiner(t);
            for (BeneficiaireTontine b : _temp) {
                result += doit_bouffer(b.getIdmain());
            }
            result -= calcul_total_enchere_rencontre(t);
        } catch (Exception e) {
        }
        return result;
    }

    public double calcul_total_entree(Tontiner t) {
        Double result = 0d;
        try {
            List<BeneficiaireTontine> _temp = beneficiaireTontineFacadeLocal.findBy_tontiner(t);
            for (BeneficiaireTontine b : _temp) {
                result += doit_bouffer(b.getIdmain());
            }
        } catch (Exception e) {
        }
        return result;
    }

    public Double calcul_total_enchere_rencontre(Tontiner t) {
        Double result = 0d;
        try {
            List<BeneficiaireTontine> _temp = beneficiaireTontineFacadeLocal.findBy_tontiner(t);
            Encherebenficiare e;
            for (BeneficiaireTontine b : _temp) {
                e = encherebenficiareFacadeLocal.findBy_benficiaireTontine(b);
                if (e != null) {
                    result += e.getMontant();
                }
            }
        } catch (Exception e) {
        }
        return result;
    }

    public Double calcul_total_doit() {
        Double result = 0d;
        try {
            for (CotisationTontine ct : getList_cotisationTontine()) {
                result += ct.getDoitCotiser();
            }
        } catch (Exception e) {
        }
        return result;
    }

    public Double calcul_total_doit_rencontre() {
        Double result = 0d;
        try {
            if (tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {
                List<Tontiner> _temp = tontinerFacadeLocal.findAllBy_cotisation(cotisation);
                for (Tontiner t : _temp) {
                    if (t.getIdtontiner().equals(tontiner.getIdtontiner())) {
                        result += calcul_montant_doit_cotise_a_la_rencontre();
                        break;
                    }
                }
            }
        } catch (Exception e) {
        }
        return result;
    }

    public Double calcul_total_lui_meme() {
        Double result = 0d;
        try {
            for (CotisationTontine ct : getList_cotisationTontine()) {
                result += ct.getACotise();
            }
        } catch (Exception e) {
        }
        return result;
    }

    public Double calcul_total_assistance() {
        Double result = 0d;
        try {
            for (CotisationTontine ct : list_cotisationTontine) {
                result += calcul_montant_aide(ct.getIdmain());
            }
        } catch (Exception e) {
        }
        return result;
    }

    public List<Aidecotisation> define_list_aides_local(Mains m) {
        List<Aidecotisation> result = new ArrayList<>();
        try {
            for (int i = 0; i < list_aides_local.size(); i++) {
                if (list_aides_local.get(i).getIdcotisationtontine().getIdmain().getIdmain().equals(m.getIdmain())) {
                    result.add(list_aides_local.get(i));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int position_of_cotisation_in_local_list(CotisationTontine c) {
        for (int i = 0; i < list_cotisationMembre.size(); i++) {
            if (list_cotisationMembre.get(i).getIdmain().getIdmain().equals(c.getIdmain().getIdmain())) {
                return i;
            }
        }
        return -1;
    }

    public boolean isVisible() {
        return visible;
    }

    public void setVisible(boolean visible) {
        this.visible = visible;
    }

    public List<CotisationTontine> getList_cotisationMembre() {
        return list_cotisationMembre;
    }

    public void setList_cotisationMembre(List<CotisationTontine> list_cotisationMembre) {
        this.list_cotisationMembre = list_cotisationMembre;
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

        public void setR(Tontiner t) {
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
