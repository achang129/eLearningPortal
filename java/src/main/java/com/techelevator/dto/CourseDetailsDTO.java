package com.techelevator.dto;

import java.time.LocalDate;

import com.techelevator.model.Course;
import com.techelevator.model.Curriculum;

/***
 * 
 * DTO for viewing course details/curricula
 *
 */

public class CourseDetailsDTO {
	private String name;
	private String description;
	private int classSize;
	private int cost;
	private LocalDate[] dates;
	private Curriculum[] curricula;
	
	public String getName(){return name;}
	public String getDescription(){return description;}
	public int getClassSize(){return classSize;}
	public int getCost(){return cost;}
	public LocalDate[] getDates(){return dates;}
	public Curriculum[] getCurricula(){return curricula;}
	
	public void setName(String name){this.name = name;}
	public void setDescription(String description){this.description = description;}
	public void setDifficulty(int classSize){this.classSize = classSize;}
	public void setCost(int cost){this.cost = cost;}
	
	public CourseDetailsDTO(Course course){
		setName(course.getName());
		setDescription(course.getDescription());
		setDifficulty(course.getClassSize());
		setCost(course.getCost());
		dates = course.getCurriculum().keySet().toArray(new LocalDate[0]);
		curricula = new Curriculum[dates.length];
		for(int i=0; i<dates.length; i++)
			curricula[i] = course.getCurriculum().get(dates[i]);
	}
}
