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
    @NamedQuery(name = "Beneficiairecotisation.findAll", query = "SELECT b FROM Beneficiairecotisation b"),
    @NamedQuery(name = "Beneficiairecotisation.findByIdbeneficiare", query = "SELECT b FROM Beneficiairecotisation b WHERE b.idbeneficiare = :idbeneficiare"),
    @NamedQuery(name = "Beneficiairecotisation.findByMontantcotisation", query = "SELECT b FROM Beneficiairecotisation b WHERE b.montantcotisation = :montantcotisation"),
    @NamedQuery(name = "Beneficiairecotisation.findByDatecotisation", query = "SELECT b FROM Beneficiairecotisation b WHERE b.datecotisation = :datecotisation"),
    @NamedQuery(name = "Beneficiairecotisation.findByObservation", query = "SELECT b FROM Beneficiairecotisation b WHERE b.observation = :observation")})
public class Beneficiairecotisation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idbeneficiare;
    @Size(max = 254)
    private String montantcotisation;
    @Temporal(TemporalType.DATE)
    private Date datecotisation;
    @Size(max = 254)
    private String observation;
    @JoinColumn(name = "idcycle", referencedColumnName = "idcycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Cycletontine idcycle;
    @JoinColumn(name = "idmembre", referencedColumnName = "idmembre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membre idmembre;
    @JoinColumn(name = "idmois", referencedColumnName = "idmois")
    @ManyToOne(fetch = FetchType.LAZY)
    private Mois idmois;

    public Beneficiairecotisation() {
    }

    public Beneficiairecotisation(Integer idbeneficiare) {
        this.idbeneficiare = idbeneficiare;
    }

    public Integer getIdbeneficiare() {
        return idbeneficiare;
    }

    public void setIdbeneficiare(Integer idbeneficiare) {
        this.idbeneficiare = idbeneficiare;
    }

    public String getMontantcotisation() {
        return montantcotisation;
    }

    public void setMontantcotisation(String montantcotisation) {
        this.montantcotisation = montantcotisation;
    }

    public Date getDatecotisation() {
        return datecotisation;
    }

    public void setDatecotisation(Date datecotisation) {
        this.datecotisation = datecotisation;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public Cycletontine getIdcycle() {
        return idcycle;
    }

    public void setIdcycle(Cycletontine idcycle) {
        this.idcycle = idcycle;
    }

    public Membre getIdmembre() {
        return idmembre;
    }

    public void setIdmembre(Membre idmembre) {
        this.idmembre = idmembre;
    }

    public Mois getIdmois() {
        return idmois;
    }

    public void setIdmois(Mois idmois) {
        this.idmois = idmois;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idbeneficiare != null ? idbeneficiare.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Beneficiairecotisation)) {
            return false;
        }
        Beneficiairecotisation other = (Beneficiairecotisation) object;
        if ((this.idbeneficiare == null && other.idbeneficiare != null) || (this.idbeneficiare != null && !this.idbeneficiare.equals(other.idbeneficiare))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Beneficiairecotisation[ idbeneficiare=" + idbeneficiare + " ]";
    }
    
}
