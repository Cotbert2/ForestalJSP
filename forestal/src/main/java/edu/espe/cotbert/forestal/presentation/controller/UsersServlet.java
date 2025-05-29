/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package edu.espe.cotbert.forestal.presentation.controller;

import edu.espe.cotbert.forestal.domain.model.security.UserAuthModel;
import edu.espe.cotbert.forestal.infraestructure.persistance.UserAuthDAO;
import edu.espe.cotbert.forestal.util.MailSender;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author sebrux
 */
@WebServlet(name = "UsersServlet", urlPatterns = {"/users"})
public class UsersServlet extends HttpServlet {

    private final UserAuthDAO daoUser = new UserAuthDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<UserAuthModel> users = daoUser.findAll();

        request.setAttribute("users", users);

        request.getRequestDispatcher("/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getParameter("_method");
        if ("DELETE".equalsIgnoreCase(method)) {
            String uuid = request.getParameter("uuid");
            if (uuid == null || uuid.isBlank()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"UUID parameter is required\"}");
                return;
            }

            daoUser.delete(uuid);

            response.sendRedirect("/forestal/users");
            return;
        }

        if ("UPDATE".equalsIgnoreCase(method)) {
            String uuid = request.getParameter("uuid");
            String name = request.getParameter("name");
            String lastname = request.getParameter("lastname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String role = request.getParameter("role_users");
            if (role != null) {
                if (role.equalsIgnoreCase("admin") || role.equalsIgnoreCase("root")) {
                    role = role.toUpperCase();
                } else {
                    role = role.toLowerCase();
                }
            }

            if (uuid == null || uuid.isBlank()
                    || name == null || name.isBlank()
                    || lastname == null || lastname.isBlank()
                    || email == null || email.isBlank()
                    || phone == null || phone.isBlank()
                    || role == null || role.isBlank()) {

                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"All fields are required\"}");
                return;
            }

            UserAuthModel updatedUser = new UserAuthModel(uuid, email, phone, name, lastname, role);

            daoUser.updateUser(updatedUser);

            // Respuesta OK
            response.setStatus(HttpServletResponse.SC_OK);
            response.sendRedirect("/forestal/users");
            return;
        }

        String firstName = request.getParameter("first_name_users");
        String lastName = request.getParameter("last_name_users");
        String email = request.getParameter("email_users");
        String phone = request.getParameter("phone_users");
        String role = request.getParameter("role_users");
        if (role != null) {
            if (role.equalsIgnoreCase("admin") || role.equalsIgnoreCase("root")) {
                role = role.toUpperCase();
            } else {
                role = role.toLowerCase();
            }
        }
        String rawPassword = request.getParameter("password_users");
        String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt());

        // Enviar correo
        String asunto = "¡Gracias por registrarte!";
        String mensaje = "Hola " + firstName + ",\n\nGracias por ser parte de nuestra comunidad forestal 🌱.\n\nRun Forest, Run!";
        MailSender.sendEmail(email, asunto, mensaje);

        String uuid = java.util.UUID.randomUUID().toString();

        UserAuthModel newUser = new UserAuthModel(uuid, email, phone, firstName, lastName, role, hashedPassword);

        daoUser.createUser(newUser);

        response.sendRedirect("users");
    }

}
