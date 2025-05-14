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
import java.util.logging.Logger;

/**
 *
 * @author Luis Sagnay
 */
@WebServlet(name = "ConservationActivityServlet", urlPatterns = {"/conservation_activities"})
public class ConservationActivitiesServlet extends HttpServlet {

    private static final Logger logger = LoggerConfig.getLogger();
    private final ConservationActivitiesDAO dao = new ConservationActivitiesDAO();
        private final ForestalZoneDAO daoForestal = new ForestalZoneDAO();


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        try {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String dateStr = request.getParameter("activity_date");
            String forestalZoneUuid = request.getParameter("uuid_forestal_zone");

            dateStr = dateStr.replace("T", " ") + ":00";

            if (name == null || description == null || dateStr == null || forestalZoneUuid == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"Missing required parameters\"}");
                return;
            }

            Timestamp activityDate = Timestamp.valueOf(dateStr);
            ConservationActivities activity = new ConservationActivities(name, description, activityDate, forestalZoneUuid);
            dao.save(activity);

            response.setStatus(HttpServletResponse.SC_CREATED);
            response.getWriter().write("{\"message\":\"Conservation activity created successfully\"}");

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ConservationActivities> activities = dao.findAll();
        request.setAttribute("activities", activities);
        List<ForestalZone> zones = daoForestal.findAll();
        request.setAttribute("zones", zones);
        request.getRequestDispatcher("/conservation_activities.jsp").forward(request, response);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uuid = request.getParameter("uuid");
        if (uuid == null || uuid.isBlank()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"UUID parameter is required\"}");
            return;
        }

        dao.delete(uuid);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("{\"message\":\"Conservation activity deleted successfully\"}");
    }
}
