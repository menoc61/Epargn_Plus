/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import controllers.util.JsfUtil;
import controllers.util.SessionMBean;
import entities.Caisse;
import entities.CollecteMainLevee;
import entities.Cycletontine;
import entities.Membrecycle;
import entities.Rencontre;
import entities.Mouchard;
import entities.Rubriquecaisse;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.transaction.UserTransaction;
import sessions.CaisseFacadeLocal;
import sessions.CollecteMainLeveeFacadeLocal;
import sessions.MembrecycleFacadeLocal;
import sessions.RencontreFacadeLocal;
import sessions.MouchardFacadeLocal;

/**
 *
 * @author Abdel Beininfo
 */
@ManagedBean
@ViewScoped
public class CollecteMainLeveeController implements Serializable {

    /**
     * Creates a new instance of DepenseController
     */
    @Resource
    private UserTransaction ut;
    
    @EJB
    protected CollecteMainLeveeFacadeLocal collecteMainLeveeFacadeLocal;
    protected CollecteMainLevee collecteMainLevee = new CollecteMainLevee();
    protected List<CollecteMainLevee> collecteMainLevees = new ArrayList<>();
    
    @EJB
    protected MembrecycleFacadeLocal membrecycleFacadeLocal;
    protected Membrecycle membrecycle = new Membrecycle();
    protected List<Membrecycle> membrecycles = new ArrayList<>();
    protected List<Membrecycle> membrecycles1 = new ArrayList<>();
    
    @EJB
    private RencontreFacadeLocal rencontreFacadeLocal;
    private Rencontre rencontre = new Rencontre();
    private List<Rencontre> rencontres = new ArrayList<>();
    
    private Cycletontine cycletontine = SessionMBean.getCycletontine();
    
    private Rubriquecaisse rubriquecaisse = new Rubriquecaisse();
    
    @EJB
    private CaisseFacadeLocal caisseFacadeLocal;
    private Caisse caisse = new Caisse();
    
    private Double reste = 0D;
    
    @EJB
    private MouchardFacadeLocal mouchardFacadeLocal;
    private Mouchard mouchard = new Mouchard();
    
    private boolean detail = true;
    private boolean showMembre = true;
    
    private String mode = "";
    
    public CollecteMainLeveeController() {
        
    }
    
    @PostConstruct
    private void init() {
        mouchard = new Mouchard();
        cycletontine = SessionMBean.getCycletontine();
        rencontre = new Rencontre();
        rubriquecaisse = new Rubriquecaisse(11);
        cycletontine = SessionMBean.getCycletontine();
    }
    
    public void activeButton() {
        detail = false;
    }
    
    public void deactiveButton() {
        detail = true;
    }
    
    public void prepareCreate() {
        mode = "Create";
        rencontre = new Rencontre();
        membrecycle = new Membrecycle();
        collecteMainLevee = new CollecteMainLevee();
        caisse = new Caisse();
        mouchard = new Mouchard();
        reste = 0d;
        showMembre = false;
        try {
            this.membrecycles.clear();
            List<Membrecycle> membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine, true);
            for (Membrecycle m : membrecycles) {
                try {
                    if (m.getResteMainLevee() > 0) {
                        this.membrecycles.add(m);
                    }
                } catch (Exception e) {
                    m.setResteMainLevee(0D);
                    membrecycleFacadeLocal.edit(m);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void prepareEdit() {
        mode = "Edit";
        try {
            showMembre = true;
            if (collecteMainLevee != null) {
                rencontre = collecteMainLevee.getIdrencontre();
                membrecycle = collecteMainLevee.getIdmembre();
                
                this.membrecycles.clear();
                List<Membrecycle> membrecycles = membrecycleFacadeLocal.findByCycle(cycletontine);
                for (Membrecycle m : membrecycles) {
                    if (m.getResteMainLevee() > 0) {
                        this.membrecycles.add(m);
                    }
                }
                
                if (!this.membrecycles.contains(membrecycle)) {
                    this.membrecycles.add(membrecycle);
                }
                reste = membrecycle.getResteMainLevee();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updateDate() {
        
    }
    
    public void updateReste() {
        try {
            reste = membrecycle.getResteMainLevee();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void save() {
        try {
            
            if ("Create".equals(mode)) {
                
                ut.begin();
                
                caisse.setIdcaisse(caisseFacadeLocal.nextId());
                caisse.setMontant(collecteMainLevee.getMontant());
                caisse.setIdmembrecycle(membrecycle);
                caisse.setLibelleoperation("Enregistrement du fond de la main levée du membre  -> " + membrecycle.getIdmembre().getNom() + " " + membrecycle.getIdmembre().getPrenom() + " ; Montant -> " + collecteMainLevee.getMontant());
                caisse.setIdrencontre(rencontre);
                caisse.setIdrubriquecaisse(rubriquecaisse);
                caisse.setIdcycle(cycletontine);
                caisse.setDateoperation(rencontre.getDaterencontre());
                caisseFacadeLocal.create(caisse);
                
                collecteMainLevee.setId(collecteMainLeveeFacadeLocal.nextId());
                collecteMainLevee.setIdcaisse(caisse);
                collecteMainLevee.setIdmembre(membrecycle);
                collecteMainLevee.setIdrencontre(rencontre);
                collecteMainLeveeFacadeLocal.create(collecteMainLevee);
                
                membrecycle.setResteMainLevee(membrecycle.getResteMainLevee() - collecteMainLevee.getMontant());
                membrecycleFacadeLocal.edit(membrecycle);
                
                ut.commit();
                
                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Enregistrement de la main lévée du membre  -> " + membrecycle.getIdmembre().getNom() + " " + membrecycle.getIdmembre().getPrenom() + " ; Montant -> " + collecteMainLevee.getMontant());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Enregistrement effectué avec succès");
            } else {
                if (collecteMainLevee != null) {
                    
                    ut.begin();
                    
                    membrecycle = collecteMainLevee.getIdmembre();
                    
                    CollecteMainLevee c = collecteMainLeveeFacadeLocal.find(collecteMainLevee.getId());
                    collecteMainLevee.setIdrencontre(rencontre);
                    if (c.getMontant() != collecteMainLevee.getMontant()) {
                        
                        membrecycle.setResteMainLevee(membrecycle.getResteMainLevee() + c.getMontant());
                        
                        collecteMainLeveeFacadeLocal.edit(collecteMainLevee);
                        caisse = collecteMainLevee.getIdcaisse();
                        caisse.setMontant(collecteMainLevee.getMontant());
                        caisseFacadeLocal.edit(caisse);
                        
                        membrecycle.setResteMainLevee(membrecycle.getResteMainLevee() - collecteMainLevee.getMontant());
                        membrecycleFacadeLocal.edit(membrecycle);
                    } else {
                        collecteMainLeveeFacadeLocal.edit(collecteMainLevee);
                        caisse = collecteMainLevee.getIdcaisse();
                        caisse.setMontant(collecteMainLevee.getMontant());
                        caisseFacadeLocal.edit(caisse);
                    }
                    ut.commit();
                    
                    JsfUtil.addSuccessMessage("Operation réussie");
                } else {
                    JsfUtil.addErrorMessage("Aucune selectionnée");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void delete() {
        try {
            if (collecteMainLevee != null) {
                
                ut.begin();
                collecteMainLeveeFacadeLocal.remove(collecteMainLevee);
                collecteMainLevee.getIdmembre().setResteMainLevee(collecteMainLevee.getIdmembre().getResteMainLevee() + collecteMainLevee.getMontant());
                membrecycleFacadeLocal.edit(collecteMainLevee.getIdmembre());
                caisseFacadeLocal.remove(collecteMainLevee.getIdcaisse());
                ut.commit();
                
                membrecycle = collecteMainLevee.getIdmembre();
                
                mouchard.setIdoperation(mouchardFacadeLocal.nextId());
                mouchard.setAction("Suppression des frais de main lévée du membre -> " + membrecycle.getIdmembre().getNom() + " " + membrecycle.getIdmembre().getPrenom() + " Montant -> " + collecteMainLevee.getMontant());
                mouchard.setIdcompteUtilisateur(SessionMBean.getUser1());
                mouchard.setDateaction(new Date());
                mouchardFacadeLocal.create(mouchard);
                JsfUtil.addSuccessMessage("Suppression effectuée avec succès");
            }
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
    
    public Rencontre getRencontre() {
        return rencontre;
    }
    
    public void setRencontre(Rencontre rencontre) {
        this.rencontre = rencontre;
    }
    
    public List<Rencontre> getRencontres() {
        try {
            rencontres = rencontreFacadeLocal.findByCycle(cycletontine, true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rencontres;
    }
    
    public void setRencontre(List<Rencontre> rencontres) {
        this.rencontres = rencontres;
    }
    
    public Rubriquecaisse getRubriquecaisse() {
        return rubriquecaisse;
    }
    
    public void setRubriquecaisse(Rubriquecaisse rubriquecaisse) {
        this.rubriquecaisse = rubriquecaisse;
    }
    
    public Caisse getCaisse() {
        return caisse;
    }
    
    public void setCaisse(Caisse caisse) {
        this.caisse = caisse;
    }
    
    public Membrecycle getMembrecycle() {
        return membrecycle;
    }
    
    public void setMembrecycle(Membrecycle membrecycle) {
        this.membrecycle = membrecycle;
    }
    
    public List<Membrecycle> getMembrecycles() {
        return membrecycles;
    }
    
    public void setMembrecycles(List<Membrecycle> membrecycles) {
        this.membrecycles = membrecycles;
    }
    
    public Double getReste() {
        return reste;
    }
    
    public void setReste(Double reste) {
        this.reste = reste;
    }
    
    public boolean isShowMembre() {
        return showMembre;
    }
    
    public void setShowMembre(boolean showMembre) {
        this.showMembre = showMembre;
    }
    
    public List<Membrecycle> getMembrecycles1() {
        try {
            membrecycles1 = membrecycleFacadeLocal.findByCycle(SessionMBean.getCycletontine());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return membrecycles1;
    }
    
    public CollecteMainLevee getCollecteMainLevee() {
        return collecteMainLevee;
    }
    
    public void setCollecteMainLevee(CollecteMainLevee collecteMainLevee) {
        this.collecteMainLevee = collecteMainLevee;
    }
    
    public List<CollecteMainLevee> getCollecteMainLevees() {
        try {
            collecteMainLevees = collecteMainLeveeFacadeLocal.findByCycle(cycletontine);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return collecteMainLevees;
    }
    
    public void setCollecteMainLevees(List<CollecteMainLevee> collecteMainLevees) {
        this.collecteMainLevees = collecteMainLevees;
    }
    
}
