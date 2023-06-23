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
    @NamedQuery(name = "Emprunt.findAll", query = "SELECT e FROM Emprunt e"),
    @NamedQuery(name = "Emprunt.findByIdemprunt", query = "SELECT e FROM Emprunt e WHERE e.idemprunt = :idemprunt"),
    @NamedQuery(name = "Emprunt.findByMontantemp", query = "SELECT e FROM Emprunt e WHERE e.montantemp = :montantemp"),
    @NamedQuery(name = "Emprunt.findByDateemprunt", query = "SELECT e FROM Emprunt e WHERE e.dateemprunt = :dateemprunt"),
    @NamedQuery(name = "Emprunt.findByObservtaion", query = "SELECT e FROM Emprunt e WHERE e.observtaion = :observtaion"),
    @NamedQuery(name = "Emprunt.findByTaux", query = "SELECT e FROM Emprunt e WHERE e.taux = :taux"),
    @NamedQuery(name = "Emprunt.findByTauxInteret", query = "SELECT e FROM Emprunt e WHERE e.tauxInteret = :tauxInteret"),
    @NamedQuery(name = "Emprunt.findByRembourse", query = "SELECT e FROM Emprunt e WHERE e.rembourse = :rembourse"),
    @NamedQuery(name = "Emprunt.findByMontantRemboursable", query = "SELECT e FROM Emprunt e WHERE e.montantRemboursable = :montantRemboursable"),
    @NamedQuery(name = "Emprunt.findByDateDernierRemboursement", query = "SELECT e FROM Emprunt e WHERE e.dateDernierRemboursement = :dateDernierRemboursement"),
    @NamedQuery(name = "Emprunt.findByCumulInteret", query = "SELECT e FROM Emprunt e WHERE e.cumulInteret = :cumulInteret"),
    @NamedQuery(name = "Emprunt.findByDateDernierRemboursementInt", query = "SELECT e FROM Emprunt e WHERE e.dateDernierRemboursementInt = :dateDernierRemboursementInt")})
public class Emprunt implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idemprunt;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montantemp;
    @Temporal(TemporalType.DATE)
    private Date dateemprunt;
    @Size(max = 254)
    private String observtaion;
    private Double taux;
    @Column(name = "taux_interet")
    private Double tauxInteret;
    private Boolean rembourse;
    @Column(name = "montant_remboursable")
    private Double montantRemboursable;
    @Column(name = "date_dernier_remboursement")
    @Temporal(TemporalType.DATE)
    private Date dateDernierRemboursement;
    @Column(name = "cumul_interet")
    private Double cumulInteret;
    @Column(name = "date_dernier_remboursement_int")
    @Temporal(TemporalType.DATE)
    private Date dateDernierRemboursementInt;
    @JoinColumn(name = "idcaisse", referencedColumnName = "idcaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Caisse idcaisse;
    @JoinColumn(name = "idmembre", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle idmembre;
    @JoinColumn(name = "idrencontre", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre idrencontre;
    @JoinColumn(name = "idtypeinteret", referencedColumnName = "idtypeinteret")
    @ManyToOne(fetch = FetchType.LAZY)
    private Typeinteret idtypeinteret;
    @OneToMany(mappedBy = "idemprunt", fetch = FetchType.LAZY)
    private List<Avalyse> avalyseList;
    @OneToMany(mappedBy = "idemprunt", fetch = FetchType.LAZY)
    private List<Remboursement> remboursementList;

    public Emprunt() {
    }

    public Emprunt(Integer idemprunt) {
        this.idemprunt = idemprunt;
    }

    public Integer getIdemprunt() {
        return idemprunt;
    }

    public void setIdemprunt(Integer idemprunt) {
        this.idemprunt = idemprunt;
    }

    public Double getMontantemp() {
        return montantemp;
    }

    public void setMontantemp(Double montantemp) {
        this.montantemp = montantemp;
    }

    public Date getDateemprunt() {
        return dateemprunt;
    }

    public void setDateemprunt(Date dateemprunt) {
        this.dateemprunt = dateemprunt;
    }

    public String getObservtaion() {
        return observtaion;
    }

    public void setObservtaion(String observtaion) {
        this.observtaion = observtaion;
    }

    public Double getTaux() {
        return taux;
    }

    public void setTaux(Double taux) {
        this.taux = taux;
    }

    public Double getTauxInteret() {
        return tauxInteret;
    }

    public void setTauxInteret(Double tauxInteret) {
        this.tauxInteret = tauxInteret;
    }

    public Boolean getRembourse() {
        return rembourse;
    }

    public void setRembourse(Boolean rembourse) {
        this.rembourse = rembourse;
    }

    public Double getMontantRemboursable() {
        return montantRemboursable;
    }

    public void setMontantRemboursable(Double montantRemboursable) {
        this.montantRemboursable = montantRemboursable;
    }

    public Date getDateDernierRemboursement() {
        return dateDernierRemboursement;
    }

    public void setDateDernierRemboursement(Date dateDernierRemboursement) {
        this.dateDernierRemboursement = dateDernierRemboursement;
    }

    public Double getCumulInteret() {
        return cumulInteret;
    }

    public void setCumulInteret(Double cumulInteret) {
        this.cumulInteret = cumulInteret;
    }

    public Date getDateDernierRemboursementInt() {
        return dateDernierRemboursementInt;
    }

    public void setDateDernierRemboursementInt(Date dateDernierRemboursementInt) {
        this.dateDernierRemboursementInt = dateDernierRemboursementInt;
    }

    public Caisse getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(Caisse idcaisse) {
        this.idcaisse = idcaisse;
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

    public Typeinteret getIdtypeinteret() {
        return idtypeinteret;
    }

    public void setIdtypeinteret(Typeinteret idtypeinteret) {
        this.idtypeinteret = idtypeinteret;
    }

    @XmlTransient
    public List<Avalyse> getAvalyseList() {
        return avalyseList;
    }

    public void setAvalyseList(List<Avalyse> avalyseList) {
        this.avalyseList = avalyseList;
    }

    @XmlTransient
    public List<Remboursement> getRemboursementList() {
        return remboursementList;
    }

    public void setRemboursementList(List<Remboursement> remboursementList) {
        this.remboursementList = remboursementList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idemprunt != null ? idemprunt.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Emprunt)) {
            return false;
        }
        Emprunt other = (Emprunt) object;
        if ((this.idemprunt == null && other.idemprunt != null) || (this.idemprunt != null && !this.idemprunt.equals(other.idemprunt))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Emprunt[ idemprunt=" + idemprunt + " ]";
    }
    
}
