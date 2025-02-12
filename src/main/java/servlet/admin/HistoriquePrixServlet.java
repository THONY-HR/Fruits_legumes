package servlet.admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classPage.admin.HistoriquePrixPage;

import java.io.IOException;

// Mapping limité au chemin /AccueilAdmin
@WebServlet("/HistoriquePrix")
public class HistoriquePrixServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HistoriquePrixPage historiquePrixPage = new HistoriquePrixPage();
        historiquePrixPage.donnerNecessaire(request,response);
        request.getRequestDispatcher("Admin/pages/historiquePrix.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {   
        response.setContentType("text/html; charset=UTF-8");
        HistoriquePrixPage historiquePrixPage = new HistoriquePrixPage();
            historiquePrixPage.voirHistoriqueparProduit(request,response);
        request.getRequestDispatcher("Admin/pages/detailleHistorique.jsp").forward(request, response);
    }    
}
