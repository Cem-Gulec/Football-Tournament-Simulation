package com.example.football.model;

import com.fasterxml.jackson.annotation.JsonProperty;

public class TournamentTeam {

    private int TournamentID;
    private int TeamID;
    private String GroupName;
    private int NumberOfMatchPlayed;
    private int Won;
    private int Draw;
    private int Loss;
    private int GroupPoint;
    private int GoalScored;
    private int GoalConceded;
    private int Average;
    private String GroupPosition;
    private String Stage;

    public TournamentTeam() {
        super();
    }

    public TournamentTeam(@JsonProperty("tournamentId") int TournamentID, @JsonProperty("teamId") int TeamID,
            @JsonProperty("groupName") String GroupName, @JsonProperty("numberOfMatchPlayed") int NumberOfMatchPlayed,
            @JsonProperty("won") int Won, @JsonProperty("draw") int Draw, @JsonProperty("loss") int Loss,
            @JsonProperty("groupPoint") int GroupPoint, @JsonProperty("goalScored") int GoalScored,
            @JsonProperty("goalConceded") int GoalConceded, @JsonProperty("average") int Average,
            @JsonProperty("groupPosition") String GroupPosition, @JsonProperty("stage") String Stage) {
        this.TournamentID = TournamentID;
        this.TeamID = TeamID;
        this.GroupName = GroupName;
        this.NumberOfMatchPlayed = NumberOfMatchPlayed;
        this.Won = Won;
        this.Draw = Draw;
        this.Loss = Loss;
        this.GroupPoint = GroupPoint;
        this.GoalScored = GoalScored;
        this.GoalConceded = GoalConceded;
        this.Average = Average;
        this.GroupPosition = GroupPosition;
        this.Stage = Stage;
    }

    public int getTournamentID() {
        return this.TournamentID;
    }

    public void setTournamentID(int TournamentID) {
        this.TournamentID = TournamentID;
    }

    public int getTeamID() {
        return this.TeamID;
    }

    public void setTeamID(int TeamID) {
        this.TeamID = TeamID;
    }

    public String getGroupName() {
        return this.GroupName;
    }

    public void setGroupName(String GroupName) {
        this.GroupName = GroupName;
    }

    public int getNumberOfMatchPlayed() {
        return this.NumberOfMatchPlayed;
    }

    public void setNumberOfMatchPlayed(int NumberOfMatchPlayed) {
        this.NumberOfMatchPlayed = NumberOfMatchPlayed;
    }

    public int getWon() {
        return this.Won;
    }

    public void setWon(int Won) {
        this.Won = Won;
    }

    public int getDraw() {
        return this.Draw;
    }

    public void setDraw(int Draw) {
        this.Draw = Draw;
    }

    public int getLoss() {
        return this.Loss;
    }

    public void setLoss(int Loss) {
        this.Loss = Loss;
    }

    public int getGroupPoint() {
        return this.GroupPoint;
    }

    public void setGroupPoint(int GroupPoint) {
        this.GroupPoint = GroupPoint;
    }

    public int getGoalScored() {
        return this.GoalScored;
    }

    public void setGoalScored(int GoalScored) {
        this.GoalScored = GoalScored;
    }

    public int getGoalConceded() {
        return this.GoalConceded;
    }

    public void setGoalConceded(int GoalConceded) {
        this.GoalConceded = GoalConceded;
    }

    public int getAverage() {
        return this.Average;
    }

    public void setAverage(int Average) {
        this.Average = Average;
    }

    public String getGroupPosition() {
        return this.GroupPosition;
    }

    public void setGroupPosition(String GroupPosition) {
        this.GroupPosition = GroupPosition;
    }

    public String getStage() {
        return this.Stage;
    }

    public void setStage(String Stage) {
        this.Stage = Stage;
    }

}
