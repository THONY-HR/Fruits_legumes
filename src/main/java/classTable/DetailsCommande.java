package classTable;

import Fonction.Fonction;

public class DetailsCommande extends Fonction {

    private int id;
    private int commandeid;
    private int produitid;
    private double quantite;
    private double prixunitaire;

    // Constructeur par défaut
    public DetailsCommande() {}

    // Constructeur avec tous les paramètres
    public DetailsCommande(int commandeid, int produitid, double quantite, double prixunitaire) {
        this.commandeid = commandeid;
        this.produitid = produitid;
        this.quantite = quantite;
        this.prixunitaire = prixunitaire;
    }
    public DetailsCommande(Produits p,int commandeid) {
        this.commandeid = commandeid;
        this.produitid = p.getid();
        this.quantite = p.getQtt();
        this.prixunitaire = p.calculPrixPromo();
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

    public int getproduitid() {
        return produitid;
    }

    public void setproduitid(int produitid) {
        this.produitid = produitid;
    }

    public double getquantite() {
        return quantite;
    }

    public void setquantite(double quantite) {
        this.quantite = quantite;
    }

    public double getprixunitaire() {
        return prixunitaire;
    }

    public void setprixunitaire(double prixunitaire) {
        this.prixunitaire = prixunitaire;
    }

}