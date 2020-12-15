package com.techelevator.dto;

public class GPADTO {
	private String student;
	private double gpa;
	
	public String getStudent(){return student;}
	public double getGpa(){return gpa;}
	
	public void setStudent(String student){this.student = student;}
	public void setGpa(double gpa){this.gpa = gpa;}
	
	public GPADTO(){
		student = "";
		gpa = 0D;
	}
}
