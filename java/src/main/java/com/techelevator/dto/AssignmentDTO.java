package com.techelevator.dto;

import java.time.LocalDate;

import com.techelevator.model.Assignment;
import com.techelevator.model.Question;

public class AssignmentDTO {
	private int id;
	private String name;
	private String description;
	private LocalDate createdDate;
	private LocalDate dueDate;
	private int course;
	private Question[] questions;
	private String[] answers;
	
	public int getId(){return id;}
	public String getName(){return name;}
	public String getDescription(){return description;}
	public LocalDate getCreatedDate(){return createdDate;}
	public LocalDate getDueDate(){return dueDate;}
	public int getCourse(){return course;}
	public Question[] getQuestions(){return questions;}
	public String[] getAnswers(){return answers;}
	
	public void setId(int id){this.id=id;}
	public void setName(String name){this.name = name;}
	public void setDescription(String description){this.description = description;}
	public void setDate(LocalDate createdDate){this.createdDate = createdDate;}
	public void setDueDate(LocalDate dueDate){this.dueDate = dueDate;}
	public void setCourse(int course){this.course = course;}
	public void setQuestions(Question[] questions){this.questions = questions;}
	public void setAnswers(String[] answers){this.answers = answers;}
	
	public AssignmentDTO(){
		id=0;
		name = "";
		description = "";
		createdDate = LocalDate.now();
		dueDate = LocalDate.now();
		course = 0;
		questions = new Question[0];
		answers = new String[0];
	}
	
	public AssignmentDTO(Assignment assignment, LocalDate date, int course, String[] answers){
		id=assignment.getId();
		name = assignment.getName();
		description = assignment.getDescription();
		this.createdDate = date;
		dueDate = assignment.getDueDate();
		this.course = course;
		this.questions = assignment.getQuestions().toArray(new Question[0]);
		this.answers = answers;
	}
}
