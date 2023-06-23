/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Louis Stark
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Cotisation.findAll", query = "SELECT c FROM Cotisation c"),
    @NamedQuery(name = "Cotisation.findByIdcotisation", query = "SELECT c FROM Cotisation c WHERE c.idcotisation = :idcotisation"),
    @NamedQuery(name = "Cotisation.findByMontant", query = "SELECT c FROM Cotisation c WHERE c.montant = :montant"),
    @NamedQuery(name = "Cotisation.findByNom", query = "SELECT c FROM Cotisation c WHERE c.nom = :nom"),
    @NamedQuery(name = "Cotisation.findByNbretours", query = "SELECT c FROM Cotisation c WHERE c.nbretours = :nbretours"),
    @NamedQuery(name = "Cotisation.findByRedevance", query = "SELECT c FROM Cotisation c WHERE c.redevance = :redevance"),
    @NamedQuery(name = "Cotisation.findByPenaliteNonCotisation", query = "SELECT c FROM Cotisation c WHERE c.penaliteNonCotisation = :penaliteNonCotisation"),
    @NamedQuery(name = "Cotisation.findByPenaliteNonCotisationABouffe", query = "SELECT c FROM Cotisation c WHERE c.penaliteNonCotisationABouffe = :penaliteNonCotisationABouffe"),
    @NamedQuery(name = "Cotisation.findByInteretAssistanceCotisation", query = "SELECT c FROM Cotisation c WHERE c.interetAssistanceCotisation = :interetAssistanceCotisation"),
    @NamedQuery(name = "Cotisation.findByCanEnchered", query = "SELECT c FROM Cotisation c WHERE c.canEnchered = :canEnchered"),
    @NamedQuery(name = "Cotisation.findByEnchereMin", query = "SELECT c FROM Cotisation c WHERE c.enchereMin = :enchereMin"),
    @NamedQuery(name = "Cotisation.findByEnchereMax", query = "SELECT c FROM Cotisation c WHERE c.enchereMax = :enchereMax"),
    @NamedQuery(name = "Cotisation.findByDateEnregistrement", query = "SELECT c FROM Cotisation c WHERE c.dateEnregistrement = :dateEnregistrement"),
    @NamedQuery(name = "Cotisation.findByEstTermine", query = "SELECT c FROM Cotisation c WHERE c.estTermine = :estTermine"),
    @NamedQuery(name = "Cotisation.findByReliquat", query = "SELECT c FROM Cotisation c WHERE c.reliquat = :reliquat")})
public class Cotisation implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idcotisation;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montant;
    @Size(max = 2147483647)
    private String nom;
    private Integer nbretours;
    private Double redevance;
    @Column(name = "penalite_non_cotisation")
    private Double penaliteNonCotisation;
    @Column(name = "penalite_non_cotisation_a_bouffe")
    private Double penaliteNonCotisationABouffe;
    @Column(name = "interet_assistance_cotisation")
    private Double interetAssistanceCotisation;
    @Column(name = "can_enchered")
    private Boolean canEnchered;
    @Column(name = "enchere_min")
    private Double enchereMin;
    @Column(name = "enchere_max")
    private Double enchereMax;
    @Column(name = "date_enregistrement")
    @Temporal(TemporalType.DATE)
    private Date dateEnregistrement;
    @Column(name = "est_termine")
    private Boolean estTermine;
    private Double reliquat;
    @OneToMany(mappedBy = "idcotisation", fetch = FetchType.LAZY)
    private List<InscriptionCotisation> inscriptionCotisationList;
    @OneToMany(mappedBy = "idcotisation", fetch = FetchType.LAZY)
    private List<Tontiner> tontinerList;
    @JoinColumn(name = "premierjour", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre premierjour;
    @JoinColumn(name = "idtontine", referencedColumnName = "idtontine")
    @ManyToOne(fetch = FetchType.LAZY)
    private Tontine idtontine;

    @JoinColumn(name = "idcycle", referencedColumnName = "idcycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Cycletontine idcycletontine;

    public Cotisation() {
    }

    public Cotisation(Integer idcotisation) {
        this.idcotisation = idcotisation;
    }

    public Integer getIdcotisation() {
        return idcotisation;
    }

    public void setIdcotisation(Integer idcotisation) {
        this.idcotisation = idcotisation;
    }

    public Double getMontant() {
        return montant;
    }

    public void setMontant(Double montant) {
        this.montant = montant;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Integer getNbretours() {
        return nbretours;
    }

    public void setNbretours(Integer nbretours) {
        this.nbretours = nbretours;
    }

    public Double getRedevance() {
        return redevance;
    }

    public void setRedevance(Double redevance) {
        this.redevance = redevance;
    }

    public Double getPenaliteNonCotisation() {
        return penaliteNonCotisation;
    }

    public void setPenaliteNonCotisation(Double penaliteNonCotisation) {
        this.penaliteNonCotisation = penaliteNonCotisation;
    }

    public Double getPenaliteNonCotisationABouffe() {
        return penaliteNonCotisationABouffe;
    }

    public void setPenaliteNonCotisationABouffe(Double penaliteNonCotisationABouffe) {
        this.penaliteNonCotisationABouffe = penaliteNonCotisationABouffe;
    }

    public Double getInteretAssistanceCotisation() {
        return interetAssistanceCotisation;
    }

    public void setInteretAssistanceCotisation(Double interetAssistanceCotisation) {
        this.interetAssistanceCotisation = interetAssistanceCotisation;
    }

    public Boolean getCanEnchered() {
        return canEnchered;
    }

    public void setCanEnchered(Boolean canEnchered) {
        this.canEnchered = canEnchered;
    }

    public Double getEnchereMin() {
        return enchereMin;
    }

    public void setEnchereMin(Double enchereMin) {
        this.enchereMin = enchereMin;
    }

    public Double getEnchereMax() {
        return enchereMax;
    }

    public void setEnchereMax(Double enchereMax) {
        this.enchereMax = enchereMax;
    }

    public Date getDateEnregistrement() {
        return dateEnregistrement;
    }

    public void setDateEnregistrement(Date dateEnregistrement) {
        this.dateEnregistrement = dateEnregistrement;
    }

    public Boolean getEstTermine() {
        return estTermine;
    }

    public void setEstTermine(Boolean estTermine) {
        this.estTermine = estTermine;
    }

    public Double getReliquat() {
        return reliquat;
    }

    public void setReliquat(Double reliquat) {
        this.reliquat = reliquat;
    }

    @XmlTransient
    public List<InscriptionCotisation> getInscriptionCotisationList() {
        return inscriptionCotisationList;
    }

    public void setInscriptionCotisationList(List<InscriptionCotisation> inscriptionCotisationList) {
        this.inscriptionCotisationList = inscriptionCotisationList;
    }

    @XmlTransient
    public List<Tontiner> getTontinerList() {
        return tontinerList;
    }

    public void setTontinerList(List<Tontiner> tontinerList) {
        this.tontinerList = tontinerList;
    }

    public Rencontre getPremierjour() {
        return premierjour;
    }

    public void setPremierjour(Rencontre premierjour) {
        this.premierjour = premierjour;
    }

    public Tontine getIdtontine() {
        return idtontine;
    }

    public void setIdtontine(Tontine idtontine) {
        this.idtontine = idtontine;
    }

    public Cycletontine getIdcycletontine() {
        return idcycletontine;
    }

    public void setIdcycletontine(Cycletontine idcycletontine) {
        this.idcycletontine = idcycletontine;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idcotisation != null ? idcotisation.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Cotisation)) {
            return false;
        }
        Cotisation other = (Cotisation) object;
        if ((this.idcotisation == null && other.idcotisation != null) || (this.idcotisation != null && !this.idcotisation.equals(other.idcotisation))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Cotisation[ idcotisation=" + idcotisation + " ]";
    }

}
