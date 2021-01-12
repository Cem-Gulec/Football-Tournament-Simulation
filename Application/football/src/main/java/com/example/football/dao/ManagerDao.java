package com.example.football.dao;

import java.util.List;
import java.util.Map;

import com.example.football.model.Manager;

public interface ManagerDao {
    
    boolean addManager(Manager manager);

    List<Manager> getAllManagers();

    Map<Integer, String> getAllManagerNames();

    Manager selectManagerById(int managerId);

    boolean deleteManagerById(int managerId);

    boolean updateManagerById(int managerId, Manager manager);

}
