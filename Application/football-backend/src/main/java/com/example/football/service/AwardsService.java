package com.example.football.service;

import java.util.List;

import com.example.football.dao.AwardsDao;
import com.example.football.model.Awards;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class AwardsService {
    
    private final AwardsDao awardsDao;

    @Autowired
    public AwardsService(@Qualifier("AwardsDataAccessService") AwardsDao awardsDao) {
        this.awardsDao = awardsDao;
    }

    public boolean addAward(Awards award) {
        return awardsDao.addAward(award);
    }

    public List<Awards> getAllAwards() {
        return awardsDao.getAllAwards();
    }

    public Awards selectAwardBySeasonAwardsId(int SeasonAwardsId) {
        return awardsDao.selectAwardBySeasonAwardsId(SeasonAwardsId);
    }

    public boolean deleteAwardBySeasonAwardsId(int SeasonAwardsId) {
        return awardsDao.deleteAwardBySeasonAwardsId(SeasonAwardsId);
    }

    public boolean updateAwardBySeasonAwardsId(int SeasonAwardsId, Awards award) {
        return awardsDao.updateAwardBySeasonAwardsId(SeasonAwardsId, award);
    }

}
