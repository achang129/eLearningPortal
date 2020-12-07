package com.techelevator.errors;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

public class IncorrectRoleException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2495923047788338798L;

	//@ResponseStatus(value = HttpStatus.FORBIDDEN)
	public IncorrectRoleException(String role, String action){
		super("Action '" + action + "' cannot be performed by role '" + role + "'");
	}
}
