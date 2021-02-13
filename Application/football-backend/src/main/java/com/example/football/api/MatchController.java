package com.example.football.api;

import java.util.List;

import javax.validation.Valid;

import com.example.football.model.Match;
import com.example.football.service.MatchService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNull;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("api/match")
@RestController
@CrossOrigin
public class MatchController {

    private final MatchService matchService;

    @Autowired
    public MatchController(MatchService matchService) {
        this.matchService = matchService;
    }

    @PostMapping
    public boolean addMatch(@Valid @NonNull @RequestBody Match match) {
        return matchService.addMatch(match);
    }

    @GetMapping
    public List<Match> getAllMatches() {
        return matchService.getAllMatches();
    }

    @GetMapping(path = "{HomeTeamID}-{AwayTeamID}-{Week}")
    public Match selectMatchByHomeTeamIdAndAwayTeamIdAndWeek(@PathVariable("HomeTeamID") int homeTeamID,
            @PathVariable("AwayTeamID") int awayTeamID, @PathVariable("Week") String week) {
        return matchService.selectMatchByHomeTeamIdAndAwayTeamIdAndWeek(homeTeamID, awayTeamID, week);
    }

    @DeleteMapping(path = "{HomeTeamID}-{AwayTeamID}-{Week}")
    public boolean deleteMatchByHomeTeamIdAndAwayTeamId(@PathVariable("HomeTeamID") int homeTeamID,
            @PathVariable("AwayTeamID") int awayTeamID, @PathVariable("Week") String week) {
        return matchService.deleteMatchByHomeTeamIdAndAwayTeamIdAndWeek(homeTeamID, awayTeamID, week);
    }

    @PutMapping(path = "{HomeTeamID}-{AwayTeamID}-{Week}")
    public boolean updateMatchByHomeTeamIdAndAwayTeamIdAndWeek(@PathVariable("HomeTeamID") int homeTeamID,
            @PathVariable("AwayTeamID") int awayTeamID, @PathVariable("Week") String week,
            @Valid @NonNull @RequestBody Match matchToUpdate) {
        return matchService.updateMatchByHomeTeamIdAndAwayTeamIdAndWeek(homeTeamID, awayTeamID, week, matchToUpdate);
    }

}
