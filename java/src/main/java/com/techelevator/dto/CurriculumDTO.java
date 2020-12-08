package com.techelevator.dto;

import java.time.LocalDate;

import com.techelevator.model.Curriculum;

public class CurriculumDTO {
	private Curriculum curriculum;
	private LocalDate date;
	
	public Curriculum getCurriculum(){return curriculum;}
	public LocalDate getDate(){return date;}
}
