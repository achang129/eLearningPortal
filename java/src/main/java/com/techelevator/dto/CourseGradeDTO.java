package com.techelevator.dto;

public class CourseGradeDTO {
	private int id;
	private String name;
	private String student;
	private double grade;
	
	public int getId(){return id;}
	public String getName(){return name;}
	public String getStudent(){return student;}
	public double getGrade(){return grade;}
	
	public void setId(int id){this.id=id;}
	public void setName(String name){this.name = name;}
	public void setStudent(String student){this.student = student;}
	public void setGrade(double grade){this.grade = grade;}
	
	public CourseGradeDTO(){
		id=0;
		name = "";
		student = "";
		grade = 0D;
	}
}
