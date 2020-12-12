package com.techelevator.dto;

import com.techelevator.model.Course;

/***
 * 
 * DTO used for adding new courses and getting a list of course information
 *
 */

public class CourseDTO {
	private int id;
	private String name;
	private String description;
	private int classSize;
	private int cost;
	
	public int getId(){return id;}
	public String getName(){return name;}
	public String getDescription(){return description;}
	public int getClassSize(){return classSize;}
	public int getCost(){return cost;}
	public void setId(int id){this.id = id;}
	public void setName(String name){this.name = name;}
	public void setDescription(String description){this.description = description;}
	public void setClassSize(int classSize){this.classSize = classSize;}
	public void setCost(int cost){this.cost = cost;}
	
	public CourseDTO(){
		id = 0;
		name = "";
		description = "";
		classSize = 0;
		cost = 0;
	}
	
	public CourseDTO(Course course){
		id = course.getId();
		name = course.getName();
		description = course.getDescription();
		classSize = course.getClassSize();
		cost = course.getCost();
	}
}
