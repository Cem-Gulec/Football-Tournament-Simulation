package com.example.football.api;

import java.util.List;

import javax.validation.Valid;

import com.example.football.model.Tournament;
import com.example.football.service.TournamentService;

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

@RequestMapping("api/tournament")
@RestController
@CrossOrigin
public class TournamentController {

    private final TournamentService tournamentService;

    @Autowired
    public TournamentController(TournamentService tournamentService) {
        this.tournamentService = tournamentService;
    }

    @PostMapping
    public boolean addTournament(@Valid @NonNull @RequestBody Tournament tournament) {
        return tournamentService.addTournament(tournament);
    }

    @GetMapping
    public List<Tournament> getAllTournaments() {
        return tournamentService.getAllTournaments();
    }

    @GetMapping(path = "{TournamentID}")
    public Tournament selectTournamentById(@PathVariable("TournamentID") int tournamentID) {
        return tournamentService.selectTournamentById(tournamentID);
    }

    @DeleteMapping(path = "{TournamentID}")
    public boolean deleteTournamentById(@PathVariable("TournamentID") int tournamentID) {
        return tournamentService.deleteTournamentById(tournamentID);
    }

    @PutMapping(path = "{TournamentID}")
    public boolean updateTournamentById(@PathVariable("TournamentID") int tournamentID,
            @Valid @NonNull @RequestBody Tournament tournamentToUpdate) {
        return tournamentService.updateTournamentById(tournamentID, tournamentToUpdate);
    }

}
