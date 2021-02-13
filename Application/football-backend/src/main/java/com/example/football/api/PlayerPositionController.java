package com.example.football.api;

import java.util.List;

import javax.validation.Valid;

import com.example.football.model.PlayerPosition;
import com.example.football.service.PlayerPositionService;

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

@RequestMapping("api/playerPosition")
@RestController
@CrossOrigin
public class PlayerPositionController {

    private final PlayerPositionService playerPositionService;

    @Autowired
    public PlayerPositionController(PlayerPositionService playerPositionService) {
        this.playerPositionService = playerPositionService;
    }

    @PostMapping
    public boolean addPlayerPosition(@Valid @NonNull @RequestBody PlayerPosition playerPosition) {
        return playerPositionService.addPlayerPosition(playerPosition);
    }

    @GetMapping
    public List<PlayerPosition> getAllPlayerPositions() {
        return playerPositionService.getAllPlayerPositions();
    }

    @GetMapping(path = "{PlayerID}-{Position}")
    public PlayerPosition selectPlayerPositionByPlayerIdAndPosition(@PathVariable("PlayerID") int playerID,
            @PathVariable("Position") String position) {
        return playerPositionService.selectPlayerPositionByPlayerIdAndPosition(playerID, position);
    }

    @DeleteMapping(path = "{PlayerID}-{Position}")
    public boolean deletePlayerPositionByPlayerIdAndPosition(@PathVariable("PlayerID") int playerID,
            @PathVariable("Position") String position) {
        return playerPositionService.deletePlayerPositionByPlayerIdAndPosition(playerID, position);
    }

    @PutMapping(path = "{PlayerID}-{Position}")
    public boolean updatePositionByPlayerIdAndPosition(@PathVariable("PlayerID") int playerID,
            @PathVariable("Position") String position,
            @Valid @NonNull @RequestBody PlayerPosition playerPositionToUpdate) {
        return playerPositionService.updatePositionByPlayerIdAndPosition(playerID, position, playerPositionToUpdate);
    }

}
