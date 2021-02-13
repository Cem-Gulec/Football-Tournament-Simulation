package com.example.football.dao;

import java.util.List;

import com.example.football.model.Goal;

public interface GoalDao {
    
    boolean addGoal(Goal goal);

    List<Goal> getAllGoals();

    Goal getGoalByGoal(Goal goal);

    boolean deleteGoalByGoal(Goal goal);

    boolean updateGoalByGoal(Goal existingGoal, Goal updatedGoal);

}
