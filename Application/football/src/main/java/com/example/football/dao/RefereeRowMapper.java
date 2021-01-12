package com.example.football.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.example.football.model.Referee;

import org.springframework.jdbc.core.RowMapper;

public class RefereeRowMapper implements RowMapper<Referee> {

    @Override
    public Referee mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new Referee(rs.getInt("RefereeID"), rs.getString("FirstName"), rs.getString("LastName"),
                rs.getInt("YearsOfExperience"));
    }

}
