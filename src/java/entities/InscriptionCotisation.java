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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Louis Stark
 */
@Entity
@Table(name = "inscription_cotisation")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "InscriptionCotisation.findAll", query = "SELECT i FROM InscriptionCotisation i"),
    @NamedQuery(name = "InscriptionCotisation.findByIdinscription", query = "SELECT i FROM InscriptionCotisation i WHERE i.idinscription = :idinscription"),
    @NamedQuery(name = "InscriptionCotisation.findByEtat", query = "SELECT i FROM InscriptionCotisation i WHERE i.etat = :etat")})
public class InscriptionCotisation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long idinscription;
    private Boolean etat;
    @JoinColumn(name = "idcotisation", referencedColumnName = "idcotisation")
    @ManyToOne(fetch = FetchType.LAZY)
    private Cotisation idcotisation;
    @JoinColumn(name = "idmembre", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle idmembre;
    @OneToMany(mappedBy = "idinscription", fetch = FetchType.LAZY)
    private List<RedevanceCotisation> redevanceCotisationList;
    @OneToMany(mappedBy = "idinscription", fetch = FetchType.LAZY)
    private List<Mains> mainsList;

    public InscriptionCotisation() {
    }

    public InscriptionCotisation(Long idinscription) {
        this.idinscription = idinscription;
    }

    public Long getIdinscription() {
        return idinscription;
    }

    public void setIdinscription(Long idinscription) {
        this.idinscription = idinscription;
    }

    public Boolean getEtat() {
        return etat;
    }

    public void setEtat(Boolean etat) {
        this.etat = etat;
    }

    public Cotisation getIdcotisation() {
        return idcotisation;
    }

    public void setIdcotisation(Cotisation idcotisation) {
        this.idcotisation = idcotisation;
    }

    public Membrecycle getIdmembre() {
        return idmembre;
    }

    public void setIdmembre(Membrecycle idmembre) {
        this.idmembre = idmembre;
    }

    @XmlTransient
    public List<RedevanceCotisation> getRedevanceCotisationList() {
        return redevanceCotisationList;
    }

    public void setRedevanceCotisationList(List<RedevanceCotisation> redevanceCotisationList) {
        this.redevanceCotisationList = redevanceCotisationList;
    }

    @XmlTransient
    public List<Mains> getMainsList() {
        return mainsList;
    }

    public void setMainsList(List<Mains> mainsList) {
        this.mainsList = mainsList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idinscription != null ? idinscription.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof InscriptionCotisation)) {
            return false;
        }
        InscriptionCotisation other = (InscriptionCotisation) object;
        if ((this.idinscription == null && other.idinscription != null) || (this.idinscription != null && !this.idinscription.equals(other.idinscription))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.InscriptionCotisation[ idinscription=" + idinscription + " ]";
    }
    
}
