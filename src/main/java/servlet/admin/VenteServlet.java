package servlet.admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classPage.admin.VentePage;

import java.io.IOException;

// Mapping limité au chemin /AccueilAdmin
@WebServlet("/Vente")
public class VenteServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        VentePage ventePage = new VentePage();
            ventePage.donnerNecessaire(request,response);
        request.getRequestDispatcher("Admin/pages/ventes.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
    }    
}
