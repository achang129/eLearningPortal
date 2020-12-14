package com.techelevator.dto;

import com.techelevator.model.User;

public class UserDTO {
	private String name;
	private int id;
	
	public String getName(){return name;}
	public int getId(){return id;}
	
	public void setName(String name){this.name = name;}
	public void setId(int id){this.id = id;}
	
	public UserDTO(){
		name = "";
		id = 0;
	}
	
	public UserDTO(User user){
		name = user.getUsername();
		id = user.getId().intValue();
	}
}
