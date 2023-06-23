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
    @NamedQuery(name = "Motifaide.findAll", query = "SELECT m FROM Motifaide m"),
    @NamedQuery(name = "Motifaide.findByIdmotifaide", query = "SELECT m FROM Motifaide m WHERE m.idmotifaide = :idmotifaide"),
    @NamedQuery(name = "Motifaide.findByNomfr", query = "SELECT m FROM Motifaide m WHERE m.nomfr = :nomfr"),
    @NamedQuery(name = "Motifaide.findByNomen", query = "SELECT m FROM Motifaide m WHERE m.nomen = :nomen")})
public class Motifaide implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idmotifaide;
    @Size(max = 254)
    private String nomfr;
    @Size(max = 254)
    private String nomen;
    @OneToMany(mappedBy = "idmotifaide", fetch = FetchType.LAZY)
    private List<Aide> aideList;

    public Motifaide() {
    }

    public Motifaide(Integer idmotifaide) {
        this.idmotifaide = idmotifaide;
    }

    public Integer getIdmotifaide() {
        return idmotifaide;
    }

    public void setIdmotifaide(Integer idmotifaide) {
        this.idmotifaide = idmotifaide;
    }

    public String getNomfr() {
        return nomfr;
    }

    public void setNomfr(String nomfr) {
        this.nomfr = nomfr;
    }

    public String getNomen() {
        return nomen;
    }

    public void setNomen(String nomen) {
        this.nomen = nomen;
    }

    @XmlTransient
    public List<Aide> getAideList() {
        return aideList;
    }

    public void setAideList(List<Aide> aideList) {
        this.aideList = aideList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idmotifaide != null ? idmotifaide.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Motifaide)) {
            return false;
        }
        Motifaide other = (Motifaide) object;
        if ((this.idmotifaide == null && other.idmotifaide != null) || (this.idmotifaide != null && !this.idmotifaide.equals(other.idmotifaide))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Motifaide[ idmotifaide=" + idmotifaide + " ]";
    }
    
}
