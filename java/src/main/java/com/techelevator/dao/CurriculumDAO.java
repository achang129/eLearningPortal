package com.techelevator.dao;

import java.time.LocalDate;

import com.techelevator.model.Curriculum;

public interface CurriculumDAO {
	//need these for API calls
	//creates the new curriculum for the given course on the given date
	boolean addCurriculum(int course, Curriculum curriculum, LocalDate date);
	
	Integer getCourse(int course);
	LocalDate getDate(LocalDate date);
	String getLesson(String lesson);
	Integer getHomework(int homework);

}
