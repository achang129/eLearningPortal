package com.techelevator.dao;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.techelevator.dto.AssignmentDTO;
import com.techelevator.model.Assignment;
import com.techelevator.model.Question;


@Component
public class AssignmentSqlDAO implements AssignmentDAO {
	
	private JdbcTemplate jdbcTemplate;

	public AssignmentSqlDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Assignment[] getStudentAssignments(int student) {
		List<Assignment> tempByStudent = new ArrayList<Assignment>();
		String sql = "SELECT * FROM assignment a INNER JOIN course c ON a.course=c.id "
				+ "INNER JOIN student s ON c.id = s.course WHERE s.student = ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql, student);
		while(results.next()) {
			Assignment result = mapRowToAssignment(results);
			tempByStudent.add(result);
		}
		return tempByStudent.toArray(new Assignment[0]);
	}

	@Override
	public boolean newAssignment(int course, LocalDate date, String name) {
		String sql = "INSERT into assignment (course, due_date, created_date, name) VALUES (?, ?, ?, ?)";
		return jdbcTemplate.update(sql, course, date, LocalDate.now(), name) == 1;
	}

	@Override
	public Assignment getAssignmentById(int id) {
		String sql = "SELECT * FROM assignment WHERE id = ?";
		return jdbcTemplate.queryForObject(sql, Assignment.class, id);
	}

	@Override
	public boolean submitAssignment(int id, int student) {
		String sql = "SELECT * FROM answers WHERE assignment = ? AND student = ?";	
		sql = "INSERT INTO grade (student, assignment, turned_in, correct) VALUES (?, ?, now(), ?)";
		return jdbcTemplate.update(sql, student, id) == 1;
	}

	@Override
	public int getTeacher(int id) {
		String sql = "SELECT teacher FROM teacher t INNER JOIN course c "
				+ "ON t.course = c.id INNER JOIN curriculum cr ON cr.course = c.id "
				+ "WHERE cr.homework = ?";
		return jdbcTemplate.queryForObject(sql, Integer.class, id);
	}

	@Override
	public boolean submitAnswer(int id, int question, int student, String answer) {
		String sql = "INSERT INTO answer (student, assignment, question, answer) "
				+ "VALUES (?, ?, ?, ?)";
		return jdbcTemplate.update(sql, student, id, question, answer) == 1;
	}

	@Override
	public boolean deleteAssignment(int id) {
		String sql = "DELETE * FROM assignment WHERE id = ?";
		return jdbcTemplate.update(sql, id) == 1;
	}
	
	@Override
	public AssignmentDTO getDTO(int id, int user){
		AssignmentDTO dto = new AssignmentDTO();
		String sql = "SELECT * FROM assignment WHERE id = ?";
		SqlRowSet rows = jdbcTemplate.queryForRowSet(sql, id);
		dto.setName(rows.getString("name"));
		dto.setDescription(rows.getString("description"));
		dto.setDate(rows.getDate("created_date").toLocalDate());
		dto.setDueDate(rows.getDate("due_date").toLocalDate());
		dto.setCourse(rows.getInt("course"));
		Question[] questions = new Question[rows.getInt("questions")];
		sql = "SELECT number, type, statement FROM question WHERE assignment = ?";
		rows = jdbcTemplate.queryForRowSet(sql, id);
		while(rows.next()){
			Question q = new Question();
			q.setStatement(rows.getString("statement"));
			q.setType(rows.getString("type"));
			questions[rows.getInt("number")] = q;
		}
		sql = "SELECT * FROM mcchoice WHERE assignment = ? ORDER BY choice DESC";
		rows = jdbcTemplate.queryForRowSet(sql, id);
		while(rows.next()){
			int q = rows.getInt("question");
			int a = rows.getInt("choice");
			if(a>questions[q].getAnswers().length){
				questions[q].setAnswers(new String[a+1]);
				questions[q].setCorrect(new boolean[a+1]);}
			questions[q].setAnswer(a,rows.getString("answer"));
			questions[q].setCorrect(a,rows.getBoolean("correct"));
		}
		dto.setQuestions(questions);
		String[] answers = new String[questions.length];
		sql = "SELECT * FROM answer WHERE student = ? AND assignment = ?";
		rows = jdbcTemplate.queryForRowSet(sql, user, id);
		while(rows.next()){
			answers[rows.getInt("question")] = rows.getString("answer");
		}
		dto.setAnswers(answers);
		return dto;
	}
	
	private Assignment mapRowToAssignment(SqlRowSet rs) {
		Assignment a = new Assignment();
		a.setId(rs.getInt("id"));
		a.setDueDate(rs.getDate("due_date").toLocalDate());
		a.setName(rs.getString("name"));
		a.setDescription(rs.getString("description"));
		return a;
	}

}
