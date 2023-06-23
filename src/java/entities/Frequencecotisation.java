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
    @NamedQuery(name = "Frequencecotisation.findAll", query = "SELECT f FROM Frequencecotisation f"),
    @NamedQuery(name = "Frequencecotisation.findByIdfrequence", query = "SELECT f FROM Frequencecotisation f WHERE f.idfrequence = :idfrequence"),
    @NamedQuery(name = "Frequencecotisation.findByDenomination", query = "SELECT f FROM Frequencecotisation f WHERE f.denomination = :denomination"),
    @NamedQuery(name = "Frequencecotisation.findByValeur", query = "SELECT f FROM Frequencecotisation f WHERE f.valeur = :valeur")})
public class Frequencecotisation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idfrequence;
    @Size(max = 254)
    private String denomination;
    private Integer valeur;

    public Frequencecotisation() {
    }

    public Frequencecotisation(Integer idfrequence) {
        this.idfrequence = idfrequence;
    }

    public Integer getIdfrequence() {
        return idfrequence;
    }

    public void setIdfrequence(Integer idfrequence) {
        this.idfrequence = idfrequence;
    }

    public String getDenomination() {
        return denomination;
    }

    public void setDenomination(String denomination) {
        this.denomination = denomination;
    }

    public Integer getValeur() {
        return valeur;
    }

    public void setValeur(Integer valeur) {
        this.valeur = valeur;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idfrequence != null ? idfrequence.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Frequencecotisation)) {
            return false;
        }
        Frequencecotisation other = (Frequencecotisation) object;
        if ((this.idfrequence == null && other.idfrequence != null) || (this.idfrequence != null && !this.idfrequence.equals(other.idfrequence))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Frequencecotisation[ idfrequence=" + idfrequence + " ]";
    }
    
}
