package com.techelevator.model;

import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;

public class Assignment {
	private int id;
	private String name;
	private String description;
	private LocalDate dueDate;
	private List<Question> questions;
	
	public int getId(){return id;}
	public String getName(){return name;}
	public String getDescription(){return description;}
	public LocalDate getDueDate(){return dueDate;}
	public List<Question> getQuestions(){return questions;}
	
	public void setId(int id){this.id = id;}
	public void setName(String name){this.name = name;}
	public void setDescription(String description){this.description = description;}
	public void setDueDate(LocalDate dueDate){this.dueDate = dueDate;}
	
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
		description = "";
		dueDate=null;
		clearQuestions();
	}
}
