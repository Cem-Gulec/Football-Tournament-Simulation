package com.example.football.dao;

import java.util.List;

import com.example.football.model.Manager;
import com.example.football.model.Pitch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("PitchDataAccessService")
public class PitchDataAccessService implements PitchDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean addPitch(Pitch pitch) {
        try {
            jdbcTemplate.update("INSERT INTO PITCH (Name, Location, OwnerName, BusinessNumber) VALUES (?, ?, ?, ?)",
                    pitch.getName(), pitch.getLocation(), pitch.getOwnerName(), pitch.getBusinessNumber());
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }

    }

    @Override
    public List<Pitch> getAllPitches() {
        return jdbcTemplate.query("SELECT * FROM PITCH", BeanPropertyRowMapper.newInstance(Pitch.class));
    }

    @Override
    public Pitch selectPitchById(int pitchId) {
        return jdbcTemplate.queryForObject("SELECT * FROM PITCH WHERE PitchID = ?", new PitchRowMapper(), pitchId);
    }

    @Override
    public boolean deletePitchById(int pitchId) {
        try {

            // Number of rows affected
            if (jdbcTemplate.update("DELETE FROM PITCH where PitchID = ?", pitchId) > 0) {
                return true;
            } else {
                return false;
            }

        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

    @Override
    public boolean updatePitchById(int pitchId, Pitch pitch) {
        try {
            jdbcTemplate.update(
                    "UPDATE PITCH SET Name = ?, Location = ?, OwnerName = ?, BusinessNumber = ? where pitchId = ?",
                    pitch.getName(), pitch.getLocation(), pitch.getOwnerName(), pitch.getBusinessNumber(), pitchId);
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

}
