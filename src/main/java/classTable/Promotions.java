package classTable;

import Fonction.Fonction;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class Promotions extends Fonction {

    private int id;
    private int produitid;
    private double pourcentage;
    private java.sql.Timestamp debut;
    private java.sql.Timestamp fin;

    // Constructeur par défaut
    public Promotions() {}

    // Constructeur avec tous les paramètres
    public Promotions(int id, int produitid, double pourcentage, Timestamp debut, Timestamp fin) {
        this.id = id;
        this.produitid = produitid;
        this.pourcentage = pourcentage;
        this.debut = debut;
        this.fin = fin;
    }

    public Promotions(String produitid, String pourcentage,String debut, String fin){
        LocalDate debutDate = LocalDate.parse(debut);
        LocalDate finDate = LocalDate.parse(fin);
        LocalDateTime debutDateTime = LocalDateTime.of(debutDate, LocalTime.now());
        LocalDateTime finDateTime = LocalDateTime.of(finDate, LocalTime.now());
        Timestamp debutTimestamp = Timestamp.valueOf(debutDateTime);
        Timestamp finTimestamp = Timestamp.valueOf(finDateTime);


        this.produitid = Integer.parseInt(produitid);
        this.pourcentage = Double.parseDouble(pourcentage);
        this.debut = debutTimestamp;
        this.fin = finTimestamp;   
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

    public double getpourcentage() {
        return pourcentage;
    }

    public void setpourcentage(double pourcentage) {
        this.pourcentage = pourcentage;
    }

    public java.sql.Timestamp getdebut() {
        return debut;
    }

    public void setdebut(java.sql.Timestamp debut) {
        this.debut = debut;
    }

    public java.sql.Timestamp getfin() {
        return fin;
    }

    public void setfin(java.sql.Timestamp fin) {
        this.fin = fin;
    }

}