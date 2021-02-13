package com.example.football.dao;

import java.util.List;

import com.example.football.model.Pitch;

public interface PitchDao {

    boolean addPitch(Pitch pitch);

    List<Pitch> getAllPitches();

    Pitch selectPitchById(int pitchId);

    boolean deletePitchById(int pitchId);

    boolean updatePitchById(int pitchId, Pitch pitch);

}
