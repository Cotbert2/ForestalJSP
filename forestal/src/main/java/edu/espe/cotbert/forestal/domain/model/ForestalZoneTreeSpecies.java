/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.espe.cotbert.forestal.domain.model;
import java.util.UUID;

/**
 *
 * @author jeffersonyepez
 */
public class ForestalZoneTreeSpecies {
    private String uuid;
    private String uuidForestalZone;
    private String uuidTreeSpecies;
    
    public ForestalZoneTreeSpecies(String uuid, String uuidFoorestalZone, String uuidTreeSpecies){
        this.uuid = uuid;
        this.uuidForestalZone = uuidFoorestalZone;
        this.uuidTreeSpecies = uuidTreeSpecies;
    }
    
    public ForestalZoneTreeSpecies(String uuidFoorestalZone, String uuidTreeSpecies){
        this.uuid = UUID.randomUUID().toString();
        this.uuidForestalZone = uuidFoorestalZone;
        this.uuidTreeSpecies = uuidTreeSpecies;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getUuidForestalZone() {
        return uuidForestalZone;
    }

    public void setUuidForestalZone(String uuidForestalZone) {
        this.uuidForestalZone = uuidForestalZone;
    }

    public String getUuidTreeSpecies() {
        return uuidTreeSpecies;
    }

    public void setUuidTreeSpecies(String uuidTreeSpecies) {
        this.uuidTreeSpecies = uuidTreeSpecies;
    }
    
    
}
