/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Louis Stark
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Tranchecotisation.findAll", query = "SELECT t FROM Tranchecotisation t"),
    @NamedQuery(name = "Tranchecotisation.findByIdtranche", query = "SELECT t FROM Tranchecotisation t WHERE t.idtranche = :idtranche"),
    @NamedQuery(name = "Tranchecotisation.findByMontant", query = "SELECT t FROM Tranchecotisation t WHERE t.montant = :montant")})
public class Tranchecotisation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idtranche;
    @Size(max = 254)
    private String montant;
    @OneToMany(mappedBy = "idtranchecotisation", fetch = FetchType.LAZY)
    private List<Tontine> tontineList;

    public Tranchecotisation() {
    }

    public Tranchecotisation(Integer idtranche) {
        this.idtranche = idtranche;
    }

    public Integer getIdtranche() {
        return idtranche;
    }

    public void setIdtranche(Integer idtranche) {
        this.idtranche = idtranche;
    }

    public String getMontant() {
        return montant;
    }

    public void setMontant(String montant) {
        this.montant = montant;
    }

    @XmlTransient
    public List<Tontine> getTontineList() {
        return tontineList;
    }

    public void setTontineList(List<Tontine> tontineList) {
        this.tontineList = tontineList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idtranche != null ? idtranche.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tranchecotisation)) {
            return false;
        }
        Tranchecotisation other = (Tranchecotisation) object;
        if ((this.idtranche == null && other.idtranche != null) || (this.idtranche != null && !this.idtranche.equals(other.idtranche))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Tranchecotisation[ idtranche=" + idtranche + " ]";
    }
    
}
