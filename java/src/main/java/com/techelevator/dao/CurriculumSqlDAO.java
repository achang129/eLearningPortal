package com.techelevator.dao;

import java.time.LocalDate;

import org.springframework.jdbc.core.JdbcTemplate;

import com.techelevator.model.Curriculum;

public class CurriculumSqlDAO implements CurriculumDAO {
	
	private JdbcTemplate jdbcTemplate;

	public CurriculumSqlDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Integer getCourse(int course) {
		Integer currCourse = 0;
		String sql = "SELECT id FROM course c JOIN curriculum cr ON cr.course = c.id WHERE cr.course = ?";
		
		currCourse = jdbcTemplate.queryForObject(sql, Integer.class, course);
		return currCourse;
	}

	@Override
	public LocalDate getDate(LocalDate date) {
		LocalDate currDate = null;
		String sql = "SELECT date FROM curriculum WHERE date = ?";
		
		currDate = jdbcTemplate.queryForObject(sql, LocalDate.class, date);
		return currDate;
	}

	@Override
	public String getLesson(String lesson) {
		String currLesson = "";
		String sql = "SELECT lesson FROM curriculum WHERE lesson = ?";
		
		currLesson = jdbcTemplate.queryForObject(sql, String.class, lesson);
		return currLesson;
	}

	@Override
	public Integer getHomework(int homework) {
		Integer currHomework = null;
		String sql = "SELECT homework FROM curriculum WHERE homework = ?";
		
		currHomework = jdbcTemplate.queryForObject(sql, Integer.class, homework);
		return currHomework;
	}

	@Override
	public boolean addCurriculum(int course, Curriculum curriculum, LocalDate date) {
		boolean curriculumAdded = false;
		
		String sql = "INSERT into curriculum "
				+ "(course, date, lesson, homework) VALUES (?, ?, ?, ?)";
		
		curriculumAdded = jdbcTemplate.update(sql, course, curriculum, date) == 1;
		
		return curriculumAdded;
	}

	@Override
	public boolean editCurriculum(int course, Curriculum curriculum, LocalDate date) {
		boolean curriculumEdit = false;
		
		String sql = "UPDATE curriculum "
						+ "SET course = ?, "
						+ "lesson = ?, "
						+ "homework = ?, "
						+ "WHERE date = ?";
		
		curriculumEdit = jdbcTemplate.update(sql, course, curriculum, date) ==1;
		return curriculumEdit;
	}

}
