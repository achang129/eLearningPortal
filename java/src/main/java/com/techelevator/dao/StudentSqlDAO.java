package com.techelevator.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.techelevator.model.Student;

public class StudentSqlDAO implements StudentDAO {
	
	JdbcTemplate jdbc;
	
	public StudentSqlDAO(JdbcTemplate jdbc) {
		this.jdbc = jdbc;
	}
	

	@Override
	public List<Student> getStudentsByCourse(int courseID) {// not sure how to build the map function based on how the student/teacher classes are built. need Peter to give input.
		List<Student> results = new ArrayList<Student>();
		String sql = "SELECT * FROM student WHERE course = ?";
		
		SqlRowSet rowSet = jdbc.queryForRowSet(sql, courseID);
		
		while(rowSet.next()) {
			
		}
	}

	@Override
	public boolean createStudent(Student newStudent) {
		// TODO Auto-generated method stub
		return false;
	}

	private Student mapToStudent(SqlRowSet rowSet) {
		Student result = new Student();
		
		result.set
	}
	
}
