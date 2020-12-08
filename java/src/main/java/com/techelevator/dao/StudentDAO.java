package com.techelevator.dao;

import java.util.List;

import com.techelevator.model.Student;

public interface StudentDAO {
	
	List<Student> getStudentsByCourse(int courseID);
	boolean createStudent(Student newStudent);
	
}
