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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Louis Stark
 */
@Entity
@Table(name = "encours_secours")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "EncoursSecours.findAll", query = "SELECT e FROM EncoursSecours e"),
    @NamedQuery(name = "EncoursSecours.findByIdEncoursSecours", query = "SELECT e FROM EncoursSecours e WHERE e.idEncoursSecours = :idEncoursSecours"),
    @NamedQuery(name = "EncoursSecours.findByEncours", query = "SELECT e FROM EncoursSecours e WHERE e.encours = :encours"),
    @NamedQuery(name = "EncoursSecours.findByMontantCotise", query = "SELECT e FROM EncoursSecours e WHERE e.montantCotise = :montantCotise"),
    @NamedQuery(name = "EncoursSecours.findByReste", query = "SELECT e FROM EncoursSecours e WHERE e.reste = :reste"),
    @NamedQuery(name = "EncoursSecours.findByObservation", query = "SELECT e FROM EncoursSecours e WHERE e.observation = :observation")})
public class EncoursSecours implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_encours_secours")
    private Long idEncoursSecours;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double encours;
    @Column(name = "montant_cotise")
    private Double montantCotise;
    private Double reste;
    @Size(max = 2147483647)
    private String observation;
    @JoinColumn(name = "idmembre", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle idmembre;
    @JoinColumn(name = "idrencontre", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre idrencontre;

    public EncoursSecours() {
    }

    public EncoursSecours(Long idEncoursSecours) {
        this.idEncoursSecours = idEncoursSecours;
    }

    public Long getIdEncoursSecours() {
        return idEncoursSecours;
    }

    public void setIdEncoursSecours(Long idEncoursSecours) {
        this.idEncoursSecours = idEncoursSecours;
    }

    public Double getEncours() {
        return encours;
    }

    public void setEncours(Double encours) {
        this.encours = encours;
    }

    public Double getMontantCotise() {
        return montantCotise;
    }

    public void setMontantCotise(Double montantCotise) {
        this.montantCotise = montantCotise;
    }

    public Double getReste() {
        return reste;
    }

    public void setReste(Double reste) {
        this.reste = reste;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
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
        hash += (idEncoursSecours != null ? idEncoursSecours.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof EncoursSecours)) {
            return false;
        }
        EncoursSecours other = (EncoursSecours) object;
        if ((this.idEncoursSecours == null && other.idEncoursSecours != null) || (this.idEncoursSecours != null && !this.idEncoursSecours.equals(other.idEncoursSecours))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.EncoursSecours[ idEncoursSecours=" + idEncoursSecours + " ]";
    }
    
}
