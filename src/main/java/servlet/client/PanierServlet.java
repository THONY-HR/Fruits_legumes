package servlet.client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import classPage.client.PanierPage;
import classTable.Produits;
import classTable.Remise;

@WebServlet("/Panier")
public class PanierServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Produits[] produits = (Produits[]) session.getAttribute("panier");
        Remise remise = new Remise();
            remise = new Remise(); // Instance vide de Remise
            remise.loadFirstRemise(); // Charger explicitement les données
        request.setAttribute("remise", remise);
        if (produits != null) {
            request.setAttribute("produits", produits);
        } else {
            request.setAttribute("produits", new Produits[0]);
        }

        request.getRequestDispatcher("Client/pages/panier.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        PanierPage panierPage = new PanierPage();
        if(request.getParameter("action") != null && request.getParameter("action").equals("viderPanier")){
            panierPage.viderPanier(request);
            response.sendRedirect(request.getContextPath() + "/Panier"); 
        }else{
            panierPage.commander(request, response);
        } 
    }


}
