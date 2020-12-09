package com.techelevator.dto;

import java.time.LocalDate;

import com.techelevator.model.Course;
import com.techelevator.model.Curriculum;

/***
 * 
 * DTO for adding a new course
 *
 */

public class CourseDTO {
	//properties
	private String name;
	private String description;
	private String difficulty;
	private int cost;
	private LocalDate[] dates;
	private Curriculum[] curricula;
	
	//getters
	public String getName(){return name;}
	public String getDescription(){return description;}
	public String getDifficulty(){return difficulty;}
	public int getCost(){return cost;}
	public LocalDate[] getDates(){return dates;}
	public Curriculum[] getCurricula(){return curricula;}
	
	//setters
	public void setName(String name){this.name = name;}
	public void setDescription(String description){this.description = description;}
	public void setDifficulty(String difficulty){this.difficulty = difficulty;}
	public void setCost(int cost){this.cost = cost;}
	
	public CourseDTO(Course course){
		setName(course.getName());
		setDescription(course.getDescription());
		setDifficulty(course.getDifficulty());
		setCost(course.getCost());
		dates = course.getCurriculum().keySet().toArray(new LocalDate[0]);
		curricula = new Curriculum[dates.length];
		for(int i=0; i<dates.length; i++){
			curricula[i] = course.getCurriculum().get(dates[i]);
		}
	}
}
