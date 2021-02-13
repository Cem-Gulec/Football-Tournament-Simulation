package com.example.football.api;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import com.example.football.model.Team;
import com.example.football.service.TeamService;

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

@RequestMapping("api/team")
@RestController
@CrossOrigin
public class TeamController {

    private final TeamService teamService;

    @Autowired
    public TeamController(TeamService teamService) {
        this.teamService = teamService;
    }

    @PostMapping
    public boolean addTeam(@Valid @NonNull @RequestBody Team team) {
        return teamService.addTeam(team);
    }

    @GetMapping
    public List<Team> getAllTeams() {
        return teamService.getAllTeams();
    }

    @GetMapping("/getAllTeamNames")
    public Map<Integer, String> getAllTeamNames() {
        return teamService.getAllTeamNames();
    }

    @GetMapping(path = "{TeamID}")
    public Team selectTeamById(@PathVariable("TeamID") int teamID) {
        return teamService.selectTeamById(teamID);
    }

    @DeleteMapping(path = "{TeamID}")
    public boolean deleteTeamById(@PathVariable("TeamID") int teamID) {
        return teamService.deleteTeamById(teamID);
    }

    @PutMapping(path = "{TeamID}")
    public boolean updateTeamById(@PathVariable("TeamID") int teamId, @Valid @NonNull @RequestBody Team teamToUpdate) {
        return teamService.updateTeamById(teamId, teamToUpdate);
    }

}
