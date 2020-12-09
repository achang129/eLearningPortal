package com.techelevator.dao;

import com.techelevator.dto.CourseDTO;
import com.techelevator.model.Course;

public interface CourseDAO {
	//needed for API calls
	//returns list of courses in which the student with the given id is enrolled
	Course[] getCoursesByStudent(int id);
	//returns list of courses taught by the teacher with the given id
	Course[] getCoursesByTeacher(int id);
	//returns list of all courses
	Course[] getAllCourses();
	//tries to create the course passed to it, returns true if successful and false otherwise
	boolean makeCourse(CourseDTO courseDTO);
	//adds the teacher with the given id to the course with the given id, returns true if successful and false otherwise
	boolean addTeacher(int course, int teacher);
	//adds the student with the given id to the course with the given id, returns true if successful and false otherwise
	boolean addStudent(int course, int student);
	//returns the course with the given ID
	Course getCourseById(int id);
	//deletes a course, returns true if successful and false otherwise
	boolean deleteCourse(int course);
}
