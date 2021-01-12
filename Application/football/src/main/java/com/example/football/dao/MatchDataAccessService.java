package com.example.football.dao;

import java.util.List;

import com.example.football.model.Match;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("MatchDataAccessService")
public class MatchDataAccessService implements MatchDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean addMatch(Match match) {
        try {
            jdbcTemplate.update(
                    "INSERT INTO MATCH (HomeTeamID, AwayTeamID, Week, RefereeID, Date, FinalResult, MatchStage) VALUES (?, ?, ?, ?, ?, ?, ?)",
                    match.getHomeTeamID(), match.getAwayTeamID(), match.getWeek(), match.getRefereeID(),
                    match.getDate(), match.getFinalResult(), match.getMatchStage());
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }

    }

    @Override
    public List<Match> getAllMatches() {
        return jdbcTemplate.query("SELECT * FROM MATCH", BeanPropertyRowMapper.newInstance(Match.class));
    }

    @Override
    public Match selectMatchByHomeTeamIdAndAwayTeamIdAndWeek(int homeTeamId, int awayTeamId, String week) {
        return jdbcTemplate.queryForObject("SELECT * FROM MATCH WHERE HomeTeamID = ? AND AwayTeamID = ? AND Week = ?",
                new MatchRowMapper(), homeTeamId, awayTeamId, week);
    }

    @Override
    public boolean deleteMatchByHomeTeamIdAndAwayTeamIdAndWeek(int homeTeamId, int awayTeamId, String week) {
        try {

            // Number of rows affected
            if (jdbcTemplate.update("DELETE FROM MATCH where HomeTeamID = ? AND AwayTeamID = ? AND Week = ?",
                    homeTeamId, awayTeamId, week) > 0) {
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
    public boolean updateMatchByHomeTeamIdAndAwayTeamIdAndWeek(int homeTeamId, int awayTeamId, String week,
            Match match) {
        try {
            jdbcTemplate.update(
                    "UPDATE MATCH SET HomeTeamID = ?, AwayTeamID = ?, Week = ?, Date = ?, FinalResult = ?, MatchStage = ? where HomeTeamID = ? AND AwayTeamID = ? AND Week = ?",
                    match.getHomeTeamID(), match.getAwayTeamID(), match.getWeek(), match.getDate(),
                    match.getFinalResult(), match.getMatchStage(), homeTeamId, awayTeamId, week);
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

}
