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
    @NamedQuery(name = "Amende.findAll", query = "SELECT a FROM Amende a"),
    @NamedQuery(name = "Amende.findByIdamende", query = "SELECT a FROM Amende a WHERE a.idamende = :idamende"),
    @NamedQuery(name = "Amende.findByDateamande", query = "SELECT a FROM Amende a WHERE a.dateamande = :dateamande"),
    @NamedQuery(name = "Amende.findByMontant", query = "SELECT a FROM Amende a WHERE a.montant = :montant"),
    @NamedQuery(name = "Amende.findByObservation", query = "SELECT a FROM Amende a WHERE a.observation = :observation")})
public class Amende implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idamende;
    @Temporal(TemporalType.DATE)
    private Date dateamande;
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

    public Amende() {
    }

    public Amende(Integer idamende) {
        this.idamende = idamende;
    }

    public Integer getIdamende() {
        return idamende;
    }

    public void setIdamende(Integer idamende) {
        this.idamende = idamende;
    }

    public Date getDateamande() {
        return dateamande;
    }

    public void setDateamande(Date dateamande) {
        this.dateamande = dateamande;
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
        hash += (idamende != null ? idamende.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Amende)) {
            return false;
        }
        Amende other = (Amende) object;
        if ((this.idamende == null && other.idamende != null) || (this.idamende != null && !this.idamende.equals(other.idamende))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Amende[ idamende=" + idamende + " ]";
    }
    
}
