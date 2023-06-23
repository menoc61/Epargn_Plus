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
    @NamedQuery(name = "Membre.findAll", query = "SELECT m FROM Membre m"),
    @NamedQuery(name = "Membre.findByIdmembre", query = "SELECT m FROM Membre m WHERE m.idmembre = :idmembre"),
    @NamedQuery(name = "Membre.findByNom", query = "SELECT m FROM Membre m WHERE m.nom = :nom"),
    @NamedQuery(name = "Membre.findByPrenom", query = "SELECT m FROM Membre m WHERE m.prenom = :prenom"),
    @NamedQuery(name = "Membre.findBySexe", query = "SELECT m FROM Membre m WHERE m.sexe = :sexe"),
    @NamedQuery(name = "Membre.findByContact", query = "SELECT m FROM Membre m WHERE m.contact = :contact"),
    @NamedQuery(name = "Membre.findByEmail", query = "SELECT m FROM Membre m WHERE m.email = :email"),
    @NamedQuery(name = "Membre.findByPhoto", query = "SELECT m FROM Membre m WHERE m.photo = :photo"),
    @NamedQuery(name = "Membre.findByAdresse", query = "SELECT m FROM Membre m WHERE m.adresse = :adresse"),
    @NamedQuery(name = "Membre.findByNumcni", query = "SELECT m FROM Membre m WHERE m.numcni = :numcni"),
    @NamedQuery(name = "Membre.findByCode", query = "SELECT m FROM Membre m WHERE m.code = :code")})
public class Membre implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idmembre;
    @Size(max = 254)
    private String nom;
    @Size(max = 254)
    private String prenom;
    @Size(max = 254)
    private String sexe;
    @Size(max = 254)
    private String contact;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Size(max = 254)
    private String email;
    @Size(max = 254)
    private String photo;
    @Size(max = 254)
    private String adresse;
    @Size(max = 2147483647)
    private String numcni;
    @Size(max = 2147483647)
    private String code;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<Compteutilisateur> compteutilisateurList;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<Membretontine> membretontineList;
    @JoinColumn(name = "idpays", referencedColumnName = "idpays")
    @ManyToOne(fetch = FetchType.LAZY)
    private Pays idpays;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<Beneficiairecotisation> beneficiairecotisationList;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<Membrecycle> membrecycleList;

    public Membre() {
    }

    public Membre(Integer idmembre) {
        this.idmembre = idmembre;
    }

    public Integer getIdmembre() {
        return idmembre;
    }

    public void setIdmembre(Integer idmembre) {
        this.idmembre = idmembre;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getSexe() {
        return sexe;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getNumcni() {
        return numcni;
    }

    public void setNumcni(String numcni) {
        this.numcni = numcni;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @XmlTransient
    public List<Compteutilisateur> getCompteutilisateurList() {
        return compteutilisateurList;
    }

    public void setCompteutilisateurList(List<Compteutilisateur> compteutilisateurList) {
        this.compteutilisateurList = compteutilisateurList;
    }

    @XmlTransient
    public List<Membretontine> getMembretontineList() {
        return membretontineList;
    }

    public void setMembretontineList(List<Membretontine> membretontineList) {
        this.membretontineList = membretontineList;
    }

    public Pays getIdpays() {
        return idpays;
    }

    public void setIdpays(Pays idpays) {
        this.idpays = idpays;
    }

    @XmlTransient
    public List<Beneficiairecotisation> getBeneficiairecotisationList() {
        return beneficiairecotisationList;
    }

    public void setBeneficiairecotisationList(List<Beneficiairecotisation> beneficiairecotisationList) {
        this.beneficiairecotisationList = beneficiairecotisationList;
    }

    @XmlTransient
    public List<Membrecycle> getMembrecycleList() {
        return membrecycleList;
    }

    public void setMembrecycleList(List<Membrecycle> membrecycleList) {
        this.membrecycleList = membrecycleList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idmembre != null ? idmembre.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Membre)) {
            return false;
        }
        Membre other = (Membre) object;
        if ((this.idmembre == null && other.idmembre != null) || (this.idmembre != null && !this.idmembre.equals(other.idmembre))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Membre[ idmembre=" + idmembre + " ]";
    }
    
}
