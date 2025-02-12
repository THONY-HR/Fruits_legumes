package classTable;

import Fonction.Fonction;

public class Categories extends Fonction {

    private int id;
    private String nom;
    private int typeid;
    private String description;

    // Constructeur par défaut
    public Categories() {}

    // Constructeur avec tous les paramètres
    public Categories(int id, String nom, int typeid, String description) {
        this.id = id;
        this.nom = nom;
        this.typeid = typeid;
        this.description = description;
    }
    
    public Categories(String nom, String typeid, String description) {
        this.nom = nom;
        this.typeid = Integer.parseInt(typeid) ;
        this.description = description;
    }

    public int getid() {
        return id;
    }

    public void setid(int id) {
        this.id = id;
    }

    public String getnom() {
        return nom;
    }

    public void setnom(String nom) {
        this.nom = nom;
    }

    public int gettypeid() {
        return typeid;
    }

    public void settypeid(int typeid) {
        this.typeid = typeid;
    }

    public String getdescription() {
        return description;
    }

    public void setdescription(String description) {
        this.description = description;
    }

}