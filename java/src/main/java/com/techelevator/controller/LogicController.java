package com.techelevator.controller;

import java.security.Principal;

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
import com.techelevator.errors.IncorrectRoleException;
import com.techelevator.model.Assignment;
import com.techelevator.model.Course;
import com.techelevator.model.CourseAssignment;
import com.techelevator.model.Curriculum;
import com.techelevator.model.Message;
import com.techelevator.model.User;

@RestController
@CrossOrigin
public class LogicController {

	private static final String ADMIN = "admin";
	private static final String TEACHER = "teacher";
	private static final String STUDENT = "student";
	
	private UserDAO userDAO;
	private CourseDAO courseDAO;
	private CurriculumDAO curriculumDAO;
	private AssignmentDAO assignmentDAO;
	
	public LogicController(UserDAO userDAO, CourseDAO courseDAO, CurriculumDAO curriculumDAO){
		this.userDAO = userDAO;
		this.courseDAO = courseDAO;
		this.curriculumDAO = curriculumDAO;
	}
	
	@RequestMapping(value = "/courses", method = RequestMethod.GET)
	public Course[] getCourses(Principal p) throws IncorrectRoleException{
		String role = validateRole(p, "get course list", TEACHER, STUDENT);
		if(role.equals(STUDENT))
			return courseDAO.getCoursesByStudent(getID(p));
		return courseDAO.getCoursesByTeacher(getID(p));
	}

    @ResponseStatus(HttpStatus.CREATED)
	@RequestMapping(value = "/courses", method = RequestMethod.POST)
	public boolean newCourse(@RequestBody Course course, Principal p) throws IncorrectRoleException{
		validateRole(p, "create course", TEACHER, ADMIN);
		return courseDAO.makeCourse(course);
	}

	@RequestMapping(value = "/courses", method = RequestMethod.PUT)
	public boolean moveToCourse(@RequestBody CourseAssignment assignment, Principal p) throws IncorrectRoleException{
		validateRole(p, "assign to course", ADMIN);
		String role = userDAO.getRoleById(new Long(assignment.getUser()));
		switch(role){
		case TEACHER:
			return courseDAO.addTeacher(assignment.getCourse(), assignment.getUser());
		case STUDENT:
			return courseDAO.addStudent(assignment.getCourse(), assignment.getUser());
		default:
			throw new IncorrectRoleException(role, "join course");
		}
	}
	
	@RequestMapping(value = "/courses/{id}", method = RequestMethod.GET)
	public Course viewCourse(@PathVariable("id") int id, Principal p){
		//validate that user is student/teacher for course or administrator?
		return courseDAO.getCourseById(id);
	}

    @ResponseStatus(HttpStatus.CREATED)
	@RequestMapping(value = "/courses/{id}", method = RequestMethod.POST)
	public boolean addCurriculum(@PathVariable("id") int id, @RequestBody Curriculum curriculum, Principal p){
		
		return false;
	}
	
	@RequestMapping(value = "/courses/{id}", method = RequestMethod.PUT)
	public boolean editCurriculum(@PathVariable("id") int id, @RequestBody Curriculum curriculum, Principal p){
		
		return false;
	}
	
	@RequestMapping(value = "/courses/{id}", method = RequestMethod.DELETE)
	public boolean deleteCourse(@PathVariable("id") int id, Principal p){
		
		return false;
	}
	
	@RequestMapping(value = "/homework/", method = RequestMethod.GET)
	public Assignment[] getHomework(Principal p){
		
		return null;
	}

    @ResponseStatus(HttpStatus.CREATED)
	@RequestMapping(value = "/homework/", method = RequestMethod.POST)
	public boolean createHomework(@RequestBody Assignment homework, Principal p){
		
		return false;
	}
	
	@RequestMapping(value = "/homework/{id}", method = RequestMethod.GET)
	public Assignment viewHomework(@PathVariable("id") int id, Principal p){
		
		return null;
	}

	@RequestMapping(value = "/homework/{id}", method = RequestMethod.POST)
	public boolean submitHomework(@PathVariable("id") int id, Principal p){
		
		return false;
	}
	
	@RequestMapping(value = "/homework/{id}", method = RequestMethod.PUT)
	public boolean submitAnswer(@PathVariable("id") int id, @RequestBody String answer, Principal p){
		
		return false;
	}
	
	@RequestMapping(value = "/homework/{id}", method = RequestMethod.DELETE)
	public boolean deleteHomework(@PathVariable("id") int id, Principal p){
		
		return false;
	}
	
	@RequestMapping(value = "/messages", method = RequestMethod.GET)
	public Message[] getMessages(Principal p){
		
		return null;
	}
	
	@RequestMapping(value = "/messages", method = RequestMethod.POST)
	public boolean readMessage(@RequestBody Message message, Principal p){
		
		return false;
	}
	
	@RequestMapping(value = "/messages", method = RequestMethod.DELETE)
	public boolean deleteMessage(@RequestBody Message message, Principal p){
		
		return false;
	}
	
	@RequestMapping(value = "/users", method = RequestMethod.GET)
	public User[] getUsers(Principal p){
		
		return null;
	}

	@RequestMapping(value = "/users/{role}", method = RequestMethod.GET)
	public User[] getUsersByRole(@PathVariable("role") String role, Principal p){
		
		return null;
	}
	
	private int getID(Principal p){
		return userDAO.findIdByUsername(p.getName());
	}
	
	private User getUser(Principal p){
		return userDAO.findByUsername(p.getName());
	}
	
	private String getRole(Principal p){
		return userDAO.getRoleByUsername(p.getName());
	}
	
	private String validateRole(Principal p, String action, String...roles) throws IncorrectRoleException{
		String prole = getRole(p);
		for(String role : roles)
			if(prole.equals(role)){return prole;}
		throw(new IncorrectRoleException(prole, action));
	}
}
