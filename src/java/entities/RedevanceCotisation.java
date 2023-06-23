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
@Table(name = "redevance_cotisation")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RedevanceCotisation.findAll", query = "SELECT r FROM RedevanceCotisation r"),
    @NamedQuery(name = "RedevanceCotisation.findByIdRedevanceCotisation", query = "SELECT r FROM RedevanceCotisation r WHERE r.idRedevanceCotisation = :idRedevanceCotisation"),
    @NamedQuery(name = "RedevanceCotisation.findByMontantInitial", query = "SELECT r FROM RedevanceCotisation r WHERE r.montantInitial = :montantInitial"),
    @NamedQuery(name = "RedevanceCotisation.findByMontantVerse", query = "SELECT r FROM RedevanceCotisation r WHERE r.montantVerse = :montantVerse"),
    @NamedQuery(name = "RedevanceCotisation.findByReste", query = "SELECT r FROM RedevanceCotisation r WHERE r.reste = :reste")})
public class RedevanceCotisation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_redevance_cotisation")
    private Long idRedevanceCotisation;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "montant_initial")
    private Double montantInitial;
    @Column(name = "montant_verse")
    private Double montantVerse;
    private Double reste;
    @JoinColumn(name = "idinscription", referencedColumnName = "idinscription")
    @ManyToOne(fetch = FetchType.LAZY)
    private InscriptionCotisation idinscription;
    @JoinColumn(name = "idrencontre", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre idrencontre;

    public RedevanceCotisation() {
    }

    public RedevanceCotisation(Long idRedevanceCotisation) {
        this.idRedevanceCotisation = idRedevanceCotisation;
    }

    public Long getIdRedevanceCotisation() {
        return idRedevanceCotisation;
    }

    public void setIdRedevanceCotisation(Long idRedevanceCotisation) {
        this.idRedevanceCotisation = idRedevanceCotisation;
    }

    public Double getMontantInitial() {
        return montantInitial;
    }

    public void setMontantInitial(Double montantInitial) {
        this.montantInitial = montantInitial;
    }

    public Double getMontantVerse() {
        return montantVerse;
    }

    public void setMontantVerse(Double montantVerse) {
        this.montantVerse = montantVerse;
    }

    public Double getReste() {
        return reste;
    }

    public void setReste(Double reste) {
        this.reste = reste;
    }

    public InscriptionCotisation getIdinscription() {
        return idinscription;
    }

    public void setIdinscription(InscriptionCotisation idinscription) {
        this.idinscription = idinscription;
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
        hash += (idRedevanceCotisation != null ? idRedevanceCotisation.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RedevanceCotisation)) {
            return false;
        }
        RedevanceCotisation other = (RedevanceCotisation) object;
        if ((this.idRedevanceCotisation == null && other.idRedevanceCotisation != null) || (this.idRedevanceCotisation != null && !this.idRedevanceCotisation.equals(other.idRedevanceCotisation))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.RedevanceCotisation[ idRedevanceCotisation=" + idRedevanceCotisation + " ]";
    }
    
}
