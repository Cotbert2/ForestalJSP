package edu.espe.cotbert.forestal.domain.model;

import java.sql.Timestamp;
import java.util.UUID;

public class ConservationActivities {

    private String uuid;
    private String name;
    private String description;
    private Timestamp activityDate;
    private String forestalZoneUuid;

    public ConservationActivities(String uuid, String name, String description, Timestamp activityDate, String forestalZoneUuid) {
        this.uuid = uuid;
        this.name = name;
        this.description = description;
        this.activityDate = activityDate;
        this.forestalZoneUuid = forestalZoneUuid;
    }

    public ConservationActivities(String name, String description, Timestamp activityDate, String forestalZoneUuid) {
        this.uuid = UUID.randomUUID().toString();
        this.name = name;
        this.description = description;
        this.activityDate = activityDate;
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

    public Timestamp getActivityDate() {
        return activityDate;
    }

    public void setActivityDate(Timestamp activityDate) {
        this.activityDate = activityDate;
    }

    public String getForestalZoneUuid() {
        return forestalZoneUuid;
    }

    public void setForestalZoneUuid(String forestalZoneUuid) {
        this.forestalZoneUuid = forestalZoneUuid;
    }

    
}
