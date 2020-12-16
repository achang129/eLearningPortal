package com.techelevator.dao;

import java.time.LocalDate;

import org.springframework.jdbc.InvalidResultSetAccessException;

import com.techelevator.errors.CurriculumDateException;
import com.techelevator.model.Course;
import com.techelevator.model.Curriculum;

public interface CurriculumDAO {
	/**Creates the new curriculum for the given course on the given date, returns true if successful and false otherwise.*/
	boolean addCurriculum(int course, Curriculum curriculum, LocalDate date);
	/**Edits the curriculum for a course on a given date, returns true if successful and false otherwise.*/
	boolean editCurriculum(int course, Curriculum curriculum, LocalDate date);
	/**Adds the curricula to an existing course object.*/
	void getCurricula(Course course) throws InvalidResultSetAccessException, CurriculumDateException;
	/**Deletes all curricula associated with a course.*/
	boolean deleteCurriculum(int course);
	/**Deletes a particular curriculum associated with a course.*/
	boolean deleteCurriculum(int course, LocalDate date);
	/**Adds a homework assignment to a particular curriculm.*/
	boolean addHomework(int course, LocalDate date, int homework);
}
