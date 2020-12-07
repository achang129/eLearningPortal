package com.techelevator.dao;


import java.util.List;

import com.techelevator.model.Message;

public interface MessageDAO {
	//need these for API calls
	//sends a new, unread message to a user, returns true if successful and false otherwise
	boolean send(int user, String content);
	//returns a list of messages for a given user
	List<Message> getList(int user);
	//returns true if a given message has been read and false otherwise
	boolean isRead(int id);
	//marks a given message as read, returns true if successful and false otherwise
	boolean markRead(int id);
	//deletes a message, returns true if successful and false otherwise
	boolean delete(int id);

}