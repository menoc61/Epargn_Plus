/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
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
    @NamedQuery(name = "Avalyse.findAll", query = "SELECT a FROM Avalyse a"),
    @NamedQuery(name = "Avalyse.findByIdavalyse", query = "SELECT a FROM Avalyse a WHERE a.idavalyse = :idavalyse"),
    @NamedQuery(name = "Avalyse.findByMontantAvalyse", query = "SELECT a FROM Avalyse a WHERE a.montantAvalyse = :montantAvalyse")})
public class Avalyse implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long idavalyse;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "montant_avalyse")
    private Double montantAvalyse;
    @JoinColumn(name = "idemprunt", referencedColumnName = "idemprunt")
    @ManyToOne(fetch = FetchType.LAZY)
    private Emprunt idemprunt;
    @JoinColumn(name = "membre_avalyste", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle membreAvalyste;

    public Avalyse() {
    }

    public Avalyse(Long idavalyse) {
        this.idavalyse = idavalyse;
    }

    public Long getIdavalyse() {
        return idavalyse;
    }

    public void setIdavalyse(Long idavalyse) {
        this.idavalyse = idavalyse;
    }

    public Double getMontantAvalyse() {
        return montantAvalyse;
    }

    public void setMontantAvalyse(Double montantAvalyse) {
        this.montantAvalyse = montantAvalyse;
    }

    public Emprunt getIdemprunt() {
        return idemprunt;
    }

    public void setIdemprunt(Emprunt idemprunt) {
        this.idemprunt = idemprunt;
    }

    public Membrecycle getMembreAvalyste() {
        return membreAvalyste;
    }

    public void setMembreAvalyste(Membrecycle membreAvalyste) {
        this.membreAvalyste = membreAvalyste;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idavalyse != null ? idavalyse.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Avalyse)) {
            return false;
        }
        Avalyse other = (Avalyse) object;
        if ((this.idavalyse == null && other.idavalyse != null) || (this.idavalyse != null && !this.idavalyse.equals(other.idavalyse))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Avalyse[ idavalyse=" + idavalyse + " ]";
    }
    
}
