package com.example.football.api;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import com.example.football.model.Manager;
import com.example.football.service.ManagerService;

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

@RequestMapping("api/manager")
@RestController
@CrossOrigin
public class ManagerController {

    private final ManagerService managerService;

    @Autowired
    public ManagerController(ManagerService managerService) {
        this.managerService = managerService;
    }

    @PostMapping
    public boolean addManager(@Valid @NonNull @RequestBody Manager manager) {
        return managerService.addManager(manager);
    }

    @GetMapping
    public List<Manager> getAllManagers() {
        return managerService.getAllManagers();
    }

    @GetMapping("/getAllManagerNames")
    public Map<Integer, String> getAllManagerNames() {
        return managerService.getAllManagerNames();
    }

    @GetMapping(path = "{ManagerID}")
    public Manager selectManagerById(@PathVariable("ManagerID") int managerID) {
        return managerService.selectManagerById(managerID);
    }

    @DeleteMapping(path = "{ManagerID}")
    public boolean deleteManagerById(@PathVariable("ManagerID") int managerID) {
        return managerService.deleteManagerById(managerID);
    }

    @PutMapping(path = "{ManagerID}")
    public boolean updateManagerById(@PathVariable("ManagerID") int managerID,
            @Valid @NonNull @RequestBody Manager managerToUpdate) {
        return managerService.updateManagerById(managerID, managerToUpdate);
    }

}
