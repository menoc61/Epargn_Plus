/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Louis Stark
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Cassation.findAll", query = "SELECT c FROM Cassation c"),
    @NamedQuery(name = "Cassation.findById", query = "SELECT c FROM Cassation c WHERE c.id = :id"),
    @NamedQuery(name = "Cassation.findByMontantEpargne", query = "SELECT c FROM Cassation c WHERE c.montantEpargne = :montantEpargne"),
    @NamedQuery(name = "Cassation.findByNombrePoint", query = "SELECT c FROM Cassation c WHERE c.nombrePoint = :nombrePoint"),
    @NamedQuery(name = "Cassation.findByMontantGain", query = "SELECT c FROM Cassation c WHERE c.montantGain = :montantGain"),
    @NamedQuery(name = "Cassation.findByMontantRembourse", query = "SELECT c FROM Cassation c WHERE c.montantRembourse = :montantRembourse"),
    @NamedQuery(name = "Cassation.findByMontantInteret", query = "SELECT c FROM Cassation c WHERE c.montantInteret = :montantInteret"),
    @NamedQuery(name = "Cassation.findByMontantEmprunte", query = "SELECT c FROM Cassation c WHERE c.montantEmprunte = :montantEmprunte"),
    @NamedQuery(name = "Cassation.findByDuree", query = "SELECT c FROM Cassation c WHERE c.duree = :duree"),
    @NamedQuery(name = "Cassation.findByCoefEpargne", query = "SELECT c FROM Cassation c WHERE c.coefEpargne = :coefEpargne"),
    @NamedQuery(name = "Cassation.findByPourcentageGain", query = "SELECT c FROM Cassation c WHERE c.pourcentageGain = :pourcentageGain"),
    @NamedQuery(name = "Cassation.findByResteCapital", query = "SELECT c FROM Cassation c WHERE c.resteCapital = :resteCapital"),
    @NamedQuery(name = "Cassation.findByResteInteret", query = "SELECT c FROM Cassation c WHERE c.resteInteret = :resteInteret"),
    @NamedQuery(name = "Cassation.findByRedevanceCotisation", query = "SELECT c FROM Cassation c WHERE c.redevanceCotisation = :redevanceCotisation"),
    @NamedQuery(name = "Cassation.findByRedevanceMainLaivee", query = "SELECT c FROM Cassation c WHERE c.redevanceMainLaivee = :redevanceMainLaivee"),
    @NamedQuery(name = "Cassation.findByRedevanceSecours", query = "SELECT c FROM Cassation c WHERE c.redevanceSecours = :redevanceSecours"),
    @NamedQuery(name = "Cassation.findByNetAPercevoir", query = "SELECT c FROM Cassation c WHERE c.netAPercevoir = :netAPercevoir"),
    @NamedQuery(name = "Cassation.findByGainNormal", query = "SELECT c FROM Cassation c WHERE c.gainNormal = :gainNormal"),
    @NamedQuery(name = "Cassation.findByGainTontine", query = "SELECT c FROM Cassation c WHERE c.gainTontine = :gainTontine"),
    @NamedQuery(name = "Cassation.findByRedevanceAbsence", query = "SELECT c FROM Cassation c WHERE c.redevanceAbsence = :redevanceAbsence")})
public class Cassation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long id;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "montant_epargne")
    private Double montantEpargne;
    @Column(name = "nombre_point")
    private Double nombrePoint;
    @Column(name = "montant_gain")
    private Double montantGain;
    @Column(name = "montant_rembourse")
    private Double montantRembourse;
    @Column(name = "montant_interet")
    private Double montantInteret;
    @Column(name = "montant_emprunte")
    private Double montantEmprunte;
    private Double duree;
    @Column(name = "coef_epargne")
    private Double coefEpargne;
    @Column(name = "pourcentage_gain")
    private Double pourcentageGain;
    @Column(name = "reste_capital")
    private Double resteCapital;
    @Column(name = "reste_interet")
    private Double resteInteret;
    @Column(name = "redevance_cotisation")
    private Double redevanceCotisation;
    @Column(name = "redevance_main_laivee")
    private Double redevanceMainLaivee;
    @Column(name = "redevance_secours")
    private Double redevanceSecours;
    @Column(name = "net_a_percevoir")
    private Double netAPercevoir;
    @Column(name = "gain_normal")
    private Double gainNormal;
    @Column(name = "gain_tontine")
    private Double gainTontine;
    @Column(name = "redevance_absence")
    private Double redevanceAbsence;
    @JoinColumn(name = "idcycle", referencedColumnName = "idcycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Cycletontine idcycle;
    @JoinColumn(name = "idmembre", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle idmembre;

    public Cassation() {
    }

    public Cassation(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getMontantEpargne() {
        return montantEpargne;
    }

    public void setMontantEpargne(Double montantEpargne) {
        this.montantEpargne = montantEpargne;
    }

    public Double getNombrePoint() {
        return nombrePoint;
    }

    public void setNombrePoint(Double nombrePoint) {
        this.nombrePoint = nombrePoint;
    }

    public Double getMontantGain() {
        return montantGain;
    }

    public void setMontantGain(Double montantGain) {
        this.montantGain = montantGain;
    }

    public Double getMontantRembourse() {
        return montantRembourse;
    }

    public void setMontantRembourse(Double montantRembourse) {
        this.montantRembourse = montantRembourse;
    }

    public Double getMontantInteret() {
        return montantInteret;
    }

    public void setMontantInteret(Double montantInteret) {
        this.montantInteret = montantInteret;
    }

    public Double getMontantEmprunte() {
        return montantEmprunte;
    }

    public void setMontantEmprunte(Double montantEmprunte) {
        this.montantEmprunte = montantEmprunte;
    }

    public Double getDuree() {
        return duree;
    }

    public void setDuree(Double duree) {
        this.duree = duree;
    }

    public Double getCoefEpargne() {
        return coefEpargne;
    }

    public void setCoefEpargne(Double coefEpargne) {
        this.coefEpargne = coefEpargne;
    }

    public Double getPourcentageGain() {
        return pourcentageGain;
    }

    public void setPourcentageGain(Double pourcentageGain) {
        this.pourcentageGain = pourcentageGain;
    }

    public Double getResteCapital() {
        return resteCapital;
    }

    public void setResteCapital(Double resteCapital) {
        this.resteCapital = resteCapital;
    }

    public Double getResteInteret() {
        return resteInteret;
    }

    public void setResteInteret(Double resteInteret) {
        this.resteInteret = resteInteret;
    }

    public Double getRedevanceCotisation() {
        return redevanceCotisation;
    }

    public void setRedevanceCotisation(Double redevanceCotisation) {
        this.redevanceCotisation = redevanceCotisation;
    }

    public Double getRedevanceMainLaivee() {
        return redevanceMainLaivee;
    }

    public void setRedevanceMainLaivee(Double redevanceMainLaivee) {
        this.redevanceMainLaivee = redevanceMainLaivee;
    }

    public Double getRedevanceSecours() {
        return redevanceSecours;
    }

    public void setRedevanceSecours(Double redevanceSecours) {
        this.redevanceSecours = redevanceSecours;
    }

    public Double getNetAPercevoir() {
        return netAPercevoir;
    }

    public void setNetAPercevoir(Double netAPercevoir) {
        this.netAPercevoir = netAPercevoir;
    }

    public Double getGainNormal() {
        return gainNormal;
    }

    public void setGainNormal(Double gainNormal) {
        this.gainNormal = gainNormal;
    }

    public Double getGainTontine() {
        return gainTontine;
    }

    public void setGainTontine(Double gainTontine) {
        this.gainTontine = gainTontine;
    }

    public Double getRedevanceAbsence() {
        return redevanceAbsence;
    }

    public void setRedevanceAbsence(Double redevanceAbsence) {
        this.redevanceAbsence = redevanceAbsence;
    }

    public Cycletontine getIdcycle() {
        return idcycle;
    }

    public void setIdcycle(Cycletontine idcycle) {
        this.idcycle = idcycle;
    }

    public Membrecycle getIdmembre() {
        return idmembre;
    }

    public void setIdmembre(Membrecycle idmembre) {
        this.idmembre = idmembre;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Cassation)) {
            return false;
        }
        Cassation other = (Cassation) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Cassation[ id=" + id + " ]";
    }
    
}
