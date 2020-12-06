package com.techelevator.model;

import java.util.List;
import java.util.ArrayList;

public class Teacher extends User {
	private List<Course> taughtCourses;
	
	public List<Course> getCourses(){return this.taughtCourses;}
	
	public Teacher(){
		super();
		taughtCourses = new ArrayList<Course>();
	}
}
