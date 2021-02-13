package com.example.football.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.example.football.model.Team;

import org.springframework.jdbc.core.RowMapper;

public class TeamRowMapper implements RowMapper<Team> {

    @Override
    public Team mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new Team(rs.getInt("TeamID"), rs.getString("Name"), rs.getString("Location"), rs.getInt("ManagerID"));
    }

}
