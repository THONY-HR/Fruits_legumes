package classView;

import Fonction.Fonction;

public class Vente extends Fonction {

    private java.sql.Date datevente;
    private int produitid;
    private String produitnom;
    private double totalvente;
    private int totalquantite;
    private int nombrecommandes;

    // Constructeur par défaut
    public Vente() {}

    // Constructeur avec tous les paramètres
    public Vente(java.sql.Date datevente, int produitid, String produitnom, double totalvente, int totalquantite, int nombrecommandes) {
        this.datevente = datevente;
        this.produitid = produitid;
        this.produitnom = produitnom;
        this.totalvente = totalvente;
        this.totalquantite = totalquantite;
        this.nombrecommandes = nombrecommandes;
    }

    public java.sql.Date getdatevente() {
        return datevente;
    }

    public void setdatevente(java.sql.Date datevente) {
        this.datevente = datevente;
    }

    public int getproduitid() {
        return produitid;
    }

    public void setproduitid(int produitid) {
        this.produitid = produitid;
    }

    public String getproduitnom() {
        return produitnom;
    }

    public void setproduitnom(String produitnom) {
        this.produitnom = produitnom;
    }

    public double gettotalvente() {
        return totalvente;
    }

    public void settotalvente(double totalvente) {
        this.totalvente = totalvente;
    }

    public int gettotalquantite() {
        return totalquantite;
    }

    public void settotalquantite(int totalquantite) {
        this.totalquantite = totalquantite;
    }

    public int getnombrecommandes() {
        return nombrecommandes;
    }

    public void setnombrecommandes(int nombrecommandes) {
        this.nombrecommandes = nombrecommandes;
    }
}