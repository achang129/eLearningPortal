package com.techelevator.model;

public class Message {
	//properties
	int messageID;
	int userID;
	boolean isRead;
	String content;
	
	//getters/setters
	public int getMessageID() {
		return messageID;
	}
	public void setMessageID(int messageID) {
		this.messageID = messageID;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public boolean isRead() {
		return isRead;
	}
	public void setRead(boolean isRead) {
		this.isRead = isRead;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	//constructors
	public Message() { }
	
	public Message(int messageID, int userID, boolean isRead, String content) {
		this.messageID = messageID;
		this.userID = userID;
		this.isRead = isRead;
		this.content = content;
	}
	
}
