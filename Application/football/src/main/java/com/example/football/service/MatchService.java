package com.example.football.service;

import java.util.List;

import com.example.football.dao.MatchDao;
import com.example.football.model.Match;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class MatchService {

    private final MatchDao matchDao;

    @Autowired
    public MatchService(@Qualifier("MatchDataAccessService") MatchDao matchDao) {
        this.matchDao = matchDao;
    }

    public boolean addMatch(Match match) {
        return matchDao.addMatch(match);
    }

    public List<Match> getAllMatches() {
        return matchDao.getAllMatches();
    }

    public Match selectMatchByHomeTeamIdAndAwayTeamIdAndWeek(int homeTeamId, int awayTeamId, String week) {
        return matchDao.selectMatchByHomeTeamIdAndAwayTeamIdAndWeek(homeTeamId, awayTeamId, week);
    }

    public boolean deleteMatchByHomeTeamIdAndAwayTeamIdAndWeek(int homeTeamId, int awayTeamId, String week) {
        return matchDao.deleteMatchByHomeTeamIdAndAwayTeamIdAndWeek(homeTeamId, awayTeamId, week);
    }

    public boolean updateMatchByHomeTeamIdAndAwayTeamIdAndWeek(int homeTeamId, int awayTeamId, String week,
            Match match) {
        return matchDao.updateMatchByHomeTeamIdAndAwayTeamIdAndWeek(homeTeamId, awayTeamId, week, match);
    }

}
