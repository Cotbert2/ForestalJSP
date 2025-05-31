package edu.espe.cotbert.forestal.presentation.controller.auth;

import edu.espe.cotbert.forestal.domain.model.security.PasswordHasher;
import edu.espe.cotbert.forestal.domain.model.security.UserAuthModel;
import edu.espe.cotbert.forestal.infraestructure.config.EmailConfig;
import edu.espe.cotbert.forestal.infraestructure.persistance.UserAuthDAO;
import edu.espe.cotbert.forestal.util.MailSender;
import jakarta.persistence.criteria.CriteriaBuilder.In;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.UUID;

/**
 *
 * @author mateo
 */
@WebServlet(name = "register", urlPatterns = {"/register"})
public class Register extends HttpServlet {

    private UserAuthDAO userDAO = new UserAuthDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String password = req.getParameter("password");
        String role = "USER";

        if (userDAO.getUserByEmail(email) != null) {
            req.setAttribute("error", "This email is already registered.");
            req.getRequestDispatcher("singup.jsp").forward(req, resp);
            return;
        }

        String hashedPassword = PasswordHasher.hash(password);

        UserAuthModel newUser = new UserAuthModel(
                UUID.randomUUID().toString(), email, phone, firstName, lastName,
                role, hashedPassword
        );

        // Enviar correo
        
        String htmlContent=EmailConfig.EMAIL_STRUCTURE.replace("{{firstName}}", firstName);

        MailSender.sendEmail(email, "O the road, welcome to Run Forest, Run!", htmlContent);

        boolean created = userDAO.createUser(newUser);

        if (created) {
            resp.sendRedirect("login.jsp");
        } else {
            req.setAttribute("error", "Something went wrong. Please try again.");
            req.getRequestDispatcher("singup.jsp").forward(req, resp);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("singup.jsp").forward(req, resp);

    }
}
