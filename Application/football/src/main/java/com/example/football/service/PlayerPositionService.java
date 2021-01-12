package com.example.football.service;

import java.util.List;

import com.example.football.dao.PlayerPositionDao;
import com.example.football.model.PlayerPosition;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class PlayerPositionService {

    private final PlayerPositionDao playerPositionDao;

    @Autowired
    public PlayerPositionService(@Qualifier("PlayerPositionDataAccessService") PlayerPositionDao playerPositionDao) {
        this.playerPositionDao = playerPositionDao;
    }

    public boolean addPlayerPosition(PlayerPosition playerPosition) {
        return playerPositionDao.addPlayerPosition(playerPosition);
    }

    public List<PlayerPosition> getAllPlayerPositions() {
        return playerPositionDao.getAllPlayerPositions();
    }

    public PlayerPosition selectPlayerPositionByPlayerIdAndPosition(int playerId, String position) {
        return playerPositionDao.selectPlayerPositionByPlayerIdAndPosition(playerId, position);
    }

    public boolean deletePlayerPositionByPlayerIdAndPosition(int playerId, String position) {
        return playerPositionDao.deletePlayerPositionByPlayerIdAndPosition(playerId, position);
    }

    public boolean updatePositionByPlayerIdAndPosition(int playerId, String position, PlayerPosition playerPosition) {
        return playerPositionDao.updatePositionByPlayerIdAndPosition(playerId, position, playerPosition);
    }

}
