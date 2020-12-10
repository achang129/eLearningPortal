package com.techelevator.dao;

import com.techelevator.model.User;

public interface UserDAO {
	/**Returns a list of all users that have the 'teacher' role.*/
    User[] findAllTeachers();
	/**Returns a list of all users that have the 'student' role.*/
    User[] findAllStudents();
	/**Returns the role of the user with the given username.*/
    String getRoleByUsername(String username);
	/**Returns the role of the user with the given ID.*/
    String getRoleById(Long userId);
	/**Returns a list of all users.*/
    User[] findAll();
	/**Returns a user object given the user's ID.*/
    User getUserById(Long userId);
	/**Returns a user object given the user's name.*/
    User findByUsername(String username);
	/**Returns the ID of the user with the given name.*/
    int findIdByUsername(String username);
	/**Creates a new user with the given username, password, and role, returning true if successful and false otherwise.*/
    boolean create(String username, String password, String role);
}
