package com.example.football.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.example.football.model.Tournament;

import org.springframework.jdbc.core.RowMapper;

public class TournamentRowMapper implements RowMapper<Tournament> {

    @Override
    public Tournament mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new Tournament(rs.getInt("TournametID"), rs.getString("TournamentName"), rs.getInt("PitchID"));
    }

}
