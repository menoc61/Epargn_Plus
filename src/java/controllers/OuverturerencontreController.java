/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.CalculInteret;
import entities.Cycletontine;
import entities.Emprunt;
import entities.EncoursEmprunt;
import entities.FichePresence;
import entities.Membrecycle;
import entities.Membretontine;
import entities.Mouchard;
import entities.Rencontre;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import org.primefaces.model.DualListModel;
import sessions.CalculInteretFacadeLocal;
import sessions.CycletontineFacadeLocal;
import sessions.EmpruntFacadeLocal;
import sessions.EncoursEmpruntFacadeLocal;
import sessions.FichePresenceFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.MembretontineFacadeLocal;
import sessions.MouchardFacadeLocal;
import sessions.RencontreFacadeLocal;
import utilitaire.Printer;
import utilitaire.Utilitaires;

/**
 *
 * @author kenne gervais
 */
@ManagedBean
@ViewScoped
public class OuverturerencontreController implements Serializable {

    @EJB
    private CycletontineFacadeLocal cycletontineFacadeLocal;
    private Cycletontine cycletontine = new Cycletontine();
    private List<Cycletontine> cycletontines = new ArrayList<>();

    @EJB
    private FichePresenceFacadeLocal fichePresenceFacadeLocal;
    private FichePresence fichePresence = new FichePresence();
    private List<FichePresence> fichePresences = new ArrayList<>();

    @EJB
    private MembrecycleFacadeLocal membrecycleFacadeLocal;
    private Membrecycle membrecycle = new Membrecycle();
    private List<Membrecycle> membrecycles = new ArrayList<>();

    @EJB
    private MembretontineFacadeLocal membretontineFacadeLocal;
    private Membretontine membretontine = new Membretontine();
    private DualListModel<Membretontine> membreDualList = new DualListModel<>();

    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre = new Rencontre();
    private List<Rencontre> rencontres = new ArrayList<>();
    private List<Rencontre> rencontres1 = new ArrayList<>();

    @EJB
    private CalculInteretFacadeLocal calculInteretFacadeLocal;
    private CalculInteret calculInteret = new CalculInteret();
    private List<CalculInteret> calculInterets = new ArrayList<>();

    @EJB
    private EncoursEmpruntFacadeLocal encoursEmpruntFacadeLocal;

    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard = new Mouchard();

    @EJB
    private EmpruntFacadeLocal empruntFacadeLocal;
    private Date date = new Date();

    private boolean detail = true;

    private boolean showInitButton = false;
    private boolean showCreateBtn = true;
    private boolean showInitBtn = true;
    private boolean showReinitialise = true;
    private boolean showReinitialise1 = true;

    private boolean showJustifie = false;
    private boolean showHeure = false;
    private boolean showMontantPenalite = false;

    @PostConstruct
    private void init() {
        mouchard = new Mouchard();
        cycletontine = SessionMBean.getCycletontine();
    }

    public void nothing() {

    }

    public void save() {
        try {

            if (!membreDualList.getTarget().isEmpty()) {
                for (Membretontine m : membreDualList.getTarget()) {
                    List<Membrecycle> membrecycles = membrecycleFacadeLocal.findByMembreCycle(m.getIdmembre(), cycletontine);
                    if (membrecycles.isEmpty()) {
                        Membrecycle mc = new Membrecycle();
                        mc.setIdmembrecycle(membrecycleFacadeLocal.nextId());
                        mc.setIdmembre(m.getIdmembre());
                        mc.setIdcycle(cycletontine);
                        membrecycleFacadeLocal.create(mc);
                    }
                }
            }

            if (!membreDualList.getSource().isEmpty()) {
                for (Membretontine m : membreDualList.getTarget()) {
                    List<Membrecycle> membrecycles = membrecycleFacadeLocal.findByMembreCycle(m.getIdmembre(), cycletontine);
                    if (!membrecycles.isEmpty()) {
                        membrecycleFacadeLocal.remove(membrecycles.get(0));
                    }
                }
            }
            JsfUtil.addSuccessMessage("Opération réussie");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void controlPresence() {
        if (fichePresence.getPresent()) {
            showHeure = true;
            showJustifie = false;
            showMontantPenalite = false;
            fichePresence.setJustifie(true);
        } else {
            showJustifie = true;
            showHeure = false;
            showMontantPenalite = false;
        }
    }

    public void controlJustifie() {
        if (fichePresence.getJustifie()) {
            showMontantPenalite = false;
        } else {
            showMontantPenalite = true;
        }
    }

    public void initializePresence() {
        try {
            if (rencontre != null) {

                List<Membrecycle> membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine);
                for (Membrecycle m : membrecycles) {
                    FichePresence f = new FichePresence();
                    f.setId(fichePresenceFacadeLocal.nextId());
                    f.setIdmembre(m);
                    f.setIdrencontre(rencontre);
                    f.setDateRencontre(rencontre.getDaterencontre());
                    f.setPresent(true);
                    f.setRetard(0);

                    if (rencontre.getHeuredebut() != null) {
                        f.setHeureDebut(rencontre.getHeuredebut());
                    }

                    if (rencontre.getHeurefin() != null) {
                        f.setHeureFin(rencontre.getHeurefin());
                    }
                    fichePresenceFacadeLocal.create(f);

                    fichePresences.add(f);
                }
                showCreateBtn = false;
                showInitButton = true;
                showReinitialise = false;
            } else {
                JsfUtil.addErrorMessage("Veuillez selectionner une rencontre");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void reinitializePresence() {
        try {
            if (rencontre != null) {
                List<FichePresence> fichePresences = fichePresenceFacadeLocal.findByRencontre(rencontre);
                if (!fichePresences.isEmpty()) {
                    List<Membrecycle> membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine);
                    List<Membrecycle> mcs = new ArrayList<>();
                    for (FichePresence fp : fichePresences) {
                        mcs.add(fp.getIdmembre());
                    }
                    if (membrecycles.size() != fichePresences.size()) {
                        for (Membrecycle mc : membrecycles) {
                            if (!mcs.contains(mc)) {
                                FichePresence f = new FichePresence();
                                f.setId(fichePresenceFacadeLocal.nextId());
                                f.setIdmembre(mc);
                                f.setIdrencontre(rencontre);
                                f.setDateRencontre(rencontre.getDaterencontre());
                                f.setPresent(true);
                                f.setRetard(0);
                                f.setRegle(true);
                                f.setJustifie(true);
                                f.setMontantPenalite(0d);

                                if (rencontre.getHeuredebut() != null) {
                                    f.setHeureDebut(rencontre.getHeuredebut());
                                }

                                if (rencontre.getHeurefin() != null) {
                                    f.setHeureFin(rencontre.getHeurefin());
                                }
                                fichePresenceFacadeLocal.create(f);

                                this.fichePresences.add(f);
                            }
                        }
                    }
                }
            }
            showReinitialise = false;
            showInitButton = true;
            JsfUtil.addSuccessMessage("Opération réussie");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateData() {
        try {
            fichePresences.clear();
            calculInterets.clear();

            showInitButton = false;
            if (rencontre != null) {
                fichePresences = fichePresenceFacadeLocal.findByRencontre(rencontre);
                if (fichePresences.isEmpty()) {
                    showInitButton = false;
                    showCreateBtn = true;
                    showReinitialise = true;
                } else {
                    showInitButton = true;
                    showCreateBtn = false;
                    showReinitialise = false;
                }

                List<CalculInteret> calculInterets = calculInteretFacadeLocal.findByRencontre(rencontre);
                if (!calculInterets.isEmpty()) {
                    this.calculInterets = calculInterets;
                    showInitBtn = true;
                    showReinitialise1 = false;
                } else {
                    showInitBtn = false;
                    showReinitialise1 = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void calculateInteret() {
        try {

            if (rencontre != null) {

                List<Rencontre> r = rencontreFacadeLocal.findByCycle(cycletontine, true, false);
                if (!r.isEmpty()) {
                    JsfUtil.addErrorMessage("Cloturer d'abord toutes les rencontres ouvertes");
                    return;
                }

                rencontre.setOuvertureRencontre(true);
                rencontreFacadeLocal.edit(rencontre);

                List<Emprunt> emprunts = empruntFacadeLocal.findByCycletontine(cycletontine.getIdcycle(), false);
                List<Membrecycle> ms = new ArrayList<>();
                calculInterets.clear();
                if (!emprunts.isEmpty()) {
                    for (Emprunt e : emprunts) {
                        if (!ms.contains(e.getIdmembre())) {
                            ms.add(e.getIdmembre());
                        }
                    }

                    for (Membrecycle mc : ms) {

                        List<Emprunt> emp = new ArrayList<>();
                        for (Emprunt emp1 : emprunts) {
                            if (emp1.getIdmembre().equals(mc)) {
                                emp.add(emp1);
                            }
                        }

                        CalculInteret calculInteret = new CalculInteret();
                        calculInteret.setId(calculInteretFacadeLocal.nextId());
                        calculInteret.setIdmembre(mc);
                        calculInteret.setIdrencontre(rencontre);

                        Double sommeInteret = 0d;
                        Double montantInitiaux = 0d;
                        Double reste_emrunt = 0d;

                        for (Emprunt e : emp) {

                            montantInitiaux += e.getMontantemp();
                            reste_emrunt += e.getMontantRemboursable();

                            sommeInteret += e.getCumulInteret();

                            if (Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur() <= 0) {
                                sommeInteret += 0;
                            } else {
                                if (e.getIdtypeinteret().getIdtypeinteret().equals(2)) {
                                    sommeInteret += (e.getMontantRemboursable() * e.getTaux() * ((Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur()))) / 100;
                                } else {
                                    sommeInteret += (e.getMontantRemboursable() + e.getCumulInteret()) * Math.pow(1 + (e.getTaux() / 100), ((Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur())));
                                    sommeInteret -= (e.getMontantRemboursable() + e.getCumulInteret());
                                }
                            }
                        }

                        calculInteret.setMontantInitialEmprunt(montantInitiaux);
                        calculInteret.setMontantInteret(sommeInteret);
                        calculInteret.setResteCapital(reste_emrunt);
                        calculInteretFacadeLocal.create(calculInteret);

                        calculInterets.add(calculInteret);
                    }
                } else {
                    JsfUtil.addErrorMessage("Le systeme n'a aucun emprunt en cours");
                }
            } else {
                JsfUtil.addErrorMessage("Aucune rencontre sélectionnée");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void reinitializeInteret() {
        try {

            List<EncoursEmprunt> encoursEmprunts = encoursEmpruntFacadeLocal.findByrencontre(rencontre);
            for (EncoursEmprunt e : encoursEmprunts) {
                encoursEmpruntFacadeLocal.remove(e);
            }

            if (!calculInterets.isEmpty()) {
                for (CalculInteret ci : calculInterets) {
                    calculInteretFacadeLocal.remove(ci);
                    System.err.println("erased");
                }
            }

            List<Emprunt> emprunts = empruntFacadeLocal.findByCycletontine(cycletontine.getIdcycle(), false);
            List<Membrecycle> ms = new ArrayList<>();
            calculInterets.clear();
            if (!emprunts.isEmpty()) {
                for (Emprunt e : emprunts) {
                    if (!ms.contains(e.getIdmembre())) {
                        ms.add(e.getIdmembre());
                    }
                }

                for (Membrecycle mc : ms) {

                    List<Emprunt> emp = new ArrayList<>();
                    for (Emprunt emp1 : emprunts) {
                        if (emp1.getIdmembre().equals(mc)) {
                            emp.add(emp1);
                        }
                    }

                    CalculInteret calculInteret = new CalculInteret();
                    calculInteret.setId(calculInteretFacadeLocal.nextId());
                    calculInteret.setIdmembre(mc);
                    calculInteret.setIdrencontre(rencontre);

                    Double sommeInteret = 0d;
                    Double montantInitiaux = 0d;
                    Double reste_capital = 0d;

                    for (Emprunt e : emp) {
                        montantInitiaux += e.getMontantemp();
                        reste_capital += e.getMontantRemboursable();

                        sommeInteret += e.getCumulInteret();
                        if (Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur() <= 0) {
                            sommeInteret += 0;
                        } else {
                            if (e.getIdtypeinteret().getIdtypeinteret().equals(2)) {
                                sommeInteret += (e.getMontantRemboursable() * e.getTaux() * ((Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur()))) / 100;
                            } else {
                                sommeInteret += (e.getMontantRemboursable() + e.getCumulInteret()) * Math.pow(1 + (e.getTaux() / 100), ((Utilitaires.duration(e.getDateDernierRemboursement(), rencontre.getDaterencontre(), 1) / cycletontine.getIdPasEmprunt().getValeur())));
                                sommeInteret -= (e.getMontantRemboursable() + e.getCumulInteret());
                            }
                        }
                    }

                    calculInteret.setMontantInitialEmprunt(montantInitiaux);
                    calculInteret.setMontantInteret(sommeInteret);
                    calculInteret.setResteCapital(reste_capital);
                    calculInteretFacadeLocal.create(calculInteret);

                    calculInterets.add(calculInteret);

                    JsfUtil.addSuccessMessage("Opération effectuée avec succès");
                }
            } else {
                JsfUtil.addErrorMessage("Le système n'a aucun emprunt en cours");
            }
            showReinitialise1 = false;
        } catch (Exception e) {
            e.printStackTrace();
            JsfUtil.addErrorMessage("Echec de l'opération");
        }
    }

    public void setPresence(FichePresence fichePresence) {
        this.fichePresence = fichePresence;
        try {
            if (fichePresence.getPresent()) {
                showHeure = true;
                showJustifie = false;
            } else {
                showJustifie = true;
                showHeure = false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void validatePresence() {
        try {
            int i = 0;
            fichePresenceFacadeLocal.edit(fichePresence);
            for (FichePresence f : fichePresences) {
                if (f.equals(fichePresence)) {
                    fichePresences.get(i).setPresent(fichePresence.getPresent());
                    fichePresences.get(i).setJustifie(fichePresence.getJustifie());
                    fichePresences.get(i).setMotif(fichePresence.getMotif());
                    if (fichePresence.getPresent()) {
                        Long interval = fichePresence.getHeureDebut().getTime() - rencontre.getHeuredebut().getTime();
                        Long minute = TimeUnit.MINUTES.convert(interval, TimeUnit.MILLISECONDS);
                        fichePresences.get(i).setRetard(minute.intValue());
                        fichePresences.get(i).setRegle(false);
                    }
                    break;
                }
                i++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void edit() {
        try {
            if (membrecycle != null) {
                membrecycleFacadeLocal.edit(membrecycle);
                JsfUtil.addSuccessMessage("Opération réussie");
            } else {
                JsfUtil.addErrorMessage("Aucune ligne selectionée");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete() {
        try {
            if (membrecycle != null) {
                membrecycleFacadeLocal.remove(membrecycle);
                JsfUtil.addSuccessMessage("Opération réussie");
            } else {
                JsfUtil.addErrorMessage("Aucune ligne sélectionnée");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public OuverturerencontreController() {

    }

    public void activeButton() {
        detail = false;
    }

    public void deactiveButton() {
        detail = true;
    }

    public void update() {
        membreDualList = new DualListModel<>();
        try {
            cycletontines = cycletontineFacadeLocal.findByTontine(cycletontine.getIdtontine());
            List<Membretontine> membretontines = membretontineFacadeLocal.findByTontine(cycletontine.getIdtontine());

            for (Membretontine m : membretontines) {
                List<Membrecycle> ms = membrecycleFacadeLocal.findByMembreCycle(m.getIdmembre(), cycletontine);
                if (ms.isEmpty()) {
                    membreDualList.getSource().add(m);
                } else {
                    membreDualList.getTarget().add(m);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void validateProcess() {
        try {
            if (rencontre != null) {

                for (FichePresence f : fichePresences) {

                    f.setRetard(0);
                    f.setMontantPenalite(0d);

                    Long interval = f.getHeureDebut().getTime() - rencontre.getHeuredebut().getTime();
                    Long minute = TimeUnit.MINUTES.convert(interval, TimeUnit.MILLISECONDS);
                    f.setRetard(minute.intValue());

                    if (!f.getPresent()) {
                        if (f.getJustifie()) {
                            f.setMontantPenalite(0d);
                            f.setRetard(0);
                            f.setRegle(true);
                        } else {
                            f.setRegle(false);
                            f.setRetard(0);
                            f.setMontantPenalite(cycletontine.getMontantAbsNonJust());
                        }
                    } else {
                        if (f.getRetard() > 0) {
                            f.setMontantPenalite(cycletontine.getMontantMinRetard() * f.getRetard());
                            f.setRegle(false);
                            f.setJustifie(false);
                            /*if (f.getRetard() >= 30) {
                             f.setRegle(false);
                             f.setJustifie(false);
                             f.setMontantPenalite(2000d);
                             } else {
                             f.setRegle(true);
                             f.setPresent(true);
                             f.setJustifie(true);
                             }*/
                        } else {
                            f.setRegle(true);
                            f.setPresent(true);
                            f.setJustifie(true);
                        }
                    }
                    fichePresenceFacadeLocal.edit(f);
                }
                fichePresences = fichePresenceFacadeLocal.findByRencontre(rencontre);
                JsfUtil.addSuccessMessage("Opération réussie");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void printFiche() {
        try {
            Printer p = new Printer();
            Map map = new HashMap();
            map.put("idrencontre", rencontre.getIdrencontre());
            p.print("/reports/rapporttontine/fiche_presence.jasper", map);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean isDetail() {
        return detail;
    }

    public void setDetail(boolean detail) {
        this.detail = detail;
    }

    public Cycletontine getCycletontine() {
        return cycletontine;
    }

    public void setCycletontine(Cycletontine cycletontine) {
        this.cycletontine = cycletontine;
    }

    public List<Cycletontine> getCycletontines() {
        return cycletontines;
    }

    public void setCycletontines(List<Cycletontine> cycletontines) {
        this.cycletontines = cycletontines;
    }

    public Membrecycle getMembrecycle() {
        return membrecycle;
    }

    public void setMembrecycle(Membrecycle membrecycle) {
        this.membrecycle = membrecycle;
    }

    public List<Membrecycle> getMembrecycles() {
        try {
            membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine , true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return membrecycles;
    }

    public void setMembrecycles(List<Membrecycle> membrecycles) {
        this.membrecycles = membrecycles;
    }

    public DualListModel<Membretontine> getMembreDualList() {
        return membreDualList;
    }

    public void setMembreDualList(DualListModel<Membretontine> membreDualList) {
        this.membreDualList = membreDualList;
    }

    public Rencontre getRencontre() {
        return rencontre;
    }

    public void setRencontre(Rencontre rencontre) {
        this.rencontre = rencontre;
    }

    public List<Rencontre> getRencontres() {
        try {
            rencontres = rencontreFacadeLocal.findByCycle(cycletontine, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rencontres;
    }

    public void setRencontres(List<Rencontre> rencontres) {
        this.rencontres = rencontres;
    }

    public List<Rencontre> getRencontres1() {
        try {
            rencontres1 = rencontreFacadeLocal.findByCycle(cycletontine, true, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rencontres1;
    }

    public void setRencontres1(List<Rencontre> rencontres1) {
        this.rencontres1 = rencontres1;
    }

    public List<FichePresence> getFichePresences() {
        return fichePresences;
    }

    public void setFichePresences(List<FichePresence> fichePresences) {
        this.fichePresences = fichePresences;
    }

    public FichePresence getFichePresence() {
        return fichePresence;
    }

    public void setFichePresence(FichePresence fichePresence) {
        this.fichePresence = fichePresence;
    }

    public boolean isShowInitButton() {
        return showInitButton;
    }

    public void setShowInitButton(boolean showInitButton) {
        this.showInitButton = showInitButton;
    }

    public boolean isShowCreateBtn() {
        return showCreateBtn;
    }

    public void setShowCreateBtn(boolean showCreateBtn) {
        this.showCreateBtn = showCreateBtn;
    }

    public CalculInteret getCalculInteret() {
        return calculInteret;
    }

    public void setCalculInteret(CalculInteret calculInteret) {
        this.calculInteret = calculInteret;
    }

    public List<CalculInteret> getCalculInterets() {
        return calculInterets;
    }

    public void setCalculInterets(List<CalculInteret> calculInterets) {
        this.calculInterets = calculInterets;
    }

    public boolean isShowInitBtn() {
        return showInitBtn;
    }

    public void setShowInitBtn(boolean showInitBtn) {
        this.showInitBtn = showInitBtn;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public boolean isShowReinitialise() {
        return showReinitialise;
    }

    public void setShowReinitialise(boolean showReinitialise) {
        this.showReinitialise = showReinitialise;
    }

    public boolean isShowReinitialise1() {
        return showReinitialise1;
    }

    public void setShowReinitialise1(boolean showReinitialise1) {
        this.showReinitialise1 = showReinitialise1;
    }

    public boolean isShowJustifie() {
        return showJustifie;
    }

    public void setShowJustifie(boolean showJustifie) {
        this.showJustifie = showJustifie;
    }

    public boolean isShowMontantPenalite() {
        return showMontantPenalite;
    }

    public void setShowMontantPenalite(boolean showMontantPenalite) {
        this.showMontantPenalite = showMontantPenalite;
    }

    public boolean isShowHeure() {
        return showHeure;
    }

    public void setShowHeure(boolean showHeure) {
        this.showHeure = showHeure;
    }

}
