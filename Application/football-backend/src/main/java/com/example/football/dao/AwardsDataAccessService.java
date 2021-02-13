package com.example.football.dao;

import java.util.List;
import java.util.Random;

import com.example.football.model.Awards;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("AwardsDataAccessService")
public class AwardsDataAccessService implements AwardsDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean addAward(Awards award) {
        Random rand = new Random(); 
        Exception checkedException;
        int numberOfRandomKeyTries = 3;

        do {
            try {
                jdbcTemplate.update("INSERT INTO AWARDS VALUES (?, ?, ?, ?, ?)", rand.nextInt(255),
                        award.getChampionTeamID(), award.getMostValuablePlayerID(), award.getMostValuableCoachID(),
                        award.getTournamentID());
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
    public List<Awards> getAllAwards() {
        return jdbcTemplate.query("SELECT * FROM AWARDS", BeanPropertyRowMapper.newInstance(Awards.class));
    }

    @Override
    public Awards selectAwardBySeasonAwardsId(int SeasonAwardsId) {
        return jdbcTemplate.queryForObject("SELECT * FROM AWARDS WHERE SeasonAwardsId = ?", new AwardsRowMapper(),
                SeasonAwardsId);
    }

    @Override
    public boolean deleteAwardBySeasonAwardsId(int SeasonAwardsId) {
        try {

            // Number of rows affected
            if (jdbcTemplate.update("DELETE FROM AWARDS where SeasonAwardsId = ?", SeasonAwardsId) > 0) {
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
    public boolean updateAwardBySeasonAwardsId(int SeasonAwardsId, Awards award) {
        try {
            jdbcTemplate.update(
                    "UPDATE AWARDS SET ChampionTeamID = ?, MostValuablePlayerID = ?, MostValuableCoachID = ?, TournamentID = ? where SeasonAwardsId = ?",
                    award.getChampionTeamID(), award.getMostValuablePlayerID(), award.getMostValuableCoachID(),
                    award.getTournamentID(), SeasonAwardsId);
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

}
