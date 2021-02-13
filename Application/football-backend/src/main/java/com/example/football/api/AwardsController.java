package com.example.football.api;

import java.util.List;

import javax.validation.Valid;

import com.example.football.model.Awards;
import com.example.football.service.AwardsService;

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

@RequestMapping("api/awards")
@RestController
@CrossOrigin
public class AwardsController {

    private final AwardsService awardsService;

    @Autowired
    public AwardsController(AwardsService awardsService) {
        this.awardsService = awardsService;
    }

    @PostMapping
    public boolean addAward(@Valid @NonNull @RequestBody Awards awards) {
        return awardsService.addAward(awards);
    }

    @GetMapping
    public List<Awards> getAllAwards() {
        return awardsService.getAllAwards();
    }

    @GetMapping(path = "{SeasonAwardsId}")
    public Awards selectAwardBySeasonAwardsId(@PathVariable("SeasonAwardsId") int SeasonAwardsId) {
        return awardsService.selectAwardBySeasonAwardsId(SeasonAwardsId);
    }

    @DeleteMapping(path = "{SeasonAwardsId}")
    public boolean deletePersonById(@PathVariable("SeasonAwardsId") int SeasonAwardsId) {
        return awardsService.deleteAwardBySeasonAwardsId(SeasonAwardsId);
    }

    @PutMapping(path = "{SeasonAwardsId}")
    public boolean updatePerson(@PathVariable("SeasonAwardsId") int SeasonAwardsId,
            @Valid @NonNull @RequestBody Awards awardToUpdate) {
        return awardsService.updateAwardBySeasonAwardsId(SeasonAwardsId, awardToUpdate);
    }

}
