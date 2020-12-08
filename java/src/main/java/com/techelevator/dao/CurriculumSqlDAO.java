package com.techelevator.dao;

import java.time.LocalDate;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.techelevator.model.Curriculum;

@Component
public class CurriculumSqlDAO implements CurriculumDAO {
	
	private JdbcTemplate jdbcTemplate;

	public CurriculumSqlDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public boolean addCurriculum(int course, Curriculum curriculum, LocalDate date) {
		String sql = "INSERT into curriculum (course, date, lesson) VALUES (?, ?, ?)";
		return jdbcTemplate.update(sql, course, date, curriculum.getLesson()) == 1;
	}

	@Override
	public boolean editCurriculum(int course, Curriculum curriculum, LocalDate date) {
		String sql = "UPDATE curriculum SET lesson = ?, homework = ? WHERE date = ? AND course = ?";
		return jdbcTemplate.update(sql, curriculum.getLesson(), curriculum.getHomework(), date, course) == 1;
	}
}
