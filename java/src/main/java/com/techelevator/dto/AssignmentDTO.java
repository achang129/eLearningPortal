package com.techelevator.dto;

import java.time.LocalDate;

import com.techelevator.model.Assignment;

public class AssignmentDTO {
	private Assignment homework;
	private int course;
	private LocalDate date;
	
	public Assignment getHomework(){return homework;}
	public int getCourse(){return course;}
	public LocalDate getDate(){return date;}
}
