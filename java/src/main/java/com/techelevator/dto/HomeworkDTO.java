package com.techelevator.dto;

import java.time.LocalDate;

import com.techelevator.model.Question;

public class HomeworkDTO {
	private String name;
	private String description;
	private LocalDate createdDate;
	private LocalDate dueDate;
	private int course;
	
	public String getName(){return name;}
	public String getDescription(){return description;}
	public LocalDate getCreatedDate(){return createdDate;}
	public LocalDate getDueDate(){return dueDate;}
	public int getCourse(){return course;}

	public void setName(String name){this.name = name;}
	public void setDescription(String description){this.description = description;}
	public void setDate(LocalDate createdDate){this.createdDate = createdDate;}
	public void setDueDate(LocalDate dueDate){this.dueDate = dueDate;}
	public void setCourse(int course){this.course = course;}
	
	public HomeworkDTO(){
		name = "";
		description = "";
		createdDate = LocalDate.now();
		dueDate = LocalDate.now();
		course = 0;
	}
}
