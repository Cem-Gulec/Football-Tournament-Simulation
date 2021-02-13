package com.example.football.api;

import java.util.List;

import javax.validation.Valid;

import com.example.football.model.TournamentTeam;
import com.example.football.service.TournamentTeamService;

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

@RequestMapping("api/tournamentTeam")
@RestController
@CrossOrigin
public class TournamentTeamController {

    private final TournamentTeamService tournamentTeamService;

    @Autowired
    public TournamentTeamController(TournamentTeamService tournamentTeamService) {
        this.tournamentTeamService = tournamentTeamService;
    }

    @PostMapping
    public boolean addTournamentTeam(@Valid @NonNull @RequestBody TournamentTeam tournamentTeam) {
        return tournamentTeamService.addTournamentTeam(tournamentTeam);
    }

    @GetMapping
    public List<TournamentTeam> getTournamentTeams() {
        return tournamentTeamService.getTournamentTeams();
    }

    @GetMapping(path = "{TournamentID}-{TeamID}")
    public TournamentTeam selectTournamentTeamByTournamentIdAndTeamId(@PathVariable("TournamentID") int tournamentId,
            @PathVariable("TeamID") int teamID) {
        return tournamentTeamService.selectTournamentTeamByTournamentIdAndTeamId(tournamentId, teamID);
    }

    @DeleteMapping(path = "{TournamentID}-{TeamID}")
    public boolean deleteTournamentTeamByTournamentIdAndTeamId(@PathVariable("TournamentID") int tournamentId,
            @PathVariable("TeamID") int teamID) {
        return tournamentTeamService.deleteTournamentTeamByTournamentIdAndTeamId(tournamentId, teamID);
    }

    @PutMapping(path = "{TournamentID}-{TeamID}")
    public boolean updateTournamentTeamByTournamentIdAndTeamId(@PathVariable("TournamentID") int tournamentId,
            @PathVariable("TeamID") int teamID, @Valid @NonNull @RequestBody TournamentTeam TournamentTeamToUpdate) {
        return tournamentTeamService.updateTournamentTeamByTournamentIdAndTeamId(tournamentId, teamID,
                TournamentTeamToUpdate);
    }

}
