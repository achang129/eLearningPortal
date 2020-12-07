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
import com.techelevator.dao.MessageDAO;
import com.techelevator.dao.UserDAO;
import com.techelevator.errors.IncorrectRoleException;
import com.techelevator.model.Assignment;
import com.techelevator.model.Course;
import com.techelevator.model.CourseAssignment;
import com.techelevator.model.Curriculum;
import com.techelevator.model.CurriculumAssignment;
import com.techelevator.model.HomeworkAnswer;
import com.techelevator.model.HomeworkAssignment;
import com.techelevator.model.Message;
import com.techelevator.model.User;

@RestController
@CrossOrigin
public class LogicController {

	private static final String ADMIN = "admin";
	private static final String TEACHER = "teacher";
	private static final String STUDENT = "student";
	
	private static final String HOMEWORK_SUBMIT_MESSAGE = "Student %s has submitted a new homework assignment.";
	
	private AssignmentDAO assignmentDAO;
	private CourseDAO courseDAO;
	private CurriculumDAO curriculumDAO;
	private MessageDAO messageDAO;
	private UserDAO userDAO;
	
	public LogicController(UserDAO userDAO, MessageDAO messageDAO, CourseDAO courseDAO, CurriculumDAO curriculumDAO){
		this.userDAO = userDAO;
		this.courseDAO = courseDAO;
		this.curriculumDAO = curriculumDAO;
		this.messageDAO = messageDAO;
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
	public boolean addCurriculum(@PathVariable("id") int id, @RequestBody CurriculumAssignment curriculum, Principal p){
    	//validate that user is teacher for course?
    	return curriculumDAO.addCurriculum(id, curriculum.getCurriculum(), curriculum.getDate());
	}
	
	@RequestMapping(value = "/courses/{id}", method = RequestMethod.PUT)
	public boolean editCurriculum(@PathVariable("id") int id, @RequestBody CurriculumAssignment curriculum, Principal p){
		//validate that user is teacher for course?
		return curriculumDAO.editCurriculum(id, curriculum.getCurriculum(), curriculum.getDate());
	}
	
	@RequestMapping(value = "/courses/{id}", method = RequestMethod.DELETE)
	public boolean deleteCourse(@PathVariable("id") int id, Principal p){
		//validate something??
		return courseDAO.deleteCourse(id);
	}
	
	@RequestMapping(value = "/homework/", method = RequestMethod.GET)
	public Assignment[] getHomework(Principal p) throws IncorrectRoleException{
		validateRole(p, "view homework", STUDENT);
		return assignmentDAO.getStudentAssignments(getID(p));
	}

    @ResponseStatus(HttpStatus.CREATED)
	@RequestMapping(value = "/homework/", method = RequestMethod.POST)
	public boolean createHomework(@RequestBody HomeworkAssignment homework, Principal p) throws IncorrectRoleException{
		validateRole(p, "create homework", TEACHER);
		return assignmentDAO.newAssignment(homework.getCourse(), homework.getDate(), homework.getHomework());
	}
	
	@RequestMapping(value = "/homework/{id}", method = RequestMethod.GET)
	public Assignment viewHomework(@PathVariable("id") int id, Principal p){
		//validate that the person in question has been assigned this work?
		return assignmentDAO.getAssignmentById(id);
	}

	@RequestMapping(value = "/homework/{id}", method = RequestMethod.POST)
	public boolean submitHomework(@PathVariable("id") int id, Principal p) throws IncorrectRoleException{
		validateRole(p, "submit homework", STUDENT);
		int uid = getID(p);
		if(assignmentDAO.submitAssignment(id, uid)){
			//possible for the message not to be sent! currently prioritizing homework status.
			messageDAO.send(assignmentDAO.getTeacher(id), String.format(HOMEWORK_SUBMIT_MESSAGE, p.getName()));
			return true;
		}else{return false;}
	}
	
	@RequestMapping(value = "/homework/{id}", method = RequestMethod.PUT)
	public boolean submitAnswer(@PathVariable("id") int id, @RequestBody HomeworkAnswer answer, Principal p) throws IncorrectRoleException{
		validateRole(p, "submit answer", STUDENT);
		int uid = getID(p);
		return assignmentDAO.submitAnswer(id, answer.getQuestion(), uid, answer.getAnswer());
	}
	
	@RequestMapping(value = "/homework/{id}", method = RequestMethod.DELETE)
	public boolean deleteHomework(@PathVariable("id") int id, Principal p) throws IncorrectRoleException{
		validateRole(p, "delete homework", TEACHER);//administrator??
		return assignmentDAO.deleteAssignment(id);
	}
	
	@RequestMapping(value = "/messages", method = RequestMethod.GET)
	public Message[] getMessages(Principal p){
		return messageDAO.getList(getID(p));
	}

	@RequestMapping(value = "/messages", method = RequestMethod.DELETE)
	public boolean deleteMessage(@RequestBody int id, Principal p){
		return messageDAO.delete(id);
	}
	
	@RequestMapping(value = "/messages/read", method = RequestMethod.GET)
	public boolean checkMessage(@RequestBody int id, Principal p){
		return messageDAO.isRead(id);
	}
	
	@RequestMapping(value = "/messages/read", method = RequestMethod.PUT)
	public boolean readMessage(@RequestBody int id, Principal p){
		return messageDAO.markRead(id);
	}
	
	@RequestMapping(value = "/users", method = RequestMethod.GET)
	public User[] getUsers(Principal p){
		return userDAO.findAll().toArray(new User[0]);
	}

	@RequestMapping(value = "/users/{role}", method = RequestMethod.GET)
	public User[] getUsersByRole(@PathVariable("role") String role, Principal p){
		switch(role){
		case STUDENT:
			return userDAO.findAllStudents().toArray(new User[0]);
		case TEACHER:
			return userDAO.findAllTeachers().toArray(new User[0]);
		default:
			return new User[0];
		}
	}
	
	private int getID(Principal p){
		return userDAO.findIdByUsername(p.getName());
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
