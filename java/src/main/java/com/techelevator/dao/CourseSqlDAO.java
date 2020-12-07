package com.techelevator.dao;

import org.springframework.jdbc.core.JdbcTemplate;

public class CourseSqlDAO implements CourseDAO {
	
	private JdbcTemplate jdbcTemplate;

	public CourseSqlDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Integer getId(int id) {
		int courseId = 0;
		
		String sql = "SELECT id FROM course WHERE id = ?";
		courseId = jdbcTemplate.queryForObject(sql, Integer.class, id);
		return courseId;
	}

	@Override
	public String getName(String name) {
		String courseName = "";
		String sql = "SELECT name FROM course WHERE name = ?";
		
		courseName = jdbcTemplate.queryForObject(sql, String.class, name);
		return courseName;
	}

	@Override
	public String getDescription(String description) {
		String courseDesc = "";
		String sql = "SELECT description FROM course WHERE description = ?";
		
		courseDesc = jdbcTemplate.queryForObject(sql, String.class, description);
		return courseDesc;
	}

	@Override
	public String getDifficulty(String difficulty) {
		String courseDiff = "";
		String sql = "SELECT difficulty FROM course WHERE difficulty = ?";
		
		courseDiff = jdbcTemplate.queryForObject(sql, String.class, difficulty);
		return courseDiff;
	}

	@Override
	public Integer getCost(int cost) {
		Integer courseCost = 0;
		String sql = "SELECT cost FROM course WHERE cost = ?";
		
		courseCost = jdbcTemplate.queryForObject(sql, Integer.class, cost);
		return courseCost;
	}

}
