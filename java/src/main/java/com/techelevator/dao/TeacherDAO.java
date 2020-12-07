package com.techelevator.dao;

import com.techelevator.model.Teacher;

public interface TeacherDAO {
	
	int getByTeacherID(int teacherID);
	int getByCourseID(int courseID);
	boolean createTeacher(Teacher newTeacher);
	
}
