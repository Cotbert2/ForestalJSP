package edu.espe.cotbert.forestal.presentation.controller;

import edu.espe.cotbert.forestal.domain.model.ForestalZone;
import edu.espe.cotbert.forestal.infraestructure.config.LoggerConfig;
import edu.espe.cotbert.forestal.infraestructure.persistance.ForestalZoneDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import edu.espe.cotbert.forestal.infraestructure.persistance.TreeSpeciesDAO;
import edu.espe.cotbert.forestal.domain.model.TreeSpecies;
import edu.espe.cotbert.forestal.infraestructure.persistance.ForestZoneTreeSpeciesDAO;
import edu.espe.cotbert.forestal.domain.model.ForestalZoneTreeSpecies;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ForestalZoneServlet", urlPatterns = {"/forestal_zone"})
public class ForestalZoneServlet extends HttpServlet {

    private static final Logger logger = LoggerConfig.getLogger();
    private final ForestalZoneDAO dao = new ForestalZoneDAO();
    private final TreeSpeciesDAO daoTrees = new TreeSpeciesDAO();
    private final ForestZoneTreeSpeciesDAO daoForestalZoneTreeSpecies = new ForestZoneTreeSpeciesDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        try {

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
                response.getWriter().write("{\"message\":\"Forestal zone deleted successfully\"}");
                response.sendRedirect("/forestal/forestal_zone");
                return;
            }
            
           if ("ADD_TREE".equalsIgnoreCase(method)) {
                String uuid = UUID.randomUUID().toString();
                String uuidForestal = request.getParameter("uuidForestal");
                String uuidTree = request.getParameter("uuidTree");
                if (uuidForestal == null || uuidForestal.isBlank() || uuidTree == null || uuidTree.isBlank()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"error\":\"UUID parameter is required\"}");
                    return;
                }
                
                ForestalZoneTreeSpecies forestalZoneTreeSpecie = new ForestalZoneTreeSpecies(uuid,uuidForestal, uuidTree);
                daoForestalZoneTreeSpecies.save(forestalZoneTreeSpecie);
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"message\":\"Tree Specie in Forest zone saved successfully\"}");
                response.sendRedirect("/forestal/forestal_zone");
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
            String description = request.getParameter("description");
            String areaStr = request.getParameter("area");
            String image = request.getParameter("image");
            String mapJson = request.getParameter("map_json");
            String registerDateStr = request.getParameter("register_date");
            registerDateStr = registerDateStr.replace("T", " ") + ":00";

            if (name == null || description == null || areaStr == null || image == null || mapJson == null || registerDateStr == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"Missing required parameters\"}");
                return;
            }

            float area = Float.parseFloat(areaStr);
            Timestamp registerDate = Timestamp.valueOf(registerDateStr);
            String uuid = UUID.randomUUID().toString();

            ForestalZone forestalZone = new ForestalZone(uuid, name, description, area, image, registerDate, mapJson);
            dao.save(forestalZone);
            response.sendRedirect("/forestal/forestal_zone");

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ForestalZone> zones = dao.findAll();
        List<TreeSpecies> trees = daoTrees.findAll();
        request.setAttribute("zones", zones);
        request.setAttribute("trees", trees); 
        //logger.log(Level.INFO, "First forestal zone name: {0}", zones.get(0).getName());
        //trees
        //logger.log(Level.INFO, "First forestal zone trees: {0}", zones.get(0).getTrees().get(0).getName());
        request.getRequestDispatcher("/forestal_zones.jsp").forward(request, response);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
