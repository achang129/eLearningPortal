package com.techelevator.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.techelevator.model.Course;

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
	public boolean makeCourse(Course course) {
		String sql = "INSERT into course (name, description, difficulty) VALUES (?, ?, ?)";
		return jdbcTemplate.update(sql, course.getName(), course.getDescription(), course.getDifficulty()) == 1;
	}

	@Override
	public boolean addTeacher(int course, int teacher) {
		String sql = "INSERT into teacher (teacher, course) VALUES (?, ?)";
		return jdbcTemplate.update(sql, course, teacher) == 1;
	}

	@Override
	public boolean addStudent(int course, int student) {
		String sql = "INSERT into student (student, course) VALUES (?, ?)";
		return jdbcTemplate.update(sql, course, student) ==1;
	}

	@Override
	public Course getCourseById(int id) {
		String sql = "SELECT * FROM course WHERE id = ?";
		return jdbcTemplate.queryForObject(sql, Course.class, id);
	}
	
	@Override
	public boolean deleteCourse(int course) {
		String sql = "DELETE * FROM course WHERE id = ?";
		return jdbcTemplate.update(sql, course) == 1;
	}
	
	private Course mapRowToCourse(SqlRowSet rs) {
		Course c = new Course();
		c.setID(rs.getLong("id"));
		c.setName(rs.getString("name"));
		c.setDescription(rs.getString("description"));
		c.setDifficulty(rs.getString("difficulty"));
		c.setName(rs.getInt("cost"));
		
		return c;
	}
}
