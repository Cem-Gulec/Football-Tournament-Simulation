package com.example.football.model;

import java.util.Date;

import javax.validation.constraints.NotNull;

import com.example.football.dao.TeamDataAccessService;
import com.fasterxml.jackson.annotation.JsonProperty;

import org.springframework.beans.factory.annotation.Autowired;

public class Match {

    private int HomeTeamID;
    private int AwayTeamID;
    private String Week;
    @NotNull
    private int RefereeID;
    @NotNull
    private Date Date;
    @NotNull
    private String FinalResult;
    @NotNull
    private String MatchStage;    

    public Match() {
        super();
    }

    public Match(@JsonProperty("homeTeamId") int HomeTeamID, @JsonProperty("awayTeamId") int AwayTeamID,
            @JsonProperty("week") String Week, @JsonProperty("refereeId") int RefereeID,
            @JsonProperty("date") Date Date, @JsonProperty("finalResult") String FinalResult,
            @JsonProperty("matchStage") String MatchStage) {
        this.HomeTeamID = HomeTeamID;
        this.AwayTeamID = AwayTeamID;
        this.Week = Week;
        this.RefereeID = RefereeID;
        this.Date = Date;
        this.FinalResult = FinalResult;
        this.MatchStage = MatchStage;
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

    public String getWeek() {
        return this.Week;
    }

    public void setWeek(String Week) {
        this.Week = Week;
    }

    public int getRefereeID() {
        return this.RefereeID;
    }

    public void setRefereeID(int RefereeID) {
        this.RefereeID = RefereeID;
    }

    public Date getDate() {
        return this.Date;
    }

    public void setDate(Date Date) {
        this.Date = Date;
    }

    public String getFinalResult() {
        return this.FinalResult;
    }

    public void setFinalResult(String FinalResult) {
        this.FinalResult = FinalResult;
    }

    public String getMatchStage() {
        return this.MatchStage;
    }

    public void setMatchStage(String MatchStage) {
        this.MatchStage = MatchStage;
    }

}
