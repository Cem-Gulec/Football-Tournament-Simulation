package com.example.football.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.example.football.model.Goal;

import org.springframework.jdbc.core.RowMapper;

public class GoalRowMapper implements RowMapper<Goal> {

    @Override
    public Goal mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new Goal(rs.getInt("HomeTeamID"), rs.getInt("AwayTeamId"), rs.getInt("PlayerID"),
                rs.getInt("Minute"), rs.getString("Week"));
    }

}
