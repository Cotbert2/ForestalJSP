package edu.espe.cotbert.forestal.domain.model;

import java.sql.Timestamp;
import java.util.UUID;

public class ConservationActivities {

    private String uuid;
    private String name;
    private String description;
    private Timestamp startDate;
    private Timestamp endDate;
    private Timestamp registerDate;
    private String forestalZoneUuid;

    public ConservationActivities(String uuid, String name, String description, Timestamp startDate, Timestamp endDate, Timestamp registerDate, String forestalZoneUuid) {
        this.uuid = uuid;
        this.name = name;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.registerDate = registerDate;
        this.forestalZoneUuid = forestalZoneUuid;
    }

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

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public Timestamp getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Timestamp registerDate) {
        this.registerDate = registerDate;
    }

    public String getForestalZoneUuid() {
        return forestalZoneUuid;
    }

    public void setForestalZoneUuid(String forestalZoneUuid) {
        this.forestalZoneUuid = forestalZoneUuid;
    }

    
}
