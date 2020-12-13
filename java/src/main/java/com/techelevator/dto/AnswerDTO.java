package com.techelevator.dto;

public class AnswerDTO {
	private int assignment;
	private int question;
	private int points;
	private String answer;
	
	public int getAssignment(){return assignment;}
	public int getQuestion(){return question;}
	public int getPoints(){return points;}
	public String getAnswer(){return answer;}
	
	public void setAssignment(int assignment){this.assignment = assignment;}
	public void setQuestion(int question){this.question = question;}
	public void setPoints(int points){this.points = points;}
	public void setAnswer(String answer){this.answer = answer;}
	
	public AnswerDTO(){
		assignment = 0;
		question = 0;
		points = 0;
		answer = "";
	}
}
