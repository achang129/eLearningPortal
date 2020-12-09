package com.techelevator.model;

import java.util.HashMap;
import java.time.LocalDate;
import java.util.Map;

import com.techelevator.errors.CurriculumDateException;


public class Course {
	//properties
	private long id;
	private String name;
	private String description;
	private String difficulty;
	private int cost;
	private Map<LocalDate, Curriculum> curriculum;
	
	//getters
	public long getID(){return id;}
	public String getName(){return name;}
	public String getDescription(){return description;}
	public String getDifficulty(){return difficulty;}
	public int getCost(){return cost;}
	public Map<LocalDate, Curriculum> getCurriculum(){return curriculum;}
	
	//setters
	public void setID(long id){this.id = id;}
	public void setName(String name){this.name = name;}
	public void setDescription(String description){this.description = description;}
	public void setDifficulty(String difficulty){this.difficulty = difficulty;}
	public void setCost(int cost){this.cost = cost;}
	
	//modify curriculum
	public void setCurriculum(LocalDate date, Curriculum curriculum) throws CurriculumDateException{
		if(date==null)
			throw new CurriculumDateException();
		if(curriculum==null){
			this.curriculum.remove(date);
		}else{
			this.curriculum.put(date, curriculum);
		}
	}
	public void clearCurriculum(){
		curriculum = new HashMap<LocalDate, Curriculum>();
	}
	public void setCurriculum(LocalDate[] dates, Curriculum[] curricula) throws Exception{
		if(dates==null || curricula==null)
			throw new Exception("List of dates/curricula cannot be null");
		if(dates.length < curricula.length)
			throw new CurriculumDateException();
		clearCurriculum();
		for(int i=0; i<curricula.length; i++){
			setCurriculum(dates[i], curricula[i]);
		}
	}
	
	public Course(){
		id=0;
		name="";
		description="";
		difficulty="";
		cost=0;
		clearCurriculum();
	}
	
	
}
