/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.math.BigInteger;
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
    @NamedQuery(name = "Operationcaisse.findAll", query = "SELECT o FROM Operationcaisse o"),
    @NamedQuery(name = "Operationcaisse.findByIdoperationcaisse", query = "SELECT o FROM Operationcaisse o WHERE o.idoperationcaisse = :idoperationcaisse"),
    @NamedQuery(name = "Operationcaisse.findByLibelle", query = "SELECT o FROM Operationcaisse o WHERE o.libelle = :libelle"),
    @NamedQuery(name = "Operationcaisse.findByMontant", query = "SELECT o FROM Operationcaisse o WHERE o.montant = :montant"),
    @NamedQuery(name = "Operationcaisse.findByDate", query = "SELECT o FROM Operationcaisse o WHERE o.date = :date")})
public class Operationcaisse implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idoperationcaisse;
    @Size(max = 254)
    private String libelle;
    private BigInteger montant;
    @Temporal(TemporalType.DATE)
    private Date date;
    @JoinColumn(name = "idcycle", referencedColumnName = "idcycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Cycletontine idcycle;
    @JoinColumn(name = "idmois", referencedColumnName = "idmois")
    @ManyToOne(fetch = FetchType.LAZY)
    private Mois idmois;

    public Operationcaisse() {
    }

    public Operationcaisse(Integer idoperationcaisse) {
        this.idoperationcaisse = idoperationcaisse;
    }

    public Integer getIdoperationcaisse() {
        return idoperationcaisse;
    }

    public void setIdoperationcaisse(Integer idoperationcaisse) {
        this.idoperationcaisse = idoperationcaisse;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public BigInteger getMontant() {
        return montant;
    }

    public void setMontant(BigInteger montant) {
        this.montant = montant;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Cycletontine getIdcycle() {
        return idcycle;
    }

    public void setIdcycle(Cycletontine idcycle) {
        this.idcycle = idcycle;
    }

    public Mois getIdmois() {
        return idmois;
    }

    public void setIdmois(Mois idmois) {
        this.idmois = idmois;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idoperationcaisse != null ? idoperationcaisse.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Operationcaisse)) {
            return false;
        }
        Operationcaisse other = (Operationcaisse) object;
        if ((this.idoperationcaisse == null && other.idoperationcaisse != null) || (this.idoperationcaisse != null && !this.idoperationcaisse.equals(other.idoperationcaisse))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Operationcaisse[ idoperationcaisse=" + idoperationcaisse + " ]";
    }
    
}
