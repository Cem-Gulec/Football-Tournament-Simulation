package com.example.football.model;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Pitch {

    private int PitchID;
    @NotNull
    private String Name;
    @NotNull
    private String Location;
    @NotNull
    private String OwnerName;
    @NotNull
    private String BusinessNumber;

    public Pitch() {
        super();
    }

    public Pitch(@JsonProperty("pitchId") int PitchID, @JsonProperty("name") String Name,
            @JsonProperty("location") String Location, @JsonProperty("ownerName") String OwnerName,
            @JsonProperty("businessNumber") String BusinessNumber) {
        this.PitchID = PitchID;
        this.Name = Name;
        this.Location = Location;
        this.OwnerName = OwnerName;
        this.BusinessNumber = BusinessNumber;
    }

    public int getPitchID() {
        return this.PitchID;
    }

    public void setPitchID(int PitchID) {
        this.PitchID = PitchID;
    }

    public String getName() {
        return this.Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getLocation() {
        return this.Location;
    }

    public void setLocation(String Location) {
        this.Location = Location;
    }

    public String getOwnerName() {
        return this.OwnerName;
    }

    public void setOwnerName(String OwnerName) {
        this.OwnerName = OwnerName;
    }

    public String getBusinessNumber() {
        return this.BusinessNumber;
    }

    public void setBusinessNumber(String BusinessNumber) {
        this.BusinessNumber = BusinessNumber;
    }

}
