package com.example.football.model;

import java.util.Date;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Player {

    private int PlayerID;
    private String FirstName;
    private String LastName;
    @NotNull
    private int TeamID;
    private String Nationality;
    private Date BirthDate;
    private int Age;
    private int NumberOfGoals;

    public Player() {
        super();
    }

    public Player(@JsonProperty("PlayerID") int PlayerID, @JsonProperty("firstName") String FirstName,
            @JsonProperty("lastName") String LastName, @JsonProperty("TeamID") int TeamID,
            @JsonProperty("Nationality") String Nationality, @JsonProperty("BirthDate") Date BirthDate,
            @JsonProperty("Age") int Age, @JsonProperty("NumberOfGoals") int NumberOfGoals) {
        this.PlayerID = PlayerID;
        this.FirstName = FirstName;
        this.LastName = LastName;
        this.TeamID = TeamID;
        this.Nationality = Nationality;
        this.BirthDate = BirthDate;
        this.Age = Age;
        this.NumberOfGoals = NumberOfGoals;
    }

    public int getPlayerID() {
        return this.PlayerID;
    }

    public void setPlayerID(int PlayerID) {
        this.PlayerID = PlayerID;
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

    public int getTeamID() {
        return this.TeamID;
    }

    public void setTeamID(int TeamID) {
        this.TeamID = TeamID;
    }

    public String getNationality() {
        return this.Nationality;
    }

    public void setNationality(String Nationality) {
        this.Nationality = Nationality;
    }

    public Date getBirthDate() {
        return this.BirthDate;
    }

    public void setBirthDate(Date BirthDate) {
        this.BirthDate = BirthDate;
    }

    public int getAge() {
        return this.Age;
    }

    public void setAge(int Age) {
        this.Age = Age;
    }

    public int getNumberOfGoals() {
        return this.NumberOfGoals;
    }

    public void setNumberOfGoals(int NumberOfGoals) {
        this.NumberOfGoals = NumberOfGoals;
    }

}
