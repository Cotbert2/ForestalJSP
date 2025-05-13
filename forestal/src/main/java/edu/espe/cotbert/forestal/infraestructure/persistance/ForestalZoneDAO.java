package edu.espe.cotbert.forestal.infraestructure.persistance;

import com.google.gson.Gson;
import edu.espe.cotbert.forestal.domain.model.ForestalZone;
import edu.espe.cotbert.forestal.domain.model.TreeSpecies;
import edu.espe.cotbert.forestal.domain.repository.ForestalZoneRepository;
import edu.espe.cotbert.forestal.infraestructure.config.ConnectionDB;
import edu.espe.cotbert.forestal.infraestructure.config.LoggerConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.logging.Logger;

public class ForestalZoneDAO implements ForestalZoneRepository {

    private static final Logger logger = LoggerConfig.getLogger();

    @Override
    public void save(ForestalZone forestalZone) {
        try (Connection conn = ConnectionDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(ConstantsDB.CREATE_FORESTAL_ZONE)) {

            stmt.setObject(1, UUID.fromString(forestalZone.getUuid()), java.sql.Types.OTHER);
            stmt.setString(2, forestalZone.getName());
            stmt.setString(3, forestalZone.getDescription());
            stmt.setFloat(4, forestalZone.getArea());
            stmt.setString(5, forestalZone.getImage());
            stmt.setTimestamp(6, forestalZone.getRegisterDate());
            stmt.setString(7, forestalZone.getMapJson());

            stmt.executeUpdate();
            logger.info("ForestalZone saved successfully");

        } catch (Exception e) {
            logger.severe("Error saving ForestalZone: " + e.getMessage());
        }
    }

    @Override
    public List<ForestalZone> findAll() {
        Map<String, ForestalZone> zoneMap = new HashMap<>();

        try (Connection conn = ConnectionDB.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(ConstantsDB.GET_ALL_FORESTAL_ZONE_WITH_TREES)) {

            while (rs.next()) {
                String zoneUuid = rs.getString("uuid_forestal_zone");

                ForestalZone zone = zoneMap.get(zoneUuid);
                if (zone == null) {
                    zone = new ForestalZone(
                            zoneUuid,
                            rs.getString("name_forestal_zone"),
                            rs.getString("description_forestal_zone"),
                            rs.getFloat("area_ha_forestal_zone"),
                            rs.getString("image_url_forestal_zone"),
                            rs.getTimestamp("register_date_forestal_zone"),
                            rs.getString("map_forestal_zone")
                    );
                    zoneMap.put(zoneUuid, zone);
                }

                if (rs.getString("uuid_tree_species") != null) {
                    TreeSpecies tree = new TreeSpecies(
                            rs.getString("uuid_tree_species"),
                            rs.getString("name_tree_species"),
                            rs.getString("common_name_tree_species"),
                            rs.getString("family_tree_species"),
                            rs.getString("origin_tree_species"),
                            rs.getString("order_name_tree_species"),
                            rs.getString("habitat_tree_species"),
                            rs.getString("description_tree_species"),
                            rs.getString("image_url_tree_species")
                    );
                    zone.getTrees().add(tree);
                }
            }

        } catch (Exception e) {
            logger.severe("Error retrieving forestal zones with trees: " + e.getMessage());
        }

        return new ArrayList<>(zoneMap.values());
    }

    @Override
    public ForestalZone findById(String uuid) {
        try (Connection conn = ConnectionDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(ConstantsDB.GET_BY_ID_FORESTAL_ZONE)) {

            stmt.setObject(1, UUID.fromString(uuid), java.sql.Types.OTHER);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new ForestalZone(
                        rs.getString("uuid_forestal_zone"),
                        rs.getString("name_forestal_zone"),
                        rs.getString("description_forestal_zone"),
                        rs.getFloat("area_ha_forestal_zone"),
                        rs.getString("image_url_forestal_zone"),
                        rs.getTimestamp("register_date_forestal_zone"),
                        rs.getString("map_forestal_zone")
                );
            }

        } catch (Exception e) {
            logger.severe("Error retrieving ForestalZone by id: " + e.getMessage());
        }
        return null;
    }

    @Override
    public void update(ForestalZone zone) {
        try (Connection conn = ConnectionDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(ConstantsDB.UPDATE_BY_ID_FORESTAL_ZONE)) {

            stmt.setString(1, zone.getName());
            stmt.setString(2, zone.getDescription());
            stmt.setFloat(3, zone.getArea());
            stmt.setString(4, zone.getImage());
            stmt.setTimestamp(5, zone.getRegisterDate());
            stmt.setString(6, zone.getMapJson());
            stmt.setObject(7, UUID.fromString(zone.getUuid()), java.sql.Types.OTHER);

            stmt.executeUpdate();
            logger.info("ForestalZone updated successfully");

        } catch (Exception e) {
            logger.severe("Error updating ForestalZone: " + e.getMessage());
        }
    }

    @Override
    public void delete(String uuid) {
        try (Connection conn = ConnectionDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(ConstantsDB.DELETE_FORESTAL_ZONE)) {

            stmt.setObject(1, UUID.fromString(uuid), java.sql.Types.OTHER);
            stmt.executeUpdate();
            logger.info("ForestalZone deleted successfully");

        } catch (Exception e) {
            logger.severe("Error deleting ForestalZone: " + e.getMessage());
        }
    }
}
