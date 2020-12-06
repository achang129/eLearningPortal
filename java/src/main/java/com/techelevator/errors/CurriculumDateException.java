package com.techelevator.errors;

public class CurriculumDateException extends Exception{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6796795334361213390L;

	public CurriculumDateException(){
		super("Curriculum assigned without valid date");
	}
}
