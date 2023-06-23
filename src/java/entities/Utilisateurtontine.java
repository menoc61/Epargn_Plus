/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Louis Stark
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Utilisateurtontine.findAll", query = "SELECT u FROM Utilisateurtontine u"),
    @NamedQuery(name = "Utilisateurtontine.findByIdutilisateurtontine", query = "SELECT u FROM Utilisateurtontine u WHERE u.idutilisateurtontine = :idutilisateurtontine")})
public class Utilisateurtontine implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idutilisateurtontine;
    @JoinColumn(name = "idtontine", referencedColumnName = "idtontine")
    @ManyToOne(fetch = FetchType.LAZY)
    private Tontine idtontine;
    @JoinColumn(name = "idutilisateur", referencedColumnName = "idutilisateur")
    @ManyToOne(fetch = FetchType.LAZY)
    private Utilisateur idutilisateur;

    public Utilisateurtontine() {
    }

    public Utilisateurtontine(Integer idutilisateurtontine) {
        this.idutilisateurtontine = idutilisateurtontine;
    }

    public Integer getIdutilisateurtontine() {
        return idutilisateurtontine;
    }

    public void setIdutilisateurtontine(Integer idutilisateurtontine) {
        this.idutilisateurtontine = idutilisateurtontine;
    }

    public Tontine getIdtontine() {
        return idtontine;
    }

    public void setIdtontine(Tontine idtontine) {
        this.idtontine = idtontine;
    }

    public Utilisateur getIdutilisateur() {
        return idutilisateur;
    }

    public void setIdutilisateur(Utilisateur idutilisateur) {
        this.idutilisateur = idutilisateur;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idutilisateurtontine != null ? idutilisateurtontine.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Utilisateurtontine)) {
            return false;
        }
        Utilisateurtontine other = (Utilisateurtontine) object;
        if ((this.idutilisateurtontine == null && other.idutilisateurtontine != null) || (this.idutilisateurtontine != null && !this.idutilisateurtontine.equals(other.idutilisateurtontine))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Utilisateurtontine[ idutilisateurtontine=" + idutilisateurtontine + " ]";
    }
    
}
