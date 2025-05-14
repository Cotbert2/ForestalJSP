/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.espe.cotbert.forestal.domain.model;

/**
 *
 * @author sebrux
 */
public class Origins {
    private String uuid_origin;
    private String name_origin;

    public Origins(String uuid_origin, String name_origin) {
        this.uuid_origin = uuid_origin;
        this.name_origin = name_origin;
    }

    public String getUuid_origin() {
        return uuid_origin;
    }

    public void setUuid_origin(String uuid_origin) {
        this.uuid_origin = uuid_origin;
    }

    public String getName_origin() {
        return name_origin;
    }

    public void setName_origin(String name_origin) {
        this.name_origin = name_origin;
    }
    
    
}
