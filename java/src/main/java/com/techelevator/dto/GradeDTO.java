package com.techelevator.dto;

import java.sql.Timestamp;

import com.techelevator.model.Grade;

public class GradeDTO {
	private String assignment;
	private String student;
	private String status;
	private Timestamp submitted;
	private double rawGrade;
	private int grade;
	private String comment;
	
	public String getAssignment(){return assignment;}
	public String getStudent(){return student;}
	public String getStatus(){return status;}
	public Timestamp getSubmitted(){return submitted;}
	public int getGrade(){return grade;}
	public double getRawGrade(){return rawGrade;}
	public String getComment(){return comment;}
	
	public void setAssignment(String assignment){this.assignment = assignment;}
	public void setStudent(String student){this.student = student;}
	public void setStatus(String status){this.status = status;}
	public void setSubmitted(Timestamp submitted){this.submitted = submitted;}
	public void setGrade(int grade){this.grade = grade;}
	public void setRawGrade(double rawGrade){this.rawGrade = rawGrade;}
	public void setComment(String comment){this.comment = comment;}
	
	public GradeDTO(){
		assignment = "";
		student = "";
		status = "";
		submitted = null;
		grade = 0;
		comment = "";
	}
	
	public GradeDTO(Grade g){
		assignment = "";
		student = "";
		submitted = g.getTimeTurnedIn();		
		grade = g.getGrade();
		rawGrade = g.getNumberCorrect();
		if(grade > 0){status = "graded";}
		else if(submitted == null){status = "unsubmitted";}
		else{status = "submitted";}
	}
	
	public void numberToRaw(int total){
		rawGrade /= total;
	}
}
