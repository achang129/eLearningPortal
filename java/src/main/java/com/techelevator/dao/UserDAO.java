package com.techelevator.dao;

import com.techelevator.dto.UserDTO;
import com.techelevator.model.User;

public interface UserDAO {
	/**Returns a list of all users that have the 'teacher' role.*/
    UserDTO[] findAllTeachers();
	/**Returns a list of all users that have the 'student' role.*/
    UserDTO[] findAllStudents();
	/**Returns the role of the user with the given username.*/
    String getRoleByUsername(String username);
	/**Returns the role of the user with the given ID.*/
    String getRoleById(Long userId);
	/**Returns a list of all users.*/
    UserDTO[] findAll();
	/**Returns a user object given the user's ID.*/
    User getUserById(Long userId);
	/**Returns a user object given the user's name.*/
    User findByUsername(String username);
	/**Returns the ID of the user with the given name.*/
    int findIdByUsername(String username);
	/**Creates a new user with the given username, password, and role, returning true if successful and false otherwise.*/
    boolean create(String username, String password, String role);
    //will return all students that are NOT already in a course
	UserDTO[] findAllUnchosenStudents(Long courseId);
	//will return all students that are NOT already in a course
	UserDTO[] findAllUnchosenTeachers(Long courseId);
	//will return all enrolled students
	UserDTO[] findAllEnrolledStudents(Long courseId);
	//will return all enrolled teachers
	UserDTO[] findAllEnrolledTeachers(Long courseId);
}
