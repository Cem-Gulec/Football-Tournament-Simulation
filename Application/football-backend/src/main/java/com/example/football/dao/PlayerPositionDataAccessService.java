package com.example.football.dao;

import java.util.List;

import com.example.football.model.PlayerPosition;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("PlayerPositionDataAccessService")
public class PlayerPositionDataAccessService implements PlayerPositionDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean addPlayerPosition(PlayerPosition playerPosition) {
        try {
            jdbcTemplate.update("INSERT INTO PLAYER_POSITION (PlayerID, Position) VALUES (?, ?)",
                    playerPosition.getPlayerID(), playerPosition.getPosition());
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }

    }

    @Override
    public List<PlayerPosition> getAllPlayerPositions() {
        return jdbcTemplate.query("SELECT * FROM PLAYER_POSITION",
                BeanPropertyRowMapper.newInstance(PlayerPosition.class));
    }

    @Override
    public PlayerPosition selectPlayerPositionByPlayerIdAndPosition(int playerId, String position) {
        return jdbcTemplate.queryForObject("SELECT * FROM PLAYER_POSITION WHERE PlayerID = ? AND Position = ?",
                new PlayerPositionRowMapper(), playerId, position);
    }

    @Override
    public boolean deletePlayerPositionByPlayerIdAndPosition(int playerId, String position) {
        try {

            // Number of rows affected
            if (jdbcTemplate.update("DELETE FROM PLAYER_POSITION where PlayerID = ? AND Position = ?", playerId,
                    position) > 0) {
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
    public boolean updatePositionByPlayerIdAndPosition(int playerId, String position, PlayerPosition playerPosition) {
        try {
            jdbcTemplate.update(
                    "UPDATE PLAYER_POSITION SET PlayerID = ?, Position = ? where  PlayerID = ? AND Position = ?",
                    playerPosition.getPlayerID(), playerPosition.getPosition(), playerId, position);
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

}
