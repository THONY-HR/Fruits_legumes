package servlet.admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classPage.admin.InsertionPage;

import java.io.IOException;
import java.io.PrintWriter;

// Mapping limité au chemin /Insertion
@WebServlet("/Insertion")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10, //10MB
    maxRequestSize = 1024 * 1024 * 50 //50MB
)

public class InsertionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        InsertionPage insertionPage = new InsertionPage();
        insertionPage.donnerNecessaire(request, response);
        request.getRequestDispatcher("Admin/pages/insertion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        InsertionPage insertionPage = new InsertionPage();
        String message = insertionPage.insertion(request, response);
            request.getSession().setAttribute("message", message);
        // PrintWriter out = response.getWriter();
        // out.println(message);
            response.sendRedirect(request.getContextPath() + "/Insertion");
    }
}