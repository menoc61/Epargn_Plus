/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Louis Stark
 */
@Entity
@Table(name = "cotisation_tontine")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CotisationTontine.findAll", query = "SELECT c FROM CotisationTontine c"),
    @NamedQuery(name = "CotisationTontine.findByIdcotisationtontine", query = "SELECT c FROM CotisationTontine c WHERE c.idcotisationtontine = :idcotisationtontine"),
    @NamedQuery(name = "CotisationTontine.findByACotise", query = "SELECT c FROM CotisationTontine c WHERE c.aCotise = :aCotise"),
    @NamedQuery(name = "CotisationTontine.findByReste", query = "SELECT c FROM CotisationTontine c WHERE c.reste = :reste"),
    @NamedQuery(name = "CotisationTontine.findByDoitCotiser", query = "SELECT c FROM CotisationTontine c WHERE c.doitCotiser = :doitCotiser")})
public class CotisationTontine implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long idcotisationtontine;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "a_cotise")
    private Double aCotise;
    private Double reste;
    @Column(name = "doit_cotiser")
    private Double doitCotiser;
    @JoinColumn(name = "idcaisse", referencedColumnName = "idcaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Caisse idcaisse;
    @JoinColumn(name = "idmain", referencedColumnName = "idmain")
    @ManyToOne(fetch = FetchType.LAZY)
    private Mains idmain;
    @JoinColumn(name = "idtontiner", referencedColumnName = "idtontiner")
    @ManyToOne(fetch = FetchType.LAZY)
    private Tontiner idtontiner;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idcotisationtontine", fetch = FetchType.LAZY)
    private List<Aidecotisation> aidecotisationList;

    public CotisationTontine() {
    }

    public CotisationTontine(Long idcotisationtontine) {
        this.idcotisationtontine = idcotisationtontine;
    }

    public Long getIdcotisationtontine() {
        return idcotisationtontine;
    }

    public void setIdcotisationtontine(Long idcotisationtontine) {
        this.idcotisationtontine = idcotisationtontine;
    }

    public Double getACotise() {
        return aCotise;
    }

    public void setACotise(Double aCotise) {
        this.aCotise = aCotise;
    }

    public Double getReste() {
        return reste;
    }

    public void setReste(Double reste) {
        this.reste = reste;
    }

    public Double getDoitCotiser() {
        return doitCotiser;
    }

    public void setDoitCotiser(Double doitCotiser) {
        this.doitCotiser = doitCotiser;
    }

    public Caisse getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(Caisse idcaisse) {
        this.idcaisse = idcaisse;
    }

    public Mains getIdmain() {
        return idmain;
    }

    public void setIdmain(Mains idmain) {
        this.idmain = idmain;
    }

    public Tontiner getIdtontiner() {
        return idtontiner;
    }

    public void setIdtontiner(Tontiner idtontiner) {
        this.idtontiner = idtontiner;
    }

    @XmlTransient
    public List<Aidecotisation> getAidecotisationList() {
        return aidecotisationList;
    }

    public void setAidecotisationList(List<Aidecotisation> aidecotisationList) {
        this.aidecotisationList = aidecotisationList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idcotisationtontine != null ? idcotisationtontine.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CotisationTontine)) {
            return false;
        }
        CotisationTontine other = (CotisationTontine) object;
        if ((this.idcotisationtontine == null && other.idcotisationtontine != null) || (this.idcotisationtontine != null && !this.idcotisationtontine.equals(other.idcotisationtontine))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.CotisationTontine[ idcotisationtontine=" + idcotisationtontine + " ]";
    }
    
}
