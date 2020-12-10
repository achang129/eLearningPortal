package com.techelevator.dao;

import java.time.LocalDate;

import org.springframework.jdbc.InvalidResultSetAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.techelevator.errors.CurriculumDateException;
import com.techelevator.model.Course;
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
	@Override
	public boolean deleteCurriculum(int courseId) {
		//N.B. in the table curriculum, what you may expect to be 
		//the course.id field is called "course"
		//DELETE all curriculum associated with course
		String sql = "DELETE FROM curriculum WHERE course = ?";
		jdbcTemplate.update(sql, courseId);
		
		//check that a search will return zero, return that logical eval as a bool
		String noneRemain = "SELECT * FROM curriculum WHERE course = ?";
		
		//this expression will evaluate TRUE if noneRemain queries for 0 Rows
		//meaning this will evaluate true if the delete was successful.
		return !(jdbcTemplate.queryForRowSet(noneRemain, courseId).first());
	}
	
	@Override
	public void getCurricula(Course course) throws InvalidResultSetAccessException, CurriculumDateException{
		String sql = "SELECT date, lesson FROM curriculum WHERE course = ? ORDER BY date";
		SqlRowSet rows = jdbcTemplate.queryForRowSet(sql, course.getId());
		while(rows.next()){
			Curriculum curriculum = new Curriculum();
			curriculum.setLesson(rows.getString("lesson"));
			course.setCurriculum(rows.getDate("date").toLocalDate(), curriculum);
		}
	}
}
