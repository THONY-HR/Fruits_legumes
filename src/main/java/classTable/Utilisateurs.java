package classTable;

import java.sql.Timestamp;


import Fonction.Fonction;

public class Utilisateurs extends Fonction {

    private int id;
    private String nom;
    private String email;
    private String motdepasse;
    private String telephone;
    private java.sql.Timestamp dateinscription;
    private String role;

    // Constructeur par défaut
    public Utilisateurs() {}

    // Constructeur avec tous les paramètres
    public Utilisateurs(int id, String nom, String email, String motdepasse, String telephone, java.sql.Timestamp dateinscription, String role) {
        this.id = id;
        this.nom = nom;
        this.email = email;
        this.motdepasse = motdepasse;
        this.telephone = telephone;
        this.dateinscription = dateinscription;
        this.role = role;
    }

    public Utilisateurs(String nom, String email, String motDePasse, String telephone) {
        this.nom = nom;
        this.email = email;
        this.motdepasse = motDePasse;
        this.telephone = telephone;
        this.dateinscription = new Timestamp(System.currentTimeMillis()); // Date actuelle
        this.role = "client"; // Valeur par défaut
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

    public String getemail() {
        return email;
    }

    public void setemail(String email) {
        this.email = email;
    }

    public String getmotdepasse() {
        return motdepasse;
    }

    public void setmotdepasse(String motdepasse) {
        this.motdepasse = motdepasse;
    }

    public String gettelephone() {
        return telephone;
    }

    public void settelephone(String telephone) {
        this.telephone = telephone;
    }

    public java.sql.Timestamp getdateinscription() {
        return dateinscription;
    }

    public void setdateinscription(java.sql.Timestamp dateinscription) {
        this.dateinscription = dateinscription;
    }

    public String getrole() {
        return role;
    }

    public void setrole(String role) {
        this.role = role;
    }

}