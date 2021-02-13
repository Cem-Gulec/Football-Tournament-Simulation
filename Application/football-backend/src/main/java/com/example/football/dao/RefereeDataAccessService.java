package com.example.football.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.example.football.model.Referee;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("RefereeDataAccessService")
public class RefereeDataAccessService implements RefereeDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean addReferee(Referee referee) {
        Random rand = new Random(); 
        Exception checkedException;
        int numberOfRandomKeyTries = 3;
        
        do {
            try {
                jdbcTemplate.update(
                        "INSERT INTO REFEREE (RefereeID, FirstName, LastName, YearsOfExperience) VALUES (?, ?, ?, ?)",
                        rand.nextInt(255), referee.getFirstName(), referee.getLastName(),
                        referee.getYearsOfExperience());
                return true;
            } catch (Exception e) {
                checkedException = e;
                numberOfRandomKeyTries--;
            }
        } while (checkedException.getClass().getCanonicalName().toString().contains("DuplicateKeyException") && numberOfRandomKeyTries > 0);

        System.out.println(checkedException);
        return false;

    }

    @Override
    public List<Referee> getAllReferees() {
        return jdbcTemplate.query("SELECT * FROM REFEREE", BeanPropertyRowMapper.newInstance(Referee.class));
    }
    
    @Override
    public Map<Integer, String> getAllRefereeNames() {
        List<Referee> allReferees = getAllReferees();
        HashMap<Integer, String> refereeNames = new HashMap<>();
        for (Referee referee : allReferees) {
            refereeNames.put(referee.getRefereeID(), referee.getFirstName() + " " + referee.getLastName());
        }
        return refereeNames;
    }

    @Override
    public Referee selectRefereeById(int refereeId) {
        return jdbcTemplate.queryForObject("SELECT * FROM REFEREE WHERE RefereeID = ?", new RefereeRowMapper(),
                refereeId);
    }

    @Override
    public boolean deleteRefereeById(int refereeId) {
        try {

            // Number of rows affected
            if (jdbcTemplate.update("DELETE FROM REFEREE where RefereeID = ?", refereeId) > 0) {
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
    public boolean updateRefereeById(int refereeId, Referee referee) {
        try {
            jdbcTemplate.update(
                    "UPDATE REFEREE SET RefereeID = ?, FirstName = ?, LastName = ?, YearsOfExperience = ? where RefereeID = ?",
                    referee.getRefereeID(), referee.getFirstName(), referee.getLastName(),
                    referee.getYearsOfExperience(), refereeId);
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

}
