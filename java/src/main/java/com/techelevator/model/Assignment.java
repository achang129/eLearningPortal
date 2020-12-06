package com.techelevator.model;

import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;

public class Assignment {
	//properties
	private long id;
	private LocalDate dueDate;
	private List<Question> questions;
	
	//getters
	public long getID(){return id;}
	public LocalDate getDueDate(){return dueDate;}
	public List<Question> getQuestions(){return questions;}
	//setters
	public void setID(long id){this.id = id;}
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
		dueDate=null;
		clearQuestions();
	}
}
