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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Louis Stark
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Aidecotisation.findAll", query = "SELECT a FROM Aidecotisation a"),
    @NamedQuery(name = "Aidecotisation.findByIdaidecotisation", query = "SELECT a FROM Aidecotisation a WHERE a.idaidecotisation = :idaidecotisation"),
    @NamedQuery(name = "Aidecotisation.findByNomaide", query = "SELECT a FROM Aidecotisation a WHERE a.nomaide = :nomaide"),
    @NamedQuery(name = "Aidecotisation.findByMontant", query = "SELECT a FROM Aidecotisation a WHERE a.montant = :montant"),
    @NamedQuery(name = "Aidecotisation.findByEtat", query = "SELECT a FROM Aidecotisation a WHERE a.etat = :etat"),
    @NamedQuery(name = "Aidecotisation.findByInteret", query = "SELECT a FROM Aidecotisation a WHERE a.interet = :interet")})
public class Aidecotisation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idaidecotisation;
    @Size(max = 254)
    private String nomaide;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montant;
    private Boolean etat;
    private Double interet;
    @JoinColumn(name = "idcaisse", referencedColumnName = "idcaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Caisse idcaisse;
    @JoinColumn(name = "idcotisationtontine", referencedColumnName = "idcotisationtontine")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private CotisationTontine idcotisationtontine;
    @JoinColumn(name = "idmembrecycle", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle idmembrecycle;

    public Aidecotisation() {
    }

    public Aidecotisation(Integer idaidecotisation) {
        this.idaidecotisation = idaidecotisation;
    }

    public Integer getIdaidecotisation() {
        return idaidecotisation;
    }

    public void setIdaidecotisation(Integer idaidecotisation) {
        this.idaidecotisation = idaidecotisation;
    }

    public String getNomaide() {
        return nomaide;
    }

    public void setNomaide(String nomaide) {
        this.nomaide = nomaide;
    }

    public Double getMontant() {
        return montant;
    }

    public void setMontant(Double montant) {
        this.montant = montant;
    }

    public Boolean getEtat() {
        return etat;
    }

    public void setEtat(Boolean etat) {
        this.etat = etat;
    }

    public Double getInteret() {
        return interet;
    }

    public void setInteret(Double interet) {
        this.interet = interet;
    }

    public Caisse getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(Caisse idcaisse) {
        this.idcaisse = idcaisse;
    }

    public CotisationTontine getIdcotisationtontine() {
        return idcotisationtontine;
    }

    public void setIdcotisationtontine(CotisationTontine idcotisationtontine) {
        this.idcotisationtontine = idcotisationtontine;
    }

    public Membrecycle getIdmembrecycle() {
        return idmembrecycle;
    }

    public void setIdmembrecycle(Membrecycle idmembrecycle) {
        this.idmembrecycle = idmembrecycle;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idaidecotisation != null ? idaidecotisation.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Aidecotisation)) {
            return false;
        }
        Aidecotisation other = (Aidecotisation) object;
        if ((this.idaidecotisation == null && other.idaidecotisation != null) || (this.idaidecotisation != null && !this.idaidecotisation.equals(other.idaidecotisation))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Aidecotisation[ idaidecotisation=" + idaidecotisation + " ]";
    }
    
}
