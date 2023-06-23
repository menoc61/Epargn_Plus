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
@Table(name = "aide_membre")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AideMembre.findAll", query = "SELECT a FROM AideMembre a"),
    @NamedQuery(name = "AideMembre.findById", query = "SELECT a FROM AideMembre a WHERE a.id = :id"),
    @NamedQuery(name = "AideMembre.findByMontant", query = "SELECT a FROM AideMembre a WHERE a.montant = :montant"),
    @NamedQuery(name = "AideMembre.findByMontantMainLevee", query = "SELECT a FROM AideMembre a WHERE a.montantMainLevee = :montantMainLevee")})
public class AideMembre implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long id;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montant;
    @Column(name = "montant_main_levee")
    private Double montantMainLevee;
    @JoinColumn(name = "idaide", referencedColumnName = "idaide")
    @ManyToOne(fetch = FetchType.LAZY)
    private Aide idaide;
    @JoinColumn(name = "idmembre", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle idmembre;

    public AideMembre() {
    }

    public AideMembre(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getMontant() {
        return montant;
    }

    public void setMontant(Double montant) {
        this.montant = montant;
    }

    public Double getMontantMainLevee() {
        return montantMainLevee;
    }

    public void setMontantMainLevee(Double montantMainLevee) {
        this.montantMainLevee = montantMainLevee;
    }

    public Aide getIdaide() {
        return idaide;
    }

    public void setIdaide(Aide idaide) {
        this.idaide = idaide;
    }

    public Membrecycle getIdmembre() {
        return idmembre;
    }

    public void setIdmembre(Membrecycle idmembre) {
        this.idmembre = idmembre;
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
        if (!(object instanceof AideMembre)) {
            return false;
        }
        AideMembre other = (AideMembre) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.AideMembre[ id=" + id + " ]";
    }
    
}
