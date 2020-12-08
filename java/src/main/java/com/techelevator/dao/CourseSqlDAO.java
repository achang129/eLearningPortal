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
		String sql = "SELECT * FROM course c JOIN student s ON "
					+ "s.course = c.id WHERE s.student = ?";
		
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
		while (results.next()) {
			Course result = mapRowToCourse(results);
			tempCoursesByStudent.add(result);
		}
		Course[] coursesByStudent = new Course[tempCoursesByStudent.size()];
		tempCoursesByStudent.toArray(coursesByStudent);
		return coursesByStudent;
		
	}

	@Override
	public Course[] getCoursesByTeacher(int id) {
		List<Course> tempByTeacher = new ArrayList<Course>();
		String sql = "SELECT * FROM course c JOIN teacher t ON "
					+ "t.course = c.id WHERE t.teacher = ?";
		
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
		while (results.next()) {
			Course result = mapRowToCourse(results);
			tempByTeacher.add(result);
		}
		Course[] coursesByTeacher = new Course[tempByTeacher.size()];
		tempByTeacher.toArray(coursesByTeacher);
		return coursesByTeacher;
	}

	@Override
	public boolean makeCourse(Course course) {
		boolean courseCreated = false;
		
		String sql = "INSERT into course (name, description, difficulty, cost)"
					+ "VALUES (?, ?, ?, ?)";
		courseCreated = jdbcTemplate.update(sql,
										course.getName(), course.getDescription(),
										course.getDifficulty(), course.getCost()) == 1;
		
		return courseCreated;
	}

	@Override
	public boolean addTeacher(int course, int teacher) {
		boolean teacherAdded = false;
		String sql = "INSERT into teacher (teacher, course)"
					+ "VALUES (?, ?)";
		teacherAdded = jdbcTemplate.update(sql, course, teacher) == 1;
		
		return teacherAdded;
	}

	@Override
	public boolean addStudent(int course, int student) {
		boolean studentAdded = false;
		String sql = "INSERT into student (student, course)"
				+ "VALUES (?, ?)";
		studentAdded = jdbcTemplate.update(sql, course, student) ==1;
		
		return studentAdded;
	}

	@Override
	public Course getCourseById(int id) {
		Course courseId = null;
		
		String sql = "SELECT * FROM course WHERE id = ?";
		courseId = jdbcTemplate.queryForObject(sql, Course.class, id);
		return courseId;
	}
	
	@Override
	public boolean deleteCourse(int course) {
		boolean courseDeleted = false;
		
		String sql = "DELETE * FROM course WHERE id = ?";
		courseDeleted = jdbcTemplate.update(sql, course) == 1;
		
		return courseDeleted;
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
