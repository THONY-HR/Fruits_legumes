package servlet.client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classPage.client.CommandePage;

import java.io.IOException;

// Mapping limité au chemin /AccueilAdmin
@WebServlet("/Commande")
public class CommandeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        
        CommandePage commandePage = new CommandePage();
            commandePage.donnerNecessaire(request,response);
            request.getRequestDispatcher("Client/pages/commandes.jsp").forward(request, response);
    }
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        
    }

}
