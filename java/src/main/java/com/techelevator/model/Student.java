package com.techelevator.model;

import java.util.List;
import java.util.ArrayList;

public class Student extends User {
	private List<Course> enrolledCourses;
	
	public List<Course> getCourses(){return this.enrolledCourses;}
	
	public Student(){
		super();
		enrolledCourses = new ArrayList<Course>();
	}
}
