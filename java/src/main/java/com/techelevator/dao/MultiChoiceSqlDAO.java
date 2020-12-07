package com.techelevator.dao;

import org.springframework.jdbc.core.JdbcTemplate;

public class MultiChoiceSqlDAO implements MultiChoiceDAO {
	
	private JdbcTemplate jdbcTemplate;

	public MultiChoiceSqlDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Integer getAssignment(int assignment) {
		Integer multiAssignment = 0;
		String sql = "SELECT assignment FROM mcchoice WHERE assignment = ?";
		
		multiAssignment = jdbcTemplate.queryForObject(sql, Integer.class, assignment);
		return multiAssignment;
	}

	@Override
	public Integer getQuestion(int question) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer getChoice(int choice) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getAnswer(String answer) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean isCorrect(boolean correct) {
		// TODO Auto-generated method stub
		return false;
	}

}
