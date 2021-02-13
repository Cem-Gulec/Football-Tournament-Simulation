package com.example.football.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.example.football.model.Awards;

import org.springframework.jdbc.core.RowMapper;

public class AwardsRowMapper implements RowMapper<Awards> {

    @Override
    public Awards mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new Awards(rs.getInt("SeasonAwardsID"), rs.getInt("ChampionTeamID"), rs.getInt("MostValuablePlayerID"),
                rs.getInt("MostValuableCoachID"), rs.getInt("TournamentID"));
    }

}
