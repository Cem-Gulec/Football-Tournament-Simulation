package com.example.football.dao;

import java.util.List;

import com.example.football.model.Awards;

public interface AwardsDao {

    boolean addAward(Awards award);

    List<Awards> getAllAwards();

    Awards selectAwardBySeasonAwardsId(int SeasonAwardsId);

    boolean deleteAwardBySeasonAwardsId(int SeasonAwardsId);

    boolean updateAwardBySeasonAwardsId(int SeasonAwardsId, Awards award);

}
