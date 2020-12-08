package com.techelevator.model;

public class Answer {
	//properties
	private int studentID;
	private int assignmentID;
	private int questionID;
	private String answer;
	
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
	public int getQuestionID() {
		return questionID;
	}
	public void setQuestionID(int questionID) {
		this.questionID = questionID;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String response) {
		this.answer = response;
	}
	
	//constructors
	public Answer(int studentID, int assignmentID, int questionID, String answer) {
		this.studentID = studentID;
		this.assignmentID = assignmentID;
		this.questionID = questionID;
		this.answer = answer;
	}
	
	public Answer() { }
	
	
}
