/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
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
    @NamedQuery(name = "Sanction.findAll", query = "SELECT s FROM Sanction s"),
    @NamedQuery(name = "Sanction.findByIdtsanction", query = "SELECT s FROM Sanction s WHERE s.idtsanction = :idtsanction"),
    @NamedQuery(name = "Sanction.findByNomEn", query = "SELECT s FROM Sanction s WHERE s.nomEn = :nomEn"),
    @NamedQuery(name = "Sanction.findByMontant", query = "SELECT s FROM Sanction s WHERE s.montant = :montant"),
    @NamedQuery(name = "Sanction.findByNomFr", query = "SELECT s FROM Sanction s WHERE s.nomFr = :nomFr")})
public class Sanction implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idtsanction;
    @Size(max = 254)
    @Column(name = "nom_en")
    private String nomEn;
    private BigInteger montant;
    @Size(max = 254)
    @Column(name = "nom_fr")
    private String nomFr;
    @OneToMany(mappedBy = "idtsanction", fetch = FetchType.LAZY)
    private List<Tontine> tontineList;

    public Sanction() {
    }

    public Sanction(Integer idtsanction) {
        this.idtsanction = idtsanction;
    }

    public Integer getIdtsanction() {
        return idtsanction;
    }

    public void setIdtsanction(Integer idtsanction) {
        this.idtsanction = idtsanction;
    }

    public String getNomEn() {
        return nomEn;
    }

    public void setNomEn(String nomEn) {
        this.nomEn = nomEn;
    }

    public BigInteger getMontant() {
        return montant;
    }

    public void setMontant(BigInteger montant) {
        this.montant = montant;
    }

    public String getNomFr() {
        return nomFr;
    }

    public void setNomFr(String nomFr) {
        this.nomFr = nomFr;
    }

    @XmlTransient
    public List<Tontine> getTontineList() {
        return tontineList;
    }

    public void setTontineList(List<Tontine> tontineList) {
        this.tontineList = tontineList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idtsanction != null ? idtsanction.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Sanction)) {
            return false;
        }
        Sanction other = (Sanction) object;
        if ((this.idtsanction == null && other.idtsanction != null) || (this.idtsanction != null && !this.idtsanction.equals(other.idtsanction))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Sanction[ idtsanction=" + idtsanction + " ]";
    }
    
}
