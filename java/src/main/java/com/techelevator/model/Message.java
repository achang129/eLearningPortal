package com.techelevator.model;

public class Message {
	//properties
	int id;
	int user;
	boolean isRead;
	String content;
	
	//getters
	public int getId() {return id;}
	public int getUser() {return user;}
	public boolean isRead() {return isRead;}
	public String getContent() {return content;}
	//setters
	public void setId(int id){this.id = id;}
	public void setUser(int user){this.user = user;}
	public void setIsRead(boolean isRead){this.isRead = isRead;}
	public void setContent(String content){this.content = content;}
	
	//constructors
	public Message(){ 
		id = 0;
		user = 0;
		isRead = false;
		content = "";
	}
	public Message(int id, int user, boolean isRead, String content) {
		this.id = id;
		this.user = user;
		this.isRead = isRead;
		this.content = content;
	}
	
}
