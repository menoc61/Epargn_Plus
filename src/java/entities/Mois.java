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
    @NamedQuery(name = "Mois.findAll", query = "SELECT m FROM Mois m"),
    @NamedQuery(name = "Mois.findByIdmois", query = "SELECT m FROM Mois m WHERE m.idmois = :idmois"),
    @NamedQuery(name = "Mois.findByNomFr", query = "SELECT m FROM Mois m WHERE m.nomFr = :nomFr"),
    @NamedQuery(name = "Mois.findByNomEn", query = "SELECT m FROM Mois m WHERE m.nomEn = :nomEn")})
public class Mois implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idmois;
    @Size(max = 254)
    @Column(name = "nom_fr")
    private String nomFr;
    @Size(max = 254)
    @Column(name = "nom_en")
    private String nomEn;
    @OneToMany(mappedBy = "idmois", fetch = FetchType.LAZY)
    private List<Operationcaisse> operationcaisseList;
    @OneToMany(mappedBy = "idmois", fetch = FetchType.LAZY)
    private List<Beneficiairecotisation> beneficiairecotisationList;

    public Mois() {
    }

    public Mois(Integer idmois) {
        this.idmois = idmois;
    }

    public Integer getIdmois() {
        return idmois;
    }

    public void setIdmois(Integer idmois) {
        this.idmois = idmois;
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
    public List<Operationcaisse> getOperationcaisseList() {
        return operationcaisseList;
    }

    public void setOperationcaisseList(List<Operationcaisse> operationcaisseList) {
        this.operationcaisseList = operationcaisseList;
    }

    @XmlTransient
    public List<Beneficiairecotisation> getBeneficiairecotisationList() {
        return beneficiairecotisationList;
    }

    public void setBeneficiairecotisationList(List<Beneficiairecotisation> beneficiairecotisationList) {
        this.beneficiairecotisationList = beneficiairecotisationList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idmois != null ? idmois.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Mois)) {
            return false;
        }
        Mois other = (Mois) object;
        if ((this.idmois == null && other.idmois != null) || (this.idmois != null && !this.idmois.equals(other.idmois))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Mois[ idmois=" + idmois + " ]";
    }
    
}
