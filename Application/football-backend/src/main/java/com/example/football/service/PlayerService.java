package com.example.football.service;

import java.util.List;
import java.util.Map;

import com.example.football.dao.PlayerDao;
import com.example.football.model.Player;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class PlayerService {

    private final PlayerDao playerDao;

    @Autowired
    public PlayerService(@Qualifier("PlayerDataAccessService") PlayerDao playerDao) {
        this.playerDao = playerDao;
    }

    public boolean addPlayer(Player player) {
        return playerDao.addPlayer(player);
    }

    public List<Player> getAllPlayers() {
        return playerDao.getAllPlayers();
    }

    public Map<Integer, String> getAllPlayerNames() {
        return playerDao.getAllPlayerNames();
    }

    public Player selectPlayerById(int playerId) {
        return playerDao.selectPlayerById(playerId);
    }

    public boolean deletePlayerById(int playerId) {
        return playerDao.deletePlayerById(playerId);
    }

    public boolean updatePlayerById(int playerId, Player player) {
        return playerDao.updatePlayerById(playerId, player);
    }

}
