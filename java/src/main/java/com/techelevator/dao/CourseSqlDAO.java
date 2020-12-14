package com.techelevator.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.techelevator.dto.CourseDTO;
import com.techelevator.model.Course;
import com.techelevator.model.User;

@Component
public class CourseSqlDAO implements CourseDAO {
	
	private JdbcTemplate jdbcTemplate;

	public CourseSqlDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Course[] getCoursesByStudent(int id) {
		List<Course> tempCoursesByStudent = new ArrayList<Course>();
		String sql = "SELECT * FROM course c INNER JOIN student s ON "
					+ "s.course = c.id WHERE s.student = ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
		while (results.next()) {
			tempCoursesByStudent.add(mapRowToCourse(results));
		}
		
		return tempCoursesByStudent.toArray(new Course[0]);
	}

	@Override
	public Course[] getCoursesByTeacher(int id) {
		List<Course> tempByTeacher = new ArrayList<Course>();
		String sql = "SELECT * FROM course c INNER JOIN teacher t ON "
					+ "t.course = c.id WHERE t.teacher = ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
		while (results.next()) {
			tempByTeacher.add(mapRowToCourse(results));
		}
		return tempByTeacher.toArray(new Course[0]);
	}
	
	@Override
	public Course[] getAllCourses(){
		List<Course> tempCourses = new ArrayList<Course>();
		String sql = "SELECT * FROM course";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
		while(results.next()){
			tempCourses.add(mapRowToCourse(results));
		}
		return tempCourses.toArray(new Course[0]);
	}

	@Override
	public boolean makeCourse(CourseDTO courseDTO) {
		String sql = "INSERT into course (name, description, class_size, cost) VALUES (?, ?, ?,?)";
		return jdbcTemplate.update(sql, courseDTO.getName(), courseDTO.getDescription(), courseDTO.getClassSize(), courseDTO.getCost()) == 1;
	}

	@Override
	public boolean addTeacher(int course, int teacher) {
		String sql = "INSERT into teacher (course, teacher) VALUES (?, ?)";
		return jdbcTemplate.update(sql, course, teacher) == 1;
	}

	@Override
	public boolean addStudent(int course, int student) {
		String sql = "INSERT into student (course, student) VALUES (?, ?)";
		return jdbcTemplate.update(sql, course, student) ==1;
	}

	@Override
	public boolean removeTeacher(int course, int teacher) {
		String sql = "DELETE FROM teacher WHERE course = ? AND teacher = ?";
		return jdbcTemplate.update(sql, course, teacher) ==1;
	}

	@Override
	public boolean removeStudent(int course, int student) {
		String sql = "DELETE FROM student WHERE course = ? AND student = ?";
		return jdbcTemplate.update(sql, course, student) ==1;
	}

	@Override
	public Course getCourseById(int id) {
		String sql = "SELECT * FROM course WHERE id = ?";
		SqlRowSet rows = jdbcTemplate.queryForRowSet(sql, id);
		if(rows.next())
			return mapRowToCourse(rows);
		else
			return null;
	}
	
	@Override
	public boolean deleteCourse(int course) {
		String sql = "DELETE FROM course WHERE id = ?";
		return jdbcTemplate.update(sql, course) == 1;
	}
	
	@Override
	public User[] getStudents(int course){
		String sql = "SELECT s.student, u.username FROM student s INNER JOIN users u ON s.student = u.user_id WHERE s.course = ?";
		SqlRowSet rows = jdbcTemplate.queryForRowSet(sql, course);
		List<User> students = new ArrayList<User>();
		while(rows.next()){
			students.add(new User(rows.getLong(1), rows.getString(2), "", ""));
		}
		return students.toArray(new User[0]);
	}
	
	private Course mapRowToCourse(SqlRowSet rs) {
		Course c = new Course();
		c.setId(rs.getInt("id"));
		c.setName(rs.getString("name"));
		c.setDescription(rs.getString("description"));
		c.setClassSize(rs.getInt("class_size"));
		c.setCost(rs.getInt("cost"));
		
		return c;
	}
}
