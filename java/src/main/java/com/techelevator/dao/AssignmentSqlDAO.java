package com.techelevator.dao;

import java.time.LocalDate;

import org.springframework.jdbc.core.JdbcTemplate;

public class AssignmentSqlDAO implements AssignmentDAO {
	
	private JdbcTemplate jdbcTemplate;

	public AssignmentSqlDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Integer getAssignmentId(int assignment) {
		Integer assignmentId = 0;
		String sql = "SELECT id FROM assignment WHERE id = ?";
		
		assignmentId = jdbcTemplate.queryForObject(sql, Integer.class, assignment);
		return assignmentId;
	}

	@Override
	public LocalDate getDueDate(LocalDate dueDate) {
		LocalDate assignmentDueDate = null;
		String sql = "SELECT due_date FROM assignment WHERE due_date = ?";
		
		assignmentDueDate = jdbcTemplate.queryForObject(sql, LocalDate.class, dueDate);
		return assignmentDueDate;
	}

	@Override
	public Integer getQuestions(int questions) {
		Integer assignmentQuestions = 0;
		String sql = "SELECT questions FROM assignment WHERE questions = ?";
		
		assignmentQuestions = jdbcTemplate.queryForObject(sql, Integer.class, questions);
		return assignmentQuestions;
	}

}
