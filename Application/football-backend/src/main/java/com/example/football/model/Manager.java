package com.example.football.model;

import java.util.Date;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Manager {

    private int ManagerID;
    @NotNull
    private String FirstName;
    @NotNull
    private String LastName;
    @NotNull
    private String Nationality;
    @NotNull
    private Date BirthDate;
    @NotNull
    private int Age;
    @NotNull
    private int YearsOfExperience;

    public Manager() {
        super();
    }

    public Manager(@JsonProperty("managerId") int ManagerID, @JsonProperty("firstName") String FirstName,
            @JsonProperty("lastName") String LastName, @JsonProperty("nationality") String Nationality,
            @JsonProperty("birthDate") Date BirthDate, @JsonProperty("age") int Age,
            @JsonProperty("yearsOfExperience") int YearsOfExperience) {
        this.ManagerID = ManagerID;
        this.FirstName = FirstName;
        this.LastName = LastName;
        this.Nationality = Nationality;
        this.BirthDate = BirthDate;
        this.Age = Age;
        this.YearsOfExperience = YearsOfExperience;
    }

    public int getManagerID() {
        return this.ManagerID;
    }

    public void setManagerID(int ManagerID) {
        this.ManagerID = ManagerID;
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

    public int getYearsOfExperience() {
        return this.YearsOfExperience;
    }

    public void setYearsOfExperience(int YearsOfExperience) {
        this.YearsOfExperience = YearsOfExperience;
    }

}
