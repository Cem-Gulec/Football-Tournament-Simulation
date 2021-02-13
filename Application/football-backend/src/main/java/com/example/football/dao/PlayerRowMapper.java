package com.example.football.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.example.football.model.Player;

import org.springframework.jdbc.core.RowMapper;

public class PlayerRowMapper implements RowMapper<Player> {

    @Override
    public Player mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new Player(rs.getInt("PlayerID"), rs.getString("FirstName"), rs.getString("LastName"),
                rs.getInt("TeamID"), rs.getString("Nationality"), rs.getDate("BirthDate"), rs.getInt("Age"),
                rs.getInt("NumberOfGoals"));
    }

}
