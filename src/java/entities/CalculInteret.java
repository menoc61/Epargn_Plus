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
@Table(name = "calcul_interet")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CalculInteret.findAll", query = "SELECT c FROM CalculInteret c"),
    @NamedQuery(name = "CalculInteret.findById", query = "SELECT c FROM CalculInteret c WHERE c.id = :id"),
    @NamedQuery(name = "CalculInteret.findByMontantInitialEmprunt", query = "SELECT c FROM CalculInteret c WHERE c.montantInitialEmprunt = :montantInitialEmprunt"),
    @NamedQuery(name = "CalculInteret.findByMontantInteret", query = "SELECT c FROM CalculInteret c WHERE c.montantInteret = :montantInteret"),
    @NamedQuery(name = "CalculInteret.findByResteCapital", query = "SELECT c FROM CalculInteret c WHERE c.resteCapital = :resteCapital")})
public class CalculInteret implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long id;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "montant_initial_emprunt")
    private Double montantInitialEmprunt;
    @Column(name = "montant_interet")
    private Double montantInteret;
    @Column(name = "reste_capital")
    private Double resteCapital;
    @OneToMany(mappedBy = "idCalculInteret", fetch = FetchType.LAZY)
    private List<EncoursEmprunt> encoursEmpruntList;
    @JoinColumn(name = "idmembre", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle idmembre;
    @JoinColumn(name = "idrencontre", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre idrencontre;

    public CalculInteret() {
    }

    public CalculInteret(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getMontantInitialEmprunt() {
        return montantInitialEmprunt;
    }

    public void setMontantInitialEmprunt(Double montantInitialEmprunt) {
        this.montantInitialEmprunt = montantInitialEmprunt;
    }

    public Double getMontantInteret() {
        return montantInteret;
    }

    public void setMontantInteret(Double montantInteret) {
        this.montantInteret = montantInteret;
    }

    public Double getResteCapital() {
        return resteCapital;
    }

    public void setResteCapital(Double resteCapital) {
        this.resteCapital = resteCapital;
    }

    @XmlTransient
    public List<EncoursEmprunt> getEncoursEmpruntList() {
        return encoursEmpruntList;
    }

    public void setEncoursEmpruntList(List<EncoursEmprunt> encoursEmpruntList) {
        this.encoursEmpruntList = encoursEmpruntList;
    }

    public Membrecycle getIdmembre() {
        return idmembre;
    }

    public void setIdmembre(Membrecycle idmembre) {
        this.idmembre = idmembre;
    }

    public Rencontre getIdrencontre() {
        return idrencontre;
    }

    public void setIdrencontre(Rencontre idrencontre) {
        this.idrencontre = idrencontre;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CalculInteret)) {
            return false;
        }
        CalculInteret other = (CalculInteret) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.CalculInteret[ id=" + id + " ]";
    }
    
}
