package com.example.football.dao;

import java.util.List;

import com.example.football.model.Match;

public interface MatchDao {

    boolean addMatch(Match match);

    List<Match> getAllMatches();

    Match selectMatchByHomeTeamIdAndAwayTeamIdAndWeek(int homeTeamId, int awayTeamId, String week);

    boolean deleteMatchByHomeTeamIdAndAwayTeamIdAndWeek(int homeTeamId, int awayTeamId, String week);

    boolean updateMatchByHomeTeamIdAndAwayTeamIdAndWeek(int homeTeamId, int awayTeamId, String week, Match match);

}
