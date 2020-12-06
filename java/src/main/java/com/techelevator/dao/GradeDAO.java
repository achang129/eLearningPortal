package com.techelevator.dao;

import java.security.Timestamp;

public interface GradeDAO {
	int getStudentID();
	int getAssignmentID();
	Timestamp getTimeTurnedIn();
	int getNumberCorrect();
	int getGrade();
}
