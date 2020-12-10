package com.techelevator.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.techelevator.model.Grade;

@Component
public class GradeSqlDAO implements GradeDAO {
	
	JdbcTemplate jdbc;
	
	 public GradeSqlDAO(JdbcTemplate jdbc) {
		 this.jdbc = jdbc;
	}
	
	@Override
	public Grade[] getGradesByStudent(int studentID) {
		List<Grade> results = new ArrayList<Grade>();
		String sql = "SELECT * FROM grade WHERE student = ?";
		SqlRowSet rowSet = jdbc.queryForRowSet(sql, studentID);
		while(rowSet.next()) 
			results.add(mapToGrade(rowSet));
		return results.toArray(new Grade[0]);
	}

	@Override
	public Grade[] getGradesByCourse(int courseID) {
		List<Grade> results = new ArrayList<Grade>();
		String sql = "SELECT * FROM grade g JOIN assignment a ON g.assignment = a.id " +
					 "JOIN curriculum c ON a.id = c.homework WHERE c.course = ?";
		SqlRowSet rowSet = jdbc.queryForRowSet(sql, courseID);
		while(rowSet.next())
			results.add(mapToGrade(rowSet));
		return results.toArray(new Grade[0]);
	}

	@Override
	public Grade[] getGradesByStudentAndCourse(int studentID, int courseID) {
		List<Grade> results = new ArrayList<Grade>();
		String sql = "SELECT * FROM grade g JOIN assignment a ON g.assignment = a.id " +
					 "JOIN curriculum c ON a.id = c.homework WHERE c.course = ? AND g.student = ?";
		SqlRowSet rowSet = jdbc.queryForRowSet(sql, courseID, studentID);
		while(rowSet.next())
			results.add(mapToGrade(rowSet));
		return results.toArray(new Grade[0]);
	}


	@Override
	public boolean createGrade(Grade newGrade) {
		String sql = "INSERT INTO grade (student, assignment, turned_in, correct, grade)" +
					 "VALUES (?, ?, ?, ?, ?, ?)";
		
		int worked = jdbc.update(sql, newGrade.getStudentID(), newGrade.getAssignmentID(), newGrade.getTimeTurnedIn(), 
				newGrade.getNumberCorrect(), newGrade.getGrade());
		
		if(worked > 0) {
			return true;
		}else {
			return false;
		}
	}

	private Grade mapToGrade(SqlRowSet rowSet) {
		Grade result = new Grade();
		
		result.setStudentID(rowSet.getInt("student"));
		result.setAssignmentID(rowSet.getInt("assignment"));
		result.setTimeTurnedIn(rowSet.getTimestamp("turned_in"));
		result.setNumberCorrect(rowSet.getInt("correct"));
		result.setGrade(rowSet.getInt("grade"));
		
		return result;
	}

}
