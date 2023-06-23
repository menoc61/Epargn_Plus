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
import javax.persistence.Table;
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
@Table(name = "fiche_presence")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "FichePresence.findAll", query = "SELECT f FROM FichePresence f"),
    @NamedQuery(name = "FichePresence.findById", query = "SELECT f FROM FichePresence f WHERE f.id = :id"),
    @NamedQuery(name = "FichePresence.findByDateRencontre", query = "SELECT f FROM FichePresence f WHERE f.dateRencontre = :dateRencontre"),
    @NamedQuery(name = "FichePresence.findByPresent", query = "SELECT f FROM FichePresence f WHERE f.present = :present"),
    @NamedQuery(name = "FichePresence.findByHeureDebut", query = "SELECT f FROM FichePresence f WHERE f.heureDebut = :heureDebut"),
    @NamedQuery(name = "FichePresence.findByHeureFin", query = "SELECT f FROM FichePresence f WHERE f.heureFin = :heureFin"),
    @NamedQuery(name = "FichePresence.findByRetard", query = "SELECT f FROM FichePresence f WHERE f.retard = :retard"),
    @NamedQuery(name = "FichePresence.findByJustifie", query = "SELECT f FROM FichePresence f WHERE f.justifie = :justifie"),
    @NamedQuery(name = "FichePresence.findByMontantPenalite", query = "SELECT f FROM FichePresence f WHERE f.montantPenalite = :montantPenalite"),
    @NamedQuery(name = "FichePresence.findByRegle", query = "SELECT f FROM FichePresence f WHERE f.regle = :regle"),
    @NamedQuery(name = "FichePresence.findByMotif", query = "SELECT f FROM FichePresence f WHERE f.motif = :motif")})
public class FichePresence implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long id;
    @Column(name = "date_rencontre")
    @Temporal(TemporalType.DATE)
    private Date dateRencontre;
    private Boolean present;
    @Column(name = "heure_debut")
    @Temporal(TemporalType.TIME)
    private Date heureDebut;
    @Column(name = "heure_fin")
    @Temporal(TemporalType.TIME)
    private Date heureFin;
    private Integer retard;
    private Boolean justifie;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "montant_penalite")
    private Double montantPenalite;
    private Boolean regle;
    @Size(max = 2147483647)
    private String motif;
    @JoinColumn(name = "idmembre", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle idmembre;
    @JoinColumn(name = "idrencontre", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre idrencontre;
    @OneToMany(mappedBy = "idpresence", fetch = FetchType.LAZY)
    private List<PayementSanction> payementSanctionList;

    public FichePresence() {
    }

    public FichePresence(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getDateRencontre() {
        return dateRencontre;
    }

    public void setDateRencontre(Date dateRencontre) {
        this.dateRencontre = dateRencontre;
    }

    public Boolean getPresent() {
        return present;
    }

    public void setPresent(Boolean present) {
        this.present = present;
    }

    public Date getHeureDebut() {
        return heureDebut;
    }

    public void setHeureDebut(Date heureDebut) {
        this.heureDebut = heureDebut;
    }

    public Date getHeureFin() {
        return heureFin;
    }

    public void setHeureFin(Date heureFin) {
        this.heureFin = heureFin;
    }

    public Integer getRetard() {
        return retard;
    }

    public void setRetard(Integer retard) {
        this.retard = retard;
    }

    public Boolean getJustifie() {
        return justifie;
    }

    public void setJustifie(Boolean justifie) {
        this.justifie = justifie;
    }

    public Double getMontantPenalite() {
        return montantPenalite;
    }

    public void setMontantPenalite(Double montantPenalite) {
        this.montantPenalite = montantPenalite;
    }

    public Boolean getRegle() {
        return regle;
    }

    public void setRegle(Boolean regle) {
        this.regle = regle;
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
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

    @XmlTransient
    public List<PayementSanction> getPayementSanctionList() {
        return payementSanctionList;
    }

    public void setPayementSanctionList(List<PayementSanction> payementSanctionList) {
        this.payementSanctionList = payementSanctionList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof FichePresence)) {
            return false;
        }
        FichePresence other = (FichePresence) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.FichePresence[ id=" + id + " ]";
    }
    
}
