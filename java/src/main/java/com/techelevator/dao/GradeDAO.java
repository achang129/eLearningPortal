package com.techelevator.dao;

import java.util.List;

import com.techelevator.model.Grade;

public interface GradeDAO {
	//may fold in with assignmentDAO, depends on how we end up implementing that
	
	//are we doing the actual grade calculation in the db or in the java app? this will define how I get the grade class here.
	Grade[] getGradesByStudent(int studentID);
	Grade[] getGradesByCourse(int courseID);
	Grade[] getGradesByStudentAndCourse(int studentID, int courseID);
	//Grade getGradeByID(int ID);//there are no grade id's, their key is the combo of student and assignment pk's
	boolean createGrade(Grade newGrade);
	
}
