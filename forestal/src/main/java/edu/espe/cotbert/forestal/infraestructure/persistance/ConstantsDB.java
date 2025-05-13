/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.espe.cotbert.forestal.infraestructure.persistance;

/**
 *
 * @author mateo
 */
public class ConstantsDB {
    
    /****************Forestal Zones****************/
    public static final String CREATE_FORESTAL_ZONE = "INSERT INTO forestal_managment.forestal_zone\n" + 
            "(uuid_forestal_zone, name_forestal_zone, description_forestal_zone, area_ha_forestal_zone,\n" + 
            "image_url_forestal_zone, register_date_forestal_zone, map_forestal_zone)\n" + 
            "VALUES (?, ?, ?, ?, ?, ?, ?::jsonb)\n";
    public static final String DELETE_FORESTAL_ZONE = "DELETE FROM forestal_managment.forestal_zone WHERE uuid_forestal_zone = ?";
    
    public static final String GET_ALL_FORESTAL_ZONE = "SELECT * FROM forestal_managment.forestal_zone";

    public static final String GET_BY_ID_FORESTAL_ZONE = "SELECT * FROM forestal_managment.forestal_zone WHERE uuid_forestal_zone = ?";
    
    public static final String UPDATE_BY_ID_FORESTAL_ZONE = "UPDATE forestal_managment.forestal_zone SET\n" + 
            "name_forestal_zone = ?, description_forestal_zone = ?, area_ha_forestal_zone = ?,\n" + 
            "image_url_forestal_zone = ?, register_date_forestal_zone = ?, map_forestal_zone = ?::jsonb\n" + 
            "WHERE uuid_forestal_zone = ?\n";

    /****************Tree Species****************/
    
    public static final String CREATE_TREE_SPECIES = "INSERT INTO forestal_managment.tree_species \n" +
            "(uuid_tree_species, name_tree_species,common_name_tree_species,family_tree_species,origin_tree_species,\n" +
            "order_name_tree_species,habitat_tree_species,description_tree_species,image_url_tree_species) \n" +
            "VALUES(?,?,?,?,?,?,?,?,?)";
    
    public static final String DELETE_TREE_SPECIES = "DELETE FROM forestal_managment.tree_species WHERE uuid_tree_species = ?";
    
    public static final String GET_ALL_TREE_SPECIES = "SELECT * FROM forestal_managment.tree_species";
    
    public static final String GET_BY_ID_TREE_SPECIES = "SELECT * FROM forestal_managment.tree_species WHERE uuid_tree_species = ?";
    
    public static final String UPDATE_BY_ID_TREE_SPECIES = "UPDATE forestal_managment.tree_species\n" +
"SET name_tree_species = ?, common_name_tree_species = ?, family_tree_species = ?, origin_tree_species = ?,\n" +
"order_name_tree_species = ?, habitat_tree_species = ?, description_tree_species = ?, image_url_tree_species = ?";
    
    /****************Conservation Activities****************/
    public static final String CREATE_CONSERVATION_ACTIVITY = "INSERT INTO forestal_managment.conservation_activity\n" +
    "(uuid_conservation_activity, name_conservation_activity, description_conservation_activity,\n" +
    "activity_date_conservation_activity, uuid_forestal_zone)\n" +
    "VALUES (?, ?, ?, ?, ?)";

    public static final String DELETE_CONSERVATION_ACTIVITY = "DELETE FROM forestal_managment.conservation_activity WHERE uuid_conservation_activity = ?";

    public static final String GET_ALL_CONSERVATION_ACTIVITY = "SELECT * FROM forestal_managment.conservation_activity";

    public static final String GET_BY_ID_CONSERVATION_ACTIVITY = "SELECT * FROM forestal_managment.conservation_activity WHERE uuid_conservation_activity = ?";

    public static final String UPDATE_BY_ID_CONSERVATION_ACTIVITY = "UPDATE forestal_managment.conservation_activity\n" +
        "SET name_conservation_activity = ?, description_conservation_activity = ?, activity_date_conservation_activity = ?, uuid_forestal_zone = ?\n" +
        "WHERE uuid_conservation_activity = ?";
}
