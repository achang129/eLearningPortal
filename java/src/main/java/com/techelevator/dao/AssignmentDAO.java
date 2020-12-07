package com.techelevator.dao;

import java.time.LocalDate;

public interface AssignmentDAO {
	
	Integer getAssignmentId(int assignment);
	
	LocalDate getDueDate(LocalDate dueDate);
	
	Integer getQuestions(int questions);
	

}
