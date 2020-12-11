package com.techelevator.model;

import java.sql.Timestamp;

public class Grade {
	private int student;
	private int assignment;
	private Timestamp timeTurnedIn;
	private int numberCorrect;
	private int grade;
	private String comment;
	
	public int getStudent(){return student;}
	public int getAssignment(){return assignment;}
	public Timestamp getTimeTurnedIn(){return timeTurnedIn;}
	public int getNumberCorrect(){return numberCorrect;}
	public int getGrade(){return grade;}
	public String getComment(){return comment;}
	
	public void setStudent(int student){this.student = student;}
	public void setAssignment(int assignment){this.assignment = assignment;}
	public void setTimeTurnedIn(Timestamp timeTurnedIn){this.timeTurnedIn = timeTurnedIn;}
	public void setNumberCorrect(int numberCorrect){this.numberCorrect = numberCorrect;}
	public void setGrade(int grade){this.grade = grade;}
	public void setComment(String comment){this.comment = comment;}
	
	public Grade(int student, int assignment, Timestamp timeTurnedIn, int numberCorrect, int grade, String comment) {
		this.student = student;
		this.assignment = assignment;
		this.timeTurnedIn = timeTurnedIn;
		this.numberCorrect = numberCorrect;
		this.grade = grade;
		this.comment = comment;
	}
	
	public Grade() {}

	
}
