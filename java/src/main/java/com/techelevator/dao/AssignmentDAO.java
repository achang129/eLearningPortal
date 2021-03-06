package com.techelevator.dao;

import java.time.LocalDate;

import com.techelevator.dto.AssignmentDTO;
import com.techelevator.model.Answer;
import com.techelevator.model.Assignment;
import com.techelevator.model.Question;

public interface AssignmentDAO {
	/**Returns list of assignments for courses the user with the given id is taking.*/
	Assignment[] getStudentAssignments(int student);
	/**Creates a new homework assignment for the given course id on the given date, returns assignment.id*/
	int newAssignment(String name, String description, LocalDate date, LocalDate dueDate, int course, Question[] questions);
	/**Returns the assignment with the new SQL-generated id.*/
	Assignment getAssignmentById(int id);
	/**Submits the homework assignment with the given id on behalf of the student with the given id at the current time, returns true if successful and false otherwise.*/
	boolean submitAssignment(int id, int student);
	/**Returns the user id of the teacher of the course for which this homework was assigned (harder than it seems, save this for last).*/
	Integer[] getTeacher(int id);
	/**Adds an answer for the given question on the assignment with the given id from the given student, returns true if successful and false otherwise.*/
	boolean submitAnswer(int id, int question, int student, String answer);
	/**Deletes a homework assignment, returns true if successful or false otherwise.*/
	boolean deleteAssignment(int id);
	/**Gets an AssignmentDTO object based on a particular user*/
	AssignmentDTO getDTO(int id, int user);
	AssignmentDTO[] getDTOs(int user, int course);
	/**returns true iff the assignment has been submitted by the student*/
	String isSubmitted(int id, int user);
}
