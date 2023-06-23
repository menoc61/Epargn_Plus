/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine.sanctions.aides;

import controllers.tontine.SuperController;
import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Aidecotisation;
import entities.BeneficiaireTontine;
import entities.Cotisation;
import entities.Mains;
import java.util.ArrayList;
import java.util.List;
import org.primefaces.PrimeFaces;

/**
 *
 * @author Louis Stark
 */
public abstract class AbstractAideCotisationController extends SuperController {

    protected List<Aidecotisation> list_aidescotisation_temp = new ArrayList<>();

    @Override
    protected void define_modifier_supprimer_detail(Object o) {
        if (o != null && o instanceof Aidecotisation) {
            modifier = details = supprimer = ((Aidecotisation) o).getIdaidecotisation() != null && ((Aidecotisation) o).getIdaidecotisation() != 0;
            return;
        }
        modifier = details = supprimer = false;
    }

    @Override
    protected void define_list_aidecotisation() {
        try {
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
            if (cotisation != null) {
                list_aidescotisation = aidecotisationFacadeLocal.findAllBy_cotisation(cotisation);
            } else {
                list_aidescotisation.clear();
                cotisation = new Cotisation(0);
            }
        } catch (Exception e) {
        }
    }

    @Override
    protected void define_list_cotisations() {
        try {
            list_cotisations = cotisationFacadeLocal.findBy_tontine(SessionMBean.getCycletontine().getIdtontine());
        } catch (Exception e) {
        }
    }

    public void prepareDetails() {
        mode = "Create";
        try {
            if (aidecotisation != null) {
                if (aidecotisation.getIdaidecotisation() != null && aidecotisation.getIdaidecotisation() != 0) {

                    cotisationTontine = aidecotisation.getIdcotisationtontine();
                    list_aidescotisation_temp = aidecotisationFacadeLocal.findAllBy_cotisationTontine(cotisationTontine);

                    PrimeFaces.current().executeScript("PF('DetailsDialog').show()");
                }
            }
        } catch (Exception e) {
            JsfUtil.addErrorMessage(e, "Message : " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void updateData() {
        try {
            cotisation = cotisationFacadeLocal.find(cotisation.getIdcotisation());
            if (cotisation != null) {

            } else {
                cotisation = new Cotisation(0);
            }
        } catch (Exception e) {
        }
    }

    public Double calcul_penalite_non_cotisation() {
        Double result = 0d;
        try {
            if (cotisationTontine != null) {
                if (cotisationTontine.getIdcotisationtontine() != null && cotisationTontine.getIdcotisationtontine() != 0) {
                    if (aidecotisation != null) {
                        if (aidecotisation.getIdaidecotisation() != null && aidecotisation.getIdaidecotisation() != 0) {
                            // on verifi si la main a déjà bouffé
                            if (a_dejà_bouffe(aidecotisation.getIdcotisationtontine().getIdmain())) {
                                // oui
                                result = (cotisation.getPenaliteNonCotisationABouffe() * aidecotisation.getIdcotisationtontine().getIdmain().getMontantsouscrit()) / 100;
                            } else {
                                // non
                                result = (cotisation.getPenaliteNonCotisation() * aidecotisation.getIdcotisationtontine().getIdmain().getMontantsouscrit()) / 100;
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public Double montantTotal_assistance() {
        Double result = 0d;
        try {
            if (cotisationTontine != null) {
                if (cotisationTontine.getIdcotisationtontine() != null && cotisationTontine.getIdcotisationtontine() != 0) {
                    for (Aidecotisation a : list_aidescotisation_temp) {
                        result += a.getMontant();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public Double calcul_total_interet_assistance() {
        Double result = 0d;
        try {
            if (cotisationTontine != null) {
                if (cotisationTontine.getIdcotisationtontine() != null && cotisationTontine.getIdcotisationtontine() != 0) {
                    result = (cotisation.getInteretAssistanceCotisation() * montantTotal_assistance()) / 100;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public Double calcul_interet_assistance(Aidecotisation a) {
        Double result = 0d;
        try {
            if (cotisationTontine != null) {
                if (cotisationTontine.getIdcotisationtontine() != null && cotisationTontine.getIdcotisationtontine() != 0) {
                    if (a.getIdmembrecycle() != null) {
                        Double percent = (a.getMontant() * 100) / montantTotal_assistance();
                        result = (calcul_total_interet_assistance() * percent) / 100;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public Double calcul_total_assistance(Aidecotisation a) {
        return a.getMontant() + calcul_interet_assistance(a);
    }

    public Double calcul_total_total_assistance() {
        Double result = 0d;
        for (Aidecotisation aa : list_aidescotisation_temp) {
            result += calcul_total_assistance(aa);
        }
        return result;
    }

    public Double calcul_total_interet() {
        Double result = 0d;
        for (Aidecotisation aa : list_aidescotisation_temp) {
            result += calcul_interet_assistance(aa);
        }
        return result;
    }

    public Double calcul_montant_total_doit() {
        Double result = 0d;
        try {
            if (cotisationTontine != null) {
                if (cotisationTontine.getIdcotisationtontine() != null && cotisationTontine.getIdcotisationtontine() != 0) {
                    result = calcul_penalite_non_cotisation() + calcul_total_total_assistance();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean a_dejà_bouffe(Mains m) {
        try {
            BeneficiaireTontine temp = beneficiaireTontineFacadeLocal.findBy_main(m);
            if (temp != null) {
                if (temp.getIdtontiner().getEffectue() && temp.getMontant() != null && temp.getMontant() != 0d) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Aidecotisation> getList_aidescotisation_temp() {
        return list_aidescotisation_temp;
    }

}
