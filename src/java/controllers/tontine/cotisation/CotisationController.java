/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine.cotisation;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Aidecotisation;
import entities.BeneficiaireTontine;
import entities.Caisse;
import entities.Cotisation;
import entities.CotisationTontine;
import entities.Encherebenficiare;
import entities.Mains;
import entities.Membrecycle;
import entities.Rubriquecaisse;
import entities.Tontiner;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import org.primefaces.PrimeFaces;
import utilitaire.Utilitaires;

/**
 *
 * @author Louis Stark
 */
@ManagedBean(name = "cotisationController")
@ViewScoped
public class CotisationController extends AbstractCotisationController implements Serializable {

    /**
     * Creates a new instance of CotisationController
     */
    public CotisationController() {
    }

    public void save() {
        try {
            if ("Cotiser".equals(mode)) {

                if (tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0 && cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {

                    for (CotisationTontine c : list_cotisationMembre) {
                        save_cotisationMain(c);
                    }

                    JsfUtil.addSuccessMessage("Enregistrement des cotisations terminé !");
                    PrimeFaces.current().executeScript("PF('CotiserDialog').hide()");

                } else {
                    JsfUtil.addErrorMessage("La rencontre et la tontine n'ont pas été sélectionnées !");
                }

            } else {
                JsfUtil.addErrorMessage("Mode inconnu !");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void save_all() {
        try {
            if (tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0 && cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                List<Mains> mains = mainsFacadeLocal.findAll_by_Cotisation(cotisation);
                list_cotisationMembre.clear();
                CotisationTontine temp;
                for (Mains m : mains) {
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

                for (CotisationTontine c : list_cotisationMembre) {
                    save_cotisationMain(c);
                }

                JsfUtil.addSuccessMessage("Enregistrement des cotisations terminé !");

            } else {
                JsfUtil.addErrorMessage("La rencontre et la tontine n'ont pas été sélectionnées !");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void save_cotisationMain(CotisationTontine c) {
        try {
            cotisationTontine = c;
            if (cotisationTontine != null && cotisationTontine.getACotise() >= 0) {
                cotisationTontine.setReste(calcul_reste_a_cotiser());

                list_aidescotisation = define_list_aides_local(cotisationTontine.getIdmain());
                System.out.println(list_aidescotisation);

                if (calcul_reste_a_cotiser() == 0) {

                    if (cotisationTontine.getIdcotisationtontine() != null && cotisationTontine.getIdcotisationtontine() != 0l) {
                        cotisationTontineFacadeLocal.edit(cotisationTontine);
                    } else {
                        cotisationTontine.setIdcotisationtontine(cotisationTontineFacadeLocal.nextId());
                        cotisationTontineFacadeLocal.create(cotisationTontine);
                    }

                    for (int i = 0; i < list_aidescotisation.size(); i++) {
                        list_aidescotisation.get(i).setIdcotisationtontine(cotisationTontine);
                        if (list_aidescotisation.get(i).getIdaidecotisation() != null && list_aidescotisation.get(i).getIdaidecotisation() != 0) {
                            aidecotisationFacadeLocal.edit(list_aidescotisation.get(i));
                        } else {
                            list_aidescotisation.get(i).setIdaidecotisation(aidecotisationFacadeLocal.nextId());
                            aidecotisationFacadeLocal.create(list_aidescotisation.get(i));
                        }

                    }

                    Utilitaires.saveOperation("Enregistrement de la cotisation de la main " + cotisationTontine.getIdmain().getNom() + " effectué", SessionMBean.getUser1(), mouchardFacadeLocal);
                    JsfUtil.addSuccessMessage("Cotisation de la main " + cotisationTontine.getIdmain().getNom() + " effectué !");

                } else {
                    if (calcul_reste_a_cotiser() > 0) {
                        throw new Exception("Le montant total cotisé est inférieur au montant souscrit par la main " + cotisationTontine.getIdmain().getNom());
                    } else if (calcul_reste_a_cotiser() < 0) {
                        throw new Exception("Le montant total cotisé est suppérieur au montant souscrit par la main " + cotisationTontine.getIdmain().getNom());
                    }
                }

                updateData();
            } else {
                throw new Exception("Le montant cotisé ne peut être inférieur à 0");
            }

        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void termine_details() {
        try {
            if (cotisationTontine != null && cotisationTontine.getIdmain() != null) {
                int position = position_of_cotisation_in_local_list(cotisationTontine);
                list_cotisationMembre.set(position, cotisationTontine);

                //mode = "Cotiser";
                PrimeFaces.current().executeScript("PF('CotiserMainDialog').hide()");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void delete(CotisationTontine c) {
        try {
            if (c != null) {
                if (c.getIdtontiner().getEffectue() != true) {
                    list_aidescotisation = aidecotisationFacadeLocal.findAllBy_main(c.getIdmain());
                    for (Aidecotisation a : list_aidescotisation) {
                        aidecotisationFacadeLocal.remove(a);
                    }
                    cotisationTontineFacadeLocal.remove(c);

                    Utilitaires.saveOperation("Suppression de la cotisation de la main " + main.getNom() + " effectué", SessionMBean.getUser1(), mouchardFacadeLocal);
                    JsfUtil.addSuccessMessage("Suppression de la cotisation de la main effectué !");

                    updateData();
                    cotisationTontine = new CotisationTontine(0l);
                    list_aidescotisation.clear();
                } else {
                    JsfUtil.addErrorMessage("Impossible de supprimer. La séance est déjà terminé !");
                }
            } else {
                JsfUtil.addErrorMessage("Veuillez sélectionner la cotisation de la main a supprimer !");
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void termine_seance() {
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0 && tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {

                //1 on verifie que toutes les mains on cotise
                List<Mains> _temp = get_list_mains_non_cotise();
                if (!verifie_all_mains_ont_cotise(cotisation)) {
                    throw new Exception("Toutes mes mains n'ont pas encore cotisé !!!");
                }

                list_beneficiairesTontine = beneficiaireTontineFacadeLocal.findBy_tontiner(tontiner);
                if (list_beneficiairesTontine.isEmpty()) {
                    throw new Exception("Aucun bénéficiaire programmé pour cette séance. Veuillez aller prgrammer des bénéficiares");
                }

                //debut de la transaction
                ut.begin();

                // on modifie le montant reçu par chaque bénéficiaire de la seance
                for (BeneficiaireTontine bt : list_beneficiairesTontine) {

                    encherebenficiare = encherebenficiareFacadeLocal.findBy_benficiaireTontine(bt);
                    if (encherebenficiare != null) {
                        bt.setMontant(calcul_montant_doit_bouffer_main(bt.getIdmain()) - encherebenficiare.getMontant());
                    } else {
                        bt.setMontant(calcul_montant_doit_bouffer_main(bt.getIdmain()));
                    }

                    bt.setReste(0d);

                    beneficiaireTontineFacadeLocal.edit(bt);
                }

                // on enregistre les dettes de à la caisse
                save_dettes_caisse();

                // on renregistre les cotisations de tous les membres dans la caisse
                save_cotisations_caisse();

                // on enregistre les sorties d'argent lié à la bouffe des bénéficiaires
                save_bouffe_caisse();

                // on enregistre la redevance et les autres montant et enfin on marque la seance comme effectué
                tontiner.setRedevance(calcul_relicat(tontiner));
                tontiner.setMontantcotise(calcul_montant_cotise_a_la_rencontre_par_membre(tontiner));
                tontiner.setMontantechec(calcul_montant_cotise_a_la_rencontre(tontiner) - tontiner.getMontantcotise());
                tontiner.setEffectue(true);
                tontinerFacadeLocal.edit(tontiner);

                cotisation.setReliquat(tontiner.getRedevance());
                cotisationFacadeLocal.edit(cotisation);

                ut.commit();

                Utilitaires.saveOperation("Séance terminé (" + tontiner.getIdrencontre().getNomfr() + ")", SessionMBean.getUser1(), mouchardFacadeLocal);
                JsfUtil.addSuccessMessage("Séance terminé ");

                updateData();

            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void save_dettes_caisse() throws Exception {
        try {
            if (tontiner != null) {
                List<Aidecotisation> _temp = aidecotisationFacadeLocal.findAllBy_cotisation(tontiner.getIdcotisation());
                for (Aidecotisation a : _temp) {
                    if (a.getIdmembrecycle() == null) {
                        caisse = new Caisse();
                        caisse.setIdcycle(SessionMBean.getCycletontine());
                        caisse.setIdmembrecycle(a.getIdcotisationtontine().getIdmain().getIdinscription().getIdmembre());
                        caisse.setIdrencontre(tontiner.getIdrencontre());
                        caisse.setIdtontiner(tontiner);
                        caisse.setIdrubriquecaisse(new Rubriquecaisse(21));
                        caisse.setMontant(a.getMontant());
                        caisse.setDateoperation(tontiner.getIdrencontre().getDaterencontre());
                        caisse.setLibelleoperation("Aide de " + caisse.getMontant() + " de la caisse au membre " + caisse.getIdmembrecycle().getIdmembre().getNom() + " pour la tontine : " + tontiner.getIdcotisation().getNom());
                        caisse.setIdcaisse(caisseFacadeLocal.nextId());

                        caisseFacadeLocal.create(caisse);
                        a.setIdcaisse(caisse);
                        aidecotisationFacadeLocal.edit(a);
                    }
                }
            }
        } catch (Exception e) {
            throw new Exception(e);
        }
    }

    public void save_cotisations_caisse() throws Exception {
        try {
            if (tontiner != null) {
                List<CotisationTontine> _temp = cotisationTontineFacadeLocal.findByRencontreCotisation(tontiner.getIdrencontre().getIdrencontre(), tontiner.getIdcotisation().getIdcotisation());
                for (CotisationTontine c : _temp) {
                    caisse = new Caisse();
                    caisse.setIdcycle(SessionMBean.getCycletontine());
                    caisse.setIdmembrecycle(c.getIdmain().getIdinscription().getIdmembre());
                    caisse.setIdrencontre(tontiner.getIdrencontre());
                    caisse.setIdtontiner(tontiner);
                    caisse.setIdrubriquecaisse(new Rubriquecaisse(22));
                    caisse.setMontant(c.getDoitCotiser());
                    caisse.setDateoperation(tontiner.getIdrencontre().getDaterencontre());
                    caisse.setLibelleoperation("Cotisation par la main " + c.getIdmain().getNom() + " pour la tontine : " + tontiner.getIdcotisation().getNom());
                    caisse.setIdcaisse(caisseFacadeLocal.nextId());

                    caisseFacadeLocal.create(caisse);
                    c.setIdcaisse(caisse);
                    cotisationTontineFacadeLocal.edit(c);
                }
            }
        } catch (Exception e) {
            throw new Exception(e);
        }
    }

    public void save_bouffe_caisse() throws Exception {
        try {
            if (tontiner != null) {
                List<BeneficiaireTontine> _temp = beneficiaireTontineFacadeLocal.findByRencontreCotisation(tontiner.getIdrencontre().getIdrencontre(), tontiner.getIdcotisation().getIdcotisation());
                for (BeneficiaireTontine b : _temp) {

                    caisse = new Caisse();
                    caisse.setIdcycle(SessionMBean.getCycletontine());
                    caisse.setIdmembrecycle(b.getIdmain().getIdinscription().getIdmembre());
                    caisse.setIdrencontre(tontiner.getIdrencontre());
                    caisse.setIdtontiner(tontiner);
                    caisse.setIdrubriquecaisse(new Rubriquecaisse(23));

                    caisse.setMontant(b.getMontant());

                    caisse.setDateoperation(tontiner.getIdrencontre().getDaterencontre());
                    caisse.setLibelleoperation("Bouffe de la main " + b.getIdmain().getNom() + " pour la tontine : " + tontiner.getIdcotisation().getNom());
                    caisse.setIdcaisse(caisseFacadeLocal.nextId());

                    caisseFacadeLocal.create(caisse);
                    b.setIdcaisse(caisse);
                    beneficiaireTontineFacadeLocal.edit(b);

                    encherebenficiare = encherebenficiareFacadeLocal.findBy_benficiaireTontine(b);
                    if (encherebenficiare != null) {
                        caisse = new Caisse();
                        caisse.setIdcycle(SessionMBean.getCycletontine());
                        caisse.setIdmembrecycle(b.getIdmain().getIdinscription().getIdmembre());
                        caisse.setIdrencontre(tontiner.getIdrencontre());
                        caisse.setIdtontiner(tontiner);
                        caisse.setIdrubriquecaisse(new Rubriquecaisse(26));

                        caisse.setMontant(encherebenficiare.getMontant());

                        caisse.setDateoperation(tontiner.getIdrencontre().getDaterencontre());
                        caisse.setLibelleoperation("Paiement de l'enchere par la main " + b.getIdmain().getNom() + " pour la tontine : " + tontiner.getIdcotisation().getNom());
                        caisse.setIdcaisse(caisseFacadeLocal.nextId());

                        caisseFacadeLocal.create(caisse);
                        encherebenficiare.setIdcaisse(caisse);
                        encherebenficiare.setTermine(true);
                        encherebenficiareFacadeLocal.edit(encherebenficiare);
                    } else {
                        encherebenficiare = new Encherebenficiare();
                    }

                }
            }
        } catch (Exception e) {
            throw new Exception(e);
        }
    }

    public void saveAide() {
        try {
            membrecycle = membrecycleFacadeLocal.find(membrecycle.getIdmembrecycle());
            aidecotisation.setNomaide("La " + "Caisse");
            if (membrecycle != null) {
                aidecotisation.setIdmembrecycle(membrecycle);
                aidecotisation.setNomaide(membrecycle.getIdmembre().getNom() + membrecycle.getIdmembre().getPrenom());
            }

            if (aidecotisation.getMontant() > calcul_reste_a_cotiser()) {
                aidecotisation.setMontant(calcul_reste_a_cotiser());
                JsfUtil.addErrorMessage("le montant d'aide est suppérieur au besoin. il va être réduit au montant du besoin...");
            }
            aidecotisation.setIdcotisationtontine(cotisationTontine);
            System.out.println("Aide : nom " + aidecotisation.getNomaide());
            list_aides_local.add(aidecotisation);

            JsfUtil.addSuccessMessage("Aide ajouté");
            PrimeFaces.current().executeScript("PF('AideCotisationDialog').hide()");

            membrecycle = new Membrecycle(0);
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    public void deleteAide(Aidecotisation a) {
        try {
            list_aides_local.remove(a);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void print_pv() {
        try {
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
            tontiner = tontinerFacadeLocal.find(tontiner.getIdtontiner());
            if (cotisation != null && tontiner != null) {

                SUBREPORT_DIR = FacesContext.getCurrentInstance().getExternalContext().getRealPath(src + "sub/");
                jasper_src = src + "pv_rencontre.jasper";
                file_name = "PV " + tontiner.getIdrencontre().getNomfr();

                params.clear();
                params.put("id_tontine", SessionMBean.getCycletontine().getIdtontine().getIdtontine());
                params.put("id_cotisation", cotisation.getIdcotisation());
                params.put("id_rencontre", tontiner.getIdrencontre().getIdrencontre());
                params.put("SUBREPORT_DIR", SUBREPORT_DIR);

                printer.print(jasper_src, params, file_name);

            } else {
                JsfUtil.addErrorMessage("Aucune cotisation ni rencontre choisi");
                tontiner = new Tontiner(0);
                cotisation = new Cotisation(0);
            }
        } catch (Exception e) {
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void print_recu() {
        try {
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
            tontiner = tontinerFacadeLocal.find(tontiner.getIdtontiner());
            if (cotisation != null && tontiner != null) {

                SUBREPORT_DIR = FacesContext.getCurrentInstance().getExternalContext().getRealPath(src);
                jasper_src = src + "recu_r.jasper";
                file_name = "Reçu " + tontiner.getIdrencontre().getNomfr();

                params.clear();
                params.put("id_tontine", SessionMBean.getCycletontine().getIdtontine().getIdtontine());
                params.put("id_cotisation", cotisation.getIdcotisation());
                params.put("id_rencontre", tontiner.getIdrencontre().getIdrencontre());
                params.put("SUBREPORT_DIR", SUBREPORT_DIR);

                printer.print(jasper_src, params, file_name);

            } else {
                JsfUtil.addErrorMessage("Aucune cotisation ni rencontre choisi");
                tontiner = new Tontiner(0);
                cotisation = new Cotisation(0);
            }
        } catch (Exception e) {
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
            e.printStackTrace();
        }
    }

    protected List<Mains> nont_pas_cotise() {
        List<Mains> result = new ArrayList<>();
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0) {
                List<Mains> _tempM = mainsFacadeLocal.findAll_by_Cotisation_rangeBy_tirage(cotisation);
                for (Mains m : _tempM) {
                    if (a_deja_cotise(m) == null) {
                        result.add(m);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
        return result;
    }

    protected Double calcul_montant_total_doit_cotise() {
        Double result = 0d;
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0 && tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {
                for (CotisationTontine c : list_cotisationTontine) {
                    result += c.getDoitCotiser();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
        return result;
    }

    protected void def_montant_beneficiare() {
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0 && tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {
                if (tontiner != null) {

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
    }

    protected Double calcul_montant_redevance() {
        Double result = 0d;
        try {
            if (cotisation.getIdcotisation() != null && cotisation.getIdcotisation() != 0 && tontiner.getIdtontiner() != null && tontiner.getIdtontiner() != 0) {
                if (tontiner != null) {
                    List<BeneficiaireTontine> _temp = beneficiaireTontineFacadeLocal.findBy_tontiner(tontiner);
                    Double mtn_benef = 0d;
                    for (BeneficiaireTontine b : _temp) {
                        mtn_benef += b.getMontant();
                    }
                    result = tontiner.getMontantcotise() - mtn_benef;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
        }
        return result;
    }

}
