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

    /**
     * **************Forestal Zones***************
     */
    public static final String CREATE_FORESTAL_ZONE = "INSERT INTO forestal_managment.forestal_zone\n"
            + "(uuid_forestal_zone, name_forestal_zone, description_forestal_zone, area_ha_forestal_zone,\n"
            + "image_url_forestal_zone, register_date_forestal_zone, map_forestal_zone)\n"
            + "VALUES (?, ?, ?, ?, ?, ?, ?::jsonb)\n";
    public static final String DELETE_FORESTAL_ZONE = "DELETE FROM forestal_managment.forestal_zone WHERE uuid_forestal_zone = ?";

    public static final String GET_ALL_FORESTAL_ZONE = "SELECT * FROM forestal_managment.forestal_zone";

    public static final String GET_BY_ID_FORESTAL_ZONE = "SELECT * FROM forestal_managment.forestal_zone WHERE uuid_forestal_zone = ?";

    public static final String UPDATE_BY_ID_FORESTAL_ZONE = "UPDATE forestal_managment.forestal_zone SET\n"
            + "name_forestal_zone = ?, description_forestal_zone = ?, area_ha_forestal_zone = ?,\n"
            + "image_url_forestal_zone = ?, register_date_forestal_zone = ?, map_forestal_zone = ?::jsonb\n"
            + "WHERE uuid_forestal_zone = ?\n";

    /**
     * **************Tree Species***************
     */
    public static final String CREATE_TREE_SPECIES = "INSERT INTO forestal_managment.tree_species \n"
            + "(uuid_tree_species, name_tree_species,common_name_tree_species,family_tree_species,origin_tree_species,\n"
            + "order_name_tree_species,habitat_tree_species,description_tree_species,image_url_tree_species) \n"
            + "VALUES(?,?,?,?,?,?,?,?,?)";

    public static final String DELETE_TREE_SPECIES = "DELETE FROM forestal_managment.tree_species WHERE uuid_tree_species = ?";

    public static final String GET_ALL_TREE_SPECIES = "SELECT * FROM forestal_managment.tree_species";

    public static final String GET_BY_ID_TREE_SPECIES = "SELECT * FROM forestal_managment.tree_species WHERE uuid_tree_species = ?";

    public static final String UPDATE_BY_ID_TREE_SPECIES = "UPDATE forestal_managment.tree_species\n"
            + "SET name_tree_species = ?, common_name_tree_species = ?, family_tree_species = ?, origin_tree_species = ?,\n"
            + "order_name_tree_species = ?, habitat_tree_species = ?, description_tree_species = ?, image_url_tree_species = ?";
    static String GET_ALL_FORESTAL_ZONE_WITH_TREES = "SELECT \n"
            + "    fz.uuid_forestal_zone,\n"
            + "    fz.name_forestal_zone,\n"
            + "    fz.description_forestal_zone,\n"
            + "    fz.area_ha_forestal_zone,\n"
            + "    fz.image_url_forestal_zone,\n"
            + "    fz.register_date_forestal_zone,\n"
            + "    fz.map_forestal_zone,\n"
            + "    \n"
            + "    ts.uuid_tree_species,\n"
            + "    ts.name_tree_species,\n"
            + "    ts.common_name_tree_species,\n"
            + "    ts.family_tree_species,\n"
            + "    ts.order_name_tree_species,\n"
            + "    ts.habitat_tree_species,\n"
            + "    ts.description_tree_species,\n"
            + "    ts.image_url_tree_species,\n"
            + " ts.origin_tree_species\n"
            + "FROM forestal_managment.forestal_zone fz\n"
            + "LEFT JOIN forestal_managment.forestal_zone_tree_species fzts\n"
            + "    ON fz.uuid_forestal_zone = fzts.uuid_forestal_zone\n"
            + "LEFT JOIN forestal_managment.tree_species ts\n"
            + "    ON ts.uuid_tree_species = fzts.uuid_tree_species;";
    static String DELETE_CONSERVATION_ACTIVITY;
    static String CREATE_CONSERVATION_ACTIVITY;
    static String GET_BY_ID_CONSERVATION_ACTIVITY;
    static String UPDATE_BY_ID_CONSERVATION_ACTIVITY;
    static String GET_ALL_CONSERVATION_ACTIVITY;

    /**
     * **************Conservation Activities***************
     * 
     */
}
