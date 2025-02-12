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
@WebServlet("/Connexion")
public class ConnexionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.getRequestDispatcher("Client/pages/connexion.jsp").forward(request, response);
    }
    

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    response.setContentType("text/html; charset=UTF-8");
    HttpSession session = request.getSession();
    String email = request.getParameter("email");
    String mdp = request.getParameter("mdp");

    try {
        Utilisateurs user = new Utilisateurs();
        user.setNomTable("Utilisateurs");
        Utilisateurs[] users = user.getObject(Utilisateurs.class);

        boolean userFound = false;

        // Parcourir les utilisateurs pour vérifier les informations d'identification
        for (Utilisateurs u : users) {
            if (u.getemail().equals(email) && u.getmotdepasse().equals(mdp)) {
                session.setAttribute("User", u);
                userFound = true;
                break; // Quittez la boucle dès que l'utilisateur est trouvé
            }
        }

        // Redirection basée sur le résultat de la vérification
        if (userFound) {
            response.sendRedirect(request.getContextPath() + "/Accueil");
        } else {
            response.sendRedirect(request.getContextPath() + "/Connexion");
        }
    } catch (Exception e) {
        // Gestion des exceptions
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/Connexion");
    }
}


}
