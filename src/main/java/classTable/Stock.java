package classTable;

import java.sql.Timestamp;

import Fonction.Fonction;

public class Stock extends Fonction {
    private int id;
    private int produitid;
    private int quantitedisponible;
    private int typemvt;
    private double prix;
    private java.sql.Timestamp dateajout;

    // Constructeur par défaut
    public Stock() {}

    // Constructeur avec tous les paramètres
    public Stock(int id, int produitid, int quantitedisponible, double prix, java.sql.Timestamp dateajout) {
        this.id = id;
        this.produitid = produitid;
        this.quantitedisponible = quantitedisponible;
        this.prix = prix;
        this.dateajout = dateajout;
    }
    public Stock(String produitid, String quantitedisponible, String prix, String mvt) {
        this.produitid = Integer.parseInt(produitid);
        this.quantitedisponible = Integer.parseInt(quantitedisponible);
        this.typemvt = Integer.parseInt(mvt);
        this.prix = Double.parseDouble(prix);
        this.dateajout = new Timestamp(System.currentTimeMillis());
    }

    public int getid() {
        return id;
    }

    public void setid(int id) {
        this.id = id;
    }

    public int getproduitid() {
        return produitid;
    }

    public void setproduitid(int produitid) {
        this.produitid = produitid;
    }

    public int getquantitedisponible() {
        return quantitedisponible;
    }

    public void setquantitedisponible(int quantitedisponible) {
        this.quantitedisponible = quantitedisponible;
    }

    public double getprix() {
        return prix;
    }

    public void setprix(double prix) {
        this.prix = prix;
    }

    public java.sql.Timestamp getdateajout() {
        return dateajout;
    }

    public void setdateajout(java.sql.Timestamp dateajout) {
        this.dateajout = dateajout;
    }

}