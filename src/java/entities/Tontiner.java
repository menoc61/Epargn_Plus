/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Louis Stark
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Tontiner.findAll", query = "SELECT t FROM Tontiner t"),
    @NamedQuery(name = "Tontiner.findByIdtontiner", query = "SELECT t FROM Tontiner t WHERE t.idtontiner = :idtontiner"),
    @NamedQuery(name = "Tontiner.findByMontantcotise", query = "SELECT t FROM Tontiner t WHERE t.montantcotise = :montantcotise"),
    @NamedQuery(name = "Tontiner.findByMontantbeneficie", query = "SELECT t FROM Tontiner t WHERE t.montantbeneficie = :montantbeneficie"),
    @NamedQuery(name = "Tontiner.findByRedevance", query = "SELECT t FROM Tontiner t WHERE t.redevance = :redevance"),
    @NamedQuery(name = "Tontiner.findByMontantechec", query = "SELECT t FROM Tontiner t WHERE t.montantechec = :montantechec"),
    @NamedQuery(name = "Tontiner.findByEffectue", query = "SELECT t FROM Tontiner t WHERE t.effectue = :effectue")})
public class Tontiner implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idtontiner;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montantcotise;
    private Double montantbeneficie;
    private Double redevance;
    private Double montantechec;
    private Boolean effectue;
    @OneToMany(mappedBy = "idtontiner", fetch = FetchType.LAZY)
    private List<CotisationTontine> cotisationTontineList;
    @OneToMany(mappedBy = "idtontiner", fetch = FetchType.LAZY)
    private List<BeneficiaireTontine> beneficiaireTontineList;
    @OneToMany(mappedBy = "idtontiner", fetch = FetchType.LAZY)
    private List<Caisse> caisseList;
    @JoinColumn(name = "idcotisation", referencedColumnName = "idcotisation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Cotisation idcotisation;
    @JoinColumn(name = "idrencontre", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre idrencontre;

    public Tontiner() {
    }

    public Tontiner(Integer idtontiner) {
        this.idtontiner = idtontiner;
    }

    public Integer getIdtontiner() {
        return idtontiner;
    }

    public void setIdtontiner(Integer idtontiner) {
        this.idtontiner = idtontiner;
    }

    public Double getMontantcotise() {
        return montantcotise;
    }

    public void setMontantcotise(Double montantcotise) {
        this.montantcotise = montantcotise;
    }

    public Double getMontantbeneficie() {
        return montantbeneficie;
    }

    public void setMontantbeneficie(Double montantbeneficie) {
        this.montantbeneficie = montantbeneficie;
    }

    public Double getRedevance() {
        return redevance;
    }

    public void setRedevance(Double redevance) {
        this.redevance = redevance;
    }

    public Double getMontantechec() {
        return montantechec;
    }

    public void setMontantechec(Double montantechec) {
        this.montantechec = montantechec;
    }

    public Boolean getEffectue() {
        return effectue;
    }

    public void setEffectue(Boolean effectue) {
        this.effectue = effectue;
    }

    @XmlTransient
    public List<CotisationTontine> getCotisationTontineList() {
        return cotisationTontineList;
    }

    public void setCotisationTontineList(List<CotisationTontine> cotisationTontineList) {
        this.cotisationTontineList = cotisationTontineList;
    }

    @XmlTransient
    public List<BeneficiaireTontine> getBeneficiaireTontineList() {
        return beneficiaireTontineList;
    }

    public void setBeneficiaireTontineList(List<BeneficiaireTontine> beneficiaireTontineList) {
        this.beneficiaireTontineList = beneficiaireTontineList;
    }

    @XmlTransient
    public List<Caisse> getCaisseList() {
        return caisseList;
    }

    public void setCaisseList(List<Caisse> caisseList) {
        this.caisseList = caisseList;
    }

    public Cotisation getIdcotisation() {
        return idcotisation;
    }

    public void setIdcotisation(Cotisation idcotisation) {
        this.idcotisation = idcotisation;
    }

    public Rencontre getIdrencontre() {
        return idrencontre;
    }

    public void setIdrencontre(Rencontre idrencontre) {
        this.idrencontre = idrencontre;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idtontiner != null ? idtontiner.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tontiner)) {
            return false;
        }
        Tontiner other = (Tontiner) object;
        if ((this.idtontiner == null && other.idtontiner != null) || (this.idtontiner != null && !this.idtontiner.equals(other.idtontiner))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Tontiner[ idtontiner=" + idtontiner + " ]";
    }
    
}
