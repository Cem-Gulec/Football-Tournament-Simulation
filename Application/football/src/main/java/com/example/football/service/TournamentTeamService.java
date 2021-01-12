package com.example.football.service;

import java.util.List;

import com.example.football.dao.TournamentTeamDao;
import com.example.football.model.TournamentTeam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class TournamentTeamService {

    private final TournamentTeamDao tournamentTeamDao;

    @Autowired
    public TournamentTeamService(@Qualifier("TournamentTeamDataAccessService") TournamentTeamDao tournamentTeamDao) {
        this.tournamentTeamDao = tournamentTeamDao;
    }

    public boolean addTournamentTeam(TournamentTeam tournamentTeam) {
        return tournamentTeamDao.addTournamentTeam(tournamentTeam);
    }

    public List<TournamentTeam> getTournamentTeams() {
        return tournamentTeamDao.getTournamentTeams();
    }

    public TournamentTeam selectTournamentTeamByTournamentIdAndTeamId(int tournamentId, int teamId) {
        return tournamentTeamDao.selectTournamentTeamByTournamentIdAndTeamId(tournamentId, teamId);
    }

    public boolean deleteTournamentTeamByTournamentIdAndTeamId(int tournamentId, int teamId) {
        return tournamentTeamDao.deleteTournamentTeamByTournamentIdAndTeamId(tournamentId, teamId);
    }

    public boolean updateTournamentTeamByTournamentIdAndTeamId(int tournamentId, int teamId,
            TournamentTeam tournamentTeam) {
        return tournamentTeamDao.updateTournamentTeamByTournamentIdAndTeamId(tournamentId, teamId, tournamentTeam);
    }

}
