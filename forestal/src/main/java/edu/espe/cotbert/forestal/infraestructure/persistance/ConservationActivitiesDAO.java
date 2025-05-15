package edu.espe.cotbert.forestal.infraestructure.persistance;

import edu.espe.cotbert.forestal.domain.model.ConservationActivities;
import edu.espe.cotbert.forestal.domain.repository.ConservationActivitiesRepository;
import edu.espe.cotbert.forestal.infraestructure.config.ConnectionDB;
import edu.espe.cotbert.forestal.infraestructure.config.LoggerConfig;

import java.sql.*;
import java.util.*;
import java.util.logging.Logger;

/**
 *
 * @author Luis Sagnay
 */

public class ConservationActivitiesDAO implements ConservationActivitiesRepository {

    private static final Logger logger = LoggerConfig.getLogger();

    @Override
    public void save(ConservationActivities activity) {
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(ConstantsDB.CREATE_CONSERVATION_ACTIVITY)) {

            stmt.setObject(1, UUID.fromString(activity.getUuid()), java.sql.Types.OTHER);
            stmt.setString(2, activity.getName());
            stmt.setString(3, activity.getDescription());
            stmt.setTimestamp(4, activity.getStartDate());
            stmt.setTimestamp(5, activity.getEndDate());
            stmt.setTimestamp(6, activity.getRegisterDate());
            stmt.setObject(7, UUID.fromString(activity.getForestalZoneUuid()), java.sql.Types.OTHER);

            stmt.executeUpdate();
            logger.info("ConservationActivity saved successfully");

        } catch (Exception e) {
            logger.severe("Error saving ConservationActivity: " + e.getMessage());
        }
    }

    @Override
    public List<ConservationActivities> findAll() {
        List<ConservationActivities> activities = new ArrayList<>();
        try (Connection conn = ConnectionDB.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(ConstantsDB.GET_ALL_CONSERVATION_ACTIVITY)) 
        {
            while (rs.next()) {
            ConservationActivities activity = new ConservationActivities(
                rs.getString("uuid_conservation_activity"),
                rs.getString("name_conservation_activity"),
                rs.getString("description_conservation_activity"),
                rs.getTimestamp("start_date_conservation_activity"),
                rs.getTimestamp("end_date_conservation_activity"),
                rs.getTimestamp("register_date_conservation_activity"),
                rs.getString("uuidd_forestal_zone") 
            );
            activities.add(activity);
        }

        } catch (Exception e) {
            logger.severe("Error retrieving ConservationActivity list: " + e.getMessage());
        }
        return activities;
    }

    @Override
    public ConservationActivities findById(String uuid) {
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(ConstantsDB.GET_BY_ID_CONSERVATION_ACTIVITY)) {

            stmt.setObject(1, UUID.fromString(uuid), java.sql.Types.OTHER);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new ConservationActivities(
                    rs.getString("uuid_conservation_activity"),
                    rs.getString("name_conservation_activity"),
                    rs.getString("description_conservation_activity"),
                    rs.getTimestamp("start_date_conservation_activity"),
                    rs.getTimestamp("end_date_conservation_activity"),
                    rs.getTimestamp("register_date_conservation_activity"),
                    rs.getString("uuid_forestal_zone")
                );
            }

        } catch (Exception e) {
            logger.severe("Error retrieving ConservationActivity by id: " + e.getMessage());
        }
        return null;
    }

    @Override
    public void update(ConservationActivities activity) {
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(ConstantsDB.UPDATE_BY_ID_CONSERVATION_ACTIVITY)) {

            stmt.setString(1, activity.getName());
            stmt.setString(2, activity.getDescription());
            stmt.setTimestamp(3, activity.getStartDate());
            stmt.setTimestamp(4, activity.getEndDate());
            stmt.setTimestamp(5, activity.getRegisterDate());
            stmt.setObject(6, UUID.fromString(activity.getForestalZoneUuid()), java.sql.Types.OTHER);
            stmt.setObject(7, UUID.fromString(activity.getUuid()), java.sql.Types.OTHER);

            stmt.executeUpdate();
            logger.info("ConservationActivity updated successfully");

        } catch (Exception e) {
            logger.severe("Error updating ConservationActivity: " + e.getMessage());
        }
    }

    @Override
    public void delete(String uuid) {
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(ConstantsDB.DELETE_CONSERVATION_ACTIVITY)) {

            stmt.setObject(1, UUID.fromString(uuid), java.sql.Types.OTHER);
            stmt.executeUpdate();
            logger.info("ConservationActivity deleted successfully");

        } catch (Exception e) {
            logger.severe("Error deleting ConservationActivity: " + e.getMessage());
        }
    }
}