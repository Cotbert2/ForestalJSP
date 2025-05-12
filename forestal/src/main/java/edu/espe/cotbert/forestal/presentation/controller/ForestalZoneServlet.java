/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package edu.espe.cotbert.forestal.presentation.controller;

import java.io.IOException;
import java.io.PrintWriter;

import edu.espe.cotbert.forestal.domain.model.ForestalZone;
import edu.espe.cotbert.forestal.infraestructure.persistance.ForestalZoneDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;

/**
 *
 * @author mateo
 */
@WebServlet(name = "ForestalZoneServlet", urlPatterns = {"/forestal_zone"})
public class ForestalZoneServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
    
        try {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String areaStr = request.getParameter("area");
            String image = request.getParameter("image");
            String mapJson = request.getParameter("map_json");
            String registerDateStr = request.getParameter("register_date");
    
            if (name == null || description == null || areaStr == null || image == null || mapJson == null || registerDateStr == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"Missing required parameters\"}");
                return;
            }
    
            float area = Float.parseFloat(areaStr);
            Timestamp registerDate = Timestamp.valueOf(registerDateStr);
    
            ForestalZone forestalZone = new ForestalZone(name, description, area, image, registerDate, mapJson);
    
            ForestalZoneDAO dao = new ForestalZoneDAO();
            dao.save(forestalZone);
    
            response.setStatus(HttpServletResponse.SC_CREATED);
            response.getWriter().write("{\"message\":\"Forestal zone created successfully\"}");
    
        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Invalid data format: " + e.getMessage() + "\"}");
        } catch (Exception e) {
            e.printStackTrace(); // Puedes reemplazar con logger
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Internal server error: " + e.getMessage() + "\"}");
        }
    }
    
}
