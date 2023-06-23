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
    @NamedQuery(name = "Epargne.findAll", query = "SELECT e FROM Epargne e"),
    @NamedQuery(name = "Epargne.findByIdepargne", query = "SELECT e FROM Epargne e WHERE e.idepargne = :idepargne"),
    @NamedQuery(name = "Epargne.findByDateepargne", query = "SELECT e FROM Epargne e WHERE e.dateepargne = :dateepargne"),
    @NamedQuery(name = "Epargne.findByMontant", query = "SELECT e FROM Epargne e WHERE e.montant = :montant"),
    @NamedQuery(name = "Epargne.findByObservation", query = "SELECT e FROM Epargne e WHERE e.observation = :observation")})
public class Epargne implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idepargne;
    @Temporal(TemporalType.DATE)
    private Date dateepargne;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montant;
    @Size(max = 2147483647)
    private String observation;
    @JoinColumn(name = "idcaisse", referencedColumnName = "idcaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Caisse idcaisse;
    @JoinColumn(name = "idmembrecycle", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle idmembrecycle;
    @JoinColumn(name = "idrencontre", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre idrencontre;

    public Epargne() {
    }

    public Epargne(Integer idepargne) {
        this.idepargne = idepargne;
    }

    public Integer getIdepargne() {
        return idepargne;
    }

    public void setIdepargne(Integer idepargne) {
        this.idepargne = idepargne;
    }

    public Date getDateepargne() {
        return dateepargne;
    }

    public void setDateepargne(Date dateepargne) {
        this.dateepargne = dateepargne;
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
        hash += (idepargne != null ? idepargne.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Epargne)) {
            return false;
        }
        Epargne other = (Epargne) object;
        if ((this.idepargne == null && other.idepargne != null) || (this.idepargne != null && !this.idepargne.equals(other.idepargne))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Epargne[ idepargne=" + idepargne + " ]";
    }
    
}
