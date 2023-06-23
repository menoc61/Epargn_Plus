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
    @NamedQuery(name = "Ration.findAll", query = "SELECT r FROM Ration r"),
    @NamedQuery(name = "Ration.findByIdration", query = "SELECT r FROM Ration r WHERE r.idration = :idration"),
    @NamedQuery(name = "Ration.findByDateration", query = "SELECT r FROM Ration r WHERE r.dateration = :dateration"),
    @NamedQuery(name = "Ration.findByMontant", query = "SELECT r FROM Ration r WHERE r.montant = :montant"),
    @NamedQuery(name = "Ration.findByObservation", query = "SELECT r FROM Ration r WHERE r.observation = :observation")})
public class Ration implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idration;
    @Temporal(TemporalType.DATE)
    private Date dateration;
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

    public Ration() {
    }

    public Ration(Integer idration) {
        this.idration = idration;
    }

    public Integer getIdration() {
        return idration;
    }

    public void setIdration(Integer idration) {
        this.idration = idration;
    }

    public Date getDateration() {
        return dateration;
    }

    public void setDateration(Date dateration) {
        this.dateration = dateration;
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
        hash += (idration != null ? idration.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Ration)) {
            return false;
        }
        Ration other = (Ration) object;
        if ((this.idration == null && other.idration != null) || (this.idration != null && !this.idration.equals(other.idration))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Ration[ idration=" + idration + " ]";
    }
    
}
