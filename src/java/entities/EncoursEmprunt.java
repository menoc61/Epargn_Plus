/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Louis Stark
 */
@Entity
@Table(name = "encours_emprunt")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "EncoursEmprunt.findAll", query = "SELECT e FROM EncoursEmprunt e"),
    @NamedQuery(name = "EncoursEmprunt.findByIdEncoursEmprunt", query = "SELECT e FROM EncoursEmprunt e WHERE e.idEncoursEmprunt = :idEncoursEmprunt"),
    @NamedQuery(name = "EncoursEmprunt.findBySoldeCapital", query = "SELECT e FROM EncoursEmprunt e WHERE e.soldeCapital = :soldeCapital"),
    @NamedQuery(name = "EncoursEmprunt.findBySoldeInteret", query = "SELECT e FROM EncoursEmprunt e WHERE e.soldeInteret = :soldeInteret"),
    @NamedQuery(name = "EncoursEmprunt.findByCapitalRembourse", query = "SELECT e FROM EncoursEmprunt e WHERE e.capitalRembourse = :capitalRembourse"),
    @NamedQuery(name = "EncoursEmprunt.findByInteretRembourse", query = "SELECT e FROM EncoursEmprunt e WHERE e.interetRembourse = :interetRembourse"),
    @NamedQuery(name = "EncoursEmprunt.findByTotal", query = "SELECT e FROM EncoursEmprunt e WHERE e.total = :total")})
public class EncoursEmprunt implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_encours_emprunt")
    private Long idEncoursEmprunt;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "solde_capital")
    private Double soldeCapital;
    @Column(name = "solde_interet")
    private Double soldeInteret;
    @Column(name = "capital_rembourse")
    private Double capitalRembourse;
    @Column(name = "interet_rembourse")
    private Double interetRembourse;
    private Double total;
    @JoinColumn(name = "id_calcul_interet", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private CalculInteret idCalculInteret;

    public EncoursEmprunt() {
    }

    public EncoursEmprunt(Long idEncoursEmprunt) {
        this.idEncoursEmprunt = idEncoursEmprunt;
    }

    public Long getIdEncoursEmprunt() {
        return idEncoursEmprunt;
    }

    public void setIdEncoursEmprunt(Long idEncoursEmprunt) {
        this.idEncoursEmprunt = idEncoursEmprunt;
    }

    public Double getSoldeCapital() {
        return soldeCapital;
    }

    public void setSoldeCapital(Double soldeCapital) {
        this.soldeCapital = soldeCapital;
    }

    public Double getSoldeInteret() {
        return soldeInteret;
    }

    public void setSoldeInteret(Double soldeInteret) {
        this.soldeInteret = soldeInteret;
    }

    public Double getCapitalRembourse() {
        return capitalRembourse;
    }

    public void setCapitalRembourse(Double capitalRembourse) {
        this.capitalRembourse = capitalRembourse;
    }

    public Double getInteretRembourse() {
        return interetRembourse;
    }

    public void setInteretRembourse(Double interetRembourse) {
        this.interetRembourse = interetRembourse;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public CalculInteret getIdCalculInteret() {
        return idCalculInteret;
    }

    public void setIdCalculInteret(CalculInteret idCalculInteret) {
        this.idCalculInteret = idCalculInteret;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idEncoursEmprunt != null ? idEncoursEmprunt.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof EncoursEmprunt)) {
            return false;
        }
        EncoursEmprunt other = (EncoursEmprunt) object;
        if ((this.idEncoursEmprunt == null && other.idEncoursEmprunt != null) || (this.idEncoursEmprunt != null && !this.idEncoursEmprunt.equals(other.idEncoursEmprunt))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.EncoursEmprunt[ idEncoursEmprunt=" + idEncoursEmprunt + " ]";
    }
    
}
