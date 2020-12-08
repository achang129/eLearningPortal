package com.techelevator.dao;

import java.time.LocalDate;

import com.techelevator.model.Curriculum;

public interface CurriculumDAO {
	//need these for API calls
	//creates the new curriculum for the given course on the given date, returns true if successful and false otherwise
	boolean addCurriculum(int course, Curriculum curriculum, LocalDate date);
	//edits the curriculum for a course on a given date, returns true if successful and false otherwise
	boolean editCurriculum(int course, Curriculum curriculum, LocalDate date);
}
