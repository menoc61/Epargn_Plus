/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
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
    @NamedQuery(name = "Statutmembre.findAll", query = "SELECT s FROM Statutmembre s"),
    @NamedQuery(name = "Statutmembre.findByIdstatut", query = "SELECT s FROM Statutmembre s WHERE s.idstatut = :idstatut"),
    @NamedQuery(name = "Statutmembre.findByNom", query = "SELECT s FROM Statutmembre s WHERE s.nom = :nom")})
public class Statutmembre implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idstatut;
    @Size(max = 2147483647)
    private String nom;

    public Statutmembre() {
    }

    public Statutmembre(Integer idstatut) {
        this.idstatut = idstatut;
    }

    public Integer getIdstatut() {
        return idstatut;
    }

    public void setIdstatut(Integer idstatut) {
        this.idstatut = idstatut;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idstatut != null ? idstatut.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Statutmembre)) {
            return false;
        }
        Statutmembre other = (Statutmembre) object;
        if ((this.idstatut == null && other.idstatut != null) || (this.idstatut != null && !this.idstatut.equals(other.idstatut))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Statutmembre[ idstatut=" + idstatut + " ]";
    }
    
}
