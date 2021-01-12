package com.example.football.model;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Referee {

    private int RefereeID;
    private String FirstName;
    private String LastName;
    private int YearsOfExperience;

    public Referee() {
        super();
    }

    public Referee(@JsonProperty("refereeId") int RefereeID, @JsonProperty("firstName") String FirstName,
            @JsonProperty("lastName") String LastName, @JsonProperty("yearsOfExperience") int YearsOfExperience) {
        this.RefereeID = RefereeID;
        this.FirstName = FirstName;
        this.LastName = LastName;
        this.YearsOfExperience = YearsOfExperience;
    }

    public int getRefereeID() {
        return this.RefereeID;
    }

    public void setRefereeID(int RefereeID) {
        this.RefereeID = RefereeID;
    }

    public String getFirstName() {
        return this.FirstName;
    }

    public void setFirstName(String FirstName) {
        this.FirstName = FirstName;
    }

    public String getLastName() {
        return this.LastName;
    }

    public void setLastName(String LastName) {
        this.LastName = LastName;
    }

    public int getYearsOfExperience() {
        return this.YearsOfExperience;
    }

    public void setYearsOfExperience(int YearsOfExperience) {
        this.YearsOfExperience = YearsOfExperience;
    }

}
