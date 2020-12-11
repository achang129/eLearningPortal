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
	public Grade[] getAllGradesByAssignment(int assignment){
		String sql = "SELECT * FROM grade WHERE assignment = ?";
		SqlRowSet rows = jdbc.queryForRowSet(sql, assignment);
		List<Grade> grades = new ArrayList<Grade>();
		while(rows.next())
			grades.add(mapToGrade(rows));
		return grades.toArray(new Grade[0]);
	}
	
	@Override
	public Grade getStudentGradeByAssignment(int student, int assignment){
		String sql = "SELECT * FROM grade WHERE assignment = ? AND student = ?";
		SqlRowSet rows = jdbc.queryForRowSet(sql);
		if(rows.next())
			return mapToGrade(rows);
		return null;
	}

	@Override
	public boolean createGrade(Grade newGrade) {
		String sql = "INSERT INTO grade (student, assignment, turned_in, correct, grade, comment)" +
					 "VALUES (?, ?, ?, ?, ?, ?)";
		return jdbc.update(sql, newGrade.getStudent(), newGrade.getAssignment(), newGrade.getTimeTurnedIn(), 
				newGrade.getNumberCorrect(), newGrade.getGrade(), newGrade.getComment()) == 1;
	}

	@Override
	public boolean updateGrade(Grade grade){
		String sql1 = "UPDATE grade SET grade = ? WHERE student = ? AND assignment = ?";
		String sql2 = "UPDATE grade SET comment = ? WHERE student = ? AND assignment = ?";
		return jdbc.update(sql1, grade.getGrade(), grade.getStudent(), grade.getAssignment()) == 1 &&
			   jdbc.update(sql2, grade.getComment(), grade.getStudent(), grade.getAssignment()) == 1;
	}
	
	private Grade mapToGrade(SqlRowSet rowSet) {
		Grade result = new Grade();
		
		result.setStudent(rowSet.getInt("student"));
		result.setAssignment(rowSet.getInt("assignment"));
		result.setTimeTurnedIn(rowSet.getTimestamp("turned_in"));
		result.setNumberCorrect(rowSet.getInt("correct"));
		result.setGrade(rowSet.getInt("grade"));
		result.setComment(rowSet.getString("comment"));
		
		return result;
	}

}
