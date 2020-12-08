package com.techelevator.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.techelevator.model.Answer;

public class AnswerSqlDAO implements AnswerDAO {
	
	JdbcTemplate jdbc;
	
	public AnswerSqlDAO(JdbcTemplate jdbc) {
		this.jdbc = jdbc;
	}

	@Override
	public List<Answer> getAnswersByStudentForHomework(int studentID, int assignmentID) {
		List<Answer> results = new ArrayList<Answer>();
		String sql = "SELECT * FROM answer WHERE student = ? AND assignment = ?";
		
		SqlRowSet rowSet = jdbc.queryForRowSet(sql, studentID, assignmentID);
		
		while(rowSet.next()) {
			results.add(mapToAnswer(rowSet));
		}
		
		return results;
	}

	@Override
	public boolean createAnswer(Answer answer) {
		String sql = "INSERT INTO answer (student, assignment, question, answer) " +
					 "VALUES (?, ?, ?, ?)";
		
		int worked = jdbc.update(sql, answer.getStudentID(), answer.getAssignmentID(), 
				answer.getQuestionID(), answer.getAnswer());
		
		if(worked > 0) {
			return true;
		}else {
			return false;
		}
	}

	private Answer mapToAnswer(SqlRowSet rowSet) {
		Answer result = new Answer();
		
		result.setStudentID(rowSet.getInt("student"));
		result.setAssignmentID(rowSet.getInt("assignment"));
		result.setQuestionID(rowSet.getInt("question"));
		result.setAnswer(rowSet.getString("answer"));
		
		return result;
	}

}
