package com.example.football.api;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import com.example.football.model.Referee;
import com.example.football.service.RefereeService;

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

@RequestMapping("api/referee")
@RestController
@CrossOrigin
public class RefereeController {

    private final RefereeService refereeService;

    @Autowired
    public RefereeController(RefereeService refereeService) {
        this.refereeService = refereeService;
    }

    @PostMapping
    public boolean addReferee(@Valid @NonNull @RequestBody Referee referee) {
        return refereeService.addReferee(referee);
    }

    @GetMapping
    public List<Referee> getAllReferees() {
        return refereeService.getAllReferees();
    }

    @GetMapping("/getAllRefereeNames")
    public Map<Integer, String> getAllRefereeNames() {
        return refereeService.getAllRefereeNames();
    }

    @GetMapping(path = "{RefereeID}")
    public Referee selectRefereeById(@PathVariable("RefereeID") int refereeId) {
        return refereeService.selectRefereeById(refereeId);
    }

    @DeleteMapping(path = "{RefereeID}")
    public boolean deleteRefereeById(@PathVariable("RefereeID") int refereeId) {
        return refereeService.deleteRefereeById(refereeId);
    }

    @PutMapping(path = "{RefereeID}")
    public boolean updateRefereeById(@PathVariable("RefereeID") int refereeId,
            @Valid @NonNull @RequestBody Referee refereeToUpdate) {
        return refereeService.updateRefereeById(refereeId, refereeToUpdate);
    }

}
