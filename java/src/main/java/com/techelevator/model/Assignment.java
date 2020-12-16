package com.techelevator.model;

import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;

public class Assignment {
	private int id;
	private String name;
	private LocalDate dueDate;
	private LocalDate createdDate;
	private List<Question> questions;
	private int course;
	
	public int getId(){return id;}
	public String getName(){return name;}
	public LocalDate getDueDate(){return dueDate;}
	public LocalDate getCreatedDate(){return createdDate;}
	public List<Question> getQuestions(){return questions;}
	public int getCourse() {return course;}
	
	public void setId(int id){this.id = id;}
	public void setName(String name){this.name = name;}
	public void setDueDate(LocalDate dueDate){this.dueDate = dueDate;}
	public void setCreatedDate(LocalDate createdDate){this.createdDate = createdDate;}
	public void setCourse(int course) {this.course=course;}
	
	//modify questions list
	public boolean removeQuestion(Question question){
		return questions.remove(question);
	}
	public void addQuestion(Question question){
		if(!questions.contains(question))
			questions.add(question);
	}
	public void setQuestions(Question[] questions){
		clearQuestions();
		for(Question q : questions)
			addQuestion(q);
	}
	public void clearQuestions(){questions = new ArrayList<Question>();}
	
	//constructor
	public Assignment(){
		id=0;
		name = "";
		createdDate=LocalDate.now();
		dueDate=null;
		clearQuestions();
		course=0;
	}
}
