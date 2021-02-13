package com.example.football.api;

import java.util.List;

import javax.validation.Valid;

import com.example.football.model.Pitch;
import com.example.football.service.PitchService;

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

@RequestMapping("api/pitch")
@RestController
@CrossOrigin
public class PitchController {

    private final PitchService pitchService;

    @Autowired
    public PitchController(PitchService pitchService) {
        this.pitchService = pitchService;
    }

    @PostMapping
    public boolean addPitch(@Valid @NonNull @RequestBody Pitch pitch) {
        return pitchService.addPitch(pitch);
    }

    @GetMapping
    public List<Pitch> getAllPitches() {
        return pitchService.getAllPitches();
    }

    @GetMapping(path = "{PitchID}")
    public Pitch selectPitchById(@PathVariable("PitchID") int pitchId) {
        return pitchService.selectPitchById(pitchId);
    }

    @DeleteMapping(path = "{PitchID}")
    public boolean deletePitchById(@PathVariable("PitchID") int pitchId) {
        return pitchService.deletePitchById(pitchId);
    }

    @PutMapping(path = "{PitchID}")
    public boolean updatePitchById(@PathVariable("PitchID") int pitchId,
            @Valid @NonNull @RequestBody Pitch pitchToUpdate) {
        return pitchService.updatePitchById(pitchId, pitchToUpdate);
    }

}
