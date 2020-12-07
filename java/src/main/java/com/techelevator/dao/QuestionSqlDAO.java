package com.techelevator.dao;

import org.springframework.jdbc.core.JdbcTemplate;

public class QuestionSqlDAO implements QuestionDAO {
	
	private JdbcTemplate jdbcTemplate;

	public QuestionSqlDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Integer getAssignment(int assignment) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer getNumber(int number) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getType(String type) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getStatement(String statement) {
		// TODO Auto-generated method stub
		return null;
	}

}
