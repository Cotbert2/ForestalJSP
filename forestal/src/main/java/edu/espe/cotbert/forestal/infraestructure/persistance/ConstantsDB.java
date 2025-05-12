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
    
    /****************Conservation Activities****************/
    
}
