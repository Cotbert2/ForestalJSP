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
public class ForestalZone {

    private String uuid;
    private String name;
    private String description;
    private float area;
    private String image;
    private Timestamp registerDate;
    private String mapJson;


    public ForestalZone(String uuid, String name, String description, float area, String image, Timestamp registerDate, String mapJson) {
        this.uuid = uuid;
        this.name = name;
        this.description = description;
        this.area = area;
        this.image = image;
        this.registerDate = registerDate;
        this.mapJson = mapJson;
    }

    //generate uuid if null
    public ForestalZone(String name, String description, float area, String image, Timestamp registerDate, String mapJson) {
        this.uuid = UUID.randomUUID().toString();
        this.name = name;
        this.description = description;
        this.area = area;
        this.image = image;
        this.registerDate = registerDate;
        this.mapJson = mapJson;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getArea() {
        return area;
    }

    public void setArea(float area) {
        this.area = area;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Timestamp getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Timestamp registerDate) {
        this.registerDate = registerDate;
    }

    public String getMapJson() {
        return mapJson;
    }

    public void setMapJson(String mapJson) {
        this.mapJson = mapJson;
    }
}
