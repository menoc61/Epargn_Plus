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
    @NamedQuery(name = "Mains.findAll", query = "SELECT m FROM Mains m"),
    @NamedQuery(name = "Mains.findByIdmain", query = "SELECT m FROM Mains m WHERE m.idmain = :idmain"),
    @NamedQuery(name = "Mains.findByCodemain", query = "SELECT m FROM Mains m WHERE m.codemain = :codemain"),
    @NamedQuery(name = "Mains.findByNom", query = "SELECT m FROM Mains m WHERE m.nom = :nom"),
    @NamedQuery(name = "Mains.findByNbretourspasse", query = "SELECT m FROM Mains m WHERE m.nbretourspasse = :nbretourspasse"),
    @NamedQuery(name = "Mains.findByNumeroordre", query = "SELECT m FROM Mains m WHERE m.numeroordre = :numeroordre"),
    @NamedQuery(name = "Mains.findByMontantsouscrit", query = "SELECT m FROM Mains m WHERE m.montantsouscrit = :montantsouscrit"),
    @NamedQuery(name = "Mains.findByEchec", query = "SELECT m FROM Mains m WHERE m.echec = :echec")})
public class Mains implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idmain;
    @Size(max = 254)
    private String codemain;
    @Size(max = 254)
    private String nom;
    private Integer nbretourspasse;
    private Integer numeroordre;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montantsouscrit;
    private Boolean echec;
    @OneToMany(mappedBy = "idmain", fetch = FetchType.LAZY)
    private List<CotisationTontine> cotisationTontineList;
    @OneToMany(mappedBy = "idmain", fetch = FetchType.LAZY)
    private List<BeneficiaireTontine> beneficiaireTontineList;
    @OneToMany(mappedBy = "idmain", fetch = FetchType.LAZY)
    private List<Cassationtontine> cassationtontineList;
    @JoinColumn(name = "idinscription", referencedColumnName = "idinscription")
    @ManyToOne(fetch = FetchType.LAZY)
    private InscriptionCotisation idinscription;

    public Mains() {
    }

    public Mains(Integer idmain) {
        this.idmain = idmain;
    }

    public Integer getIdmain() {
        return idmain;
    }

    public void setIdmain(Integer idmain) {
        this.idmain = idmain;
    }

    public String getCodemain() {
        return codemain;
    }

    public void setCodemain(String codemain) {
        this.codemain = codemain;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Integer getNbretourspasse() {
        return nbretourspasse;
    }

    public void setNbretourspasse(Integer nbretourspasse) {
        this.nbretourspasse = nbretourspasse;
    }

    public Integer getNumeroordre() {
        return numeroordre;
    }

    public void setNumeroordre(Integer numeroordre) {
        this.numeroordre = numeroordre;
    }

    public Double getMontantsouscrit() {
        return montantsouscrit;
    }

    public void setMontantsouscrit(Double montantsouscrit) {
        this.montantsouscrit = montantsouscrit;
    }

    public Boolean getEchec() {
        return echec;
    }

    public void setEchec(Boolean echec) {
        this.echec = echec;
    }

    @XmlTransient
    public List<CotisationTontine> getCotisationTontineList() {
        return cotisationTontineList;
    }

    public void setCotisationTontineList(List<CotisationTontine> cotisationTontineList) {
        this.cotisationTontineList = cotisationTontineList;
    }

    @XmlTransient
    public List<BeneficiaireTontine> getBeneficiaireTontineList() {
        return beneficiaireTontineList;
    }

    public void setBeneficiaireTontineList(List<BeneficiaireTontine> beneficiaireTontineList) {
        this.beneficiaireTontineList = beneficiaireTontineList;
    }

    @XmlTransient
    public List<Cassationtontine> getCassationtontineList() {
        return cassationtontineList;
    }

    public void setCassationtontineList(List<Cassationtontine> cassationtontineList) {
        this.cassationtontineList = cassationtontineList;
    }

    public InscriptionCotisation getIdinscription() {
        return idinscription;
    }

    public void setIdinscription(InscriptionCotisation idinscription) {
        this.idinscription = idinscription;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idmain != null ? idmain.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Mains)) {
            return false;
        }
        Mains other = (Mains) object;
        if ((this.idmain == null && other.idmain != null) || (this.idmain != null && !this.idmain.equals(other.idmain))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Mains[ idmain=" + idmain + " ]";
    }
    
}
