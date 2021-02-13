package com.example.football.dao;

import java.util.List;
import java.util.Map;

import com.example.football.model.Referee;

public interface RefereeDao {

    boolean addReferee(Referee referee);

    List<Referee> getAllReferees();

    Map<Integer, String> getAllRefereeNames();

    Referee selectRefereeById(int refereeId);

    boolean deleteRefereeById(int refereeId);

    boolean updateRefereeById(int refereeId, Referee referee);

}
