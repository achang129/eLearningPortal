package com.techelevator.controller;

import java.security.Principal;
import java.time.LocalDate;

import javax.annotation.security.RolesAllowed;
import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.jdbc.InvalidResultSetAccessException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import com.techelevator.dao.AssignmentDAO;
import com.techelevator.dao.CourseDAO;
import com.techelevator.dao.CurriculumDAO;
import com.techelevator.dao.GradeDAO;
import com.techelevator.dao.MessageDAO;
import com.techelevator.dao.UserDAO;
import com.techelevator.dto.AssignmentDTO;
import com.techelevator.dto.CourseAssignmentDTO;
import com.techelevator.dto.CourseDTO;
import com.techelevator.dto.CurriculumDTO;
import com.techelevator.dto.GPADTO;
import com.techelevator.dto.GradeDTO;
import com.techelevator.dto.UserDTO;
import com.techelevator.dto.CourseDetailsDTO;
import com.techelevator.dto.CourseGradeDTO;
import com.techelevator.errors.CurriculumDateException;
import com.techelevator.errors.IncorrectRoleException;
import com.techelevator.model.Assignment;
import com.techelevator.model.Course;
import com.techelevator.model.Curriculum;
import com.techelevator.model.Grade;
import com.techelevator.model.HomeworkAnswer;
import com.techelevator.model.Message;
import com.techelevator.model.User;

@RestController
@CrossOrigin
@PreAuthorize("isAuthenticated()")
public class LogicController {
	
	// these strings are consistent with vue and sql for now
	private static final String ADMIN = "ROLE_ADMIN";
	private static final String TEACHER = "ROLE_TEACHER";
	private static final String STUDENT = "ROLE_USER";
	
	private static final String HOMEWORK_SUBMIT_MESSAGE = "Student %s has submitted a new homework assignment.";
	
	private AssignmentDAO assignmentDAO;
	private CourseDAO courseDAO;
	private CurriculumDAO curriculumDAO;
	private GradeDAO gradeDAO;
	private MessageDAO messageDAO;
	private UserDAO userDAO;
	
	public LogicController(GradeDAO gradeDAO, UserDAO userDAO, MessageDAO messageDAO, CourseDAO courseDAO, CurriculumDAO curriculumDAO, AssignmentDAO assignmentDAO){
		this.userDAO = userDAO;
		this.courseDAO = courseDAO;
		this.curriculumDAO = curriculumDAO;
		this.messageDAO = messageDAO;
		this.assignmentDAO = assignmentDAO;
		this.gradeDAO = gradeDAO;
	}
	
	@RequestMapping(value = "/courses", method = RequestMethod.GET)
	public Course[] getCourses(Principal p) throws IncorrectRoleException{
		//String role = validateRole(p, "get course list", TEACHER, STUDENT);
		String role = getRole(p);
		if(role.equals(STUDENT))
			return courseDAO.getCoursesByStudent(getID(p));
		return courseDAO.getCoursesByTeacher(getID(p));
	}
	
	@RequestMapping(value = "/courses/all", method = RequestMethod.GET)
	public CourseDTO[] getAllCourses(Principal p){
		Course[] courses = courseDAO.getAllCourses();
		CourseDTO[] dtos = new CourseDTO[courses.length];
		for(int i=0; i<courses.length; i++)
			dtos[i] = new CourseDTO(courses[i]);
		return dtos;
	}

    @ResponseStatus(HttpStatus.CREATED)
	@RequestMapping(value = "/courses", method = RequestMethod.POST)
	public boolean newCourse(@RequestBody CourseDTO courseDTO, Principal p) throws IncorrectRoleException{
		//validateRole(p, "create course", TEACHER, ADMIN);
		return courseDAO.makeCourse(courseDTO);
	}
    
	@RequestMapping(value = "/courses", method = RequestMethod.PUT)
	public boolean moveToCourse(@RequestBody CourseAssignmentDTO assignment, Principal p) throws IncorrectRoleException{
		//validateRole(p, "assign to course", ADMIN);
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
	@RequestMapping(value = "/courses/remove", method = RequestMethod.PUT)
	public boolean removeFromCourse(@RequestBody CourseAssignmentDTO assignment, Principal p) throws IncorrectRoleException{
		String role = userDAO.getRoleById(new Long(assignment.getUser()));
		switch(role){
			case TEACHER:
				return courseDAO.removeTeacher(assignment.getCourse(), assignment.getUser());
			case STUDENT:
				return courseDAO.removeStudent(assignment.getCourse(), assignment.getUser());
			default:
				throw new IncorrectRoleException(role, "leave course");
		}
	}
	
	@RequestMapping(value = "/courses/{id}", method = RequestMethod.GET)
	public CourseDetailsDTO viewCourse(@PathVariable("id") int id, Principal p) throws InvalidResultSetAccessException, CurriculumDateException{
		//validate that user is student/teacher for course or administrator?
		Course course = courseDAO.getCourseById(id);
		curriculumDAO.getCurricula(course);
		return new CourseDetailsDTO(course);
	}

    @ResponseStatus(HttpStatus.CREATED)
	@RequestMapping(value = "/courses/{id}", method = RequestMethod.POST)
	public boolean addCurriculum(@PathVariable("id") int id, @RequestBody CurriculumDTO dto, Principal p){
    	//validate that user is teacher for course?
    	Curriculum curriculum = new Curriculum();
    	curriculum.setLesson(dto.getLesson());
    	return curriculumDAO.addCurriculum(id, curriculum, dto.getDate());
	}
	
	@RequestMapping(value = "/courses/{id}", method = RequestMethod.PUT)
	public boolean editCurriculum(@PathVariable("id") int id, @RequestBody CurriculumDTO dto, Principal p){
		//validate that user is teacher for course?
    	Curriculum curriculum = new Curriculum();
    	curriculum.setLesson(dto.getLesson());
		return curriculumDAO.editCurriculum(id, curriculum, dto.getDate());
	}
	
	@RequestMapping(value = "/courses/{id}", method = RequestMethod.DELETE)
	public boolean deleteCourse(@PathVariable("id") int id, Principal p){
		//validate something??
		curriculumDAO.deleteCurriculum(id);
		userDAO.deleteCourseTeachersStudents(new Long(id));
		return courseDAO.deleteCourse(id);
	}
	
	@RequestMapping(value = "/courses/grade/{id}", method = RequestMethod.GET)
	public CourseGradeDTO[] getGrades(@PathVariable("id") int id, Principal p){
		UserDTO[] students = userDAO.findAllEnrolledStudents(new Long(id));
		CourseGradeDTO[] dtos = new CourseGradeDTO[students.length];
		String course = courseDAO.getCourseById(id).getName();
		for(int i=0; i<students.length; i++){
			dtos[i] = new CourseGradeDTO();
			dtos[i].setStudent(students[i].getName());
			dtos[i].setName(course);
			double avg = 0;
			double total = 0;
			Grade[] grades = gradeDAO.getGradesByStudentAndCourse(students[i].getId(), id);
			for(Grade grade:grades){
				if(grade.getGrade() >= 0){
					avg += grade.getGrade();
					total++;
				}
			}
			if(total == 0)
				total = 1;
			dtos[i].setGrade(avg/total);
		}
		return dtos;
	}
	
	@RequestMapping(value = "/grades", method = RequestMethod.GET)
	public CourseGradeDTO[] getCourseGrades(Principal p){
		int id = getID(p);
		CourseGradeDTO[] dtos = new CourseGradeDTO[0];
		Course[] courses = new Course[0];
		switch(getRole(p)){
		case STUDENT:
			courses = courseDAO.getCoursesByStudent(id);
			dtos = new CourseGradeDTO[courses.length];
			for(int i=0; i<courses.length; i++){
				Grade[] grades = gradeDAO.getGradesByStudentAndCourse(getID(p), courses[i].getId());
				CourseGradeDTO dto = new CourseGradeDTO();
				dto.setName(courses[i].getName());
				dto.setStudent(p.getName());
				int avg = 0;
				int total = 0;
				for(Grade grade:grades){
					if(grade.getGrade() >= 0){
						avg += grade.getGrade();
						total++;
					}
				}
				if(total == 0)
					total = 1;
				dto.setGrade(((double)avg)/((double)total));
				dtos[i] = dto;
			}
			return dtos;
		case TEACHER:
			courses = courseDAO.getCoursesByTeacher(id);
			int studentCount = 0;
			User[][] students = new User[courses.length][];
			int[][] avgs = new int[courses.length][];
			int[][] totals = new int[courses.length][];
			for(int i=0; i<courses.length; i++){
				students[i] = courseDAO.getStudents(courses[i].getId());
				studentCount += students[i].length;
				avgs[i] = new int[students[i].length];
				totals[i] = new int[students[i].length];
			}
			dtos = new CourseGradeDTO[studentCount];
			for(int i=0; i<courses.length; i++){
				for(int j=0; j<students[i].length; j++){
					Grade[] grades = gradeDAO.getGradesByStudentAndCourse(students[i][j].getId().intValue(), courses[i].getId());
					CourseGradeDTO dto = new CourseGradeDTO();
					dto.setStudent(students[i][j].getUsername());
					dto.setName(courses[i].getName());
					avgs[i][j] = 0;
					totals[i][j] = 0;
					for(Grade grade:grades){
						if(grade.getGrade() >= 0){
							avgs[i][j] += grade.getGrade();
							totals[i][j]++;
						}
					}
					if(totals[i][j] == 0)
						totals[i][j] = 1;
					dto.setGrade((double)avgs[i][j]/(double)totals[i][j]);
					dtos[i*courses.length+j] = dto;
				}
			}
			return dtos;
		}
		
		return dtos;
	}
	

	@RequestMapping(value = "/grades/{id}", method = RequestMethod.GET)
	public GradeDTO[] getAssignmentGrade(@PathVariable int id, Principal p){
		GradeDTO[] dtos = new GradeDTO[0];
		Assignment assignment = assignmentDAO.getAssignmentById(id);
		switch(getRole(p)){
		case STUDENT:
			dtos = new GradeDTO[1];
			dtos[0] = new GradeDTO(gradeDAO.getStudentGradeByAssignment(getID(p), id));
			dtos[0].setAssignment(assignment.getName());
			dtos[0].setStudent(p.getName());
			dtos[0].numberToRaw(assignment.getQuestions().size());
			return dtos;
		case TEACHER:
			Grade[] grades = gradeDAO.getAllGradesByAssignment(id);
			dtos = new GradeDTO[grades.length];
			for(int i=0; i<grades.length; i++){
				dtos[i] = new GradeDTO(grades[i]);
				dtos[i].setAssignment(assignment.getName());
				dtos[i].setStudent(userDAO.getUserById(new Long(grades[i].getStudent())).getUsername());
				dtos[i].numberToRaw(assignment.getQuestions().size());
			}
			return dtos;
		}
		return dtos;
	}

	@RequestMapping(value = "/grades/{id}", method = RequestMethod.PUT)
	public boolean getAssignmentGrade(@PathVariable int id, @RequestBody GradeDTO dto, Principal p){
		Grade grade = new Grade();
		grade.setAssignment(id);
		grade.setStudent(userDAO.findIdByUsername(dto.getStudent()));
		grade.setComment(dto.getComment());
		grade.setGrade(dto.getGrade());
		return gradeDAO.updateGrade(grade);
	}
	
	@RequestMapping(value = "/homework", method = RequestMethod.GET)
	public Assignment[] getHomework(Principal p) throws IncorrectRoleException{
		//validateRole(p, "view homework", STUDENT);
		return assignmentDAO.getStudentAssignments(getID(p));
	}

    @ResponseStatus(HttpStatus.CREATED)
	@RequestMapping(value = "/homework", method = RequestMethod.POST)
	public boolean createHomework(@RequestBody AssignmentDTO homework, Principal p) throws IncorrectRoleException{
		//validateRole(p, "create homework", TEACHER);
    	
    	int id = assignmentDAO.newAssignment(homework.getName(), homework.getDescription(), homework.getCreatedDate(), homework.getDueDate(), homework.getCourse(), homework.getQuestions());
    	return curriculumDAO.addHomework(homework.getCourse(), homework.getCreatedDate(), id);
    }
	
	@RequestMapping(value = "/homework/{id}", method = RequestMethod.GET)
	public AssignmentDTO viewHomework(@PathVariable("id") int id, Principal p){
		//validate that the person in question has been assigned this work?
		return assignmentDAO.getDTO(id, getID(p));
	}

	@RequestMapping(value = "/homework/{id}", method = RequestMethod.POST)
	public boolean submitHomework(@PathVariable("id") int id, Principal p) throws IncorrectRoleException{
		//validateRole(p, "submit homework", STUDENT);
		int uid = getID(p);
		if(assignmentDAO.submitAssignment(id, uid)){
			//possible for the message not to be sent! currently prioritizing homework status.
			messageDAO.send(assignmentDAO.getTeacher(id), String.format(HOMEWORK_SUBMIT_MESSAGE, p.getName()));
			return true;
		}else{return false;}
	}
	
	@RequestMapping(value = "/homework/{id}", method = RequestMethod.PUT)
	public boolean submitAnswer(@PathVariable("id") int id, @RequestBody HomeworkAnswer answer, Principal p) throws IncorrectRoleException{
		//validateRole(p, "submit answer", STUDENT);
		int uid = getID(p);
		return assignmentDAO.submitAnswer(id, answer.getQuestion(), uid, answer.getAnswer());
	}
	
	@RequestMapping(value = "/homework/{id}", method = RequestMethod.DELETE)
	public boolean deleteHomework(@PathVariable("id") int id, Principal p) throws IncorrectRoleException{
		//validateRole(p, "delete homework", TEACHER);//administrator??
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
	
	@RequestMapping(value = "/student", method = RequestMethod.GET)
	public GPADTO[] getGPAs(Principal p){
		UserDTO[] students = userDAO.findAllStudents();
		GPADTO[] gpas = new GPADTO[students.length];
		Course[] courses = new Course[0];
		for(int i=0; i<gpas.length; i++){
			gpas[i] = new GPADTO();
			gpas[i].setStudent(students[i].getName());
			int gpa = 0;
			courses = courseDAO.getCoursesByStudent(students[i].getId());
			for(int j=0; j<courses.length; j++){
				Grade[] grades = gradeDAO.getGradesByStudentAndCourse(getID(p), courses[j].getId());
				int avg = 0;
				int total = 0;
				for(Grade grade:grades){
					if(grade.getGrade() >= 0){
						avg += grade.getGrade();
						total++;
					}
				}
				if(total == 0)
					total = 1;
				gpa += (((double)avg)/((double)total));
			}
			gpas[i].setGpa(4 * gpa/courses.length);
		}
		return gpas;
	}
	
	@RequestMapping(value = "/users", method = RequestMethod.GET)
	public UserDTO[] getUsers(Principal p){
		return userDAO.findAll();
	}

	@RequestMapping(value = "/users/{role}", method = RequestMethod.GET)
	public UserDTO[] getUsersByRole(@PathVariable("role") String role, Principal p){
		String fullRole = "ROLE_" + role.toUpperCase();
		switch(fullRole){
		case STUDENT:
			return userDAO.findAllStudents();
		case TEACHER:
			return userDAO.findAllTeachers();
		default:
			return new UserDTO[0];
		}
	}
	@RequestMapping(value = "/users/{role}/{courseid}", method = RequestMethod.GET)
	public UserDTO[] getUnchosenUsersByRole(@PathVariable("role") String role, @PathVariable("courseid") int course, Principal p){
		String fullRole = "ROLE_" + role.toUpperCase();
		switch(fullRole){
		case STUDENT:
			return userDAO.findAllUnchosenStudents(new Long(course));
		case TEACHER:
			return userDAO.findAllUnchosenTeachers(new Long(course));
		default:
			return new UserDTO[0];
		}
	}
	@RequestMapping(value = "/enrollment/{courseid}/{role}", method = RequestMethod.GET)
	public UserDTO[] getEnrolledUsersByRole(@PathVariable("role") String role, @PathVariable("courseid") int course, Principal p){
		String fullRole = "ROLE_" + role.toUpperCase();
		switch(fullRole){
		case STUDENT:
			return userDAO.findAllEnrolledStudents(new Long(course));
		case TEACHER:
			return userDAO.findAllEnrolledTeachers(new Long(course));
		default:
			return new UserDTO[0];
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
