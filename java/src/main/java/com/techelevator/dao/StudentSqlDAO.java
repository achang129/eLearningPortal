package com.techelevator.dao;

<<<<<<< HEAD
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

=======
import java.util.List;

>>>>>>> 2dbbf7adcc40506bd228a30c372e5fc7585bfc14
import com.techelevator.model.Student;

public class StudentSqlDAO implements StudentDAO {
	
	JdbcTemplate jdbc;
	
	public StudentSqlDAO(JdbcTemplate jdbc) {
		this.jdbc = jdbc;
	}
	

//	@Override
//	public int getStudentID() {
//		// TODO Auto-generated method stub
//		return 0;
//	}
//
//	@Override
//	public int getCourseID() {
//		// TODO Auto-generated method stub
//		return 0;
//	}

	@Override

	public List<Student> getStudentsByCourse(int courseID) {
		// TODO Auto-generated method stub
		return null;
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
