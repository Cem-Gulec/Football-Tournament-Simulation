package com.example.football.dao;

import java.util.List;
import java.util.Random;

import com.example.football.model.Goal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("GoalDataAccessService")
public class GoalDataAccessService implements GoalDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean addGoal(Goal goal) {
        try {
            jdbcTemplate.update("INSERT INTO GOAL VALUES (?, ?, ?, ?, ?)", goal.getHomeTeamID(), goal.getAwayTeamID(),
                    goal.getPlayerID(), goal.getMinute(), goal.getWeek());
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

    @Override
    public List<Goal> getAllGoals() {
        return jdbcTemplate.query("SELECT * FROM GOAL", BeanPropertyRowMapper.newInstance(Goal.class));
    }

    @Override
    public Goal getGoalByGoal(Goal goal) {
        return jdbcTemplate.queryForObject(
                "SELECT * FROM GOAL WHERE HomeTeamID = ? AND AwayTeamID = ? AND PlayerID = ? AND Minute = ? AND Week = ?",
                new GoalRowMapper(), goal.getHomeTeamID(), goal.getAwayTeamID(), goal.getPlayerID(), goal.getMinute(),
                goal.getWeek());
    }

    @Override
    public boolean deleteGoalByGoal(Goal goal) {
        try {

            // Number of rows affected
            if (jdbcTemplate.update(
                    "DELETE FROM GOAL where HomeTeamID = ? AND AwayTeamID = ? AND PlayerID = ? AND Minute = ? AND Week = ?",
                    goal.getHomeTeamID(), goal.getAwayTeamID(), goal.getPlayerID(), goal.getMinute(),
                    goal.getWeek()) > 0) {
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
    public boolean updateGoalByGoal(Goal existingGoal, Goal updatedGoal) {
        try {
            jdbcTemplate.update(
                    "UPDATE GOAL SET HomeTeamID = ?, AwayTeamID = ?, PlayerID = ?, Minute = ?, Week = ? where HomeTeamID = ? AND AwayTeamID = ? AND PlayerID = ? AND Minute = ? AND Week = ?",
                    updatedGoal.getHomeTeamID(), updatedGoal.getAwayTeamID(), updatedGoal.getPlayerID(),
                    updatedGoal.getMinute(), updatedGoal.getWeek(), existingGoal.getHomeTeamID(),
                    existingGoal.getAwayTeamID(), existingGoal.getPlayerID(), existingGoal.getMinute(),
                    existingGoal.getWeek());
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

}
