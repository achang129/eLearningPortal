package com.techelevator.dto;

public class GradeDTO {
	private String assignment;
	private String status;
	private int grade;
	private String comment;
	
	public String getAssignment(){return assignment;}
	public String getStatus(){return status;}
	public int getGrade(){return grade;}
	public String getComment(){return comment;}
	
	public void setAssignment(String assignment){this.assignment = assignment;}
	public void setStatus(String status){this.status = status;}
	public void setGrade(int grade){this.grade = grade;}
	public void setComment(String comment){this.comment = comment;}
	
	public GradeDTO(){
		assignment = "";
		status = "";
		grade = 0;
		comment = "";
	}
}
