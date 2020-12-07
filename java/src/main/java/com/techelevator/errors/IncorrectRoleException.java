package com.techelevator.errors;

public class IncorrectRoleException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2495923047788338798L;

	public IncorrectRoleException(String role, String action){
		super("Action '" + action + "' cannot be performed by role '" + role + "'");
	}
}
