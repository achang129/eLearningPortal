package com.techelevator.dao;


public interface MultiChoiceDAO {
	
	Integer getAssignment(int assignment);
	
	Integer getQuestion(int question);
	
	Integer getChoice(int choice);
	
	String getAnswer(String answer);
	
	boolean isCorrect(boolean correct);
	
	
}
