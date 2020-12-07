package com.techelevator.dao;

import com.techelevator.model.User;

import java.util.List;

public interface UserDAO {
	//need these for API calls
    List<User> findAllTeachers();
    List<User> findAllStudents();
    String getRoleByUsername(String username);
    String getRoleById(Long userId);
    
    //already implemented
    List<User> findAll();
    User getUserById(Long userId);
    User findByUsername(String username);
    int findIdByUsername(String username);
    boolean create(String username, String password, String role);
}
