package com.example.football.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.example.football.model.Pitch;

import org.springframework.jdbc.core.RowMapper;

public class PitchRowMapper implements RowMapper<Pitch> {

    @Override
    public Pitch mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new Pitch(rs.getInt("PitchID"), rs.getString("Name"), rs.getString("Location"),
                rs.getString("OwnerName"), rs.getString("BusinessNumber"));
    }

}
