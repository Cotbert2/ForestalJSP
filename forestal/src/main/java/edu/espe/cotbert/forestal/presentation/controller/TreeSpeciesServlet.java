/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package edu.espe.cotbert.forestal.presentation.controller;

import edu.espe.cotbert.forestal.domain.model.ForestalZone;
import edu.espe.cotbert.forestal.domain.model.Origins;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import edu.espe.cotbert.forestal.infraestructure.persistance.TreeSpeciesDAO;
import edu.espe.cotbert.forestal.domain.model.TreeSpecies;
import edu.espe.cotbert.forestal.infraestructure.persistance.ForestZoneTreeSpeciesDAO;
import edu.espe.cotbert.forestal.infraestructure.persistance.ForestalZoneDAO;
import edu.espe.cotbert.forestal.infraestructure.persistance.OriginsDAO;
import java.util.UUID;
/**
 *
 * @author jeffersonyepez
 */
@WebServlet(name = "TreeSpeciesServlet", urlPatterns = {"/tree_species"})
public class TreeSpeciesServlet extends HttpServlet {
    private final TreeSpeciesDAO dao = new TreeSpeciesDAO();
    private final ForestalZoneDAO zoneDAO = new ForestalZoneDAO();
    private final ForestZoneTreeSpeciesDAO daoForestalZoneTreeSpecies = new ForestZoneTreeSpeciesDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<TreeSpecies> trees = dao.findAll();
        OriginsDAO originsDAO = new OriginsDAO();
        List<Origins> origins = originsDAO.findAll();
        List<ForestalZone> zones = zoneDAO.findAll();
        
        request.setAttribute("trees", trees);
        request.setAttribute("origins", origins);
        request.setAttribute("zones", zones);
        
        request.getRequestDispatcher("/tree_species.jsp").forward(request, response);   
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        try {
            // ✅ Manejar la lógica de agregar una zona a una especie
            
            
            String method = request.getParameter("_method");
            
            if ("DELETE".equalsIgnoreCase(method)) {
                String uuid = request.getParameter("uuid");
                if (uuid == null || uuid.isBlank()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"error\":\"UUID parameter is required\"}");
                    return;
                }

                dao.delete(uuid);
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"message\":\"Tree deleted successfully\"}");
                response.sendRedirect("/forestal/tree_species");
                return;
            }
            
            if ("ADD_ZONE".equalsIgnoreCase(method)) {
                String uuidTree = request.getParameter("uuidTree");
                String uuidZone = request.getParameter("uuidZone");

                if (uuidTree == null || uuidTree.isBlank() || uuidZone == null || uuidZone.isBlank()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"error\":\"Missing required parameters\"}");
                    return;
                }

               
                edu.espe.cotbert.forestal.infraestructure.persistance.ForestZoneTreeSpeciesDAO daoLink = new edu.espe.cotbert.forestal.infraestructure.persistance.ForestZoneTreeSpeciesDAO();
                String uuid = UUID.randomUUID().toString();
                edu.espe.cotbert.forestal.domain.model.ForestalZoneTreeSpecies relation =
                    new edu.espe.cotbert.forestal.domain.model.ForestalZoneTreeSpecies(uuid, uuidZone, uuidTree);
                daoLink.save(relation);

                response.sendRedirect("/forestal/tree_species");
                return;
            }
            
            if ("DELETE_TREE".equalsIgnoreCase(method)) {
                String uuidForestal = request.getParameter("uuidForestal");
                String uuidTree = request.getParameter("uuidTree");
                if (uuidForestal == null || uuidForestal.isBlank() || uuidTree == null || uuidTree.isBlank()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"error\":\"UUID parameter is required\"}");
                    return;
                }
                
                daoForestalZoneTreeSpecies.delete(uuidForestal,uuidTree);
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"message\":\"Tree Specie in Forest zone deleted successfully\"}");
                response.sendRedirect("/forestal/forestal_zone");
                return;
            }

            
            String name = request.getParameter("name");
            String commonName = request.getParameter("common_name");
            String family = request.getParameter("family");
            String origin = request.getParameter("origin");
            String orderName = request.getParameter("order_name");
            String habitat = request.getParameter("habitat");
            String description = request.getParameter("description");
            String image = request.getParameter("image");

            if (name == null || commonName == null || family == null || origin == null ||
                orderName == null || habitat == null || description == null || image == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"Missing required parameters\"}");
                return;
            }

            String uuid = UUID.randomUUID().toString();
            TreeSpecies treeSpecies = new TreeSpecies(uuid, name, commonName, family, origin, orderName, habitat, description, image);
            dao.save(treeSpecies);
            response.sendRedirect("/forestal/tree_species");

        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Invalid data format: " + e.getMessage() + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Internal server error: " + e.getMessage() + "\"}");
        }
    }

    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uuid = request.getParameter("uuid");
        if(uuid == null || uuid.isBlank()){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"UUID parameter is required\"}");
            return;
        }
        
        dao.delete(uuid);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("{\"message\":\"Forestal zone deleted successfully\"}");
    }

}