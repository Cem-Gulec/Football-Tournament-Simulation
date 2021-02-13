package com.example.football.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.example.football.model.Match;

import org.springframework.jdbc.core.RowMapper;

public class MatchRowMapper implements RowMapper<Match> {

    @Override
    public Match mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new Match(rs.getInt("HomeTeamID"), rs.getInt("AwayTeamID"), rs.getString("Week"), rs.getInt("RefereeID"),
                rs.getDate("Date"), rs.getString("FinalResult"), rs.getString("MatchStage"));
    }

}
