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
    @NamedQuery(name = "Aide.findAll", query = "SELECT a FROM Aide a"),
    @NamedQuery(name = "Aide.findByIdaide", query = "SELECT a FROM Aide a WHERE a.idaide = :idaide"),
    @NamedQuery(name = "Aide.findByDateaide", query = "SELECT a FROM Aide a WHERE a.dateaide = :dateaide"),
    @NamedQuery(name = "Aide.findByMontantaide", query = "SELECT a FROM Aide a WHERE a.montantaide = :montantaide"),
    @NamedQuery(name = "Aide.findByObservation", query = "SELECT a FROM Aide a WHERE a.observation = :observation"),
    @NamedQuery(name = "Aide.findByMontantMaintLevee", query = "SELECT a FROM Aide a WHERE a.montantMaintLevee = :montantMaintLevee")})
public class Aide implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idaide;
    @Temporal(TemporalType.DATE)
    private Date dateaide;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montantaide;
    @Size(max = 254)
    private String observation;
    @Column(name = "montant_maint_levee")
    private Double montantMaintLevee;
    @JoinColumn(name = "idcaisse", referencedColumnName = "idcaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Caisse idcaisse;
    @JoinColumn(name = "idcycle", referencedColumnName = "idcycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Cycletontine idcycle;
    @JoinColumn(name = "idbeneficiare", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle idbeneficiare;
    @JoinColumn(name = "idmembre", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle idmembre;
    @JoinColumn(name = "idmotifaide", referencedColumnName = "idmotifaide")
    @ManyToOne(fetch = FetchType.LAZY)
    private Motifaide idmotifaide;
    @JoinColumn(name = "idrencontre", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre idrencontre;
    @OneToMany(mappedBy = "idaide", fetch = FetchType.LAZY)
    private List<AideMembre> aideMembreList;

    public Aide() {
    }

    public Aide(Integer idaide) {
        this.idaide = idaide;
    }

    public Integer getIdaide() {
        return idaide;
    }

    public void setIdaide(Integer idaide) {
        this.idaide = idaide;
    }

    public Date getDateaide() {
        return dateaide;
    }

    public void setDateaide(Date dateaide) {
        this.dateaide = dateaide;
    }

    public Double getMontantaide() {
        return montantaide;
    }

    public void setMontantaide(Double montantaide) {
        this.montantaide = montantaide;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public Double getMontantMaintLevee() {
        return montantMaintLevee;
    }

    public void setMontantMaintLevee(Double montantMaintLevee) {
        this.montantMaintLevee = montantMaintLevee;
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

    public Membrecycle getIdbeneficiare() {
        return idbeneficiare;
    }

    public void setIdbeneficiare(Membrecycle idbeneficiare) {
        this.idbeneficiare = idbeneficiare;
    }

    public Membrecycle getIdmembre() {
        return idmembre;
    }

    public void setIdmembre(Membrecycle idmembre) {
        this.idmembre = idmembre;
    }

    public Motifaide getIdmotifaide() {
        return idmotifaide;
    }

    public void setIdmotifaide(Motifaide idmotifaide) {
        this.idmotifaide = idmotifaide;
    }

    public Rencontre getIdrencontre() {
        return idrencontre;
    }

    public void setIdrencontre(Rencontre idrencontre) {
        this.idrencontre = idrencontre;
    }

    @XmlTransient
    public List<AideMembre> getAideMembreList() {
        return aideMembreList;
    }

    public void setAideMembreList(List<AideMembre> aideMembreList) {
        this.aideMembreList = aideMembreList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idaide != null ? idaide.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Aide)) {
            return false;
        }
        Aide other = (Aide) object;
        if ((this.idaide == null && other.idaide != null) || (this.idaide != null && !this.idaide.equals(other.idaide))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Aide[ idaide=" + idaide + " ]";
    }
    
}
