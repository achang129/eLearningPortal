package com.techelevator.model;

import java.sql.Timestamp;

public class Grade {
	//properties
	private int studentID;
	private int assignmentID;
	private Timestamp timeTurnedIn;
	private int numberCorrect;
	private int grade;
	
	//getters/setters
	public int getStudentID() {
		return studentID;
	}

	public void setStudentID(int studentID) {
		this.studentID = studentID;
	}

	public int getAssignmentID() {
		return assignmentID;
	}

	public void setAssignmentID(int assignmentID) {
		this.assignmentID = assignmentID;
	}

	public Timestamp getTimeTurnedIn() {
		return timeTurnedIn;
	}

	public void setTimeTurnedIn(Timestamp timeTurnedIn) {
		this.timeTurnedIn = timeTurnedIn;
	}

	public int getNumberCorrect() {
		return numberCorrect;
	}

	public void setNumberCorrect(int numberCorrect) {
		this.numberCorrect = numberCorrect;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	//constructors
	public Grade(int studentID, int assignmentID, Timestamp timeTurnedIn, int numberCorrect, int grade) {
		this.studentID = studentID;
		this.assignmentID = assignmentID;
		this.timeTurnedIn = timeTurnedIn;
		this.numberCorrect = numberCorrect;
		this.grade = grade;
	}

	
}
