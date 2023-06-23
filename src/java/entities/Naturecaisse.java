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
    @NamedQuery(name = "Naturecaisse.findAll", query = "SELECT n FROM Naturecaisse n"),
    @NamedQuery(name = "Naturecaisse.findByIdnaturecaisse", query = "SELECT n FROM Naturecaisse n WHERE n.idnaturecaisse = :idnaturecaisse"),
    @NamedQuery(name = "Naturecaisse.findByNomfr", query = "SELECT n FROM Naturecaisse n WHERE n.nomfr = :nomfr"),
    @NamedQuery(name = "Naturecaisse.findByNomen", query = "SELECT n FROM Naturecaisse n WHERE n.nomen = :nomen")})
public class Naturecaisse implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idnaturecaisse;
    @Size(max = 2147483647)
    private String nomfr;
    @Size(max = 2147483647)
    private String nomen;
    @OneToMany(mappedBy = "idnaturecaisse", fetch = FetchType.LAZY)
    private List<Rubriquecaisse> rubriquecaisseList;

    public Naturecaisse() {
    }

    public Naturecaisse(Integer idnaturecaisse) {
        this.idnaturecaisse = idnaturecaisse;
    }

    public Integer getIdnaturecaisse() {
        return idnaturecaisse;
    }

    public void setIdnaturecaisse(Integer idnaturecaisse) {
        this.idnaturecaisse = idnaturecaisse;
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
    public List<Rubriquecaisse> getRubriquecaisseList() {
        return rubriquecaisseList;
    }

    public void setRubriquecaisseList(List<Rubriquecaisse> rubriquecaisseList) {
        this.rubriquecaisseList = rubriquecaisseList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idnaturecaisse != null ? idnaturecaisse.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Naturecaisse)) {
            return false;
        }
        Naturecaisse other = (Naturecaisse) object;
        if ((this.idnaturecaisse == null && other.idnaturecaisse != null) || (this.idnaturecaisse != null && !this.idnaturecaisse.equals(other.idnaturecaisse))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Naturecaisse[ idnaturecaisse=" + idnaturecaisse + " ]";
    }
    
}
