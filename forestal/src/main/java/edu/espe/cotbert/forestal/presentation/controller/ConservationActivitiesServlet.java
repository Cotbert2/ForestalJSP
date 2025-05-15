package edu.espe.cotbert.forestal.presentation.controller;

import edu.espe.cotbert.forestal.domain.model.ConservationActivities;
import edu.espe.cotbert.forestal.domain.model.ForestalZone;
import edu.espe.cotbert.forestal.infraestructure.config.LoggerConfig;
import edu.espe.cotbert.forestal.infraestructure.persistance.ConservationActivitiesDAO;
import edu.espe.cotbert.forestal.infraestructure.persistance.ForestalZoneDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;

/**
 *
 * @author Luis Sagnay
 */
@WebServlet(name = "ConservationActivitiesServlet", urlPatterns = {"/conservation_activities"})
public class ConservationActivitiesServlet extends HttpServlet {

    private final ConservationActivitiesDAO dao = new ConservationActivitiesDAO();
    private final ForestalZoneDAO daoForestal = new ForestalZoneDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            String method = request.getParameter("_method");

            // ELIMINAR (soft delete)
            if ("DELETE".equalsIgnoreCase(method)) {
                String uuid = request.getParameter("uuid");
                if (uuid == null || uuid.isBlank()) {
                    sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "UUID parameter is required");
                    return;
                }

                dao.delete(uuid);
                response.sendRedirect("/forestal/conservation_activities");
                return;
            }

            // ACTUALIZAR
            if ("UPDATE".equalsIgnoreCase(method)) {
                handleUpdate(request, response);
                return;
            }

            // CREAR
            handleCreate(request, response);

        } catch (IllegalArgumentException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid date format: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal server error: " + e.getMessage());
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String uuid = request.getParameter("uuid");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String startDateStr = request.getParameter("start_date");
        String endDateStr = request.getParameter("end_date");
        String registerDateStr = request.getParameter("register_date");
        String forestalZoneUuid = request.getParameter("uuidd_forestal_zone");

        // Validación de campos requeridos
        if (uuid == null || uuid.isBlank() || name == null || name.isBlank() || 
            description == null || description.isBlank() || startDateStr == null || startDateStr.isBlank() ||
            endDateStr == null || endDateStr.isBlank() || registerDateStr == null || registerDateStr.isBlank() ||
            forestalZoneUuid == null || forestalZoneUuid.isBlank()) {
            
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
            return;
        }

        // Formateo de fechas
        startDateStr = startDateStr.replace("T", " ") + ":00";
        endDateStr = endDateStr.replace("T", " ") + ":00";
        registerDateStr = registerDateStr.replace("T", " ") + ":00";

        // Validación de fechas
        Timestamp startDate = Timestamp.valueOf(startDateStr);
        Timestamp endDate = Timestamp.valueOf(endDateStr);
        Timestamp registerDate = Timestamp.valueOf(registerDateStr);
        
        if (endDate.before(startDate)) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "End date must be after start date");
            return;
        }

        ConservationActivities activity = new ConservationActivities(
            uuid, name, description, 
            startDate, endDate, registerDate, 
            forestalZoneUuid
        );

        dao.update(activity);
        response.sendRedirect("/forestal/conservation_activities");
    }

    private void handleCreate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String startDateStr = request.getParameter("start_date");
        String endDateStr = request.getParameter("end_date");
        String registerDateStr = request.getParameter("register_date");
        String forestalZoneUuid = request.getParameter("uuidd_forestal_zone");

        // Validación de campos requeridos
        if (name == null || description == null || startDateStr == null || endDateStr == null ||
            registerDateStr == null || forestalZoneUuid == null || name.isBlank() || 
            description.isBlank() || startDateStr.isBlank() || endDateStr.isBlank() ||
            registerDateStr.isBlank() || forestalZoneUuid.isBlank()) {
            
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
            return;
        }

        // Formateo de fechas
        startDateStr = startDateStr.replace("T", " ") + ":00";
        endDateStr = endDateStr.replace("T", " ") + ":00";
        registerDateStr = registerDateStr.replace("T", " ") + ":00";

        // Validación de fechas
        Timestamp startDate = Timestamp.valueOf(startDateStr);
        Timestamp endDate = Timestamp.valueOf(endDateStr);
        Timestamp registerDate = Timestamp.valueOf(registerDateStr);
        
        if (endDate.before(startDate)) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "End date must be after start date");
            return;
        }

        String uuid = UUID.randomUUID().toString();
        ConservationActivities activity = new ConservationActivities(
            uuid, name, description, 
            startDate, endDate, registerDate, 
            forestalZoneUuid
        );

        dao.save(activity);
        response.sendRedirect("/forestal/conservation_activities");
    }

    private void sendErrorResponse(HttpServletResponse response, int status, String message) throws IOException {
        response.setStatus(status);
        response.setContentType("application/json");
        response.getWriter().write("{\"error\":\"" + message + "\"}");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<ConservationActivities> activities = dao.findAll();
            List<ForestalZone> zones = daoForestal.findAll();

            request.setAttribute("activities", activities);
            request.setAttribute("zones", zones);

            request.getRequestDispatcher("/conservation_activities.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading data");
        }
    }
}