package com.techelevator.dao;

import java.time.LocalDate;

public interface CurriculumDAO {
	
	Integer getCourse(int course);
	
	LocalDate getDate(LocalDate date);
	
	String getLesson(String lesson);
	
	Integer getHomework(int homework);

}
