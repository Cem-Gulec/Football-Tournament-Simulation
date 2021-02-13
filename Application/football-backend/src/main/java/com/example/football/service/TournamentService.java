package com.example.football.service;

import java.util.List;

import com.example.football.dao.TournamentDao;
import com.example.football.model.Tournament;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class TournamentService {

    private final TournamentDao tournamentDao;

    @Autowired
    public TournamentService(@Qualifier("TournamentDataAccessService") TournamentDao tournamentDao) {
        this.tournamentDao = tournamentDao;
    }

    public boolean addTournament(Tournament tournament) {
        return tournamentDao.addTournament(tournament);
    }

    public List<Tournament> getAllTournaments() {
        return tournamentDao.getAllTournaments();
    }

    public Tournament selectTournamentById(int tournamentId) {
        return tournamentDao.selectTournamentById(tournamentId);
    }

    public boolean deleteTournamentById(int tournamentId) {
        return tournamentDao.deleteTournamentById(tournamentId);
    }

    public boolean updateTournamentById(int tournamentId, Tournament tournament) {
        return tournamentDao.updateTournamentById(tournamentId, tournament);
    }

}
