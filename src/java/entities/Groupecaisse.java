/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
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
    @NamedQuery(name = "Groupecaisse.findAll", query = "SELECT g FROM Groupecaisse g"),
    @NamedQuery(name = "Groupecaisse.findByIdgroupecaisse", query = "SELECT g FROM Groupecaisse g WHERE g.idgroupecaisse = :idgroupecaisse"),
    @NamedQuery(name = "Groupecaisse.findByNomfr", query = "SELECT g FROM Groupecaisse g WHERE g.nomfr = :nomfr"),
    @NamedQuery(name = "Groupecaisse.findByNomen", query = "SELECT g FROM Groupecaisse g WHERE g.nomen = :nomen")})
public class Groupecaisse implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idgroupecaisse;
    @Size(max = 2147483647)
    private String nomfr;
    @Size(max = 2147483647)
    private String nomen;

    public Groupecaisse() {
    }

    public Groupecaisse(Integer idgroupecaisse) {
        this.idgroupecaisse = idgroupecaisse;
    }

    public Integer getIdgroupecaisse() {
        return idgroupecaisse;
    }

    public void setIdgroupecaisse(Integer idgroupecaisse) {
        this.idgroupecaisse = idgroupecaisse;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idgroupecaisse != null ? idgroupecaisse.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Groupecaisse)) {
            return false;
        }
        Groupecaisse other = (Groupecaisse) object;
        if ((this.idgroupecaisse == null && other.idgroupecaisse != null) || (this.idgroupecaisse != null && !this.idgroupecaisse.equals(other.idgroupecaisse))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Groupecaisse[ idgroupecaisse=" + idgroupecaisse + " ]";
    }
    
}
