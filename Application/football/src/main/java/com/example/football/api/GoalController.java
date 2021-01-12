package com.example.football.api;

import java.util.List;

import javax.validation.Valid;

import com.example.football.model.Goal;
import com.example.football.service.GoalService;

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

@RequestMapping("api/goal")
@RestController
@CrossOrigin
public class GoalController {

    private final GoalService goalService;

    @Autowired
    public GoalController(GoalService goalService) {
        this.goalService = goalService;
    }

    @PostMapping
    public boolean addGoal(@Valid @NonNull @RequestBody Goal goal) {
        return goalService.addGoal(goal);
    }

    @GetMapping
    public List<Goal> getAllGoals() {
        return goalService.getAllGoals();
    }

    @GetMapping(path = "{HomeTeamID}-{AwayTeamID}-{PlayerID}-{Minute}-{Week}")
    public Goal getGoalByGoal(@PathVariable("HomeTeamID") int HomeTeamID, @PathVariable("AwayTeamID") int AwayTeamID,
            @PathVariable("PlayerID") int PlayerID, @PathVariable("Minute") int Minute,
            @PathVariable("Week") String Week) {
        return goalService.getGoalByGoal(new Goal(HomeTeamID, AwayTeamID, PlayerID, Minute, Week));
    }

    @DeleteMapping(path = "{HomeTeamID}-{AwayTeamID}-{PlayerID}-{Minute}-{Week}")
    public boolean deleteGoalByGoal(@PathVariable("HomeTeamID") int HomeTeamID,
            @PathVariable("AwayTeamID") int AwayTeamID, @PathVariable("PlayerID") int PlayerID,
            @PathVariable("Minute") int Minute, @PathVariable("Week") String Week) {
        return goalService.deleteGoalByGoal(new Goal(HomeTeamID, AwayTeamID, PlayerID, Minute, Week));
    }

    @PutMapping(path = "{HomeTeamID}-{AwayTeamID}-{PlayerID}-{Minute}-{Week}")
    public boolean updateGoalByGoal(@PathVariable("HomeTeamID") int HomeTeamID,
            @PathVariable("AwayTeamID") int AwayTeamID, @PathVariable("PlayerID") int PlayerID,
            @PathVariable("Minute") int Minute, @PathVariable("Week") String Week,
            @Valid @NonNull @RequestBody Goal updatedGoal) {
        return goalService.updateGoalByGoal(new Goal(HomeTeamID, AwayTeamID, PlayerID, Minute, Week), updatedGoal);
    }

}
