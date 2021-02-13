package com.example.football.dao;

import java.util.List;

import com.example.football.model.PlayerPosition;

public interface PlayerPositionDao {

    boolean addPlayerPosition(PlayerPosition playerPosition);

    List<PlayerPosition> getAllPlayerPositions();

    PlayerPosition selectPlayerPositionByPlayerIdAndPosition(int playerId, String position);

    boolean deletePlayerPositionByPlayerIdAndPosition(int playerId, String position);

    boolean updatePositionByPlayerIdAndPosition(int playerId, String position, PlayerPosition playerPosition);

}
