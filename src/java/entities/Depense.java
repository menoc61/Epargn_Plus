/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Louis Stark
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Depense.findAll", query = "SELECT d FROM Depense d"),
    @NamedQuery(name = "Depense.findByIddepense", query = "SELECT d FROM Depense d WHERE d.iddepense = :iddepense"),
    @NamedQuery(name = "Depense.findByDate", query = "SELECT d FROM Depense d WHERE d.date = :date"),
    @NamedQuery(name = "Depense.findByMontant", query = "SELECT d FROM Depense d WHERE d.montant = :montant"),
    @NamedQuery(name = "Depense.findByObservation", query = "SELECT d FROM Depense d WHERE d.observation = :observation")})
public class Depense implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer iddepense;
    @Temporal(TemporalType.DATE)
    private Date date;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montant;
    @Size(max = 2147483647)
    private String observation;
    @JoinColumn(name = "idcaisse", referencedColumnName = "idcaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Caisse idcaisse;
    @JoinColumn(name = "idcycle", referencedColumnName = "idcycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Cycletontine idcycle;
    @JoinColumn(name = "idrencontre", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre idrencontre;
    @JoinColumn(name = "idrubriquecaisse", referencedColumnName = "idrubriquecaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rubriquecaisse idrubriquecaisse;

    public Depense() {
    }

    public Depense(Integer iddepense) {
        this.iddepense = iddepense;
    }

    public Integer getIddepense() {
        return iddepense;
    }

    public void setIddepense(Integer iddepense) {
        this.iddepense = iddepense;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Double getMontant() {
        return montant;
    }

    public void setMontant(Double montant) {
        this.montant = montant;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public Caisse getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(Caisse idcaisse) {
        this.idcaisse = idcaisse;
    }

    public Cycletontine getIdcycle() {
        return idcycle;
    }

    public void setIdcycle(Cycletontine idcycle) {
        this.idcycle = idcycle;
    }

    public Rencontre getIdrencontre() {
        return idrencontre;
    }

    public void setIdrencontre(Rencontre idrencontre) {
        this.idrencontre = idrencontre;
    }

    public Rubriquecaisse getIdrubriquecaisse() {
        return idrubriquecaisse;
    }

    public void setIdrubriquecaisse(Rubriquecaisse idrubriquecaisse) {
        this.idrubriquecaisse = idrubriquecaisse;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iddepense != null ? iddepense.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Depense)) {
            return false;
        }
        Depense other = (Depense) object;
        if ((this.iddepense == null && other.iddepense != null) || (this.iddepense != null && !this.iddepense.equals(other.iddepense))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Depense[ iddepense=" + iddepense + " ]";
    }
    
}
