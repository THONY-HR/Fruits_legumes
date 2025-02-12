package classTable;

import Fonction.Fonction;

public class Paiements extends Fonction {

    private int id;
    private int commandeid;
    private int methodepayementid;
    private double montant;
    private String statut;
    private java.sql.Timestamp datepaiement;

    // Constructeur par défaut
    public Paiements() {}

    // Constructeur avec tous les paramètres
    public Paiements(int id, int commandeid, int methodepayementid, double montant, String statut, java.sql.Timestamp datepaiement) {
        this.id = id;
        this.commandeid = commandeid;
        this.methodepayementid = methodepayementid;
        this.montant = montant;
        this.statut = statut;
        this.datepaiement = datepaiement;
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

    public int getmethodepayementid() {
        return methodepayementid;
    }

    public void setmethodepayementid(int methodepayementid) {
        this.methodepayementid = methodepayementid;
    }

    public double getmontant() {
        return montant;
    }

    public void setmontant(double montant) {
        this.montant = montant;
    }

    public String getstatut() {
        return statut;
    }

    public void setstatut(String statut) {
        this.statut = statut;
    }

    public java.sql.Timestamp getdatepaiement() {
        return datepaiement;
    }

    public void setdatepaiement(java.sql.Timestamp datepaiement) {
        this.datepaiement = datepaiement;
    }

}