/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package edu.espe.cotbert.forestal.presentation.controller;

import edu.espe.cotbert.forestal.domain.model.Origins;
import edu.espe.cotbert.forestal.infraestructure.persistance.OriginsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author sebrux
 */
@WebServlet(name = "OriginsServlet", urlPatterns = {"/OriginsServlet"})
public class OriginsServlet extends HttpServlet {


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    private final OriginsDAO originsDAO = new OriginsDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Se obtienen los origins 
        List<Origins> origins = originsDAO.findAll();
        
        //Enviar como atributo al JSP
        request.setAttribute("origins", origins);
        
        //Redirigir al JSP (ajusta si el JSP se llama distinto)
        request.getRequestDispatcher("/tree_species.jsp").forward(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
    response.setContentType("application/json");

    try {
        String nameOrigin = request.getParameter("name_origin");

        if (nameOrigin == null || nameOrigin.isBlank()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Missing name_origin parameter\"}");
            return;
        }

        String uuid = java.util.UUID.randomUUID().toString();
        Origins newOrigin = new Origins(uuid, nameOrigin);

        OriginsDAO dao = new OriginsDAO();
        dao.save(newOrigin); // Este método debe existir en OriginsDAO

        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("{\"message\":\"Origin saved successfully\"}");

    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"error\":\"Internal server error\"}");
    }
    }

    
}
