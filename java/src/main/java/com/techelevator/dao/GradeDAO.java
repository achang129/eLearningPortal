package com.techelevator.dao;

import java.util.List;

import com.techelevator.model.Grade;

public interface GradeDAO {
	//are we doing the actual grade calculation in the db or in the java app? this will define how I get the grade class here.
	List<Grade> getGradesByStudent(int studentID);
	List<Grade> getGradesByCourse(int courseID);
	List<Grade> getGradesByStudentAndCourse(int studentID, int courseID);
	Grade getGradeByID(int ID);
	boolean createGrade(Grade newGrade);
	
}
