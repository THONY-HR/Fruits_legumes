package classTable;

import java.sql.Timestamp;
import java.util.Base64;

import javax.servlet.http.Part;

import Fonction.Fonction;

public class Produits extends Fonction {

    private int id;
    private String nom;
    private String description;
    private byte[] image;
    private int categorieid;
    private int saisonid;
    private String unite;
    private java.sql.Timestamp dateajout;

    // Constructeur par défaut
    public Produits() {}

    // Constructeur avec tous les paramètres
    public Produits(int id, String nom, String description, byte[] image, int categorieid, java.sql.Timestamp dateajout) {
        this.id = id;
        this.nom = nom;
        this.description = description;
        this.image = image;
        this.categorieid = categorieid;
        this.dateajout = dateajout;
    }
    public Produits(String nom, String description,String categorieid, String saisonsid,String unite,Part image) {
        try {
            this.nom = nom;
            this.description = description;
            this.image = this.convertToBytes(image);
            this.categorieid = Integer.parseInt(categorieid);
            this.saisonid = Integer.parseInt(saisonsid);
            this.unite = unite;
            this.dateajout = new Timestamp(System.currentTimeMillis());            
        } catch (Exception e) {
            e.getStackTrace();
        }

    }
    public Produits(String nom, String description, int categorieid) {
        this.nom = nom;
        this.description = description;
        this.categorieid = categorieid;
        this.dateajout = new Timestamp(System.currentTimeMillis());
    }

    public int getid() {
        return id;
    }

    public void setid(int id) {
        this.id = id;
    }

    public int getunite() {
        return id;
    }

    public void setunite(String unite) {
        this.unite = unite;
    }

    public String getnom() {
        return nom;
    }

    public void setnom(String nom) {
        this.nom = nom;
    }

    public String getdescription() {
        return description;
    }

    public void setdescription(String description) {
        this.description = description;
    }

    public byte[] getimage() {
        return image;
    }

    public String getimageS() {
        String imageBase64 = Base64.getEncoder().encodeToString(this.image);
        String image = "data:image/jpeg;base64," + imageBase64 ;
        return image;
    }

    public void setimage(byte[] image) {
        this.image = image;
    }

    public int getcategorieid() {
        return categorieid;
    }

    public void setcategorieid(int categorieid) {
        this.categorieid = categorieid;
    }

    public int getsaisonid() {
        return saisonid;
    }

    public void setsaisonid(int saisonid) {
        this.saisonid = saisonid;
    }

    public java.sql.Timestamp getdateajout() {
        return dateajout;
    }

    public void setdateajout(java.sql.Timestamp dateajout) {
        this.dateajout = dateajout;
    }

    public Boolean verifProm() {
        try {
            Timestamp dateNow = new Timestamp(System.currentTimeMillis());
            this.setNomTable("Promotions WHERE produitId=" + this.getid() + " ORDER BY debut DESC");
            
            Promotions[] promo = this.getObject(Promotions.class); 
    
            if (promo == null || promo.length == 0) {
                return false;
            }
    
            Promotions currentPromo = promo[0];
            if (dateNow.compareTo(currentPromo.getdebut()) >= 0
                    && dateNow.compareTo(currentPromo.getfin()) <= 0) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            System.err.println("Produits.verifProm ..id=" + this.getid() + " - " + e.getMessage());
            return false;
        }
    }
    

    public double calculPrixPromo(){
        try {
            double pourcentage = 0;
            if (this.verifProm()) {
                this.setNomTable("Promotions WHERE produitId=" + this.getid() + " ORDER BY debut DESC");
                Promotions[] promo = this.getObject(Promotions.class); 
                pourcentage = (promo[0].getpourcentage() * this.getprix()) / 100;
                return this.getprix() - pourcentage;
            }           
            return this.getprix();
        } catch (Exception e) {
            return this.getprix();
        }
    }

    public double getprix(){
        try {
            this.setNomTable("Stock WHERE produitId = "+this.getid()+" AND typemvt = 0 ORDER BY dateAjout DESC LIMIT 1");
            Stock[] stocks = this.getObject(Stock.class); 
            return stocks[0].getprix();          
        } catch (Exception e) {
            System.err.println("Produits.getPrix..id="+this.getid()+e.getMessage());
            return 0;
        }
    }
    public StockRestant getStock(){
        try {
            this.setNomTable("StockRestant WHERE produitid = "+this.getid());
            StockRestant[] stocks = this.getObject(StockRestant.class); 
            return stocks[0];          
        } catch (Exception e) {
            System.err.println("Produits.getPrix..id="+this.getid()+e.getMessage());
            return new StockRestant();
        }
    }

    public Stock[] getHistoriquePrix(){
        try {
            this.setNomTable("Stock WHERE produitId = "+this.getid());
            Stock[] stocks = this.getObject(Stock.class); 
            return stocks;          
        } catch (Exception e) {
            System.err.println("Produits.getPrix..id="+this.getid()+e.getMessage());
            return new Stock[0];
        }       
    }
    public Promotions getPromotions(){
        try {
            this.setNomTable("Promotions WHERE produitId=" + this.getid() + " ORDER BY debut DESC");
            Promotions[] promo = this.getObject(Promotions.class); 
            return promo[0];          
        } catch (Exception e) {
            System.err.println("Produits.getPromotions ..id="+this.getid()+e.getMessage());
            return new Promotions();
        }
    }
    public Categories getCategorie(){
        try {
            this.setNomTable("categories WHERE id = "+this.getcategorieid());
            Categories[] categories = this.getObject(Categories.class); 
            return categories[0];          
        } catch (Exception e) {
            System.err.println("Produits.getPrix..id="+this.getid()+e.getMessage());
            return new Categories();
        }
    }
    public Saisons getSaisons(){
        try {
            this.setNomTable("Saisons WHERE id = "+this.getsaisonid());
            Saisons[] saisons = this.getObject(Saisons.class); 
            return saisons[0];          
        } catch (Exception e) {
            System.err.println("Produits.getPrix..id="+this.getid()+e.getMessage());
            return new Saisons();
        }
    }
}