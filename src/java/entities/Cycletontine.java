/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Louis Stark
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Cycletontine.findAll", query = "SELECT c FROM Cycletontine c"),
    @NamedQuery(name = "Cycletontine.findByIdcycle", query = "SELECT c FROM Cycletontine c WHERE c.idcycle = :idcycle"),
    @NamedQuery(name = "Cycletontine.findByNomfr", query = "SELECT c FROM Cycletontine c WHERE c.nomfr = :nomfr"),
    @NamedQuery(name = "Cycletontine.findByNomen", query = "SELECT c FROM Cycletontine c WHERE c.nomen = :nomen"),
    @NamedQuery(name = "Cycletontine.findByNombremembre", query = "SELECT c FROM Cycletontine c WHERE c.nombremembre = :nombremembre"),
    @NamedQuery(name = "Cycletontine.findByFraisadhesion", query = "SELECT c FROM Cycletontine c WHERE c.fraisadhesion = :fraisadhesion"),
    @NamedQuery(name = "Cycletontine.findByTauxavaliste", query = "SELECT c FROM Cycletontine c WHERE c.tauxavaliste = :tauxavaliste"),
    @NamedQuery(name = "Cycletontine.findByTauxInteretDefault", query = "SELECT c FROM Cycletontine c WHERE c.tauxInteretDefault = :tauxInteretDefault"),
    @NamedQuery(name = "Cycletontine.findByUniteEmprunt", query = "SELECT c FROM Cycletontine c WHERE c.uniteEmprunt = :uniteEmprunt"),
    @NamedQuery(name = "Cycletontine.findByMontantCotisation", query = "SELECT c FROM Cycletontine c WHERE c.montantCotisation = :montantCotisation"),
    @NamedQuery(name = "Cycletontine.findByMontantMinRetard", query = "SELECT c FROM Cycletontine c WHERE c.montantMinRetard = :montantMinRetard"),
    @NamedQuery(name = "Cycletontine.findByMontantAbsNonJust", query = "SELECT c FROM Cycletontine c WHERE c.montantAbsNonJust = :montantAbsNonJust"),
    @NamedQuery(name = "Cycletontine.findByMontantSecours", query = "SELECT c FROM Cycletontine c WHERE c.montantSecours = :montantSecours"),
    @NamedQuery(name = "Cycletontine.findByTransfere", query = "SELECT c FROM Cycletontine c WHERE c.transfere = :transfere"),
    @NamedQuery(name = "Cycletontine.findByProportionGain", query = "SELECT c FROM Cycletontine c WHERE c.proportionGain = :proportionGain")})
public class Cycletontine implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idcycle;
    @Size(max = 254)
    private String nomfr;
    @Size(max = 254)
    private String nomen;
    private Integer nombremembre;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double fraisadhesion;
    private Double tauxavaliste;
    @Column(name = "taux_interet_default")
    private Double tauxInteretDefault;
    @Column(name = "unite_emprunt")
    private Double uniteEmprunt;
    @Column(name = "montant_cotisation")
    private Double montantCotisation;
    @Column(name = "montant_min_retard")
    private Double montantMinRetard;
    @Column(name = "montant_abs_non_just")
    private Double montantAbsNonJust;
    @Column(name = "montant_secours")
    private Double montantSecours;
    private Boolean transfere;
    @Column(name = "proportion_gain")
    private Double proportionGain;
    @OneToMany(mappedBy = "idcycle", fetch = FetchType.LAZY)
    private List<Operationcaisse> operationcaisseList;
    @OneToMany(mappedBy = "idcycle", fetch = FetchType.LAZY)
    private List<Aide> aideList;
    @OneToMany(mappedBy = "idcycle", fetch = FetchType.LAZY)
    private List<Caisse> caisseList;
    @OneToMany(mappedBy = "idcycle", fetch = FetchType.LAZY)
    private List<Rencontre> rencontreList;
    @OneToMany(mappedBy = "idcycle", fetch = FetchType.LAZY)
    private List<Depense> depenseList;
    @OneToMany(mappedBy = "idcycle", fetch = FetchType.LAZY)
    private List<Beneficiairecotisation> beneficiairecotisationList;
    @JoinColumn(name = "id_pas_emprunt", referencedColumnName = "idpas")
    @ManyToOne(fetch = FetchType.LAZY)
    private PasEmprunt idPasEmprunt;
    @JoinColumn(name = "idtontine", referencedColumnName = "idtontine")
    @ManyToOne(fetch = FetchType.LAZY)
    private Tontine idtontine;
    @OneToMany(mappedBy = "idcycle", fetch = FetchType.LAZY)
    private List<Recette> recetteList;
    @OneToMany(mappedBy = "idcycle", fetch = FetchType.LAZY)
    private List<Cassation> cassationList;
    @OneToMany(mappedBy = "idcycle", fetch = FetchType.LAZY)
    private List<CassationDetail> cassationDetailList;
    @OneToMany(mappedBy = "idcycle", fetch = FetchType.LAZY)
    private List<Membrecycle> membrecycleList;

    public Cycletontine() {
    }

    public Cycletontine(Integer idcycle) {
        this.idcycle = idcycle;
    }

    public Integer getIdcycle() {
        return idcycle;
    }

    public void setIdcycle(Integer idcycle) {
        this.idcycle = idcycle;
    }

    public String getNomfr() {
        return nomfr;
    }

    public void setNomfr(String nomfr) {
        this.nomfr = nomfr;
    }

    public String getNomen() {
        return nomen;
    }

    public void setNomen(String nomen) {
        this.nomen = nomen;
    }

    public Integer getNombremembre() {
        return nombremembre;
    }

    public void setNombremembre(Integer nombremembre) {
        this.nombremembre = nombremembre;
    }

    public Double getFraisadhesion() {
        return fraisadhesion;
    }

    public void setFraisadhesion(Double fraisadhesion) {
        this.fraisadhesion = fraisadhesion;
    }

    public Double getTauxavaliste() {
        return tauxavaliste;
    }

    public void setTauxavaliste(Double tauxavaliste) {
        this.tauxavaliste = tauxavaliste;
    }

    public Double getTauxInteretDefault() {
        return tauxInteretDefault;
    }

    public void setTauxInteretDefault(Double tauxInteretDefault) {
        this.tauxInteretDefault = tauxInteretDefault;
    }

    public Double getUniteEmprunt() {
        return uniteEmprunt;
    }

    public void setUniteEmprunt(Double uniteEmprunt) {
        this.uniteEmprunt = uniteEmprunt;
    }

    public Double getMontantCotisation() {
        return montantCotisation;
    }

    public void setMontantCotisation(Double montantCotisation) {
        this.montantCotisation = montantCotisation;
    }

    public Double getMontantMinRetard() {
        return montantMinRetard;
    }

    public void setMontantMinRetard(Double montantMinRetard) {
        this.montantMinRetard = montantMinRetard;
    }

    public Double getMontantAbsNonJust() {
        return montantAbsNonJust;
    }

    public void setMontantAbsNonJust(Double montantAbsNonJust) {
        this.montantAbsNonJust = montantAbsNonJust;
    }

    public Double getMontantSecours() {
        return montantSecours;
    }

    public void setMontantSecours(Double montantSecours) {
        this.montantSecours = montantSecours;
    }

    public Boolean getTransfere() {
        return transfere;
    }

    public void setTransfere(Boolean transfere) {
        this.transfere = transfere;
    }

    public Double getProportionGain() {
        return proportionGain;
    }

    public void setProportionGain(Double proportionGain) {
        this.proportionGain = proportionGain;
    }

    @XmlTransient
    public List<Operationcaisse> getOperationcaisseList() {
        return operationcaisseList;
    }

    public void setOperationcaisseList(List<Operationcaisse> operationcaisseList) {
        this.operationcaisseList = operationcaisseList;
    }

    @XmlTransient
    public List<Aide> getAideList() {
        return aideList;
    }

    public void setAideList(List<Aide> aideList) {
        this.aideList = aideList;
    }

    @XmlTransient
    public List<Caisse> getCaisseList() {
        return caisseList;
    }

    public void setCaisseList(List<Caisse> caisseList) {
        this.caisseList = caisseList;
    }

    @XmlTransient
    public List<Rencontre> getRencontreList() {
        return rencontreList;
    }

    public void setRencontreList(List<Rencontre> rencontreList) {
        this.rencontreList = rencontreList;
    }

    @XmlTransient
    public List<Depense> getDepenseList() {
        return depenseList;
    }

    public void setDepenseList(List<Depense> depenseList) {
        this.depenseList = depenseList;
    }

    @XmlTransient
    public List<Beneficiairecotisation> getBeneficiairecotisationList() {
        return beneficiairecotisationList;
    }

    public void setBeneficiairecotisationList(List<Beneficiairecotisation> beneficiairecotisationList) {
        this.beneficiairecotisationList = beneficiairecotisationList;
    }

    public PasEmprunt getIdPasEmprunt() {
        return idPasEmprunt;
    }

    public void setIdPasEmprunt(PasEmprunt idPasEmprunt) {
        this.idPasEmprunt = idPasEmprunt;
    }

    public Tontine getIdtontine() {
        return idtontine;
    }

    public void setIdtontine(Tontine idtontine) {
        this.idtontine = idtontine;
    }

    @XmlTransient
    public List<Recette> getRecetteList() {
        return recetteList;
    }

    public void setRecetteList(List<Recette> recetteList) {
        this.recetteList = recetteList;
    }

    @XmlTransient
    public List<Cassation> getCassationList() {
        return cassationList;
    }

    public void setCassationList(List<Cassation> cassationList) {
        this.cassationList = cassationList;
    }

    @XmlTransient
    public List<CassationDetail> getCassationDetailList() {
        return cassationDetailList;
    }

    public void setCassationDetailList(List<CassationDetail> cassationDetailList) {
        this.cassationDetailList = cassationDetailList;
    }

    @XmlTransient
    public List<Membrecycle> getMembrecycleList() {
        return membrecycleList;
    }

    public void setMembrecycleList(List<Membrecycle> membrecycleList) {
        this.membrecycleList = membrecycleList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idcycle != null ? idcycle.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Cycletontine)) {
            return false;
        }
        Cycletontine other = (Cycletontine) object;
        if ((this.idcycle == null && other.idcycle != null) || (this.idcycle != null && !this.idcycle.equals(other.idcycle))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Cycletontine[ idcycle=" + idcycle + " ]";
    }
    
}
