package com.techelevator.dao;

public interface MessageDAO {
	int getMessageID();
	int getRecipientUserID();
	//int getSenderID();
	boolean isRead();
	String getContent();
}
