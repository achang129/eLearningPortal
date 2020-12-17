package com.techelevator.dao;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.techelevator.dto.AssignmentDTO;
import com.techelevator.model.Answer;
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
	public int newAssignment(String name, String description, LocalDate date, LocalDate dueDate, int course, Question[] questions) {
		String sql = "INSERT into assignment ( name, description, created_date, due_date, course, questions) VALUES (?, ?, ?, ?, ?,?)";
		if(jdbcTemplate.update(sql, name, description, date, dueDate, course, questions.length) != 1)
			return 0;
		sql = "SELECT id FROM assignment WHERE name = ? AND course = ?";
		SqlRowSet rows = jdbcTemplate.queryForRowSet(sql, name, course);
		if(!rows.next())
			return 0;
		int id = rows.getInt("id");
		for(int i=0; i<questions.length; i++){
			sql = "INSERT INTO question (assignment, number, weight, type, statement) VALUES (?,?,?,?,?)";
			jdbcTemplate.update(sql,id,i,questions[i].getWeight(),questions[i].getType(),questions[i].getStatement());
			for(int j=0; j<questions[i].getAnswers().length; j++){
				sql = "INSERT INTO mcchoice (assignment, question, choice, answer, correct) VALUES (?,?,?,?,?)";
				jdbcTemplate.update(sql,id,i,j,questions[i].getAnswers()[j],questions[i].getCorrect()[j]);
			}
		}
		return id;
	}

	@Override
	public Assignment getAssignmentById(int id) {
		String sql = "SELECT * FROM assignment WHERE id = ?";
		return jdbcTemplate.queryForObject(sql, Assignment.class, id);
	}

	@Override
	public boolean submitAssignment(int id, int student) {
		int correct = 0;
		String sql = "SELECT number, weight, type FROM answers WHERE assignment = ? ORDER BY number DESC";
		SqlRowSet rows = jdbcTemplate.queryForRowSet(sql, id, student);
		if(!rows.next()){return false;}
		String[] types = new String[rows.getInt("number") + 1];
		int[] weights = new int[types.length];
		do{
			types[rows.getInt("number")] = rows.getString("type");
			weights[rows.getInt("number")] = rows.getInt("weight");
		} while(rows.next());
		sql = "SELECT question, answer FROM answers WHERE assignment = ? AND student = ?";
		rows = jdbcTemplate.queryForRowSet(sql, id, student);
		String[] ans = new String[types.length];
		while(rows.next()){
			ans[rows.getInt("question")] = rows.getString("answer");
		}
		for(int i=0; i<ans.length; i++){
			switch(types[i]){
			case "text":
				sql = "SELECT answer FROM mcchoice WHERE assignment = ? AND question = ?";
				rows = jdbcTemplate.queryForRowSet(sql, id, i);
				while(rows.next()){
					if(rows.getString(0).toLowerCase().equals(ans[i].toLowerCase())){
						correct += weights[i];
						break;
					}
				}
				break;
			case "mc":
				sql = "SELECT choice FROM mcchoice WHERE assignment = ? AND question = ? AND correct = true";
				rows = jdbcTemplate.queryForRowSet(sql, id, i);
				if(rows.next()){
					if(Integer.toString(rows.getInt(0)).equals(ans[i]))
						correct += weights[i];
				}
				break;
			case "mmc":
				sql = "SELECT choice FROM mcchoice WHERE assignment = ? AND question = ? AND correct = true ORDER BY choice";
				rows = jdbcTemplate.queryForRowSet(sql, id, i);
				String exp = "";
				if(rows.next())
					exp = Integer.toString(rows.getInt(0));
				while(rows.next()){
					exp += "," + Integer.toString(rows.getInt(0));
				}
				if(exp.equals(ans[i]))
					correct += weights[i];
				break;
			default:
				return false;
			}
		}
		sql = "INSERT INTO grade (student, assignment, turned_in, correct, grade) VALUES (?, ?, now(), ?, -1)";
		return jdbcTemplate.update(sql, student, id, correct) == 1;
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
		a.setName(rs.getString("name"));
		a.setDescription(rs.getString("description"));
		a.setId(rs.getInt("id"));
		a.setDueDate(rs.getDate("due_date").toLocalDate());
		a.setCreatedDate(rs.getDate("created_date").toLocalDate());
		a.setCourse(rs.getInt("course"));
		return a;
	}

}
