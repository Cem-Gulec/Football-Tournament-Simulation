package com.example.football.service;

import java.util.List;
import java.util.Map;

import com.example.football.dao.ManagerDao;
import com.example.football.model.Manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class ManagerService {

    private final ManagerDao managerDao;

    @Autowired
    public ManagerService(@Qualifier("ManagerDataAccessService") ManagerDao managerDao) {
        this.managerDao = managerDao;
    }

    public boolean addManager(Manager manager) {
        return managerDao.addManager(manager);
    }

    public List<Manager> getAllManagers() {
        return managerDao.getAllManagers();
    }

    public Map<Integer, String> getAllManagerNames() {
        return managerDao.getAllManagerNames();
    }

    public Manager selectManagerById(int managerId) {
        return managerDao.selectManagerById(managerId);
    }

    public boolean deleteManagerById(int managerId) {
        return managerDao.deleteManagerById(managerId);
    }

    public boolean updateManagerById(int managerId, Manager manager) {
        return managerDao.updateManagerById(managerId, manager);
    }

}
