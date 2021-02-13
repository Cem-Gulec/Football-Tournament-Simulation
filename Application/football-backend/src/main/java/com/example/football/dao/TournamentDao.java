package com.example.football.dao;

import java.util.List;

import com.example.football.model.Tournament;

public interface TournamentDao {

    boolean addTournament(Tournament tournament);

    List<Tournament> getAllTournaments();

    Tournament selectTournamentById(int tournamentId);

    boolean deleteTournamentById(int tournamentId);

    boolean updateTournamentById(int tournamentId, Tournament tournament);

}
