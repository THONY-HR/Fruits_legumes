package classTable;

import Fonction.Fonction;

public class Saisons extends Fonction {

    private int id;
    private String nom;

    // Constructeur par défaut
    public Saisons() {}

    // Constructeur avec tous les paramètres
    public Saisons(int id, String nom) {
        this.id = id;
        this.nom = nom;
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

}