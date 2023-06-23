/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
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
    @NamedQuery(name = "Frequencetontine.findAll", query = "SELECT f FROM Frequencetontine f"),
    @NamedQuery(name = "Frequencetontine.findByIdfreqtontine", query = "SELECT f FROM Frequencetontine f WHERE f.idfreqtontine = :idfreqtontine"),
    @NamedQuery(name = "Frequencetontine.findByNomFr", query = "SELECT f FROM Frequencetontine f WHERE f.nomFr = :nomFr"),
    @NamedQuery(name = "Frequencetontine.findByNomEn", query = "SELECT f FROM Frequencetontine f WHERE f.nomEn = :nomEn")})
public class Frequencetontine implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idfreqtontine;
    @Size(max = 254)
    @Column(name = "nom_fr")
    private String nomFr;
    @Size(max = 254)
    @Column(name = "nom_en")
    private String nomEn;
    @OneToMany(mappedBy = "idfreqtontine", fetch = FetchType.LAZY)
    private List<Tontine> tontineList;

    public Frequencetontine() {
    }

    public Frequencetontine(Integer idfreqtontine) {
        this.idfreqtontine = idfreqtontine;
    }

    public Integer getIdfreqtontine() {
        return idfreqtontine;
    }

    public void setIdfreqtontine(Integer idfreqtontine) {
        this.idfreqtontine = idfreqtontine;
    }

    public String getNomFr() {
        return nomFr;
    }

    public void setNomFr(String nomFr) {
        this.nomFr = nomFr;
    }

    public String getNomEn() {
        return nomEn;
    }

    public void setNomEn(String nomEn) {
        this.nomEn = nomEn;
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
        hash += (idfreqtontine != null ? idfreqtontine.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Frequencetontine)) {
            return false;
        }
        Frequencetontine other = (Frequencetontine) object;
        if ((this.idfreqtontine == null && other.idfreqtontine != null) || (this.idfreqtontine != null && !this.idfreqtontine.equals(other.idfreqtontine))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Frequencetontine[ idfreqtontine=" + idfreqtontine + " ]";
    }
    
}
