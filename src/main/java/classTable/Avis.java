package classTable;

import Fonction.Fonction;

public class Avis extends Fonction {

    private int id;
    private int utilisateurid;
    private int produitid;
    private int note;
    private String commentaire;
    private java.sql.Timestamp dateavis;

    // Constructeur par défaut
    public Avis() {}

    // Constructeur avec tous les paramètres
    public Avis(int id, int utilisateurid, int produitid, int note, String commentaire, java.sql.Timestamp dateavis) {
        this.id = id;
        this.utilisateurid = utilisateurid;
        this.produitid = produitid;
        this.note = note;
        this.commentaire = commentaire;
        this.dateavis = dateavis;
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

    public int getproduitid() {
        return produitid;
    }

    public void setproduitid(int produitid) {
        this.produitid = produitid;
    }

    public int getnote() {
        return note;
    }

    public void setnote(int note) {
        this.note = note;
    }

    public String getcommentaire() {
        return commentaire;
    }

    public void setcommentaire(String commentaire) {
        this.commentaire = commentaire;
    }

    public java.sql.Timestamp getdateavis() {
        return dateavis;
    }

    public void setdateavis(java.sql.Timestamp dateavis) {
        this.dateavis = dateavis;
    }

}