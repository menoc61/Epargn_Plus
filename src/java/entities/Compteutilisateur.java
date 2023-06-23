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
    @NamedQuery(name = "Compteutilisateur.findAll", query = "SELECT c FROM Compteutilisateur c"),
    @NamedQuery(name = "Compteutilisateur.findByIdcompte", query = "SELECT c FROM Compteutilisateur c WHERE c.idcompte = :idcompte"),
    @NamedQuery(name = "Compteutilisateur.findByLogin", query = "SELECT c FROM Compteutilisateur c WHERE c.login = :login"),
    @NamedQuery(name = "Compteutilisateur.findByPassword", query = "SELECT c FROM Compteutilisateur c WHERE c.password = :password"),
    @NamedQuery(name = "Compteutilisateur.findByEtat", query = "SELECT c FROM Compteutilisateur c WHERE c.etat = :etat")})
public class Compteutilisateur implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idcompte;
    @Size(max = 254)
    private String login;
    @Size(max = 254)
    private String password;
    private Boolean etat;
    @JoinColumn(name = "idmembre", referencedColumnName = "idmembre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membre idmembre;
    @JoinColumn(name = "idutilisateur", referencedColumnName = "idutilisateur")
    @ManyToOne(fetch = FetchType.LAZY)
    private Utilisateur idutilisateur;
    @OneToMany(mappedBy = "idcompteUtilisateur", fetch = FetchType.LAZY)
    private List<Privilege> privilegeList;
    @OneToMany(mappedBy = "idcompteUtilisateur", fetch = FetchType.LAZY)
    private List<Mouchard> mouchardList;

    public Compteutilisateur() {
    }

    public Compteutilisateur(Integer idcompte) {
        this.idcompte = idcompte;
    }

    public Integer getIdcompte() {
        return idcompte;
    }

    public void setIdcompte(Integer idcompte) {
        this.idcompte = idcompte;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getEtat() {
        return etat;
    }

    public void setEtat(Boolean etat) {
        this.etat = etat;
    }

    public Membre getIdmembre() {
        return idmembre;
    }

    public void setIdmembre(Membre idmembre) {
        this.idmembre = idmembre;
    }

    public Utilisateur getIdutilisateur() {
        return idutilisateur;
    }

    public void setIdutilisateur(Utilisateur idutilisateur) {
        this.idutilisateur = idutilisateur;
    }

    @XmlTransient
    public List<Privilege> getPrivilegeList() {
        return privilegeList;
    }

    public void setPrivilegeList(List<Privilege> privilegeList) {
        this.privilegeList = privilegeList;
    }

    @XmlTransient
    public List<Mouchard> getMouchardList() {
        return mouchardList;
    }

    public void setMouchardList(List<Mouchard> mouchardList) {
        this.mouchardList = mouchardList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idcompte != null ? idcompte.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Compteutilisateur)) {
            return false;
        }
        Compteutilisateur other = (Compteutilisateur) object;
        if ((this.idcompte == null && other.idcompte != null) || (this.idcompte != null && !this.idcompte.equals(other.idcompte))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Compteutilisateur[ idcompte=" + idcompte + " ]";
    }
    
}
