package com.techelevator.dao;

import java.util.List;

import com.techelevator.model.Message;

public interface MessageDAO {
	
	boolean sendMessage(Message message);
	List<Message> getMessageByUser(int userID);
	Message getMessageByID(int ID);
	
}
