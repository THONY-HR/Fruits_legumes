package classPage.client;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Fonction.Fonction;
import classTable.Commandes;
import classTable.Utilisateurs;

public class CommandePage extends Fonction{
    Commandes[] commandes;
    
    public void chargerDonner(int idUser){
        try {
            this.setNomTable("Commandes WHERE utilisateurId = " + idUser);
            commandes = this.getObject(Commandes.class);       
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public void donnerNecessaire(HttpServletRequest request, HttpServletResponse response){
        try {
            HttpSession session = request.getSession();
            if (session.getAttribute("User") != null) {
                Utilisateurs user = (Utilisateurs) session.getAttribute("User");
                this.chargerDonner(user.getid());
            }else{
                commandes = new Commandes[0];
            }
            request.setAttribute("commandes", commandes);
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }
}
