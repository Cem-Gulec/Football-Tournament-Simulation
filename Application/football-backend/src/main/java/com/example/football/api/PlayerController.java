package com.example.football.api;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import com.example.football.model.Player;
import com.example.football.service.PlayerService;

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

@RequestMapping("api/player")
@RestController
@CrossOrigin
public class PlayerController {

    private final PlayerService playerService;

    @Autowired
    public PlayerController(PlayerService playerService) {
        this.playerService = playerService;
    }

    @PostMapping
    public boolean addPlayer(@Valid @NonNull @RequestBody Player player) {
        return playerService.addPlayer(player);
    }

    @GetMapping
    public List<Player> getAllPlayers() {
        return playerService.getAllPlayers();
    }

    @GetMapping("/getAllPlayerNames")
    public Map<Integer, String> getAllPlayerNames() {
        return playerService.getAllPlayerNames();
    }

    @GetMapping(path = "{PlayerID}")
    public Player selectPlayerById(@PathVariable("PlayerID") int playerId) {
        return playerService.selectPlayerById(playerId);
    }

    @DeleteMapping(path = "{PlayerID}")
    public boolean deletePlayerById(@PathVariable("PlayerID") int playerId) {
        return playerService.deletePlayerById(playerId);
    }

    @PutMapping(path = "{PlayerID}")
    public boolean updatePlayerById(@PathVariable("PlayerID") int playerId,
            @Valid @NonNull @RequestBody Player playerToUpdate) {
        return playerService.updatePlayerById(playerId, playerToUpdate);
    }

}
