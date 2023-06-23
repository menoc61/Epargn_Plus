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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Louis Stark
 */
@Entity
@Table(name = "cassation_detail")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CassationDetail.findAll", query = "SELECT c FROM CassationDetail c"),
    @NamedQuery(name = "CassationDetail.findById", query = "SELECT c FROM CassationDetail c WHERE c.id = :id"),
    @NamedQuery(name = "CassationDetail.findByMontant", query = "SELECT c FROM CassationDetail c WHERE c.montant = :montant"),
    @NamedQuery(name = "CassationDetail.findByDateEpargne", query = "SELECT c FROM CassationDetail c WHERE c.dateEpargne = :dateEpargne"),
    @NamedQuery(name = "CassationDetail.findByDateCalcul", query = "SELECT c FROM CassationDetail c WHERE c.dateCalcul = :dateCalcul"),
    @NamedQuery(name = "CassationDetail.findByCoefEpargne", query = "SELECT c FROM CassationDetail c WHERE c.coefEpargne = :coefEpargne"),
    @NamedQuery(name = "CassationDetail.findByDuree", query = "SELECT c FROM CassationDetail c WHERE c.duree = :duree"),
    @NamedQuery(name = "CassationDetail.findByNombrePoint", query = "SELECT c FROM CassationDetail c WHERE c.nombrePoint = :nombrePoint")})
public class CassationDetail implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long id;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montant;
    @Column(name = "date_epargne")
    @Temporal(TemporalType.DATE)
    private Date dateEpargne;
    @Column(name = "date_calcul")
    @Temporal(TemporalType.DATE)
    private Date dateCalcul;
    @Column(name = "coef_epargne")
    private Double coefEpargne;
    private Double duree;
    @Column(name = "nombre_point")
    private Double nombrePoint;
    @JoinColumn(name = "idcycle", referencedColumnName = "idcycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Cycletontine idcycle;
    @JoinColumn(name = "idmembre", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle idmembre;

    public CassationDetail() {
    }

    public CassationDetail(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getMontant() {
        return montant;
    }

    public void setMontant(Double montant) {
        this.montant = montant;
    }

    public Date getDateEpargne() {
        return dateEpargne;
    }

    public void setDateEpargne(Date dateEpargne) {
        this.dateEpargne = dateEpargne;
    }

    public Date getDateCalcul() {
        return dateCalcul;
    }

    public void setDateCalcul(Date dateCalcul) {
        this.dateCalcul = dateCalcul;
    }

    public Double getCoefEpargne() {
        return coefEpargne;
    }

    public void setCoefEpargne(Double coefEpargne) {
        this.coefEpargne = coefEpargne;
    }

    public Double getDuree() {
        return duree;
    }

    public void setDuree(Double duree) {
        this.duree = duree;
    }

    public Double getNombrePoint() {
        return nombrePoint;
    }

    public void setNombrePoint(Double nombrePoint) {
        this.nombrePoint = nombrePoint;
    }

    public Cycletontine getIdcycle() {
        return idcycle;
    }

    public void setIdcycle(Cycletontine idcycle) {
        this.idcycle = idcycle;
    }

    public Membrecycle getIdmembre() {
        return idmembre;
    }

    public void setIdmembre(Membrecycle idmembre) {
        this.idmembre = idmembre;
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
        if (!(object instanceof CassationDetail)) {
            return false;
        }
        CassationDetail other = (CassationDetail) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.CassationDetail[ id=" + id + " ]";
    }
    
}
