/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Louis Stark
 */
@Entity
@Table(name = "pas_emprunt")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PasEmprunt.findAll", query = "SELECT p FROM PasEmprunt p"),
    @NamedQuery(name = "PasEmprunt.findByIdpas", query = "SELECT p FROM PasEmprunt p WHERE p.idpas = :idpas"),
    @NamedQuery(name = "PasEmprunt.findByNom", query = "SELECT p FROM PasEmprunt p WHERE p.nom = :nom"),
    @NamedQuery(name = "PasEmprunt.findByValeur", query = "SELECT p FROM PasEmprunt p WHERE p.valeur = :valeur")})
public class PasEmprunt implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idpas;
    @Size(max = 2147483647)
    private String nom;
    private Integer valeur;
    @OneToMany(mappedBy = "idPasEmprunt", fetch = FetchType.LAZY)
    private List<Cycletontine> cycletontineList;

    public PasEmprunt() {
    }

    public PasEmprunt(Integer idpas) {
        this.idpas = idpas;
    }

    public Integer getIdpas() {
        return idpas;
    }

    public void setIdpas(Integer idpas) {
        this.idpas = idpas;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Integer getValeur() {
        return valeur;
    }

    public void setValeur(Integer valeur) {
        this.valeur = valeur;
    }

    @XmlTransient
    public List<Cycletontine> getCycletontineList() {
        return cycletontineList;
    }

    public void setCycletontineList(List<Cycletontine> cycletontineList) {
        this.cycletontineList = cycletontineList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idpas != null ? idpas.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PasEmprunt)) {
            return false;
        }
        PasEmprunt other = (PasEmprunt) object;
        if ((this.idpas == null && other.idpas != null) || (this.idpas != null && !this.idpas.equals(other.idpas))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.PasEmprunt[ idpas=" + idpas + " ]";
    }
    
}
