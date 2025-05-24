
package edu.espe.cotbert.forestal.infraestructure.persistance;
import edu.espe.cotbert.forestal.domain.model.ForestalZone;
import edu.espe.cotbert.forestal.domain.model.TreeSpecies;
import edu.espe.cotbert.forestal.domain.repository.TreeSpeciesRepository;
import edu.espe.cotbert.forestal.infraestructure.config.ConnectionDB;
import edu.espe.cotbert.forestal.infraestructure.config.LoggerConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;
/**
 *
 * @author jeffersonyepez
 */
public class TreeSpeciesDAO implements TreeSpeciesRepository{
    private static final Logger logger = LoggerConfig.getLogger();
    @Override
    public void save(TreeSpecies treeSpecies){
        try(Connection conn = ConnectionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(ConstantsDB.CREATE_TREE_SPECIES)){
            stmt.setObject(1, UUID.fromString(treeSpecies.getUuid()),java.sql.Types.OTHER);
            stmt.setString(2, treeSpecies.getName());
            stmt.setString(3, treeSpecies.getCommonName());
            stmt.setString(4, treeSpecies.getFamily());
            stmt.setObject(5, UUID.fromString(treeSpecies.getOrigin()));
            stmt.setString(6, treeSpecies.getOrderName());
            stmt.setString(7, treeSpecies.getHabitat());
            stmt.setString(8, treeSpecies.getDescription());
            stmt.setString(9, treeSpecies.getImage());
            
            stmt.executeUpdate();
            logger.severe("TreeSpecies saved successfully");
        }catch(Exception e){
            logger.severe("Error saving TreeSpecies: " + e.getMessage());
        }
    }
    
    @Override
    public List<TreeSpecies> findAll(){
        List<TreeSpecies> trees = new ArrayList<>();
        try(Connection conn = ConnectionDB.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(ConstantsDB.GET_ALL_TREE_SPECIES)) {

            while (rs.next()) {
                // Extraer el UUID una vez
                String uuidTree = rs.getString("uuid_tree_species");

                // Verificar si ya existe el árbol
                TreeSpecies existingTree = trees.stream()
                    .filter(t -> t.getUuid().equals(uuidTree))
                    .findFirst()
                    .orElse(null);

                TreeSpecies tree;
                if (existingTree != null) {
                    tree = existingTree;
                } else {
                    tree = new TreeSpecies(
                        uuidTree,
                        rs.getString("name_tree_species"),
                        rs.getString("common_name_tree_species"),
                        rs.getString("family_tree_species"),
                        rs.getString("origin_tree_species"),
                        rs.getString("order_name_tree_species"),
                        rs.getString("habitat_tree_species"),
                        rs.getString("description_tree_species"),
                        rs.getString("image_url_tree_species")
                    );
                    trees.add(tree);
                }

                // Agregar zona si existe
                if (rs.getString("uuid_forestal_zone") != null) {
                    ForestalZone zone = new ForestalZone(
                        rs.getString("uuid_forestal_zone"),
                        rs.getString("name_forestal_zone"),
                        rs.getString("description_forestal_zone"),
                        rs.getFloat("area_ha_forestal_zone"),
                        rs.getString("image_url_forestal_zone"),
                        rs.getTimestamp("register_date_forestal_zone"),
                        rs.getString("map_forestal_zone")
                    );
                    tree.getZones().add(zone);
                }
            }

        } catch(Exception e){
            logger.severe("Error retrieving trees species: " + e.getMessage());
        }
        return trees;
    }

    
    @Override
    public TreeSpecies findById(String uuid){
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(ConstantsDB.GET_BY_ID_TREE_SPECIES)) {

            stmt.setObject(1, UUID.fromString(uuid), java.sql.Types.OTHER);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new TreeSpecies(
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
            }

        } catch (Exception e) {
            logger.severe("Error retrieving ForestalZone by id: " + e.getMessage());
        }
        return null;
    }
    
    @Override
    public void update(TreeSpecies tree){
        try(Connection conn = ConnectionDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(ConstantsDB.UPDATE_BY_ID_TREE_SPECIES)){
            
            stmt.setString(1, tree.getName());
            stmt.setString(2, tree.getCommonName());
            stmt.setString(3, tree.getFamily());
            
            stmt.setObject(4, UUID.fromString(tree.getOrigin()), java.sql.Types.OTHER);
            stmt.setString(5, tree.getOrderName());
            stmt.setString(6, tree.getHabitat());
            stmt.setString(7, tree.getDescription());
            stmt.setObject(8,UUID.fromString(tree.getUuid()), java.sql.Types.OTHER);
            
            stmt.executeUpdate();
            logger.info("TreeSpecies updated successfully");
        }catch(Exception e){
            logger.severe("Error updating TreeSpecies: " + e.getMessage());
        }
    }
    
    @Override
    public boolean delete(String uuid){
    int rowsAffected = 0;
    try (Connection conn = ConnectionDB.getConnection()) {
        // 1. Eliminar todas las relaciones con zonas forestales
        
        try (PreparedStatement stmtDeleteRelations = conn.prepareStatement(
             ConstantsDB.DELET_BY_RELATION)) {
            stmtDeleteRelations.setObject(1, UUID.fromString(uuid), java.sql.Types.OTHER);
            stmtDeleteRelations.executeUpdate();
        }

        // 2. Eliminar lógicamente el árbol
        try (PreparedStatement stmtDeleteTree = conn.prepareStatement(ConstantsDB.DELETE_TREE_SPECIES)) {
            stmtDeleteTree.setObject(1, UUID.fromString(uuid), java.sql.Types.OTHER);
            rowsAffected = stmtDeleteTree.executeUpdate();
        }

        logger.info("TreeSpecies and its zone relations deleted successfully");
        return rowsAffected > 0;
    } catch (Exception e) {
        logger.severe("Error deleting TreeSpecies and its relations: " + e.getMessage());
    }
    return false;
}



}