package com.techelevator.dao;

import com.techelevator.model.Student;

public interface StudentDAO {
	
	int getByStudentID(int studentID);
	int getByCourseID(int courseID);
	boolean createStudent(Student newStudent);
	
}
