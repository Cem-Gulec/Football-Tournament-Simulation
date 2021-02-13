package com.example.football.model;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Awards {

    private int SeasonAwardsID;
    @NotNull
    private int ChampionTeamID;
    @NotNull
    private int MostValuablePlayerID;
    @NotNull
    private int MostValuableCoachID;
    @NotNull
    private int TournamentID;

    public Awards() {
        super();
    }

    public Awards(@JsonProperty("seasonAwardsId") int SeasonAwardsID, @JsonProperty("championTeamId") int ChampionTeamID, @JsonProperty("mostValuablePlayerId") int MostValuablePlayerID, @JsonProperty("mostValuableCoachId") int MostValuableCoachID, @JsonProperty("tournamentId") int TournamentID) {
        this.SeasonAwardsID = SeasonAwardsID;
        this.ChampionTeamID = ChampionTeamID;
        this.MostValuablePlayerID = MostValuablePlayerID;
        this.MostValuableCoachID = MostValuableCoachID;
        this.TournamentID = TournamentID;
    }

    public int getSeasonAwardsID() {
        return this.SeasonAwardsID;
    }

    public void setSeasonAwardsID(int SeasonAwardsID) {
        this.SeasonAwardsID = SeasonAwardsID;
    }

    public int getChampionTeamID() {
        return this.ChampionTeamID;
    }

    public void setChampionTeamID(int ChampionTeamID) {
        this.ChampionTeamID = ChampionTeamID;
    }

    public int getMostValuablePlayerID() {
        return this.MostValuablePlayerID;
    }

    public void setMostValuablePlayerID(int MostValuablePlayerID) {
        this.MostValuablePlayerID = MostValuablePlayerID;
    }

    public int getMostValuableCoachID() {
        return this.MostValuableCoachID;
    }

    public void setMostValuableCoachID(int MostValuableCoachID) {
        this.MostValuableCoachID = MostValuableCoachID;
    }

    public int getTournamentID() {
        return this.TournamentID;
    }

    public void setTournamentID(int TournamentID) {
        this.TournamentID = TournamentID;
    }

}
