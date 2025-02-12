package classPage.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import Fonction.Fonction;
import classTable.*;

public class InsertionPage extends Fonction{
    Types[] types;
    Categories[] categories;
    Saisons[] saisons;
    Produits[] produits;
    Stock[] stock;
    Promotions[] promo;
    public void chargerDonner(){
        try {
            this.setNomTable("Types");
            types = this.getObject(Types.class);

            this.setNomTable("Categories");
            categories = this.getObject(Categories.class);

            this.setNomTable("Saisons");
            saisons = this.getObject(Saisons.class);

            this.setNomTable("Produits");
            produits = this.getObject(Produits.class);

            this.setNomTable("Stock");
            stock = this.getObject(Stock.class);

            this.setNomTable("Promotions");
            promo = this.getObject(Promotions.class);
            
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public void donnerNecessaire(HttpServletRequest request, HttpServletResponse response){
        try {
            this.chargerDonner();
            request.setAttribute("types", types);
            request.setAttribute("categories", categories);
            request.setAttribute("saisons", saisons);
            request.setAttribute("produits", produits);
            request.setAttribute("stocks", stock);
            request.setAttribute("promo", promo);

        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public String insertion(HttpServletRequest request, HttpServletResponse response){
        String message = "";
        String reussi = " Ajouter Avec Succes";
        String erreur = "Erreurs lors de l'insertion de ";

        Boolean bool;
        String action = request.getParameter("action");

        switch (action) {
            case "Type":
                try {
                    String name = request.getParameter("type-name");
                    String description = request.getParameter("type-description");

                    Types types = new Types(name,description);
                    types.setNomTable("Types");
                    bool = types.inserer();

                    if (bool) {
                        message = action + reussi;
                    }else{
                        message = erreur + action;
                    } 
                    break;             
                } catch (Exception e) {
                    message = e.getMessage() + " action = " + action;
                    break;
                }
            case "Categorie":
                try {
                    String name = request.getParameter("category-name");
                    String type = request.getParameter("category-type");
                    String description = request.getParameter("category-description");

                    Categories categorie = new Categories(name,type,description);
                    categorie.setNomTable("Categories");
                    bool = categorie.inserer();

                    if (bool) {
                        message = action + reussi;
                    }else{
                        message = erreur + action;
                    } 
                    break;             
                } catch (Exception e) {
                    message = e.getMessage() + " action = " + action;
                    break;
                }
            case "Produits":
                try {
                    String name = request.getParameter("product-name");
                    String categorie = request.getParameter("product-category");
                    String description = request.getParameter("product-description");
                    String saisons = request.getParameter("product-saison");
                    String unite = request.getParameter("product-unite");
                    Part imageImporter = request.getPart("product-image");

                    /* eto zao */
                    Produits produits = new Produits(name,description,categorie,saisons,unite,imageImporter);
                    produits.setNomTable("Produits");
                    bool = produits.inserer();

                    if (bool) {
                        message = action + reussi;
                    }else{
                        message = erreur + action;
                    } 
                    break;             
                } catch (Exception e) {
                    message = e.getMessage() + " action = " + action;
                    break;
                }
            case "Stock":
                try {
                    String product = request.getParameter("stock-product");
                    String quantity = request.getParameter("stock-quantity");
                    String price = request.getParameter("stock-price");
                    String mvt = request.getParameter("stock-mvt");
                    this.setNomTable("stock where produitId = " + product + " ORDER BY dateAjout Desc");
                    /* eto zao */
                    price = String.valueOf(this.getObject(Stock.class)[0].getprix());
                    Stock stock = new Stock(product,quantity,price,mvt);

                    stock.setNomTable("Stock");
                    bool = stock.inserer();

                    if (bool) {
                        message = action + reussi;
                    }else{
                        message = erreur + action;
                    } 
                    break;             
                } catch (Exception e) {
                    message = e.getMessage() + " action = " + action;
                    break;
                }
            case "Prix":
                try {
                    String product = request.getParameter("prix-product");
                    String quantity = request.getParameter("prix-quantity");
                    String price = request.getParameter("prix-price");
                    String mvt = request.getParameter("prix-mvt");
                    java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf(request.getParameter("timestamp"));

                    /* eto zao */
                    Stock stock = new Stock(product,quantity,price,mvt);
                        stock.setdateajout(timestamp);
                    stock.setNomTable("Stock");
                    bool = stock.inserer();

                    if (bool) {
                        message = action + reussi;
                    }else{
                        message = erreur + action;
                    } 
                    break;             
                } catch (Exception e) {
                    message = e.getMessage() + " action = " + action;
                    break;
                }
            case "Promotion":
                try {
                    String product = request.getParameter("promo-product");
                    String pourcentage = request.getParameter("promo-pourcentage");
                    String dateDebut = request.getParameter("promo-dateDebut");
                    String dateFin = request.getParameter("promo-dateFin");
                    

                    /* eto zao */   
                    Promotions promo = new Promotions(product,pourcentage,dateDebut,dateFin);
                    promo.setNomTable("Promotions");
                    bool = promo.inserer();

                    if (bool) {
                        message = action + reussi;
                    }else{
                        message = erreur + action;
                    }
                    break;             
                } catch (Exception e) {
                    message = e.getMessage() + " action = " + action;
                    break;
                }
            default:
                message = "Aucun insertion traiter";
                break;
        }
        return message;
    }
}
