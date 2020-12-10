package com.techelevator.dao;

import com.techelevator.dto.CourseDTO;
import com.techelevator.model.Course;
import com.techelevator.model.User;

public interface CourseDAO {
	/**Returns list of courses in which the student with the given id is enrolled.*/
	Course[] getCoursesByStudent(int id);
	/**Returns list of courses taught by the teacher with the given id.*/
	Course[] getCoursesByTeacher(int id);
	/**Returns list of all courses.*/
	Course[] getAllCourses();
	/**Tries to create the course passed to it, returns true if successful and false otherwise.*/
	boolean makeCourse(CourseDTO courseDTO);
	/**Adds the teacher with the given id to the course with the given id, returns true if successful and false otherwise.*/
	boolean addTeacher(int course, int teacher);
	/**Adds the student with the given id to the course with the given id, returns true if successful and false otherwise.*/
	boolean addStudent(int course, int student);
	/**Returns the course with the given ID.*/
	Course getCourseById(int id);
	/**Deletes a course, returns true if successful and false otherwise.*/
	boolean deleteCourse(int course);
	/**Returns the students enrolled in a given course.*/
	User[] getStudents(int course);
}
