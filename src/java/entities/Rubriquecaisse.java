/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
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
    @NamedQuery(name = "Rubriquecaisse.findAll", query = "SELECT r FROM Rubriquecaisse r"),
    @NamedQuery(name = "Rubriquecaisse.findByIdrubriquecaisse", query = "SELECT r FROM Rubriquecaisse r WHERE r.idrubriquecaisse = :idrubriquecaisse"),
    @NamedQuery(name = "Rubriquecaisse.findByNomfr", query = "SELECT r FROM Rubriquecaisse r WHERE r.nomfr = :nomfr"),
    @NamedQuery(name = "Rubriquecaisse.findByNomen", query = "SELECT r FROM Rubriquecaisse r WHERE r.nomen = :nomen"),
    @NamedQuery(name = "Rubriquecaisse.findByCode", query = "SELECT r FROM Rubriquecaisse r WHERE r.code = :code"),
    @NamedQuery(name = "Rubriquecaisse.findByModifiable", query = "SELECT r FROM Rubriquecaisse r WHERE r.modifiable = :modifiable"),
    @NamedQuery(name = "Rubriquecaisse.findByAfficher", query = "SELECT r FROM Rubriquecaisse r WHERE r.afficher = :afficher"),
    @NamedQuery(name = "Rubriquecaisse.findByEditableEnCaisse", query = "SELECT r FROM Rubriquecaisse r WHERE r.editableEnCaisse = :editableEnCaisse")})
public class Rubriquecaisse implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idrubriquecaisse;
    @Size(max = 254)
    private String nomfr;
    @Size(max = 254)
    private String nomen;
    @Size(max = 254)
    private String code;
    private Boolean modifiable;
    private Boolean afficher;
    @Column(name = "editable_en_caisse")
    private Boolean editableEnCaisse;
    @OneToMany(mappedBy = "idrubriquecaisse", fetch = FetchType.LAZY)
    private List<Caisse> caisseList;
    @JoinColumn(name = "idnaturecaisse", referencedColumnName = "idnaturecaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Naturecaisse idnaturecaisse;
    @OneToMany(mappedBy = "idrubriquecaisse", fetch = FetchType.LAZY)
    private List<Tontine> tontineList;
    @OneToMany(mappedBy = "idrubriquecaisse", fetch = FetchType.LAZY)
    private List<Depense> depenseList;
    @OneToMany(mappedBy = "idrubrique", fetch = FetchType.LAZY)
    private List<Recette> recetteList;

    public Rubriquecaisse() {
    }

    public Rubriquecaisse(Integer idrubriquecaisse) {
        this.idrubriquecaisse = idrubriquecaisse;
    }

    public Integer getIdrubriquecaisse() {
        return idrubriquecaisse;
    }

    public void setIdrubriquecaisse(Integer idrubriquecaisse) {
        this.idrubriquecaisse = idrubriquecaisse;
    }

    public String getNomfr() {
        return nomfr;
    }

    public void setNomfr(String nomfr) {
        this.nomfr = nomfr;
    }

    public String getNomen() {
        return nomen;
    }

    public void setNomen(String nomen) {
        this.nomen = nomen;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Boolean getModifiable() {
        return modifiable;
    }

    public void setModifiable(Boolean modifiable) {
        this.modifiable = modifiable;
    }

    public Boolean getAfficher() {
        return afficher;
    }

    public void setAfficher(Boolean afficher) {
        this.afficher = afficher;
    }

    public Boolean getEditableEnCaisse() {
        return editableEnCaisse;
    }

    public void setEditableEnCaisse(Boolean editableEnCaisse) {
        this.editableEnCaisse = editableEnCaisse;
    }

    @XmlTransient
    public List<Caisse> getCaisseList() {
        return caisseList;
    }

    public void setCaisseList(List<Caisse> caisseList) {
        this.caisseList = caisseList;
    }

    public Naturecaisse getIdnaturecaisse() {
        return idnaturecaisse;
    }

    public void setIdnaturecaisse(Naturecaisse idnaturecaisse) {
        this.idnaturecaisse = idnaturecaisse;
    }

    @XmlTransient
    public List<Tontine> getTontineList() {
        return tontineList;
    }

    public void setTontineList(List<Tontine> tontineList) {
        this.tontineList = tontineList;
    }

    @XmlTransient
    public List<Depense> getDepenseList() {
        return depenseList;
    }

    public void setDepenseList(List<Depense> depenseList) {
        this.depenseList = depenseList;
    }

    @XmlTransient
    public List<Recette> getRecetteList() {
        return recetteList;
    }

    public void setRecetteList(List<Recette> recetteList) {
        this.recetteList = recetteList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idrubriquecaisse != null ? idrubriquecaisse.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Rubriquecaisse)) {
            return false;
        }
        Rubriquecaisse other = (Rubriquecaisse) object;
        if ((this.idrubriquecaisse == null && other.idrubriquecaisse != null) || (this.idrubriquecaisse != null && !this.idrubriquecaisse.equals(other.idrubriquecaisse))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Rubriquecaisse[ idrubriquecaisse=" + idrubriquecaisse + " ]";
    }
    
}
