package com.techelevator.dao;

import com.techelevator.model.Course;

public interface CourseDAO {
	//needed for API calls
	//returns list of courses in which the student with the given id is enrolled
	Course[] getCoursesByStudent(int id);
	//returns list of courses taught by the teacher with the given id
	Course[] getCoursesByTeacher(int id);
	//tries to create the course passed to it, returns true if successful and false otherwise
	boolean makeCourse(Course course);
	//adds the teacher with the given id to the course with the given id, returns true if successful and false otherwise
	boolean addTeacher(int course, int teacher);
	//adds the student with the given id to the course with the given id, returns true if successful and false otherwise
	boolean addStudent(int course, int student);
	//returns the course with the given ID
	Course getCourseById(int id);
	
	
	//existing
	Integer getId(int id);
	String getName(String name);
	String getDescription(String description);
	String getDifficulty(String difficulty);
	Integer getCost(int cost);
}
