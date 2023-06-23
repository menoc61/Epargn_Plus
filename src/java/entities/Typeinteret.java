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
    @NamedQuery(name = "Typeinteret.findAll", query = "SELECT t FROM Typeinteret t"),
    @NamedQuery(name = "Typeinteret.findByIdtypeinteret", query = "SELECT t FROM Typeinteret t WHERE t.idtypeinteret = :idtypeinteret"),
    @NamedQuery(name = "Typeinteret.findByNomFr", query = "SELECT t FROM Typeinteret t WHERE t.nomFr = :nomFr"),
    @NamedQuery(name = "Typeinteret.findByNomEn", query = "SELECT t FROM Typeinteret t WHERE t.nomEn = :nomEn")})
public class Typeinteret implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idtypeinteret;
    @Size(max = 254)
    @Column(name = "nom_fr")
    private String nomFr;
    @Size(max = 254)
    @Column(name = "nom_en")
    private String nomEn;
    @OneToMany(mappedBy = "idtypeinteret", fetch = FetchType.LAZY)
    private List<Emprunt> empruntList;

    public Typeinteret() {
    }

    public Typeinteret(Integer idtypeinteret) {
        this.idtypeinteret = idtypeinteret;
    }

    public Integer getIdtypeinteret() {
        return idtypeinteret;
    }

    public void setIdtypeinteret(Integer idtypeinteret) {
        this.idtypeinteret = idtypeinteret;
    }

    public String getNomFr() {
        return nomFr;
    }

    public void setNomFr(String nomFr) {
        this.nomFr = nomFr;
    }

    public String getNomEn() {
        return nomEn;
    }

    public void setNomEn(String nomEn) {
        this.nomEn = nomEn;
    }

    @XmlTransient
    public List<Emprunt> getEmpruntList() {
        return empruntList;
    }

    public void setEmpruntList(List<Emprunt> empruntList) {
        this.empruntList = empruntList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idtypeinteret != null ? idtypeinteret.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Typeinteret)) {
            return false;
        }
        Typeinteret other = (Typeinteret) object;
        if ((this.idtypeinteret == null && other.idtypeinteret != null) || (this.idtypeinteret != null && !this.idtypeinteret.equals(other.idtypeinteret))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Typeinteret[ idtypeinteret=" + idtypeinteret + " ]";
    }
    
}
