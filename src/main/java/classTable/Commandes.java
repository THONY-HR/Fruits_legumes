package classTable;

import java.sql.Timestamp;

import Fonction.Fonction;

public class Commandes extends Fonction {

    private int id;
    private int utilisateurid;
    private String statut = "valide";
    private double total;
    private double remise;
    private java.sql.Timestamp datecommande;

    // Constructeur par défaut
    public Commandes() {}

    // Constructeur avec tous les paramètres
    public Commandes(int utilisateurid, double total, double remise) {
        this.utilisateurid = utilisateurid;
        this.total = total;
        this.remise = remise;
        this.datecommande = new Timestamp(System.currentTimeMillis());
    }

    public int getid() {
        return id;
    }

    public void setid(int id) {
        this.id = id;
    }

    public int getutilisateurid() {
        return utilisateurid;
    }

    public void setutilisateurid(int utilisateurid) {
        this.utilisateurid = utilisateurid;
    }

    public String getstatut() {
        return statut;
    }

    public void setstatut(String statut) {
        this.statut = statut;
    }

    public double gettotal() {
        return total;
    }

    public void settotal(double total) {
        this.total = total;
    }

    public java.sql.Timestamp getdatecommande() {
        return datecommande;
    }

    public void setdatecommande(java.sql.Timestamp datecommande) {
        this.datecommande = datecommande;
    }

    public double getremise(){
        return this.remise;
    }

    public void setremise(double remise){
        this.remise = remise;
    }

    public DetailsCommande[] detailsCommandes() throws Exception{
        try {
            this.setNomTable("DetailsCommande");
            DetailsCommande[] detaillCommandes = this.getObject(DetailsCommande.class);
            return detaillCommandes;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }
}