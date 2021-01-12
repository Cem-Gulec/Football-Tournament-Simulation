package com.example.football.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.example.football.model.Team;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("TeamDataAccessService")
public class TeamDataAccessService implements TeamDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean addTeam(Team team) {
        Random rand = new Random();
        Exception checkedException;
        int numberOfRandomKeyTries = 3;

        do {
            try {
                jdbcTemplate.update("INSERT INTO TEAM (TeamID, Name, Location, ManagerID) VALUES (?, ?, ?, ?)",
                        rand.nextInt(255), team.getName(), team.getLocation(), team.getManagerID());
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
    public List<Team> getAllTeams() {
        return jdbcTemplate.query("SELECT * FROM TEAM", BeanPropertyRowMapper.newInstance(Team.class));
    }

    @Override
    public Map<Integer, String> getAllTeamNames() {
        List<Team> allTeams = getAllTeams();
        HashMap<Integer, String> teamNames = new HashMap<>();
        for (Team team : allTeams) {
            teamNames.put(team.getTeamID(), team.getName());
        }
        return teamNames;
    }

    @Override
    public Team selectTeamById(int teamId) {
        return jdbcTemplate.queryForObject("SELECT * FROM TEAM WHERE TeamID = ?", new TeamRowMapper(), teamId);
    }

    @Override
    public boolean deleteTeamById(int teamId) {
        try {

            // Number of rows affected
            if (jdbcTemplate.update("DELETE FROM TEAM where TeamID = ?", teamId) > 0) {
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
    public boolean updateTeamById(int teamId, Team team) {
        try {
            jdbcTemplate.update("UPDATE TEAM SET TeamID = ?, Name = ?, Location = ?, ManagerID = ? where TeamID = ?",
                    team.getTeamID(), team.getName(), team.getLocation(), team.getManagerID(), teamId);
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

}
