package edu.espe.cotbert.forestal.presentation.controller.auth;

import edu.espe.cotbert.forestal.domain.model.security.UserAuthModel;
import edu.espe.cotbert.forestal.domain.model.security.PasswordHasher;
import edu.espe.cotbert.forestal.infraestructure.persistance.UserAuthDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author mateo
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private UserAuthDAO userDAO = new UserAuthDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String username = req.getParameter("email");
        String password = req.getParameter("password");

        UserAuthModel user = userDAO.getUserByEmail(username);
        System.out.println("user login" + user.getUuidUsers());
        System.out.println("password " + user.getPassword());

        if (user != null && PasswordHasher.verify(password,  user.getPassword())) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            resp.sendRedirect("home.jsp");
        } else {
            req.setAttribute("error", "Wrong credentials");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
            req.getRequestDispatcher("login.jsp").forward(req, resp);
    }
}
