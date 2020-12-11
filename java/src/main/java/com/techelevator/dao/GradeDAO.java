package com.techelevator.dao;

import com.techelevator.model.Grade;

public interface GradeDAO {
	/**Returns list of grades for assignments submitted by a particular student.*/
	Grade[] getGradesByStudent(int studentID);
	/**Returns list of grades for assignments in a particular course.*/
	Grade[] getGradesByCourse(int courseID);
	/**Returns list of grades for assignments in a particular course submitted by a particular student.*/
	Grade[] getGradesByStudentAndCourse(int studentID, int courseID);
	/**Returns list of grades for a particular assignment*/
	Grade[] getAllGradesByAssignment(int assignment);
	/**Returns grade for a particular assignment submitted by a particular student*/
	Grade getStudentGradeByAssignment(int student, int assignment);
	/**Creates a new grade.*/
	boolean createGrade(Grade newGrade);
	/**Updates an existing grade with a new grade/comment.*/
	boolean updateGrade(Grade grade);
	
}
