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
import javax.persistence.Column;
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
    @NamedQuery(name = "Rencontre.findAll", query = "SELECT r FROM Rencontre r"),
    @NamedQuery(name = "Rencontre.findByIdrencontre", query = "SELECT r FROM Rencontre r WHERE r.idrencontre = :idrencontre"),
    @NamedQuery(name = "Rencontre.findByNomfr", query = "SELECT r FROM Rencontre r WHERE r.nomfr = :nomfr"),
    @NamedQuery(name = "Rencontre.findByDaterencontre", query = "SELECT r FROM Rencontre r WHERE r.daterencontre = :daterencontre"),
    @NamedQuery(name = "Rencontre.findByNomen", query = "SELECT r FROM Rencontre r WHERE r.nomen = :nomen"),
    @NamedQuery(name = "Rencontre.findByOuvertureRencontre", query = "SELECT r FROM Rencontre r WHERE r.ouvertureRencontre = :ouvertureRencontre"),
    @NamedQuery(name = "Rencontre.findByHeuredebut", query = "SELECT r FROM Rencontre r WHERE r.heuredebut = :heuredebut"),
    @NamedQuery(name = "Rencontre.findByHeurefin", query = "SELECT r FROM Rencontre r WHERE r.heurefin = :heurefin"),
    @NamedQuery(name = "Rencontre.findByFermetture", query = "SELECT r FROM Rencontre r WHERE r.fermetture = :fermetture"),
    @NamedQuery(name = "Rencontre.findByIsRencontreCotisation", query = "SELECT r FROM Rencontre r WHERE r.isRencontreCotisation = :isRencontreCotisation")})
public class Rencontre implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idrencontre;
    @Size(max = 2147483647)
    private String nomfr;
    @Temporal(TemporalType.DATE)
    private Date daterencontre;
    @Size(max = 2147483647)
    private String nomen;
    @Column(name = "ouverture_rencontre")
    private Boolean ouvertureRencontre;
    @Temporal(TemporalType.TIME)
    private Date heuredebut;
    @Temporal(TemporalType.TIME)
    private Date heurefin;
    private Boolean fermetture;
    @Column(name = "is_rencontre_cotisation")
    private Boolean isRencontreCotisation;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<CollecteMainLevee> collecteMainLeveeList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<FichePresence> fichePresenceList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<Aide> aideList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<Secours> secoursList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<CollecteSecours> collecteSecoursList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<Caisse> caisseList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<Amende> amendeList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<Emprunt> empruntList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<Tontiner> tontinerList;
    @JoinColumn(name = "idcycle", referencedColumnName = "idcycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Cycletontine idcycle;
    @JoinColumn(name = "id_tontine", referencedColumnName = "idtontine")
    @ManyToOne(fetch = FetchType.LAZY)
    private Tontine idTontine;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<EncoursSecours> encoursSecoursList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<Epargne> epargneList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<Ration> rationList;
    @OneToMany(mappedBy = "premierjour", fetch = FetchType.LAZY)
    private List<Cotisation> cotisationList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<RedevanceCotisation> redevanceCotisationList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<Retard> retardList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<PayementSanction> payementSanctionList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<Depense> depenseList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<Recette> recetteList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<CalculInteret> calculInteretList;
    @OneToMany(mappedBy = "idrencontre", fetch = FetchType.LAZY)
    private List<Remboursement> remboursementList;

    public Rencontre() {
    }

    public Rencontre(Integer idrencontre) {
        this.idrencontre = idrencontre;
    }

    public Integer getIdrencontre() {
        return idrencontre;
    }

    public void setIdrencontre(Integer idrencontre) {
        this.idrencontre = idrencontre;
    }

    public String getNomfr() {
        return nomfr;
    }

    public void setNomfr(String nomfr) {
        this.nomfr = nomfr;
    }

    public Date getDaterencontre() {
        return daterencontre;
    }

    public void setDaterencontre(Date daterencontre) {
        this.daterencontre = daterencontre;
    }

    public String getNomen() {
        return nomen;
    }

    public void setNomen(String nomen) {
        this.nomen = nomen;
    }

    public Boolean getOuvertureRencontre() {
        return ouvertureRencontre;
    }

    public void setOuvertureRencontre(Boolean ouvertureRencontre) {
        this.ouvertureRencontre = ouvertureRencontre;
    }

    public Date getHeuredebut() {
        return heuredebut;
    }

    public void setHeuredebut(Date heuredebut) {
        this.heuredebut = heuredebut;
    }

    public Date getHeurefin() {
        return heurefin;
    }

    public void setHeurefin(Date heurefin) {
        this.heurefin = heurefin;
    }

    public Boolean getFermetture() {
        return fermetture;
    }

    public void setFermetture(Boolean fermetture) {
        this.fermetture = fermetture;
    }

    public Boolean getIsRencontreCotisation() {
        return isRencontreCotisation;
    }

    public void setIsRencontreCotisation(Boolean isRencontreCotisation) {
        this.isRencontreCotisation = isRencontreCotisation;
    }

    @XmlTransient
    public List<CollecteMainLevee> getCollecteMainLeveeList() {
        return collecteMainLeveeList;
    }

    public void setCollecteMainLeveeList(List<CollecteMainLevee> collecteMainLeveeList) {
        this.collecteMainLeveeList = collecteMainLeveeList;
    }

    @XmlTransient
    public List<FichePresence> getFichePresenceList() {
        return fichePresenceList;
    }

    public void setFichePresenceList(List<FichePresence> fichePresenceList) {
        this.fichePresenceList = fichePresenceList;
    }

    @XmlTransient
    public List<Aide> getAideList() {
        return aideList;
    }

    public void setAideList(List<Aide> aideList) {
        this.aideList = aideList;
    }

    @XmlTransient
    public List<Secours> getSecoursList() {
        return secoursList;
    }

    public void setSecoursList(List<Secours> secoursList) {
        this.secoursList = secoursList;
    }

    @XmlTransient
    public List<CollecteSecours> getCollecteSecoursList() {
        return collecteSecoursList;
    }

    public void setCollecteSecoursList(List<CollecteSecours> collecteSecoursList) {
        this.collecteSecoursList = collecteSecoursList;
    }

    @XmlTransient
    public List<Caisse> getCaisseList() {
        return caisseList;
    }

    public void setCaisseList(List<Caisse> caisseList) {
        this.caisseList = caisseList;
    }

    @XmlTransient
    public List<Amende> getAmendeList() {
        return amendeList;
    }

    public void setAmendeList(List<Amende> amendeList) {
        this.amendeList = amendeList;
    }

    @XmlTransient
    public List<Emprunt> getEmpruntList() {
        return empruntList;
    }

    public void setEmpruntList(List<Emprunt> empruntList) {
        this.empruntList = empruntList;
    }

    @XmlTransient
    public List<Tontiner> getTontinerList() {
        return tontinerList;
    }

    public void setTontinerList(List<Tontiner> tontinerList) {
        this.tontinerList = tontinerList;
    }

    public Cycletontine getIdcycle() {
        return idcycle;
    }

    public void setIdcycle(Cycletontine idcycle) {
        this.idcycle = idcycle;
    }

    public Tontine getIdTontine() {
        return idTontine;
    }

    public void setIdTontine(Tontine idTontine) {
        this.idTontine = idTontine;
    }

    @XmlTransient
    public List<EncoursSecours> getEncoursSecoursList() {
        return encoursSecoursList;
    }

    public void setEncoursSecoursList(List<EncoursSecours> encoursSecoursList) {
        this.encoursSecoursList = encoursSecoursList;
    }

    @XmlTransient
    public List<Epargne> getEpargneList() {
        return epargneList;
    }

    public void setEpargneList(List<Epargne> epargneList) {
        this.epargneList = epargneList;
    }

    @XmlTransient
    public List<Ration> getRationList() {
        return rationList;
    }

    public void setRationList(List<Ration> rationList) {
        this.rationList = rationList;
    }

    @XmlTransient
    public List<Cotisation> getCotisationList() {
        return cotisationList;
    }

    public void setCotisationList(List<Cotisation> cotisationList) {
        this.cotisationList = cotisationList;
    }

    @XmlTransient
    public List<RedevanceCotisation> getRedevanceCotisationList() {
        return redevanceCotisationList;
    }

    public void setRedevanceCotisationList(List<RedevanceCotisation> redevanceCotisationList) {
        this.redevanceCotisationList = redevanceCotisationList;
    }

    @XmlTransient
    public List<Retard> getRetardList() {
        return retardList;
    }

    public void setRetardList(List<Retard> retardList) {
        this.retardList = retardList;
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
    public List<CalculInteret> getCalculInteretList() {
        return calculInteretList;
    }

    public void setCalculInteretList(List<CalculInteret> calculInteretList) {
        this.calculInteretList = calculInteretList;
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
        hash += (idrencontre != null ? idrencontre.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Rencontre)) {
            return false;
        }
        Rencontre other = (Rencontre) object;
        if ((this.idrencontre == null && other.idrencontre != null) || (this.idrencontre != null && !this.idrencontre.equals(other.idrencontre))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Rencontre[ idrencontre=" + idrencontre + " ]";
    }
    
}
