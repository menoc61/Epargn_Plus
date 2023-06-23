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
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Louis Stark
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Cassationtontine.findAll", query = "SELECT c FROM Cassationtontine c"),
    @NamedQuery(name = "Cassationtontine.findByIdcassation", query = "SELECT c FROM Cassationtontine c WHERE c.idcassation = :idcassation"),
    @NamedQuery(name = "Cassationtontine.findByMontant", query = "SELECT c FROM Cassationtontine c WHERE c.montant = :montant")})
public class Cassationtontine implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idcassation;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montant;
    @JoinColumn(name = "idcaisse", referencedColumnName = "idcaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Caisse idcaisse;
    @JoinColumn(name = "idmain", referencedColumnName = "idmain")
    @ManyToOne(fetch = FetchType.LAZY)
    private Mains idmain;

    public Cassationtontine() {
    }

    public Cassationtontine(Integer idcassation) {
        this.idcassation = idcassation;
    }

    public Integer getIdcassation() {
        return idcassation;
    }

    public void setIdcassation(Integer idcassation) {
        this.idcassation = idcassation;
    }

    public Double getMontant() {
        return montant;
    }

    public void setMontant(Double montant) {
        this.montant = montant;
    }

    public Caisse getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(Caisse idcaisse) {
        this.idcaisse = idcaisse;
    }

    public Mains getIdmain() {
        return idmain;
    }

    public void setIdmain(Mains idmain) {
        this.idmain = idmain;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idcassation != null ? idcassation.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Cassationtontine)) {
            return false;
        }
        Cassationtontine other = (Cassationtontine) object;
        if ((this.idcassation == null && other.idcassation != null) || (this.idcassation != null && !this.idcassation.equals(other.idcassation))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Cassationtontine[ idcassation=" + idcassation + " ]";
    }
    
}
