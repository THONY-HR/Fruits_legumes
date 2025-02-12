package servlet.client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classPage.client.AccueilPage;

import java.io.IOException;
import java.io.PrintWriter;
import classTable.*;

// Mapping limité au chemin /AccueilAdmin
@WebServlet("/Accueil")
public class AccueilServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        AccueilPage accueilPage = new AccueilPage();
        accueilPage.donnerNecessaire(request, response);
        // if (request.getParameter("action").equals("pannier")) {
        //     request.getRequestDispatcher("Client/accueil.jsp#catalogue").forward(request, response);
        // }    
        request.getRequestDispatcher("Client/accueil.jsp").forward(request, response);
    }
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        AccueilPage accueilPage = new AccueilPage();
        String message = accueilPage.sessionPanier(request, response,session);
        // out.println(message);
        request.setAttribute("message", message);
        // response.sendRedirect(request.getContextPath() + "/Accueil?action=pannier");
        response.sendRedirect(request.getContextPath() + "/Accueil#catalogue");
        
    }

}
