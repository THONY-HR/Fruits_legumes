package classTable;

import Fonction.Fonction;

public class StockRestant extends Fonction{

    private int produitid;
    private String produitnom;
    private double totalentree;
    private double totalsortie;
    private double stockrestant;

    // Constructeur par défaut
    public StockRestant() {}

    // Constructeur avec tous les paramètres
    public StockRestant(int produitid, String produitnom, double totalentree, double totalsortie, double stockrestant) {
        this.produitid = produitid;
        this.produitnom = produitnom;
        this.totalentree = totalentree;
        this.totalsortie = totalsortie;
        this.stockrestant = stockrestant;
    }

    // Getters et setters

    public int getid() {
        return produitid;
    }

    public void setid(int produitid) {
        this.produitid = produitid;
    }

    public String getnom() {
        return produitnom;
    }

    public void setnom(String produitnom) {
        this.produitnom = produitnom;
    }

    public double gettotalentree() {
        return totalentree;
    }

    public void settotalentree(double totalentree) {
        this.totalentree = totalentree;
    }

    public double gettotalsortie() {
        return totalsortie;
    }

    public void settotalsortie(double totalsortie) {
        this.totalsortie = totalsortie;
    }

    public double getstockrestant() {
        return stockrestant;
    }

    public void setstockrestant(double stockrestant) {
        this.stockrestant = stockrestant;
    }

    // Méthode toString pour une représentation textuelle de l'objet
    @Override
    public String toString() {
        return "Stockrestant{" +
                "produitid=" + produitid +
                ", produitnom='" + produitnom + '\'' +
                ", totalentree=" + totalentree +
                ", totalsortie=" + totalsortie +
                ", stockrestant=" + stockrestant +
                '}';
    }
}
