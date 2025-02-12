package classPage.client;

import classTable.*;

import java.io.IOException;
// import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Fonction.Fonction;

public class AccueilPage extends Fonction{
    Types[] types;
    Categories[] categories;
    Produits[] produits;
    Saisons[] saisons;
    public void chargerDonner(){
        try {
            this.setNomTable("Types");
            types = this.getObject(Types.class);
    
            this.setNomTable("Categories");
            categories = this.getObject(Categories.class);
    
            this.setNomTable("Produits");
            produits = this.getObject(Produits.class);

            this.setNomTable("Saisons");
            saisons = this.getObject(Saisons.class);
            
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }
    public double calculPromoPrix(){
        return 0;
    }
    public void donnerNecessaire(HttpServletRequest request, HttpServletResponse response){
        try {
            this.chargerDonner();
            request.setAttribute("types", types);
            request.setAttribute("categories", categories);
            request.setAttribute("produits", produits);
            request.setAttribute("saisons", saisons);

            System.out.println("Longueur Produit = " + produits.length);

        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }
    public Produits getProduitById(String id){
        for (Produits produit : produits) {
            if(produit.getid() == Integer.parseInt(id)){
                return produit;
            }
        }
        return null;
    }

    public String sessionPanier(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        try {
            this.chargerDonner();
            // PrintWriter out = response.getWriter();
            String message = "";
            String produitId = request.getParameter("produitid");

            Produits newProduit = this.getProduitById(produitId);
            Produits[] sessionProduits;          
            if (session.getAttribute("panier") == null) {
                sessionProduits = new Produits[1];
                sessionProduits[0] = newProduit;
                session.setAttribute("panier", sessionProduits);
                message = "Produit Ajouter";
            } else {
                sessionProduits = (Produits[]) session.getAttribute("panier");
                for(Produits p: sessionProduits){
                    if(p.getid() == newProduit.getid()){
                        message = "Produits existants";
                    }else{
                        Produits[] newProduits = new Produits[sessionProduits.length + 1];
                        System.arraycopy(sessionProduits, 0, newProduits, 0, sessionProduits.length);
                        newProduits[sessionProduits.length] = newProduit;
                        session.setAttribute("panier", newProduits);
                        message = "Produits ajouter avec succes";
                    }
                }
            }
            return message;
        } catch (Exception e) {
            response.setContentType("text/plain");
            return "Erreur :" + e.getMessage();
        }
    }
}
