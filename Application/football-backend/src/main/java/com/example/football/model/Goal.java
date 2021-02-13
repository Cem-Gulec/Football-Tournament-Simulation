package com.example.football.model;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Goal {
    @NotNull
    private int HomeTeamID;
    @NotNull
    private int AwayTeamID;
    @NotNull
    private int PlayerID;
    @NotNull
    private int Minute;
    @NotNull
    private String Week;

    public Goal() {
        super();
    }

    public Goal(@JsonProperty("homeTeamId") int HomeTeamID, @JsonProperty("awayTeamId") int AwayTeamID, @JsonProperty("playerId") int PlayerID, @JsonProperty("minute") int Minute, @JsonProperty("week") String Week) {
        this.HomeTeamID = HomeTeamID;
        this.AwayTeamID = AwayTeamID;
        this.PlayerID = PlayerID;
        this.Minute = Minute;
        this.Week = Week;
    }

    public int getHomeTeamID() {
        return this.HomeTeamID;
    }

    public void setHomeTeamID(int HomeTeamID) {
        this.HomeTeamID = HomeTeamID;
    }

    public int getAwayTeamID() {
        return this.AwayTeamID;
    }

    public void setAwayTeamID(int AwayTeamID) {
        this.AwayTeamID = AwayTeamID;
    }

    public int getPlayerID() {
        return this.PlayerID;
    }

    public void setPlayerID(int PlayerID) {
        this.PlayerID = PlayerID;
    }

    public int getMinute() {
        return this.Minute;
    }

    public void setMinute(int Minute) {
        this.Minute = Minute;
    }

    public String getWeek() {
        return this.Week;
    }

    public void setWeek(String Week) {
        this.Week = Week;
    }

}
