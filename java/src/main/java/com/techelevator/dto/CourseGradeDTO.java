package com.techelevator.dto;

public class CourseGradeDTO {
	private String name;
	private String student;
	private double grade;
	
	public String getName(){return name;}
	public String getStudent(){return student;}
	public double getGrade(){return grade;}
	
	public void setName(String name){this.name = name;}
	public void setStudent(String student){this.student = student;}
	public void setGrade(double grade){this.grade = grade;}
	
	public CourseGradeDTO(){
		name = "";
		student = "";
		grade = 0D;
	}
}
