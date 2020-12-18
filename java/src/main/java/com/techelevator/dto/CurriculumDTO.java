package com.techelevator.dto;

import java.time.LocalDate;

import com.techelevator.model.Curriculum;

public class CurriculumDTO {
	private String lesson;
	private LocalDate date;
	private int homework;
	
	public String getLesson(){return lesson;}
	public LocalDate getDate(){return date;}
	public int getHomework(){return homework;}
	public void setLesson(String lesson){this.lesson = lesson;}
	public void setDate(LocalDate date){this.date = date;}
	public void setHomework(int homework){this.homework = homework;}
	
	public CurriculumDTO(){
		lesson = "";
		date = LocalDate.now();
		homework = 0;
	}
}
