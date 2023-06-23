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
    @NamedQuery(name = "Secours.findAll", query = "SELECT s FROM Secours s"),
    @NamedQuery(name = "Secours.findByIdsecours", query = "SELECT s FROM Secours s WHERE s.idsecours = :idsecours"),
    @NamedQuery(name = "Secours.findByDate", query = "SELECT s FROM Secours s WHERE s.date = :date"),
    @NamedQuery(name = "Secours.findByMontant", query = "SELECT s FROM Secours s WHERE s.montant = :montant"),
    @NamedQuery(name = "Secours.findByObservation", query = "SELECT s FROM Secours s WHERE s.observation = :observation")})
public class Secours implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idsecours;
    @Temporal(TemporalType.DATE)
    private Date date;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montant;
    @Size(max = 2147483647)
    private String observation;
    @JoinColumn(name = "idmembrecycle", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle idmembrecycle;
    @JoinColumn(name = "idrencontre", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre idrencontre;

    public Secours() {
    }

    public Secours(Integer idsecours) {
        this.idsecours = idsecours;
    }

    public Integer getIdsecours() {
        return idsecours;
    }

    public void setIdsecours(Integer idsecours) {
        this.idsecours = idsecours;
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

    public Membrecycle getIdmembrecycle() {
        return idmembrecycle;
    }

    public void setIdmembrecycle(Membrecycle idmembrecycle) {
        this.idmembrecycle = idmembrecycle;
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
        hash += (idsecours != null ? idsecours.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Secours)) {
            return false;
        }
        Secours other = (Secours) object;
        if ((this.idsecours == null && other.idsecours != null) || (this.idsecours != null && !this.idsecours.equals(other.idsecours))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Secours[ idsecours=" + idsecours + " ]";
    }
    
}
