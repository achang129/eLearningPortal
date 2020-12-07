package com.techelevator.model;

import java.time.LocalDate;

public class HomeworkAssignment {
	private Assignment homework;
	private int course;
	private LocalDate date;
	
	public Assignment getHomework(){return homework;}
	public int getCourse(){return course;}
	public LocalDate getDate(){return date;}
}
