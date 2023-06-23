/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
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
    @NamedQuery(name = "Caisse.findAll", query = "SELECT c FROM Caisse c"),
    @NamedQuery(name = "Caisse.findByIdcaisse", query = "SELECT c FROM Caisse c WHERE c.idcaisse = :idcaisse"),
    @NamedQuery(name = "Caisse.findByMontant", query = "SELECT c FROM Caisse c WHERE c.montant = :montant"),
    @NamedQuery(name = "Caisse.findByDateoperation", query = "SELECT c FROM Caisse c WHERE c.dateoperation = :dateoperation"),
    @NamedQuery(name = "Caisse.findByLibelleoperation", query = "SELECT c FROM Caisse c WHERE c.libelleoperation = :libelleoperation")})
public class Caisse implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Long idcaisse;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montant;
    @Temporal(TemporalType.DATE)
    private Date dateoperation;
    @Size(max = 2147483647)
    private String libelleoperation;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<CollecteMainLevee> collecteMainLeveeList;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<Aide> aideList;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<CotisationTontine> cotisationTontineList;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<CollecteSecours> collecteSecoursList;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<BeneficiaireTontine> beneficiaireTontineList;
    @JoinColumn(name = "idcycle", referencedColumnName = "idcycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Cycletontine idcycle;
    @JoinColumn(name = "idmembrecycle", referencedColumnName = "idmembrecycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membrecycle idmembrecycle;
    @JoinColumn(name = "idrencontre", referencedColumnName = "idrencontre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rencontre idrencontre;
    @JoinColumn(name = "idrubriquecaisse", referencedColumnName = "idrubriquecaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Rubriquecaisse idrubriquecaisse;
    @JoinColumn(name = "idtontiner", referencedColumnName = "idtontiner")
    @ManyToOne(fetch = FetchType.LAZY)
    private Tontiner idtontiner;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<Emprunt> empruntList;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<Encherebenficiare> encherebenficiareList;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<Epargne> epargneList;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<Aidecotisation> aidecotisationList;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<Cassationtontine> cassationtontineList;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<PayementSanction> payementSanctionList;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<Depense> depenseList;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<Recette> recetteList;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<Remboursement> remboursementList;
    @OneToMany(mappedBy = "idcaisse", fetch = FetchType.LAZY)
    private List<Membrecycle> membrecycleList;

    public Caisse() {
    }

    public Caisse(Long idcaisse) {
        this.idcaisse = idcaisse;
    }

    public Long getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(Long idcaisse) {
        this.idcaisse = idcaisse;
    }

    public Double getMontant() {
        return montant;
    }

    public void setMontant(Double montant) {
        this.montant = montant;
    }

    public Date getDateoperation() {
        return dateoperation;
    }

    public void setDateoperation(Date dateoperation) {
        this.dateoperation = dateoperation;
    }

    public String getLibelleoperation() {
        return libelleoperation;
    }

    public void setLibelleoperation(String libelleoperation) {
        this.libelleoperation = libelleoperation;
    }

    @XmlTransient
    public List<CollecteMainLevee> getCollecteMainLeveeList() {
        return collecteMainLeveeList;
    }

    public void setCollecteMainLeveeList(List<CollecteMainLevee> collecteMainLeveeList) {
        this.collecteMainLeveeList = collecteMainLeveeList;
    }

    @XmlTransient
    public List<Aide> getAideList() {
        return aideList;
    }

    public void setAideList(List<Aide> aideList) {
        this.aideList = aideList;
    }

    @XmlTransient
    public List<CotisationTontine> getCotisationTontineList() {
        return cotisationTontineList;
    }

    public void setCotisationTontineList(List<CotisationTontine> cotisationTontineList) {
        this.cotisationTontineList = cotisationTontineList;
    }

    @XmlTransient
    public List<CollecteSecours> getCollecteSecoursList() {
        return collecteSecoursList;
    }

    public void setCollecteSecoursList(List<CollecteSecours> collecteSecoursList) {
        this.collecteSecoursList = collecteSecoursList;
    }

    @XmlTransient
    public List<BeneficiaireTontine> getBeneficiaireTontineList() {
        return beneficiaireTontineList;
    }

    public void setBeneficiaireTontineList(List<BeneficiaireTontine> beneficiaireTontineList) {
        this.beneficiaireTontineList = beneficiaireTontineList;
    }

    public Cycletontine getIdcycle() {
        return idcycle;
    }

    public void setIdcycle(Cycletontine idcycle) {
        this.idcycle = idcycle;
    }

    public Membrecycle getIdmembrecycle() {
        return idmembrecycle;
    }

    public void setIdmembrecycle(Membrecycle idmembrecycle) {
        this.idmembrecycle = idmembrecycle;
    }

    public Rencontre getIdrencontre() {
        return idrencontre;
    }

    public void setIdrencontre(Rencontre idrencontre) {
        this.idrencontre = idrencontre;
    }

    public Rubriquecaisse getIdrubriquecaisse() {
        return idrubriquecaisse;
    }

    public void setIdrubriquecaisse(Rubriquecaisse idrubriquecaisse) {
        this.idrubriquecaisse = idrubriquecaisse;
    }

    public Tontiner getIdtontiner() {
        return idtontiner;
    }

    public void setIdtontiner(Tontiner idtontiner) {
        this.idtontiner = idtontiner;
    }

    @XmlTransient
    public List<Emprunt> getEmpruntList() {
        return empruntList;
    }

    public void setEmpruntList(List<Emprunt> empruntList) {
        this.empruntList = empruntList;
    }

    @XmlTransient
    public List<Encherebenficiare> getEncherebenficiareList() {
        return encherebenficiareList;
    }

    public void setEncherebenficiareList(List<Encherebenficiare> encherebenficiareList) {
        this.encherebenficiareList = encherebenficiareList;
    }

    @XmlTransient
    public List<Epargne> getEpargneList() {
        return epargneList;
    }

    public void setEpargneList(List<Epargne> epargneList) {
        this.epargneList = epargneList;
    }

    @XmlTransient
    public List<Aidecotisation> getAidecotisationList() {
        return aidecotisationList;
    }

    public void setAidecotisationList(List<Aidecotisation> aidecotisationList) {
        this.aidecotisationList = aidecotisationList;
    }

    @XmlTransient
    public List<Cassationtontine> getCassationtontineList() {
        return cassationtontineList;
    }

    public void setCassationtontineList(List<Cassationtontine> cassationtontineList) {
        this.cassationtontineList = cassationtontineList;
    }

    @XmlTransient
    public List<PayementSanction> getPayementSanctionList() {
        return payementSanctionList;
    }

    public void setPayementSanctionList(List<PayementSanction> payementSanctionList) {
        this.payementSanctionList = payementSanctionList;
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

    @XmlTransient
    public List<Remboursement> getRemboursementList() {
        return remboursementList;
    }

    public void setRemboursementList(List<Remboursement> remboursementList) {
        this.remboursementList = remboursementList;
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
        hash += (idcaisse != null ? idcaisse.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Caisse)) {
            return false;
        }
        Caisse other = (Caisse) object;
        if ((this.idcaisse == null && other.idcaisse != null) || (this.idcaisse != null && !this.idcaisse.equals(other.idcaisse))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Caisse[ idcaisse=" + idcaisse + " ]";
    }
    
}
