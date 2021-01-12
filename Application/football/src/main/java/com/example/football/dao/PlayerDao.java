package com.example.football.dao;

import java.util.List;
import java.util.Map;

import com.example.football.model.Player;

public interface PlayerDao {

    boolean addPlayer(Player player);

    List<Player> getAllPlayers();

    Map<Integer, String> getAllPlayerNames();

    Player selectPlayerById(int playerId);

    boolean deletePlayerById(int playerId);

    boolean updatePlayerById(int playerId, Player player);

}
