package com.example.football.service;

import java.util.List;
import java.util.Map;

import com.example.football.dao.TeamDao;
import com.example.football.model.Team;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class TeamService {

    private final TeamDao teamDao;

    @Autowired
    public TeamService(@Qualifier("TeamDataAccessService") TeamDao teamDao) {
        this.teamDao = teamDao;
    }

    public boolean addTeam(Team team) {
        return teamDao.addTeam(team);
    }

    public List<Team> getAllTeams() {
        return teamDao.getAllTeams();
    }

    public Map<Integer, String> getAllTeamNames() {
        return teamDao.getAllTeamNames();
    }

    public Team selectTeamById(int teamId) {
        return teamDao.selectTeamById(teamId);
    }

    public boolean deleteTeamById(int teamId) {
        return teamDao.deleteTeamById(teamId);
    }

    public boolean updateTeamById(int teamId, Team team) {
        return teamDao.updateTeamById(teamId, team);
    }

}
