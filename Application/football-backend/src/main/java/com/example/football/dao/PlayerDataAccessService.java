package com.example.football.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

import com.example.football.model.Player;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.Map;

@Repository("PlayerDataAccessService")
public class PlayerDataAccessService implements PlayerDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean addPlayer(Player player) {
        Random rand = new Random(); 
        Exception checkedException;
        int numberOfRandomKeyTries = 3;

        do {
            try {
                jdbcTemplate.update(
                        "INSERT INTO PLAYER (PlayerID, FirstName, LastName, TeamID, Nationality, BirthDate, NumberOfGoals) VALUES (?, ?, ?, ?, ?, ?, ?)",
                        rand.nextInt(255), player.getFirstName(), player.getLastName(), player.getTeamID(),
                        player.getNationality(), player.getBirthDate(), player.getNumberOfGoals());
                return true;
            } catch (Exception e) {
                checkedException = e;
                numberOfRandomKeyTries--;
            }
        } while (checkedException.getClass().getCanonicalName().toString().contains("DuplicateKeyException") && numberOfRandomKeyTries > 0);

        System.out.println(checkedException);
        return false;

    }

    @Override
    public List<Player> getAllPlayers() {
        return jdbcTemplate.query("SELECT * FROM PLAYER", BeanPropertyRowMapper.newInstance(Player.class));
    }

    @Override
    public Map<Integer, String> getAllPlayerNames() {
        List<Player> allPlayers = getAllPlayers();
        HashMap<Integer, String> playerNames = new HashMap<>();
        for (Player player : allPlayers) {
            playerNames.put(player.getPlayerID(), player.getFirstName() + " " + player.getLastName());
        }
        return playerNames;
    }

    @Override
    public Player selectPlayerById(int playerId) {
        return jdbcTemplate.queryForObject("SELECT * FROM PLAYER WHERE PlayerID = ?", new PlayerRowMapper(), playerId);
    }

    @Override
    public boolean deletePlayerById(int playerId) {
        try {

            // Number of rows affected
            if (jdbcTemplate.update("DELETE FROM PLAYER where PlayerID = ?", playerId) > 0) {
                return true;
            } else {
                return false;
            }

        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

    @Override
    public boolean updatePlayerById(int playerId, Player player) {
        try {
            jdbcTemplate.update(
                    "UPDATE PLAYER SET PlayerID = ?, FirstName = ?, LastName = ?, TeamID = ?, Nationality = ?, BirthDate = ?, NumberOfGoals = ? where PlayerID = ?",
                    player.getPlayerID(), player.getFirstName(), player.getLastName(), player.getTeamID(),
                    player.getNationality(), player.getBirthDate(), player.getNumberOfGoals(), playerId);
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

}
