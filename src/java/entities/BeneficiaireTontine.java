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
@Table(name = "beneficiaire_tontine")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "BeneficiaireTontine.findAll", query = "SELECT b FROM BeneficiaireTontine b"),
    @NamedQuery(name = "BeneficiaireTontine.findByIdbeneficiaire", query = "SELECT b FROM BeneficiaireTontine b WHERE b.idbeneficiaire = :idbeneficiaire"),
    @NamedQuery(name = "BeneficiaireTontine.findByMontant", query = "SELECT b FROM BeneficiaireTontine b WHERE b.montant = :montant"),
    @NamedQuery(name = "BeneficiaireTontine.findByNumeroOrdre", query = "SELECT b FROM BeneficiaireTontine b WHERE b.numeroOrdre = :numeroOrdre"),
    @NamedQuery(name = "BeneficiaireTontine.findByReste", query = "SELECT b FROM BeneficiaireTontine b WHERE b.reste = :reste")})
public class BeneficiaireTontine implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long idbeneficiaire;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montant;
    @Column(name = "numero_ordre")
    private Integer numeroOrdre;
    private Double reste;
    @JoinColumn(name = "idcaisse", referencedColumnName = "idcaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Caisse idcaisse;
    @JoinColumn(name = "idmain", referencedColumnName = "idmain")
    @ManyToOne(fetch = FetchType.LAZY)
    private Mains idmain;
    @JoinColumn(name = "idtontiner", referencedColumnName = "idtontiner")
    @ManyToOne(fetch = FetchType.LAZY)
    private Tontiner idtontiner;
    @OneToMany(mappedBy = "idbeneficiaire", fetch = FetchType.LAZY)
    private List<Encherebenficiare> encherebenficiareList;

    public BeneficiaireTontine() {
    }

    public BeneficiaireTontine(Long idbeneficiaire) {
        this.idbeneficiaire = idbeneficiaire;
    }

    public Long getIdbeneficiaire() {
        return idbeneficiaire;
    }

    public void setIdbeneficiaire(Long idbeneficiaire) {
        this.idbeneficiaire = idbeneficiaire;
    }

    public Double getMontant() {
        return montant;
    }

    public void setMontant(Double montant) {
        this.montant = montant;
    }

    public Integer getNumeroOrdre() {
        return numeroOrdre;
    }

    public void setNumeroOrdre(Integer numeroOrdre) {
        this.numeroOrdre = numeroOrdre;
    }

    public Double getReste() {
        return reste;
    }

    public void setReste(Double reste) {
        this.reste = reste;
    }

    public Caisse getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(Caisse idcaisse) {
        this.idcaisse = idcaisse;
    }

    public Mains getIdmain() {
        return idmain;
    }

    public void setIdmain(Mains idmain) {
        this.idmain = idmain;
    }

    public Tontiner getIdtontiner() {
        return idtontiner;
    }

    public void setIdtontiner(Tontiner idtontiner) {
        this.idtontiner = idtontiner;
    }

    @XmlTransient
    public List<Encherebenficiare> getEncherebenficiareList() {
        return encherebenficiareList;
    }

    public void setEncherebenficiareList(List<Encherebenficiare> encherebenficiareList) {
        this.encherebenficiareList = encherebenficiareList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idbeneficiaire != null ? idbeneficiaire.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof BeneficiaireTontine)) {
            return false;
        }
        BeneficiaireTontine other = (BeneficiaireTontine) object;
        if ((this.idbeneficiaire == null && other.idbeneficiaire != null) || (this.idbeneficiaire != null && !this.idbeneficiaire.equals(other.idbeneficiaire))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.BeneficiaireTontine[ idbeneficiaire=" + idbeneficiaire + " ]";
    }
    
}
