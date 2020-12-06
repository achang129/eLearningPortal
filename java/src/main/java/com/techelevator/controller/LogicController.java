package com.techelevator.controller;

import javax.validation.Valid;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.techelevator.dao.AssignmentDAO;
import com.techelevator.dao.CourseDAO;
import com.techelevator.dao.CurriculumDAO;
import com.techelevator.dao.UserDAO;
import com.techelevator.model.Assignment;
import com.techelevator.model.Course;
import com.techelevator.model.Curriculum;
import com.techelevator.model.User;

@RestController
@CrossOrigin
public class LogicController {

	
	public LogicController(){
		
	}
	
	@RequestMapping(value = "/courses", method = RequestMethod.GET)
	public void getCourses(){
		
	}
	
	@RequestMapping(value = "/courses", method = RequestMethod.POST)
	public void newCourse(){
		
	}
	
	@RequestMapping(value = "/courses", method = RequestMethod.PUT)
	public void moveToCourse(){
		
	}
	
	@RequestMapping(value = "/courses/{id}", method = RequestMethod.GET)
	public void viewCourse(@PathVariable("id") int id){
		
	}
	
	@RequestMapping(value = "/courses/{id}", method = RequestMethod.POST)
	public void addCurriculum(@PathVariable("id") int id){
		
	}
	
	@RequestMapping(value = "/courses/{id}", method = RequestMethod.PUT)
	public void editCurriculum(@PathVariable("id") int id){
		
	}
	
	@RequestMapping(value = "/courses/{id}", method = RequestMethod.DELETE)
	public void deleteCourse(@PathVariable("id") int id){
		
	}
	
	@RequestMapping(value = "/homework/", method = RequestMethod.GET)
	public void getHomework(){
		
	}
	
	@RequestMapping(value = "/homework/", method = RequestMethod.POST)
	public void createHomework(){
		
	}
	
	@RequestMapping(value = "/homework/{id}", method = RequestMethod.GET)
	public void viewHomework(@PathVariable("id") int id){
		
	}

	@RequestMapping(value = "/homework/{id}", method = RequestMethod.POST)
	public void submitHomework(@PathVariable("id") int id){
		
	}
	
	@RequestMapping(value = "/homework/{id}", method = RequestMethod.PUT)
	public void submitAnswer(@PathVariable("id") int id){
		
	}
	
	@RequestMapping(value = "/homework/{id}", method = RequestMethod.DELETE)
	public void deleteHomework(@PathVariable("id") int id){
		
	}
}
