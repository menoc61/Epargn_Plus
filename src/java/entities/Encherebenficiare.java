/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Louis Stark
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Encherebenficiare.findAll", query = "SELECT e FROM Encherebenficiare e"),
    @NamedQuery(name = "Encherebenficiare.findByIdenchere", query = "SELECT e FROM Encherebenficiare e WHERE e.idenchere = :idenchere"),
    @NamedQuery(name = "Encherebenficiare.findByMontant", query = "SELECT e FROM Encherebenficiare e WHERE e.montant = :montant"),
    @NamedQuery(name = "Encherebenficiare.findByTermine", query = "SELECT e FROM Encherebenficiare e WHERE e.termine = :termine")})
public class Encherebenficiare implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idenchere;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montant;
    private Boolean termine;
    @JoinColumn(name = "idbeneficiaire", referencedColumnName = "idbeneficiaire")
    @ManyToOne(fetch = FetchType.LAZY)
    private BeneficiaireTontine idbeneficiaire;
    @JoinColumn(name = "idcaisse", referencedColumnName = "idcaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Caisse idcaisse;

    public Encherebenficiare() {
    }

    public Encherebenficiare(Integer idenchere) {
        this.idenchere = idenchere;
    }

    public Integer getIdenchere() {
        return idenchere;
    }

    public void setIdenchere(Integer idenchere) {
        this.idenchere = idenchere;
    }

    public Double getMontant() {
        return montant;
    }

    public void setMontant(Double montant) {
        this.montant = montant;
    }

    public Boolean getTermine() {
        return termine;
    }

    public void setTermine(Boolean termine) {
        this.termine = termine;
    }

    public BeneficiaireTontine getIdbeneficiaire() {
        return idbeneficiaire;
    }

    public void setIdbeneficiaire(BeneficiaireTontine idbeneficiaire) {
        this.idbeneficiaire = idbeneficiaire;
    }

    public Caisse getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(Caisse idcaisse) {
        this.idcaisse = idcaisse;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idenchere != null ? idenchere.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Encherebenficiare)) {
            return false;
        }
        Encherebenficiare other = (Encherebenficiare) object;
        if ((this.idenchere == null && other.idenchere != null) || (this.idenchere != null && !this.idenchere.equals(other.idenchere))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Encherebenficiare[ idenchere=" + idenchere + " ]";
    }
    
}
