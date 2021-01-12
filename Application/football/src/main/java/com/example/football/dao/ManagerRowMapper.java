package com.example.football.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.example.football.model.Manager;

import org.springframework.jdbc.core.RowMapper;

public class ManagerRowMapper implements RowMapper<Manager> {

    @Override
    public Manager mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new Manager(rs.getInt("ManagerID"), rs.getString("FirstName"), rs.getString("LastName"),
                rs.getString("Nationality"), rs.getDate("BirthDate"), rs.getInt("Age"),
                rs.getInt("YearsOfExperience"));
    }

}
