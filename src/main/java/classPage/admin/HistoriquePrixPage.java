package classPage.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Fonction.Fonction;
import classTable.Produits;

public class HistoriquePrixPage extends Fonction{
    Produits[] produits;
    public void chargerDonner(){
        try {
            this.setNomTable("Produits");
            produits = this.getObject(Produits.class);  
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public void donnerNecessaire(HttpServletRequest request, HttpServletResponse response){
        try {
            this.chargerDonner();
            request.setAttribute("produits", produits);
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }
    
    public void voirHistoriqueparProduit(HttpServletRequest request, HttpServletResponse response){
        try {
            String idProduit = request.getParameter("idProduit");
            this.setNomTable("Produits WHERE id=" + idProduit);
            Produits p = this.getObject(Produits.class)[0];
            request.setAttribute("produit", p);
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    } 
}
