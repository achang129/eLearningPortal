package com.techelevator.dto;

import java.time.LocalDate;

import com.techelevator.model.Course;
import com.techelevator.model.Curriculum;

public class NewCourseDTO {
	//properties
		private String name;
		private String description;
		private String difficulty;
		private int cost;
		
		//getters
		public String getName(){return name;}
		public String getDescription(){return description;}
		public String getDifficulty(){return difficulty;}
		public int getCost(){return cost;}
		
		//setters
		public void setName(String name){this.name = name;}
		public void setDescription(String description){this.description = description;}
		public void setDifficulty(String difficulty){this.difficulty = difficulty;}
		public void setCost(int cost){this.cost = cost;}
		
		public NewCourseDTO(){
			name = "";
			description = "";
			difficulty = "";
			cost = 0;
		}
}
