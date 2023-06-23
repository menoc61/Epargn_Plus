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
    @NamedQuery(name = "Retard.findAll", query = "SELECT r FROM Retard r"),
    @NamedQuery(name = "Retard.findByIdretard", query = "SELECT r FROM Retard r WHERE r.idretard = :idretard"),
    @NamedQuery(name = "Retard.findByDateretard", query = "SELECT r FROM Retard r WHERE r.dateretard = :dateretard"),
    @NamedQuery(name = "Retard.findByMontant", query = "SELECT r FROM Retard r WHERE r.montant = :montant"),
    @NamedQuery(name = "Retard.findByObservation", query = "SELECT r FROM Retard r WHERE r.observation = :observation")})
public class Retard implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idretard;
    @Temporal(TemporalType.DATE)
    private Date dateretard;
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

    public Retard() {
    }

    public Retard(Integer idretard) {
        this.idretard = idretard;
    }

    public Integer getIdretard() {
        return idretard;
    }

    public void setIdretard(Integer idretard) {
        this.idretard = idretard;
    }

    public Date getDateretard() {
        return dateretard;
    }

    public void setDateretard(Date dateretard) {
        this.dateretard = dateretard;
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
        hash += (idretard != null ? idretard.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Retard)) {
            return false;
        }
        Retard other = (Retard) object;
        if ((this.idretard == null && other.idretard != null) || (this.idretard != null && !this.idretard.equals(other.idretard))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Retard[ idretard=" + idretard + " ]";
    }
    
}
