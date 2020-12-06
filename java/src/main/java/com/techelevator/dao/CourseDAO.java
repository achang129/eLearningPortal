package com.techelevator.dao;

public interface CourseDAO {
	
	Integer getId(int id);
	
	String getName(String name);
	
	String getDescription(String description);
	
	String getDifficulty(String difficulty);
	
	Integer getCost(int cost);

}
