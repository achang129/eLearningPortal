package com.techelevator.dao;

import com.techelevator.model.Teacher;

public interface TeacherDAO {
	
	Teacher getTeacherByCourse(int courseID);
	boolean createTeacher(Teacher newTeacher);
	
}
