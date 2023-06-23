/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Louis Stark
 */
@Entity
@Table(name = "payement_sanction")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PayementSanction.findAll", query = "SELECT p FROM PayementSanction p"),
    @NamedQuery(name = "PayementSanction.findById", query = "SELECT p FROM PayementSanction p WHERE p.id = :id"),
    @NamedQuery(name = "PayementSanction.findByMontant", query = "SELECT p FROM PayementSanction p WHERE p.montant = :montant"),
    @NamedQuery(name = "PayementSanction.findByObservation", query = "SELECT p FROM PayementSanction p WHERE p.observation = :observation")})
public class PayementSanction implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long id;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montant;
    @Size(max = 2147483647)
    private String observation;
    @JoinColumn(name = "idcaisse", referencedColumnName = "idcaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Caisse idcaisse;
    @JoinColumn(name = "idpresence", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private FichePresence idpresence;
    @JoinColumn(name = "idrencontre", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre idrencontre;

    public PayementSanction() {
    }

    public PayementSanction(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public FichePresence getIdpresence() {
        return idpresence;
    }

    public void setIdpresence(FichePresence idpresence) {
        this.idpresence = idpresence;
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
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PayementSanction)) {
            return false;
        }
        PayementSanction other = (PayementSanction) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.PayementSanction[ id=" + id + " ]";
    }
    
}
