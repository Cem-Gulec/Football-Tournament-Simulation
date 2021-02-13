package com.example.football.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.example.football.model.TournamentTeam;

import org.springframework.jdbc.core.RowMapper;

public class TournamentTeamRowMapper implements RowMapper<TournamentTeam> {

    @Override
    public TournamentTeam mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new TournamentTeam(rs.getInt("TournamentID"), rs.getInt("TeamID"), rs.getString("GroupName"),
                rs.getInt("NumberOfMatchPlayed"), rs.getInt("Won"), rs.getInt("Draw"), rs.getInt("Loss"),
                rs.getInt("GroupPoint"), rs.getInt("GoalScored"), rs.getInt("GoalConceded"), rs.getInt("Average"),
                rs.getString("GroupPosition"), rs.getString("Stage"));
    }

}
