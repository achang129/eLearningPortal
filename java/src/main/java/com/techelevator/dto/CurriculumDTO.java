package com.techelevator.dto;

import java.time.LocalDate;

import com.techelevator.model.Curriculum;

public class CurriculumDTO {
	private String lesson;
	private LocalDate date;
	
	public String getLesson(){return lesson;}
	public LocalDate getDate(){return date;}
}
