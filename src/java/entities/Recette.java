/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
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
    @NamedQuery(name = "Recette.findAll", query = "SELECT r FROM Recette r"),
    @NamedQuery(name = "Recette.findByIdrecette", query = "SELECT r FROM Recette r WHERE r.idrecette = :idrecette"),
    @NamedQuery(name = "Recette.findByDate", query = "SELECT r FROM Recette r WHERE r.date = :date"),
    @NamedQuery(name = "Recette.findByObservation", query = "SELECT r FROM Recette r WHERE r.observation = :observation"),
    @NamedQuery(name = "Recette.findByMontant", query = "SELECT r FROM Recette r WHERE r.montant = :montant")})
public class Recette implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idrecette;
    @Temporal(TemporalType.DATE)
    private Date date;
    @Size(max = 2147483647)
    private String observation;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montant;
    @JoinColumn(name = "idcaisse", referencedColumnName = "idcaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Caisse idcaisse;
    @JoinColumn(name = "idcycle", referencedColumnName = "idcycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Cycletontine idcycle;
    @JoinColumn(name = "idrencontre", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre idrencontre;
    @JoinColumn(name = "idrubrique", referencedColumnName = "idrubriquecaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rubriquecaisse idrubrique;

    public Recette() {
    }

    public Recette(Integer idrecette) {
        this.idrecette = idrecette;
    }

    public Integer getIdrecette() {
        return idrecette;
    }

    public void setIdrecette(Integer idrecette) {
        this.idrecette = idrecette;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public Double getMontant() {
        return montant;
    }

    public void setMontant(Double montant) {
        this.montant = montant;
    }

    public Caisse getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(Caisse idcaisse) {
        this.idcaisse = idcaisse;
    }

    public Cycletontine getIdcycle() {
        return idcycle;
    }

    public void setIdcycle(Cycletontine idcycle) {
        this.idcycle = idcycle;
    }

    public Rencontre getIdrencontre() {
        return idrencontre;
    }

    public void setIdrencontre(Rencontre idrencontre) {
        this.idrencontre = idrencontre;
    }

    public Rubriquecaisse getIdrubrique() {
        return idrubrique;
    }

    public void setIdrubrique(Rubriquecaisse idrubrique) {
        this.idrubrique = idrubrique;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idrecette != null ? idrecette.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Recette)) {
            return false;
        }
        Recette other = (Recette) object;
        if ((this.idrecette == null && other.idrecette != null) || (this.idrecette != null && !this.idrecette.equals(other.idrecette))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Recette[ idrecette=" + idrecette + " ]";
    }
    
}
