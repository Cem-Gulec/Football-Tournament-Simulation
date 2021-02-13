package com.example.football.dao;

import java.util.List;
import java.util.Map;

import com.example.football.model.Team;

public interface TeamDao {

    boolean addTeam(Team team);

    List<Team> getAllTeams();

    Map<Integer, String> getAllTeamNames();

    Team selectTeamById(int teamId);

    boolean deleteTeamById(int teamId);

    boolean updateTeamById(int teamId, Team team);

}
