/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.espe.cotbert.forestal.domain.model;
import java.sql.Timestamp;
import java.util.Date;
import java.util.UUID;

/**
 *
 * @author mateo
 */
public class TreeSpecies {
    private String uuid;
    private String name;
    private String commonName;
    private String family;
    private String origin;
    private String orderName;
    private String habitat;
    private String description;
    private String image;
    
    public TreeSpecies(String uuid, String name, String commonName, String family, String origin, String orderName, String habitat, String description, String image){
        this.uuid = uuid;
        this.name = name;
        this.commonName = commonName;
        this.family = family;
        this.origin = origin;
        this.orderName = orderName;
        this.habitat = habitat;
        this.description = description;
        this.image = image;
    }
    //generate uuid if null
    public TreeSpecies(String name, String commonName, String family,String origin, String orderName, String habitat, String description, String image){
        this.uuid = UUID.randomUUID().toString();
        this.name = name;
        this.commonName = commonName;
        this.family = family;
        this.origin = origin;
        this.orderName = orderName;
        this.habitat = habitat;
        this.description = description;
        this.image = image;
    }
    
    //setters and getters

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCommonName() {
        return commonName;
    }

    public void setCommonName(String commonName) {
        this.commonName = commonName;
    }

    public String getFamily() {
        return family;
    }

    public void setFamily(String family) {
        this.family = family;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getOrderName() {
        return orderName;
    }

    public void setOrderName(String orderName) {
        this.orderName = orderName;
    }

    public String getHabitat() {
        return habitat;
    }

    public void setHabitat(String habitat) {
        this.habitat = habitat;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
    
}
