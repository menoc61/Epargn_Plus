/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine.inscription;

import controllers.tontine.SuperController;
import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.BeneficiaireTontine;
import entities.Cotisation;
import entities.CotisationTontine;
import entities.InscriptionCotisation;
import entities.Mains;
import entities.Membrecycle;
import entities.Tontiner;
import java.util.ArrayList;
import java.util.List;
import org.primefaces.PrimeFaces;

/**
 *
 * @author Louis Stark
 */
public abstract class AbstractCotisationInscriptionController extends SuperController {

    protected Integer nbre = 0;

    @Override
    protected void define_modifier_supprimer_detail(Object o) {
        if (o != null && o instanceof InscriptionCotisation) {
            modifier = details = supprimer = ((InscriptionCotisation) o).getIdinscription() != null;
        } else {
            modifier = details = supprimer = false;
        }
    }

    @Override
    protected void define_list_rencontres() {
        list_rencontres = rencontreFacadeLocal.findByRencontreCotisation(cycletontine.getIdtontine());
    }

    @Override
    protected void define_list_cotisations() {
        list_cotisations = cotisationFacadeLocal.findBy_tontine(SessionMBean.getCycletontine().getIdtontine());
    }

    @Override
    protected void define_list_membrecycle() {
        try {
            list_membrecycle = membrecycleFacadeLocal.findByCycle(SessionMBean.getCycletontine());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void define_list_mains() {
        try {
            if (membrecycle != null && cotisation != null) {
                if (membrecycle.getIdmembrecycle() != null && membrecycle.getIdmembrecycle() != 0 && cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                    list_mains = mainsFacadeLocal.findAll_by_Cotisation_membrecycle(cotisation, membrecycle);
                }
            }
        } catch (Exception e) {
        }
    }

    @Override
    protected void define_list_inscriptionCotisation() {
        try {
            if (cotisation != null) {
                if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                    list_inscriptionCotisations = inscriptionCotisationFacadeLocal.findByCotisation(cotisation.getIdcotisation());
                }
            }
        } catch (Exception e) {
        }
    }

    public void prepareInscription() {
        mode = "Create";

        try {
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());

            if (cotisation != null) {

                inscriptionCotisation = new InscriptionCotisation();
                membrecycle = new Membrecycle(0);

                PrimeFaces.current().executeScript("PF('AddMembreDialog').show()");

            } else {
                cotisation = new Cotisation();
                JsfUtil.addErrorMessage("Aucune cotisation choisi");
            }

        } catch (Exception e) {
            cotisation = new Cotisation();
            e.printStackTrace();
        }

    }

    public void prepareEdit() {
        mode = "Edit";

        try {

            if (inscriptionCotisation != null) {

                membrecycle = inscriptionCotisation.getIdmembre();
                cotisation = inscriptionCotisation.getIdcotisation();
                list_mains = mainsFacadeLocal.findAll_by_Inscription(inscriptionCotisation);

                PrimeFaces.current().executeScript("PF('AddMembreDialog').show()");
            }
        } catch (Exception e) {
        }

    }

    public void prepareTirage() {

        if (cotisation != null) {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                list_mains = mainsFacadeLocal.findAll_by_Cotisation(cotisation);
            }
        }

        PrimeFaces.current().executeScript("PF('CotisationTirageDialog').show()");
    }

    public void prepare_add_membre() {

        membrecycle = new Membrecycle();
        nbre = 0;
        inscriptionCotisation = new InscriptionCotisation();

        PrimeFaces.current().executeScript("PF('AddMembreDialog').show()");

    }

    public void prepareAdd_main() {
        try {
            membrecycle = membrecycleFacadeLocal.find(membrecycle.getIdmembrecycle());
            if (membrecycle != null) {

                mode = "Add_main";
                main = new Mains();
                main.setNbretourspasse(calcul_nbre_tours_passe(cotisation));
                main.setNom(membrecycle.getIdmembre().getNom() + " - " + ((mainsFacadeLocal.findAll_by_Cotisation_membrecycle(cotisation, membrecycle)).size() + 1));
                main.setMontantsouscrit(cotisation.getMontant());

                PrimeFaces.current().executeScript("PF('AddMainDialog').show()");
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
                list_inscriptionCotisations = inscriptionCotisationFacadeLocal.findByCotisation(cotisation.getIdcotisation());
            } else {
                cotisation = new Cotisation(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void updateData_addMain() {
        try {
            membrecycle = membrecycleFacadeLocal.find(membrecycle.getIdmembrecycle());
            if (membrecycle != null) {
                main.setNom(membrecycle.getIdmembre().getNom() + " - " + ((mainsFacadeLocal.findAll_by_Cotisation_membrecycle(cotisation, membrecycle)).size() + 1));

            }
        } catch (Exception e) {
        }
    }

    public void updateData_addMembre() {
        try {
            membrecycle = membrecycleFacadeLocal.find(membrecycle.getIdmembrecycle());
            if (membrecycle != null) {
                inscriptionCotisation = inscriptionCotisationFacadeLocal.findBy_cotisation_membrecycle(cotisation, membrecycle);

                if (inscriptionCotisation != null) {
                    list_mains = mainsFacadeLocal.findAll_by_Inscription(inscriptionCotisation);
                }

            } else {
                membrecycle = new Membrecycle();
            }
        } catch (Exception e) {
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public Integer calcul_nbre_mains(InscriptionCotisation i) {
        return get_inscription_list_mains(i).size();
    }

    public List<Mains> get_inscription_list_mains(InscriptionCotisation i) {
        List<Mains> _temp = new ArrayList<>();
        try {
            _temp = mainsFacadeLocal.findAll_by_Inscription(i);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return _temp == null ? new ArrayList<>() : _temp;
    }

    public Integer calcul_nbre_total_mains() {
        Integer result = 0;
        try {
            result = (mainsFacadeLocal.findAll_by_Cotisation(cotisation)).size();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    protected Integer calcul_nbre_tours_passe(Cotisation c) throws Exception {
        Integer n = 0;
        List<Tontiner> _temp = tontinerFacadeLocal.findAllBy_cotisation(c);
        for (Tontiner t : _temp) {
            try {
                if (t.getEffectue()) {
                    n += 1;
                }
            } catch (Exception e) {
            }
        }
        return n;
    }

    public String def_code_main(Mains m) {
        String code = "";
        try {
            code += SessionMBean.getCycletontine().getIdtontine().getIdtontine();
            code += SessionMBean.getCycletontine().getIdcycle();
            code += m.getIdinscription().getIdcotisation().getIdcotisation();
            code += m.getIdinscription().getIdinscription();
            code += mainsFacadeLocal.nextId();
        } catch (Exception e) {
        }
        return code;
    }

    public BeneficiaireTontine a_deja_touche(Mains m) {
        try {
            BeneficiaireTontine b = beneficiaireTontineFacadeLocal.findBy_main(m);
            if (b != null) {
                if (b.getIdtontiner().getEffectue() != null && b.getIdtontiner().getEffectue() != false) {
                    return b;
                }
            }
        } catch (Exception e) {
        }
        return null;
    }

    public List<CotisationTontine> get_cotisations_main(Mains m) {
        try {
            return cotisationTontineFacadeLocal.findBy_main(m);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    public Boolean a_dej_cotise(Mains m) {
        return !get_cotisations_main(m).isEmpty();
    }

    public Integer getNbre() {
        return nbre;
    }

    public void setNbre(Integer nbre) {
        this.nbre = nbre;
    }

}
