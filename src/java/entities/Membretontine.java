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
    @NamedQuery(name = "Membretontine.findAll", query = "SELECT m FROM Membretontine m"),
    @NamedQuery(name = "Membretontine.findByIdmembretontine", query = "SELECT m FROM Membretontine m WHERE m.idmembretontine = :idmembretontine"),
    @NamedQuery(name = "Membretontine.findByEtat", query = "SELECT m FROM Membretontine m WHERE m.etat = :etat")})
public class Membretontine implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idmembretontine;
    private Boolean etat;
    @JoinColumn(name = "idmembre", referencedColumnName = "idmembre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membre idmembre;
    @JoinColumn(name = "idtontine", referencedColumnName = "idtontine")
    @ManyToOne(fetch = FetchType.LAZY)
    private Tontine idtontine;

    public Membretontine() {
    }

    public Membretontine(Integer idmembretontine) {
        this.idmembretontine = idmembretontine;
    }

    public Integer getIdmembretontine() {
        return idmembretontine;
    }

    public void setIdmembretontine(Integer idmembretontine) {
        this.idmembretontine = idmembretontine;
    }

    public Boolean getEtat() {
        return etat;
    }

    public void setEtat(Boolean etat) {
        this.etat = etat;
    }

    public Membre getIdmembre() {
        return idmembre;
    }

    public void setIdmembre(Membre idmembre) {
        this.idmembre = idmembre;
    }

    public Tontine getIdtontine() {
        return idtontine;
    }

    public void setIdtontine(Tontine idtontine) {
        this.idtontine = idtontine;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idmembretontine != null ? idmembretontine.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Membretontine)) {
            return false;
        }
        Membretontine other = (Membretontine) object;
        if ((this.idmembretontine == null && other.idmembretontine != null) || (this.idmembretontine != null && !this.idmembretontine.equals(other.idmembretontine))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Membretontine[ idmembretontine=" + idmembretontine + " ]";
    }
    
}
