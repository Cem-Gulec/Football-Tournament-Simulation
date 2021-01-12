package com.example.football.dao;

import java.util.List;

import com.example.football.model.TournamentTeam;

public interface TournamentTeamDao {

    boolean addTournamentTeam(TournamentTeam tournamentTeam);

    List<TournamentTeam> getTournamentTeams();

    TournamentTeam selectTournamentTeamByTournamentIdAndTeamId(int tournamentId, int teamId);

    boolean deleteTournamentTeamByTournamentIdAndTeamId(int tournamentId, int teamId);

    boolean updateTournamentTeamByTournamentIdAndTeamId(int tournamentId, int teamId, TournamentTeam tournamentTeam);

}
