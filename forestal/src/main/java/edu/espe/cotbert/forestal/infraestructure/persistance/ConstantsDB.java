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
    //public static final String DELETE_FORESTAL_ZONE = "DELETE FROM forestal_managment.forestal_zone WHERE uuid_forestal_zone = ?";

    public static final String DELETE_FORESTAL_ZONE = "UPDATE forestal_managment.forestal_zone fz \n" + "set is_deleted_forestal_zone = true WHERE fz.uuid_forestal_zone = ?;";

    public static final String GET_ALL_FORESTAL_ZONE = "SELECT * FROM forestal_managment.forestal_zone";

    public static final String GET_BY_ID_FORESTAL_ZONE = "SELECT * FROM forestal_managment.forestal_zone WHERE uuid_forestal_zone = ?";

    public static final String UPDATE_BY_ID_FORESTAL_ZONE = "UPDATE forestal_managment.forestal_zone SET\n"
            + "name_forestal_zone = ?, description_forestal_zone = ?, area_ha_forestal_zone = ?,\n"
            + "register_date_forestal_zone = ? WHERE uuid_forestal_zone = ?\n";

    /**
     * **************Tree Species***************
     */
    public static final String CREATE_TREE_SPECIES = "INSERT INTO forestal_managment.tree_species \n"
            + "(uuid_tree_species, name_tree_species,common_name_tree_species,family_tree_species,origin_tree_species,\n"
            + "order_name_tree_species,habitat_tree_species,description_tree_species,image_url_tree_species) \n"
            + "VALUES(?,?,?,?,?,?,?,?,?)";

    public static final String DELETE_TREE_SPECIES = "UPDATE forestal_managment.tree_species \n"
            + "SET is_deleted_tree_species = true \n"
            + "WHERE uuid_tree_species  = ?;";

   public static final String GET_ALL_TREE_SPECIES = 
    "SELECT \n"
  + "    ts.uuid_tree_species,\n"
  + "    ts.name_tree_species,\n"
  + "    ts.common_name_tree_species,\n"
  + "    ts.family_tree_species,\n"
  + "    ts.origin_tree_species,\n"
  + "    ts.order_name_tree_species,\n"
  + "    ts.habitat_tree_species,\n"
  + "    ts.description_tree_species,\n"
  + "    ts.image_url_tree_species,\n"
  + "    z.uuid_forestal_zone,\n"
  + "    z.name_forestal_zone,\n"
  + "    z.description_forestal_zone,\n"
  + "    z.area_ha_forestal_zone,\n"
  + "    z.image_url_forestal_zone,\n"
  + "    z.register_date_forestal_zone,\n"
  + "    z.map_forestal_zone\n"
  + "FROM forestal_managment.tree_species ts\n"
  + "LEFT JOIN forestal_managment.forestal_zone_tree_species fzts\n"
  + "    ON ts.uuid_tree_species = fzts.uuid_tree_species\n"
  + "LEFT JOIN forestal_managment.forestal_zone z\n"
  + "    ON z.uuid_forestal_zone = fzts.uuid_forestal_zone\n"
  + "    AND (z.is_deleted_forestal_zone IS NOT TRUE OR z.is_deleted_forestal_zone IS NULL)\n"
  + "WHERE ts.is_deleted_tree_species = FALSE";

    public static final String DELET_BY_RELATION = "DELETE FROM forestal_managment.forestal_zone_tree_species WHERE uuid_tree_species = ?";

    public static final String GET_BY_ID_TREE_SPECIES
            = "SELECT * FROM forestal_managment.tree_species WHERE uuid_tree_species = ? AND is_deleted_tree_species = FALSE";

    public static final String UPDATE_BY_ID_TREE_SPECIES = "UPDATE forestal_managment.tree_species\n"
            + "SET name_tree_species = ?, common_name_tree_species = ?, family_tree_species = ?, origin_tree_species = ?,\n"
            + "order_name_tree_species = ?, habitat_tree_species = ?, description_tree_species = ? WHERE uuid_tree_species = ?";
    public static final String GET_ALL_FORESTAL_ZONE_WITH_TREES = "SELECT \n"
            + "    fz.uuid_forestal_zone,\n"
            + "    fz.name_forestal_zone,\n"
            + "    fz.description_forestal_zone,\n"
            + "    fz.area_ha_forestal_zone,\n"
            + "    fz.image_url_forestal_zone,\n"
            + "    fz.register_date_forestal_zone,\n"
            + "    fz.map_forestal_zone,\n"
            + "    ts.uuid_tree_species,\n"
            + "    ts.name_tree_species,\n"
            + "    ts.common_name_tree_species,\n"
            + "    ts.family_tree_species,\n"
            + "    ts.order_name_tree_species,\n"
            + "    ts.habitat_tree_species,\n"
            + "    ts.description_tree_species,\n"
            + "    ts.image_url_tree_species,\n"
            + "    ts.origin_tree_species\n"
            + "FROM forestal_managment.forestal_zone fz\n"
            + "LEFT JOIN forestal_managment.forestal_zone_tree_species fzts\n"
            + "    ON fz.uuid_forestal_zone = fzts.uuid_forestal_zone\n"
            + "LEFT JOIN forestal_managment.tree_species ts\n"
            + "    ON ts.uuid_tree_species = fzts.uuid_tree_species\n"
            + "WHERE fz.is_deleted_forestal_zone IS NOT TRUE OR fz.is_deleted_forestal_zone IS NULL;";

    /**
     * **************Conservation Activities***************
     *
     */
    /**
     * **************Conservation Activities***************
     */
    public static final String CREATE_CONSERVATION_ACTIVITY = "INSERT INTO forestal_managment.conservation_activities\n"
            + "(uuid_conservation_activity, name_conservation_activity, description_conservation_activity,\n"
            + "start_date_conservation_activity, end_date_conservation_activity, register_date_conservation_activity, \n"
            + "uuidd_forestal_zone, is_deleted_conservation_activities)\n"
            + "VALUES (?, ?, ?, ?, ?, ?, ?, false)";

    public static final String DELETE_CONSERVATION_ACTIVITY = "UPDATE forestal_managment.conservation_activities\n"
            + "SET is_deleted_conservation_activities = true\n"
            + "WHERE uuid_conservation_activity = ?";

public static final String GET_ALL_CONSERVATION_ACTIVITY =
    "SELECT ca.uuid_conservation_activity, ca.name_conservation_activity, ca.description_conservation_activity, "
  + "ca.start_date_conservation_activity, ca.end_date_conservation_activity, ca.register_date_conservation_activity, "
  + "ca.uuidd_forestal_zone, fz.name_forestal_zone "
  + "FROM forestal_managment.conservation_activities ca "
  + "INNER JOIN forestal_managment.forestal_zone fz "
  + "  ON ca.uuidd_forestal_zone = fz.uuid_forestal_zone "
  + "WHERE ca.is_deleted_conservation_activities IS NOT TRUE "
  + "  AND (fz.is_deleted_forestal_zone IS NOT TRUE OR fz.is_deleted_forestal_zone IS NULL)";


    public static final String GET_BY_ID_CONSERVATION_ACTIVITY
            = "SELECT ca.uuid_conservation_activity, ca.name_conservation_activity, ca.description_conservation_activity,\n"
            + "ca.start_date_conservation_activity, ca.end_date_conservation_activity, ca.register_date_conservation_activity,\n"
            + "ca.uuidd_forestal_zone, fz.name_forestal_zone\n"
            + "FROM forestal_managment.conservation_activities ca\n"
            + "LEFT JOIN forestal_managment.forestal_zone fz ON ca.uuidd_forestal_zone = fz.uuid_forestal_zone\n"
            + "WHERE ca.uuid_conservation_activity = ?\n"
            + "AND ca.is_deleted_conservation_activities IS NOT TRUE";

    public static final String UPDATE_BY_ID_CONSERVATION_ACTIVITY = "UPDATE forestal_managment.conservation_activities\n"
            + "SET name_conservation_activity = ?, description_conservation_activity = ?,\n"
            + "start_date_conservation_activity = ?, end_date_conservation_activity = ?, register_date_conservation_activity = ?, uuidd_forestal_zone = ?\n"
            + "WHERE uuid_conservation_activity = ?";
    /**
     * **************Forestal Zone Tree Species***************
     *
     */
    public static final String CREATE_FORESTAL_ZONE_TREE_SPECIES = "insert into  forestal_managment.forestal_zone_tree_species(uuid_forestal_zone_tree_species,uuid_forestal_zone,uuid_tree_species)\n"
            + "VALUES (?,?,?);";

    public static final String DELETE_FORESTAL_ZONE_TREE_SPECIES = "DELETE FROM forestal_managment.forestal_zone_tree_species WHERE uuid_forestal_zone = ? AND uuid_tree_species = ?";

    public static final String GET_ALL_FORESTAL_ZONE_TREE_SPECIES = "SELECT * FROM forestal_managment.forestal_zone_tree_species";

    public static final String GET_BY_ID_FORESTAL_ZONE_TREE_SPECIES = "SELECT * FROM forestal_managment.cforestal_zone_tree_species WHERE uuid_forestal_zone_tree_species = ?";

    public static final String UPDATE_BY_ID_FORESTAL_ZONE_TREE_SPECIES = "UPDATE forestal_managment.forestal_zone_tree_species SET uuid_forestal_zone = ?, uuid_tree_species = ?";

    /**
     * **************Origins***************
     */
    public static final String GET_ALL_ORIGINS = "SELECT uuid_origin, name_origin FROM forestal_managment.origins";

    public static final String GET_BY_ID_ORIGIN = "SELECT uuid_origin, name_origin FROM forestal_managment.origins WHERE uuid_origin = ?";

    public static final String CREATE_ORIGINS = "INSERT INTO forestal_managment.origins (uuid_origin, name_origin) VALUES (?, ?)";
    
    /**
     * **************Users***************
     *
     */
    
    public static final String GET_USER_BY_EMAIL = "SELECT * FROM forestal_managment.users WHERE email_users = ? AND is_active_user = true;";
    public static final String CREATE_USER = "INSERT INTO forestal_managment.users (uuid_users, email_users, phone_users, first_name_users, last_name_users, password_users, role_users, is_active_user) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    public static final String GET_ALL_USERS = "SELECT uuid_users, email_users, phone_users, first_name_users, last_name_users, role_users FROM forestal_managment.users WHERE is_active_user = true";
    public static final String UPDATE_USERS = "UPDATE forestal_managment.users SET email_users = ?, phone_users = ?, first_name_users = ?, last_name_users = ?, role_users = ? WHERE uuid_users = ?";
    public static final String DELETE_USER = "UPDATE forestal_managment.users SET is_active_user = false WHERE uuid_users = ?";

}   
