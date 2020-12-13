package com.techelevator.model;

public class Question {
	private static final String TEXT = "text";
	private static final String MC = "mc";
	private static final String MMC = "mmc";
	
	
	private String type;
	private String statement;
	private int weight;
	private String[] answers;
	private boolean[] correct;
	
	public String getType(){return type;}
	public String getStatement(){return statement;}
	public int getWeight(){return weight;}
	public String[] getAnswers(){return answers;}
	public boolean[] getCorrect(){return correct;}
	
	public void setType(String type){this.type = type;}
	public void setStatement(String statement){this.statement = statement;}
	public void setWeight(int weight){this.weight = weight;}
	public void setAnswers(String[] answers){this.answers = answers;}
	public void setCorrect(boolean[] correct){this.correct = correct;}
	
	public Question(){
		type = "";
		statement = "";
		weight = 1;
		answers = new String[0];
		correct = new boolean[0];
	}
}
