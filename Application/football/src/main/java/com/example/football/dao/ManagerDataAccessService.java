package com.example.football.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.Map;

import com.example.football.model.Manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("ManagerDataAccessService")
public class ManagerDataAccessService implements ManagerDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean addManager(Manager manager) {
        Random rand = new Random();
        Exception checkedException;
        int numberOfRandomKeyTries = 3;

        do {
            try {
                jdbcTemplate.update(
                        "INSERT INTO MANAGER (ManagerID, FirstName, LastName, Nationality, BirthDate, YearsOfExperience) VALUES (?, ?, ?, ?, ?, ?)",
                        rand.nextInt(255), manager.getFirstName(), manager.getLastName(), manager.getNationality(),
                        manager.getBirthDate(), manager.getYearsOfExperience());
                return true;
            } catch (Exception e) {
                checkedException = e;
                numberOfRandomKeyTries--;
            }
        } while (checkedException.getClass().getCanonicalName().toString().contains("DuplicateKeyException")
                && numberOfRandomKeyTries > 0);

        System.out.println(checkedException);
        return false;

    }

    @Override
    public List<Manager> getAllManagers() {
        return jdbcTemplate.query("SELECT * FROM MANAGER", BeanPropertyRowMapper.newInstance(Manager.class));
    }

    @Override
    public Map<Integer, String> getAllManagerNames() {
        List<Manager> allManagers = getAllManagers();
        HashMap<Integer, String> managerNames = new HashMap<>();
        for (Manager manager : allManagers) {
            managerNames.put(manager.getManagerID(), manager.getFirstName() + " " + manager.getLastName());
        }
        return managerNames;
    }

    @Override
    public Manager selectManagerById(int managerId) {
        return jdbcTemplate.queryForObject("SELECT * FROM MANAGER WHERE ManagerID = ?", new ManagerRowMapper(),
                managerId);
    }

    @Override
    public boolean deleteManagerById(int managerId) {
        try {

            // Number of rows affected
            if (jdbcTemplate.update("DELETE FROM MANAGER where ManagerID = ?", managerId) > 0) {
                return true;
            } else {
                return false;
            }

        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

    @Override
    public boolean updateManagerById(int managerId, Manager manager) {
        try {
            jdbcTemplate.update(
                    "UPDATE MANAGER SET FirstName = ?, LastName = ?, Nationality = ?, BirthDate = ?, YearsOfExperience = ? where ManagerId = ?",
                    manager.getFirstName(), manager.getLastName(), manager.getNationality(), manager.getBirthDate(),
                    manager.getYearsOfExperience(), managerId);
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

}
