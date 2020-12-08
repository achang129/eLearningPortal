package com.techelevator.dao;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.techelevator.model.Assignment;



public class AssignmentSqlDAO implements AssignmentDAO {
	
	private JdbcTemplate jdbcTemplate;

	public AssignmentSqlDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
	}



	@Override
	public Assignment[] getStudentAssignments(int student) {
		List<Assignment> tempByStudent = new ArrayList<Assignment>();
		String sql = "SELECT * FROM assignment a JOIN curriculum c ON a.id = c.homework "
				+ "JOIN student s ON c.id = s.course WHERE s.student =?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql, student);
		while(results.next()) {
			Assignment result = mapRowToAssignment(results);
			tempByStudent.add(result);
		}
		Assignment[] assignmentsByStudent = new Assignment[tempByStudent.size()];
		
		return assignmentsByStudent;
	}

	@Override
	public boolean newAssignment(int course, LocalDate date, Assignment homework) {
		boolean assignmentCreated = false;
		
		String sql = "INSERT into assignment "
				+ "(due_date, questions) VALUES (?, ?)";
		assignmentCreated = jdbcTemplate.update(sql, course, date, homework) ==1;
		
		return assignmentCreated;
	}

	@Override
	public Assignment getAssignmentById(int id) {
		Assignment assignmentId = null;
		String sql = "SELECT * FROM assignment WHERE id = ?";
		
		assignmentId = jdbcTemplate.queryForObject(sql, Assignment.class, id);
		return assignmentId;
	}

	@Override
	public boolean submitAssignment(int id, int student) {
		boolean assignmentSubmitted = false;
//		String sql = ""
		return false;
	}

	@Override
	public int getTeacher(int id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean submitAnswer(int id, int question, int student, String answer) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteAssignment(int id) {
		boolean assignmentDeleted = false;
		
		String sql = "DELETE * FROM assignment WHERE id = ?";
		assignmentDeleted = jdbcTemplate.update(sql, id) == 1;
		
		return assignmentDeleted;
	}
	
	private Assignment mapRowToAssignment(SqlRowSet rs) {
		Assignment a = new Assignment();
		a.setID(rs.getLong("id"));
		a.setDueDate(rs.getDate("due_date").toLocalDate());
		
		return a;
	}

}
