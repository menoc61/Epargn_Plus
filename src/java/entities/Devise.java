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
    @NamedQuery(name = "Devise.findAll", query = "SELECT d FROM Devise d"),
    @NamedQuery(name = "Devise.findByIddevices", query = "SELECT d FROM Devise d WHERE d.iddevices = :iddevices"),
    @NamedQuery(name = "Devise.findByNomFr", query = "SELECT d FROM Devise d WHERE d.nomFr = :nomFr"),
    @NamedQuery(name = "Devise.findByNomEn", query = "SELECT d FROM Devise d WHERE d.nomEn = :nomEn")})
public class Devise implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer iddevices;
    @Size(max = 254)
    @Column(name = "nom_fr")
    private String nomFr;
    @Size(max = 2147483647)
    @Column(name = "nom_en")
    private String nomEn;
    @OneToMany(mappedBy = "iddevices", fetch = FetchType.LAZY)
    private List<Tontine> tontineList;

    public Devise() {
    }

    public Devise(Integer iddevices) {
        this.iddevices = iddevices;
    }

    public Integer getIddevices() {
        return iddevices;
    }

    public void setIddevices(Integer iddevices) {
        this.iddevices = iddevices;
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
        hash += (iddevices != null ? iddevices.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Devise)) {
            return false;
        }
        Devise other = (Devise) object;
        if ((this.iddevices == null && other.iddevices != null) || (this.iddevices != null && !this.iddevices.equals(other.iddevices))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Devise[ iddevices=" + iddevices + " ]";
    }
    
}
