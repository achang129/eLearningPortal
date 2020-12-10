package com.techelevator.dao;

import com.techelevator.model.Message;

public interface MessageDAO {
	/**Sends a new, unread message to a user, returns true if successful and false otherwise.*/
	boolean send(int user, String content);
	/**Returns a list of messages for a given user.*/
	Message[] getList(int user);
	/**Returns true if a given message has been read and false otherwise.*/
	boolean isRead(int id);
	/**Marks a given message as read, returns true if successful and false otherwise.*/
	boolean markRead(int id);
	/**Deletes a message, returns true if successful and false otherwise.*/
	boolean delete(int id);

}