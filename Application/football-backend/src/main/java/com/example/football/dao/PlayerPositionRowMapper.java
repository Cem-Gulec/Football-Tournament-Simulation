package com.example.football.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.example.football.model.PlayerPosition;

import org.springframework.jdbc.core.RowMapper;

public class PlayerPositionRowMapper implements RowMapper<PlayerPosition> {

    @Override
    public PlayerPosition mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new PlayerPosition(rs.getInt("PlayerID"), rs.getString("Position"));
    }

}
