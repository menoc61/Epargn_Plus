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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
    @NamedQuery(name = "Tontine.findAll", query = "SELECT t FROM Tontine t"),
    @NamedQuery(name = "Tontine.findByIdtontine", query = "SELECT t FROM Tontine t WHERE t.idtontine = :idtontine"),
    @NamedQuery(name = "Tontine.findByNom", query = "SELECT t FROM Tontine t WHERE t.nom = :nom"),
    @NamedQuery(name = "Tontine.findBySlogan", query = "SELECT t FROM Tontine t WHERE t.slogan = :slogan"),
    @NamedQuery(name = "Tontine.findByNumerodetransfert", query = "SELECT t FROM Tontine t WHERE t.numerodetransfert = :numerodetransfert")})
public class Tontine implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idtontine;
    @Size(max = 254)
    private String nom;
    @Size(max = 254)
    private String slogan;
    @Size(max = 2147483647)
    private String numerodetransfert;
    @OneToMany(mappedBy = "idtontine", fetch = FetchType.LAZY)
    private List<Utilisateurtontine> utilisateurtontineList;
    @OneToMany(mappedBy = "idtontine", fetch = FetchType.LAZY)
    private List<Membretontine> membretontineList;
    @OneToMany(mappedBy = "idTontine", fetch = FetchType.LAZY)
    private List<Rencontre> rencontreList;
    @JoinColumn(name = "iddevices", referencedColumnName = "iddevices")
    @ManyToOne(fetch = FetchType.LAZY)
    private Devise iddevices;
    @JoinColumn(name = "idfreqtontine", referencedColumnName = "idfreqtontine")
    @ManyToOne(fetch = FetchType.LAZY)
    private Frequencetontine idfreqtontine;
    @JoinColumn(name = "idmdepaiement", referencedColumnName = "idmdepaiement")
    @ManyToOne(fetch = FetchType.LAZY)
    private Modepaiement idmdepaiement;
    @JoinColumn(name = "idrubriquecaisse", referencedColumnName = "idrubriquecaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rubriquecaisse idrubriquecaisse;
    @JoinColumn(name = "idtsanction", referencedColumnName = "idtsanction")
    @ManyToOne(fetch = FetchType.LAZY)
    private Sanction idtsanction;
    @JoinColumn(name = "idtranchecotisation", referencedColumnName = "idtranche")
    @ManyToOne(fetch = FetchType.LAZY)
    private Tranchecotisation idtranchecotisation;
    @OneToMany(mappedBy = "idtontine", fetch = FetchType.LAZY)
    private List<Cotisation> cotisationList;
    @OneToMany(mappedBy = "idtontine", fetch = FetchType.LAZY)
    private List<Cycletontine> cycletontineList;

    public Tontine() {
    }

    public Tontine(Integer idtontine) {
        this.idtontine = idtontine;
    }

    public Integer getIdtontine() {
        return idtontine;
    }

    public void setIdtontine(Integer idtontine) {
        this.idtontine = idtontine;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getSlogan() {
        return slogan;
    }

    public void setSlogan(String slogan) {
        this.slogan = slogan;
    }

    public String getNumerodetransfert() {
        return numerodetransfert;
    }

    public void setNumerodetransfert(String numerodetransfert) {
        this.numerodetransfert = numerodetransfert;
    }

    @XmlTransient
    public List<Utilisateurtontine> getUtilisateurtontineList() {
        return utilisateurtontineList;
    }

    public void setUtilisateurtontineList(List<Utilisateurtontine> utilisateurtontineList) {
        this.utilisateurtontineList = utilisateurtontineList;
    }

    @XmlTransient
    public List<Membretontine> getMembretontineList() {
        return membretontineList;
    }

    public void setMembretontineList(List<Membretontine> membretontineList) {
        this.membretontineList = membretontineList;
    }

    @XmlTransient
    public List<Rencontre> getRencontreList() {
        return rencontreList;
    }

    public void setRencontreList(List<Rencontre> rencontreList) {
        this.rencontreList = rencontreList;
    }

    public Devise getIddevices() {
        return iddevices;
    }

    public void setIddevices(Devise iddevices) {
        this.iddevices = iddevices;
    }

    public Frequencetontine getIdfreqtontine() {
        return idfreqtontine;
    }

    public void setIdfreqtontine(Frequencetontine idfreqtontine) {
        this.idfreqtontine = idfreqtontine;
    }

    public Modepaiement getIdmdepaiement() {
        return idmdepaiement;
    }

    public void setIdmdepaiement(Modepaiement idmdepaiement) {
        this.idmdepaiement = idmdepaiement;
    }

    public Rubriquecaisse getIdrubriquecaisse() {
        return idrubriquecaisse;
    }

    public void setIdrubriquecaisse(Rubriquecaisse idrubriquecaisse) {
        this.idrubriquecaisse = idrubriquecaisse;
    }

    public Sanction getIdtsanction() {
        return idtsanction;
    }

    public void setIdtsanction(Sanction idtsanction) {
        this.idtsanction = idtsanction;
    }

    public Tranchecotisation getIdtranchecotisation() {
        return idtranchecotisation;
    }

    public void setIdtranchecotisation(Tranchecotisation idtranchecotisation) {
        this.idtranchecotisation = idtranchecotisation;
    }

    @XmlTransient
    public List<Cotisation> getCotisationList() {
        return cotisationList;
    }

    public void setCotisationList(List<Cotisation> cotisationList) {
        this.cotisationList = cotisationList;
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
        hash += (idtontine != null ? idtontine.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tontine)) {
            return false;
        }
        Tontine other = (Tontine) object;
        if ((this.idtontine == null && other.idtontine != null) || (this.idtontine != null && !this.idtontine.equals(other.idtontine))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Tontine[ idtontine=" + idtontine + " ]";
    }
    
}
