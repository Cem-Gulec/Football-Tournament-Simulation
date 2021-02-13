package com.example.football.service;

import java.util.List;

import com.example.football.dao.PitchDao;
import com.example.football.model.Pitch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class PitchService {

    private final PitchDao pitchDao;

    @Autowired
    public PitchService(@Qualifier("PitchDataAccessService") PitchDao pitchDao) {
        this.pitchDao = pitchDao;
    }

    public boolean addPitch(Pitch pitch) {
        return pitchDao.addPitch(pitch);
    }

    public List<Pitch> getAllPitches() {
        return pitchDao.getAllPitches();
    }

    public Pitch selectPitchById(int pitchId) {
        return pitchDao.selectPitchById(pitchId);
    }

    public boolean deletePitchById(int pitchId) {
        return pitchDao.deletePitchById(pitchId);
    }

    public boolean updatePitchById(int pitchId, Pitch pitch) {
        return pitchDao.updatePitchById(pitchId, pitch);
    }

}
