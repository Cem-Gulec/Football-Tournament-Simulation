package com.example.football.model;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Tournament {

    private int TournametID;
    private String TournamentName;
    @NotNull
    private int PitchID;

    public Tournament() {
        super();
    }

    public Tournament(@JsonProperty("tournamentId") int TournametID,
            @JsonProperty("tournamentName") String TournamentName, @JsonProperty("pitchId") int PitchID) {
        this.TournametID = TournametID;
        this.TournamentName = TournamentName;
        this.PitchID = PitchID;
    }

    public int getTournametID() {
        return this.TournametID;
    }

    public void setTournametID(int TournametID) {
        this.TournametID = TournametID;
    }

    public String getTournamentName() {
        return this.TournamentName;
    }

    public void setTournamentName(String TournamentName) {
        this.TournamentName = TournamentName;
    }

    public int getPitchID() {
        return this.PitchID;
    }

    public void setPitchID(int PitchID) {
        this.PitchID = PitchID;
    }

}
