package classView;

import Fonction.Fonction;

public class StockRestant extends Fonction {

    private int produitid;
    private String produitnom;
    private int totalentree;
    private int totalsortie;
    private int stockrestant;

    // Constructeur par défaut
    public StockRestant() {}

    // Constructeur avec tous les paramètres
    public StockRestant(int produitid, String produitnom, int totalentree, int totalsortie, int stockrestant) {
        this.produitid = produitid;
        this.produitnom = produitnom;
        this.totalentree = totalentree;
        this.totalsortie = totalsortie;
        this.stockrestant = stockrestant;
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

    public int gettotalentree() {
        return totalentree;
    }

    public void settotalentree(int totalentree) {
        this.totalentree = totalentree;
    }

    public int gettotalsortie() {
        return totalsortie;
    }

    public void settotalsortie(int totalsortie) {
        this.totalsortie = totalsortie;
    }

    public int getstockrestant() {
        return stockrestant;
    }

    public void setstockrestant(int stockrestant) {
        this.stockrestant = stockrestant;
    }

}