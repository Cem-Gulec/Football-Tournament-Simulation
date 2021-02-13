package com.example.football.model;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonProperty;

public class PlayerPosition {

    private int PlayerID;
    private String Position;

    public PlayerPosition() {
        super();
    }

    public PlayerPosition(@JsonProperty("PlayerID") int PlayerID, @JsonProperty("position") String Position) {
        this.PlayerID = PlayerID;
        this.Position = Position;
    }

    public int getPlayerID() {
        return this.PlayerID;
    }

    public void setPlayerID(int PlayerID) {
        this.PlayerID = PlayerID;
    }

    public String getPosition() {
        return this.Position;
    }

    public void setPosition(String Position) {
        this.Position = Position;
    }
    
}
