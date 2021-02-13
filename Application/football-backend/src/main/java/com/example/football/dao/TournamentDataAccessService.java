package com.example.football.dao;

import java.util.List;
import java.util.Random;

import com.example.football.model.Tournament;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("TournamentDataAccessService")
public class TournamentDataAccessService implements TournamentDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean addTournament(Tournament tournament) {
        Random rand = new Random();
        Exception checkedException;
        int numberOfRandomKeyTries = 3;

        do {
            try {
                jdbcTemplate.update("INSERT INTO TOURNAMENT (TournametID, TournamentName, PitchID) VALUES (?, ?, ?)",
                        rand.nextInt(255), tournament.getTournamentName(), tournament.getPitchID());
                return true;
            } catch (Exception e) {
                checkedException = e;
                numberOfRandomKeyTries--;
            }
        } while (checkedException.getClass().getCanonicalName().toString().contains("DuplicateKeyException")
                && numberOfRandomKeyTries > 0);

        System.out.println(checkedException);
        return false;

    }

    @Override
    public List<Tournament> getAllTournaments() {
        return jdbcTemplate.query("SELECT * FROM TOURNAMENT", BeanPropertyRowMapper.newInstance(Tournament.class));
    }

    @Override
    public Tournament selectTournamentById(int tournamentId) {
        return jdbcTemplate.queryForObject("SELECT * FROM TOURNAMENT WHERE TournametID = ?", new TournamentRowMapper(),
                tournamentId);
    }

    @Override
    public boolean deleteTournamentById(int tournamentId) {
        try {

            // Number of rows affected
            if (jdbcTemplate.update("DELETE FROM TOURNAMENT where TournametID = ?", tournamentId) > 0) {
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
    public boolean updateTournamentById(int tournamentId, Tournament tournament) {
        try {
            jdbcTemplate.update(
                    "UPDATE TOURNAMENT SET TournametID = ?, TournamentName = ?, PitchID = ? where TournametID = ?",
                    tournament.getTournametID(), tournament.getTournamentName(), tournament.getPitchID(), tournamentId);
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

}
