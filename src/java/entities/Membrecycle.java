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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Louis Stark
 */
@Entity
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Membrecycle.findAll", query = "SELECT m FROM Membrecycle m"),
    @NamedQuery(name = "Membrecycle.findByIdmembrecycle", query = "SELECT m FROM Membrecycle m WHERE m.idmembrecycle = :idmembrecycle"),
    @NamedQuery(name = "Membrecycle.findByMontantavalise", query = "SELECT m FROM Membrecycle m WHERE m.montantavalise = :montantavalise"),
    @NamedQuery(name = "Membrecycle.findByMontantSecours", query = "SELECT m FROM Membrecycle m WHERE m.montantSecours = :montantSecours"),
    @NamedQuery(name = "Membrecycle.findByResteMainLevee", query = "SELECT m FROM Membrecycle m WHERE m.resteMainLevee = :resteMainLevee"),
    @NamedQuery(name = "Membrecycle.findByEtat", query = "SELECT m FROM Membrecycle m WHERE m.etat = :etat"),
    @NamedQuery(name = "Membrecycle.findByFraisadhesion", query = "SELECT m FROM Membrecycle m WHERE m.fraisadhesion = :fraisadhesion")})
public class Membrecycle implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer idmembrecycle;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private Double montantavalise;
    @Column(name = "montant_secours")
    private Double montantSecours;
    @Column(name = "reste_main_levee")
    private Double resteMainLevee;
    private Boolean etat;
    private Double fraisadhesion;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<CollecteMainLevee> collecteMainLeveeList;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<FichePresence> fichePresenceList;
    @OneToMany(mappedBy = "idbeneficiare", fetch = FetchType.LAZY)
    private List<Aide> aideList;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<Aide> aideList1;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<InscriptionCotisation> inscriptionCotisationList;
    @OneToMany(mappedBy = "idmembrecycle", fetch = FetchType.LAZY)
    private List<Secours> secoursList;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<CollecteSecours> collecteSecoursList;
    @OneToMany(mappedBy = "idmembrecycle", fetch = FetchType.LAZY)
    private List<Caisse> caisseList;
    @OneToMany(mappedBy = "idmembrecycle", fetch = FetchType.LAZY)
    private List<Amende> amendeList;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<Emprunt> empruntList;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<EncoursSecours> encoursSecoursList;
    @OneToMany(mappedBy = "idmembrecycle", fetch = FetchType.LAZY)
    private List<Epargne> epargneList;
    @OneToMany(mappedBy = "membreAvalyste", fetch = FetchType.LAZY)
    private List<Avalyse> avalyseList;
    @OneToMany(mappedBy = "idmembrecycle", fetch = FetchType.LAZY)
    private List<Aidecotisation> aidecotisationList;
    @OneToMany(mappedBy = "idmembrecycle", fetch = FetchType.LAZY)
    private List<Ration> rationList;
    @OneToMany(mappedBy = "idmembrecycle", fetch = FetchType.LAZY)
    private List<Retard> retardList;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<Cassation> cassationList;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<CassationDetail> cassationDetailList;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<CalculInteret> calculInteretList;
    @OneToMany(mappedBy = "idmembre", fetch = FetchType.LAZY)
    private List<AideMembre> aideMembreList;
    @JoinColumn(name = "idcaisse", referencedColumnName = "idcaisse")
    @ManyToOne(fetch = FetchType.LAZY)
    private Caisse idcaisse;
    @JoinColumn(name = "idcycle", referencedColumnName = "idcycle")
    @ManyToOne(fetch = FetchType.LAZY)
    private Cycletontine idcycle;
    @JoinColumn(name = "idmembre", referencedColumnName = "idmembre")
    @ManyToOne(fetch = FetchType.LAZY)
    private Membre idmembre;

    public Membrecycle() {
    }

    public Membrecycle(Integer idmembrecycle) {
        this.idmembrecycle = idmembrecycle;
    }

    public Integer getIdmembrecycle() {
        return idmembrecycle;
    }

    public void setIdmembrecycle(Integer idmembrecycle) {
        this.idmembrecycle = idmembrecycle;
    }

    public Double getMontantavalise() {
        return montantavalise;
    }

    public void setMontantavalise(Double montantavalise) {
        this.montantavalise = montantavalise;
    }

    public Double getMontantSecours() {
        return montantSecours;
    }

    public void setMontantSecours(Double montantSecours) {
        this.montantSecours = montantSecours;
    }

    public Double getResteMainLevee() {
        return resteMainLevee;
    }

    public void setResteMainLevee(Double resteMainLevee) {
        this.resteMainLevee = resteMainLevee;
    }

    public Boolean getEtat() {
        return etat;
    }

    public void setEtat(Boolean etat) {
        this.etat = etat;
    }

    public Double getFraisadhesion() {
        return fraisadhesion;
    }

    public void setFraisadhesion(Double fraisadhesion) {
        this.fraisadhesion = fraisadhesion;
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
    public List<Aide> getAideList1() {
        return aideList1;
    }

    public void setAideList1(List<Aide> aideList1) {
        this.aideList1 = aideList1;
    }

    @XmlTransient
    public List<InscriptionCotisation> getInscriptionCotisationList() {
        return inscriptionCotisationList;
    }

    public void setInscriptionCotisationList(List<InscriptionCotisation> inscriptionCotisationList) {
        this.inscriptionCotisationList = inscriptionCotisationList;
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
    public List<Avalyse> getAvalyseList() {
        return avalyseList;
    }

    public void setAvalyseList(List<Avalyse> avalyseList) {
        this.avalyseList = avalyseList;
    }

    @XmlTransient
    public List<Aidecotisation> getAidecotisationList() {
        return aidecotisationList;
    }

    public void setAidecotisationList(List<Aidecotisation> aidecotisationList) {
        this.aidecotisationList = aidecotisationList;
    }

    @XmlTransient
    public List<Ration> getRationList() {
        return rationList;
    }

    public void setRationList(List<Ration> rationList) {
        this.rationList = rationList;
    }

    @XmlTransient
    public List<Retard> getRetardList() {
        return retardList;
    }

    public void setRetardList(List<Retard> retardList) {
        this.retardList = retardList;
    }

    @XmlTransient
    public List<Cassation> getCassationList() {
        return cassationList;
    }

    public void setCassationList(List<Cassation> cassationList) {
        this.cassationList = cassationList;
    }

    @XmlTransient
    public List<CassationDetail> getCassationDetailList() {
        return cassationDetailList;
    }

    public void setCassationDetailList(List<CassationDetail> cassationDetailList) {
        this.cassationDetailList = cassationDetailList;
    }

    @XmlTransient
    public List<CalculInteret> getCalculInteretList() {
        return calculInteretList;
    }

    public void setCalculInteretList(List<CalculInteret> calculInteretList) {
        this.calculInteretList = calculInteretList;
    }

    @XmlTransient
    public List<AideMembre> getAideMembreList() {
        return aideMembreList;
    }

    public void setAideMembreList(List<AideMembre> aideMembreList) {
        this.aideMembreList = aideMembreList;
    }

    public Caisse getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(Caisse idcaisse) {
        this.idcaisse = idcaisse;
    }

    public Cycletontine getIdcycle() {
        return idcycle;
    }

    public void setIdcycle(Cycletontine idcycle) {
        this.idcycle = idcycle;
    }

    public Membre getIdmembre() {
        return idmembre;
    }

    public void setIdmembre(Membre idmembre) {
        this.idmembre = idmembre;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idmembrecycle != null ? idmembrecycle.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Membrecycle)) {
            return false;
        }
        Membrecycle other = (Membrecycle) object;
        if ((this.idmembrecycle == null && other.idmembrecycle != null) || (this.idmembrecycle != null && !this.idmembrecycle.equals(other.idmembrecycle))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Membrecycle[ idmembrecycle=" + idmembrecycle + " ]";
    }
    
}
