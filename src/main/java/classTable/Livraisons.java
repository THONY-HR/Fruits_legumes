package classTable;

import Fonction.Fonction;

public class Livraisons extends Fonction {

    private int id;
    private int commandeid;
    private String adresselivraison;
    private String ville;
    private String codepostal;
    private java.sql.Timestamp datelivraison;
    private String statut;

    // Constructeur par défaut
    public Livraisons() {}

    // Constructeur avec tous les paramètres
    public Livraisons(int id, int commandeid, String adresselivraison, String ville, String codepostal, java.sql.Timestamp datelivraison, String statut) {
        this.id = id;
        this.commandeid = commandeid;
        this.adresselivraison = adresselivraison;
        this.ville = ville;
        this.codepostal = codepostal;
        this.datelivraison = datelivraison;
        this.statut = statut;
    }

    public int getid() {
        return id;
    }

    public void setid(int id) {
        this.id = id;
    }

    public int getcommandeid() {
        return commandeid;
    }

    public void setcommandeid(int commandeid) {
        this.commandeid = commandeid;
    }

    public String getadresselivraison() {
        return adresselivraison;
    }

    public void setadresselivraison(String adresselivraison) {
        this.adresselivraison = adresselivraison;
    }

    public String getville() {
        return ville;
    }

    public void setville(String ville) {
        this.ville = ville;
    }

    public String getcodepostal() {
        return codepostal;
    }

    public void setcodepostal(String codepostal) {
        this.codepostal = codepostal;
    }

    public java.sql.Timestamp getdatelivraison() {
        return datelivraison;
    }

    public void setdatelivraison(java.sql.Timestamp datelivraison) {
        this.datelivraison = datelivraison;
    }

    public String getstatut() {
        return statut;
    }

    public void setstatut(String statut) {
        this.statut = statut;
    }

}