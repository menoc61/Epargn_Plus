/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
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
    @NamedQuery(name = "Trancheemprunt.findAll", query = "SELECT t FROM Trancheemprunt t"),
    @NamedQuery(name = "Trancheemprunt.findByIdtranche", query = "SELECT t FROM Trancheemprunt t WHERE t.idtranche = :idtranche"),
    @NamedQuery(name = "Trancheemprunt.findByNomFr", query = "SELECT t FROM Trancheemprunt t WHERE t.nomFr = :nomFr"),
    @NamedQuery(name = "Trancheemprunt.findByTauxinteret", query = "SELECT t FROM Trancheemprunt t WHERE t.tauxinteret = :tauxinteret"),
    @NamedQuery(name = "Trancheemprunt.findByNomEn", query = "SELECT t FROM Trancheemprunt t WHERE t.nomEn = :nomEn")})
public class Trancheemprunt implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idtranche;
    @Size(max = 254)
    @Column(name = "nom_fr")
    private String nomFr;
    private BigInteger tauxinteret;
    @Size(max = 254)
    @Column(name = "nom_en")
    private String nomEn;

    public Trancheemprunt() {
    }

    public Trancheemprunt(Integer idtranche) {
        this.idtranche = idtranche;
    }

    public Integer getIdtranche() {
        return idtranche;
    }

    public void setIdtranche(Integer idtranche) {
        this.idtranche = idtranche;
    }

    public String getNomFr() {
        return nomFr;
    }

    public void setNomFr(String nomFr) {
        this.nomFr = nomFr;
    }

    public BigInteger getTauxinteret() {
        return tauxinteret;
    }

    public void setTauxinteret(BigInteger tauxinteret) {
        this.tauxinteret = tauxinteret;
    }

    public String getNomEn() {
        return nomEn;
    }

    public void setNomEn(String nomEn) {
        this.nomEn = nomEn;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idtranche != null ? idtranche.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Trancheemprunt)) {
            return false;
        }
        Trancheemprunt other = (Trancheemprunt) object;
        if ((this.idtranche == null && other.idtranche != null) || (this.idtranche != null && !this.idtranche.equals(other.idtranche))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Trancheemprunt[ idtranche=" + idtranche + " ]";
    }
    
}
