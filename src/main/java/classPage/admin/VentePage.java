package classPage.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Fonction.Fonction;
import classView.Vente;

public class VentePage extends Fonction{
    Vente[] ventes;
    public void chargerDonner(){
        try {
            this.setNomTable("Vente");
            ventes = this.getObject(Vente.class);  
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public void donnerNecessaire(HttpServletRequest request, HttpServletResponse response){
        try {
            this.chargerDonner();
            request.setAttribute("ventes", ventes);

        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }
}
