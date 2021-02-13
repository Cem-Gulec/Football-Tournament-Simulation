package com.example.football.service;

import java.util.List;
import java.util.Map;

import com.example.football.dao.RefereeDao;
import com.example.football.model.Referee;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class RefereeService {

    private final RefereeDao refereeDao;

    @Autowired
    public RefereeService(@Qualifier("RefereeDataAccessService") RefereeDao refereeDao) {
        this.refereeDao = refereeDao;
    }

    public boolean addReferee(Referee referee) {
        return refereeDao.addReferee(referee);
    }

    public List<Referee> getAllReferees() {
        return refereeDao.getAllReferees();
    }

    public Map<Integer, String> getAllRefereeNames() {
        return refereeDao.getAllRefereeNames();
    }

    public Referee selectRefereeById(int refereeId) {
        return refereeDao.selectRefereeById(refereeId);
    }

    public boolean deleteRefereeById(int refereeId) {
        return refereeDao.deleteRefereeById(refereeId);
    }

    public boolean updateRefereeById(int refereeId, Referee referee) {
        return refereeDao.updateRefereeById(refereeId, referee);
    }

}
