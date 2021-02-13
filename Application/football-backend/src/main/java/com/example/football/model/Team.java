package com.example.football.model;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Team {

    private int TeamID;
    private String Name;
    private String Location;
    @NotNull
    private int ManagerID;

    public Team() {
        super();
    }

    public Team(@JsonProperty("teamId") int TeamID, @JsonProperty("name") String Name,
            @JsonProperty("location") String Location, @JsonProperty("managerId") int ManagerID) {
        this.TeamID = TeamID;
        this.Name = Name;
        this.Location = Location;
        this.ManagerID = ManagerID;
    }

    public int getTeamID() {
        return this.TeamID;
    }

    public void setTeamID(int TeamID) {
        this.TeamID = TeamID;
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

    public int getManagerID() {
        return this.ManagerID;
    }

    public void setManagerID(int ManagerID) {
        this.ManagerID = ManagerID;
    }

}
