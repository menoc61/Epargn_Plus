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
@Table(name = "type_remboursement")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TypeRemboursement.findAll", query = "SELECT t FROM TypeRemboursement t"),
    @NamedQuery(name = "TypeRemboursement.findById", query = "SELECT t FROM TypeRemboursement t WHERE t.id = :id"),
    @NamedQuery(name = "TypeRemboursement.findByNom", query = "SELECT t FROM TypeRemboursement t WHERE t.nom = :nom")})
public class TypeRemboursement implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer id;
    @Size(max = 2147483647)
    private String nom;
    @OneToMany(mappedBy = "idtyperemboursement", fetch = FetchType.LAZY)
    private List<Remboursement> remboursementList;

    public TypeRemboursement() {
    }

    public TypeRemboursement(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    @XmlTransient
    public List<Remboursement> getRemboursementList() {
        return remboursementList;
    }

    public void setRemboursementList(List<Remboursement> remboursementList) {
        this.remboursementList = remboursementList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TypeRemboursement)) {
            return false;
        }
        TypeRemboursement other = (TypeRemboursement) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.TypeRemboursement[ id=" + id + " ]";
    }
    
}
