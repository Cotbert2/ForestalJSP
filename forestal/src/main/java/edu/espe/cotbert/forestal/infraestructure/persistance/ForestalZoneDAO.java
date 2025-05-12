/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.espe.cotbert.forestal.infraestructure.persistance;

import edu.espe.cotbert.forestal.domain.model.ForestalZone;
import edu.espe.cotbert.forestal.domain.repository.ForestalZoneRepository;
import edu.espe.cotbert.forestal.infraestructure.config.ConnectionDB;
import edu.espe.cotbert.forestal.infraestructure.config.LoggerConfig;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;

/**
 *
 * @author mateo
 */
public class ForestalZoneDAO implements ForestalZoneRepository {

    private static final Logger logger = LoggerConfig.getLogger();


    @Override
    public void save(ForestalZone forestalZone) {
        String query = "INSERT INTO forestal_managment.forestal_zone\n" + //
                        "(uuid_forestal_zone, name_forestal_zone, description_forestal_zone, area_ha_forestal_zone, image_url_forestal_zone, register_date_forestal_zone, map_forestal_zone)\n" + //
                        "VALUES(?, ?, ?, ?, ?, ?, ?::jsonb);";
        try (Connection connectionDB = ConnectionDB.getConnection()) {
            PreparedStatement stmt = connectionDB.prepareStatement(query);
            stmt.setObject(1, UUID.fromString(forestalZone.getUuid()), java.sql.Types.OTHER);
            stmt.setString(2, forestalZone.getName());
            stmt.setString(3, forestalZone.getDescription());
            stmt.setFloat(4, forestalZone.getArea());
            stmt.setString(5, forestalZone.getImage());
            stmt.setTimestamp(6, forestalZone.getRegisterDate());
            stmt.setString(7, forestalZone.getMapJson());
            stmt.executeUpdate();
        } catch (Exception e) {
            logger.severe("Error saving ForestalZone: " + e.getMessage());
        }
    }

    @Override
    public List<ForestalZone> findAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ForestalZone findById(String uuid) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(ForestalZone Zone) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(String uuid) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
