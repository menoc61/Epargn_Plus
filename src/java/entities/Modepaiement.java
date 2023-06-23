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
    @NamedQuery(name = "Modepaiement.findAll", query = "SELECT m FROM Modepaiement m"),
    @NamedQuery(name = "Modepaiement.findByIdmdepaiement", query = "SELECT m FROM Modepaiement m WHERE m.idmdepaiement = :idmdepaiement"),
    @NamedQuery(name = "Modepaiement.findByNomFr", query = "SELECT m FROM Modepaiement m WHERE m.nomFr = :nomFr"),
    @NamedQuery(name = "Modepaiement.findByNomEn", query = "SELECT m FROM Modepaiement m WHERE m.nomEn = :nomEn")})
public class Modepaiement implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idmdepaiement;
    @Size(max = 254)
    @Column(name = "nom_fr")
    private String nomFr;
    @Size(max = 254)
    @Column(name = "nom_en")
    private String nomEn;
    @OneToMany(mappedBy = "idmdepaiement", fetch = FetchType.LAZY)
    private List<Tontine> tontineList;

    public Modepaiement() {
    }

    public Modepaiement(Integer idmdepaiement) {
        this.idmdepaiement = idmdepaiement;
    }

    public Integer getIdmdepaiement() {
        return idmdepaiement;
    }

    public void setIdmdepaiement(Integer idmdepaiement) {
        this.idmdepaiement = idmdepaiement;
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
        hash += (idmdepaiement != null ? idmdepaiement.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Modepaiement)) {
            return false;
        }
        Modepaiement other = (Modepaiement) object;
        if ((this.idmdepaiement == null && other.idmdepaiement != null) || (this.idmdepaiement != null && !this.idmdepaiement.equals(other.idmdepaiement))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Modepaiement[ idmdepaiement=" + idmdepaiement + " ]";
    }
    
}
