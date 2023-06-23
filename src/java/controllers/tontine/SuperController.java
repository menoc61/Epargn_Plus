/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.tontine;

import controllers.util.SessionMBean;
import entities.Aidecotisation;
import entities.BeneficiaireTontine;
import entities.Beneficiairecotisation;
import entities.Caisse;
import entities.Cassationtontine;
import entities.Cotisation;
import entities.CotisationTontine;
import entities.Cycletontine;
import entities.Emprunt;
import entities.Encherebenficiare;
import entities.Frequencecotisation;
import entities.InscriptionCotisation;
import entities.Mains;
import entities.Membrecycle;
import entities.PasEmprunt;
import entities.Rencontre;
import entities.Tontine;
import entities.Tontiner;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.transaction.UserTransaction;
import org.primefaces.model.DualListModel;
import sessions.AidecotisationFacadeLocal;
import sessions.BeneficiaireTontineFacadeLocal;
import sessions.BeneficiairecotisationFacadeLocal;
import sessions.CaisseFacadeLocal;
import sessions.CassationtontineFacadeLocal;
import sessions.CotisationFacadeLocal;
import sessions.CotisationTontineFacadeLocal;
import sessions.CycletontineFacadeLocal;
import sessions.EmpruntFacadeLocal;
import sessions.EncherebenficiareFacadeLocal;
import sessions.FrequencecotisationFacadeLocal;
import sessions.InscriptionCotisationFacadeLocal;
import sessions.MainsFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.PasEmpruntFacadeLocal;
import sessions.RencontreFacadeLocal;
import sessions.TontineFacadeLocal;
import sessions.TontinerFacadeLocal;
import utilitaire.Printer;

/**
 *
 * @author Louis Stark
 */
public abstract class SuperController {

    @Resource
    protected UserTransaction ut;

    @EJB
    protected MouchardFacadeLocal mouchardFacadeLocal;

    @EJB
    protected TontineFacadeLocal tontineFacadeLocal;
    protected List<Tontine> list_tontines = new ArrayList<>();
    protected Tontine tontine = new Tontine(0);

    @EJB
    protected CotisationFacadeLocal cotisationFacadeLocal;
    protected List<Cotisation> list_cotisations = new ArrayList<>();
    protected Cotisation cotisation = new Cotisation(0);

    @EJB
    protected MembrecycleFacadeLocal membrecycleFacadeLocal;
    protected List<Membrecycle> list_membrecycle = new ArrayList<>();
    protected DualListModel<Membrecycle> dualList_membrecycle = new DualListModel<>();
    protected Membrecycle membrecycle = new Membrecycle(0);

    @EJB
    protected InscriptionCotisationFacadeLocal inscriptionCotisationFacadeLocal;
    protected List<InscriptionCotisation> list_inscriptionCotisations = new ArrayList<>();
    protected InscriptionCotisation inscriptionCotisation = new InscriptionCotisation(0l);

    @EJB
    protected MainsFacadeLocal mainsFacadeLocal;
    protected List<Mains> list_mains = new ArrayList<>();
    protected Mains main = new Mains();

    @EJB
    protected BeneficiaireTontineFacadeLocal beneficiaireTontineFacadeLocal;
    protected List<BeneficiaireTontine> list_beneficiairesTontine = new ArrayList<>();
    protected BeneficiaireTontine beneficiaireTontine = new BeneficiaireTontine(0l);

    @EJB
    protected BeneficiairecotisationFacadeLocal beneficiairecotisationFacadeLocal;
    protected List<Beneficiairecotisation> list_beneficiairesCotisations = new ArrayList<>();
    protected Beneficiairecotisation beneficiairecotisation = new Beneficiairecotisation(0);

    @EJB
    protected FrequencecotisationFacadeLocal frequencecotisationFacadeLocal;
    protected List<Frequencecotisation> list_frequenceCotisations = new ArrayList<>();
    protected Frequencecotisation frequencecotisation = new Frequencecotisation(0);

    @EJB
    protected CycletontineFacadeLocal cycletontineFacadeLocal;
    protected List<Cycletontine> list_cyclestontine = new ArrayList<>();
    protected Cycletontine cycletontine = new Cycletontine(0);

    @EJB
    protected RencontreFacadeLocal rencontreFacadeLocal;
    protected List<Rencontre> list_rencontres = new ArrayList<>();
    protected Rencontre rencontre = new Rencontre(0);

    @EJB
    protected TontinerFacadeLocal tontinerFacadeLocal;
    protected List<Tontiner> list_tontiner = new ArrayList<>();
    protected Tontiner tontiner = new Tontiner(0);

    @EJB
    protected CotisationTontineFacadeLocal cotisationTontineFacadeLocal;
    protected List<CotisationTontine> list_cotisationTontine = new ArrayList<>();
    protected CotisationTontine cotisationTontine = new CotisationTontine(0l);

    @EJB
    protected PasEmpruntFacadeLocal pasEmpruntFacadeLocal;
    protected List<PasEmprunt> list_pasemprunt = new ArrayList<>();
    protected PasEmprunt pasEmprunt = new PasEmprunt(0);

    @EJB
    protected AidecotisationFacadeLocal aidecotisationFacadeLocal;
    protected List<Aidecotisation> list_aidescotisation = new ArrayList<>();
    protected Aidecotisation aidecotisation = new Aidecotisation(0);

    @EJB
    protected CaisseFacadeLocal caisseFacadeLocal;
    protected List<Caisse> list_caisses = new ArrayList<>();
    protected Caisse caisse = new Caisse(0l);

    @EJB
    protected CassationtontineFacadeLocal cassationtontineFacadeLocal;
    protected List<Cassationtontine> list_cassationTontines = new ArrayList<>();
    protected Cassationtontine cassationtontine = new Cassationtontine(0);

    @EJB
    protected EmpruntFacadeLocal empruntFacadeLocal;
    protected List<Emprunt> list_emprunts = new ArrayList<>();
    protected Emprunt emprunt = new Emprunt(0);

    @EJB
    protected EncherebenficiareFacadeLocal encherebenficiareFacadeLocal;
    protected List<Encherebenficiare> list_encheres = new ArrayList<>();
    protected Encherebenficiare encherebenficiare = new Encherebenficiare(0);

    protected String mode = "";

    protected boolean modifier = false, supprimer = false, details = false;

    protected Printer printer = new Printer();
    protected String src = "/reports/jasper/";
    protected String jasper_src = "";
    protected String SUBREPORT_DIR = "";
    protected String file_name = "";
    protected Map<String, Object> params = new HashMap<>();

    //////////////////////// abstract metods  ////////////////////////////////////////////
    /////////
    protected void define_list_inscriptionCotisation() {
    }

    protected void define_list_mains() {
    }

    protected void define_dualList_membrecycle() {
    }

    protected void define_list_membrecycle() {
    }

    protected void define_list_beneficairesTontine() {
    }

    protected void define_list_beneficairesCotisations() {
    }

    protected void define_list_rencontres() {
        if (SessionMBean.getCycletontine() != null) {
            System.err.println("cycle non null");
            list_rencontres = rencontreFacadeLocal.findByRencontreCotisation(SessionMBean.getCycletontine().getIdtontine());
        } else {
            System.err.println("cycle null");
        }
    }

    protected void define_list_tontiner() {
    }

    protected void define_list_pasEmprunt() {
    }

    protected void define_list_cotisationTontine() {
    }

    protected void define_list_tontines() {
    }

    protected void define_list_aidecotisation() {
    }

    protected void define_list_caisses() {
    }

    protected void define_list_emprunt() {
    }

    protected void define_list_encheres() {
    }

    protected void define_list_cassationTontines() {
    }

    /**
     * Cette methode permet de définir la valeur des booleens Modifier et
     * supprimer Ainsi en fonction de si l'objet en parametre n'est pas nulle,
     * modifier et supprimer seront vrai dans le cas contraire ils sont a false
     *
     * @param o
     */
    protected abstract void define_modifier_supprimer_detail(Object o);

    //////////////////////// metods  //////////////////////////////////////////////////
    ///////////
    protected void define_list_frequenceCotisation() {
        list_frequenceCotisations = frequencecotisationFacadeLocal.findAllRange_by_name();
    }

    protected void define_list_cotisations() {
        try {
            if (SessionMBean.getCycletontine() != null) {
                list_cotisations = cotisationFacadeLocal.findBy_tontine(SessionMBean.getCycletontine().getIdtontine());
            }
        } catch (Exception e) {
            Logger.getLogger(SuperController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void define_list_cyclestontine() {
        try {
            list_cyclestontine = cycletontineFacadeLocal.findByTontine(SessionMBean.getCycletontine().getIdtontine());
        } catch (Exception ex) {
            Logger.getLogger(SuperController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //////////////////////  getters et setters ///////////////////////////////////////////
    //////////////////
    public String getMode() {
        return mode;
    }

    public boolean isModifier() {
        return modifier;
    }

    public boolean isSupprimer() {
        return supprimer;
    }

    public boolean isDetails() {
        return details;
    }

    public List<Cotisation> getList_cotisations() {
        define_list_cotisations();
        return list_cotisations;
    }

    public List<InscriptionCotisation> getList_inscriptionCotisations() {
        define_list_inscriptionCotisation();
        return list_inscriptionCotisations;
    }

    public List<Mains> getList_mains() {
        define_list_mains();
        return list_mains;
    }

    public List<BeneficiaireTontine> getList_beneficiairesTontine() {
        define_list_beneficairesTontine();
        return list_beneficiairesTontine;
    }

    public List<Frequencecotisation> getList_frequenceCotisations() {
        define_list_frequenceCotisation();
        return list_frequenceCotisations;
    }

    public List<Cycletontine> getList_cyclestontine() {
        define_list_cyclestontine();
        return list_cyclestontine;
    }

    public DualListModel<Membrecycle> getDualList_membrecycle() {
        define_dualList_membrecycle();
        return dualList_membrecycle;
    }

    public List<Beneficiairecotisation> getList_beneficiairesCotisations() {
        define_list_beneficairesCotisations();
        return list_beneficiairesCotisations;
    }

    public void setDualList_membrecycle(DualListModel<Membrecycle> dualList_membrecycle) {
        this.dualList_membrecycle = dualList_membrecycle;
    }

    public List<Membrecycle> getList_membrecycle() {
        define_list_membrecycle();
        return list_membrecycle;
    }

    public List<Rencontre> getList_rencontres() {
        //define_list_rencontres();

        if (SessionMBean.getCycletontine() != null) {
            list_rencontres = rencontreFacadeLocal.findByRencontreCotisation(SessionMBean.getCycletontine().getIdtontine());
        }
        return list_rencontres;
    }

    public List<Tontiner> getList_tontiner() {
        define_list_tontiner();
        return list_tontiner;
    }

    public List<CotisationTontine> getList_cotisationTontine() {
        define_list_cotisationTontine();
        return list_cotisationTontine;
    }

    public List<PasEmprunt> getList_pasemprunt() {
        define_list_pasEmprunt();
        return list_pasemprunt;
    }

    public List<Tontine> getList_tontines() {
        define_list_tontines();
        return list_tontines;
    }

    public List<Aidecotisation> getList_aidescotisation() {
        define_list_aidecotisation();
        return list_aidescotisation;
    }

    public List<Caisse> getList_caisses() {
        define_list_caisses();
        return list_caisses;
    }

    public List<Emprunt> getList_emprunts() {
        define_list_emprunt();
        return list_emprunts;
    }

    public List<Encherebenficiare> getList_encheres() {
        define_list_encheres();
        return list_encheres;
    }

    public List<Cassationtontine> getList_cassationTontines() {
        define_list_cassationTontines();
        return list_cassationTontines;
    }

    public Cotisation getCotisation() {
        return cotisation;
    }

    public void setCotisation(Cotisation cotisation) {
        this.cotisation = cotisation;
        define_modifier_supprimer_detail(cotisation);
    }

    public InscriptionCotisation getInscriptionCotisation() {
        return inscriptionCotisation;
    }

    public void setInscriptionCotisation(InscriptionCotisation inscriptionCotisation) {
        this.inscriptionCotisation = inscriptionCotisation;
        define_modifier_supprimer_detail(inscriptionCotisation);
    }

    public Mains getMain() {
        return main;
    }

    public void setMain(Mains main) {
        this.main = main;
        define_modifier_supprimer_detail(main);
    }

    public BeneficiaireTontine getBeneficiaireTontine() {
        return beneficiaireTontine;
    }

    public void setBeneficiaireTontine(BeneficiaireTontine beneficiaireTontine) {
        this.beneficiaireTontine = beneficiaireTontine;
        define_modifier_supprimer_detail(beneficiaireTontine);
    }

    public Frequencecotisation getFrequencecotisation() {
        return frequencecotisation;
    }

    public void setFrequencecotisation(Frequencecotisation frequencecotisation) {
        this.frequencecotisation = frequencecotisation;
        define_modifier_supprimer_detail(frequencecotisation);
    }

    public Cycletontine getCycletontine() {
        return cycletontine;
    }

    public void setCycletontine(Cycletontine cycletontine) {
        this.cycletontine = cycletontine;
        define_modifier_supprimer_detail(cycletontine);
    }

    public Membrecycle getMembrecycle() {
        return membrecycle;
    }

    public void setMembrecycle(Membrecycle membrecycle) {
        this.membrecycle = membrecycle;
        define_modifier_supprimer_detail(membrecycle);
    }

    public Beneficiairecotisation getBeneficiairecotisation() {
        return beneficiairecotisation;
    }

    public void setBeneficiairecotisation(Beneficiairecotisation beneficiairecotisation) {
        this.beneficiairecotisation = beneficiairecotisation;
        define_modifier_supprimer_detail(beneficiairecotisation);
    }

    public Rencontre getRencontre() {
        return rencontre;
    }

    public void setRencontre(Rencontre rencontre) {
        this.rencontre = rencontre;
        define_modifier_supprimer_detail(rencontre);
    }

    public Tontiner getTontiner() {
        return tontiner;
    }

    public void setTontiner(Tontiner tontiner) {
        this.tontiner = tontiner;
        define_modifier_supprimer_detail(tontiner);
    }

    public Tontine getTontine() {
        return tontine;
    }

    public void setTontine(Tontine tontine) {
        this.tontine = tontine;
        define_modifier_supprimer_detail(tontine);
    }

    public CotisationTontine getCotisationTontine() {
        return cotisationTontine;
    }

    public void setCotisationTontine(CotisationTontine cotisationTontine) {
        this.cotisationTontine = cotisationTontine;
        define_modifier_supprimer_detail(cotisationTontine);
    }

    public PasEmprunt getPasEmprunt() {
        return pasEmprunt;
    }

    public void setPasEmprunt(PasEmprunt pasEmprunt) {
        this.pasEmprunt = pasEmprunt;
        define_modifier_supprimer_detail(pasEmprunt);
    }

    public Aidecotisation getAidecotisation() {
        return aidecotisation;
    }

    public void setAidecotisation(Aidecotisation aidecotisation) {
        this.aidecotisation = aidecotisation;
        define_modifier_supprimer_detail(aidecotisation);
    }

    public Caisse getCaisse() {
        return caisse;
    }

    public void setCaisse(Caisse caisse) {
        this.caisse = caisse;
        define_modifier_supprimer_detail(caisse);
    }

    public Emprunt getEmprunt() {
        return emprunt;
    }

    public void setEmprunt(Emprunt emprunt) {
        this.emprunt = emprunt;
        define_modifier_supprimer_detail(emprunt);
    }

    public Encherebenficiare getEncherebenficiare() {
        return encherebenficiare;
    }

    public void setEncherebenficiare(Encherebenficiare encherebenficiare) {
        this.encherebenficiare = encherebenficiare;
        define_modifier_supprimer_detail(encherebenficiare);
    }

    public Cassationtontine getCassationtontine() {
        return cassationtontine;
    }

    public void setCassationtontine(Cassationtontine cassationtontine) {
        this.cassationtontine = cassationtontine;
        define_modifier_supprimer_detail(cassationtontine);
    }

}
