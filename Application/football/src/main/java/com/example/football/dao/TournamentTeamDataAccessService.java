package com.example.football.dao;

import java.util.List;

import com.example.football.model.TournamentTeam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("TournamentTeamDataAccessService")
public class TournamentTeamDataAccessService implements TournamentTeamDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean addTournamentTeam(TournamentTeam tournamentTeam) {
        try {
            jdbcTemplate.update(
                    "INSERT INTO TOURNAMENT_TEAM (TournamentID, TeamID, GroupName, NumberOfMatchPlayed, Won, Draw, Loss, GoalScored, GoalConceded, GroupPosition, Stage) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    tournamentTeam.getTournamentID(), tournamentTeam.getTeamID(), tournamentTeam.getGroupName(),
                    tournamentTeam.getNumberOfMatchPlayed(), tournamentTeam.getWon(), tournamentTeam.getDraw(),
                    tournamentTeam.getLoss(), tournamentTeam.getGoalScored(), tournamentTeam.getGoalConceded(),
                    tournamentTeam.getGroupPosition(), tournamentTeam.getStage());
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }

    }

    @Override
    public List<TournamentTeam> getTournamentTeams() {
        return jdbcTemplate.query("SELECT * FROM TOURNAMENT_TEAM",
                BeanPropertyRowMapper.newInstance(TournamentTeam.class));
    }

    @Override
    public TournamentTeam selectTournamentTeamByTournamentIdAndTeamId(int tournamentId, int teamId) {
        return jdbcTemplate.queryForObject("SELECT * FROM TOURNAMENT_TEAM WHERE TournamentID = ? AND TeamID = ?",
                new TournamentTeamRowMapper(), tournamentId, teamId);
    }

    @Override
    public boolean deleteTournamentTeamByTournamentIdAndTeamId(int tournamentId, int teamId) {
        try {

            // Number of rows affected
            if (jdbcTemplate.update("DELETE FROM TOURNAMENT_TEAM WHERE TournamentID = ? AND TeamID = ?", tournamentId,
                    teamId) > 0) {
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
    public boolean updateTournamentTeamByTournamentIdAndTeamId(int tournamentId, int teamId,
            TournamentTeam tournamentTeam) {
        try {
            jdbcTemplate.update(
                    "UPDATE TOURNAMENT_TEAM SET TournamentID = ?, TeamID = ?, GroupName = ?, NumberOfMatchPlayed = ?, Won = ?, Draw = ?, Loss = ?, GoalScored = ?, GoalConceded = ?, GroupPosition = ?, Stage = ? where TournamentID = ? AND TeamID = ?",
                    tournamentTeam.getTournamentID(), tournamentTeam.getTeamID(), tournamentTeam.getGroupName(),
                    tournamentTeam.getNumberOfMatchPlayed(), tournamentTeam.getWon(), tournamentTeam.getDraw(),
                    tournamentTeam.getLoss(), tournamentTeam.getGoalScored(), tournamentTeam.getGoalConceded(),
                    tournamentTeam.getGroupPosition(), tournamentTeam.getStage(), tournamentId, teamId);
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

}
