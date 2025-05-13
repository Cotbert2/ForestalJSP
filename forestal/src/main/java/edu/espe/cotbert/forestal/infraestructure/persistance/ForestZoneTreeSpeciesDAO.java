/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.espe.cotbert.forestal.infraestructure.persistance;

import edu.espe.cotbert.forestal.domain.model.ForestalZone;
import edu.espe.cotbert.forestal.domain.repository.ForestalZoneTreeSpeciesRepository;
import edu.espe.cotbert.forestal.infraestructure.config.LoggerConfig;
import edu.espe.cotbert.forestal.domain.model.ForestalZoneTreeSpecies;
import edu.espe.cotbert.forestal.infraestructure.config.ConnectionDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;
/**
 *
 * @author jeffersonyepez
 */
public class ForestZoneTreeSpeciesDAO implements ForestalZoneTreeSpeciesRepository{
    private static final Logger logger = LoggerConfig.getLogger();
    
    @Override
    public void save(ForestalZoneTreeSpecies forestalZoneTreeSpecies){
        try(Connection conn = ConnectionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(ConstantsDB.CREATE_FORESTAL_ZONE_TREE_SPECIES)){
            stmt.setObject(1, UUID.fromString(forestalZoneTreeSpecies.getUuid()),java.sql.Types.OTHER);
            stmt.setObject(2, UUID.fromString(forestalZoneTreeSpecies.getUuidForestalZone()));
            stmt.setObject(3, UUID.fromString(forestalZoneTreeSpecies.getUuidTreeSpecies()));
            
            stmt.executeUpdate();
            logger.severe("forestalZoneTreeSpecies saved successfully");
        }catch(Exception e){
            logger.severe("Error saving forestalZoneTreeSpecies: " + e.getMessage());
        }
    }
    @Override
    public List<ForestalZoneTreeSpecies> findAll(){
        List<ForestalZoneTreeSpecies> forestalZoneTreeSpecies = new ArrayList<>();
        try(Connection conn = ConnectionDB.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(ConstantsDB.GET_ALL_FORESTAL_ZONE_TREE_SPECIES)){
            
            while (rs.next()){
                ForestalZoneTreeSpecies forestalZoneTreeSpecie  = new ForestalZoneTreeSpecies(
                        rs.getString("uuid_forestal_zone_tree_species"),
                        rs.getString("uuid_forestal_zone"),
                        rs.getString("uuid_tree_species")
                );
                forestalZoneTreeSpecies.add(forestalZoneTreeSpecie);
            }
        }catch(Exception e){
            logger.severe("Error retrieving forestal zone trees species: " + e.getMessage());
        }
        return forestalZoneTreeSpecies;
    }
    
    @Override
    public ForestalZoneTreeSpecies findById(String uuid){
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(ConstantsDB.GET_BY_ID_FORESTAL_ZONE_TREE_SPECIES)) {

            stmt.setObject(1, UUID.fromString(uuid), java.sql.Types.OTHER);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new ForestalZoneTreeSpecies(
                        rs.getString("uuid_forestal_zone"),
                        rs.getString("uuid_tree_species")
                );
            }

        } catch (Exception e) {
            logger.severe("Error retrieving ForestalZoneTreeSpecies by id: " + e.getMessage());
        }
        return null;
    }
    
    @Override
    public void update(ForestalZoneTreeSpecies forestalZoneTreeSpecie){
        try(Connection conn = ConnectionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(ConstantsDB.UPDATE_BY_ID_FORESTAL_ZONE_TREE_SPECIES)){
            
            stmt.setString(1, forestalZoneTreeSpecie.getUuidForestalZone());
            stmt.setString(2, forestalZoneTreeSpecie.getUuidTreeSpecies());
            
            stmt.executeUpdate();
            logger.info("forestalZoneTreeSpecies updated successfully");
        }catch(Exception e){
            logger.severe("Error updating TreeSpecies: " + e.getMessage());
        }
    }
    
    @Override
    public void delete(String uuid){
        try(Connection conn = ConnectionDB.getConnection();
                PreparedStatement stmt = conn.prepareCall(ConstantsDB.DELETE_FORESTAL_ZONE_TREE_SPECIES)){
            
            stmt.setObject(1, UUID.fromString(uuid), java.sql.Types.OTHER);
            stmt.executeUpdate();
            logger.info("forestalZoneTreeSpecies deleted successfully");
        }catch(Exception e){
            logger.severe("Error deleting TreeSpecies: " + e.getMessage());
        }
    }


}
