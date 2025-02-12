package classPage.client;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import Fonction.Fonction;
import classTable.Commandes;
import classTable.DetailsCommande;
import classTable.Produits;
import classTable.Remise;
import classTable.Utilisateurs;

public class PanierPage extends Fonction{
    Remise remise;
    int idCommande;
 
    public PanierPage() {
        remise = new Remise(); // Instance vide de Remise
        remise.loadFirstRemise(); // Charger explicitement les données
    }
    
    public void commander(HttpServletRequest request, HttpServletResponse response){
        String produits_commander = request.getParameter("produits");
        if (produits_commander != null && !produits_commander.isEmpty()) {
            try {
                HttpSession session = request.getSession(false);
                if(session.getAttribute("User") ==null){
                    response.sendRedirect(request.getContextPath() + "/Connexion");
                }else{
                    ObjectMapper mapper = new ObjectMapper();
                    JsonNode produitsNode = mapper.readTree(produits_commander);
    
                    int[] idProduit = new int[produitsNode.size()];
                    double[] quantite = new double[produitsNode.size()];
    
                    for (int i = 0; i < produitsNode.size(); i++) {
                        JsonNode produit = produitsNode.get(i);
                        idProduit[i] = produit.get("idProduit").asInt();
                        quantite[i] = produit.get("quantite").asDouble();
                    }
                    
                    Produits[] produits = (Produits[]) session.getAttribute("panier");
                    
                    for (int i = 0; i < produits.length; i++) {
                        for (int j = 0; j < idProduit.length; j++) {
                            if(produits[i].getid() == idProduit[j]){
                                produits[i].setQtt(quantite[j]);
                            }
                        }
                    }
                    double prixTotal = this.calculPrixTotal(produits);
                    if(verifPrixTotal(prixTotal)){
                        prixTotal = remise(prixTotal);
                    }
                    Utilisateurs user = (Utilisateurs) session.getAttribute("User");
                    Commandes creeCommande = new Commandes(user.getid(), prixTotal, remise.getpourcentage());
                        creeCommande.setNomTable("Commandes");
                        creeCommande.inserer();
                        idCommande = Integer.parseInt(creeCommande.getLastInsert("id"));
    
                    DetailsCommande[] creeDetaillCommande = new DetailsCommande[produits.length];
                        for (int d = 0; d < creeDetaillCommande.length; d++) {
                            creeDetaillCommande[d] = new DetailsCommande(produits[d],idCommande);
                            creeDetaillCommande[d].setNomTable("DetailsCommande");
                            creeDetaillCommande[d].inserer();
                        }
                        this.viderPanier(request);
                        response.sendRedirect(request.getContextPath() + "/Panier");  
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private double calculPrixTotal(Produits[] produits){
        double prix_total = 0;
        for(Produits p: produits){
            prix_total += p.calculPrixPromo() * p.getQtt();
        }
        return prix_total;
    }

    public boolean verifPrixTotal(double total){
        try {
            if (total >= this.remise.getprixatteint()) {
                return true;
            }else{
                return false;
            }
        } catch (Exception e) {
            return false;
        }
    }

    public double remise(double total){
        double pourcentage = remise.getpourcentage();
        double rep = (pourcentage * total)/100;
        return total - rep;
    }

    public void viderPanier(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        session.removeAttribute("panier");
    }
}
