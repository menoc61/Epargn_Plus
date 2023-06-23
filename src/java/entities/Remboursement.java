/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
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
    @NamedQuery(name = "Remboursement.findAll", query = "SELECT r FROM Remboursement r"),
    @NamedQuery(name = "Remboursement.findByIdremboursement", query = "SELECT r FROM Remboursement r WHERE r.idremboursement = :idremboursement"),
    @NamedQuery(name = "Remboursement.findByDaterembour", query = "SELECT r FROM Remboursement r WHERE r.daterembour = :daterembour"),
    @NamedQuery(name = "Remboursement.findByInteret", query = "SELECT r FROM Remboursement r WHERE r.interet = :interet"),
    @NamedQuery(name = "Remboursement.findByMontanttotal", query = "SELECT r FROM Remboursement r WHERE r.montanttotal = :montanttotal"),
    @NamedQuery(name = "Remboursement.findByMontantRembourse", query = "SELECT r FROM Remboursement r WHERE r.montantRembourse = :montantRembourse"),
    @NamedQuery(name = "Remboursement.findByObservation", query = "SELECT r FROM Remboursement r WHERE r.observation = :observation"),
    @NamedQuery(name = "Remboursement.findByResteCapitalAvant", query = "SELECT r FROM Remboursement r WHERE r.resteCapitalAvant = :resteCapitalAvant"),
    @NamedQuery(name = "Remboursement.findByCumulInteretAvant", query = "SELECT r FROM Remboursement r WHERE r.cumulInteretAvant = :cumulInteretAvant")})
public class Remboursement implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idremboursement;
    @Temporal(TemporalType.DATE)
    private Date daterembour;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double interet;
    private Double montanttotal;
    @Column(name = "montant_rembourse")
    private Double montantRembourse;
    @Size(max = 2147483647)
    private String observation;
    @Column(name = "reste_capital_avant")
    private Double resteCapitalAvant;
    @Column(name = "cumul_interet_avant")
    private Double cumulInteretAvant;
    @JoinColumn(name = "idcaisse", referencedColumnName = "idcaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Caisse idcaisse;
    @JoinColumn(name = "idemprunt", referencedColumnName = "idemprunt")
    @ManyToOne(fetch = FetchType.LAZY)
    private Emprunt idemprunt;
    @JoinColumn(name = "idrencontre", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre idrencontre;
    @JoinColumn(name = "idtyperemboursement", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private TypeRemboursement idtyperemboursement;

    public Remboursement() {
    }

    public Remboursement(Integer idremboursement) {
        this.idremboursement = idremboursement;
    }

    public Integer getIdremboursement() {
        return idremboursement;
    }

    public void setIdremboursement(Integer idremboursement) {
        this.idremboursement = idremboursement;
    }

    public Date getDaterembour() {
        return daterembour;
    }

    public void setDaterembour(Date daterembour) {
        this.daterembour = daterembour;
    }

    public Double getInteret() {
        return interet;
    }

    public void setInteret(Double interet) {
        this.interet = interet;
    }

    public Double getMontanttotal() {
        return montanttotal;
    }

    public void setMontanttotal(Double montanttotal) {
        this.montanttotal = montanttotal;
    }

    public Double getMontantRembourse() {
        return montantRembourse;
    }

    public void setMontantRembourse(Double montantRembourse) {
        this.montantRembourse = montantRembourse;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public Double getResteCapitalAvant() {
        return resteCapitalAvant;
    }

    public void setResteCapitalAvant(Double resteCapitalAvant) {
        this.resteCapitalAvant = resteCapitalAvant;
    }

    public Double getCumulInteretAvant() {
        return cumulInteretAvant;
    }

    public void setCumulInteretAvant(Double cumulInteretAvant) {
        this.cumulInteretAvant = cumulInteretAvant;
    }

    public Caisse getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(Caisse idcaisse) {
        this.idcaisse = idcaisse;
    }

    public Emprunt getIdemprunt() {
        return idemprunt;
    }

    public void setIdemprunt(Emprunt idemprunt) {
        this.idemprunt = idemprunt;
    }

    public Rencontre getIdrencontre() {
        return idrencontre;
    }

    public void setIdrencontre(Rencontre idrencontre) {
        this.idrencontre = idrencontre;
    }

    public TypeRemboursement getIdtyperemboursement() {
        return idtyperemboursement;
    }

    public void setIdtyperemboursement(TypeRemboursement idtyperemboursement) {
        this.idtyperemboursement = idtyperemboursement;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idremboursement != null ? idremboursement.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Remboursement)) {
            return false;
        }
        Remboursement other = (Remboursement) object;
        if ((this.idremboursement == null && other.idremboursement != null) || (this.idremboursement != null && !this.idremboursement.equals(other.idremboursement))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Remboursement[ idremboursement=" + idremboursement + " ]";
    }
    
}
