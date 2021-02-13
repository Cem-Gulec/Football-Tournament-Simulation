package com.example.football.service;

import java.util.List;

import com.example.football.dao.GoalDao;
import com.example.football.model.Goal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class GoalService {
    
    private final GoalDao goalDao;

    @Autowired
    public GoalService(@Qualifier("GoalDataAccessService") GoalDao goalDao) {
        this.goalDao = goalDao;
    }

    public boolean addGoal(Goal goal) {
        return goalDao.addGoal(goal);
    }

    public List<Goal> getAllGoals() {
        return goalDao.getAllGoals();
    }

    public Goal getGoalByGoal(Goal goal) {
        return goalDao.getGoalByGoal(goal);
    }

    public boolean deleteGoalByGoal(Goal goal) {
        return goalDao.deleteGoalByGoal(goal);
    }

    public boolean updateGoalByGoal(Goal existingGoal, Goal updatedGoal) {
        return goalDao.updateGoalByGoal(existingGoal, updatedGoal);
    }

}
